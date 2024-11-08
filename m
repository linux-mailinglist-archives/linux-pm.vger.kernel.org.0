Return-Path: <linux-pm+bounces-17230-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7B19C260A
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 21:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C43331C21997
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 20:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9031AA1DB;
	Fri,  8 Nov 2024 20:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEmaQGka"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0771A17A5BE;
	Fri,  8 Nov 2024 20:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731096208; cv=none; b=MNn/zHXMyqa+qkYw1vPQ+ZPrvfkTLeXw79xuGbdszNPDidw2WsW1s7bqD+T3/1VybCZWc54t6JUCNK3wjdXZvpixTej/VQEI/51gviNyfd35kup1fLQBiOG9O1HTLtVfydFdtVQamb09b9wLzmozYQkI/lxuOTe24AOKiIXJ6Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731096208; c=relaxed/simple;
	bh=39ZXVOkYUevo40/LbyNDLW7yUbY/BTJ3rbRlDOBCdyI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=mwTN430Z6djB0A5RMa89lFFje89ZAjWxdpfmYR8i/fdJplJrwf+o6wD1gQNpd2X66H7SBvw9/z4rlqq7zRqooF07YLw4bGpjT599uuIZ+SggHfv3AlvgPuOC8ChUjSbhEmlwEuwWPVEAZgPo/kMklH0X730woEBPlmufe3JZxak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEmaQGka; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA0DDC4CED2;
	Fri,  8 Nov 2024 20:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731096207;
	bh=39ZXVOkYUevo40/LbyNDLW7yUbY/BTJ3rbRlDOBCdyI=;
	h=From:Date:Subject:To:Cc:From;
	b=PEmaQGka79zde/MQNV5L60eQF2TU9ZQ1TgxTn1gfnLnvr/ylZBlrjX2mzCeYyU5WY
	 NgVREdqCGUG4fyy1OscilHoZ2iIq3rphz1RiMiIz0gDDeo+2leWVpBO8Ea7mvxMdHw
	 xr98COjNBkyaF+JQX2bx4eskHMPTH7QkqZ8476ABrTDPbeCEsTkVoD362QhumT+8kv
	 QYmDmY1DyIrRpAhftJcDZW3pewDPG1mngnggL2IsWrhrogxfna9BEKQawwqMTLDWyQ
	 nac9EOtmyYsCfXlKoeWhkRuN2waU7i/JUazwrA8WpOE7G4xUSV49uGNrrUrh/Q/AFp
	 lw0YuOY9TFuzw==
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e2a97c2681so2030811a91.2;
        Fri, 08 Nov 2024 12:03:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVgmjgqY3b6M/Jd12Gi9gu6tPfLantjKeP1pL+sK5KS3pAVHIlHXyxoH3me7EDv0yilQP9i4vTa5whSUps=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6WZtaCgSItySnF72kSzph9E5+h1juW64zzQIENxhgFKhrnTqC
	lUUlKA66zTMIIB7OuNvbKzF0lU8AhmXROiptfrdkJbL0tYpH0cZframF3KbePLFLrVoweldLu4L
	0e4vMmvB7XFZb9AYyEXrV5RNOuyg=
X-Google-Smtp-Source: AGHT+IEEG+im2jr+Mad2TCq7MjI1r5xHSj/ADqT6wgUc9AwhyF2DpzJAPt0CknrZonhFZvLqHOS2SLUu+70VyKg9fFQ=
X-Received: by 2002:a17:90b:288e:b0:2d8:e524:797b with SMTP id
 98e67ed59e1d1-2e9b16aaf31mr6327832a91.18.1731096207453; Fri, 08 Nov 2024
 12:03:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 8 Nov 2024 21:03:15 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h1JmxJSeR6sOAfMhmdPLVzHx+wV4dE_HyhoqfLs9Zmvw@mail.gmail.com>
Message-ID: <CAJZ5v0h1JmxJSeR6sOAfMhmdPLVzHx+wV4dE_HyhoqfLs9Zmvw@mail.gmail.com>
Subject: [GIT PULL] Thermal control fixes for v6.12-rc7
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.12-rc7

with top-most commit 5469a8deac05391781bcd27e7c40f2c35121ca09

 Merge tag 'thermal-v6.12-rc7' of
ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux

on top of commit 59b723cd2adbac2a34fc8e12c74ae26ae45bf230

 Linux 6.12-rc6

to receive thermal control fixes for 6.12-rc7.

These fix one issue in the qcom lmh thermal driver, a DT handling
issue in the thermal core and two issues in the userspace thermal
library:

 - Allow tripless thermal zones defined in a DT to be registered in
   accordance with the thermal DT bindings (Icenowy Zheng).

 - Annotate LMH IRQs with lockdep classes to prevent lockdep from
   reporting a possible recursive locking issue that cannot really
   occur (Dmitry Baryshkov).

 - Improve the thermal library "make clean" to remove a leftover
   symbolic link created during compilation and fix the sampling
   handler invocation in that library to pass the correct pointer
   to it (Emil Dahl Juhl, zhang jiao).

Thanks!


---------------

Dmitry Baryshkov (1):
      thermal/drivers/qcom/lmh: Remove false lockdep backtrace

Emil Dahl Juhl (1):
      tools/lib/thermal: Fix sampling handler context ptr

Icenowy Zheng (1):
      thermal/of: support thermal zones w/o trips subnode

zhang jiao (1):
      tools/lib/thermal: Remove the thermal.h soft link when doing make clean

---------------

 drivers/thermal/qcom/lmh.c   |  7 +++++++
 drivers/thermal/thermal_of.c | 21 ++++++++++-----------
 tools/lib/thermal/Makefile   |  4 +++-
 tools/lib/thermal/sampling.c |  2 ++
 4 files changed, 22 insertions(+), 12 deletions(-)

