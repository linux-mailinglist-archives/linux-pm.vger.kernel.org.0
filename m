Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34249187E7
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2019 11:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbfEIJmj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 May 2019 05:42:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38414 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfEIJmj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 May 2019 05:42:39 -0400
Received: from mail-pg1-f197.google.com ([209.85.215.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hOfZU-0005ug-3R
        for linux-pm@vger.kernel.org; Thu, 09 May 2019 09:42:36 +0000
Received: by mail-pg1-f197.google.com with SMTP id o8so1312323pgq.5
        for <linux-pm@vger.kernel.org>; Thu, 09 May 2019 02:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vCyQ60BE6nSCa7adNn8wGWtGspW5wwW93oaMgXkndqY=;
        b=Si8LKko3CiQwDLbVTYDGDPTxztGZ1347gJvT0unfAUOnORtRrGnLX/n1jHdWCdO1G2
         XUtOivqZt6N+ivEnlk80fKXrmnkdbzfbTHPl9hztDWV8b3wY+znn4GxjgqePMdNkazXt
         U2+8rp4s1hPSq9AhHDDhncBrjLfUNNpdx2aJM4eOJkCe1NPNlhGWPyli3KI17oZl0als
         zAl8qz1sw41CImOwrJyDicIzsPN4ISvKgR8i9GdRPTB6uufsrGupN+DWHAwyavfjG62Y
         tKP0rBocjYmGKjk3uHlWRHcINyS4qdNWImVO9u//ghfOlhwjm9I/pkD+K3nvmv5o9iw9
         eKEg==
X-Gm-Message-State: APjAAAVWMKXpHgaLXzLxlyJhrwDtGj/wl541IMzWxs1FAgAVxqcmQEFX
        JFlNgkFxZZXB7v8Z3WiICXVbqkGLO4VohNi6sFFsyLtY6bIqZaoGd5D1GTKD4fOfJsGLVumYp3r
        2NrXY3Es4nd/o6BlxO/nza0sWKSEVdg+vVYm/
X-Received: by 2002:a63:10c:: with SMTP id 12mr4207305pgb.276.1557394954729;
        Thu, 09 May 2019 02:42:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx4tmcD33XpLhEuyhpoUaGX5iEQ6p4zYrtvOSZ/IdC6tLif2k7cQ2EI0mQEiPkOT1lAI1J9Ew==
X-Received: by 2002:a63:10c:: with SMTP id 12mr4207277pgb.276.1557394954398;
        Thu, 09 May 2019 02:42:34 -0700 (PDT)
Received: from 2001-b011-380f-14b9-f0ba-4a15-3e79-97f9.dynamic-ip6.hinet.net (2001-b011-380f-14b9-f0ba-4a15-3e79-97f9.dynamic-ip6.hinet.net. [2001:b011:380f:14b9:f0ba:4a15:3e79:97f9])
        by smtp.gmail.com with ESMTPSA id f87sm3062680pff.56.2019.05.09.02.42.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 02:42:33 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] nvme-pci: Use non-operational power state instead of D3
 on Suspend-to-Idle
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <CAJZ5v0ggMwpJt=XWXu4gU51o8y4BpJ4KZ5RKzfk3+v8GGb-QbQ@mail.gmail.com>
Date:   Thu, 9 May 2019 17:42:30 +0800
Cc:     Christoph Hellwig <hch@lst.de>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Keith Busch <kbusch@kernel.org>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8bit
Message-Id: <A4DD2E9F-054E-4D4B-9F77-D69040EBE120@canonical.com>
References: <20190508185955.11406-1-kai.heng.feng@canonical.com>
 <20190508191624.GA8365@localhost.localdomain>
 <3CDA9F13-B17C-456F-8CE1-3A63C6E0DC8F@canonical.com>
 <f8a043b00909418bad6adcdb62d16e6e@AUSX13MPC105.AMER.DELL.COM>
 <20190508195159.GA1530@lst.de>
 <b43f2c0078f245398101fa9a40cfc2dc@AUSX13MPC105.AMER.DELL.COM>
 <20190509061237.GA15229@lst.de>
 <064701C3-2BD4-4D93-891D-B7FBB5040FC4@canonical.com>
 <CAJZ5v0ggMwpJt=XWXu4gU51o8y4BpJ4KZ5RKzfk3+v8GGb-QbQ@mail.gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

at 17:07, Rafael J. Wysocki <rafael@kernel.org> wrote:

> On Thu, May 9, 2019 at 8:49 AM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
>> Cc Rafael and linux-pm
>
> I would have been much more useful to CC the patch to linux-pm at
> least from the outset.
>
>> at 14:12, Christoph Hellwig <hch@lst.de> wrote:
>>
>>> On Wed, May 08, 2019 at 08:28:30PM +0000, Mario.Limonciello@dell.com  
>>> wrote:
>>>> You might think this would be adding runtime_suspend/runtime_resume
>>>> callbacks, but those also get called actually at runtime which is not
>>>> the goal here.  At runtime, these types of disks should rely on APST  
>>>> which
>>>> should calculate the appropriate latencies around the different power
>>>> states.
>>>>
>>>> This code path is only applicable in the suspend to idle state, which
>>>> /does/
>>>> call suspend/resume functions associated with dev_pm_ops.  There isn't
>>>> a dedicated function in there for use only in suspend to idle, which is
>>>> why pm_suspend_via_s2idle() needs to get called.
>>>
>>> The problem is that it also gets called for others paths:
>>>
>>> #ifdef CONFIG_PM_SLEEP
>>> #define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
>>>         .suspend = suspend_fn, \
>>>       .resume = resume_fn, \
>>>       .freeze = suspend_fn, \
>>>       .thaw = resume_fn, \
>>>       .poweroff = suspend_fn, \
>>>       .restore = resume_fn,
>>> #else
>>> else
>>> #define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
>>> #endif
>>>
>>> #define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
>>> const struct dev_pm_ops name = { \
>>>       SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
>>> }
>>>
>>> And at least for poweroff this new code seems completely wrong, even
>>> for freeze it looks rather borderline.
>>
>> Not really, for hibernation pm_suspend_via_s2idle() evaluates to false so
>> the old code path will be taken.
>>
>>> And more to the points - if these "modern MS standby" systems are
>>> becoming common, which it looks they are, we need support in the PM core
>>> for those instead of working around the decisions in low-level drivers.
>>
>> Rafael, what do you think about this?
>
> The difference between suspend-to-idle and suspend-to-RAM (S3) boils
> down to the fact that at the end of S3 suspend all control of the
> system is passed to the platform firmware.  Then, the firmware can
> take care of some things that may not be taken care of by drivers (it
> sometimes assumes that drivers will not take care of those things even
> which is generally problematic).
>
> For suspend-to-idle the final physical state of the system should (in
> theory) be the same as the deepest possible physical idle state of it
> achievable through working-state PM (combination of PM-runtime and
> cpuidle, roughly speaking).  However, in practice the working-state PM
> may not even be able to get there, as it generally requires many
> things to happen exactly at the right time in a specific order and the
> probability of that in the working-state PM situation is practically
> 0.  Suspend-to-idle helps here by quiescing everything in an ordered
> fashion which makes all of the requisite conditions more likely to be
> met together.
>
> So yes, from an individual driver perspective, the device handling for
> s2idle should be more like for PM-runtime than for S3 (s2R), but this
> really shouldn't matter (and it doesn't matter for the vast majority
> of drivers).
>
> Unfortunately, the "modern MS standby" concept makes it matter,
> because "modern MS standby" causes system-wide transitions to be
> "special" and it appears to expect drivers to take care of the "extra
> bit" that would have been taken care of by the platform firmware in
> the S3 case.  [Note that in the Windows world the "modern MS standby"
> systems don't support S3 ("modern MS standby" and S3 support are
> mutually exclusive in Windows AFAICS) while Linux needs to support S3
> and is expected to achieve the minimum power state through s2idle
> (generally, even on the same platform) at the same time.]
>
>> Including this patch, there are five drivers that use
>> pm_suspend_via_{firmware,s2idle}() to differentiate between S2I and S3.
>
> Well, that is not a large number relative to the total number of
> drivers in Linux.

That’s right, but I think we are going to see more of similar cases.

>
>> So I think maybe it’s time to introduce a new suspend callback for S2I?
>
> That would be a set of 6 new suspend and resume callbacks, mind you,
> and there's quite a few of them already.  And the majority of drivers
> would not need to use them anyway.

I think suspend_to_idle() and resume_from_idle() should be enough?
What are other 4 callbacks?

>
> Also, please note that, possibly apart from the device power state
> setting, the S2I and S2R handling really aren't that different at all.
> You basically need to carry out the same preparations during suspend
> and reverse them during resume in both cases.

But for this case, it’s quite different to the original suspend and resume  
callbacks.

>
> That said I admit that there are cases in which device drivers need to
> know that the system-wide transition under way is into s2idle and so
> they should do extra stuff.  If pm_suspend_via_firmware() is not
> sufficient for that, then I'm open to other suggestions, but
> introducing a new set of callbacks for that alone would be rather
> excessive IMO.

 From drivers’ perspective nothing changed, as PM core can prioritize  
suspend_to_idle() over suspend() when it’s actually S2I.

>
>>>> SIMPLE_DEV_PM_OPS normally sets the same function for suspend and
>>>> freeze (hibernate), so to avoid any changes to the hibernate case it  
>>>> seems
>>>> to me that there needs to be a new nvme_freeze() that calls into the
>>>> existing
>>>> nvme_dev_disable for the freeze pm op and nvme_thaw() that calls into  
>>>> the
>>>> existing nvme_reset_ctrl for the thaw pm op.
>>>
>>> At least, yes.
>>
>> Hibernation should remain the same as stated above.
>
> Depending on what check is used in that code path.
> pm_suspend_via_s2idle() will return "true" in the hibernation path
> too, for one.

You are right, I should use !pm_suspend_via_firmware() instead.

>
>>>>> enterprise class NVMe devices
>>>>> that don't do APST and don't really do different power states at
>>>>> all in many cases.
>>>>
>>>> Enterprise class NVMe devices that don't do APST - do they typically
>>>> have a non-zero value for ndev->ctrl.npss?
>>>>
>>>> If not, they wouldn't enter this new codepath even if the server entered
>>>> into S2I.
>>>
>>> No, devices that do set NPSS will have at least some power states
>>> per definition, although they might not be too useful.  I suspect  
>>> checking
>>> APSTA might be safer, but if we don't want to rely on APST we should
>>> check for a power state supporting the condition that the MS document
>>> quoted in the original document supports.
>>
>> If Modern Standby or Connected Standby is not supported by servers, I  
>> don’t
>> think the design documents mean much here.
>> We probably should check if the platform firmware really supports S2I
>> instead.
>
> S2I is expected to work regardless of the platform firmware and there
> is nothing like "platform firmware support for S2I".  IOW, that check
> would always return "false".
>
> What you really need to know is if the given particular transition is S2I.

Maybe a helper based on FADT flag and _DSM can do this thing?

Kai-Heng


