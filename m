Return-Path: <linux-pm+bounces-9414-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFFB90C730
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 12:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8687FB244FF
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 10:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410B31AC44A;
	Tue, 18 Jun 2024 08:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B1u1g1qO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3490813B5B5;
	Tue, 18 Jun 2024 08:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718699752; cv=none; b=onywxCu3/sCpjdiLVE4EyONQkL6faK+ySsBbgPTTZ8EevH4PMslqIdFJ+3T/qZti4X3rcdyTZ2p5fGw7dTpfp3BWKs3tNYkKESOyRpH83cCk19t7GOPWgfHsyACltpgYFokVDcgrE7erAf1QiX/T7jFFR+/aJ8E+VCgTnormwb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718699752; c=relaxed/simple;
	bh=nYvoxFAcUSVYJxLnDXRVnyZjqM6DX0X3xxOLqPkbgB4=;
	h=From:Date:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=H/5VSqBHAeuRagf1DmAxxGGQua2AT109VLX8P2A244nI7cC/Wo2P+Bw3fUHMBWwNO3avE65lozJRdTsQRZlAYJUHUOU2RXZT2YfUTLKCkntNC0AzUgqz2if8LnHRNloilhmpLtZ2POaPGaGqYLnOXGO3lgrvp0OH3xPxVy0vKms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B1u1g1qO; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718699750; x=1750235750;
  h=from:date:to:cc:subject:message-id:mime-version;
  bh=nYvoxFAcUSVYJxLnDXRVnyZjqM6DX0X3xxOLqPkbgB4=;
  b=B1u1g1qOfU+BjU3qOiM6+bWo0tow7hIwNOrtCToAky8KQQInbiP0OBL6
   3U9XggqgUOnY/FR8Q4pRdSImZSkUsarSfsXgWgV/JhHsRokjtMqgepLjR
   xPvZvtInNSuq0sVuviXRTlFqymnCx2yXZvg6bV/SJruf++bbY62p2G1bf
   UtWnwR4k0+oC97i/6U20Els5dKhiwT9Ixz+MaeODXcYXYoqXN3bz+gQjV
   SHRRY4R7k6aWZ6J0oPOripP8CVROuFYNgSNBRsbdRwBNnqyx8K5GcN0Q7
   ADpZm7W07a2fiQOqjueOvYhMIdyD0fQ9bOVnd+9XJnqSwKTsegc2lvoeE
   g==;
X-CSE-ConnectionGUID: p/ZJXP0hQ1W61Ok03odo4A==
X-CSE-MsgGUID: X9tizdnxQLS6gzzKI7a7ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="38082591"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="38082591"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 01:35:50 -0700
X-CSE-ConnectionGUID: CmK7bRVETQ6TvX+2UQKiDw==
X-CSE-MsgGUID: mhYCFdATQl62EEBY3AIHHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="64700456"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.7])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 01:35:44 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 18 Jun 2024 11:35:40 +0300 (EEST)
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
Subject: [GIT PULL] Immutable branch between pdx86 lenovo c630 branch,
 power/supply and USB
Message-ID: <e999261e-cba8-740e-430b-4a4e702fd609@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi,

Here is the IB containing the platform patches (1-2) the other patches in 
the Lenovo C630 series depend on (Dmitry was going to do a minor update on 
the remaining patches before they are ready to be merged).

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-ib-lenovo-c630-v6.11

for you to fetch changes up to 5e5f2f92cccc29f356422d3cbc104f7f42430f22:

  platform: arm64: add Lenovo Yoga C630 WOS EC driver (2024-06-14 12:51:30 +0300)

----------------------------------------------------------------
Immutable branch between pdx86 lenovo c630 branch, power/supply and USB
subsystems due for the v6.11 merge window.

platform-drivers-x86-ib-lenovo-c630-v6.11:
  v6.10-rc1 + platform-drivers-x86-lenovo-c630
for merging into the power/supply and USB subsystems for v6.11.

----------------------------------------------------------------
Bjorn Andersson (1):
      dt-bindings: platform: Add Lenovo Yoga C630 EC

Dmitry Baryshkov (1):
      platform: arm64: add Lenovo Yoga C630 WOS EC driver

 .../bindings/platform/lenovo,yoga-c630-ec.yaml     |  83 ++++++
 drivers/platform/arm64/Kconfig                     |  14 +
 drivers/platform/arm64/Makefile                    |   1 +
 drivers/platform/arm64/lenovo-yoga-c630.c          | 291 +++++++++++++++++++++
 include/linux/platform_data/lenovo-yoga-c630.h     |  44 ++++
 5 files changed, 433 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/platform/lenovo,yoga-c630-ec.yaml
 create mode 100644 drivers/platform/arm64/lenovo-yoga-c630.c
 create mode 100644 include/linux/platform_data/lenovo-yoga-c630.h

