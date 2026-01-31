Return-Path: <linux-pm+bounces-41845-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /sIeB9lBfmmtWgIAu9opvQ
	(envelope-from <linux-pm+bounces-41845-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 18:54:33 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D3BC36DF
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 18:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08BE83029AEA
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 17:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058E336402B;
	Sat, 31 Jan 2026 17:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHDZEgMm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D230135BDD5;
	Sat, 31 Jan 2026 17:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769882067; cv=none; b=J5/gLAp/jFbTRPbrBN1JQ6+Wg0WSPLFPsFGRYN2dVsmuuvYgcW+GyZK9I6fKhZGTdiZFgif2hBHYgi1zvUxQmJV2BnfFKCSITC6bBVu8Qv5f6wNdL35vuI6aFeGWe6VMNQUKoLZhdkuBbbZuoItCb+MLcLCeUUDWwPJ25wqwvmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769882067; c=relaxed/simple;
	bh=nGBuNWH2C/cZMgf7p2YBdZH+AmwcRBcXXxsMIojsYmg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r9A7rgNWZ8cdUM12G28tuBjdkF2yFrEVmrc4pS7R09sG3s1OrWipzKtbV/UC9TFcUvZ8zlqDxAINUA/48c+/8UvNTtzG4zY8uBDFpRIOiLnWL4hsBIM/jxQmmsLD+GQJJvg2Rba1/xF6w6jj2sVTUjv930cByZWfs99PPcxjqAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHDZEgMm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84E5C4CEF1;
	Sat, 31 Jan 2026 17:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769882067;
	bh=nGBuNWH2C/cZMgf7p2YBdZH+AmwcRBcXXxsMIojsYmg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jHDZEgMmOSm1+ACoua48V5qu5JtEL2bEpqEynRaJeNhxFPOenmjCB5LHHYDI/rbeJ
	 M0FGtQFh3qT3620cc0aYTB3VePZk7Uao+PhreNKmA6g5RMAtR4CyTRBOHHmnfInKae
	 hF696o9C8wsg7Ed6Spgixk7au60XGloAONZs/5ks/u/02dODkex4o01I6oiND9z9GR
	 CUf0EMcT2Wr0bAI2q2iGScu/hTG+dlYVnNS973+SHsX1g2KcBn12ens0OTFMfwvRfi
	 CZ/K937jZ58DvnNc9WXHFst9dexsAeqM0rTbpr+3v/yvDWvNdSDeNmUk/7n0fMtk0W
	 6Qegw+26FaARQ==
Date: Sat, 31 Jan 2026 17:54:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 agross@kernel.org, andersson@kernel.org, lumag@kernel.org,
 dmitry.baryshkov@oss.qualcomm.com, konradybcio@kernel.org,
 daniel.lezcano@linaro.org, sboyd@kernel.org, amitk@kernel.org,
 thara.gopinath@gmail.com, lee@kernel.org, rafael@kernel.org,
 subbaraman.narayanamurthy@oss.qualcomm.com, david.collins@oss.qualcomm.com,
 anjelique.melendez@oss.qualcomm.com, kamal.wadhwa@oss.qualcomm.com,
 rui.zhang@intel.com, lukasz.luba@arm.com, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 cros-qcom-dts-watchers@chromium.org, quic_kotarake@quicinc.com,
 neil.armstrong@linaro.org, stephan.gerhold@linaro.org
Subject: Re: [PATCH V10 4/4] thermal: qcom: add support for PMIC5 Gen3 ADC
 thermal monitoring
Message-ID: <20260131175412.0ded39d4@jic23-huawei>
In-Reply-To: <20260130115421.2197892-5-jishnu.prakash@oss.qualcomm.com>
References: <20260130115421.2197892-1-jishnu.prakash@oss.qualcomm.com>
	<20260130115421.2197892-5-jishnu.prakash@oss.qualcomm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41845-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,linux-pm@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,linaro.org,gmail.com,intel.com,arm.com,vger.kernel.org,chromium.org,quicinc.com];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: 66D3BC36DF
X-Rspamd-Action: no action

On Fri, 30 Jan 2026 17:24:21 +0530
Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:

> Add support for ADC_TM part of PMIC5 Gen3.
> 
> This is an auxiliary driver under the Gen3 ADC driver, which implements the
> threshold setting and interrupt generating functionalities of QCOM ADC_TM
> drivers, used to support thermal trip points.
> 
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>

Hi Jishnu.

Some minor editorial style stuff below if you are spinning again.
Otherwise this looks good to me

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Given I expect this patch will go through the thermal tree and not IIO.
As mentioned in previous patch review, we've missed this cycle for IIO where
I'd expect to spin an immutable branch for 1-3 so we can do this early
next cycle.

Thanks,

Jonathan


> diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
> new file mode 100644
> index 000000000000..882355d6606d
> --- /dev/null
> +++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
> @@ -0,0 +1,512 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include <linux/auxiliary_bus.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
> +#include <linux/container_of.h>
> +#include <linux/device.h>

Similar comment to previous.  It's rare we need device.h
and if a forwards definition of struct device is enough it
is better to just do that.

> +#include <linux/device/devres.h>
> +#include <linux/dev_printk.h>
> +#include <linux/err.h>
> +#include <linux/iio/adc/qcom-adc5-gen3-common.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/thermal.h>
> +#include <linux/types.h>
> +#include <linux/workqueue.h>
> +#include <linux/unaligned.h>
> +
> +#include "../thermal_hwmon.h"

> +
> +static void tm_handler_work(struct work_struct *work)
> +{
> +	struct adc_tm5_gen3_chip *adc_tm5 = container_of(work, struct adc_tm5_gen3_chip,
> +							 tm_handler_work);
> +	int sdam_index = -1;
> +	u8 tm_status[2] = { };
> +	u8 buf[16] = { };
> +
> +	for (int i = 0; i < adc_tm5->nchannels; i++) {

Not that important but you've been a bit inconsistent on this style
of putting the loop iterator declaration in the for loop or not.
You could definitely do it in a few more places.  I didn't comment on those
because it's a style choice, but consistency is a good idea - hence I'm
commenting here.

> +		struct adc_tm5_gen3_channel_props *chan_prop = &adc_tm5->chan_props[i];
> +		int offset = chan_prop->tm_chan_index;
> +		bool upper_set, lower_set;
> +		int ret, temp;
> +		u16 code;
> +
> +		scoped_guard(adc5_gen3, adc_tm5) {
> +			if (chan_prop->sdam_index != sdam_index) {
> +				sdam_index = chan_prop->sdam_index;
> +				ret = adc5_gen3_tm_status_check(adc_tm5, sdam_index,
> +								tm_status, buf);
> +				if (ret)
> +					return;
> +			}
> +
> +			upper_set = ((tm_status[0] & BIT(offset)) && chan_prop->high_thr_en);
> +			lower_set = ((tm_status[1] & BIT(offset)) && chan_prop->low_thr_en);
> +		}
> +
> +		if (!(upper_set || lower_set))
> +			continue;
> +
> +		code = get_unaligned_le16(&buf[2 * offset]);
> +		dev_dbg(adc_tm5->dev, "ADC_TM threshold code:%#x\n", code);
> +
> +		ret = adc5_gen3_therm_code_to_temp(adc_tm5->dev,
> +						   &chan_prop->common_props,
> +						   code, &temp);
> +		if (ret) {
> +			dev_err(adc_tm5->dev,
> +				"Invalid temperature reading, ret = %d, code=%#x\n",
> +				ret, code);
> +			continue;
> +		}
> +
> +		chan_prop->last_temp = temp;
> +		chan_prop->last_temp_set = true;
> +		thermal_zone_device_update(chan_prop->tzd, THERMAL_TRIP_VIOLATED);
> +	}
> +}

>

> +static int adc_tm5_register_tzd(struct adc_tm5_gen3_chip *adc_tm5)
> +{
> +	unsigned int i, channel;
> +	struct thermal_zone_device *tzd;
> +	int ret;
> +
> +	for (i = 0; i < adc_tm5->nchannels; i++) {
> +		channel = ADC5_GEN3_V_CHAN(adc_tm5->chan_props[i].common_props);
> +		tzd = devm_thermal_of_zone_register(adc_tm5->dev, channel,
> +						    &adc_tm5->chan_props[i],
> +						    &adc_tm_ops);
> +
No blank line here.  Keep the function and the check on it's error tightly
coupled by not having one.  Slightly improves readability.

> +		if (IS_ERR(tzd)) {
> +			if (PTR_ERR(tzd) == -ENODEV) {
> +				dev_warn(adc_tm5->dev,
> +					 "thermal sensor on channel %d is not used\n",
> +					 channel);

Why is it a warning?  Seems like maybe they'd sometimes not be used. In which case
maybe dev_dbg() or dev_info() is more appropriate.

> +				continue;
> +			}
> +			return dev_err_probe(adc_tm5->dev, PTR_ERR(tzd),
> +					     "Error registering TZ zone:%ld for channel:%d\n",
> +					     PTR_ERR(tzd), channel);
> +		}
> +		adc_tm5->chan_props[i].tzd = tzd;
> +		ret = devm_thermal_add_hwmon_sysfs(adc_tm5->dev, tzd);
> +		if (ret)
> +			return ret;
> +	}
> +	return 0;
> +}
> +
> +static void adc5_gen3_clear_work(void *data)
> +{
> +	struct adc_tm5_gen3_chip *adc_tm5 = data;
> +
> +	cancel_work_sync(&adc_tm5->tm_handler_work);
> +}

> +
> +static int adc_tm5_probe(struct auxiliary_device *aux_dev,
> +			 const struct auxiliary_device_id *id)
> +{

> +	adc5_gen3_register_tm_event_notifier(dev, adctm_event_handler);
> +
> +	/*
> +	 * This is to cancel any instances of tm_handler_work scheduled by
> +	 * TM interrupt, at the time of module removal.
> +	 */
> +

Drop this blank line to keep the association between the comment and the call
it is talking about.

> +	ret = devm_add_action(dev, adc5_gen3_clear_work, adc_tm5);
> +	if (ret)
> +		return ret;
> +
> +	ret = adc_tm5_register_tzd(adc_tm5);
> +	if (ret)
> +		return ret;
> +
> +	/* This is to disable all ADC_TM channels in case of probe failure. */
> +
> +	return devm_add_action(dev, adc5_gen3_disable, adc_tm5);
> +}

