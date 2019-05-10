Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 721FB19FE9
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2019 17:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfEJPNl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 10 May 2019 11:13:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45863 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbfEJPNk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 May 2019 11:13:40 -0400
Received: from mail-pf1-f199.google.com ([209.85.210.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hP7DN-0006cL-Uz
        for linux-pm@vger.kernel.org; Fri, 10 May 2019 15:13:38 +0000
Received: by mail-pf1-f199.google.com with SMTP id e20so4325117pfn.8
        for <linux-pm@vger.kernel.org>; Fri, 10 May 2019 08:13:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NmWASUs3KbA0AaXEm2yCaVhhAGbxqPp+fvrTyXt64uk=;
        b=jXQoLrDeNJBHSqtsxFKwlJZsa92gPBP7Kw99I7/h7qkrcR1Jm0akus7i7zOBzeTsgI
         FVcs30+4aWx9PtnDN49++gZNVSO1DaAwKpeypmh0ouk/q9SG2/iboDIQqRSXloX6Jl1H
         UY/k8EmgE76/OHAZWIhwJApvYiRatJnd39DPweVc+RgR51GSOgW/CkPR8TYkAjlKA2kM
         BIEYqGGiUkYA1MuIB2kP5r9vSZuk+7CGlDVw4PabfVwEecGD8IOhnjv/CzyGuRBGliwR
         /5AC/a3eCb57JJoGp5Va68S5r/ybGbfQBGKOBGS15z7IWoyM+hND+cfMIHxRySpDBf+T
         Q50A==
X-Gm-Message-State: APjAAAX5Tz6cxUI37pRyxrcdsI4lprAbBPjOpQRwilsOMSpKN+jqnnzw
        mXvqMGAA3qOnyooWHs0C48SsxTflShIzkDqOaY9LzP6npvNkllT+m+eZ/EMXPNx4S80+DiQZj2j
        ea5ORaQfaEcihrmivAk+YgBOjrgfQD8W7dn7I
X-Received: by 2002:aa7:9242:: with SMTP id 2mr15164962pfp.230.1557501216535;
        Fri, 10 May 2019 08:13:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxw5zxsqhG5LJGMPKVvE2BsNwPWG6uw9NXt/AOlH6TmHdYZv9RPBiVsLYlez6zOdIpxiCnFlQ==
X-Received: by 2002:aa7:9242:: with SMTP id 2mr15164896pfp.230.1557501216170;
        Fri, 10 May 2019 08:13:36 -0700 (PDT)
Received: from [192.168.1.220] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id 2sm11743129pgc.49.2019.05.10.08.13.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 08:13:33 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] nvme-pci: Use non-operational power state instead of D3
 on Suspend-to-Idle
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <CAJZ5v0jAcX-Q2twygKoKvmx2H6tneHWimmH+c2GsYitHK5-knw@mail.gmail.com>
Date:   Fri, 10 May 2019 23:15:05 +0800
Cc:     Mario Limonciello <Mario.Limonciello@dell.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Linux PM <linux-pm@vger.kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Keith Busch <keith.busch@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <54E4999C-DBE8-4FC1-8E82-17FEDFDA9CA6@canonical.com>
References: <064701C3-2BD4-4D93-891D-B7FBB5040FC4@canonical.com>
 <CAJZ5v0ggMwpJt=XWXu4gU51o8y4BpJ4KZ5RKzfk3+v8GGb-QbQ@mail.gmail.com>
 <A4DD2E9F-054E-4D4B-9F77-D69040EBE120@canonical.com>
 <20190509095601.GA19041@lst.de>
 <225CF4F7-C8E1-4C66-B362-97E84596A54E@canonical.com>
 <20190509103142.GA19550@lst.de>
 <AB325926-0D77-4851-8E8A-A10599756BF9@canonical.com>
 <31b7d7959bf94c15a04bab0ced518444@AUSX13MPC101.AMER.DELL.COM>
 <20190509192807.GB9675@localhost.localdomain>
 <7a002851c435481593f8629ec9193e40@AUSX13MPC101.AMER.DELL.COM>
 <20190509215409.GD9675@localhost.localdomain>
 <495d76c66aec41a8bfbbf527820f8eb9@AUSX13MPC101.AMER.DELL.COM>
 <BC5EB1D0-8718-48B3-ACAB-F7E5571D821D@canonical.com>
 <CAJZ5v0jAcX-Q2twygKoKvmx2H6tneHWimmH+c2GsYitHK5-knw@mail.gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



> On May 10, 2019, at 4:23 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> 
> On Fri, May 10, 2019 at 8:08 AM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
>> 
>> at 06:19, <Mario.Limonciello@dell.com> <Mario.Limonciello@dell.com> wrote:
>> 
>>>> -----Original Message-----
>>>> From: Keith Busch <kbusch@kernel.org>
>>>> Sent: Thursday, May 9, 2019 4:54 PM
>>>> To: Limonciello, Mario
>>>> Cc: kai.heng.feng@canonical.com; hch@lst.de; axboe@fb.com;
>>>> sagi@grimberg.me; rafael@kernel.org; linux-pm@vger.kernel.org;
>>>> rafael.j.wysocki@intel.com; linux-kernel@vger.kernel.org; linux-
>>>> nvme@lists.infradead.org; keith.busch@intel.com
>>>> Subject: Re: [PATCH] nvme-pci: Use non-operational power state instead
>>>> of D3 on
>>>> Suspend-to-Idle
>>>> 
>>>> 
>>>> [EXTERNAL EMAIL]
>>>> 
>>>> On Thu, May 09, 2019 at 09:37:58PM +0000, Mario.Limonciello@dell.com
>>>> wrote:
>>>>>> +int nvme_set_power(struct nvme_ctrl *ctrl, unsigned npss)
>>>>>> +{
>>>>>> +  int ret;
>>>>>> +
>>>>>> +  mutex_lock(&ctrl->scan_lock);
>>>>>> +  nvme_start_freeze(ctrl);
>>>>>> +  nvme_wait_freeze(ctrl);
>>>>>> +  ret = nvme_set_features(ctrl, NVME_FEAT_POWER_MGMT, npss, NULL, 0,
>>>>>> +                          NULL);
>>>>>> +  nvme_unfreeze(ctrl);
>>>>>> +  mutex_unlock(&ctrl->scan_lock);
>>>>>> +
>>>>>> +  return ret;
>>>>>> +}
>>>>>> +EXPORT_SYMBOL_GPL(nvme_set_power);
>>>>> 
>>>>> I believe without memory barriers at the end disks with HMB this will
>>>>> still kernel panic (Such as Toshiba BG3).
>>>> 
>>>> Well, the mutex has an implied memory barrier, but your HMB explanation
>>>> doesn't make much sense to me anyway. The "mb()" in this thread's original
>>>> patch is a CPU memory barrier, and the CPU had better not be accessing
>>>> HMB memory. Is there something else going on here?
>>> 
>>> Kai Heng will need to speak up a bit in his time zone as he has this disk
>>> on hand,
>>> but what I recall from our discussion was that DMA operation MemRd after
>>> resume was the source of the hang.
>> 
>> Yes, that’ what I was told by the NVMe vendor, so all I know is to impose a
>> memory barrier.
>> If mb() shouldn’t be used here, what’s the correct variant to use in this
>> context?
>> 
>>> 
>>>>> This still allows D3 which we found at least failed to go into deepest
>>>>> state and
>>>> blocked
>>>>> platform s0ix for the following SSDs (maybe others):
>>>>> Hynix PC601
>>>>> LiteOn CL1
>>>> 
>>>> We usually write features to spec first, then quirk non-compliant
>>>> devices after.
>>> 
>>> NVME spec doesn't talk about a relationship between SetFeatures w/
>>> NVME_FEAT_POWER_MGMGT and D3 support, nor order of events.
>>> 
>>> This is why we opened a dialog with storage vendors, including
>>> contrasting the behavior
>>> of Microsoft Windows inbox NVME driver and Intel's Windows RST driver.
>>> 
>>> Those two I mention that come to mind immediately because they were most
>>> recently
>>> tested to fail.  Our discussion with storage vendors overwhelmingly
>>> requested
>>> that we don't use D3 under S2I because their current firmware
>>> architecture won't
>>> support it.
>>> 
>>> For example one vendor told us with current implementation that receiving
>>> D3hot
>>> after NVME shutdown will prevent being able to enter L1.2.  D3hot entry
>>> was supported
>>> by an IRQ handler that isn't serviced in NVME shutdown state.
>>> 
>>> Another vendor told us that with current implementation it's impossible
>>> to transition
>>> to PS4 (at least via APST) while L1.2 D3hot is active.
>> 
>> I tested the patch from Keith and it has two issues just as simply skipping
>> nvme_dev_disable():
>> 1) It consumes more power in S2I
>> 2) System freeze after resume
> 
> Well, the Keith's patch doesn't prevent pci_pm_suspend_noirq() from
> asking for D3 and both of the symptoms above may be consequences of
> that in principle.

Sorry, I should mention that I use a slightly modified drivers/nvme/host/pci.c:

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3e4fb891a95a..ece428ce6876 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -18,6 +18,7 @@
 #include <linux/mutex.h>
 #include <linux/once.h>
 #include <linux/pci.h>
+#include <linux/suspend.h>
 #include <linux/t10-pi.h>
 #include <linux/types.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
@@ -2833,6 +2834,11 @@ static int nvme_suspend(struct device *dev)
        struct pci_dev *pdev = to_pci_dev(dev);
        struct nvme_dev *ndev = pci_get_drvdata(pdev);
 
+       if (!pm_suspend_via_firmware()) {
+               nvme_set_power(&ndev->ctrl, ndev->ctrl.npss);
+               pci_save_state(pdev);
+       }
+
        nvme_dev_disable(ndev, true);
        return 0;
 }
@@ -2842,6 +2848,10 @@ static int nvme_resume(struct device *dev)
        struct pci_dev *pdev = to_pci_dev(dev);
        struct nvme_dev *ndev = pci_get_drvdata(pdev);
 
+       if (!pm_resume_via_firmware()) {
+               return nvme_set_power(&ndev->ctrl, 0);
+       }
+
        nvme_reset_ctrl(&ndev->ctrl);
        return 0;
}

Does pci_save_state() here enough to prevent the device enter to D3?

Kai-Heng

