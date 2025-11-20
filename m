Return-Path: <linux-pm+bounces-38316-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB58C75BEA
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 18:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DE4C04E792A
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 17:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DDB36D514;
	Thu, 20 Nov 2025 17:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4WWQ6mc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11CE36D511
	for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 17:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763659591; cv=none; b=Tbz3EBlQ8DoXtu4vdkKVevac4TJ3wySkYlGU+4dGN1nTkDxPDdg1P7WowNo3cTboMmM299P160Z6KPpVyEKsezYhYOZe2k7zdwXtN7BvrNEi1uQh6CnW1ejZEa1QE41FNH9PFMOlPu3zdFccGnvpJkU8/7QXLOTAFqfF5vfRMLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763659591; c=relaxed/simple;
	bh=vUr/rozEgXCn+qMQ9kPLWmGvdKJiig8T2+nVhma/Dpk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=VT5qXp5BYAkYzE8AWLu99BY/t5C+sPgg1wBBuZG1w4J8+kXtpwTUN8hS+bP18cfcHDml2fMmUbk674vtSkLbvKiJNnXDMyF92tEhWGWeVtuswF8L2zoap9oxqxNZBbQY5rUFQIa+Gw3XkzJU83/IBKKafIG3ZRPrHmCJ5f+7qzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4WWQ6mc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E7CC4CEF1
	for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 17:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763659591;
	bh=vUr/rozEgXCn+qMQ9kPLWmGvdKJiig8T2+nVhma/Dpk=;
	h=From:Date:Subject:To:Cc:From;
	b=F4WWQ6mcy1h4Y1vR3FnjtCvOnCXKNqf+vIdoeTGyQ4G0eo3mKVmWKMYZUSoGJ+NT8
	 X09Ld9x5q/oeAvWVa+YZF3PFalhONHuFMQ+PDdW1g6OIlMHghKW9jNFxXGWeoAFT4L
	 Bof18NDkj6m56i9fOUy62dJML5DzBCCmlBo6l6b9GY/dFTQJG66gSewX+HUnD2GOvQ
	 R+FHiDrjqQSehVhkuzPAPHsWc2sR5BapvzWLvi1jU/VfLskfEpIvNqqcW2gurjc38f
	 AZm1NVBc8PPZAQCxa3U0MWtETFwmpz394/JOKs27sI8tv11Rj0mrQUQ9WH11Cp9xni
	 vYF57437bO4Aw==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-656de56ce7aso239679eaf.3
        for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 09:26:31 -0800 (PST)
X-Gm-Message-State: AOJu0YzX2cfRm1ekTswutrP5aC9iecUuKCmDAJJ6rRJUQgwfOsZCk66d
	Pw9OBC4o8pJ5u2C1eu/6NE92gpQ2bEzpohmWSP/9GLl873fidbE1pNpWVnXzHhMcPheqmvRNeQH
	ATuQ0G/F60/pqQTLzC/rq58q4vxQdohw=
X-Google-Smtp-Source: AGHT+IEiLGnPmO/d7KPRvYcFeQ04iDdR6BF7/kpFoKNaGJs+D/9tF3THdP/sDuVNhq578ykklmyGatZ8ue0cJwbB+DQ=
X-Received: by 2002:a05:6820:228c:b0:657:17a5:b314 with SMTP id
 006d021491bc7-65782773e0fmr1617619eaf.0.1763659591098; Thu, 20 Nov 2025
 09:26:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 20 Nov 2025 18:26:20 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jXFO_vQUz6E1LsKdR84NfCb-+nLjGzpJ8sZmt_QcP0Zw@mail.gmail.com>
X-Gm-Features: AWmQ_blMDjkbttaYWIiVRjUcA5hwUssS-8Uob9NX0mENnLSV1fyiJl2pqY8DeRA
Message-ID: <CAJZ5v0jXFO_vQUz6E1LsKdR84NfCb-+nLjGzpJ8sZmt_QcP0Zw@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v6.18-rc7
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.18-rc7

with top-most commit f384497a76ed9539f70f6e8fe81a193441c943d2

 PM: sleep: core: Fix runtime PM enabling in device_resume_early()

on top of commit 6a23ae0a96a600d1d12557add110e0bb6e32730c

 Linux 6.18-rc6

to receive a power management fix for 6.18-rc7.

This fixes a regression introduced during the 6.16 development cycle
that may cause runtime PM to be enabled by mistake for devices that
do not support it (which may lead to some serious trouble) if there
is a system wakeup event during the "late suspend" phase of system
suspend.

Thanks!


---------------

Rafael J. Wysocki (1):
      PM: sleep: core: Fix runtime PM enabling in device_resume_early()

---------------

 drivers/base/power/main.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

