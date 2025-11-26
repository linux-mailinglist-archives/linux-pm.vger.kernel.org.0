Return-Path: <linux-pm+bounces-38704-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A397FC89DED
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 13:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DC893A8C40
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 12:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF5A328B40;
	Wed, 26 Nov 2025 12:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JngBKuv6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB68328251
	for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 12:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764161675; cv=none; b=N3nUHDZv5b5/PiZfzrpIKdYopkaX8G0+koK7QzXhs6ZHVM01LuRYpElm+Fnw3d5x9qJf3M+SDLYHSK2OTOeq5wppDwlflrvDg3gPFRghZq1lvNkmntJgFWfCK9vZfaVGasNVdREOqmcq33tHB96zv3+1ty2pYeGrSc8aObft+Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764161675; c=relaxed/simple;
	bh=906uSaW+hNrl4mjuQuq3qwvQ5iYqcjyFvx5atEfrYfk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=GOfmdYNgjjUrf7UQNW2bQV2du0vSvSoUyb/1PBM8w9GAob0ACxL0hmlBJ7dDyT4ewSedxrJ80hQehbHcQVKkIhECNpg/7sBqGrwdlDKUMFVcKrlnX7NIdlHJX/lUhst5oAkqJ4oIWf9xP/ZuzJFgZ3aApRGbed3cKMehyIxw1Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JngBKuv6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A10C116C6
	for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 12:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764161675;
	bh=906uSaW+hNrl4mjuQuq3qwvQ5iYqcjyFvx5atEfrYfk=;
	h=From:Date:Subject:To:Cc:From;
	b=JngBKuv6xVmP+eTCVGwaA2vUbaynxSQ1xo0izme62RpMvIwaQaG2bgvZVv8zOF4U1
	 J0qRs20dnuKzDigBdgphrK33HQ9mVoaqZdm23O8rZwyCAoUn/zsq+qYBbTMtMaFJNe
	 Xi0J1vDVN8YpmUdZd0A+7NEHCAPWpO5H8EJp2hGZ76tVPnDgDAZOt5F+PORcL9Hkjo
	 40yNgMaWqKkPGcb3mWS/fiQeSlvxZqygeiAF5cvxshYcQu5EiI/pLqebkvnOVHkGwj
	 RkYGKxzCP/JrNUHra0OK0T+KtZ8qFVrmcBrOg9DbZJ4vw7Ir8hnQxmjug3KUFgbKmB
	 1E1Nw59k/A6Ig==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6574de1cda1so2626667eaf.3
        for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 04:54:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVtIA/nPRaaddPFfih2PHlLOvrQe9jXDFUp+RVrmAm+M1Kpeuo/xCYcBA3i9B2F7UtsfetF3Ec+4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw92USPn9ULlHRmUhE3s2B6t++gG2BNmQLKTz/hF2NwXzgdV0nR
	YqIGFjHIwPPZ6L+TL4GSkbk16e9ApyUW/WTG9wQ9QPW3pZ/dUYB0wP2XzIRljNzxSX/YRgSlFmn
	zeq8IDTY84ie2dUSHaVjnCzMXJoJPx+I=
X-Google-Smtp-Source: AGHT+IHpg2fKWULpdy3I30LPDJtfMpLOQjHplNcYURc8E63EG9lpKixxTl1yrHKZoJKG6tA64bGEzY3SwM9aomiiAiQ=
X-Received: by 2002:a05:6820:188e:b0:650:73:b922 with SMTP id
 006d021491bc7-657bdba56dbmr2527788eaf.6.1764161674730; Wed, 26 Nov 2025
 04:54:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 26 Nov 2025 13:54:24 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g6c1HNbxxh088xh_nTgD-SE6c2qtDr81AgD1+by-jnKA@mail.gmail.com>
X-Gm-Features: AWmQ_bl4Y6SZK4RBxbvx3EgK7bKtAtyXDZHzbQemCiZyocUfM8lJLcQC7Xh3KPA
Message-ID: <CAJZ5v0g6c1HNbxxh088xh_nTgD-SE6c2qtDr81AgD1+by-jnKA@mail.gmail.com>
Subject: [GIT PULL] Urgent ACPI support fix for v6.18
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.18-rc8

with top-most commit 43ff36c4a5a574ee83b4b0d3f3d74f09a3a8c2d3

 Revert "ACPI: processor: idle: Optimize ACPI idle driver registration"

on top of commit ac3fd01e4c1efce8f2c054cdeb2ddd2fc0fb150d

 Linux 6.18-rc7

to receive an urgent ACPI support fix for 6.18.

This reverts a commit that attempted to make the code in the ACPI
processor driver more straightforward, but it turned out to cause
the kernel to crash on at least one system, along with some further
cleanups on top of it.

Thanks!


---------------

Rafael J. Wysocki (5):
      Revert "ACPI: processor: Do not expose global variable acpi_idle_driver"
      Revert "ACPI: processor: idle: Redefine two functions as void"
      Revert "ACPI: processor: idle: Rearrange declarations in header file"
      Revert "ACPI: processor: Remove unused empty stubs of some functions"
      Revert "ACPI: processor: idle: Optimize ACPI idle driver registration"

---------------

 drivers/acpi/processor_driver.c |   6 +--
 drivers/acpi/processor_idle.c   | 115 ++++++++++++++++------------------------
 include/acpi/processor.h        |  34 +++++++++---
 3 files changed, 76 insertions(+), 79 deletions(-)

