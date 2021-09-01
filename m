Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBA503FD4D7
	for <lists+linux-pm@lfdr.de>; Wed,  1 Sep 2021 10:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242870AbhIAIDZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Sep 2021 04:03:25 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:15281 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242876AbhIAIDF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Sep 2021 04:03:05 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GzxN42MPjz8D9C;
        Wed,  1 Sep 2021 16:01:40 +0800 (CST)
Received: from dggemi759-chm.china.huawei.com (10.1.198.145) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 1 Sep 2021 16:01:55 +0800
Received: from [127.0.0.1] (10.40.192.131) by dggemi759-chm.china.huawei.com
 (10.1.198.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Wed, 1 Sep
 2021 16:01:54 +0800
From:   luojiaxing <luojiaxing@huawei.com>
Subject: Some concurrent actions cause __device_links_no_driver to report the
 warning calltrace.
To:     <rafael.j.wysocki@intel.com>, <linux-pm@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <02b78c8a-82e8-94d1-efe6-a1510e5f884d@huawei.com>
Date:   Wed, 1 Sep 2021 16:01:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.40.192.131]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggemi759-chm.china.huawei.com (10.1.198.145)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi, rafael


I found one issue about device link, and want to ask for your help.


During the kernel test recently, we find that some concurrent actions 
generate a calltrace, as shown in the following:

<4>[  606.102307] WARNING: CPU: 0 PID: 7 at drivers/base/core.c:1339 
__device_links_no_driver+0x138/0x170
<4>[  606.284685] Call trace:
<4>[  606.287122]  __device_links_no_driver+0x138/0x170
<4>[  606.291804]  device_links_driver_cleanup+0xb0/0xfc
<4>[  606.296575]  __device_release_driver+0x148/0x1d8
<4>[  606.301173]  device_release_driver+0x38/0x50
<4>[  606.305423]  bus_remove_device+0x130/0x140
<4>[  606.309502]  device_del+0x174/0x430
<4>[  606.312975]  __scsi_remove_device+0x114/0x14c
<4>[  606.317313]  scsi_remove_target+0x1bc/0x240
<4>[  606.321469]  sas_rphy_remove+0x90/0x94
<4>[  606.325202]  sas_rphy_delete+0x44/0x5c
<4>[  606.328935]  sas_destruct_devices+0x64/0xa0 [libsas]
<4>[  606.333883]  sas_revalidate_domain+0xf8/0x1d0 [libsas]
<4>[  606.339002]  process_one_work+0x1dc/0x48c
<4>[  606.342994]  worker_thread+0x15c/0x464
<4>[  606.346726]  kthread+0x168/0x16c
<4>[  606.349940]  ret_from_fork+0x10/0x18
<4>[  606.353502] ---[ end trace cceb4f5db8bdcd25 ]---


The test method is to rmmod device driver and perform hard reset on the 
hard disk at the same time.


We know device_links_unbind_consumers() is called during rmmod device 
driver to release all consumers under the device in sequence.

As we are storage controller driver, so it look as follows:

supplier: storage controller

consumer: sda->sdb->sdc...

As the device_links_unbind_consumers () releases the consumer device in 
serial mode. If a concurrent action is performed to hard reset a hard 
disk, as the following software call stack show :

scsi_remove_target->device_del->bus_remove_device->device_release_driver->__device_links_no_driver().

The hardreset process also calls __device_links_no_driver.

Assume that device_links_unbind_consumers () is releasing sda and sdb is 
queuing, but scsi_remove_target() calls __device_links_no_driver() to 
release sdb in advance.Then a warning calltrace is generated.

We got some further analysis, it shows that sdb's link->status is now 
DL_STATE_ACTIVE(sda's sdb's link->status is modified to 
DL_STATE_SUPPLIER_UNBIND by device_links_unbind_consumers).

The if() in the following code will be false and pass through.

if (link->status != DL_STATE_CONSUMER_PROBE &&
     link->status != DL_STATE_ACTIVE)
     continue;

Since link->supplier->links.status has been set to DL_DEV_UNBINDING, 
next code enters the else branch.

if (link->supplier->links.status == DL_DEV_DRIVER_BOUND) {
         WRITE_ONCE(link->status, DL_STATE_AVAILABLE);
} else {
         WARN_ON(!(link->flags & DL_FLAG_SYNC_STATE_ONLY));
         WRITE_ONCE(link->status, DL_STATE_DORMANT);
}


Because link->flags is set to DL_FLAG_MANAGED, calltrace is generated 
based on WARN_ON.


In conclusion, we know that the call trace is generated because 
link->supplier->links.status and link->status are not modified 
synchronously.

After link->supplier->links.status is changed to DL_DEV_UNBINDING, the 
value of link->status is changed to DL_STATE_SUPPLIER_UNBIND in sequence.

During this time difference, if a concurrent kernel thread invokes 
__device_links_no_driver, warning calltrace will occurs.


I wonder if there is any way to solve this warning call trace?


Thanks

Jiaxing



