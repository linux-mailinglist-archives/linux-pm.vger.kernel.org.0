Return-Path: <linux-pm+bounces-39677-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3415ECCD749
	for <lists+linux-pm@lfdr.de>; Thu, 18 Dec 2025 21:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33E43302D2AF
	for <lists+linux-pm@lfdr.de>; Thu, 18 Dec 2025 20:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B865284888;
	Thu, 18 Dec 2025 20:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PS+IZ7td"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F2C2566E9
	for <linux-pm@vger.kernel.org>; Thu, 18 Dec 2025 20:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088142; cv=none; b=CQYjGHj3gtwqx6/1Rqf/D89pq704VDt+71Ag8vLW/01u+5z4eDYh3Se/3P68mqh4UbzIIk+pY9uxy+89I+uTQMtvS6Jtwf2x66xAPJi8GnFJbs6qnin1MucHukG9mXWAgMz8U1yh/t7GVCNqwIa3wWPhXhEPEywEF10j1oViHzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088142; c=relaxed/simple;
	bh=LoV9n09547otchgzCjUNnOCwjdyV8TMJRDfIn3TWvX0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=s7Jjs51AgQn8K4d2S2CxpAgMmNDTui2lq9IYrQsDsBWANWJHyLF1p4ZeYSsc+fq4Opbm27jgTdGZbN/nB7TzwSfNrprNV3WAQGu+I1h2weRl3kBz6SSOohBecY33GeR4HxwTxIkt9syA3daEbhqay7BpZVVn7rh8QR0kHoSG55Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PS+IZ7td; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE076C19421
	for <linux-pm@vger.kernel.org>; Thu, 18 Dec 2025 20:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766088141;
	bh=LoV9n09547otchgzCjUNnOCwjdyV8TMJRDfIn3TWvX0=;
	h=From:Date:Subject:To:Cc:From;
	b=PS+IZ7td0J9zUoog1v/on3un/N4kF+lEbIbNfYjMYRaRKQZUoRp07ImTTeYM7o0sW
	 J1djby9KQBtWWyX04s8uSD9O5GrNNGWSZZhRLHvIAvxIBV9qhYXUa9gMK+wC/zKFlL
	 A2aztBWHRMn7Dw8iGGUWr5nqJ2Cymnk3SvuETdz+scMxYwSjLthMaRtaVEoru+l2UP
	 fi2S7yEKnX6gMxGSd01qVV1jhGYgyVKREax2HHiCrjSoiYQ9kY1FDGVCoLrjK/BeHR
	 KWW7/wslRswhqrW+xlIW1DJ9iScgnn6vGH1m68k076xr3FzJapobYoxqdbTZsJNWjP
	 rm8QaUjxSTrYg==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-3f5c9275b31so646453fac.0
        for <linux-pm@vger.kernel.org>; Thu, 18 Dec 2025 12:02:21 -0800 (PST)
X-Gm-Message-State: AOJu0YyP2zI04hLbYcF1otTfu//r8m+VaLyArPVkvFm3FmOmtTwQzaiB
	P2VXHa/ScTLfi1GJSpDObmojoqNub8a+Gvd+cVs4R8WM3mOGHRWx2rBFiwgzF4x5iwfH6PloUlO
	NkrzziUF6hSGrKsHkdIQPd5AILKEOrSE=
X-Google-Smtp-Source: AGHT+IEpxp0y++VcKCeG/tqDuMqcMAGFNWXXNW6f9/825jGZWHLSA+knHe7V/WUngeFPYNNRfh/oXT0UiMzNhNR/hjo=
X-Received: by 2002:a05:6820:162a:b0:65d:363:b874 with SMTP id
 006d021491bc7-65d0ea9708emr334338eaf.32.1766088140965; Thu, 18 Dec 2025
 12:02:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 18 Dec 2025 21:02:09 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0go6vKUdZmwAqafyr5LrSGhgGpvfq_whp=KEOvmEp9-HA@mail.gmail.com>
X-Gm-Features: AQt7F2qWsdrq88lkrfp7q4Tls1p09bcXmMt_iV88ZHceKegoIvw72LBBrpkgrYE
Message-ID: <CAJZ5v0go6vKUdZmwAqafyr5LrSGhgGpvfq_whp=KEOvmEp9-HA@mail.gmail.com>
Subject: [GIT PULL] Thermal control updates for v6.19-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.19-rc2

with top-most commit d113735421da322ea144c9778c433de6ff6bc57b

 thermal: core: Fix typo and indentation in comments

on top of commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8

 Linux 6.19-rc1

to receive thermal control updates for 6.19-rc2.

These enable a new hardware feature in the int340x thermal driver
and fix up comments in the thermal core code:

 - Set a feature flag in the int340x thermal driver to enable the
   power slider interface for Wildcat Lake processors (Srinivas
   Pandruvada)

 - Fix typo and indentation in comments in the thermal core (Thorsten
   Blum)

Thanks!


---------------

Srinivas Pandruvada (1):
      thermal: intel: int340x: Enable power slider interface for Wildcat Lake

Thorsten Blum (1):
      thermal: core: Fix typo and indentation in comments

---------------

 drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c | 3 ++-
 drivers/thermal/thermal_core.c                                       | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

