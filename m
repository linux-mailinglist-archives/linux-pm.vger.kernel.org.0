Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851832116B1
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jul 2020 01:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgGAXgo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jul 2020 19:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgGAXgo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2020 19:36:44 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA1FC08C5C1;
        Wed,  1 Jul 2020 16:36:44 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id m26so14724846lfo.13;
        Wed, 01 Jul 2020 16:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TARMjYdHjjq3zj3UdYugq16yVCkI0yHEqNSthzPBnjA=;
        b=Clb1fkeGHtH5meU1AUmTh/DrSXEJKzyyUHougWi7iLO/PnCVM/KT/Qfl5gObcxYIOf
         poxGIyQtI77yF3t5Uu5k+sO3j+gtvSxhoNu++hYXaMAfbz87fNyEJUIgOl2Qor6XF8ZO
         AOIYeudjgV+vLLwJA37SnQWJZ9bzmWP9L5JJASIJdhDVJWvLbQ76dz1UNHc9Cn6Ob7aJ
         jjDYitbCsYIZH3BdqPaZY3cuPmTXRlb2p+eIQL1roJcLJzW9+A/ufuhvPMEjtcoM26Yx
         LGkrRo+rktmXODPrvEPVbmy+A/4PTcxNhGXIJZj8rT/G9//GdE6zHSxE6yqdECukvJrN
         ZE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TARMjYdHjjq3zj3UdYugq16yVCkI0yHEqNSthzPBnjA=;
        b=fTzhxPi7LjEyIJJ75babB9jLbnNMJHxZa7Ts9y2No4K1dtHvwDA418UFbqUjC7Wdrt
         JTnuS+MGQYYkZDCvqfYpwUCuBnQfnyTrbL7DZEs63rJklBhePh7kSA5GgY0oSy4G7nki
         s9px/yxTKJbcPZuSTp+cEdnLQ5aS9kZigTvJRodN2aJtHbfcL9NAClFD+T1GCwSCVhnc
         0nv5VblQKO4QNbJ63HeL8FATjw8fa1nWYqPxjzL6hTAqJKcshMotRnG29Wsgbe29qADF
         dgpg/dQj2KG2gxQW0FSRt6o55rhZftVM9KCLFSwNVk8WaNVJ2V0YU8OmNOY5sKjhC7oN
         AC8A==
X-Gm-Message-State: AOAM5331pR8HSRiXQDtxXAXB35l92VPx7NOY5ha0/lmn+FfJLTIdOx3q
        AyDhWbkZlaOA75Lm5H1/2lNYzTAMY3Y=
X-Google-Smtp-Source: ABdhPJzpjVfIcRoIVtpwV3y58+IISkU9q95ir4JljE24TYlCKzQbPSQXrlZCICbOftVA0366nD51Fw==
X-Received: by 2002:a19:4805:: with SMTP id v5mr16722713lfa.75.1593646602112;
        Wed, 01 Jul 2020 16:36:42 -0700 (PDT)
Received: from [192.168.2.145] (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.googlemail.com with ESMTPSA id u19sm2551087lju.63.2020.07.01.16.36.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 16:36:41 -0700 (PDT)
Subject: Re: [PATCH v4 28/37] memory: tegra: Register as interconnect provider
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
References: <20200609131404.17523-1-digetx@gmail.com>
 <20200609131404.17523-29-digetx@gmail.com>
 <aec831a6-a7ad-6bcc-4e15-c44582f7568e@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <82d27a47-f189-6609-a584-c9ca1b35a76c@gmail.com>
Date:   Thu, 2 Jul 2020 02:36:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <aec831a6-a7ad-6bcc-4e15-c44582f7568e@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

01.07.2020 20:12, Georgi Djakov пишет:
> Hi Dmitry,
> 
> Thank you for updating the patches!

Hello, Georgi!

Thank you for the review!

> On 6/9/20 16:13, Dmitry Osipenko wrote:
>> Now memory controller is a memory interconnection provider. This allows us
>> to use interconnect API in order to change memory configuration.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/memory/tegra/Kconfig |   1 +
>>  drivers/memory/tegra/mc.c    | 114 +++++++++++++++++++++++++++++++++++
>>  drivers/memory/tegra/mc.h    |   8 +++
>>  include/soc/tegra/mc.h       |   3 +
>>  4 files changed, 126 insertions(+)
>>
>> diff --git a/drivers/memory/tegra/Kconfig b/drivers/memory/tegra/Kconfig
>> index 5bf75b316a2f..7055fdef2c32 100644
>> --- a/drivers/memory/tegra/Kconfig
>> +++ b/drivers/memory/tegra/Kconfig
>> @@ -3,6 +3,7 @@ config TEGRA_MC
>>  	bool "NVIDIA Tegra Memory Controller support"
>>  	default y
>>  	depends on ARCH_TEGRA
>> +	select INTERCONNECT
>>  	help
>>  	  This driver supports the Memory Controller (MC) hardware found on
>>  	  NVIDIA Tegra SoCs.
>> diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
>> index 772aa021b5f6..7ef7ac9e103e 100644
>> --- a/drivers/memory/tegra/mc.c
>> +++ b/drivers/memory/tegra/mc.c
>> @@ -594,6 +594,118 @@ static __maybe_unused irqreturn_t tegra20_mc_irq(int irq, void *data)
>>  	return IRQ_HANDLED;
>>  }
>>  
>> +static int tegra_mc_icc_set(struct icc_node *src, struct icc_node *dst)
>> +{
>> +	return 0;
>> +}
>> +
>> +static int tegra_mc_icc_aggregate(struct icc_node *node,
>> +				  u32 tag, u32 avg_bw, u32 peak_bw,
>> +				  u32 *agg_avg, u32 *agg_peak)
>> +{
>> +	*agg_avg = min((u64)avg_bw + (*agg_avg), (u64)U32_MAX);
>> +	*agg_peak = max(*agg_peak, peak_bw);
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * Memory Controller (MC) has few Memory Clients that are issuing memory
>> + * bandwidth allocation requests to the MC interconnect provider. The MC
>> + * provider aggregates the requests and then sends the aggregated request
>> + * up to the External Memory Controller (EMC) interconnect provider which
>> + * re-configures hardware interface to External Memory (EMEM) in accordance
>> + * to the required bandwidth. Each MC interconnect node represents an
>> + * individual Memory Client.
>> + *
>> + * Memory interconnect topology:
>> + *
>> + *               +----+
>> + * +--------+    |    |
>> + * | TEXSRD +--->+    |
>> + * +--------+    |    |
>> + *               |    |    +-----+    +------+
>> + *    ...        | MC +--->+ EMC +--->+ EMEM |
>> + *               |    |    +-----+    +------+
>> + * +--------+    |    |
>> + * | DISP.. +--->+    |
>> + * +--------+    |    |
>> + *               +----+
>> + */
>> +static int tegra_mc_interconnect_setup(struct tegra_mc *mc)
>> +{
>> +	struct icc_onecell_data *data;
>> +	struct icc_node *node;
>> +	unsigned int num_nodes;
>> +	unsigned int i;
>> +	int err;
>> +
>> +	/* older device-trees don't have interconnect properties */
>> +	if (!of_find_property(mc->dev->of_node, "#interconnect-cells", NULL))
>> +		return 0;
>> +
>> +	num_nodes = mc->soc->num_clients;
>> +
>> +	data = devm_kzalloc(mc->dev, struct_size(data, nodes, num_nodes),
>> +			    GFP_KERNEL);
>> +	if (!data)
>> +		return -ENOMEM;
>> +
>> +	mc->provider.dev = mc->dev;
>> +	mc->provider.set = tegra_mc_icc_set;
> 
> Hmm, maybe the core should not require a set() implementation and we can
> just make it optional instead. Then the dummy function would not be needed.

Eventually this dummy function might become populated with a memory
latency allowness programming. I could add a comment into that function
in the next version, saying that it's to-be-done for now.

>> +	mc->provider.data = data;
>> +	mc->provider.xlate = of_icc_xlate_onecell;
>> +	mc->provider.aggregate = tegra_mc_icc_aggregate;
>> +
>> +	err = icc_provider_add(&mc->provider);
>> +	if (err)
>> +		goto err_msg;
> 
> Nit: I am planning to re-organize some of the existing drivers to call
> icc_provider_add() after the topology is populated. Could you please move
> this after the nodes are created and linked.

Are you planning to remove the provider's list-head initialization from
the icc_provider_add() [1] and move it to the individual provider
drivers, correct?

[1]
https://elixir.bootlin.com/linux/v5.8-rc3/source/drivers/interconnect/core.c#L977

If yes, then it should be easy to move the icc_provider_add() in the
case of this driver. Otherwise, please give some more clarification.

Please notice that the same "node" variable is used for both creation
and linking of the nodes to the provider here, making code nice and
clean. And thus, the provider's list-head should be initialized before
the linking.

...
> The rest looks good to me!

Thanks!
