Return-Path: <linux-pm+bounces-9904-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2726D91539F
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 18:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6DA32862F8
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 16:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D5E19E7ED;
	Mon, 24 Jun 2024 16:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zez7tI6q"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4EA19E7E2;
	Mon, 24 Jun 2024 16:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246307; cv=none; b=A5ip511682hN8wehktsJlI6K+K1xo/8oG6Cd4+SlR8BSkEhNHB52nkLVa0OOigE7FUT6r+dLlCF2XV53v2Xko/t0BLx97l8f/uMdS8jm6dZiVB0zVkGWYpCeI2Wq1CYQtAtf/FdIMZfxlRdv1u7+GXmvqYQyVc5up9dIND1uOUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246307; c=relaxed/simple;
	bh=fbCoAVw5u4SsXGsY9Q4TwtAMZSfeZ8xtbvxJxzRDzEQ=;
	h=From:Date:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=AGbJnL3xsktQvlZNW8g6Ppcx3g3JCGgEWyhjKlo8dNKj2KBo+IIGlD/6aLTZaHquL4EkkpzODjGLLd2Xzz7TY7xVzeu3o73Wiu4EypZnaP3+IAUcr2mRhOl12ipk8MFx96BNpb3o/kIy1lDhYXLD5UqqNxFPpDcPtRWDIMfHzwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zez7tI6q; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719246306; x=1750782306;
  h=from:date:to:cc:subject:message-id:mime-version;
  bh=fbCoAVw5u4SsXGsY9Q4TwtAMZSfeZ8xtbvxJxzRDzEQ=;
  b=Zez7tI6qo7n3L2ZjSbUbAi3SEDZQ3M/KSo7HG9UmNBxHKJ2hvOU8NlZo
   95yJO/a1SmzqJOThzaSJqGshwcBu9Gw0X2vSpaS2V5+/JamaoKKSBCk0S
   dAKMpndlu54k5eWYpwRh0BYI/VHpB3VFMQUkSnltXmd/mHmZ1RG1UxP+3
   u4yzJyk7wGP5KFW7NdtD5+D4hwkWlMVwqh2Lx6zKWInBlCxwxA/3TTSb4
   GKiuIlKRxODQgBidnT5xt759xBc+a2oCGsSUJXhobvvMsh4mkufG62G1V
   7vG6yYSRRa/mg6mhmJOhUPQ2Akk5vB2l/01/7cfFX5QvMLQ3BXFgijCZS
   w==;
X-CSE-ConnectionGUID: 0c8P+Sn9QjieRCW7DaNIVA==
X-CSE-MsgGUID: 6LIcOikfSwazQoxZ6v868g==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="16356537"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="16356537"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 09:25:05 -0700
X-CSE-ConnectionGUID: g4niJvsaQbGtyeXmdH28uw==
X-CSE-MsgGUID: hqDaBJICQkeSfs4KYI8E2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="48520499"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.61])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 09:25:00 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 24 Jun 2024 19:24:55 +0300 (EEST)
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
    Sebastian Reichel <sre@kernel.org>, 
    Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
    Hans de Goede <hdegoede@redhat.com>, 
    Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
    Konrad Dybcio <konrad.dybcio@linaro.org>, linux-pm@vger.kernel.org, 
    devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    platform-driver-x86@vger.kernel.org, linux-usb@vger.kernel.org, 
    linux-arm-msm@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>, 
    Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [GIT PULL RESEND] Immutable branch between pdx86 lenovo c630 branch,
 power/supply and USB
Message-ID: <e42fb2e9-81d4-4e40-ff3a-f9d6a46d03f9@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi,

This is v2 of the lenovo c630 IB branch with the build fix for non-ARM64 
platforms (built on top of the commits in the previous IB PR). Resent with 
full Subject line.

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-ib-lenovo-c630-v6.11-2

for you to fetch changes up to 13bbe1c83bc401c2538c758228d27b4042b08341:

  platform/arm64: build drivers even on non-ARM64 platforms (2024-06-24 18:22:15 +0300)

----------------------------------------------------------------
Immutable branch between pdx86 lenovo c630 branch, power/supply and USB
subsystems due for the v6.11 merge window.

platform-drivers-x86-ib-lenovo-c630-v6.11-2:
  v6.10-rc1 + platform-drivers-x86-lenovo-c630
for merging into the power/supply and USB subsystems for v6.11.

----------------------------------------------------------------
Bjorn Andersson (1):
      dt-bindings: platform: Add Lenovo Yoga C630 EC

Dmitry Baryshkov (2):
      platform: arm64: add Lenovo Yoga C630 WOS EC driver
      platform/arm64: build drivers even on non-ARM64 platforms

 .../bindings/platform/lenovo,yoga-c630-ec.yaml     |  83 ++++++
 drivers/platform/Makefile                          |   2 +-
 drivers/platform/arm64/Kconfig                     |  14 +
 drivers/platform/arm64/Makefile                    |   1 +
 drivers/platform/arm64/lenovo-yoga-c630.c          | 291 +++++++++++++++++++++
 include/linux/platform_data/lenovo-yoga-c630.h     |  44 ++++
 6 files changed, 434 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/platform/lenovo,yoga-c630-ec.yaml
 create mode 100644 drivers/platform/arm64/lenovo-yoga-c630.c
 create mode 100644 include/linux/platform_data/lenovo-yoga-c630.h

