Return-Path: <linux-pm+bounces-9060-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE50906607
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 10:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6E7A286259
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 07:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CD013D24F;
	Thu, 13 Jun 2024 07:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gTjnPvBA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAB413CFBB;
	Thu, 13 Jun 2024 07:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718265472; cv=none; b=dH1hK6xTUc1ZBoupIAoGJos8LEYkCN5AqDoe/EoJDexl68EFgDbrIA0rehH8QHl/7Tj7phV02qtnl9W20At2mAXvvYg7yCsEjRzGIKX/ECljWfJpSuMoD9qVr2WMC9wK7KNkXgx+etJcujsdP37lxswiftt4NFh4lOZP8P9rM6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718265472; c=relaxed/simple;
	bh=e0NxTlF2iD4qbRcwJ7BIXq/PGgNblesDkARtB5e6oSo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rc5Cer/Y7uv0GM0A6z1Sb2JNVC26YT28FPnq2oxzOtKoJ6GZt+6ZL9HoIUOj6NMKo0eJ0beFsMOrpf1d4MFh81VkYcOK3jiQy2XJ3limqrd0eTAjyM6+27nfC3dQm/bTYnLLPX8wOX5DhtXxb1BtJbDwGCmti3ak+BdXx3zuypw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gTjnPvBA; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718265470; x=1749801470;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=e0NxTlF2iD4qbRcwJ7BIXq/PGgNblesDkARtB5e6oSo=;
  b=gTjnPvBAMx+GTdq5rnCfJIBJ7Hnac9JXGQVe2251qErTg9NvzrNdNl2T
   StVworITY3MNq0Wx/2EXjaSfOLbJsoF2pZrpiEj8ErQ41JpczasLrrLyR
   +cZy9no2MEOaZiXkdrRZuBTXb3noE6j8sDvmDa3JlcTMEJNTet8/BfoDP
   OO9ivdMeNsLP5reVwDFnsaHHsFYE0w8QpkkZTbVo0Qi5Ao1iNVfm3YZ5p
   puqshw7RHY57YynkWYFsyRhyBAlwWp4cIQQXLKZcYJKiaMIUv2N+q7WYI
   aSxeLhcJvVBM27aikmKpc60hVPCE2qaPTjId0U/mVuMjMa3t1niHuWlmb
   w==;
X-CSE-ConnectionGUID: 1jVAoXHWT2aVyDodDj5Rjg==
X-CSE-MsgGUID: xrp2OwTiT8688un+pEz+vw==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="26182325"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="26182325"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 00:57:50 -0700
X-CSE-ConnectionGUID: M8wZ9vsRT3enWARScp26kw==
X-CSE-MsgGUID: d2kYW95NT4uLxwd8VzG9/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="40022628"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.209])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 00:57:45 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 13 Jun 2024 10:57:41 +0300 (EEST)
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
    Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
    Hans de Goede <hdegoede@redhat.com>, 
    Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
    Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Konrad Dybcio <konrad.dybcio@linaro.org>, devicetree@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, 
    linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
    Nikita Travkin <nikita@trvn.ru>
Subject: Re: [PATCH v6 4/6] power: supply: lenovo_yoga_c630_battery: add
 Lenovo C630 driver
In-Reply-To: <20240612-yoga-ec-driver-v6-4-8e76ba060439@linaro.org>
Message-ID: <4fc43c56-f801-909a-9178-166d275a5fee@linux.intel.com>
References: <20240612-yoga-ec-driver-v6-0-8e76ba060439@linaro.org> <20240612-yoga-ec-driver-v6-4-8e76ba060439@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 12 Jun 2024, Dmitry Baryshkov wrote:

> On the Lenovo Yoga C630 WOS laptop the EC provides access to the adapter
> and battery status. Add the driver to read power supply status on the
> laptop.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

> +/* the mutex should already be locked */

Enforce this with lockdep_assert_held() (and remove the comment).

> +static int yoga_c630_psy_update_bat_info(struct yoga_c630_psy *ecbat)
> +{
> +	struct yoga_c630_ec *ec = ecbat->ec;
> +	int val;
> +
> +	val = yoga_c630_ec_read8(ec, LENOVO_EC_BAT_PRESENT);
> +	if (val < 0)
> +		return val;
> +	ecbat->bat_present = !!(val & LENOVO_EC_BAT_PRESENT_IS_PRESENT);
> +	if (!ecbat->bat_present)
> +		return val;
> +
> +	val = yoga_c630_ec_read8(ec, LENOVO_EC_BAT_ATTRIBUTES);
> +	if (val < 0)
> +		return val;
> +	ecbat->unit_mA = val & LENOVO_EC_BAT_ATTRIBUTES_UNIT_IS_MA;
> +
> +	val = yoga_c630_ec_read16(ec, LENOVO_EC_BAT_DESIGN_CAPACITY);
> +	if (val < 0)
> +		return val;
> +	ecbat->design_capacity = val * 1000;
> +
> +	/*
> +	 * DSDT has delays after most of EC reads in these methods.
> +	 * Having no documentation for the EC we have to follow and sleep here.
> +	 */
> +	msleep(50);
> +
> +	val = yoga_c630_ec_read16(ec, LENOVO_EC_BAT_DESIGN_VOLTAGE);
> +	if (val < 0)
> +		return val;
> +	ecbat->design_voltage = val;
> +
> +	msleep(50);
> +
> +	val = yoga_c630_ec_read8(ec, LENOVO_EC_BAT_FULL_REGISTER);
> +	if (val < 0)
> +		return val;
> +	val = yoga_c630_ec_read16(ec,
> +				  val & LENOVO_EC_BAT_FULL_REGISTER_IS_FACTORY ?
> +				  LENOVO_EC_BAT_FULL_FACTORY :
> +				  LENOVO_EC_BAT_FULL_CAPACITY);
> +	if (val < 0)
> +		return val;
> +
> +	ecbat->full_charge_capacity = val * 1000;
> +
> +	if (!ecbat->unit_mA) {
> +		ecbat->design_capacity *= 10;
> +		ecbat->full_charge_capacity *= 10;
> +	}
> +
> +	return 0;
> +}
> +
> +static int yoga_c630_psy_maybe_update_bat_status(struct yoga_c630_psy *ecbat)
> +{
> +	struct yoga_c630_ec *ec = ecbat->ec;
> +	int current_mA;
> +	int val;
> +
> +	scoped_guard(mutex, &ecbat->lock) {

This too could be simply guard() to bring down the indentation level.

> +		if (time_before(jiffies, ecbat->last_status_update + LENOVO_EC_CACHE_TIME))
> +			return 0;
> +
> +		val = yoga_c630_ec_read8(ec, LENOVO_EC_BAT_STATUS);
> +		if (val < 0)
> +			return val;
> +		ecbat->bat_status = val;
> +
> +		msleep(50);
> +
> +		val = yoga_c630_ec_read16(ec, LENOVO_EC_BAT_REMAIN_CAPACITY);
> +		if (val < 0)
> +			return val;
> +		ecbat->capacity_now = val * 1000;
> +
> +		msleep(50);
> +
> +		val = yoga_c630_ec_read16(ec, LENOVO_EC_BAT_VOLTAGE);
> +		if (val < 0)
> +			return val;
> +		ecbat->voltage_now = val * 1000;
> +
> +		msleep(50);
> +
> +		val = yoga_c630_ec_read16(ec, LENOVO_EC_BAT_CURRENT);
> +		if (val < 0)
> +			return val;
> +		current_mA = sign_extend32(val, 15);
> +		ecbat->current_now = current_mA * 1000;
> +		ecbat->rate_now = current_mA * (ecbat->voltage_now / 1000);
> +
> +		msleep(50);
> +
> +		if (!ecbat->unit_mA)
> +			ecbat->capacity_now *= 10;
> +
> +		ecbat->last_status_update = jiffies;
> +	}
> +
> +	return 0;
> +}
> +
> +static int yoga_c630_psy_update_adapter_status(struct yoga_c630_psy *ecbat)
> +{
> +	struct yoga_c630_ec *ec = ecbat->ec;
> +	int val;
> +
> +	scoped_guard(mutex, &ecbat->lock) {

Ditto.

> +		val = yoga_c630_ec_read8(ec, LENOVO_EC_ADPT_STATUS);
> +		if (val < 0)
> +			return val;
> +
> +		ecbat->adapter_online = !!(val & LENOVO_EC_ADPT_STATUS_PRESENT);
> +	}
> +
> +	return 0;
> +}


> +static const struct power_supply_desc yoga_c630_psy_bat_psy_desc_mA = {
> +	.name = "yoga-c630-battery",
> +	.type = POWER_SUPPLY_TYPE_BATTERY,
> +	.properties = yoga_c630_psy_bat_mA_properties,
> +	.num_properties = ARRAY_SIZE(yoga_c630_psy_bat_mA_properties),
> +	.get_property = yoga_c630_psy_bat_get_property,
> +};
> +
> +static const struct power_supply_desc yoga_c630_psy_bat_psy_desc_mWh = {
> +	.name = "yoga-c630-battery",
> +	.type = POWER_SUPPLY_TYPE_BATTERY,
> +	.properties = yoga_c630_psy_bat_mWh_properties,
> +	.num_properties = ARRAY_SIZE(yoga_c630_psy_bat_mWh_properties),
> +	.get_property = yoga_c630_psy_bat_get_property,
> +};
> +
> +static int yoga_c630_psy_adpt_get_property(struct power_supply *psy,
> +					  enum power_supply_property psp,
> +					  union power_supply_propval *val)
> +{
> +	struct yoga_c630_psy *ecbat = power_supply_get_drvdata(psy);
> +	int ret = 0;
> +
> +	ret = yoga_c630_psy_update_adapter_status(ecbat);
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		val->intval = ecbat->adapter_online;
> +		break;
> +	case POWER_SUPPLY_PROP_USB_TYPE:
> +		val->intval = POWER_SUPPLY_USB_TYPE_C;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static enum power_supply_property yoga_c630_psy_adpt_properties[] = {
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_USB_TYPE,
> +};
> +
> +static const enum power_supply_usb_type yoga_c630_psy_adpt_usb_type[] = {
> +	POWER_SUPPLY_USB_TYPE_C,
> +};
> +
> +static const struct power_supply_desc yoga_c630_psy_adpt_psy_desc = {
> +	.name = "yoga-c630-adapter",
> +	.type = POWER_SUPPLY_TYPE_USB,
> +	.usb_types = yoga_c630_psy_adpt_usb_type,
> +	.num_usb_types = ARRAY_SIZE(yoga_c630_psy_adpt_usb_type),
> +	.properties = yoga_c630_psy_adpt_properties,
> +	.num_properties = ARRAY_SIZE(yoga_c630_psy_adpt_properties),
> +	.get_property = yoga_c630_psy_adpt_get_property,
> +};
> +
> +static int yoga_c630_psy_register_bat_psy(struct yoga_c630_psy *ecbat)
> +{
> +	struct power_supply_config bat_cfg = {};
> +
> +	bat_cfg.drv_data = ecbat;
> +	bat_cfg.fwnode = ecbat->fwnode;
> +	ecbat->bat_psy = power_supply_register_no_ws(ecbat->dev,
> +						     ecbat->unit_mA ?
> +						     &yoga_c630_psy_bat_psy_desc_mA :
> +						     &yoga_c630_psy_bat_psy_desc_mWh,
> +						     &bat_cfg);
> +	if (IS_ERR(ecbat->bat_psy)) {
> +		dev_err(ecbat->dev, "failed to register battery supply\n");
> +		return PTR_ERR(ecbat->bat_psy);
> +	}
> +
> +	return 0;
> +}
> +
> +static void yoga_c630_ec_refresh_bat_info(struct yoga_c630_psy *ecbat)
> +{
> +	bool current_unit;
> +
> +	scoped_guard(mutex, &ecbat->lock) {

guard()

> +		current_unit = ecbat->unit_mA;
> +
> +		yoga_c630_psy_update_bat_info(ecbat);
> +
> +		if (current_unit != ecbat->unit_mA) {
> +			power_supply_unregister(ecbat->bat_psy);
> +			yoga_c630_psy_register_bat_psy(ecbat);
> +		}
> +	}
> +}


> +	adp_cfg.supplied_to = (char **)&yoga_c630_psy_bat_psy_desc_mA.name;

This is not problem with your patch but I'm wondering why supplied_to 
needs to be non-const char *. Are those strings expected to be altered by 
something, I couldn't find anything to that effect (the pointer itself 
does not become const if supplied_to is changed to const char **)?

--
 i.


