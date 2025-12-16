Return-Path: <linux-pm+bounces-39616-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B44CC0E0B
	for <lists+linux-pm@lfdr.de>; Tue, 16 Dec 2025 05:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FD473077E61
	for <lists+linux-pm@lfdr.de>; Tue, 16 Dec 2025 04:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5A232C30A;
	Tue, 16 Dec 2025 04:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.b="C8ai/uUI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail86.out.titan.email (mail86.out.titan.email [209.209.25.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB8130EF7F
	for <linux-pm@vger.kernel.org>; Tue, 16 Dec 2025 04:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.209.25.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765859223; cv=none; b=LGoa2Ad0ZqYxd9n3S08J8mYzGTv+BjcfmKAQdS069HTWJfCbcXTGaynXuYSK+IEeq/wGedyiOXLLqEbgkrUXOHAAQ1M60XomB/BBERNWHZH/pjDC99LLcohOGBLdkSGd46Mrd270ikkS3fOn1Z5Y+fzWVWvJ/ZronY9MB44zarg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765859223; c=relaxed/simple;
	bh=sF1WnRmUgXjOianAvDDJl1ZA6eiSQcLIwJiWDwNReuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CEziXw4d0ACLTN37e6V2nOuhbmHXDo0p3hwmnTHvWocrmKu4UN4TnXR3BcuJO2pyOhRRNQPaSJvjTehAGej5ZU/TIJaO8PxbFFu6zfZX/nssBj6+QT3fqeGIE2j8cVNNTdA72uyh4LBUYSCT4PmsPF58golSjn+RplBr/sZwVHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.b=C8ai/uUI; arc=none smtp.client-ip=209.209.25.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Received: from localhost (localhost [127.0.0.1])
	by smtp-out.flockmail.com (Postfix) with ESMTP id 4dVkCN0kqRz7t9J;
	Tue, 16 Dec 2025 04:16:48 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=7n7qMq2z773A6crxSe2h52Ruo5UwRmT1FP0PMQ4p+ec=;
	c=relaxed/relaxed; d=ziyao.cc;
	h=to:message-id:in-reply-to:date:from:subject:cc:references:mime-version:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1765858608; v=1;
	b=C8ai/uUIcIC2/r/nA4mW3Nq1ffkkSI+I3YlQXUq3FWa23HXh8a/tFdEMWU2roXuU9kbCsiYu
	lZSGqUF/tkrawoRz5rj97BGdWFBLWoJ5ggk0HP1c6Rt9P1a8ylySQHB3BRYR1NKllYeTq9M89qc
	pHolYxhgXdEU8CuzjKVQ9730=
Received: from pie (unknown [117.171.66.90])
	by smtp-out.flockmail.com (Postfix) with ESMTPA id 4dVkCF3YM3z7t7t;
	Tue, 16 Dec 2025 04:16:41 +0000 (UTC)
Date: Tue, 16 Dec 2025 04:16:27 +0000
Feedback-ID: :me@ziyao.cc:ziyao.cc:flockmailId
From: Yao Zi <me@ziyao.cc>
To: Shuwei Wu <shuweiwoo@163.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] thermal: spacemit: k1: Add thermal sensor support
Message-ID: <aUDc-o63KJpY8xLG@pie>
References: <20251216-patchv2-k1-thermal-v1-0-d4b31fe9c904@163.com>
 <20251216-patchv2-k1-thermal-v1-2-d4b31fe9c904@163.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216-patchv2-k1-thermal-v1-2-d4b31fe9c904@163.com>
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1765858607931248556.30087.3778824715309203318@prod-use1-smtp-out1002.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=TPG/S0la c=1 sm=1 tr=0 ts=6940dd2f
	a=rBp+3XZz9uO5KTvnfbZ58A==:117 a=rBp+3XZz9uO5KTvnfbZ58A==:17
	a=kj9zAlcOel0A:10 a=MKtGQD3n3ToA:10 a=CEWIc4RMnpUA:10 a=Byx-y9mGAAAA:8
	a=K1kigjf773wChWhSffkA:9 a=CjuIK1q_8ugA:10 a=3z85VNIBY5UIEeAh_hcH:22
	a=NWVoK91CQySWRX1oVYDe:22

On Tue, Dec 16, 2025 at 10:00:36AM +0800, Shuwei Wu wrote:
> The thermal sensor on K1 supports monitoring five temperature zones.
> The driver registers these sensors with the thermal framework
> and supports standard operations:
> - Reading temperature (millidegree Celsius)
> - Setting high/low thresholds for interrupts
> 
> Signed-off-by: Shuwei Wu <shuweiwoo@163.com>
> ---
> Changes in v2:
> - Rename k1_thermal.c to k1_tsensor.c for better hardware alignment
> - Move driver to drivers/thermal/spacemit/
> - Add Kconfig/Makefile for spacemit and update top-level build files
> - Refactor names, style, code alignment, and comments
> - Simplify probe and error handling
> ---
>  drivers/thermal/Kconfig               |   2 +
>  drivers/thermal/Makefile              |   1 +
>  drivers/thermal/spacemit/Kconfig      |  19 +++
>  drivers/thermal/spacemit/Makefile     |   3 +
>  drivers/thermal/spacemit/k1_tsensor.c | 283 ++++++++++++++++++++++++++++++++++
>  5 files changed, 308 insertions(+)
> diff --git a/drivers/thermal/spacemit/k1_tsensor.c b/drivers/thermal/spacemit/k1_tsensor.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..f164754e807ddd311c8cf98bcc074fd580514aa2
> --- /dev/null
> +++ b/drivers/thermal/spacemit/k1_tsensor.c

...

> +static void k1_tsensor_init(struct k1_tsensor *ts)
> +{

Configuration of K1_TSU_PCTRL2 (offset 0x04) is removed in this
revision, but why? Isn't it necessary for the sensor to function?

And you didn't ask my question raised in v1 about the source of 24MHz
clock. I still suspect whether the binding is complete or not.

> +	u32 val;
> +
> +	/* Disable all the interrupts */
> +	writel(0xffffffff, ts->base + K1_TSENSOR_INT_EN_REG);
> +
> +	/* Configure ADC sampling time and filter period */
> +	val = readl(ts->base + K1_TSENSOR_TIME_REG);
> +	val &= ~K1_TSENSOR_TIME_MASK;
> +	val |= K1_TSENSOR_TIME_FILTER_PERIOD |
> +		K1_TSENSOR_TIME_ADC_CNT_RST |
> +		K1_TSENSOR_TIME_WAIT_REF_CNT;

It's more natural to align K1_TSENSOR_TIME_ADC_CNT_RST and other
following constants with K1_TSENSOR_TIME_FILTER_PERIOD. This applies for
other multiple-line assignments, too.

...

> +static int k1_tsensor_probe(struct platform_device *pdev)
> +{

...

> +	for (i = 0; i < MAX_SENSOR_NUMBER; ++i) {
> +		ts->ch[i].id = i;
> +		ts->ch[i].ts = ts;
> +		ts->ch[i].tzd = devm_thermal_of_zone_register(dev, i, ts->ch + i, &k1_tsensor_ops);
> +		if (IS_ERR(ts->ch[i].tzd))
> +			return PTR_ERR(ts->ch[i].tzd);

Would emitting a error message with dev_err_probe() help here?

> +
> +		/* Attach sysfs hwmon attributes for userspace monitoring */
> +		ret = devm_thermal_add_hwmon_sysfs(dev, ts->ch[i].tzd);
> +		if (ret)
> +			dev_warn(dev, "Failed to add hwmon sysfs attributes\n");
> +
> +		k1_tsensor_enable_irq(ts->ch + i);
> +	}
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;

Same as the above question.

> +	ret = devm_request_threaded_irq(dev, irq, NULL,
> +					k1_tsensor_irq_thread,
> +					IRQF_ONESHOT, "k1_tsensor", ts);
> +	if (ret < 0)
> +		return ret;

Same as above.

Besides these questions, the driver itself looks pretty nice to me :)

Best regards,
Yao Zi

