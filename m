Return-Path: <linux-pm+bounces-18101-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 316C69D8BC1
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 18:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B98A5161EC7
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 17:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F111B81DC;
	Mon, 25 Nov 2024 17:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVULCjqS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4B241C92;
	Mon, 25 Nov 2024 17:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732557435; cv=none; b=ti0ZSXGYXM1eyOnjh7sZdQnjE1TicURQuWzMj8RGS1mVH1GfLz4g0AnTmreVOyOGY2rgtuasy/hLxv6g4EZgXpusJesX4ejY0VaokX6EOqvv+VQXIyP8qEGtQYrwQ3VD9bK55J/I5c9nQw3ikbDlKfPMqmEI3BGDfVu8G80NYp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732557435; c=relaxed/simple;
	bh=YT80/O07exbvHiZ+p9AkVjVIlP6bA4gVhumiRx2cpMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5NoW71f6uLr1tfiPEWtvWtpeEo5yagGHRo1BB/bI2PXYmyUcibarBDhfJHCfDBz7UwF9fX2IEt6ztb8cYDqNUI+9lBAuEnBQG/GCaH9dpg9vZGHQILIPVXtuNkqK0ZrhXuk1ycF3KMHRRKMaPRm3ObolDxW1cTpOgXo08UWANM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVULCjqS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27CE7C4CECE;
	Mon, 25 Nov 2024 17:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732557434;
	bh=YT80/O07exbvHiZ+p9AkVjVIlP6bA4gVhumiRx2cpMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZVULCjqSsIb0LXPSlZyPC2PFqGBC5GWZV9VygVQJCaHmCukbrllCD2+2kMufKAt6C
	 DUUTIFUzWrt59m/ZOupB9zxZtF4PlZ1SstJ7X95XT6tMgvZQzzbBVA3NSPGIEzqDzJ
	 fTZ1YOWfxPQ2qh7ns+ChNaA+IUMqpk1K2Mi/ici5FgCzV1wFStmAzFnHy3zoYUiIiz
	 qSUR/+r2XROh4UFAhYFVkUGEF3N+pzaT2SSU7puzkrzZ5Jx4zxbS6USciAlDDIpkeb
	 1GBYxmPB2dEHERR0qeX1JtrNE6SnVivkPAsOKsHmdwgAZdXXnXhvfTvERPUMZCWLnf
	 SsBah5iTrcd6Q==
Received: by pali.im (Postfix)
	id 4A4365DA; Mon, 25 Nov 2024 18:57:05 +0100 (CET)
Date: Mon, 25 Nov 2024 18:57:05 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: "Sicelo A. Mhlongo" <absicsz@gmail.com>
Cc: linux-pm@vger.kernel.org, sre@kernel.org, linux-kernel@vger.kernel.org,
	maemo-leste@lists.dyne.org
Subject: Re: [PATCH] bq27xxx: add voltage min design for bq27000 and bq27200
Message-ID: <20241125175705.hxcyesdsexcmhdtr@pali>
References: <20241125151321.45440-1-absicsz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241125151321.45440-1-absicsz@gmail.com>
User-Agent: NeoMutt/20180716

On Monday 25 November 2024 17:12:58 Sicelo A. Mhlongo wrote:
> The bq27x00 gauges have an EEPROM register which contains the value of
> the voltage that should be considered to be zero battery capacity. Expose
> this to userspace using the VOLTAGE_MIN_DESIGN property.
> 
> Tested on Nokia N900 with bq27200.
> 
> Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>

Looks good,

Acked-by: Pali Rohár <pali@kernel.org>

> ---
>  drivers/power/supply/bq27xxx_battery.c | 39 +++++++++++++++++++++++++-
>  include/linux/power/bq27xxx_battery.h  |  1 +
>  2 files changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
> index 40c5ac7a1118..90a5bccfc6b9 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -123,6 +123,7 @@ enum bq27xxx_reg_index {
>  	BQ27XXX_DM_BLOCK,	/* Data Block */
>  	BQ27XXX_DM_DATA,	/* Block Data */
>  	BQ27XXX_DM_CKSUM,	/* Block Data Checksum */
> +	BQ27XXX_REG_SEDVF,	/* End-of-discharge Voltage */
>  	BQ27XXX_REG_MAX,	/* sentinel */
>  };
>  
> @@ -159,6 +160,7 @@ static u8
>  		[BQ27XXX_DM_BLOCK] = INVALID_REG_ADDR,
>  		[BQ27XXX_DM_DATA] = INVALID_REG_ADDR,
>  		[BQ27XXX_DM_CKSUM] = INVALID_REG_ADDR,
> +		[BQ27XXX_REG_SEDVF] = 0x77,
>  	},
>  	bq27010_regs[BQ27XXX_REG_MAX] = {
>  		[BQ27XXX_REG_CTRL] = 0x00,
> @@ -184,6 +186,7 @@ static u8
>  		[BQ27XXX_DM_BLOCK] = INVALID_REG_ADDR,
>  		[BQ27XXX_DM_DATA] = INVALID_REG_ADDR,
>  		[BQ27XXX_DM_CKSUM] = INVALID_REG_ADDR,
> +		[BQ27XXX_REG_SEDVF] = 0x77,
>  	},
>  	bq2750x_regs[BQ27XXX_REG_MAX] = {
>  		[BQ27XXX_REG_CTRL] = 0x00,
> @@ -579,6 +582,7 @@ static enum power_supply_property bq27000_props[] = {
>  	POWER_SUPPLY_PROP_POWER_AVG,
>  	POWER_SUPPLY_PROP_HEALTH,
>  	POWER_SUPPLY_PROP_MANUFACTURER,
> +	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
>  };
>  
>  static enum power_supply_property bq27010_props[] = {
> @@ -599,6 +603,7 @@ static enum power_supply_property bq27010_props[] = {
>  	POWER_SUPPLY_PROP_CYCLE_COUNT,
>  	POWER_SUPPLY_PROP_HEALTH,
>  	POWER_SUPPLY_PROP_MANUFACTURER,
> +	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
>  };
>  
>  #define bq2750x_props bq27510g3_props
> @@ -2039,6 +2044,36 @@ static int bq27xxx_battery_voltage(struct bq27xxx_device_info *di,
>  	return 0;
>  }
>  
> +/*
> + * Return the design minimum battery Voltage in microvolts
> + * Or < 0 if something fails.
> + */
> +static int bq27xxx_battery_read_dmin_volt(struct bq27xxx_device_info *di,
> +					  union power_supply_propval *val)
> +{
> +	int volt;
> +
> +	/* We only have to read design minimum voltage once */
> +	if (di->voltage_min_design > 0) {
> +		val->intval = di->voltage_min_design;
> +		return 0;
> +	}
> +
> +	volt = bq27xxx_read(di, BQ27XXX_REG_SEDVF, true);
> +	if (volt < 0) {
> +		dev_err(di->dev, "error reading design min voltage\n");
> +		return volt;
> +	}
> +
> +	/* SEDVF = Design EDVF / 8 - 256 */
> +	val->intval = volt * 8000 + 2048000;
> +
> +	/* Save for later reads */
> +	di->voltage_min_design = val->intval;
> +
> +	return 0;
> +}
> +
>  static int bq27xxx_simple_value(int value,
>  				union power_supply_propval *val)
>  {
> @@ -2119,8 +2154,10 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
>  	 * power_supply_battery_info visible in sysfs.
>  	 */
>  	case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
> -	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
>  		return -EINVAL;
> +	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
> +		ret = bq27xxx_battery_read_dmin_volt(di, val);
> +		break;
>  	case POWER_SUPPLY_PROP_CYCLE_COUNT:
>  		ret = bq27xxx_battery_read_cyct(di, val);
>  		break;
> diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
> index 5180dc9f1706..6b190639b08e 100644
> --- a/include/linux/power/bq27xxx_battery.h
> +++ b/include/linux/power/bq27xxx_battery.h
> @@ -61,6 +61,7 @@ struct bq27xxx_device_info {
>  	struct bq27xxx_access_methods bus;
>  	struct bq27xxx_reg_cache cache;
>  	int charge_design_full;
> +	int voltage_min_design;
>  	bool removed;
>  	unsigned long last_update;
>  	union power_supply_propval last_status;
> -- 
> 2.45.2
> 

