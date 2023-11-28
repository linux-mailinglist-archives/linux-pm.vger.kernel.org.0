Return-Path: <linux-pm+bounces-356-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D453E7FBAF3
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 14:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62BD92829A8
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 13:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A308956471;
	Tue, 28 Nov 2023 13:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sb8tDrPA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE1018F;
	Tue, 28 Nov 2023 05:09:32 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6cd8579096eso2470075b3a.0;
        Tue, 28 Nov 2023 05:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701176971; x=1701781771; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8wlpDIqNbi5vLnzI15P5Lxtzc5A7rbfuNGTA7aBUUY=;
        b=Sb8tDrPA8DBgYB0dKyHp11lUOoXpgEz1ui40G+cq8SBckQa0Vysa064Oq5N2VdBf1J
         8nMk4+F1dxOl5qN270ruv0UUDBVdVwJIzVuu0NVGie7D35KRhaIuS9AeGyMLYo4jCLGJ
         SiAZDRBCooLee55e1Iz1oi1uR3mD1Wuf+V1VZSN47n5Lol+7N0rbNmLR3/61xPCXQM+S
         3iy3E9xtOmTqHQrJ4ZR8N+pwZraPjE3E1pnbeml5RoN8VgxjJQDSM4g0XhrdLJLOZmWH
         VTA7O8EyHYLcLuy5gAq1sPvOWqGGDGbrBZnnr+4HKAUHtLAbJ1oYWtsvuURLsgSWAGNG
         5r1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701176971; x=1701781771;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A8wlpDIqNbi5vLnzI15P5Lxtzc5A7rbfuNGTA7aBUUY=;
        b=tCxusN9+m7LntvfI7SJv09tBEYmXDjMwrNhDWGKsJmHd2LX3cKDex6Nk6Fg53/6mv1
         67XqWLmzJi8eFk36pkLz4Ow7jR2a8bGJTdzPHEQEhse3H/lqj4Z1eNjBTbNweeOBjgW1
         4VEb/jLeuK7jAIZT0brQlOhjfH5bxhCStD2f0sZC46X4VM3RBKnJaYZ32ZTt4waqNEsk
         RG7IP1Geap0ofryNhkO6YKHXvM6ap13f6kESHWU/z8OM2inHSDPRBuv/FGW85TQaoB4N
         3L2T6ZCiEOsFnAT5lM4/53Sv9fJPHUN214+A0cAqXTy0C+QWCPO3J7ljctooNrqhQMdk
         ZzBg==
X-Gm-Message-State: AOJu0Yz72veqzLfW6FeJltM7Oz2m+B97F/3Z8qHos62Yk5+oxdcn2tql
	jpA3jPLvMfS/MEKW8HZocCXRZOYxKHihGQ==
X-Google-Smtp-Source: AGHT+IFPqMtwLgpXsxzmkLwbwnT2E+yfl9IJPiQNoF7hcNQN73mIlZ/wQyvyYleB711N0rjXyFYIxQ==
X-Received: by 2002:a05:6a00:3909:b0:6be:130a:22a0 with SMTP id fh9-20020a056a00390900b006be130a22a0mr16638210pfb.14.1701176971167;
        Tue, 28 Nov 2023 05:09:31 -0800 (PST)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id s6-20020aa78d46000000b006cbb5f2cbe0sm8768749pfe.102.2023.11.28.05.09.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 05:09:30 -0800 (PST)
Message-ID: <4b3c624a-f114-4e39-9e1c-0df18f307e8c@gmail.com>
Date: Tue, 28 Nov 2023 20:09:24 +0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 Linux IOMMU <iommu@lists.linux.dev>,
 Linux Power Management <linux-pm@vger.kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Lu Baolu
 <baolu.lu@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 kbugreports@proton.me
From: Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: Kernels v6.5 and v6.6 break resume from standby (s3) on some
 Intel systems if VT-d is enabled
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> Note:
> 
> I'm just a Linux user, I don't work in IT or even write code, so, I'm probably using terms to describe the issue that are not the ones someone who knows code and what the system does under the hood would use.
> 
> Affected system:
> 
> Thinkpad, Intel Kaby Lake (i7-7600U) chipset / cpu and onboard gpu (Intel HD 620), no separate graphics card, current bios firmware; running Void Linux, xfce / lightdm
> 
> Symptom / problem:
> 
> Since the upgrade to kernel v6.5.5 (from v6.3.13) my system doesn't wake up from standby, i.e. resume from s3 fails 100% of the time.
> When pressing a key or the power button nothing happens. The LED that indicates different states of the system, keeps indicating standby mode.
> The only way to use the system again is hard reset by pressing the power button for a few seconds.
> 
> So, there is no crashing on resume or incomplete resume or only sometimes failing to resume or failing to go into standby in the first place.
> 
> Granted, this issue was present with kernels before v6.5, but only occasionally and it would not re-appear for many many boot cycles. So, I never had any lead as to why it would happen.
> 
> I installed kernel v6.4.16 to test for the bug - it's not in there.
> 
> For further testing I also installed kernel v6.5.2, as this was the first kernel of the 6.5 series available on void linux, (and because the kernel logs mention VT-d for kernel v6.5.5 and v6.5.3, see below). Result: The bug is already in v6.5.2, too.
> 
> There's only one thing I noticed from comparing logs between kernels v6.5/6.6 vs v6.1/6.3/6.4. In the moment the system goes into standby, if running one of the latter three kernel versions the system would print the following messages:
> 
> [elogind-daemon] Entering sleep state 'suspend'...
> [kernel] PM: suspend entry (deep)
> 
> 
> But with kernels v6.5/6.6, the kernel message is missing, only the elogind-daemon message shows up in the logs. As if the kernel didn't get the memo and thus didn't prepare and didn't listen for the wake-up call to resume.
> 
> 
> To see, if this is a bug that might be tight to a certain chipset / cpu generation, I tested kernel v6.5 on my old Thinkpad (Intel Sandy Bridge chipset / cpu, and also onboard graphics only). Its BIOS also has VT-d enabled. Interestingly, on that system, resume from standby with kernel v6.5 is no problem, even though its system is set up the same as the current Thinkpad.
> 
> So, this bug seems to be limited to certain set of chipset / cpu. Which seems feasible, as I couldn't find a bug report on this - not too many seem to be affected.
> 
> 
> 
> There's an older bug report on similar symptoms, but the cure doesn't work on my system:
> 
> "intel_iommu=on breaks resume from suspend on several Thinkpad models"
> https://bugzilla.kernel.org/show_bug.cgi?id=197029
> 
> 
> Although it sounds just like what my system is experiencing - apart from the fact that term suspend being sometimes also used to describe hibernation and it is not specified which one is meant in the bug report.
> 
> So, I was hopeful on the one hand that the (workaround) fix (adding intel_iommu=off to the kernel parameters) would work on my system, too - on the other hand, this bug report was for kernel v4.13, so it's probably not necessarily relevant to similar symptoms with kernel v6.5 and v6.6, respectively.
> 
> Anyway, adding intel_iommu=off to the kernel parameters didn't change anything on my system. I made, of course, sure once the system was running, that intel_iommu=off was in indeed used as one of the kernel parameters.
> 
> 
> With this information in mind I did a regular internet search and found some information that in case intel_iommu=off in the kernel parameters doesn't help, disabling VT-d in BIOS might.
> And in my case it does indeed help avoiding the bug - for both kernel versions, v6.5 and v6.6.
> 
> Reading some other bug reports and some changelogs, I noticed that iommu and vt-s are connected, to I posted this bug report in drivers/iommu. If it is misplaced here, please feel free to move it to the correct category.
> 
> 
> I attached a file with the output of some commands I found being used in several other bug reports on here, just in case they might be needed / helpful.
> 
> 
> Thank you very much for your help in advance!

See Bugzilla for the full thread.

Anyway, I'm adding this regression to regzbot:

#regzbot introduced: v6.3..v6.5 https://bugzilla.kernel.org/show_bug.cgi?id=218191
#regzbot title: resume from standby fails on Thinkpad with Kaby Lake CPU

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=218191

-- 
An old man doll... just what I always wanted! - Clara

