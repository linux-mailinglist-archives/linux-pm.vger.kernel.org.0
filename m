Return-Path: <linux-pm+bounces-13253-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1564966778
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 19:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F7A0286740
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 17:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75121B78E8;
	Fri, 30 Aug 2024 16:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QMjm5CBp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0F414B949;
	Fri, 30 Aug 2024 16:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725037197; cv=none; b=lmpAiaF1g7QIWnfGGgnXnYcj96TN1Ep+kmYfWYrYL9kYWx0GcA1+shSYd8zxNS8VkPmBha35l+LcsrXL4Bx30FKR5nw6drwMpeNclVSzpyrXyCfAAQukebNlrL9WuHuMnwKQhgYj9TjPmuo8UeiPLdXM23YZkvGRDwhsNIshCgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725037197; c=relaxed/simple;
	bh=iCAno9zKKmr9OKEmLyF210InA2Ix20hKWzsnvrOaOp8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=MCrTAZq+99PvEFQ0Cp8PFkrt3l0DrQ9ScDt0V29YejzLWUitZVU+a1bRpCy3D03Shr/7EgaHj4LUS+pYWntXUsBnAzccrh8XACozi1/2twE1LG5zpfcu3xMHZNeAy4V4F6AVk3Iu62L52I4WnuG8cwro2DYRcr7n6tSX2zYzQus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QMjm5CBp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E09C4CEC2;
	Fri, 30 Aug 2024 16:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725037197;
	bh=iCAno9zKKmr9OKEmLyF210InA2Ix20hKWzsnvrOaOp8=;
	h=From:Date:Subject:To:Cc:From;
	b=QMjm5CBpzvHryKnJPc3t1UC/B6beO/Nb0FU3Ev+C9K10OYhxUaa5qTJBMsak1FwLf
	 YN591tgpLAVUXfCzS4Av49QTu3ksvtyxyaHG5d1/sC/WYnha2ne3o0oINaBm6u/+C5
	 olTcAQo8tf77OQQN02co7dJIx3xm6XoZMO9SA60+Fd/WnXTHZaMXrsw062vQA7hil3
	 OcjTJKCluTul0s/XVbuF44t2A8P/WTFPT/pXcMfAwuT6s3IOBCGTqWJHp8AS4h9N7a
	 SQuJkqt5X0D0FkW0b9SczM5VU+XyY2dtOmAFVRm0Bg4OSpFVJfXZJ69vSm6Z76V5zM
	 nWmB43qO+ZYUA==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5d5c7f24372so1247937eaf.0;
        Fri, 30 Aug 2024 09:59:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVsj4SyPbaXmuMqfLd6QUiTYt4zweRyxHgjhNp5qn9nQv9e53bAE9fxe++zHKJ50oeufHERw0G6NjOEusU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQYewauxDaFC8fsEloFQ+Qd8PUV/x0EwqZKQo2ixwDUNO5IR58
	E/LZ/6/gyhjyCvJuoY4s8fCJuPFAo52AJgk5gw5fRIe++XTlGPdCdvb/8mUGT2Ao8Sb7riO0Ctx
	G1CpGp6uuMVeerAxwOxgSysQ6Tl8=
X-Google-Smtp-Source: AGHT+IFnKj83QEpCKgIcPCaFzoruLV6127fiWgAoiQvl65S5hL03T+/Y/IlfJbWbOXirpWPY+2upehtXhbErzU+EP3s=
X-Received: by 2002:a05:6820:2292:b0:5c6:9293:ed8a with SMTP id
 006d021491bc7-5dfacfb1542mr3595546eaf.6.1725037196442; Fri, 30 Aug 2024
 09:59:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 30 Aug 2024 18:59:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jOgpgotLwOMyhURMcfWvAP4rWtWxNbFohqwyEzCJGSSA@mail.gmail.com>
Message-ID: <CAJZ5v0jOgpgotLwOMyhURMcfWvAP4rWtWxNbFohqwyEzCJGSSA@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v6.11-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.11-rc6

with top-most commit 15d75184a86fdd8ba56e17606c3088ac60150ab3

 Merge tag 'amd-pstate-v6.11-2024-08-26' of
ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux

on top of commit 5be63fc19fcaa4c236b307420483578a56986a37

 Linux 6.11-rc5

to receive power management fixes for 6.11-rc6.

These fix three issues in the amd-pstate cpufreq driver.

Specifics:

 - Remove checks for highest performance match on preferred cores when
   updating preferred core ranking in amd-pstate (Mario Limonciello).

 - Make amd-pstate call topology_logical_package_id() instead of
   logical_die_id() to get a socked ID for a CPU (Gautham Shenoy).

 - Fix uninitialized variable in amd_pstate_cpu_boost_update() (Dan
   Carpenter).

Thanks!


---------------

Dan Carpenter (1):
      cpufreq: amd-pstate: Fix uninitialized variable in
amd_pstate_cpu_boost_update()

Gautham R. Shenoy (1):
      cpufreq/amd-pstate: Use topology_logical_package_id() instead of
logical_die_id()

Mario Limonciello (1):
      cpufreq/amd-pstate-ut: Don't check for highest perf matching on prefcore

---------------

 drivers/cpufreq/amd-pstate-ut.c | 13 ++++++++-----
 drivers/cpufreq/amd-pstate.c    |  4 ++--
 2 files changed, 10 insertions(+), 7 deletions(-)

