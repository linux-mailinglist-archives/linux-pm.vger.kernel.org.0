Return-Path: <linux-pm+bounces-41844-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Az/DnE+fmk6WgIAu9opvQ
	(envelope-from <linux-pm+bounces-41844-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 18:40:01 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2D9C359F
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 18:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3CA4830041CA
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 17:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5479F35B62D;
	Sat, 31 Jan 2026 17:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8cBJc1G"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD0135B623;
	Sat, 31 Jan 2026 17:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769881197; cv=none; b=EnuB3rwh7Wovl3YlMNYYmah7gj9JW6iEuxB/CNlXd7jodw2b/96XZdm0IhyhUmZHO8EEKEUEucFhLBNzhDr1qneW+Ty8T8Kf9paiqQl7MuWxzm0CxO0MVgUvemOZLjOuUbwHqghKKKOqTvILOeqxNtC5hWQhgMyXxLJtpip3OhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769881197; c=relaxed/simple;
	bh=4d7y7u7lETaw7U9WZsJlA8Xw6ch9fJayxjMU5Y8yLu0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UgxULfUjJZi6Hi40EQI+WBOoteh1FBx4PLu29U2Gs8HkiUrBmbex2qf+fP/BW0gsq3xUcx16GpoChPlPkIUcrfWXvJWWlt02WWFGXwk+0ScN/MUd2lMmcQfsyyMyHmhubjv8+3ieUcUOO1ZCOnaiSg6irF8FKBfL8Ri5XSpLeoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8cBJc1G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A56C16AAE;
	Sat, 31 Jan 2026 17:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769881196;
	bh=4d7y7u7lETaw7U9WZsJlA8Xw6ch9fJayxjMU5Y8yLu0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D8cBJc1GDYoCiddEx6JmDQo/xmPSYjtBk11kSqzcDEJ9AbfrYyFir3blRNWfkTnrV
	 oRvs3osqw3MUGWV5c8pampLrqsz/1GzO0SwZtTdF6OfJ5tiu/X8CAInvYg4WA6FZd2
	 VyA90aUi5IWNsv/X/iS8pSt4nTxYMbtWu++MeNt5ThwYB6gR2kl40+y5eRH8oYxmpr
	 aPjcjkx+d20Mk8OPYDkPPTIPGiNK/+GiPB2yOzb7okVoT/JMjj+MrznFHfEDU7VPU9
	 agtH8bibvten0d4nlDKfTH+ed0/4/hiekA5kCbWuv4l/X/TAgiwY1qB7xDpmuFkn0I
	 yvTS/6iTXGSRQ==
Date: Sat, 31 Jan 2026 17:39:41 +0000
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
Subject: Re: [PATCH V10 3/4] iio: adc: Add support for QCOM PMIC5 Gen3 ADC
Message-ID: <20260131173941.68b8116d@jic23-huawei>
In-Reply-To: <20260130115421.2197892-4-jishnu.prakash@oss.qualcomm.com>
References: <20260130115421.2197892-1-jishnu.prakash@oss.qualcomm.com>
	<20260130115421.2197892-4-jishnu.prakash@oss.qualcomm.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41844-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email]
X-Rspamd-Queue-Id: CD2D9C359F
X-Rspamd-Action: no action

On Fri, 30 Jan 2026 17:24:20 +0530
Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:

> The ADC architecture on PMIC5 Gen3 is similar to that on PMIC5 Gen2,
> with all SW communication to ADC going through PMK8550 which
> communicates with other PMICs through PBS.
> 
> One major difference is that the register interface used here is that
> of an SDAM (Shared Direct Access Memory) peripheral present on PMK8550.
> There may be more than one SDAM used for ADC5 Gen3 and each has eight
> channels, which may be used for either immediate reads (same functionality
> as previous PMIC5 and PMIC5 Gen2 ADC peripherals) or recurring measurements
> (same as ADC_TM functionality).
> 
> By convention, we reserve the first channel of the first SDAM for all
> immediate reads and use the remaining channels across all SDAMs for
> ADC_TM monitoring functionality.
> 
> Add support for PMIC5 Gen3 ADC driver for immediate read functionality.
> ADC_TM is implemented as an auxiliary thermal driver under this ADC
> driver.
> 
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Hi Jishnu

Whilst there are a couple of comments below, I think this is ready to go.
Unfortunately this is just a few days too late to merge for this coming
cycle as I need to send the IIO pull request today or tomorrow (due to going
through char-misc) so this would get no soak time in next.

Also, I'm not sure how we actually want to merge this given close coupling with
the thermal driver.  Perhaps best bet is I do an immutable branch of next rc1
once available that we pull into both trees. That would have the first 3 patches
on it. 

Jonathan

> diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> new file mode 100644
> index 000000000000..f8168a14b907
> --- /dev/null
> +++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> @@ -0,0 +1,860 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include <linux/auxiliary_bus.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
> +#include <linux/completion.h>
> +#include <linux/container_of.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
If you happen to be spinning again for some reason, I think you might be able to replace
this device.h include with a forwards declaration of struct device;

If you can that would be good as we are trying to reduce includes of these
mega headers.

> +#include <linux/device/devres.h>
> +#include <linux/dev_printk.h>
> +#include <linux/err.h>
> +#include <linux/export.h>
> +#include <linux/iio/adc/qcom-adc5-gen3-common.h>
> +#include <linux/iio/iio.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/types.h>
> +#include <linux/unaligned.h>


> +static int adc5_gen3_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct iio_dev *indio_dev;
> +	struct adc5_chip *adc;
> +	struct regmap *regmap;
> +	int ret, i;
> +	u32 *reg;
> +
> +	regmap = dev_get_regmap(dev->parent, NULL);
> +	if (!regmap)
> +		return -ENODEV;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	adc = iio_priv(indio_dev);
> +	adc->dev_data.regmap = regmap;
> +	adc->dev = dev;
> +
> +	ret = device_property_count_u32(dev, "reg");
> +	if (ret < 0)
> +		return ret;
> +
> +	adc->dev_data.num_sdams = ret;
> +
> +	reg = devm_kcalloc(dev, adc->dev_data.num_sdams, sizeof(u32),
> +			   GFP_KERNEL);
> +	if (!reg)
> +		return -ENOMEM;
> +
> +	ret = device_property_read_u32_array(dev, "reg", reg,
> +					     adc->dev_data.num_sdams);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to read reg property\n");
> +
> +	adc->dev_data.base = devm_kcalloc(dev, adc->dev_data.num_sdams,
> +					  sizeof(*adc->dev_data.base),
> +					  GFP_KERNEL);
> +	if (!adc->dev_data.base)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +	init_completion(&adc->complete);
> +	ret = devm_mutex_init(dev, &adc->lock);

I'd move this stuff up to before you get reg so you can keep all the stuff
related to num_sdams together.

> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < adc->dev_data.num_sdams; i++) {
> +		adc->dev_data.base[i].base_addr = reg[i];
>


