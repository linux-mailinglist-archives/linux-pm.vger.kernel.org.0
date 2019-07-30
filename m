Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44E767B2A7
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 20:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388418AbfG3SuR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 14:50:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47184 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388054AbfG3SuJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 14:50:09 -0400
Received: from mail-pl1-f199.google.com ([209.85.214.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hsXCI-0008Q7-O6
        for linux-pm@vger.kernel.org; Tue, 30 Jul 2019 18:50:06 +0000
Received: by mail-pl1-f199.google.com with SMTP id d2so35860468pla.18
        for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2019 11:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8AX9oe3ZacxjT4EiPIUnCdg/jOWgIIX7DxG+k/pFbS8=;
        b=FlS6OnEA87y15T5iZj+OJA9dc9wM5EeddSzeU5VsJAu/8kLGFeY9UVMgAVBfLvBE/v
         nuS6YgiqPzKpQqveRl1sw0LSnJZSh7DLQ/z57AC+i4w4AjNZBdDhhNCErnfNicubBdcf
         F+25pRCXUwuFp/XVejRWY6RDoRxBkeqyg5errupAQ157dMr0s6pUjhIDpUsVwpURP6a+
         wlfvfrD0LPuv7v17VQkv82jDJHRFKFSGvm3gA1uJ+XyqOWzhcgJZ9bN2D381txPw/iIQ
         41vCPoswFNaGs7FzQuS7uH3UNWxqGPFFfRpVCgNmHoQ1/atwH8hCG22XFcpbW3bS+LDP
         vOEA==
X-Gm-Message-State: APjAAAWN2Jsz/hCkMwiFpweqkejE9nc22NTr5GkHLmGNOEB5YOnXjYS+
        n6XcJ6yKp+nLGKJ3Gd1S2YV8lhORqGkfMFXeS/LeZFcVoGLe5JcdoL/HWkjXtYrivawJrsFv9t6
        ViLDX2TUI5ryBZBnwyR8OhWRGQfOD34Ub2kLv
X-Received: by 2002:a17:902:6b81:: with SMTP id p1mr113381983plk.91.1564512605414;
        Tue, 30 Jul 2019 11:50:05 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxvCU5ize3AwSJB2TM51RQU/Q2wBF3GrSjiotc5LGGtRBCPjWjkrkKo6GCfdHilGoejjSBy7g==
X-Received: by 2002:a17:902:6b81:: with SMTP id p1mr113381952plk.91.1564512605139;
        Tue, 30 Jul 2019 11:50:05 -0700 (PDT)
Received: from 2001-b011-380f-37d3-91ca-5fad-3233-fb26.dynamic-ip6.hinet.net (2001-b011-380f-37d3-91ca-5fad-3233-fb26.dynamic-ip6.hinet.net. [2001:b011:380f:37d3:91ca:5fad:3233:fb26])
        by smtp.gmail.com with ESMTPSA id h1sm88791118pfo.152.2019.07.30.11.50.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 11:50:04 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [Regression] Commit "nvme/pci: Use host managed power state for
 suspend" has problems
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <100ba4aff1c6434a81e47774ab4acddc@AUSX13MPC105.AMER.DELL.COM>
Date:   Wed, 31 Jul 2019 02:50:01 +0800
Cc:     Keith Busch <kbusch@kernel.org>, rjw@rjwysocki.net,
        keith.busch@intel.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rajatja@google.com
Content-Transfer-Encoding: 7bit
Message-Id: <8246360B-F7D9-42EB-94FC-82995A769E28@canonical.com>
References: <2332799.izEFUvJP67@kreacher>
 <4323ed84dd07474eab65699b4d007aaf@AUSX13MPC105.AMER.DELL.COM>
 <CAJZ5v0iDQ4=kTUgW94tKGt7oJzA_3uVU_M6HAMbNCRXwp_do8A@mail.gmail.com>
 <47415939.KV5G6iaeJG@kreacher> <20190730144134.GA12844@localhost.localdomain>
 <100ba4aff1c6434a81e47774ab4acddc@AUSX13MPC105.AMER.DELL.COM>
To:     Mario.Limonciello@dell.com
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

at 01:14, <Mario.Limonciello@dell.com> <Mario.Limonciello@dell.com> wrote:

>> -----Original Message-----
>> From: Keith Busch <kbusch@kernel.org>
>> Sent: Tuesday, July 30, 2019 9:42 AM
>> To: Rafael J. Wysocki
>> Cc: Busch, Keith; Limonciello, Mario; Kai-Heng Feng; Christoph Hellwig;  
>> Sagi
>> Grimberg; linux-nvme; Linux PM; Linux Kernel Mailing List; Rajat Jain
>> Subject: Re: [Regression] Commit "nvme/pci: Use host managed power state  
>> for
>> suspend" has problems
>>
>>
>> [EXTERNAL EMAIL]
>>
>> On Tue, Jul 30, 2019 at 03:45:31AM -0700, Rafael J. Wysocki wrote:
>>> So I can reproduce this problem with plain 5.3-rc1 and the patch below  
>>> fixes it.
>>>
>>> Also Mario reports that the same patch needs to be applied for his 9380  
>>> to
>> reach
>>> SLP_S0 after some additional changes under testing/review now, so here it
>> goes.
>>> [The changes mentioned above are in the pm-s2idle-testing branch in the
>>>  linux-pm.git tree at kernel.org.]
>>>
>>> ---
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> Subject: [PATCH] nvme-pci: Do not prevent PCI bus-level PM from being  
>>> used
>>>
>>> One of the modifications made by commit d916b1be94b6 ("nvme-pci: use
>>> host managed power state for suspend") was adding a pci_save_state()
>>> call to nvme_suspend() in order to prevent the PCI bus-level PM from
>>> being applied to the suspended NVMe devices, but that causes the NVMe
>>> drive (PC401 NVMe SK hynix 256GB) in my Dell XPS13 9380 to prevent
>>> the SoC from reaching package idle states deeper than PC3, which is
>>> way insufficient for system suspend.
>>>
>>> Fix this issue by removing the pci_save_state() call in question.
>>
>> I'm okay with the patch if we can get confirmation this doesn't break
>> any previously tested devices. I recall we add the pci_save_state() in
>> the first place specifically to prevent PCI D3 since that was reported
>> to break some devices' low power settings. Kai-Heng or Mario, any input
>> here?
>
> It's entirely possible that in fixing the shutdown/flush/send NVME power  
> state command
> that D3 will be OK now but it will take some time to double check across  
> the variety of disks that
> we tested before.

Just did a quick test, this patch regress SK Hynix BC501, the SoC stays at  
PC3 once the patch is applied.

Kai-Heng

>
> What's kernel policy in terms of adding a module parameter and removing  
> it later?  My gut
> reaction is I'd like to see that behind a module parameter and if we see  
> that all the disks
> are actually OK we can potentially rip it out in a future release.  Also  
> gives us a knob for easier
> wider testing outside of the 4 of us.
>
>>> Fixes: d916b1be94b6 ("nvme-pci: use host managed power state for  
>>> suspend")
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>>  drivers/nvme/host/pci.c |    8 +-------
>>>  1 file changed, 1 insertion(+), 7 deletions(-)
>>>
>>> Index: linux-pm/drivers/nvme/host/pci.c
>> ==============================================================
>> =====
>>> --- linux-pm.orig/drivers/nvme/host/pci.c
>>> +++ linux-pm/drivers/nvme/host/pci.c
>>> @@ -2897,14 +2897,8 @@ static int nvme_suspend(struct device *d
>>>  		nvme_dev_disable(ndev, true);
>>>  		ctrl->npss = 0;
>>>  		ret = 0;
>>> -		goto unfreeze;
>>>  	}
>>> -	/*
>>> -	 * A saved state prevents pci pm from generically controlling the
>>> -	 * device's power. If we're using protocol specific settings, we don't
>>> -	 * want pci interfering.
>>> -	 */
>>> -	pci_save_state(pdev);
>>> +
>>>  unfreeze:
>>>  	nvme_unfreeze(ctrl);
>>>  	return ret;


