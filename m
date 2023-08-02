Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE9E76C380
	for <lists+linux-pm@lfdr.de>; Wed,  2 Aug 2023 05:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjHBD04 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Aug 2023 23:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjHBD04 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Aug 2023 23:26:56 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2077.outbound.protection.outlook.com [40.107.100.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EFB1705
        for <linux-pm@vger.kernel.org>; Tue,  1 Aug 2023 20:26:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPEovyYu7eRAn8wkORB/PKAtwseS7mXtl7DfAMFVHIfIFS5jBlZLW/4aiDorvj643ZtTFSyskkGSUAKTwqXJICTtk7w5omnF/ZnXAVO1jTjbGeplooIn3zeKzjl1j1oI9Cz+e7rHkVADFaoMOBWa/BrC+0nfTmI+ZBwOslmrVUAKTKu/sClu+RX3FKghuKVjdXuKnMb1Ov+xzEBEWFO7CHXEEtrPr6JR9UA0e75S2SQ1ABGzFvoq9YvEbCjRd8hVRmOx9OmUnP5pN8kJCL3Mlxw/U3bBiCaD7QMzJKEm+gjVJrr+tVawnTR8pRt0eFIBRVJ8FoXcd8lrf0c6/M4i6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8yPKGeEFL4D3sifwWlKiEbQqe0260aqoVdgDt7/hcQ=;
 b=eOiNaG8N+mURVLRuI9BYFouEaTBnS1mD0M5yOE5JssFUhKFYLiW8QBDy8alllMLWufJVG6P/biCB7TiEwFK6QqXqD/YAH/ZPrFw8EHXgcZsVaPApke0nlXduE22Aez3Bn61G5xe2Qg3aIi/UdGszHtGTp6K4l8flaZvwyimnod5qFgnFjdCHX2K2CO+Yikxp/P6/BLkjL0IVkPdsPJYE55h3+mio3oKuXVUfu2ZjmyR5+PZMIxF2gkJa+UPXBirSiKFEReUNbShrEYNkV7zSo1FKx2lefBIqK6ohmniKZZIhGXPxmkft/b8KqkTSIDRmr8cx+sKhje6U70m84mCM5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8yPKGeEFL4D3sifwWlKiEbQqe0260aqoVdgDt7/hcQ=;
 b=ILaEeDcBqFs9adMWeeVaUykxs1vVxEF9+fG3BLZ1WU3sNVe5p7ijtEC0dk5LLgEWIs0w+yyIpmLWxmtHhmtf9qQzbn/A5DN/7nStzDFNtWDBV92NQnHCNPUl+4TjHuPqYSFpMQMIri64udSLqZDVh7pZ2ELfq9DIBICA7m4iJWCpJFSkIZqVbafVcOyh+IL2L5ObUU060JMMNqrU3IOz/MMfRpgujxdFTeIgA5bJawOYglmogK8MOzkqY4RNLoqK8VOOUopzplF5HaRhnyACKP4VkpO3jEUglECHlfl9/SYL1v6YJPTquojkA9XgTrIQA/uvK3Po26UyQCvXxhzm4Q==
Received: from DS7P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::7) by
 PH7PR12MB5617.namprd12.prod.outlook.com (2603:10b6:510:133::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.44; Wed, 2 Aug 2023 03:26:50 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:8:2e:cafe::79) by DS7P222CA0001.outlook.office365.com
 (2603:10b6:8:2e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Wed, 2 Aug 2023 03:26:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 03:26:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 1 Aug 2023
 20:26:38 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 1 Aug 2023
 20:26:37 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-nvme@lists.infradead.org>, <linux-pm@vger.kernel.org>
CC:     <rafael@kernel.org>, <len.brown@intel.com>, <pavel@ucw.cz>,
        <gregkh@linuxfoundation.org>, <kbusch@kernel.org>, <hch@lst.de>,
        <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 0/3] nvme-core: restructure nvme_init_ctrl()
Date:   Tue, 1 Aug 2023 20:26:26 -0700
Message-ID: <20230802032629.24309-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset="a"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|PH7PR12MB5617:EE_
X-MS-Office365-Filtering-Correlation-Id: 29e900c7-1482-4c61-4546-08db93084f18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eyOIZqh11fu1KJ+XnBaMeAL+WrUcs4mRgGYRJ1pqyUfXId1NtHYsoRdVsC1xM+HlLKM1TXj8yBhSG4wvba2xbq5T+Fx6LyVfbW8leKlQyKAruvlQBBiQryzEvjNSi5VD6eCwrlTcVHbDyUqNo/N8E5w4em/oprQ5pcFXUQoaUMbYx76i8ItEy+AK5IZyMCfasq8t6vnCxfJWHSPLUQtUrDKe0Ha2dNFjNRrvZzrNaPDNhHazxIRSDBjPiL16rabvjN42uKIgb0ON5j9Z2DqnFTvSs3dRJ9IiflrDjKDetuzcm1z++4JcLjZnPxchuG6eG5xcuusy8CRvMlAsQa1he0Zn57Z9N10fc/WTWSI1Gsvb51ru2VL7HpsQ5sAvogJjx265X5hSsEa/Z0iRrRinbzLLqlyU2FdzWvDGEIh2Uhk2jPO8i+oQehskpeI6U5CQ5rihUFJbpuLrk/8E5EOr8tJDMENsIP5HiWKq+UxVIrytNDDdlSGKAFoSqvzQpPqneiVRBpBlzLnM9ZhxpJVSBtQn+N3R60iN5lPHJNELSi14WCDaE9EY82fErBiIF1y7u180T5J5rviAdD5xD5xOxq4rbyejjlxNmfEDGyIirY2hFOZ3obmJ4qahADssz9J3O8DyDeO72nbYvvDWLHFJY9FHtMNYrVVsmb+WpTBpBQnxlfhhw5eTRuXool2GCH1+3q1c1HzWhIPfpxvsgxLZNLOpRWAF4S3eFcR+W7xGy+NdB4PHG3vmdgpJ1Tbw76a5kfj7zsHRtqtJMpJ+jlospsc6hxMru5ircGDmudHCdSA=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(107886003)(40480700001)(4326008)(2616005)(83380400001)(2906002)(426003)(30864003)(47076005)(186003)(336012)(316002)(16526019)(478600001)(41300700001)(36860700001)(110136005)(356005)(7636003)(54906003)(40460700003)(82740400003)(5660300002)(70206006)(1076003)(26005)(6666004)(8676002)(70586007)(8936002)(7696005)(36756003)(93036002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 03:26:49.7663
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e900c7-1482-4c61-4546-08db93084f18
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5617
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Restructure nvme_init_ctrl() for better initialization flow.

Currenlty nvme_init_ctrl() initialized nvme authentication, fault
injection, and device PM QoS after adding the controller device with
a call to cdev_device_add(). This has led to additional code complexity,
as it required handling the unwinding of these initializations if any
of them failed.

This series addresses the issue by restructuring nvme_init_ctrl() to
perform the required initializations before adding the controller
device. With this potential failures are caught earlier in the
initialization process, preventing the controller from becoming
visible in userspace until it is fully initialized.

Also it avoids exposing a half-initialized device to userspace, which 
could lead to various problems, including userspace inconsistencies 
where applications may assume the device is fully initialized while
still being prone to failure.

I've done basic testing with blktests and module load/unload they seem
to pass.

Instead of sending one patch I've purposely made 3 separate patches
since they all are not related, however I've merged fault injection
and mpath.

-ck

Chaitanya Kulkarni (3):
  nvme-core: init auth ctrl early
  nvme-core: init fault injection & mpath ctrl early
  nvme-core: init power qoe ops early

 drivers/nvme/host/core.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

nvme (nvme-6.6) # 
nvme (nvme-6.6) # gitlog -3
218a1f775461 (HEAD -> nvme-6.6) nvme-core: init power qoe ops early
d7240009e752 nvme-core: init fault injection & mpath ctrl early
063f3e74a3a2 nvme-core: init auth ctrl early
nvme (nvme-6.6) # ./compile_nvme.sh 
+ umount /mnt/nvme0n1
+ clear_dmesg
./compile_nvme.sh: line 3: clear_dmesg: command not found
umount: /mnt/nvme0n1: no mount point specified.
+ ./delete.sh
+ NQN=testnqn
+ nvme disconnect -n testnqn
NQN:testnqn disconnected 0 controller(s)

real	0m0.012s
user	0m0.000s
sys	0m0.005s
+ rm -fr '/sys/kernel/config/nvmet/ports/1/subsystems/*'
+ rmdir /sys/kernel/config/nvmet/ports/1
rmdir: failed to remove '/sys/kernel/config/nvmet/ports/1': No such file or directory
+ for subsys in /sys/kernel/config/nvmet/subsystems/*
+ for ns in ${subsys}/namespaces/*
+ echo 0
./delete.sh: line 14: /sys/kernel/config/nvmet/subsystems/*/namespaces/*/enable: No such file or directory
+ rmdir '/sys/kernel/config/nvmet/subsystems/*/namespaces/*'
rmdir: failed to remove '/sys/kernel/config/nvmet/subsystems/*/namespaces/*': No such file or directory
+ rmdir '/sys/kernel/config/nvmet/subsystems/*'
rmdir: failed to remove '/sys/kernel/config/nvmet/subsystems/*': No such file or directory
+ rmdir 'config/nullb/nullb*'
rmdir: failed to remove 'config/nullb/nullb*': No such file or directory
+ umount /mnt/nvme0n1
umount: /mnt/nvme0n1: no mount point specified.
+ umount /mnt/backend
umount: /mnt/backend: not mounted.
+ modprobe -r nvme_loop
+ modprobe -r nvme_fabrics
+ modprobe -r nvmet
+ modprobe -r nvme
+ modprobe -r null_blk
+ tree /sys/kernel/config
/sys/kernel/config
└── pci_ep
    ├── controllers
    └── functions

3 directories, 0 files
+ sleep 1
+ modprobe -r nvme-core
+ lsmod
+ grep nvme
+ sleep 1
+ git diff
diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index 8e93167f1783..169ec6d02ffb 100644
--- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -39,6 +39,9 @@
 
 #include "power.h"
 
+#undef pr_fmt
+#define pr_fmt(fmt)    "power/qos: " fmt
+
 static DEFINE_MUTEX(dev_pm_qos_mtx);
 static DEFINE_MUTEX(dev_pm_qos_sysfs_mtx);
 
@@ -906,11 +909,12 @@ int dev_pm_qos_update_user_latency_tolerance(struct device *dev, s32 val)
        int ret;
 
        mutex_lock(&dev_pm_qos_mtx);
-
+       pr_info("%s %d\n", __func__, __LINE__);
        if (IS_ERR_OR_NULL(dev->power.qos)
            || !dev->power.qos->latency_tolerance_req) {
                struct dev_pm_qos_request *req;
 
+               pr_info("%s %d\n", __func__, __LINE__);
                if (val < 0) {
                        if (val == PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT)
                                ret = 0;
@@ -918,19 +922,24 @@ int dev_pm_qos_update_user_latency_tolerance(struct device *dev, s32 val)
                                ret = -EINVAL;
                        goto out;
                }
+               pr_info("%s %d\n", __func__, __LINE__);
                req = kzalloc(sizeof(*req), GFP_KERNEL);
                if (!req) {
                        ret = -ENOMEM;
                        goto out;
                }
+               pr_info("%s %d\n", __func__, __LINE__);
                ret = __dev_pm_qos_add_request(dev, req, DEV_PM_QOS_LATENCY_TOLERANCE, val);
                if (ret < 0) {
                        kfree(req);
                        goto out;
                }
                dev->power.qos->latency_tolerance_req = req;
+               pr_info("%s %d\n", __func__, __LINE__);
        } else {
+               pr_info("%s %d\n", __func__, __LINE__);
                if (val < 0) {
+                       pr_info("%s %d\n", __func__, __LINE__);
                        __dev_pm_qos_drop_user_request(dev, DEV_PM_QOS_LATENCY_TOLERANCE);
                        ret = 0;
                } else {
++ nproc
+ make -j 48 M=drivers/nvme/ modules
  CC [M]  drivers/nvme/host/core.o
  LD [M]  drivers/nvme/host/nvme-core.o
  MODPOST drivers/nvme/Module.symvers
  CC [M]  drivers/nvme/host/nvme-core.mod.o
  CC [M]  drivers/nvme/host/nvme.mod.o
  CC [M]  drivers/nvme/host/nvme-fabrics.mod.o
  CC [M]  drivers/nvme/host/nvme-rdma.mod.o
  CC [M]  drivers/nvme/host/nvme-fc.mod.o
  CC [M]  drivers/nvme/host/nvme-tcp.mod.o
  CC [M]  drivers/nvme/target/nvmet.mod.o
  CC [M]  drivers/nvme/target/nvme-loop.mod.o
  CC [M]  drivers/nvme/target/nvmet-fc.mod.o
  CC [M]  drivers/nvme/target/nvmet-rdma.mod.o
  CC [M]  drivers/nvme/target/nvme-fcloop.mod.o
  CC [M]  drivers/nvme/common/nvme-common.mod.o
  CC [M]  drivers/nvme/target/nvmet-tcp.mod.o
  LD [M]  drivers/nvme/host/nvme-tcp.ko
  LD [M]  drivers/nvme/target/nvmet.ko
  LD [M]  drivers/nvme/host/nvme-fabrics.ko
  LD [M]  drivers/nvme/target/nvmet-fc.ko
  LD [M]  drivers/nvme/host/nvme.ko
  LD [M]  drivers/nvme/host/nvme-rdma.ko
  LD [M]  drivers/nvme/host/nvme-fc.ko
  LD [M]  drivers/nvme/target/nvme-fcloop.ko
  LD [M]  drivers/nvme/target/nvmet-rdma.ko
  LD [M]  drivers/nvme/target/nvme-loop.ko
  LD [M]  drivers/nvme/host/nvme-core.ko
  LD [M]  drivers/nvme/target/nvmet-tcp.ko
  LD [M]  drivers/nvme/common/nvme-common.ko
+ HOST=drivers/nvme/host
+ TARGET=drivers/nvme/target
++ uname -r
+ HOST_DEST=/lib/modules/6.5.0-rc2nvme+/kernel/drivers/nvme/host/
++ uname -r
+ TARGET_DEST=/lib/modules/6.5.0-rc2nvme+/kernel/drivers/nvme/target/
+ cp drivers/nvme/host/nvme-core.ko drivers/nvme/host/nvme-fabrics.ko drivers/nvme/host/nvme-fc.ko drivers/nvme/host/nvme.ko drivers/nvme/host/nvme-rdma.ko drivers/nvme/host/nvme-tcp.ko /lib/modules/6.5.0-rc2nvme+/kernel/drivers/nvme/host//
+ cp drivers/nvme/target/nvme-fcloop.ko drivers/nvme/target/nvme-loop.ko drivers/nvme/target/nvmet-fc.ko drivers/nvme/target/nvmet.ko drivers/nvme/target/nvmet-rdma.ko drivers/nvme/target/nvmet-tcp.ko /lib/modules/6.5.0-rc2nvme+/kernel/drivers/nvme/target//
+ ls -lrth /lib/modules/6.5.0-rc2nvme+/kernel/drivers/nvme/host/ /lib/modules/6.5.0-rc2nvme+/kernel/drivers/nvme/target//
/lib/modules/6.5.0-rc2nvme+/kernel/drivers/nvme/host/:
total 8.1M
-rw-r--r--. 1 root root  4.1M Aug  1 18:34 nvme-core.ko
-rw-r--r--. 1 root root  495K Aug  1 18:34 nvme-fabrics.ko
-rw-r--r--. 1 root root 1005K Aug  1 18:34 nvme-fc.ko
-rw-r--r--. 1 root root  788K Aug  1 18:34 nvme.ko
-rw-r--r--. 1 root root  931K Aug  1 18:34 nvme-rdma.ko
-rw-r--r--. 1 root root  914K Aug  1 18:34 nvme-tcp.ko

/lib/modules/6.5.0-rc2nvme+/kernel/drivers/nvme/target//:
total 7.5M
-rw-r--r--. 1 root root 541K Aug  1 18:34 nvme-fcloop.ko
-rw-r--r--. 1 root root 476K Aug  1 18:34 nvme-loop.ko
-rw-r--r--. 1 root root 827K Aug  1 18:34 nvmet-fc.ko
-rw-r--r--. 1 root root 4.0M Aug  1 18:34 nvmet.ko
-rw-r--r--. 1 root root 903K Aug  1 18:34 nvmet-rdma.ko
-rw-r--r--. 1 root root 769K Aug  1 18:34 nvmet-tcp.ko
+ sync
+ sync
+ sync
+ modprobe nvme
+ echo 'Press enter to continue ...'
Press enter to continue ...
nvme (nvme-6.6) # modprobe nvme 
nvme (nvme-6.6) # dmesg  -c 
[  147.346136] nvme 0000:00:04.0: vgaarb: pci_notify
[  147.403997] power/qos: dev_pm_qos_update_user_latency_tolerance 912
[  147.404001] power/qos: dev_pm_qos_update_user_latency_tolerance 940
[  147.404002] power/qos: dev_pm_qos_update_user_latency_tolerance 942
[  147.404211] pci 0000:00:04.0: vgaarb: pci_notify
[  154.598489] nvme_core: loading out-of-tree module taints kernel.
[  154.607823] nvme 0000:00:04.0: vgaarb: pci_notify
[  154.607857] nvme 0000:00:04.0: runtime IRQ mapping not provided by arch
[  154.607938] power/qos: dev_pm_qos_update_user_latency_tolerance 912
[  154.607974] power/qos: dev_pm_qos_update_user_latency_tolerance 917
[  154.607976] power/qos: dev_pm_qos_update_user_latency_tolerance 925
[  154.607978] power/qos: dev_pm_qos_update_user_latency_tolerance 931
[  154.607981] power/qos: dev_pm_qos_update_user_latency_tolerance 938
[  154.608624] nvme nvme0: pci function 0000:00:04.0
[  154.624312] nvme 0000:00:04.0: enabling bus mastering
[  154.624900] nvme 0000:00:04.0: saving config space at offset 0x0 (reading 0x101b36)
[  154.624907] nvme 0000:00:04.0: saving config space at offset 0x4 (reading 0x100507)
[  154.624912] nvme 0000:00:04.0: saving config space at offset 0x8 (reading 0x1080202)
[  154.624916] nvme 0000:00:04.0: saving config space at offset 0xc (reading 0x0)
[  154.624921] nvme 0000:00:04.0: saving config space at offset 0x10 (reading 0xfebd0004)
[  154.624926] nvme 0000:00:04.0: saving config space at offset 0x14 (reading 0x0)
[  154.624930] nvme 0000:00:04.0: saving config space at offset 0x18 (reading 0x0)
[  154.624935] nvme 0000:00:04.0: saving config space at offset 0x1c (reading 0x0)
[  154.624939] nvme 0000:00:04.0: saving config space at offset 0x20 (reading 0x0)
[  154.624944] nvme 0000:00:04.0: saving config space at offset 0x24 (reading 0x0)
[  154.624948] nvme 0000:00:04.0: saving config space at offset 0x28 (reading 0x0)
[  154.624952] nvme 0000:00:04.0: saving config space at offset 0x2c (reading 0x11001af4)
[  154.624957] nvme 0000:00:04.0: saving config space at offset 0x30 (reading 0x0)
[  154.624961] nvme 0000:00:04.0: saving config space at offset 0x34 (reading 0x40)
[  154.624966] nvme 0000:00:04.0: saving config space at offset 0x38 (reading 0x0)
[  154.624970] nvme 0000:00:04.0: saving config space at offset 0x3c (reading 0x10b)
[  154.636004] nvme nvme0: 48/0/0 default/read/poll queues
[  154.639365] nvme nvme0: Ignoring bogus Namespace Identifiers
[  154.642471] nvme 0000:00:04.0: vgaarb: pci_notify
nvme (nvme-6.6) # modprobe  -r nvme 
nvme (nvme-6.6) # cdblktests 
blktests (master) # ./check nvme
nvme/002 (create many subsystems and test discovery)         [passed]
    runtime  18.857s  ...  18.964s
nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  10.082s  ...  10.075s
nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
    runtime  1.434s  ...  1.437s
nvme/005 (reset local loopback target)                       [passed]
    runtime  1.800s  ...  1.793s
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
    runtime  0.066s  ...  0.074s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
    runtime  0.033s  ...  0.037s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  1.448s  ...  1.452s
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
    runtime  1.420s  ...  1.434s
nvme/010 (run data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  58.052s  ...  59.627s
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  89.351s  ...  90.811s
nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  52.261s  ...  54.646s
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  82.256s  ...  82.792s
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
    runtime  6.966s  ...  7.131s
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
    runtime  6.135s  ...  6.227s
nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [passed]
    runtime  12.594s  ...  12.457s
nvme/017 (create/delete many file-ns and test discovery)     [passed]
    runtime  12.636s  ...  12.562s
nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
    runtime  1.429s  ...  1.416s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
    runtime  1.440s  ...  1.445s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
    runtime  1.431s  ...  1.425s
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
    runtime  1.430s  ...  1.408s
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
    runtime  1.761s  ...  1.779s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
    runtime  1.448s  ...  1.427s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
    runtime  1.431s  ...  1.410s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
    runtime  1.435s  ...  1.419s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
    runtime  1.415s  ...  1.429s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
    runtime  1.436s  ...  1.431s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
    runtime  1.430s  ...  1.418s
nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
    runtime  1.563s  ...  1.554s
nvme/030 (ensure the discovery generation counter is updated appropriately) [passed]
    runtime  0.205s  ...  0.189s
nvme/031 (test deletion of NVMeOF controllers immediately after setup) [passed]
    runtime  3.899s  ...  3.959s
nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
    runtime  0.013s  ...  0.013s
nvme/040 (test nvme fabrics controller reset/disconnect operation during I/O) [passed]
    runtime  7.953s  ...  7.992s
nvme/041 (Create authenticated connections)                  [passed]
    runtime  0.733s  ...  0.731s
nvme/042 (Test dhchap key types for authenticated connections) [passed]
    runtime  4.755s  ...  4.768s
nvme/043 (Test hash and DH group variations for authenticated connections) [passed]
    runtime  23.182s  ...  23.268s
nvme/044 (Test bi-directional authentication)                [passed]
    runtime  1.814s  ...  1.813s
nvme/045 (Test re-authentication)                            [passed]
    runtime  4.272s  ...  3.809s
nvme/047 (test different queue types for fabric transports)  [not run]
    nvme_trtype=loop is not supported in this test
nvme/048 (Test queue count changes on reconnect)             [not run]
    nvme_trtype=loop is not supported in this test
blktests (master) # 


-- 
2.40.0

