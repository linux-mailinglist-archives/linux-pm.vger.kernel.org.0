Return-Path: <linux-pm+bounces-9173-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1364D9088C0
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 11:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83C4F1F223C3
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 09:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8757619597E;
	Fri, 14 Jun 2024 09:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EMJsBj8+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A41192B87;
	Fri, 14 Jun 2024 09:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718358599; cv=none; b=h6TH6VPd3l2855wYT5IUrP1ytwskxWOQukydNXgWy2yIJ/zqZg55R3CdM8Z9p5SgeK2UNvlTUo41lfC6YjpKJVRUdV80pL0dfN/Me58dK4XaIIqnR9RO+HjAAvaQrNcm81u39DVzEMWPHHQsziTtQrgPfbrIvI8vjUnRvKYZkE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718358599; c=relaxed/simple;
	bh=2OZ3L7NQnRMDE7VXZmO25GoZOXA0atjNt18Kc5M8loQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sig6um4VhUh5hUXDlYnwqd2rB/IuSpNYdtPbAriq7TEFRcwy6KHQe8NBvNSUgGeq5rN47B77bcPfea9iBavzLqhrZ1u7cDy30PVxx+Jag/5SN1s1+sgnb8IHIZITbXHhL2YNas0Nb9IXf9aM+lZ8t9wqo+48OWEg+egMxX4ovBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EMJsBj8+; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718358598; x=1749894598;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=2OZ3L7NQnRMDE7VXZmO25GoZOXA0atjNt18Kc5M8loQ=;
  b=EMJsBj8+WfmQj4DPrNh+kGsAgRGAxt91QId9Uxecl9R0X+HYiWLxLfq8
   zG/4cvJBLMzNTNjwU+gQJdlWILMvEONiAb7kHMLxw7N/HqSFnHU55Vgj7
   cHRdcD3SG786MeEEqRYOKQbDSXN9KvNgUG5vCCvUCV1LVBkzrr96UWWYX
   VNb7bsZ2+26i3LgFBVI8r1Ri5v+zEUSCltHDl3IJeGGLyzLba/NKTbtxY
   Jl1pQIK82c38CiYX//RnGI3T+IebHwuTqzlsd8/sLVesUozeWZp3Ya9Ar
   3qibClJno497Do0Joyg42CdwP5lnlfwkj+jDj3zk42FhK+DorsSQBV0Qi
   g==;
X-CSE-ConnectionGUID: cYFCeWBqQcOx1nu9D/pdQg==
X-CSE-MsgGUID: AAkocf0HSESftyQDtXK5mQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="37760681"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="37760681"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 02:49:57 -0700
X-CSE-ConnectionGUID: ICK1xWFqRlWMZGnakqtFzA==
X-CSE-MsgGUID: +AgR8c+2QZKzx1jIe+fLGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="40551884"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.222])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 02:49:50 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 14 Jun 2024 12:49:46 +0300 (EEST)
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
    Hans de Goede <hdegoede@redhat.com>, 
    Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
    Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Konrad Dybcio <konrad.dybcio@linaro.org>, linux-pm@vger.kernel.org, 
    devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    platform-driver-x86@vger.kernel.org, linux-usb@vger.kernel.org, 
    linux-arm-msm@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>, 
    Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v7 0/6] power: supply: Lenovo Yoga C630 EC
In-Reply-To: <20240614-yoga-ec-driver-v7-0-9f0b9b40ae76@linaro.org>
Message-ID: <0cf0e301-2caf-bcfb-33db-355ac89f5a2d@linux.intel.com>
References: <20240614-yoga-ec-driver-v7-0-9f0b9b40ae76@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 14 Jun 2024, Dmitry Baryshkov wrote:

> This adds binding, driver and the DT support for the Lenovo Yoga C630
> Embedded Controller, to provide battery information.
> 
> Support for this EC was implemented by Bjorn, who later could not work
> on this driver. I've picked this patchset up and updated it following
> the pending review comments.
> 
> DisplayPort support is still not a part of this patchset. It uses EC
> messages to provide AltMode information rather than implementing
> corresponding UCSI commands. However to have a cleaner uAPI story, the
> AltMode should be handled via the same Type-C port.
> 
> Merge strategy: the driver bits depend on the platform/arm64 patch,
> which adds interface for the subdrivers. I'd either ask to get that
> patch merged to the immutable branch, which then can be picked up by
> power/supply and USB trees or, to make life simpler, ack merging all
> driver bits e.g. through USB subsystem (I'm biased here since I plan to
> send more cleanups for the UCSI subsystem, which would otherwise result
> in cross-subsystem conflicts).

In preparation for making an IB, I took patch 1-2 into 
platform-drivers-x86-lenovo-c630 branch. I'll tag it once LKP has 
built tested the branch.

-- 
 i.


> 
> ---
> Changes in v7:
> - In PSY driver use guard() instead of scoped_guard() (Ilpo)
> - Use switch/case rather than ifs in yoga_c630_ucsi_read() (Ilpo)
> - Link to v6: https://lore.kernel.org/r/20240612-yoga-ec-driver-v6-0-8e76ba060439@linaro.org
> 
> Changes in v6:
> - Use guard() instead of scoped_guard() (Ilpo)
> - Add a define for UCSI version register (Ilpo)
> - Added a check to prevent overflowing the address in reg16 read (Ilpo)
> - Link to v5: https://lore.kernel.org/r/20240607-yoga-ec-driver-v5-0-1ac91a0b4326@linaro.org
> 
> Changes in v5:
> - Added missing article in the commit message (Bryan)
> - Changed yoga_c630_ec_ucsi_get_version() to explicitly set the register
>   instead of just incrementing it (Bryan)
> - Dropped spurious debugging pr_info (Bryan)
> - Added missing includes all over the place (Ilpo)
> - Switched to scoped_guard() where it's suitable (Ilpo)
> - Defined register bits (Ilpo, Bryan)
> - Whitespace cleanup (Ilpo, Bryan)
> - Reworked yoga_c630_ucsi_notify() to use switch-case (Bryan)
> - Use ternary operators instead of if()s (Ilpo)
> - Switched power supply driver to use fwnode (Sebastian)
> - Fixed handling of the adapter's type vs usb_type (Sebastian)
> - Added SCOPE property to the battery (Sebastian)
> - Link to v4: https://lore.kernel.org/r/20240528-yoga-ec-driver-v4-0-4fa8dfaae7b6@linaro.org
> 
> Changes in v4:
> - Moved bindings to platform/ to follow example of other Acer Aspire1 EC
>   (Nikita Travkin)
> - Fixed dt validation for EC interrupt pin (Rob Herring)
> - Dropped separate 'scale' property (Oliver Neukum)
> - Link to v3: https://lore.kernel.org/r/20240527-yoga-ec-driver-v3-0-327a9851dad5@linaro.org
> 
> Changes in v3:
> - Split the driver into core and power supply drivers,
> - Added UCSI driver part, handling USB connections,
> - Fixed Bjorn's address in DT bindings (Brian Masney)
> - Changed power-role for both ports to be "dual" per UCSI
> - Link to v2: https://lore.kernel.org/linux-arm-msm/20230205152809.2233436-1-dmitry.baryshkov@linaro.org/
> 
> Changes in v2:
> - Dropped DP support for now, as the bindings are in process of being
>   discussed separately,
> - Merged dt patch into the same patchseries,
> - Removed the fixed serial number battery property,
> - Fixed indentation of dt bindings example,
> - Added property: reg and unevaluatedProperties to the connector
>   bindings.
> - Link to v1: https://lore.kernel.org/linux-arm-msm/20220810035424.2796777-1-bjorn.andersson@linaro.org/
> 
> ---
> Bjorn Andersson (2):
>       dt-bindings: platform: Add Lenovo Yoga C630 EC
>       arm64: dts: qcom: c630: Add Embedded Controller node
> 
> Dmitry Baryshkov (4):
>       platform: arm64: add Lenovo Yoga C630 WOS EC driver
>       usb: typec: ucsi: add Lenovo Yoga C630 glue driver
>       power: supply: lenovo_yoga_c630_battery: add Lenovo C630 driver
>       arm64: dts: qcom: sdm845: describe connections of USB/DP port
> 
>  .../bindings/platform/lenovo,yoga-c630-ec.yaml     |  83 ++++
>  arch/arm64/boot/dts/qcom/sdm845.dtsi               |  53 ++-
>  .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts      |  75 ++++
>  drivers/platform/arm64/Kconfig                     |  14 +
>  drivers/platform/arm64/Makefile                    |   1 +
>  drivers/platform/arm64/lenovo-yoga-c630.c          | 290 ++++++++++++
>  drivers/power/supply/Kconfig                       |   9 +
>  drivers/power/supply/Makefile                      |   1 +
>  drivers/power/supply/lenovo_yoga_c630_battery.c    | 500 +++++++++++++++++++++
>  drivers/usb/typec/ucsi/Kconfig                     |   9 +
>  drivers/usb/typec/ucsi/Makefile                    |   1 +
>  drivers/usb/typec/ucsi/ucsi_yoga_c630.c            | 204 +++++++++
>  include/linux/platform_data/lenovo-yoga-c630.h     |  44 ++
>  13 files changed, 1283 insertions(+), 1 deletion(-)
> ---
> base-commit: 6906a84c482f098d31486df8dc98cead21cce2d0
> change-id: 20240527-yoga-ec-driver-76fd7f5ddae8
> 
> Best regards,
> 

