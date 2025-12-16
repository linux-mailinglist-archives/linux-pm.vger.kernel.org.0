Return-Path: <linux-pm+bounces-39629-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C366ACC1EC1
	for <lists+linux-pm@lfdr.de>; Tue, 16 Dec 2025 11:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BCF86301824C
	for <lists+linux-pm@lfdr.de>; Tue, 16 Dec 2025 10:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6666E32E15B;
	Tue, 16 Dec 2025 10:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.b="WBalnqKO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail58.out.titan.email (mail58.out.titan.email [209.209.25.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FCB32E12B
	for <linux-pm@vger.kernel.org>; Tue, 16 Dec 2025 10:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.209.25.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765880104; cv=none; b=OGFVBcqsyx8hACji6Nt99LDuHad1jMSkwGrE5gTfYfIX1YezVZfeN8uBGjzpTP/ucHvdgi6aYhsbXt0Duj11112dPqxatV2CJg9WxmjVoCWLcD/FR9/UY5BQ/lZEitbWRChS7xcYtVQ+LLNPjUuYZk1YPt9DBCRCk6zoebvFTqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765880104; c=relaxed/simple;
	bh=cPeanqZJkqu/FnYcumzArXWQTq8YNvwlugJh19yoXsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CemEMspJYWI/i+EejgZMzRDn/87GnXwqf4wiNGgYWMOLw404OC02JHqObV/gixG4WPzttPMvpKI0ycuK2+wAtoU/gmo9V/gwzvWaW88cfwmDwT3/oM6Afg3IJOdQKMx83i6Q4JhzPeCxeIBAsqSWRmSjf9Jg7miNgVlc2UkMIE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.b=WBalnqKO; arc=none smtp.client-ip=209.209.25.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Received: from localhost (localhost [127.0.0.1])
	by smtp-out.flockmail.com (Postfix) with ESMTP id 4dVt8c21w0z2xDS;
	Tue, 16 Dec 2025 10:14:56 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=JRYE7dZuS1EyQE3Ha8bBcmdg8NdStYsYqAqgvc7/9LQ=;
	c=relaxed/relaxed; d=ziyao.cc;
	h=to:subject:mime-version:date:from:cc:references:message-id:in-reply-to:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1765880096; v=1;
	b=WBalnqKOAoW25sYUqwKYrlMbSyNNpXVqfN7EF7jhqOVe2E3s1L4qYp4hr7pvThV7RcIdx4ay
	qtxtoxalS0/L8qkNry2nOh17pDBVHzE1GR4bkumqnoDBYEe6T0Bau7/Ccb4SMW/lEc2jvpG92US
	+KYseHiJnFFN6d/cJtmibi1U=
Received: from pie (unknown [117.171.66.90])
	by smtp-out.flockmail.com (Postfix) with ESMTPA id 4dVt8T6kbgz2xDl;
	Tue, 16 Dec 2025 10:14:49 +0000 (UTC)
Date: Tue, 16 Dec 2025 10:14:46 +0000
Feedback-ID: :me@ziyao.cc:ziyao.cc:flockmailId
From: Yao Zi <me@ziyao.cc>
To: wayne <shuweiwoo@163.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
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
Message-ID: <aUExFjJJh0rrRCdV@pie>
References: <20251216-patchv2-k1-thermal-v1-0-d4b31fe9c904@163.com>
 <20251216-patchv2-k1-thermal-v1-2-d4b31fe9c904@163.com>
 <aUDc-o63KJpY8xLG@pie>
 <68620b24-256f-4032-8bc0-911d94bfb616@163.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68620b24-256f-4032-8bc0-911d94bfb616@163.com>
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1765880096091703187.27573.8248559529016179629@prod-use1-smtp-out1001.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=TPG/S0la c=1 sm=1 tr=0 ts=69413120
	a=rBp+3XZz9uO5KTvnfbZ58A==:117 a=rBp+3XZz9uO5KTvnfbZ58A==:17
	a=kj9zAlcOel0A:10 a=MKtGQD3n3ToA:10 a=CEWIc4RMnpUA:10 a=VwQbUJbxAAAA:8
	a=7mOBRU54AAAA:8 a=Byx-y9mGAAAA:8 a=aEzJoT4k0w9bqF-TWZ8A:9
	a=CjuIK1q_8ugA:10 a=wa9RWnbW_A1YIeRBVszw:22 a=3z85VNIBY5UIEeAh_hcH:22
	a=NWVoK91CQySWRX1oVYDe:22

On Tue, Dec 16, 2025 at 05:31:06PM +0800, wayne wrote:
> |On 2025/12/16 12:16, |Yao Zi wrote:
> 
> > On Tue, Dec 16, 2025 at 10:00:36AM +0800, Shuwei Wu wrote:
> > > The thermal sensor on K1 supports monitoring five temperature zones.
> > > The driver registers these sensors with the thermal framework
> > > and supports standard operations:
> > > - Reading temperature (millidegree Celsius)
> > > - Setting high/low thresholds for interrupts
> > > 
> > > Signed-off-by: Shuwei Wu <shuweiwoo@163.com>
> > > ---
> > > Changes in v2:
> > > - Rename k1_thermal.c to k1_tsensor.c for better hardware alignment
> > > - Move driver to drivers/thermal/spacemit/
> > > - Add Kconfig/Makefile for spacemit and update top-level build files
> > > - Refactor names, style, code alignment, and comments
> > > - Simplify probe and error handling
> > > ---
> > >   drivers/thermal/Kconfig               |   2 +
> > >   drivers/thermal/Makefile              |   1 +
> > >   drivers/thermal/spacemit/Kconfig      |  19 +++
> > >   drivers/thermal/spacemit/Makefile     |   3 +
> > >   drivers/thermal/spacemit/k1_tsensor.c | 283 ++++++++++++++++++++++++++++++++++
> > >   5 files changed, 308 insertions(+)
> > > diff --git a/drivers/thermal/spacemit/k1_tsensor.c b/drivers/thermal/spacemit/k1_tsensor.c
> > > new file mode 100644
> > > index 0000000000000000000000000000000000000000..f164754e807ddd311c8cf98bcc074fd580514aa2
> > > --- /dev/null
> > > +++ b/drivers/thermal/spacemit/k1_tsensor.c
> > ...
> > 
> > > +static void k1_tsensor_init(struct k1_tsensor *ts)
> > > +{
> > Configuration of K1_TSU_PCTRL2 (offset 0x04) is removed in this
> > revision, but why? Isn't it necessary for the sensor to function?
> > 
> > And you didn't ask my question raised in v1 about the source of 24MHz
> > clock. I still suspect whether the binding is complete or not.
> 
> Thank you for pointing this out, and I apologize for not addressing your
> question
> 
> about the 24MHz clock earlier.
> 
> In v1, I referenced the vendor's implementation, though their device tree
> 
> did not specify this clock for the thermal node.
> 
> After your review, I revisited the SpacemiT K1 clock tree published by the
> vendor,
> 
> and found that TSENSOR relies only on the APBC clock, which in turn is
> ultimately
> 
> sourced from the 24MHz crystal via the PLL.
> 
> Disabling the 24MHz clock for the syscon_apbc node in the device tree had no
> impact
> 
> on TSENSOR operation in my testing, so I did not include it in the binding.
> 
> As for the PCTRL2 configuration, I confirmed that its default value after
> reset is zero,
> 
> and changing its configuration had no effect on the temperature sensor's
> behavior.
> 
> This led me to remove the PCTRL2 configuration code in v2.

Thanks, this is a reasonable answer to me.

> > > +	u32 val;
> > > +
> > > +	/* Disable all the interrupts */
> > > +	writel(0xffffffff, ts->base + K1_TSENSOR_INT_EN_REG);
> > > +
> > > +	/* Configure ADC sampling time and filter period */
> > > +	val = readl(ts->base + K1_TSENSOR_TIME_REG);
> > > +	val &= ~K1_TSENSOR_TIME_MASK;
> > > +	val |= K1_TSENSOR_TIME_FILTER_PERIOD |
> > > +		K1_TSENSOR_TIME_ADC_CNT_RST |
> > > +		K1_TSENSOR_TIME_WAIT_REF_CNT;
> > It's more natural to align K1_TSENSOR_TIME_ADC_CNT_RST and other
> > following constants with K1_TSENSOR_TIME_FILTER_PERIOD. This applies for
> > other multiple-line assignments, too.
> > 
> > ...
> > 
> > > +static int k1_tsensor_probe(struct platform_device *pdev)
> > > +{
> > ...
> > 
> > > +	for (i = 0; i < MAX_SENSOR_NUMBER; ++i) {
> > > +		ts->ch[i].id = i;
> > > +		ts->ch[i].ts = ts;
> > > +		ts->ch[i].tzd = devm_thermal_of_zone_register(dev, i, ts->ch + i, &k1_tsensor_ops);
> > > +		if (IS_ERR(ts->ch[i].tzd))
> > > +			return PTR_ERR(ts->ch[i].tzd);
> > Would emitting a error message with dev_err_probe() help here?
> 
> In v1, the reviewer mentioned that it is no need to print extra error
> message.
> 
> See:
> 
> https://lore.kernel.org/spacemit/20251127225848-GYA1797866@gentoo.org/T/#mc335bea36323d2d8b3afb09aa40c9c7160440d39

Oops, yeah, I definitely read this link before, but forgot it. So
keeping it as-is is okay.

> > > +
> > > +		/* Attach sysfs hwmon attributes for userspace monitoring */
> > > +		ret = devm_thermal_add_hwmon_sysfs(dev, ts->ch[i].tzd);
> > > +		if (ret)
> > > +			dev_warn(dev, "Failed to add hwmon sysfs attributes\n");
> > > +
> > > +		k1_tsensor_enable_irq(ts->ch + i);
> > > +	}
> > > +
> > > +	irq = platform_get_irq(pdev, 0);
> > > +	if (irq < 0)
> > > +		return irq;
> > Same as the above question.
> Ditto.
> > > +	ret = devm_request_threaded_irq(dev, irq, NULL,
> > > +					k1_tsensor_irq_thread,
> > > +					IRQF_ONESHOT, "k1_tsensor", ts);
> > > +	if (ret < 0)
> > > +		return ret;
> > Same as above.
> Ditto.
> > Besides these questions, the driver itself looks pretty nice to me :)
> > 
> > Best regards,
> > Yao Zi
> 
> |Please let me know if you need further details or test results. Thank you
> for reviewing my patch. Best regards, Shuwei Wu|
> 
> 

Regards,
Yao Zi

