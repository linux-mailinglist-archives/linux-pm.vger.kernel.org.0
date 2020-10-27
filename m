Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0AF29C8F2
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 20:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1830029AbgJ0TbD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 15:31:03 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37914 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1830028AbgJ0TbC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 15:31:02 -0400
Received: by mail-lf1-f65.google.com with SMTP id c141so3838295lfg.5;
        Tue, 27 Oct 2020 12:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LvZumlP31qHBxjJEshej0bJc9X40oipjDpQPJKtO+GE=;
        b=ts2EcOPdVgCrYrhoDDml0MtDIH3KavQ4606q/jt1JejvkszziZ44//Jt9P6LcuMzsk
         tzu4TULHVLxyiWMaFYMuavSMcbldk/KSnW3GwlFdgb1G7b313aQaHDlzjEt2kVV8AvRb
         EvhM7MH1aK3LslL5t+waPaO17BK9v4G+gT6FgcDgVbM4gp2N4YsrhDfSk0Avq+SwctFC
         L8ckkTMLLop0IyEtDbwEnylrbtkLefRjFTXYuJvXjUzdnP3ECmUGZj7KHCNUn+Gb5Cem
         VI8b6VVn0ohGnS/PRzKC+aLKrZdzgNd5vTAPjpglE+gUovKmeZlCv+ZIiGZabwNcK+Ot
         5yTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LvZumlP31qHBxjJEshej0bJc9X40oipjDpQPJKtO+GE=;
        b=VhnePu68dgl7EoH52n+7r9q9RDuyeXMoIF9vhYHReI6W/5/z7kWY43Qm8jMEZdeZ1l
         M+eseBiKw84ZlpmN4tbvfuLX7Cq61N4MP4060QcIGEGMjO4L/rCBqRFRar6bkyCJ99TH
         +9wvgyQ+caTx4mjenfTjJAGAuDATav8dPAlr8nqCskJ//c3E+szlFWVrIt2wlf8QeulN
         JmCR0WHUTlCxojGGvAYTxcJPKiJRFndVOD6IitbHU5opPUd7M27K0C4BW9XOW2PI84Ac
         2TvRyMgFxK5jTILNbDnRfaBzmxkjz146gPnKPJcFdJ3ql9zbebF3mZZtlcuoFmsxQ93w
         DoNg==
X-Gm-Message-State: AOAM531GxS8fMJ5PuKDUpbXkQe6ssGX5qv1vl9HkBz+7bvdkvb7viPq+
        jcVywkLFq752sAsTjw9AvRe/2auzQcw=
X-Google-Smtp-Source: ABdhPJzQz9k2oel0unqHbNe5Kaic8WjLVyQwtS9/rIWkZ1OeRnczlYmf7TF9r4TQK3gsFB+zVprSQQ==
X-Received: by 2002:ac2:5633:: with SMTP id b19mr1536460lff.334.1603827058806;
        Tue, 27 Oct 2020 12:30:58 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.googlemail.com with ESMTPSA id o22sm290553ljg.122.2020.10.27.12.30.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 12:30:58 -0700 (PDT)
Subject: Re: [PATCH v6 29/52] memory: tegra-mc: Add interconnect framework
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-30-digetx@gmail.com> <20201027134805.GJ1822510@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <aec58c94-2c12-fcb6-6b36-2043a35bd9e2@gmail.com>
Date:   Tue, 27 Oct 2020 22:30:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201027134805.GJ1822510@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

27.10.2020 16:48, Thierry Reding пишет:
...
>> +static struct icc_node_data *
>> +tegra_mc_of_icc_xlate_extended(struct of_phandle_args *spec, void *data)
>> +{
>> +	struct icc_provider *provider = data;
>> +	unsigned int idx = spec->args[0];
>> +	struct icc_node_data *ndata;
>> +	struct icc_node *node;
>> +
>> +	list_for_each_entry(node, &provider->nodes, node_list) {
>> +		if (node->id != idx)
>> +			continue;
>> +
>> +		ndata = kzalloc(sizeof(*ndata), GFP_KERNEL);
>> +		if (!ndata)
>> +			return ERR_PTR(-ENOMEM);
>> +
>> +		ndata->node = node;
>> +
>> +		/* these clients are isochronous by default on all SoCs */
>> +		if (strstarts(node->name, "display") ||
>> +		    strstarts(node->name, "ptc") ||
>> +		    strstarts(node->name, "vi"))
>> +			ndata->tag = TEGRA_MC_ICC_TAG_ISO;
> 
> This looks like something that might be better left to the drivers to
> decide. Doing this here seems okay for now, but I suspect that this will
> get fairly complicated to keep accurate as we add more clients later on.

It's not a problem to add a driver-specific hook for the
xlate_extended(), like it's done for the aggregate() and set() hooks below.

...
>> +static int tegra_mc_interconnect_setup(struct tegra_mc *mc)
>> +{
>> +	struct icc_node *node;
>> +	unsigned int i;
>> +	int err;
>> +
>> +	/* older device-trees don't have interconnect properties */
>> +	if (!of_find_property(mc->dev->of_node, "#interconnect-cells", NULL) ||
>> +	    !mc->soc->icc_ops)
>> +		return 0;
> 
> This indicates that this property is indeed optional, so the bindings
> should reflect that.

Yes, but the property isn't optional for the newer binding. Does it
really need to be documented as optional?

>> +	mc->provider.dev = mc->dev;
>> +	mc->provider.data = &mc->provider;
>> +	mc->provider.set = mc->soc->icc_ops->set;
>> +	mc->provider.aggregate = mc->soc->icc_ops->aggregate;
>> +	mc->provider.xlate_extended = tegra_mc_of_icc_xlate_extended;
>> +
>> +	err = icc_provider_add(&mc->provider);
>> +	if (err)
>> +		goto err_msg;
>> +
>> +	/* create Memory Controller node */
>> +	node = icc_node_create(TEGRA_ICC_MC);
>> +	err = PTR_ERR_OR_ZERO(node);
>> +	if (err)
>> +		goto del_provider;
>> +
>> +	node->name = "Memory Controller";
>> +	icc_node_add(node, &mc->provider);
>> +
>> +	/* link Memory Controller to External Memory Controller */
>> +	err = icc_link_create(node, TEGRA_ICC_EMC);
>> +	if (err)
>> +		goto remove_nodes;
>> +
>> +	for (i = 0; i < mc->soc->num_clients; i++) {
>> +		/* create MC client node */
>> +		node = icc_node_create(mc->soc->clients[i].id);
>> +		err = PTR_ERR_OR_ZERO(node);
>> +		if (err)
>> +			goto remove_nodes;
>> +
>> +		node->name = mc->soc->clients[i].name;
>> +		icc_node_add(node, &mc->provider);
> 
> I'm not fully familiar with how these nodes are set up, but would it be
> possible to set the isochronous tag here already? I'd still prefer this
> to be up to the drivers because I think that nicely localizes the
> device-specific information in the driver, but if that's not an option,
> then doing it here, based on lookup data from the MC clients table
> sounds like the next best thing.

The tag needs to be set by xlate_extended(), otherwise it won't be
applied by default.

https://elixir.bootlin.com/linux/v5.10-rc1/source/drivers/interconnect/core.c#L501

...
>>  static int tegra_mc_probe(struct platform_device *pdev)
>>  {
>>  	struct resource *res;
>> @@ -747,6 +874,8 @@ static int tegra_mc_probe(struct platform_device *pdev)
>>  		}
>>  	}
>>  
>> +	tegra_mc_interconnect_setup(mc);
> 
> Do you want to check the return value here for errors? If not, might as
> well make the function return void.

The error won't be fatal and shouldn't block the rest functionality of
the MC driver.

It's possible to return void, but it's not necessary because compiler
will take care of optimizing the code and to me it's more consistent to
have error code returned by the function.

Perhaps should be better to just add a comment telling that error
skipping is intentional?

...
>> diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
>> index afa3ba45c9e6..abeb6a2cc36a 100644
>> --- a/drivers/memory/tegra/mc.h
>> +++ b/drivers/memory/tegra/mc.h
>> @@ -115,4 +115,12 @@ extern const struct tegra_mc_soc tegra132_mc_soc;
>>  extern const struct tegra_mc_soc tegra210_mc_soc;
>>  #endif
>>  
>> +/*
>> + * These IDs are for internal use of Tegra's ICC, the values are chosen
>> + * such that they don't conflict with the device-tree ICC node IDs.
>> + */
>> +#define TEGRA_ICC_EMC		1000
>> +#define TEGRA_ICC_EMEM		2000
>> +#define TEGRA_ICC_MC		3000
> 
> Sounds to me like these could equally well be 1000, 1001 and 1002. Why
> leave these large holes in the number space?

There is no specific reason, I can change the numbers if you want.
