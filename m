Return-Path: <linux-pm+bounces-9059-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD76E906518
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 09:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FFE41F220BB
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 07:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8949C13C669;
	Thu, 13 Jun 2024 07:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OdnUOSVg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E2C13B5B0;
	Thu, 13 Jun 2024 07:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718263834; cv=none; b=UMKhHL/cV4wYpWiYvIi9n/DIIdHZpvGNJ7+wpnUWsfyBCaIWS/X5j1kmCZBTan0HtRQmxE4w3AbX/iaajL6N1RTCKKd4cVoWZb/bOPqoVaEOeJkpj5l6ctJu/p8HgVNU5sHV4FsAMQrilSJF806QNx6cWvsKO69HBRtbxOufFKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718263834; c=relaxed/simple;
	bh=dsetrFdITEMBuE/dVKeYsPlIhzXBWBSLjWq5b239AhQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BsQNGfRHmAqcnu3lNLRFWKJjCuyIuh+aIfuHhu3hcMMnz2lXtRGK6Y0KSTxGtO2e5FiyZqv/F3Paji4bShJNnOTsDZ1Bb2TqA21zS2tvcLBSs/53/bdCc1tXRV/3LqqTgJhVWrIArgml5XP3WcPCyw19BDVczhpA30jGY2PE+zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OdnUOSVg; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718263833; x=1749799833;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=dsetrFdITEMBuE/dVKeYsPlIhzXBWBSLjWq5b239AhQ=;
  b=OdnUOSVgKZV6gDw/hR5ODOC5kIACpRsIZYntY13NY9F6qEFlsb1vsa2b
   oO6OK9tyUIyX+5Ex1HPH4hiJ0TZQGfV28uvcE6IKW7DrPRbLBJArCr05r
   TYTPXCZU0V51a/FuJxXZUjAbPK2D4IzA/7GgawwAlNWxuR12p0PLibcPu
   ZbAeH3hFIPB3RvyA0egLrDWj7bJ7iBZne50geqwfkii68/Eu0IFKW0vMU
   Pnl3LBx9Fnavv/s0f2AYDrX2eDzdDpIYo3Os7uQAOt0G3ZgdHoXoLEz9V
   icu+mcZDOWvfx/Tlq0rjhSZ8Dk4FAIKwVBij7xkT9VxixyenwIyLqL9Nv
   A==;
X-CSE-ConnectionGUID: G3ag7TxFR5uqrnerMtBqZQ==
X-CSE-MsgGUID: THdUdd6cTDOddWcFhiIFlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="26179761"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="26179761"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 00:30:31 -0700
X-CSE-ConnectionGUID: VZ2GH6DcRz6lt7rN8CLZrA==
X-CSE-MsgGUID: 1/G27uvSQ02EkRRYgnBJrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="40118770"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.209])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 00:30:26 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 13 Jun 2024 10:30:23 +0300 (EEST)
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
    linux-arm-msm@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>
Subject: Re: [PATCH v6 3/6] usb: typec: ucsi: add Lenovo Yoga C630 glue
 driver
In-Reply-To: <20240612-yoga-ec-driver-v6-3-8e76ba060439@linaro.org>
Message-ID: <c8c81617-4391-2c4c-1009-4a8a667a14dc@linux.intel.com>
References: <20240612-yoga-ec-driver-v6-0-8e76ba060439@linaro.org> <20240612-yoga-ec-driver-v6-3-8e76ba060439@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 12 Jun 2024, Dmitry Baryshkov wrote:

> The Lenovo Yoga C630 WOS laptop provides implements UCSI interface in
> the onboard EC. Add glue driver to interface the platform's UCSI
> implementation.
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

> +static int yoga_c630_ucsi_read(struct ucsi *ucsi, unsigned int offset,
> +			       void *val, size_t val_len)
> +{
> +	struct yoga_c630_ucsi *uec = ucsi_get_drvdata(ucsi);
> +	u8 buf[YOGA_C630_UCSI_READ_SIZE];
> +	int ret;
> +
> +	ret = yoga_c630_ec_ucsi_read(uec->ec, buf);
> +	if (ret)
> +		return ret;
> +
> +	if (offset == UCSI_VERSION) {
> +		memcpy(val, &uec->version, min(val_len, sizeof(uec->version)));
> +		return 0;
> +	}
> +
> +	if (offset == UCSI_CCI)
> +		memcpy(val, buf, min(val_len, YOGA_C630_UCSI_CCI_SIZE));
> +	else if (offset == UCSI_MESSAGE_IN)
> +		memcpy(val, buf + YOGA_C630_UCSI_CCI_SIZE,
> +		       min(val_len, YOGA_C630_UCSI_DATA_SIZE));
> +	else
> +		return -EINVAL;
> +
> +	return 0;

Hmm, the inconsistency when to do return 0 is a bit odd. Also, using 
switch (offset) would probably be better here anyway to replace all the 
ifs.

> +}
> +
> +static int yoga_c630_ucsi_async_write(struct ucsi *ucsi, unsigned int offset,
> +				      const void *val, size_t val_len)
> +{
> +	struct yoga_c630_ucsi *uec = ucsi_get_drvdata(ucsi);
> +
> +	if (offset != UCSI_CONTROL ||
> +	    val_len != YOGA_C630_UCSI_WRITE_SIZE)
> +		return -EINVAL;
> +
> +	return yoga_c630_ec_ucsi_write(uec->ec, val);
> +}
> +
> +static int yoga_c630_ucsi_sync_write(struct ucsi *ucsi, unsigned int offset,
> +				     const void *val, size_t val_len)
> +{
> +	struct yoga_c630_ucsi *uec = ucsi_get_drvdata(ucsi);
> +	bool ack = UCSI_COMMAND(*(u64 *)val) == UCSI_ACK_CC_CI;
> +	int ret;
> +
> +	if (ack)
> +		set_bit(UCSI_C630_ACK_PENDING, &uec->flags);
> +	else
> +		set_bit(UCSI_C630_COMMAND_PENDING, &uec->flags);
> +
> +	reinit_completion(&uec->complete);
> +
> +	ret = yoga_c630_ucsi_async_write(ucsi, offset, val, val_len);
> +	if (ret)
> +		goto out_clear_bit;
> +
> +	if (!wait_for_completion_timeout(&uec->complete, 5 * HZ))
> +		ret = -ETIMEDOUT;
> +
> +out_clear_bit:
> +	if (ack)
> +		clear_bit(UCSI_C630_ACK_PENDING, &uec->flags);
> +	else
> +		clear_bit(UCSI_C630_COMMAND_PENDING, &uec->flags);
> +
> +	return ret;
> +}
> +
> +const struct ucsi_operations yoga_c630_ucsi_ops = {
> +	.read = yoga_c630_ucsi_read,
> +	.sync_write = yoga_c630_ucsi_sync_write,
> +	.async_write = yoga_c630_ucsi_async_write,
> +};
> +
> +static void yoga_c630_ucsi_notify_ucsi(struct yoga_c630_ucsi *uec, u32 cci)
> +{
> +	if (UCSI_CCI_CONNECTOR(cci))
> +		ucsi_connector_change(uec->ucsi, UCSI_CCI_CONNECTOR(cci));
> +
> +	if (cci & UCSI_CCI_ACK_COMPLETE &&
> +	    test_bit(UCSI_C630_ACK_PENDING, &uec->flags))
> +		complete(&uec->complete);
> +
> +	if (cci & UCSI_CCI_COMMAND_COMPLETE &&
> +	    test_bit(UCSI_C630_COMMAND_PENDING, &uec->flags))
> +		complete(&uec->complete);

Is this racy? Can another command start after an ACK in between these two 
ifs and complete() is called prematurely for the new command? (Or will 
different value in cci protect against that?)

> +}
> +
> +static int yoga_c630_ucsi_notify(struct notifier_block *nb,
> +				 unsigned long action, void *data)
> +{
> +	struct yoga_c630_ucsi *uec = container_of(nb, struct yoga_c630_ucsi, nb);
> +	u32 cci;
> +	int ret;
> +
> +	switch (action) {
> +	case LENOVO_EC_EVENT_USB:
> +	case LENOVO_EC_EVENT_HPD:
> +		ucsi_connector_change(uec->ucsi, 1);
> +		return NOTIFY_OK;
> +
> +	case LENOVO_EC_EVENT_UCSI:
> +		ret = uec->ucsi->ops->read(uec->ucsi, UCSI_CCI, &cci, sizeof(cci));
> +		if (ret)
> +			return NOTIFY_DONE;
> +
> +		yoga_c630_ucsi_notify_ucsi(uec, cci);
> +
> +		return NOTIFY_OK;
> +
> +	default:
> +		return NOTIFY_DONE;
> +	}
> +}
> +
> +static int yoga_c630_ucsi_probe(struct auxiliary_device *adev,
> +				const struct auxiliary_device_id *id)
> +{
> +	struct yoga_c630_ec *ec = adev->dev.platform_data;
> +	struct yoga_c630_ucsi *uec;
> +	int ret;
> +
> +	uec = devm_kzalloc(&adev->dev, sizeof(*uec), GFP_KERNEL);
> +	if (!uec)
> +		return -ENOMEM;
> +
> +	uec->ec = ec;
> +	init_completion(&uec->complete);
> +	uec->nb.notifier_call = yoga_c630_ucsi_notify;
> +
> +	uec->ucsi = ucsi_create(&adev->dev, &yoga_c630_ucsi_ops);
> +	if (IS_ERR(uec->ucsi))
> +		return PTR_ERR(uec->ucsi);
> +
> +	ucsi_set_drvdata(uec->ucsi, uec);
> +
> +	uec->version = yoga_c630_ec_ucsi_get_version(uec->ec);
> +
> +	auxiliary_set_drvdata(adev, uec);
> +
> +	ret = yoga_c630_ec_register_notify(ec, &uec->nb);
> +	if (ret)
> +		return ret;
> +
> +	return ucsi_register(uec->ucsi);
> +}
> +
> +static void yoga_c630_ucsi_remove(struct auxiliary_device *adev)
> +{
> +	struct yoga_c630_ucsi *uec = auxiliary_get_drvdata(adev);
> +
> +	yoga_c630_ec_unregister_notify(uec->ec, &uec->nb);
> +	ucsi_unregister(uec->ucsi);

Usually, the remove should tear down in reverse order than the probe side. 
Is the divergence from that here intentional?


-- 
 i.


