Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0460E4577FB
	for <lists+linux-pm@lfdr.de>; Fri, 19 Nov 2021 21:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbhKSVAq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Nov 2021 16:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235393AbhKSVAp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Nov 2021 16:00:45 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F32FC061574
        for <linux-pm@vger.kernel.org>; Fri, 19 Nov 2021 12:57:43 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id w29so20166911wra.12
        for <linux-pm@vger.kernel.org>; Fri, 19 Nov 2021 12:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=I4B5HFmy96F+nwrWPqo3yCY/gtnU/WqzBwP+duwHSo8=;
        b=L0WK59nFYAx5D1sVOWtIE+pfcFj77YnZRRca6xSi6oRHtVLRet9kQTIE8d3Vz1MBkS
         fVk+fBalwe4exDT+tgq4O10P9pO4O0NvTWIilEkcQruFmsOBmFgqGpXwHjaM2IwF9X/H
         UBxhFDfu/FJnYvWtuUh0IZmvZq0lI0sin83XCFfm9uY96DAXgmx470ktEey5o07BkRsV
         vwJRQzunIgehdNa+5fkMLujEBgqElBRnBMOaFrOEHi6BSdALFlHu7rXKTJubc4eyPhSP
         I6ErWfPES5Z4jmDaRKhTwS2CYLBDJHyBWxOHEt2NT3iNlQwPVnzGQ/aaKbtVz2xHyoBV
         wizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=I4B5HFmy96F+nwrWPqo3yCY/gtnU/WqzBwP+duwHSo8=;
        b=wjCJI3jfZm9y4xSY31fsrSAujEE1slkjnqzhdlB5OTcoPSJ8Meffk9E0HuvHPwo9II
         +5Crcr9y0vFzo40LXbtcSvbqClk9rSNHm9ye5vZlee+vVFXLRCyBafm182oEwlfURteT
         dm6h6B0lGh86g2dyAACkIZeaVg1Bsrgl/MDAojNTWni/P/1tWv2G41eaouJiBmK0HRVA
         Tse3J2pOnS6YukUe5MrSStnIg4iyDmudCwvzQO7Fo1/KbzcLFRuWbsgLikux1memkWiJ
         Y8dqO36TPqHbjm97MrNOvC+qEDjYkas2TYy9roHfXJ95uPJIFOchlM1K+l8ZOLV5FC10
         M6Iw==
X-Gm-Message-State: AOAM532W0WkLlViV/YcYFh23y5LcbSgM+l54GDNtpCu9zY5O5bO8mLVc
        uE4FuPutpONVefZRLE0S5kE=
X-Google-Smtp-Source: ABdhPJxThqyWTf0egpTyNTCp6Gr7jhSgpzMj1B/CMXcoDPlLYGFSCSstGGEn/cT9MiTXSGpY9jdDTw==
X-Received: by 2002:a5d:64c3:: with SMTP id f3mr10883281wri.321.1637355462123;
        Fri, 19 Nov 2021 12:57:42 -0800 (PST)
Received: from ?IPV6:2003:ea:8f1a:f00:e956:6e6f:f307:5861? (p200300ea8f1a0f00e9566e6ff3075861.dip0.t-ipconnect.de. [2003:ea:8f1a:f00:e956:6e6f:f307:5861])
        by smtp.googlemail.com with ESMTPSA id n15sm14768925wmq.38.2021.11.19.12.57.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 12:57:41 -0800 (PST)
Message-ID: <cf153c5c-e2f0-8d40-cdab-b893e63d2e9c@gmail.com>
Date:   Fri, 19 Nov 2021 21:57:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, Linux PM <linux-pm@vger.kernel.org>
References: <d9d76980-966a-e031-70d1-3254ba5be5eb@gmail.com>
 <s5hczmxgnm2.wl-tiwai@suse.de>
 <bc281416-e28d-4c18-2475-add92d38a554@gmail.com>
 <s5hczmwfe3x.wl-tiwai@suse.de>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: Warning due to "ALSA: hda: intel: More comprehensive PM runtime
 setup for controller driver"
In-Reply-To: <s5hczmwfe3x.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19.11.2021 14:51, Takashi Iwai wrote:
> On Thu, 18 Nov 2021 23:13:50 +0100,
> Heiner Kallweit wrote:
>>
>> On 18.11.2021 22:28, Takashi Iwai wrote:
>>> On Thu, 18 Nov 2021 21:33:34 +0100,
>>> Heiner Kallweit wrote:
>>>>
>>>> I get the following warning caused by 4f66a9ef37d3 ("ALSA: hda: intel: More
>>>> comprehensive PM runtime setup for controller driver"):
>>>>
>>>> snd_hda_intel 0000:00:1f.3: Unbalanced pm_runtime_enable!
>>>>
>>>> Not sure how this patch was tested because the warning is obvious.
>>>> The patch doesn't consider what the PCI sub-system does with regard to
>>>> RPM. Have a look at pci_pm_init().
>>>>
>>>> I'd understand to add the call to pm_runtime_dont_use_autosuspend(),
>>>> but for all other added calls I see no justification.
>>>>
>>>> If being unsure about when to use which RPM call best involve
>>>> linux-pm@vger.kernel.org.
>>>
>>> Thanks for the notice.  It's been through Intel CI and tests on a few
>>> local machines, maybe we haven't checked carefully those errors but
>>> only concentrated on the other issues, as it seems.
>>>
>>> There were two problems: one was the runtime PM being kicked off even
>>> during the PCI driver remove call, and another was the proper runtime
>>> PM setup after re-binding.
>>>
>>
>> Having a look at the commit message of "ALSA: hda: fix general protection
>> fault in azx_runtime_idle" the following sounds weird:
>>
>>   - pci-driver.c:pm_runtime_put_sync() leads to a call
>>     to rpm_idle() which again calls azx_runtime_idle()
>>
>> rpm_idle() is only called if usage_count is 1 when entering
>> pm_runtime_put_sync. And this should not be the case.
>> pm_runtime_get_sync() increments the usage counter before remove()
>> is called, and remove() should also increment the usage counter.
>> This doesn't seem to happen. Maybe for whatever reason 
>> pm_runtime_get_noresume() isn't called in azx_free(), or azx_free()
>> isn't called from remove().
>> I think you should trace the call chain from the PCI core calling
>> remove() to pm_runtime_get_noresume() getting called or not.
> 
> Neither of them, supposedly.  Now I took a deeper look at the code
> around it and dug into the git log, and found that the likely problem
> was the recent PCI core code refactoring (removal of pci->driver, etc)
> that have been already reverted; that was why linux-next-20211109 was
> broken and linux-next-20211110 worked.  With the leftover pci->driver,
> the stale runtime PM callback was called at the pm_runtime_put_sync()
> call in pci_device_remove().
> 
I also noticed that partially I was on the wrong path.

> In anyway, I'll drop the invalid calls of pm_runtime_enable() /
> disable() & co.  Maybe keeping pm_runtime_forbid() and
> pm_runtime_dont_use_autosuspend() at remove still makes some sense as
> a counter-part for the probe calls, though.
> 
The call to pm_runtime_forbid() in pci_pm_init() is a heritage from
early ACPI times when broken ACPI implementations had problems with RPM.
There's a discussion (w/o result yet) to enable RPM per default for
newer ACPI versions.

Calling pm_runtime_forbid() in the driver removal path isn't strictly
needed but it doesn't hurt.

> 
> thanks,
> 
> Takashi
> 

