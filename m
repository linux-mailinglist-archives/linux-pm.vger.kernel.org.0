Return-Path: <linux-pm+bounces-8781-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AE490028D
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 13:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45C161F250E0
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 11:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00E919007A;
	Fri,  7 Jun 2024 11:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CoZhXKKH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC581527A4;
	Fri,  7 Jun 2024 11:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717760792; cv=none; b=ltlV5a4+wwxC3vdbJhvdQmtwHHR2Klytb9LvWMlwfwAI6KJSlW+MDWg6k6xJaQ5AuFVwo1gbNHOqzMvpcvFicGkZaouaL4hQcUJKUPgrFTayvl/HNmYP1vv/tB54nsoT/DhG2jBojcMowHz02oK3RcwnkDNlmnAFpa5dqPsvDuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717760792; c=relaxed/simple;
	bh=WgoPOvpJBrjFRzJkMr0lOsjcrFohGFp24YpP2tSK04c=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fAjEXV3hixdSBKzJkqa97qOXDyWT5bHWZ2E04lma6Z3Fu0KFvPSweYgbB9iLHDPLfoppEuzLyCYif82MRWCxlIuvnC70ojIbSopw92XdxqWCeA6C4/j++8Ecps/zBT35tUrEaKLqaT+M2qjjgnXN6PJn3L0x5GJArXMm4v6K860=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CoZhXKKH; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717760791; x=1749296791;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=WgoPOvpJBrjFRzJkMr0lOsjcrFohGFp24YpP2tSK04c=;
  b=CoZhXKKHANDuPBh6mFhQQ+Nm+6+uKzTjsT5V6kGS8bwoGm/AJcXeVOLm
   A7JcjEu4peb+RSg3ifgezvZb3KlWEhNcYoJjHD7Ze+DO/OgAgPgrPtpMx
   ExcDq3vaKlvWK+eh4SPngIk0Q3IlaQ11McSEof4vB/Ii8NQCzpX6Ir+oI
   fzC1Vzg+MWUC6BA3N2p+r/kYQIA7JZAKQ67P8cT6hDCB3JP/9+4Zf88rF
   0oRVa2wF7n16mUq6xwTWz4j1e+lWh00Ly9UeMwYtkYmM/JZX31WWxa9GX
   Z113+3Otk4/DTVnEWCTRcxk0wJIu5FrWoDiR6+EfbP740LBjQEZSFHC0p
   w==;
X-CSE-ConnectionGUID: lLWB/BQ/SMq5f4D/w/WuGg==
X-CSE-MsgGUID: F/M4WIOqSWCs6hs8Nkno4w==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14321039"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="14321039"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 04:46:30 -0700
X-CSE-ConnectionGUID: 4lKNgLrKSGCxUy3it4FE/Q==
X-CSE-MsgGUID: +x08uut2TuWWc9SfCar14w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="38400831"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.184])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 04:46:24 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 7 Jun 2024 14:46:20 +0300 (EEST)
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
    Hans de Goede <hdegoede@redhat.com>, 
    =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
    Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Konrad Dybcio <konrad.dybcio@linaro.org>, linux-pm@vger.kernel.org, 
    devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    platform-driver-x86@vger.kernel.org, linux-usb@vger.kernel.org, 
    linux-arm-msm@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>
Subject: Re: [PATCH v5 2/6] platform: arm64: add Lenovo Yoga C630 WOS EC
 driver
In-Reply-To: <20240607-yoga-ec-driver-v5-2-1ac91a0b4326@linaro.org>
Message-ID: <3a9cb5b3-92a0-640d-baac-0429a91a669b@linux.intel.com>
References: <20240607-yoga-ec-driver-v5-0-1ac91a0b4326@linaro.org> <20240607-yoga-ec-driver-v5-2-1ac91a0b4326@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 7 Jun 2024, Dmitry Baryshkov wrote:

> Lenovo Yoga C630 WOS is a laptop using Snapdragon 850 SoC. Like many
> laptops it uses an embedded controller (EC) to perform various platform
> operations, including, but not limited, to Type-C port control or power
> supply handlng.
> 
> Add the driver for the EC, that creates devices for UCSI and power
> supply devices.
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/platform/arm64/Kconfig                 |  14 ++
>  drivers/platform/arm64/Makefile                |   1 +
>  drivers/platform/arm64/lenovo-yoga-c630.c      | 283 +++++++++++++++++++++++++
>  include/linux/platform_data/lenovo-yoga-c630.h |  43 ++++
>  4 files changed, 341 insertions(+)
> 
> diff --git a/drivers/platform/arm64/Kconfig b/drivers/platform/arm64/Kconfig
> index 8fdca0f8e909..8c103b3150d1 100644
> --- a/drivers/platform/arm64/Kconfig
> +++ b/drivers/platform/arm64/Kconfig
> @@ -32,4 +32,18 @@ config EC_ACER_ASPIRE1
>  	  laptop where this information is not properly exposed via the
>  	  standard ACPI devices.
>  
> +config EC_LENOVO_YOGA_C630
> +	tristate "Lenovo Yoga C630 Embedded Controller driver"
> +	depends on I2C
> +	help
> +	  Driver for the Embedded Controller in the Qualcomm Snapdragon-based
> +	  Lenovo Yoga C630, which provides battery and power adapter
> +	  information.
> +
> +	  This driver provides battery and AC status support for the mentioned
> +	  laptop where this information is not properly exposed via the
> +	  standard ACPI devices.
> +
> +	  Say M or Y here to include this support.
> +
>  endif # ARM64_PLATFORM_DEVICES
> diff --git a/drivers/platform/arm64/Makefile b/drivers/platform/arm64/Makefile
> index 4fcc9855579b..b2ae9114fdd8 100644
> --- a/drivers/platform/arm64/Makefile
> +++ b/drivers/platform/arm64/Makefile
> @@ -6,3 +6,4 @@
>  #
>  
>  obj-$(CONFIG_EC_ACER_ASPIRE1)	+= acer-aspire1-ec.o
> +obj-$(CONFIG_EC_LENOVO_YOGA_C630) += lenovo-yoga-c630.o
> diff --git a/drivers/platform/arm64/lenovo-yoga-c630.c b/drivers/platform/arm64/lenovo-yoga-c630.c
> new file mode 100644
> index 000000000000..ffad8c443a13
> --- /dev/null
> +++ b/drivers/platform/arm64/lenovo-yoga-c630.c

> +int yoga_c630_ec_read8(struct yoga_c630_ec *ec, u8 addr)
> +{
> +	u8 req[2] = { LENOVO_EC_READ_REG, };
> +	int ret;
> +	u8 val;
> +
> +	scoped_guard(mutex, &ec->lock) {
> +		req[1] = addr;
> +		ret = yoga_c630_ec_request(ec, req, sizeof(req), &val, 1);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return val;

For simple cases like this which don't do logic after the unlock, guard() 
would be enough (I don't mind scoped_guard() myself though).

> +}
> +EXPORT_SYMBOL_GPL(yoga_c630_ec_read8);
> +
> +int yoga_c630_ec_read16(struct yoga_c630_ec *ec, u8 addr)
> +{
> +	u8 req[2] = { LENOVO_EC_READ_REG, };
> +	int ret;
> +	u8 msb;
> +	u8 lsb;

addr + 1 could overflow below so it would be good the return -EINVAL if 
0xff addr is given as a parameter.

> +	scoped_guard(mutex, &ec->lock) {
> +		req[1] = addr;
> +		ret = yoga_c630_ec_request(ec, req, sizeof(req), &lsb, 1);
> +		if (ret < 0)
> +			return ret;
> +
> +		req[1] = addr + 1;
> +		ret = yoga_c630_ec_request(ec, req, sizeof(req), &msb, 1);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return msb << 8 | lsb;
> +}
> +EXPORT_SYMBOL_GPL(yoga_c630_ec_read16);


> +
> +u16 yoga_c630_ec_ucsi_get_version(struct yoga_c630_ec *ec)
> +{
> +	u8 req[3] = { 0xb3, 0xf2, 0x20};
> +	int ret;
> +	u8 msb;
> +	u8 lsb;
> +
> +	scoped_guard(mutex, &ec->lock) {
> +		ret = yoga_c630_ec_request(ec, req, sizeof(req), &lsb, 1);
> +		if (ret < 0)
> +			return ret;
> +
> +		req[2] = 0x21;

Could you name 0x20 with a define and use it above and with + 1 here?

> +		ret = yoga_c630_ec_request(ec, req, sizeof(req), &msb, 1);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return msb << 8 | lsb;
> +}
> +EXPORT_SYMBOL_GPL(yoga_c630_ec_ucsi_get_version);

> diff --git a/include/linux/platform_data/lenovo-yoga-c630.h b/include/linux/platform_data/lenovo-yoga-c630.h
> new file mode 100644
> index 000000000000..5571dd65ce08
> --- /dev/null
> +++ b/include/linux/platform_data/lenovo-yoga-c630.h
> @@ -0,0 +1,43 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022-2024, Linaro Ltd
> + * Authors:
> + *    Bjorn Andersson
> + *    Dmitry Baryshkov
> + */
> +
> +#ifndef _LENOVO_YOGA_C630_DATA_H
> +#define _LENOVO_YOGA_C630_DATA_H
> +
> +struct yoga_c630_ec;
> +struct notifier_block;
> +
> +#define YOGA_C630_MOD_NAME	"lenovo_yoga_c630"
> +
> +#define YOGA_C630_DEV_UCSI	"ucsi"
> +#define YOGA_C630_DEV_PSY	"psy"
> +
> +int yoga_c630_ec_read8(struct yoga_c630_ec *ec, u8 addr);
> +int yoga_c630_ec_read16(struct yoga_c630_ec *ec, u8 addr);
> +
> +int yoga_c630_ec_register_notify(struct yoga_c630_ec *ec, struct notifier_block *nb);
> +void yoga_c630_ec_unregister_notify(struct yoga_c630_ec *ec, struct notifier_block *nb);
> +
> +#define YOGA_C630_UCSI_WRITE_SIZE	8
> +#define YOGA_C630_UCSI_CCI_SIZE		4
> +#define YOGA_C630_UCSI_DATA_SIZE	16
> +#define YOGA_C630_UCSI_READ_SIZE	(YOGA_C630_UCSI_CCI_SIZE + YOGA_C630_UCSI_DATA_SIZE)

Add newline here.

> +u16 yoga_c630_ec_ucsi_get_version(struct yoga_c630_ec *ec);
> +int yoga_c630_ec_ucsi_write(struct yoga_c630_ec *ec,
> +			    const u8 req[YOGA_C630_UCSI_WRITE_SIZE]);
> +int yoga_c630_ec_ucsi_read(struct yoga_c630_ec *ec,
> +			   u8 resp[YOGA_C630_UCSI_READ_SIZE]);
> +
> +#define LENOVO_EC_EVENT_USB		0x20
> +#define LENOVO_EC_EVENT_UCSI		0x21
> +#define LENOVO_EC_EVENT_HPD		0x22
> +#define LENOVO_EC_EVENT_BAT_STATUS	0x24
> +#define LENOVO_EC_EVENT_BAT_INFO	0x25
> +#define LENOVO_EC_EVENT_BAT_ADPT_STATUS	0x37
> +
> +#endif
> 
> 

-- 
 i.


