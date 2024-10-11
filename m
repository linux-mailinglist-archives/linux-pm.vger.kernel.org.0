Return-Path: <linux-pm+bounces-15543-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2680999A803
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 17:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7ABF1F211A1
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 15:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0AB195B18;
	Fri, 11 Oct 2024 15:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmY6CT59"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436A4188CB1;
	Fri, 11 Oct 2024 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728661193; cv=none; b=J1Egf99rQK5DtziLtsH7OUQGRCKSk6apGcFqfbmsDx3pYLmJgPTYVpc/+50bidtFjx+lcGzxpLhdXRFOpZlD2NeGuDKOX2nDQfxYA5G7UpTI4olcC+pTv5uPwJ/yRwVk9B7aMq5qm5SFH92y7vOj3p1N1vdHFNqUrksnpmHZIxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728661193; c=relaxed/simple;
	bh=luvGOGPZZYIdzQjAB9ZtwD+WVIc7f5qm3UsozDAnYww=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=OesFQD4gAcgfbT1wcs6S7aDks3GevR9TN1drX7lLA+6APYqnFUUCD93tUguXrdi3sR1gQuQzYyuvP6bo9op7EyOmc2LksY3+lB5aEd+LTlU4LtwR7wEDSxBJ3aZPnCX5k5UmTEsktHqfJ6lBlFoQXBXB6pHZeOgq/sPqAfwuuNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmY6CT59; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1FEC4CEC3;
	Fri, 11 Oct 2024 15:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728661192;
	bh=luvGOGPZZYIdzQjAB9ZtwD+WVIc7f5qm3UsozDAnYww=;
	h=From:Date:Subject:To:Cc:From;
	b=ZmY6CT59KUFdVXs8tPF82FXslmb21avQhJbeM3XsxQcA9d2ISwuDx+FDhN1eTpXcR
	 vSGk4Nd9SaO1gPFd8xZPlUy6/7s07TVyxvXFHuC3MpEhxKp33A1TkGfqLmQSDKzaAk
	 a34NYvOrch+YP7bUXVGdAUAWwnc/lftEN8MM3Nh0TB3H9ghd+y72XnRIyWCSJsIKag
	 OxzgAYUAAM8pbenUNK/B/+cGO0lqAdrrIazhGSJSgaKNs+SmWs58qHH79MaOHLP8NS
	 Mb32CziuIoU8g3wZuhiQKSydUvmXoOTYeCgBPpuYqgnVSHJvEL857JyTL0t3QYS4Hj
	 +yciFa2k3/5/A==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3e5cfb970c9so260772b6e.1;
        Fri, 11 Oct 2024 08:39:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUpL676HybQqhUBoh6TTn1rZkFgQ0xDoVDFSnmY9aZa9nr5JnUYJ/qqgNfkD69fo8+iZr/cPbg8722w12c=@vger.kernel.org
X-Gm-Message-State: AOJu0YylGmiy61ohbsut5DQqylgHVC/Sm2P9OTIpY4TGwcFD20WBi3VL
	tZtDf1yBXSsJTJ606hZUGgDYtOBKaRwQ16b8TSaa6/xCNBwf+hP621L2T0ps2/ns6Yz3b6G8opi
	MkcIcVcdSitEm0lS54HMu1KYz4/0=
X-Google-Smtp-Source: AGHT+IE5SB4rv3cXzYHj84dLcTScXtM0maP6JAg0OHbTUmn9FgERlfueCQQ+sMA6VwUuiUWhnWvF0xiev4hDJcJ1v2Y=
X-Received: by 2002:a05:6808:130f:b0:3e4:4b8f:cb8e with SMTP id
 5614622812f47-3e5c911e974mr2608766b6e.35.1728661192179; Fri, 11 Oct 2024
 08:39:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 11 Oct 2024 17:39:41 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jRZ1yVkn_pa=aY616QNiOe7P2C0RdOG+oRwQ7sH-6w3Q@mail.gmail.com>
Message-ID: <CAJZ5v0jRZ1yVkn_pa=aY616QNiOe7P2C0RdOG+oRwQ7sH-6w3Q@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v6.12-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.12-rc3

with top-most commit 3fb0eea8a1c4be5884e0731ea76cbd3ce126e1f3

 thermal: intel: int340x: processor: Add MMIO RAPL PL4 support

on top of commit e1043b6765d6ca310a10be342e25d5451d58ee53

 Merge tag 'acpi-6.12-rc2' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive power management updates for 6.12-rc3.

These address two issues in the TPMI module of the Intel RAPL power
capping driver and one issue in the processor part of the Intel int340x
thermal driver, update a CPU ID list and register definitions needed
for RAPL PL4 support and remove some unused code.

Specifics:

 - Fix the TPMI_RAPL_REG_DOMAIN_INFO register offset in the TPMI part of
   the Intel RAPL power capping driver, make it ignore minor hardware
   version mismatches (which only indicate exposing additional features)
   and update register definitions in it to enable PL4 support (Zhang
   Rui).

 - Add Arrow Lake-U to the list of processors supporting PL4 in the MSR
   part of the Intel RAPL power capping driver (Sumeet Pawnikar).

 - Remove excess pci_disable_device() calls from the processor part of
   the int340x thermal driver to address a warning triggered during
   module unload and remove unused CPU hotplug code related to RAPL
   support from it (Zhang Rui).

Thanks!


---------------

Sumeet Pawnikar (1):
      powercap: intel_rapl_msr: Add PL4 support for Arrowlake-U

Zhang Rui (5):
      powercap: intel_rapl_tpmi: Fix bogus register reading
      thermal: intel: int340x: processor: Fix warning during module unload
      powercap: intel_rapl_tpmi: Ignore minor version change
      thermal: intel: int340x: processor: Remove MMIO RAPL CPU hotplug support
      thermal: intel: int340x: processor: Add MMIO RAPL PL4 support

---------------

 drivers/powercap/intel_rapl_msr.c                  |  1 +
 drivers/powercap/intel_rapl_tpmi.c                 | 19 ++++--
 .../int340x_thermal/processor_thermal_device_pci.c |  2 -
 .../intel/int340x_thermal/processor_thermal_rapl.c | 70 ++++++++--------------
 4 files changed, 40 insertions(+), 52 deletions(-)

