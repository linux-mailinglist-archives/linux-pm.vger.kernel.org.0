Return-Path: <linux-pm+bounces-24467-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C825FA6DFCC
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 17:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E1A616A1C8
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 16:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CFD263C61;
	Mon, 24 Mar 2025 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hj4TQceS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C7E262813;
	Mon, 24 Mar 2025 16:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742834049; cv=none; b=u3a8+qxX9T03hUbxcJpcquGow1CdXLehWdSQOVXNIFaGyfkRQP+JW3oUH63azj17YE9IeSO9AE1H8mMTJPBIu1zP8D2hXCv2fHiEAdDE9AhSK81mvgOg+Pq97vV7cpzYb/EVouVKY6q+dyWXgWIhtTUUWoYUmKUulpkWdFEiQyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742834049; c=relaxed/simple;
	bh=8qLB9SM0hc2FsPLkO+65ZIoeHiOYJktBA/bREXtxV1M=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Ju3l40dbmw42RZWEDzI7UcmuR9hKdVi1nUjkC2z1z0Jrn+PN253AMGbkPoO9AWy1VTVfHH/EKrpsAwUVyyE2nlrsGkpVa763glz3r/FtYWpEv4lqhDo0V80O7Kacog3Zo0CH7Er5LxvHSzULR4hZN7F3gutC0LFPp/W5PyR/xP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hj4TQceS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD84C4CEE9;
	Mon, 24 Mar 2025 16:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742834048;
	bh=8qLB9SM0hc2FsPLkO+65ZIoeHiOYJktBA/bREXtxV1M=;
	h=From:Date:Subject:To:Cc:From;
	b=Hj4TQceSsHwL3g7YGEIDvICbdBZ0Icq5qScIb0g9cdRQP8J2qK41tI/zBmgZK1zGg
	 wsrAraoT81h5XdK51gHQEzU82PUImCakjgJAmnaWXRvH7Bro/4loiGnlVk/Pmdpw7p
	 IJah9tWljUbyH0cVbJbEsgasltgRttkegGWxhih9ej+BLt7rBtG5FPte6bfTA7Z0y6
	 9asfRQqkbvAJqQj0MOcgI1dPvYHX9euL5KLuZ6UH61SxRk6eeZHI01NWBfIaUojKjP
	 uKWSxUkgC47gYKDBSiIK+XEBP1JzJIFJovpFvVxYtISY3Gzo4AY3/e8kx1/gaHwhzc
	 +n/R4c1n4OheQ==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-601b1132110so2553621eaf.3;
        Mon, 24 Mar 2025 09:34:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWNNzY0yyFYTKby7M+cxApipevgPGhTs2iyOtx/UaVy5MgHvTb0OwX0+gYMTDvKMrW6v+u2+aE+3Yu+5/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0meabJIUFononUxe39BVHZmGZcyFUeenEJ+8FiNB/WLxLAw6q
	qWfkV1UeNZU8gzZxdII+0/ENMbOl+m19/KRx7VQRQaZLyiqXs7Mpz8iYbP2NYyFg/4S5jd2O0Wl
	cPBiDstSI6VLOx4DZPcVS2TJNj88=
X-Google-Smtp-Source: AGHT+IGh8sus7rKNjTBAYdjpUdits4FXboHBG3r5faLHiwW7a0qSSqCJSJ6lPB7mzBP2Pqx2W7gGQEpqfZSHmsjYrrw=
X-Received: by 2002:a05:6871:81e:b0:29e:1325:760a with SMTP id
 586e51a60fabf-2c780243b17mr8772375fac.8.1742834047515; Mon, 24 Mar 2025
 09:34:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 24 Mar 2025 17:33:56 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gsHdE+Mt+8vMbUJMRuTUdiBTnUTonaGM_41EpPt9wS5g@mail.gmail.com>
X-Gm-Features: AQ5f1JoQ0t8sroDIYNXVZr0PH4FgsEvo023Bn6B2NZACfnn8rbTuM_1b8hKcKe0
Message-ID: <CAJZ5v0gsHdE+Mt+8vMbUJMRuTUdiBTnUTonaGM_41EpPt9wS5g@mail.gmail.com>
Subject: [GIT PULL] Thermal control updates for v6.15-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.15-rc1

with top-most commit c3b659b74541f4564f9f5a39f65e625c47e77e21

 Merge branches 'thermal-core' and 'thermal-misc'

on top of commit 80e54e84911a923c40d7bee33a34c1b4be148d7a

 Linux 6.14-rc6

to receive thermal control updates for 6.15-rc1.

These include one thermal core fix for an issue leading to a NULL
pointer dereference, a similar fix for the int340x thermal driver (even
though the issue may not actually occur in practice in this particular
case), and a bunch of cleanups, mostly related to replacing kzalloc()
with kcalloc() where applicable:

 - Delay exposing thermal zone sysfs interface to prevent user space
   from accessing thermal zones that have not been completely
   initialized yet (Lucas De Marchi).

 - Check a pointer against NULL early in int3402_thermal_probe() to
   avoid a potential NULL pointer dereference (Chenyuan Yang).

 - Use kcalloc() instead of kzalloc() in some places in the thermal
   control subsystem (Lukasz Luba, Ethan Carter Edwards).

 - Fix a spelling mistake in a comment in the thermal core (Colin Ian
   King).

 - Clean up variable initialization in int340x_thermal_zone_add()
   (Christophe JAILLET).

Thanks!


---------------

Chenyuan Yang (1):
      thermal: int340x: Add NULL check for adev

Christophe JAILLET (1):
      thermal: intel: Clean up zone_trips[] initialization in
int340x_thermal_zone_add()

Colin Ian King (1):
      thermal: core: Fix spelling mistake "Occurences" -> "Occurrences"

Ethan Carter Edwards (1):
      thermal/debugfs: replace kzalloc() with kcalloc() in
thermal_debug_tz_add()

Lucas De Marchi (1):
      thermal: core: Delay exposing sysfs interface

Lukasz Luba (4):
      thermal/of: Use kcalloc() instead of kzalloc() with multiplication
      thermal: k3_j72xx_bandgap: Use kcalloc() instead of kzalloc()
      thermal: int340x: Use kcalloc() instead of kzalloc() with multiplication
      thermal: hisi: Use kcalloc() instead of kzalloc() with multiplication

---------------

 drivers/thermal/hisi_thermal.c                       |  4 ++--
 .../thermal/intel/int340x_thermal/int3402_thermal.c  |  3 +++
 .../intel/int340x_thermal/int340x_thermal_zone.c     |  6 +++---
 drivers/thermal/k3_j72xx_bandgap.c                   |  4 ++--
 drivers/thermal/thermal_core.c                       | 20 ++++++++++----------
 drivers/thermal/thermal_debugfs.c                    |  4 ++--
 drivers/thermal/thermal_of.c                         |  2 +-
 7 files changed, 23 insertions(+), 20 deletions(-)

