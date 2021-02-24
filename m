Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 104A1323B81
	for <lists+linux-pm@lfdr.de>; Wed, 24 Feb 2021 12:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234582AbhBXLv1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Feb 2021 06:51:27 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:58150 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233445AbhBXLvZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 24 Feb 2021 06:51:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1614167484; x=1645703484;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=icYCP5cU+RA38rrwM1op/xIQLq/s0pzO62jNoky0aCg=;
  b=DDdgRMCJG5IEAQ3/0hPwx+rIhS/g1DdmKzzeKK6kUQmT9zEYJwIQx4ba
   Q3gKLjtl4hbtubKEEy6WP/vzqhYxLCSgPerCrQqs18E9le45mQXYc4fe3
   ZB6Upg6qiuKaOnhnXLO29NmeCyTGqPDgXwiNNnOwQILfme6qEQCo1rNTR
   fIWRVmd+F769HMjpNcx34X4y/zX51wq6M/6k/Ka6Mb4MUibd85Cf8n6Ah
   ekXXrASezGkhd0F/ghZii8vlvvCUBhk559cHfhadPwwAzME98hpYZrUMM
   yaVv/Ba0te3JT4Nt5k0hYP+XvK/QmoV9uYNVYLutkM0+zZXCi5J/uut3Y
   Q==;
IronPort-SDR: 0LltqTdV1DqXT7w//ES3q9IhEKptWbEhwjY0fzFOyX3yoYCXoGux46f1iF1mZC8wc/8vIlHhxr
 ogu6cw3slikiAjOlqAxtzm3VCe4F+uCU81teGzH5yW2jq9SkKqXoGI4aPnY0V6NfmIwuTL3y3C
 k3I9ihVv2wjLuWQc3nYQA+8atIgNz9s6f9ZoAA8+mRCO68Qi+/TAjVvfdnFv7KDpVjRHyDMAYD
 ed1r4Xl1Vc6fCqP86oWcwDspSLORQwxD7OcJi5TqeBwvF4BzF4e89417VFm9+yRqkMMfGavjyb
 SjA=
X-IronPort-AV: E=Sophos;i="5.81,202,1610406000"; 
   d="scan'208";a="16144924"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 24 Feb 2021 12:50:42 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 24 Feb 2021 12:50:42 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 24 Feb 2021 12:50:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1614167442; x=1645703442;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=icYCP5cU+RA38rrwM1op/xIQLq/s0pzO62jNoky0aCg=;
  b=QAFk6EqH1svbyeJGwRov9MX5sYAnbzEoPiyTyQ6CFGceEr9usAV09sWe
   +l3j8iyzK8E6Eqy1T9niWw/hWoCqYHYctc4as/qxADfvZNfqZy/BiwIao
   JzVCKP51oqT+JwaQCUCRT2oTq1vLvfwxi6bFLXja/luu/mtgke5ST2ZOH
   usx9cyOwFB69mOwMUcCC3DxxF62oRN0+LdX9wJLQEa5EGHxRR5wybEpDg
   wxWiMMry8zD0yGlfPy0mpLsSlhc+k6EjFtmpbGlenDOq3Li0rCFbSha1a
   aLzM9GfteQdoXij7sGt6mvgnc18CcTI1RcinkPLicO9/Cy2DqOH8AHToL
   Q==;
IronPort-SDR: elaRCa4IfFyxceGUdNyZsWvpCZr00m7648yC9CztrDsDthkuMq5Cv1mmK4nRAQxXH/lD3SbzMM
 NfbRkGK2uAFXAJ4jZNmM9xa0AktiN8sGJBd7Npy+YtgNicHrvtO/7Hbe9deMJtRxnel8zbnrgv
 aWrJDPqO57F3Kbwu7yLcrOY9tIpdz5z2L0pNo4Lu8eCtPdJMy6Tm0gB/XTwPPreLVXTXLgZQHp
 tH1oFeZi/b+GxdnLMTJ9KuAe4OuHvjKUapankLsCGrRvEpX2kk1y89iHQKq+4w/JJnxdxQLNbZ
 ZlE=
X-IronPort-AV: E=Sophos;i="5.81,202,1610406000"; 
   d="scan'208";a="16144923"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 24 Feb 2021 12:50:42 +0100
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.121.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 1E503280070;
        Wed, 24 Feb 2021 12:50:42 +0100 (CET)
X-CheckPoint: {60363D8F-17-7A65FF6A-CBEA163E}
X-MAIL-CPID: 603F260884BBEF3AA2A1D91C050EB747_5
X-Control-Analysis: str=0001.0A782F24.60363D92.0052,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Message-ID: <b9fb6bc3255c085c6336736c2fd7e76b1fcb8de9.camel@ew.tq-group.com>
Subject: Re: [PATCH 2/3] power: supply: bq27xxx: fix power_avg
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Dan Murphy <dmurphy@ti.com>,
        Pali =?ISO-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 24 Feb 2021 12:50:39 +0100
In-Reply-To: <20210223141122.9574-2-matthias.schiffer@ew.tq-group.com>
References: <20210223141122.9574-1-matthias.schiffer@ew.tq-group.com>
         <20210223141122.9574-2-matthias.schiffer@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2021-02-23 at 15:11 +0100, Matthias Schiffer wrote:
> On all newer bq27xxx ICs, the AveragePower register contains a signed
> value; in addition to handling the raw value as unsigned, the driver
> code also didn't convert it to µW as expected.
> 
> At least for the BQ28Z610, the reference manual incorrectly states that
> the value is in units of 1mA and not 10mA. I have no way of knowing
> whether the manuals of other supported ICs contain the same error, or if
> there are models that actually use 1mA. At least, the new code shouldn't
> be *less* correct than the old version for any device

Ugh, of course this section should talk about mW and not mA. I'll wait
if there is more feedback and then send a v2.


> .
> 
> power_avg is removed from the cache structure, se we don't have to
> extend it to store both a signed value and an error code. Always getting
> an up-to-date value may be desirable anyways, as it avoids inconsistent
> current and power readings when switching between charging and
> discharging.
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>  drivers/power/supply/bq27xxx_battery.c | 51 ++++++++++++++------------
>  include/linux/power/bq27xxx_battery.h  |  1 -
>  2 files changed, 27 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
> index cb6ebd2f905e..20e1dc8a87cf 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -1661,27 +1661,6 @@ static int bq27xxx_battery_read_time(struct bq27xxx_device_info *di, u8 reg)
>  	return tval * 60;
>  }
>  
> -/*
> - * Read an average power register.
> - * Return < 0 if something fails.
> - */
> -static int bq27xxx_battery_read_pwr_avg(struct bq27xxx_device_info *di)
> -{
> -	int tval;
> -
> -	tval = bq27xxx_read(di, BQ27XXX_REG_AP, false);
> -	if (tval < 0) {
> -		dev_err(di->dev, "error reading average power register  %02x: %d\n",
> -			BQ27XXX_REG_AP, tval);
> -		return tval;
> -	}
> -
> -	if (di->opts & BQ27XXX_O_ZERO)
> -		return (tval * BQ27XXX_POWER_CONSTANT) / BQ27XXX_RS;
> -	else
> -		return tval;
> -}
> -
>  /*
>   * Returns true if a battery over temperature condition is detected
>   */
> @@ -1769,8 +1748,6 @@ void bq27xxx_battery_update(struct bq27xxx_device_info *di)
>  		}
>  		if (di->regs[BQ27XXX_REG_CYCT] != INVALID_REG_ADDR)
>  			cache.cycle_count = bq27xxx_battery_read_cyct(di);
> -		if (di->regs[BQ27XXX_REG_AP] != INVALID_REG_ADDR)
> -			cache.power_avg = bq27xxx_battery_read_pwr_avg(di);
>  
>  		/* We only have to read charge design full once */
>  		if (di->charge_design_full <= 0)
> @@ -1833,6 +1810,32 @@ static int bq27xxx_battery_current(struct bq27xxx_device_info *di,
>  	return 0;
>  }
>  
> +/*
> + * Get the average power in µW
> + * Return < 0 if something fails.
> + */
> +static int bq27xxx_battery_pwr_avg(struct bq27xxx_device_info *di,
> +				   union power_supply_propval *val)
> +{
> +	int power;
> +
> +	power = bq27xxx_read(di, BQ27XXX_REG_AP, false);
> +	if (power < 0) {
> +		dev_err(di->dev,
> +			"error reading average power register %02x: %d\n",
> +			BQ27XXX_REG_AP, power);
> +		return power;
> +	}
> +
> +	if (di->opts & BQ27XXX_O_ZERO)
> +		val->intval = (power * BQ27XXX_POWER_CONSTANT) / BQ27XXX_RS;
> +	else
> +		/* Other gauges return a signed value in units of 10mW */
> +		val->intval = (int)((s16)power) * 10000;
> +
> +	return 0;
> +}
> +
>  static int bq27xxx_battery_status(struct bq27xxx_device_info *di,
>  				  union power_supply_propval *val)
>  {
> @@ -2020,7 +2023,7 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
>  		ret = bq27xxx_simple_value(di->cache.energy, val);
>  		break;
>  	case POWER_SUPPLY_PROP_POWER_AVG:
> -		ret = bq27xxx_simple_value(di->cache.power_avg, val);
> +		ret = bq27xxx_battery_pwr_avg(di, val);
>  		break;
>  	case POWER_SUPPLY_PROP_HEALTH:
>  		ret = bq27xxx_simple_value(di->cache.health, val);
> diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
> index 111a40d0d3d5..8d5f4f40fb41 100644
> --- a/include/linux/power/bq27xxx_battery.h
> +++ b/include/linux/power/bq27xxx_battery.h
> @@ -53,7 +53,6 @@ struct bq27xxx_reg_cache {
>  	int capacity;
>  	int energy;
>  	int flags;
> -	int power_avg;
>  	int health;
>  };
>  

