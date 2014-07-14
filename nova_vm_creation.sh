#!/bin/bash

# nova
export NOVA_USERNAME=admin   #���O�C������ID
export NOVA_PROJECT_ID=scale  #�e�i���g��
export NOVA_PASSWORD=nova   #���O�C�����̃p�X���[�h
export NOVA_HOST=controller01   #OpenStack�R���g���[���[�̖��O/IP

# required params

network_name="1_scale"  #�ڑ�����l�b�g���[�N��
flavor_name="m1.tiny"   #���p����t���[�o�[��
image_name="Ubuntu12.04LTS"  #���p����C���[�W��
creation_num=50   #�쐬���鐔
vm_name_prefix="Test_VM_"  #�쐬���鉼�z�}�V���̖��O�̃v���t�B�b�N�X�l(���̒l�̌��ɐ��������܂�)

#--------------------------------------------------------
#------------------�ȉ��A�ύX�s�v------------------------
#--------------------------------------------------------
# nova
export NOVA_API_KEY=$NOVA_PASSWORD
export NOVA_URL=http://$NOVA_HOST:5000/v2.0/
export NOVA_VERSION=1.1
export NOVA_REGION_NAME=RegionOne

# glance
export OS_AUTH_USER=${NOVA_USERNAME}
export OS_AUTH_KEY=${NOVA_PASSWORD}
export OS_AUTH_TENANT=${NOVA_PROJECT_ID}
export OS_AUTH_URL=${NOVA_URL}
export OS_AUTH_STRATEGY=keystone

flv=`nova flavor-list | grep $flavor_name | cut -b 3-38`
img=`nova image-list | grep $image_name | cut -b 3-38`
nwk=`nova network-list | grep $network_name | cut -b 3-38`
i=0

while [ $i -ne $creation_num ]
do
    i=`expr $i + 1`
    nova boot --flavor $flv --image $img --nic net-id=$nwk $vm_name_prefix$i
    sleep 1
done