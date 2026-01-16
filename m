Return-Path: <linux-pm+bounces-41028-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A396D334A7
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 16:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57FD8309EE33
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 15:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F02C33A9FE;
	Fri, 16 Jan 2026 15:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLBNJqbJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E2B33A005
	for <linux-pm@vger.kernel.org>; Fri, 16 Jan 2026 15:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768578160; cv=none; b=gqWy6x2WgJMCTN117hYiSm8qTRFSBVJS3e0SpUib7cmHYQCAVB3UEdnuJrC1EdRRNXjD25/o1HPb/Xk4a9c/EEHqc4w5dgnHCooTWMy8jyaWsUx55YH3veDUrRPpe6FxDvwoxD4zp6dTlOHLaKIifnVG0Hj+vxiCTAOFDDma6D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768578160; c=relaxed/simple;
	bh=K7eYkw7ekQF5B0CqmA1970HwobsmbpjswWYIaAXe7eo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=nSm4LaPt0zq4OvsJUli5VzusB+Iv3EFnIUPivyKQEkpwQtt51etSSJ9b0qGhNCCRYTyVuYbMMopDlhpvEWsoqjeiusItEDB0cWVfGPvuTaRE4fQq9N+OtYDrqGRc98w6oec5nKAvDC/7Yd0Oz1hmcxHsnuHSeh/c25YkFTlQsSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLBNJqbJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD2FEC116C6
	for <linux-pm@vger.kernel.org>; Fri, 16 Jan 2026 15:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768578159;
	bh=K7eYkw7ekQF5B0CqmA1970HwobsmbpjswWYIaAXe7eo=;
	h=From:Date:Subject:To:Cc:From;
	b=JLBNJqbJxOjmBrocT1FmMm2KS2fhxAI7TajxTbLfWr3MKhl7R2zDUIisM/PN4xVTo
	 QYMzJprm+jc2WRwR/mHoZahsoOdfhyTsq/CqqCJNmlCcv+pSX4Mk1/u7mYcRgeBCKp
	 i0hs+CuINmuqyWuLzesj0keV+BVGjNChIimRdN6Yv3/UhWKo2txMeAHQ1X6lx+rDiK
	 HCHcCbE2ojvEjfP8pkd0l7kZgwLySG40ncvN+U78ySuyku31l1EhXmIwoSveXRZZiD
	 rSrxees4E9gu8lyvhPbhg/HVIF7RrRKX6q1VoRQqHySEDauwF6w2a15DdHcdjPIwVf
	 +cqu8UGbX1Cow==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6611c401aa2so390879eaf.3
        for <linux-pm@vger.kernel.org>; Fri, 16 Jan 2026 07:42:39 -0800 (PST)
X-Gm-Message-State: AOJu0YzEB+tq+b3+isEDO9OtpXtmyWvMc0/Y4TIFD4DvZZLg0x/585FI
	6d08++KoaeVP4WStYlW7Vterl/0DyzjDu3nJ0hq7W5sn+u46aYR47/ptLZZHFfVVh5toIZAJl/k
	y238xxF2u3J80RnaUsKXBwsJ60PP58RA=
X-Received: by 2002:a05:6820:1518:b0:65c:ff20:a3b5 with SMTP id
 006d021491bc7-66117a441camr1470569eaf.77.1768578158957; Fri, 16 Jan 2026
 07:42:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 16 Jan 2026 16:42:27 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j6om=j8nB-YcuRN1=cCFeWB1DriOKwkGsRav6+bRJo0w@mail.gmail.com>
X-Gm-Features: AZwV_QjAAl3gYFQQHOmEcf2n3lHmPI1j_zFXD9U_m1BxtWTvvC6fL0A6qxcwOZ0
Message-ID: <CAJZ5v0j6om=j8nB-YcuRN1=cCFeWB1DriOKwkGsRav6+bRJo0w@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v6.19-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.19-rc6

with top-most commit d51e68b7007b9c1c3456c4f93657a153ae3816ec

 Merge branch 'pm-em'

on top of commit 0f61b1860cc3f52aef9036d7235ed1f017632193

 Linux 6.19-rc5

to receive power management fixes for 6.19-rc6.

These fix an error path memory leak in the energy model management code,
fix a kerneldoc comment in it, and fix and revamp the energy model YNL
specification added recently along with the new energy model management
netlink interface (that received feedback after being added):

 - Fix a memory leak in em_create_pd() error path (Malaya Kumar Rout)

 - Fix stale description of the cost field in struct em_perf_state to
   reflect the current code (Yaxiong Tian)

 - Fix and revamp the energy model YNL specification added recently
   along with the energy model netlink interface (Changwoo Min)

Thanks!


---------------

Changwoo Min (4):
      PM: EM: Fix yamllint warnings in the EM YNL spec
      PM: EM: Rename em.yaml to dev-energymodel.yaml
      PM: EM: Change cpus' type from string to u64 array in the EM YNL spec
      PM: EM: Add dump to get-perf-domains in the EM YNL spec

Malaya Kumar Rout (1):
      PM: EM: Fix memory leak in em_create_pd() error path

Yaxiong Tian (1):
      PM: EM: Fix incorrect description of the cost field in struct
em_perf_state

---------------

 Documentation/netlink/specs/dev-energymodel.yaml | 175 +++++++++++++++++++
 Documentation/netlink/specs/em.yaml              | 113 ------------
 MAINTAINERS                                      |   8 +-
 include/linux/energy_model.h                     |   2 +-
 include/uapi/linux/dev_energymodel.h             |  82 +++++++++
 include/uapi/linux/energy_model.h                |  63 -------
 kernel/power/em_netlink.c                        | 213 +++++++++++++++--------
 kernel/power/em_netlink_autogen.c                |  58 +++---
 kernel/power/em_netlink_autogen.h                |  22 ++-
 kernel/power/energy_model.c                      |   6 +-
 10 files changed, 454 insertions(+), 288 deletions(-)

