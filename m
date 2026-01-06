Return-Path: <linux-pm+bounces-40329-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9850CFA11C
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 19:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F71E3037CDD
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 17:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FF23563C6;
	Tue,  6 Jan 2026 17:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="Rk0jrZL2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BCA3563DC;
	Tue,  6 Jan 2026 17:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767720601; cv=none; b=MX/5zX6Eaq/PHx1GuaQ9Kf/xgcVnRMX/6dde9F4HG+KJ+lZV4fQoHZHWyP255ZpCJ1aVFvnd8RsUq+8EXpJaqfljEs4qKV/H4JqaABi/thPNXG1p+prVq/4MFMf2y2FMefzsMaCfj8cl00b1vjJ+Nb96Nd6jJX8QvF8fgKjiOqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767720601; c=relaxed/simple;
	bh=u4uuqTQUdVSQFR40CmbeuCd7YWPpLNXfQChgviT0EYY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IkHibpavluvs3R4vE1/yfNjsS+/L2YpngdCzMzV3sSVxOzYQhSrDzJDuZi8UgFel8CJMriPlpzmtIWDvXl1Su5SS3rz0+v/LTfOR2VyARVWk+TYHNfNq3ma7UmWF+yDuFw1fWnh8q3NEMzdAkzZDP137nK6IVrxicI1RPFTFNMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=Rk0jrZL2; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=c3xQQo7dlQe+3ToJZk0WtJfo6q7i6BfPDImOGw/1mAY=; b=Rk0jrZL2JDiHAt8AM6gbN5vLDJ
	Q4407EBHUY56ExWkUEpmOVlHodGmpbUzQXxFu7XbiA0Kc7l6RDi9erVOuvSJTMkh1sZ+oaHlEqJJC
	q1ExTI3DGyPI9X1o5xF1Fy3jdD+wCSbR3hMLVWYxDMsJixdVx7y2R7xqeGzOYAM6s+1lb5lSfPKgQ
	Y7J1Tz+V4vXgzLH+IcPohDNqL2IPxrypuPQN3Fx4rSwz64KpQkckHNz3+u9FReveAwILFDfwvWWBt
	ZjZBmHubVtk0AhJgSrLLk4gL0mafptijqfN4P0iXEU6lOVCBOzD73clayjDcTUZHQ1BFjs7YehWFs
	yMchuuwg==;
Date: Tue, 6 Jan 2026 18:29:46 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Haotian Zhang <vulab@iscas.ac.cn>, Kevin Hilman <khilman@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, linux-omap@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] omap-cpufreq: Fix regulator resource leak in probe()
Message-ID: <20260106182946.1c54d769@kemnade.info>
In-Reply-To: <pjmwnxp6wae3bbmzmzys4r5szw6ywxphi4qtmpmg7jsqadc5fm@fvozoujr4mi5>
References: <20251215030327.1771-1-vulab@iscas.ac.cn>
	<20260105101412.0ac7baa7@kemnade.info>
	<pjmwnxp6wae3bbmzmzys4r5szw6ywxphi4qtmpmg7jsqadc5fm@fvozoujr4mi5>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Jan 2026 10:20:55 +0530
Viresh Kumar <viresh.kumar@linaro.org> wrote:

> On 05-01-26, 10:14, Andreas Kemnade wrote:
> > On Mon, 15 Dec 2025 11:03:27 +0800
> > Haotian Zhang <vulab@iscas.ac.cn> wrote:
> >   
> > > The current omap_cpufreq_probe() uses regulator_get() to obtain the MPU
> > > regulator but does not release it in omap_cpufreq_remove() or when
> > > cpufreq_register_driver() fails, leading to a potential resource leak.
> > > 
> > > Use devm_regulator_get() instead of regulator_get() so that the regulator
> > > resource is automatically released.
> > > 
> > > Fixes: 53dfe8a884e6 ("cpufreq: OMAP: scale voltage along with frequency")
> > > Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> > > ---
> > >  drivers/cpufreq/omap-cpufreq.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
> > > index bbb01d93b54b..f83f85996b36 100644
> > > --- a/drivers/cpufreq/omap-cpufreq.c
> > > +++ b/drivers/cpufreq/omap-cpufreq.c
> > > @@ -157,7 +157,7 @@ static int omap_cpufreq_probe(struct platform_device *pdev)
> > >  		return -EINVAL;
> > >  	}
> > >  
> > > -	mpu_reg = regulator_get(mpu_dev, "vcc");
> > > +	mpu_reg = devm_regulator_get(mpu_dev, "vcc");
> > >  	if (IS_ERR(mpu_reg)) {
> > >  		pr_warn("%s: unable to get MPU regulator\n", __func__);
> > >  		mpu_reg = NULL;
> > > @@ -169,7 +169,6 @@ static int omap_cpufreq_probe(struct platform_device *pdev)
> > >  		if (regulator_get_voltage(mpu_reg) < 0) {
> > >  			pr_warn("%s: physical regulator not present for MPU\n",
> > >  				__func__);
> > > -			regulator_put(mpu_reg);  
> > 
> > so it it not useable and could be released which is not done anymare 
> > with your patch. It is not an error path here.  
> 
> Right. Perhaps devm_regulator_put() here would be good enough.
> 
ok, didn't expect such a function, so that should be the cleanest approach.

> > >  			mpu_reg = NULL;  
> > 
> > And this should happen after removal, too. I feel some discomfort with
> > variables pointing to freed ressources. So I think rather add
> > the regulator_put and the = NULL to the remove function.  
> 
> I don't see a reason why this extra step should be performed after the driver is
> removed. `mpu_reg` can't be used after that.
> 
hmm, it is performed when the device is removed/unbound, which does not necessarily
mean the driver is removed. But that does not prevent trouble if something
is still trying to access stuff here after driver removal. So it is not really
helpful.

Hmm, how does a device gets bound to this driver?

Lets gets back to this very basic question. I am usually using CPUFREQ_DT.
Are there any signs of usage of this driver?

omap2plus_defconfig creates in .config
#
# CPU frequency scaling drivers
#
CONFIG_CPUFREQ_DT=m
# CONFIG_CPUFREQ_VIRT is not set
CONFIG_CPUFREQ_DT_PLATDEV=y
# CONFIG_ARM_OMAP2PLUS_CPUFREQ is not set
CONFIG_ARM_TI_CPUFREQ=y
# end of CPU Frequency scaling

So this thing is not used. Everything with omap2plus uses devicetree,
so probably no user at all for it. So I think we can deorbit the whole
thing.

But the fix is good for stable. So I would propose to add this
fix (to let it propagate to stable) and deorbit this driver.

Regards,
Andreas

