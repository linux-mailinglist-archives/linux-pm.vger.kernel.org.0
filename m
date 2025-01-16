Return-Path: <linux-pm+bounces-20537-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A13A139AB
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 13:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FF59168370
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 12:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7708B1DE3DC;
	Thu, 16 Jan 2025 12:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kvb2l+YM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA8D1D90DB;
	Thu, 16 Jan 2025 12:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737028969; cv=none; b=uGfocAeq8OtJBo/iVoaKUyh8sAzu+As8UZblXHCgmjtdiDlUJNPH239LIONfY8UfmRTDgLzkDSCiJ34FRiFaKi+jAAuBmvnaNcXun3w/YQgftQJGTCPW8RrTuyx6qlyeCAGIMwGmXneKUHhhLKHFPfR+M1HNqWZgc7dpMQId+dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737028969; c=relaxed/simple;
	bh=NgMks3iOQKzMIwQHOtA+dP88k7Mk7eu8pT4IExXYSo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THJwlkuX+7d5s/IST1uBkAnctFpR2cj0PuaVt3iGd7cRdbbDmq05kuYh8SOui8L++yrXjItchj8PeyuyHgd3PQQNoHje9bQP4CvS9GdJp4x4YmFDUTlyI/TPKHV18SUQ6OufkgT7YfhThFDJn5MUHBEEfVvsLOCWZB3m41RkPjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kvb2l+YM; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737028968; x=1768564968;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NgMks3iOQKzMIwQHOtA+dP88k7Mk7eu8pT4IExXYSo4=;
  b=Kvb2l+YM6Bugdk95Dpd4an3MvnFbfS6A+4wNGv6W/NZhE+ycVTdJKQqE
   6FeKKy1UAi7mishAGwjZkmbYcNPOI/kG8pUjA50XNCO2Xb7mUncLxs63Z
   siwrYsbJX34eJgcylU8a995MMw3AxnfRTksiiOHULi1cIBUWR8QRBFVi7
   iRvB/2ZzZcoqZOqyu5qpbKpNKHN7nQh6rDbM7FDCZZZjidbKmRrSXQc/0
   RbER4Ni3SrgV8EgoC3HQu/NFUNLA4U22RWjSnMV4ThAhSzlCnUqFBKWWw
   Ryaojg8b0DHAfkKAmqaEHXFozPdxFORy27XD+8hJk3wqV/NTwgVlYfED/
   Q==;
X-CSE-ConnectionGUID: D4jw5TItQkKQGr19JfWq6A==
X-CSE-MsgGUID: QPrnRmHISyqn/OlijW6mIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="48806107"
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="48806107"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 04:02:47 -0800
X-CSE-ConnectionGUID: 7XN/y71JSHqEoD3bBWgY0g==
X-CSE-MsgGUID: vz555kR/Q5mWewTlcUEJsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="105293015"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa006.fm.intel.com with SMTP; 16 Jan 2025 04:02:19 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 16 Jan 2025 14:02:18 +0200
Date: Thu, 16 Jan 2025 14:02:18 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Pengyu Luo <mitltlatltl@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v3 2/6] platform: arm64: add Huawei Matebook E Go EC
 driver
Message-ID: <Z4j1SicBtMZq4P9B@kuha.fi.intel.com>
References: <20250113174945.590344-1-mitltlatltl@gmail.com>
 <20250113175049.590511-1-mitltlatltl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113175049.590511-1-mitltlatltl@gmail.com>

Hi,

> +static void gaokun_ec_remove(struct i2c_client *client)
> +{
> +	struct gaokun_ec *ec = i2c_get_clientdata(client);
> +	hwmon_device_unregister(ec->hwmon_dev);
> +}

You are missing black line after the declaration.

> +static const struct i2c_device_id gaokun_ec_id[] = {
> +	{ "gaokun-ec", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, gaokun_ec_id);
> +
> +static const struct of_device_id gaokun_ec_of_match[] = {
> +	{ .compatible = "huawei,gaokun3-ec", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, gaokun_ec_of_match);
> +
> +static const struct dev_pm_ops gaokun_ec_pm_ops = {
> +	NOIRQ_SYSTEM_SLEEP_PM_OPS(gaokun_ec_suspend, gaokun_ec_resume)
> +};
> +
> +static struct i2c_driver gaokun_ec_driver = {
> +	.driver = {
> +		.name = "gaokun-ec",
> +		.of_match_table = gaokun_ec_of_match,
> +		.pm = &gaokun_ec_pm_ops,
> +		.dev_groups = gaokun_ec_groups,
> +	},
> +	.probe = gaokun_ec_probe,
> +	.remove = gaokun_ec_remove,
> +	.id_table = gaokun_ec_id,
> +};
> +module_i2c_driver(gaokun_ec_driver);
> +
> +MODULE_DESCRIPTION("HUAWEI Matebook E Go EC driver");
> +MODULE_AUTHOR("Pengyu Luo <mitltlatltl@gmail.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/platform_data/huawei-gaokun-ec.h b/include/linux/platform_data/huawei-gaokun-ec.h
> new file mode 100644
> index 000000000..dfd177bd9
> --- /dev/null
> +++ b/include/linux/platform_data/huawei-gaokun-ec.h
> @@ -0,0 +1,80 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Huawei Matebook E Go Embedded Controller
> + *
> + * Copyright (C) 2024 Pengyu Luo <mitltlatltl@gmail.com>
> + */
> +
> +#ifndef __HUAWEI_GAOKUN_EC_H__
> +#define __HUAWEI_GAOKUN_EC_H__
> +
> +#define GAOKUN_UCSI_CCI_SIZE	4
> +#define GAOKUN_UCSI_DATA_SIZE	16
> +#define GAOKUN_UCSI_READ_SIZE	(GAOKUN_UCSI_CCI_SIZE + GAOKUN_UCSI_DATA_SIZE)
> +#define GAOKUN_UCSI_WRITE_SIZE	0x18
> +
> +#define GAOKUN_UCSI_NO_PORT_UPDATE	(-1)
> +
> +#define GAOKUN_SMART_CHARGE_DATA_SIZE	4 /* mode, delay, start, end */
> +
> +/* -------------------------------------------------------------------------- */
> +
> +struct gaokun_ec;
> +struct gaokun_ucsi_reg;
> +struct notifier_block;
> +
> +#define GAOKUN_MOD_NAME			"huawei_gaokun_ec"
> +#define GAOKUN_DEV_PSY			"psy"
> +#define GAOKUN_DEV_UCSI			"ucsi"
> +
> +/* -------------------------------------------------------------------------- */
> +/* Common API */
> +
> +int gaokun_ec_register_notify(struct gaokun_ec *ec,
> +			      struct notifier_block *nb);
> +void gaokun_ec_unregister_notify(struct gaokun_ec *ec,
> +				 struct notifier_block *nb);
> +
> +int gaokun_ec_read(struct gaokun_ec *ec, const u8 *req,
> +		   size_t resp_len, u8 *resp);
> +int gaokun_ec_write(struct gaokun_ec *ec, u8 *req);
> +int gaokun_ec_read_byte(struct gaokun_ec *ec, u8 *req, u8 *byte);
> +
> +/* -------------------------------------------------------------------------- */
> +/* API For PSY */
> +
> +int gaokun_ec_psy_multi_read(struct gaokun_ec *ec, u8 reg,
> +			     size_t resp_len, u8 *resp);
> +
> +static inline int gaokun_ec_psy_read_byte(struct gaokun_ec *ec,
> +					  u8 reg, u8 *byte)
> +{
> +	return gaokun_ec_psy_multi_read(ec, reg, sizeof(*byte), byte);
> +}
> +
> +static inline int gaokun_ec_psy_read_word(struct gaokun_ec *ec,
> +					  u8 reg, u16 *word)
> +{
> +	return gaokun_ec_psy_multi_read(ec, reg, sizeof(*word), (u8 *)word);
> +}
> +
> +int gaokun_ec_psy_get_smart_charge(struct gaokun_ec *ec,
> +				   u8 data[GAOKUN_SMART_CHARGE_DATA_SIZE]);
> +int gaokun_ec_psy_set_smart_charge(struct gaokun_ec *ec,
> +				   u8 data[GAOKUN_SMART_CHARGE_DATA_SIZE]);
> +
> +int gaokun_ec_psy_get_smart_charge_enable(struct gaokun_ec *ec, bool *on);
> +int gaokun_ec_psy_set_smart_charge_enable(struct gaokun_ec *ec, bool on);
> +
> +/* -------------------------------------------------------------------------- */
> +/* API For UCSI */
> +
> +int gaokun_ec_ucsi_read(struct gaokun_ec *ec, u8 resp[GAOKUN_UCSI_READ_SIZE]);
> +int gaokun_ec_ucsi_write(struct gaokun_ec *ec,
> +			 const u8 req[GAOKUN_UCSI_WRITE_SIZE]);
> +
> +int gaokun_ec_ucsi_get_reg(struct gaokun_ec *ec, struct gaokun_ucsi_reg *ureg);
> +int gaokun_ec_ucsi_pan_ack(struct gaokun_ec *ec, int port_id);
> +
> +

Here you have extra line.

scripts/checkpatch.pl should find this kind issues for you.

Br,

-- 
heikki

