Return-Path: <linux-pm+bounces-12462-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 534EA957014
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 18:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FAAC2834B3
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 16:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E55175548;
	Mon, 19 Aug 2024 16:20:02 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5C9171E40;
	Mon, 19 Aug 2024 16:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724084402; cv=none; b=EIzU3hvHPUE8irTVy9sVDnStzXlC7e58cVhjiUR2fq2tns4F+Gw3F4JVJaE1Z3liFMQHCmdIZOGx1FyFrEGszsHrx5yKcC0QVtji7X8va0J9DT2A09bo0uThYCoQNT0HOVuAzVsSJ0Bcl84hWFoXHze0ndsQ764DD1tzwJ1LJss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724084402; c=relaxed/simple;
	bh=5SSV7DkFmOl+bKJkrZT6bYYiWZ6Sy0xh6MTS9UC0VVI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hIqDGXO6hyd+EXpssQC2BA8B/lJpQ87fG9jRlPNIe3jKp682wkq/mxc+ZZ24uxd0q6IVLdzNjadn1g2mcSwTLOWklqLiWeiD2dyQ64KF9/8GSxJzJMF3jlSnMWvJMEmv0i4XAkblczcvBIEJLg8p6LH1ZCmG+WymLDqy81yyMzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wnd5d3wgkz6K6j4;
	Tue, 20 Aug 2024 00:16:53 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B69C51400DD;
	Tue, 20 Aug 2024 00:19:56 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 19 Aug
 2024 17:19:56 +0100
Date: Mon, 19 Aug 2024 17:19:54 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Anup Patel
	<anup@brainfault.org>, Paul Walmsley <paul.walmsley@sifive.com>, "Palmer
 Dabbelt" <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	<linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 2/4] cpuidle: riscv-sbi: Use scoped device node handling
 to simplify error paths
Message-ID: <20240819171954.0000600d@Huawei.com>
In-Reply-To: <20240819171313.00004677@Huawei.com>
References: <20240816150931.142208-1-krzysztof.kozlowski@linaro.org>
	<20240816150931.142208-2-krzysztof.kozlowski@linaro.org>
	<20240819171313.00004677@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 19 Aug 2024 17:13:13 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Fri, 16 Aug 2024 17:09:29 +0200
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
> > Obtain the device node reference with scoped/cleanup.h to reduce error
> > handling and make the code a bit simpler.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>  
> The original code looks suspect. See below.

Whilst here...  Why not do similar for state_node to avoid
the delayed return check.
Existing code
	{
		state_node = of_get_cpu_state_node(cpu_node, i - 1);
		if (!state_node)
			break;

		ret = sbi_dt_parse_state_node(state_node, &states[i]);
		of_node_put(state_node);

		if (ret)
			//another bug here on holding cpu_node btw.
			return ret;
		pr_debug("sbi-state %#x index %d\n", states[i], i);
	}
//I think only path to this is is early break above.
	if (i != state_count) {
		ret = -ENODEV;
		goto fail;
	}
Can be something like

	{
		struct device_node *state_node __free(device_node) =
			= of_get-cpu_State_nod(cpu_node, i - 1);
	
		if (!state_node)
			return -ENODEV;

		ret = sbi_dt_parse_state_node(state_node, &states[i]);
		if (ret)
			return ret;

		pr_debug("sbi-state %#x index %d\n", states[i], i);
	}
		

> 
> > ---
> >  drivers/cpuidle/cpuidle-riscv-sbi.c | 21 +++++++--------------
> >  1 file changed, 7 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
> > index a6e123dfe394..5bb3401220d2 100644
> > --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> > +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> > @@ -8,6 +8,7 @@
> >  
> >  #define pr_fmt(fmt) "cpuidle-riscv-sbi: " fmt
> >  
> > +#include <linux/cleanup.h>
> >  #include <linux/cpuhotplug.h>
> >  #include <linux/cpuidle.h>
> >  #include <linux/cpumask.h>
> > @@ -236,19 +237,16 @@ static int sbi_cpuidle_dt_init_states(struct device *dev,
> >  {
> >  	struct sbi_cpuidle_data *data = per_cpu_ptr(&sbi_cpuidle_data, cpu);
> >  	struct device_node *state_node;
> > -	struct device_node *cpu_node;
> >  	u32 *states;
> >  	int i, ret;
> >  
> > -	cpu_node = of_cpu_device_node_get(cpu);
> > +	struct device_node *cpu_node __free(device_node) = of_cpu_device_node_get(cpu);
> >  	if (!cpu_node)
> >  		return -ENODEV;
> >  
> >  	states = devm_kcalloc(dev, state_count, sizeof(*states), GFP_KERNEL);
> > -	if (!states) {
> > -		ret = -ENOMEM;
> > -		goto fail;
> > -	}
> > +	if (!states)
> > +		return -ENOMEM;
> >  
> >  	/* Parse SBI specific details from state DT nodes */
> >  	for (i = 1; i < state_count; i++) {
> > @@ -264,10 +262,8 @@ static int sbi_cpuidle_dt_init_states(struct device *dev,
> >  
> >  		pr_debug("sbi-state %#x index %d\n", states[i], i);
> >  	}
> > -	if (i != state_count) {
> > -		ret = -ENODEV;
> > -		goto fail;
> > -	}
> > +	if (i != state_count)
> > +		return -ENODEV;
> >  
> >  	/* Initialize optional data, used for the hierarchical topology. */
> >  	ret = sbi_dt_cpu_init_topology(drv, data, state_count, cpu);  
> The handling of error ret from here doesn't free the node.
> 
> Bug or something subtle I'm missing?
> 
> If it's a bug, then fixes tag.

> 
> 
> > @@ -277,10 +273,7 @@ static int sbi_cpuidle_dt_init_states(struct device *dev,
> >  	/* Store states in the per-cpu struct. */
> >  	data->states = states;
> >  
> > -fail:
> > -	of_node_put(cpu_node);
> > -
> > -	return ret;
> > +	return 0;
> >  }
> >  
> >  static void sbi_cpuidle_deinit_cpu(int cpu)  
> 


