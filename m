Return-Path: <linux-pm+bounces-26224-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D90A9CADA
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 15:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D8917B4CAA
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 13:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC8F22D4DA;
	Fri, 25 Apr 2025 13:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZAVPoJQL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B4471747;
	Fri, 25 Apr 2025 13:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745589072; cv=none; b=QZf7ZHWSrjWcNcYSevLMWVqYrUR5VrhKvh6K4uHnNbJsWhTF9iFZjQTvcuWVyf1btXGwMH5Anc2HoovfTIrr9iD9gLcfT/33NCTItSEKdY8vWc4NA0vfjpyB5fT+00GYRraifdc0+aYPWttIR3i7Iz16Gg4ZrMZHPRBiGoLMZLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745589072; c=relaxed/simple;
	bh=OhZMVslTMFHk1PYXUziNNqXZhgpB08GxxfE5qfU9SMk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Y3uBEwUTz1y/AdR/MWlV+Z2dbkK/10ijvrcSykTek4CawjFz1m1L2ctc99MM2TdlIuQrtTYKJcz96JOf3/Az5Gx1iJHdSI8BB+6GdhcD0BvOo/TpVuKSB9dLWh/nOfFKYYkhAfocgk/esZxa+bBmEa2dHLCt6D2/yDXPthqCsm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZAVPoJQL; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745589071; x=1777125071;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=OhZMVslTMFHk1PYXUziNNqXZhgpB08GxxfE5qfU9SMk=;
  b=ZAVPoJQLRHhmJ2advrNRsFva3K7C9aGDvJBcxDwNlg+1oy7u8BxdV3iV
   ybh5VxV0CLWl9/xtMTZtIqzd0ZSiFwtWOoVgDCyq5xceJaIg3YBY5gGBR
   lQMvOWAL7iBjXty/8NYXaERN4JP/YuHePGMj9TNoV2U0KKJDa2saMP6FW
   do4WbVV1WKdF3okTErJndahHzNSeUV0Zrze7hH/huN2MUsYLm+BxzDqyJ
   xAXsFjMcsWfqW7Fg3MqjoD01ehx+7Y+W3czuE8Pivq2J0dcaygtF+LB5t
   OnCBELDIre0ITrFmVAK197LB1DJudSVWlmiUKi+pPJOlU17YdL0kcs1Xc
   w==;
X-CSE-ConnectionGUID: 77xyvPGySFi2WBKZPmBQ9w==
X-CSE-MsgGUID: aj6lyNgmT9ubvaAOL7uahA==
X-IronPort-AV: E=McAfee;i="6700,10204,11414"; a="50917497"
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="50917497"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 06:51:10 -0700
X-CSE-ConnectionGUID: bD/JDR3LQ9yWdeM3F6uVBA==
X-CSE-MsgGUID: VK6mzkL+SLKFFR+xFJka7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="137722441"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.154])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 06:51:04 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: platform-driver-x86@vger.kernel.org, 
 Antheas Kapenekakis <lkml@antheas.dev>
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, 
 Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
 Joaquin Ignacio Aramendia <samsagax@gmail.com>, 
 Derek J Clark <derekjohn.clark@gmail.com>, 
 Kevin Greenberg <kdgreenberg234@protonmail.com>, 
 Joshua Tam <csinaction@pm.me>, Parth Menon <parthasarathymenon@gmail.com>, 
 Eileen <eileen@one-netbook.com>, linux-kernel@vger.kernel.org, 
 sre@kernel.org, linux@weissschuh.net, hdegoede@redhat.com, 
 mario.limonciello@amd.com
In-Reply-To: <20250425111821.88746-1-lkml@antheas.dev>
References: <20250425111821.88746-1-lkml@antheas.dev>
Subject: Re: [PATCH v10 00/16] hwmon: (oxpsensors) Add devices, features,
 fix ABI and move to platform/x86
Message-Id: <174558905993.2965.3080490340204327476.b4-ty@linux.intel.com>
Date: Fri, 25 Apr 2025 16:50:59 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Fri, 25 Apr 2025 13:18:05 +0200, Antheas Kapenekakis wrote:

> This four part series updates the oxpsensors module to bring it in line
> with its Windows OneXPlayer counterpart. First, it adds support for all
> 2024, 2025 OneXPlayer handhelds and their special variants. Then, it moves
> the module to platform/x86 to allow for including more EC features.
> 
> Then, it adds the new charge limiting and bypass features that were first
> introduced in the X1 and retrofit to older OneXFly variants and for
> controlling the turbo led found in the X1 models. For Bypass, it adds a new
> charge_behaviour variant called inhibit-charge-s0.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[01/16] hwmon: (oxp-sensors) Distinguish the X1 variants
        commit: 217d55ca13d22ba6af7e96ac2d28c2ef6927fc54
[02/16] hwmon: (oxp-sensors) Add all OneXFly variants
        commit: 9f4c9ec158fa8fa4afcdbcbff9c9a9a900dc9c2f
[03/16] platform/x86: oxpec: Move hwmon/oxp-sensors to platform/x86
        commit: fe812896e55d0d8e2a45bcf994cadc80fe912fb5
[04/16] ABI: testing: sysfs-class-oxp: add missing documentation
        commit: 05f8e5928bfd37416380e8e0994c5f4fd1b615c8
[05/16] ABI: testing: sysfs-class-oxp: add tt_led attribute documentation
        commit: 7ba14e4eec62985ae2021ef7e06d537b8e4c8712
[06/16] platform/x86: oxpec: Rename ec group to tt_toggle
        commit: 8e1963b9d84a3db10cdd2a807dc3fe401837d228
[07/16] platform/x86: oxpec: Add turbo led support to X1 devices
        commit: 5485a80150ff03b6784bfbb194858244ae5f991d
[08/16] platform/x86: oxpec: Move pwm_enable read to its own function
        commit: aa682cff3097dfa2370298ecebd33ff1fb64bab8
[09/16] platform/x86: oxpec: Move pwm value read/write to separate functions
        commit: 0ba0d67b0608c15b407491712af1c2a3d5140492
[10/16] platform/x86: oxpec: Move fan speed read to separate function
        commit: 653feeccdd2eb1dfe44923f4c0bbf50a948c7a07
[11/16] platform/x86: oxpec: Adhere to sysfs-class-hwmon and enable pwm on 2
        commit: 7dea472a8b2814013213f4fed290f5f86c6cc7cb
[12/16] platform/x86: oxpec: Follow reverse xmas convention for tt_toggle
        commit: bb9854e9819ae5c29602d4985313cde2d07f6847
[13/16] power: supply: add inhibit-charge-awake to charge_behaviour
        commit: 468182a839f88fecab915792cbb98ad7328be266
[14/16] platform/x86: oxpec: Add charge threshold and behaviour to OneXPlayer
        commit: 202593d1e86bf3ccb1c1091713760b6f44641718
[15/16] platform/x86: oxpec: Rename rval to ret in tt_toggle
        commit: 57c775a990a742f7cc2650a5cbfc103d6b4a015d
[16/16] platform/x86: oxpec: Convert defines to using tabs
        commit: f5612600314bcce86934318601501e2d8301176d

--
 i.


