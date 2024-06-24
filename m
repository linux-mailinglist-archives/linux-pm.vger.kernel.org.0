Return-Path: <linux-pm+bounces-9903-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5861D91537A
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 18:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BDD01C225E3
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 16:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF51D19DFA3;
	Mon, 24 Jun 2024 16:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eM1bwwsT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394A119DF63;
	Mon, 24 Jun 2024 16:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246142; cv=none; b=gqi7fvyXdJfLUYsMl7xl3DI0qVyVtazZ4qix4isDZ7CkIXw9mWC64f0bVHM/QLTmrqB0mzaC08dyJePjDlo+tUxu7jHX0Nx2ZJOPmKCSv9inCI9iwbP4Vt1c9Gw10iJko02O/XmAiGugPqirON8ez+Fr+QtOvLCB7MsTDwGOfCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246142; c=relaxed/simple;
	bh=F4+Y3cxc/O7I9mHF0Tndy0UmovZrdLKD0A9V49BygtI=;
	h=From:Date:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=nXuhygwfx39l/+x6EXaXsu9NiDpgW/cMVlwcgNSdCs0BLg2UTUhyjYOTdHJpgt5S7SmYu7VDib7+3qkZOHxmnDaeWqrt99RCmo2wEyTnzZjuNM2gmnMvfASUoSbDkgVghPeLKuek2q2p2jJNAEqxKWyWwUHjOAk6qNIN8ywPV5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eM1bwwsT; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719246142; x=1750782142;
  h=from:date:to:cc:subject:message-id:mime-version;
  bh=F4+Y3cxc/O7I9mHF0Tndy0UmovZrdLKD0A9V49BygtI=;
  b=eM1bwwsTyLz961F2i2fWFMs5Hb7hpZ9n4YTirz3ZQh6RIYb0fU3ksSum
   yDbVs2hm0ICAIhyADK8r5BmuVdz0S4NxRlzhbMBijqMfkOkJFyNgvw/Qq
   5j5romH4MvkBS2vNpqXHeCT5CoFbdOyxemb3E4LbiRoDkt9f6NZ8WofOw
   8ewXKJikSv0OWIpF6fUgMZzkarYbxq/JWfeOuLZ72GppjLMOOccpuWfxf
   t6SgnsErOJxOT5oyUTfG93coGsOLtOYQJr+9CRBwIZya7+R8sESG4MY99
   I4eNumFEid/GhJVURymVoxQ10/glSZaUjry0GY2UQ6cvP9ig9RzPe6EEs
   Q==;
X-CSE-ConnectionGUID: JA7CPWkbRBaIRtwIdsSpUg==
X-CSE-MsgGUID: psOO9gwFS72skdqjCSkJLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="27637272"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="27637272"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 09:22:21 -0700
X-CSE-ConnectionGUID: BYOU9KmYQaW5pzZiTrNtkw==
X-CSE-MsgGUID: 0uzXkmujTjyvFcGh+4A4Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="47721812"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.61])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 09:22:14 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 24 Jun 2024 19:22:10 +0300 (EEST)
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
Subject: branch between pdx86 lenovo c630 branch, power/supply and USB
Message-ID: <0986fbac-7fba-56ea-cabb-c040ae12a795@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi,

This is v2 of the lenovo c630 IB branch with the build fix for non-ARM64 
platforms (built on top of the commits in the previous IB PR).

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

