Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34CB918587
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2019 08:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfEIGtH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 May 2019 02:49:07 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35216 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfEIGtG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 May 2019 02:49:06 -0400
Received: from mail-pg1-f197.google.com ([209.85.215.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hOcrZ-0003dt-4i
        for linux-pm@vger.kernel.org; Thu, 09 May 2019 06:49:05 +0000
Received: by mail-pg1-f197.google.com with SMTP id s5so989618pgv.21
        for <linux-pm@vger.kernel.org>; Wed, 08 May 2019 23:49:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=32kiJIP116e2mLUfbaNVIRXAUg5m0z/rzvErm/or1eE=;
        b=NI6pQnmrXCBldvrkvfK0MSM0t/onJPjQcIXnSngnv25LxV+t4OC8OwBWLujkjhDwGm
         gXmM5II+dSHdi6+3M6CyRlIMvgiPAKNcTe45gR4ShNF97PxMsw9ikDbD7poQQUfRlNYj
         IjTrDp7xS/fXvYLbJ2ikPd68kVwcmf235l25GIk+6gtMNm0EOVV62zG4DtxJqJcK+AK1
         Cb2TChvgY6EtDKE7+koTIgBNx3MJ3oKKoP9xHPbpBW7en7mhgkH9OBoUPQIinwFORguY
         5l/lB4HzyqrZJETHFabrAjCWWuZ37hwuo5PcFAGbyEa8hT82X6K5qIWlGpL2zTNxkVBf
         ApBg==
X-Gm-Message-State: APjAAAXqyE6VRXJ3uAi44GCbt1+rdilCQN376QEFHEDhcLGGEl2SdLmc
        fLTDG9pxIfR1JQpYcqErWrncihpYRA0FiIiyAZCZqAQ17ugyItK/2CIVVP/8bWOtV/PH8jj89LK
        P8rKeTbLKsxea8DRxqjlruWLkLBfGvOyfILg5
X-Received: by 2002:a17:902:2927:: with SMTP id g36mr2893654plb.6.1557384543703;
        Wed, 08 May 2019 23:49:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxJPM/iiIg9NOJAfxK2pfbyNTkSEm2UBAYNaAFq1fQROUzkh4woLlPJ4IuDqPN3TMlHwJyvEA==
X-Received: by 2002:a17:902:2927:: with SMTP id g36mr2893630plb.6.1557384543367;
        Wed, 08 May 2019 23:49:03 -0700 (PDT)
Received: from 2001-b011-380f-14b9-f0ba-4a15-3e79-97f9.dynamic-ip6.hinet.net (2001-b011-380f-14b9-f0ba-4a15-3e79-97f9.dynamic-ip6.hinet.net. [2001:b011:380f:14b9:f0ba:4a15:3e79:97f9])
        by smtp.gmail.com with ESMTPSA id i12sm1460088pgb.61.2019.05.08.23.49.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 23:49:02 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] nvme-pci: Use non-operational power state instead of D3
 on Suspend-to-Idle
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20190509061237.GA15229@lst.de>
Date:   Thu, 9 May 2019 14:48:59 +0800
Cc:     Mario.Limonciello@dell.com, Keith Busch <kbusch@kernel.org>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8bit
Message-Id: <064701C3-2BD4-4D93-891D-B7FBB5040FC4@canonical.com>
References: <20190508185955.11406-1-kai.heng.feng@canonical.com>
 <20190508191624.GA8365@localhost.localdomain>
 <3CDA9F13-B17C-456F-8CE1-3A63C6E0DC8F@canonical.com>
 <f8a043b00909418bad6adcdb62d16e6e@AUSX13MPC105.AMER.DELL.COM>
 <20190508195159.GA1530@lst.de>
 <b43f2c0078f245398101fa9a40cfc2dc@AUSX13MPC105.AMER.DELL.COM>
 <20190509061237.GA15229@lst.de>
To:     Christoph Hellwig <hch@lst.de>, rafael.j.wysocki@intel.com
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Cc Rafael and linux-pm

at 14:12, Christoph Hellwig <hch@lst.de> wrote:

> On Wed, May 08, 2019 at 08:28:30PM +0000, Mario.Limonciello@dell.com wrote:
>> You might think this would be adding runtime_suspend/runtime_resume
>> callbacks, but those also get called actually at runtime which is not
>> the goal here.  At runtime, these types of disks should rely on APST which
>> should calculate the appropriate latencies around the different power  
>> states.
>>
>> This code path is only applicable in the suspend to idle state, which  
>> /does/
>> call suspend/resume functions associated with dev_pm_ops.  There isn't
>> a dedicated function in there for use only in suspend to idle, which is
>> why pm_suspend_via_s2idle() needs to get called.
>
> The problem is that it also gets called for others paths:
>
> #ifdef CONFIG_PM_SLEEP
> #define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
>         .suspend = suspend_fn, \
> 	.resume = resume_fn, \
> 	.freeze = suspend_fn, \
> 	.thaw = resume_fn, \
> 	.poweroff = suspend_fn, \
> 	.restore = resume_fn,
> #else
> else
> #define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
> #endif
>
> #define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
> const struct dev_pm_ops name = { \
> 	SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
> }
>
> And at least for poweroff this new code seems completely wrong, even
> for freeze it looks rather borderline.

Not really, for hibernation pm_suspend_via_s2idle() evaluates to false so  
the old code path will be taken.

>
> And more to the points - if these "modern MS standby" systems are
> becoming common, which it looks they are, we need support in the PM core
> for those instead of working around the decisions in low-level drivers.

Rafael, what do you think about this?
Including this patch, there are five drivers that use  
pm_suspend_via_{firmware,s2idle}() to differentiate between S2I and S3.
So I think maybe it’s time to introduce a new suspend callback for S2I?

>
>> SIMPLE_DEV_PM_OPS normally sets the same function for suspend and
>> freeze (hibernate), so to avoid any changes to the hibernate case it seems
>> to me that there needs to be a new nvme_freeze() that calls into the  
>> existing
>> nvme_dev_disable for the freeze pm op and nvme_thaw() that calls into the
>> existing nvme_reset_ctrl for the thaw pm op.
>
> At least, yes.

Hibernation should remain the same as stated above.

>
>>> enterprise class NVMe devices
>>> that don't do APST and don't really do different power states at
>>> all in many cases.
>>
>> Enterprise class NVMe devices that don't do APST - do they typically
>> have a non-zero value for ndev->ctrl.npss?
>>
>> If not, they wouldn't enter this new codepath even if the server entered  
>> into S2I.
>
> No, devices that do set NPSS will have at least some power states
> per definition, although they might not be too useful.  I suspect checking
> APSTA might be safer, but if we don't want to rely on APST we should
> check for a power state supporting the condition that the MS document
> quoted in the original document supports.

If Modern Standby or Connected Standby is not supported by servers, I don’t  
think the design documents mean much here.
We probably should check if the platform firmware really supports S2I  
instead.

Kai-Heng

