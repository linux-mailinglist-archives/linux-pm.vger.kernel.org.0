Return-Path: <linux-pm+bounces-40210-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B552CF49CB
	for <lists+linux-pm@lfdr.de>; Mon, 05 Jan 2026 17:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 67040302CDCD
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jan 2026 16:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF9631AA8F;
	Mon,  5 Jan 2026 16:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dgQc0b4b"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417882F25E4;
	Mon,  5 Jan 2026 16:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767629429; cv=none; b=uUTGfjnVMSg09h/Itz5egqgdu+enqI1fRI1zqIncxvaOLmHTKghn5Lp0kfYRlqguiIO18L/uR4NGW18eVdM/UuP0VrbMkHtdqet1C/R50sMSBSh6hY/XZrjOrIWbncLtNSPWvRtzZB/zQOKSAbed/ixX1p15z9Hsi9F4LwCInJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767629429; c=relaxed/simple;
	bh=kzCRFUztXQTIWieGzaPRB5F9NacR2ZhvKHo9n5T7lCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXZ/tSdSRvCf7vP27mCSoNjpiKKBy7FB2Mh2Im6fAaXgLI95bLJU/Aw8kyncSAsA27czDyjBUAVckAu+LRAjc2D0SY9semw9SIrF7z/wnvbinMzK8q6FwbDmi7tTPuVByNOlLjx4NClWt1iyHvAx1haJE8hJILpQjVt9Hl4dg10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dgQc0b4b; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767629427; x=1799165427;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kzCRFUztXQTIWieGzaPRB5F9NacR2ZhvKHo9n5T7lCs=;
  b=dgQc0b4bkVdYXVUk7Sfz79trgYSNc4RnsHIBQuSZyhsnxODh+tDI0pbL
   Pm6Qqc+F84QfruQ4xUz8iS3xKAk4HWWDV1nL/Tj3kFbvLAV65HYE56cJL
   TCq6RyalR9CyZTkKfDPlCvdsqagGIptLdukZbnzGifjHaMJhP3F7Xi5l5
   IaPSoMURAQ7gLqR8nhsq4Q3kW+9O/YRSJaNAr3orkgZC4uMCCgbqYjaR5
   slCNaSMMM9YHhRsrt+QnyCC3hFPRoeduJIcGDAZjbSjnlEFqK+30V+JKc
   iLAt575Hj/0/ffEEG5vJfmUcngKZn+L/KN9XyibD5VQgFko6ZuKB8Yf5t
   Q==;
X-CSE-ConnectionGUID: WltLiaPeTc+VR7OvQGbH2A==
X-CSE-MsgGUID: ZnO4oCPJRd6JAVOFyN8jLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="79300044"
X-IronPort-AV: E=Sophos;i="6.21,203,1763452800"; 
   d="scan'208";a="79300044"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 08:10:26 -0800
X-CSE-ConnectionGUID: zs90m1P/T/6PV/+GxPKxMQ==
X-CSE-MsgGUID: 6BWfqYvcS/SbRp4lnJP65w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,203,1763452800"; 
   d="scan'208";a="202469155"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO kuha) ([10.124.222.12])
  by orviesa008.jf.intel.com with SMTP; 05 Jan 2026 08:10:20 -0800
Received: by kuha (sSMTP sendmail emulation); Mon, 05 Jan 2026 18:10:01 +0200
Date: Mon, 5 Jan 2026 18:10:01 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: amitsd@google.com
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Badhri Jagan Sridharan <badhri@google.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>
Subject: Re: [PATCH v3 5/5] usb: typec: tcpm/tcpci_maxim: deprecate WAR for
 setting charger mode
Message-ID: <aVvhvuq6Ls1v3B_E@kuha>
References: <20251227-max77759-charger-v3-0-54e664f5ca92@google.com>
 <20251227-max77759-charger-v3-5-54e664f5ca92@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-max77759-charger-v3-5-54e664f5ca92@google.com>

Sat, Dec 27, 2025 at 12:04:25AM +0000, Amit Sunil Dhamne via B4 Relay kirjoitti:
> From: Amit Sunil Dhamne <amitsd@google.com>
> 
> TCPCI maxim driver directly writes to the charger's register space to
> set charger mode depending on the power role. As MAX77759 chg driver
> exists, this WAR is not required.
> 
> Instead, use a regulator interface to source vbus when typec is in
> source power mode. In other power modes, this regulator will be turned
> off if active.
> 
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpci_maxim.h      |  1 +
>  drivers/usb/typec/tcpm/tcpci_maxim_core.c | 54 +++++++++++++++++++------------
>  2 files changed, 34 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.h b/drivers/usb/typec/tcpm/tcpci_maxim.h
> index b33540a42a95..b314606eb0f6 100644
> --- a/drivers/usb/typec/tcpm/tcpci_maxim.h
> +++ b/drivers/usb/typec/tcpm/tcpci_maxim.h
> @@ -60,6 +60,7 @@ struct max_tcpci_chip {
>  	struct tcpm_port *port;
>  	enum contamiant_state contaminant_state;
>  	bool veto_vconn_swap;
> +	struct regulator *vbus_reg;
>  };
>  
>  static inline int max_tcpci_read16(struct max_tcpci_chip *chip, unsigned int reg, u16 *val)
> diff --git a/drivers/usb/typec/tcpm/tcpci_maxim_core.c b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> index 19f638650796..e9e2405c5ca0 100644
> --- a/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> +++ b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> @@ -10,6 +10,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/usb/pd.h>
>  #include <linux/usb/tcpci.h>
>  #include <linux/usb/tcpm.h>
> @@ -35,12 +36,6 @@
>   */
>  #define TCPC_RECEIVE_BUFFER_LEN				32
>  
> -#define MAX_BUCK_BOOST_SID				0x69
> -#define MAX_BUCK_BOOST_OP				0xb9
> -#define MAX_BUCK_BOOST_OFF				0
> -#define MAX_BUCK_BOOST_SOURCE				0xa
> -#define MAX_BUCK_BOOST_SINK				0x5
> -
>  static const struct regmap_range max_tcpci_tcpci_range[] = {
>  	regmap_reg_range(0x00, 0x95)
>  };
> @@ -202,32 +197,49 @@ static void process_rx(struct max_tcpci_chip *chip, u16 status)
>  	tcpm_pd_receive(chip->port, &msg, rx_type);
>  }
>  
> +static int get_vbus_regulator_handle(struct max_tcpci_chip *chip)
> +{
> +	if (IS_ERR_OR_NULL(chip->vbus_reg)) {
> +		chip->vbus_reg = devm_regulator_get_exclusive(chip->dev,
> +							      "vbus");
> +		if (IS_ERR_OR_NULL(chip->vbus_reg)) {
> +			dev_err(chip->dev,
> +				"Failed to get vbus regulator handle");
> +			return -ENODEV;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int max_tcpci_set_vbus(struct tcpci *tcpci, struct tcpci_data *tdata, bool source, bool sink)
>  {
>  	struct max_tcpci_chip *chip = tdata_to_max_tcpci(tdata);
> -	u8 buffer_source[2] = {MAX_BUCK_BOOST_OP, MAX_BUCK_BOOST_SOURCE};
> -	u8 buffer_sink[2] = {MAX_BUCK_BOOST_OP, MAX_BUCK_BOOST_SINK};
> -	u8 buffer_none[2] = {MAX_BUCK_BOOST_OP, MAX_BUCK_BOOST_OFF};
> -	struct i2c_client *i2c = chip->client;
>  	int ret;
>  
> -	struct i2c_msg msgs[] = {
> -		{
> -			.addr = MAX_BUCK_BOOST_SID,
> -			.flags = i2c->flags & I2C_M_TEN,
> -			.len = 2,
> -			.buf = source ? buffer_source : sink ? buffer_sink : buffer_none,
> -		},
> -	};
> -
>  	if (source && sink) {
>  		dev_err(chip->dev, "Both source and sink set\n");
>  		return -EINVAL;
>  	}
>  
> -	ret = i2c_transfer(i2c->adapter, msgs, 1);
> +	ret = get_vbus_regulator_handle(chip);
> +	if (ret) {
> +		/*
> +		 * Regulator is not necessary for sink only applications. Return
> +		 * success in cases where sink mode is being modified.
> +		 */
> +		return source ? ret : 1;
> +	}
> +
> +	if (source) {
> +		if (!regulator_is_enabled(chip->vbus_reg))
> +			ret = regulator_enable(chip->vbus_reg);
> +	} else {
> +		if (regulator_is_enabled(chip->vbus_reg))
> +			ret = regulator_disable(chip->vbus_reg);
> +	}
>  
> -	return  ret < 0 ? ret : 1;
> +	return ret < 0 ? ret : 1;
>  }
>  
>  static void process_power_status(struct max_tcpci_chip *chip)
> 
> -- 
> 2.52.0.351.gbe84eed79e-goog
> 

-- 
heikki

