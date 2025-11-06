Return-Path: <linux-pm+bounces-37567-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDD4C3D7F3
	for <lists+linux-pm@lfdr.de>; Thu, 06 Nov 2025 22:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B19A4E2938
	for <lists+linux-pm@lfdr.de>; Thu,  6 Nov 2025 21:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7289B306B39;
	Thu,  6 Nov 2025 21:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J09Eadt7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC5E305056
	for <linux-pm@vger.kernel.org>; Thu,  6 Nov 2025 21:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762464486; cv=none; b=SgVGLGqaax51a3qjzCWLVAPwkgYOBw3pQSkviQEnzAuTDH+trDgczUgGZBoowCo1BNwwWnhNiV7ZpVXN9Dm7Y14t3T8p0+hZg+HxmPLND6JDQi+JZW00c73sHlx0ajXzXUDTgpJBihqyrvF+87SvadJaHF+xr5gCDllsFrbEzQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762464486; c=relaxed/simple;
	bh=K0MBA/NDjuYhSJlc9XQF6LJrAQaSHSLl0UPjoCj5H8A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=MpoMQttl6/vRN7UJ/MdmLHrZAO/3J+irL2o1gDWo8d1xK4ElpeHU4/FKF6pN1gXz15/xopz1DH3O/gAGBEdF+xJ3Jrprj7F4KLhCDuHHn7nOOdXZ72EDUnkRRT3p8n5B+94HboopcE8oRmcNJPWL1RMnX0N+eJ0SytQek7i1y9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J09Eadt7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF58C4AF0B
	for <linux-pm@vger.kernel.org>; Thu,  6 Nov 2025 21:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762464486;
	bh=K0MBA/NDjuYhSJlc9XQF6LJrAQaSHSLl0UPjoCj5H8A=;
	h=From:Date:Subject:To:Cc:From;
	b=J09Eadt7NWuzAS9T6YnRJ24RePODcr71iDuGW1ckL0ucWjfewEDm58YVDYVPfR9pU
	 Fp0qx91AwDRJZmgsEyLKYIb/rCp/8M3uuWpT5DrLeoqoAiLUprHz7TW5dblXThl3iK
	 U/mkkzUkM07pi7Aggv1T+yuvV62GhEwsERrCYw1Ak1AfogR7Oke7uVDA32x59ZMmXZ
	 H4PbHeX1mzaBmfEL6HViRydmeZNU3qnaGgp66zlgdgYSP9R99Ra98nnqZws4ayqiuB
	 zEGTJu/lQN7NQICv0gB/C0iELAahiqluJWKLUEDyLfy0RFv7BJWbGLaub/8+PgkVa6
	 ul3DYlqR0sPYA==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-65363319bacso29405eaf.2
        for <linux-pm@vger.kernel.org>; Thu, 06 Nov 2025 13:28:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVPW8XfQoz5i40yDVQikqU+CcmauRgdrOStmQBaAmPrIdTxGZalTIu/PFo/RR8VEbzsaE/mS0IXkg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYP/qKh0gh8pxVAYE3XLL9Vty5WVZAYIJCMdbxD+FumbsVzRwB
	YsK+bc0b7KeX4NNUyHsrbj6fq0+hAM+jj7zW4J4+xELzWgKQWU+E4I9GHDlAXXqLc6asK56CFzi
	K4HbUGf/ibTQCLAJvlUKvHQpAQ7W/44w=
X-Google-Smtp-Source: AGHT+IF7dXr2RjLUY6C1fn8TVkoQlFIs4Kvq8HgR0agdfLt+A1tmPiUwMKNIMRKDuTeki2c06C7v7pnTpBbzrMNIFWE=
X-Received: by 2002:a05:6808:4f2a:b0:44d:c03e:657a with SMTP id
 5614622812f47-45015cf2fc2mr529707b6e.7.1762464485311; Thu, 06 Nov 2025
 13:28:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 6 Nov 2025 22:27:54 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0heXyzAAP5mH-kP9iS9yGJ-ceGFUJG5m-FL-rMMWx4eJg@mail.gmail.com>
X-Gm-Features: AWmQ_bmo8bBBfH4_s2z-itlUMPz6AjaSxaBC6mGyOgstB6XZR-N0AaE5S4zWuOw
Message-ID: <CAJZ5v0heXyzAAP5mH-kP9iS9yGJ-ceGFUJG5m-FL-rMMWx4eJg@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v6.18-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.18-rc5

with top-most commit 771e8f483583728cd2ef164f7c2256c4bf2adf4c

 Merge branches 'acpi-cppc' and 'acpi-docs'

on top of commit 6146a0f1dfae5d37442a9ddcba012add260bceb0

 Linux 6.18-rc4

to receive ACPI support fixes for 6.18-rc5.

These fix a coding mistake in the ACPI Smart Battery Subsystem (SBS)
driver and two documentation issues:

 - Fix computation of the battery->present value in acpi_battery_read()
   to work when battery->id is not zero (Dan Carpenter)

 - Fix comment typo in the ACPI CPPC library (Chu Guangqing)

 - Fix I2C device references in two ASL examples in the firmware guide
   that were broken by a previous update (Jonas Gorski)

Thanks!


---------------

Chu Guangqing (1):
      ACPI: CPPC: Fix typo in a comment

Dan Carpenter (1):
      ACPI: SBS: Fix present test in acpi_battery_read()

Jonas Gorski (1):
      Documentation: ACPI: i2c-muxes: fix I2C device references

---------------

 Documentation/firmware-guide/acpi/i2c-muxes.rst | 8 ++++----
 drivers/acpi/cppc_acpi.c                        | 2 +-
 drivers/acpi/sbs.c                              | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

