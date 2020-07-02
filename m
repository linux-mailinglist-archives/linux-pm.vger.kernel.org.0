Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21902212370
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jul 2020 14:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbgGBMgQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jul 2020 08:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728977AbgGBMgL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jul 2020 08:36:11 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B83C08C5C1
        for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2020 05:36:11 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id q15so26582890wmj.2
        for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2020 05:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=asqQgjrfbyVj5Iv56jP1w9WQe+0TnQ0unPu7ewQBCcI=;
        b=BzO7p5WkwqdLrsiOO/zuKx5aLf49H4McNOyySPs8CwaC8u4rY661E3yg7jqxp136OO
         k6IZ2DKG3Gs/UKmmG6k+xrYKIeRxahRGAdFc1zc3rqA32vxJD04Csq9VhYwzlqE607LW
         qQfrZDCEbkHceyY6rjiowWtGiKtX1iaN3nOssrhWBVPXmTJY3u0NHkDgow4sL0ORBG33
         Vzz2Acep2RpeRdWZnP7dfneRKmtdJNU4i98Eh3PjlSVipZ2vQcJhDZUfDZ1+w1cWOmZV
         1Ul5zAahVA1ThXFY2+lyU7jTrgwJ8XZ1GOl7lrX84Iem0XVIrc8wAfzXB17E0l4/Sqt6
         Jd0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=asqQgjrfbyVj5Iv56jP1w9WQe+0TnQ0unPu7ewQBCcI=;
        b=H/YePco1nzgNFES0aAR0h1Itc//G8W6RHCSTVBYKuQBlDzBhmMAJRd6u+pO3uqiDT9
         Kh1Kghl4/B2I9W359RN9tOcGDwnKF1poHCfS8oikwIyg16utIji66bIyVsQr6iI5Ydyy
         dPpBGz6yLha7KNcucsu9MlxG2LNRPyT1Y3AvANXkUxloh05Z+Rl5llL1DdEiBy0OlOad
         2JZti9pPIouApcgmRRwT2S1IqLzNkxeUaEIm/g/4a4Cp+SOTgDZ+s73854pY4Oc9qiFs
         wRCi237HIJgbNpZcpKmunC03ff+YiMkFkp5kuVxtHQiXrmwWj866nrIFtotl2iM4Vcjo
         dhgg==
X-Gm-Message-State: AOAM530dCx0FRl1OSPhdesANDR01qsZljR9zuZAZu1kw7aOjSjpcahzW
        3jglALl3agjae7K5AW5WzeZqQw==
X-Google-Smtp-Source: ABdhPJzpsSNTFwsJ2jOvT+hV0tyZyibiFrV9YjDnkbsjPho2QDfe0MSy1Ocq4OuD+UaVm8B77u636w==
X-Received: by 2002:a7b:c043:: with SMTP id u3mr33511858wmc.185.1593693368746;
        Thu, 02 Jul 2020 05:36:08 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id g16sm11788693wrh.91.2020.07.02.05.36.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 05:36:08 -0700 (PDT)
Subject: Re: [PATCH v4 28/37] memory: tegra: Register as interconnect provider
To:     Dmitry Osipenko <digetx@gmail.com>
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
 <82d27a47-f189-6609-a584-c9ca1b35a76c@gmail.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <05cb459d-fc10-1537-eaea-df06f7566b6a@linaro.org>
Date:   Thu, 2 Jul 2020 15:36:07 +0300
MIME-Version: 1.0
In-Reply-To: <82d27a47-f189-6609-a584-c9ca1b35a76c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Dmitry,

On 7/2/20 02:36, Dmitry Osipenko wrote:
> 01.07.2020 20:12, Georgi Djakov пишет:
>> Hi Dmitry,
>>
>> Thank you for updating the patches!
> 
> Hello, Georgi!
> 
> Thank you for the review!
> 
>> On 6/9/20 16:13, Dmitry Osipenko wrote:
>>> Now memory controller is a memory interconnection provider. This allows us
>>> to use interconnect API in order to change memory configuration.
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  drivers/memory/tegra/Kconfig |   1 +
>>>  drivers/memory/tegra/mc.c    | 114 +++++++++++++++++++++++++++++++++++
>>>  drivers/memory/tegra/mc.h    |   8 +++
>>>  include/soc/tegra/mc.h       |   3 +
>>>  4 files changed, 126 insertions(+)
>>>
>>> diff --git a/drivers/memory/tegra/Kconfig b/drivers/memory/tegra/Kconfig
>>> index 5bf75b316a2f..7055fdef2c32 100644
>>> --- a/drivers/memory/tegra/Kconfig
>>> +++ b/drivers/memory/tegra/Kconfig
>>> @@ -3,6 +3,7 @@ config TEGRA_MC
>>>  	bool "NVIDIA Tegra Memory Controller support"
>>>  	default y
>>>  	depends on ARCH_TEGRA
>>> +	select INTERCONNECT
>>>  	help
>>>  	  This driver supports the Memory Controller (MC) hardware found on
>>>  	  NVIDIA Tegra SoCs.
>>> diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
>>> index 772aa021b5f6..7ef7ac9e103e 100644
>>> --- a/drivers/memory/tegra/mc.c
>>> +++ b/drivers/memory/tegra/mc.c
>>> @@ -594,6 +594,118 @@ static __maybe_unused irqreturn_t tegra20_mc_irq(int irq, void *data)
>>>  	return IRQ_HANDLED;
>>>  }
>>>  
>>> +static int tegra_mc_icc_set(struct icc_node *src, struct icc_node *dst)
>>> +{
>>> +	return 0;
>>> +}
>>> +
>>> +static int tegra_mc_icc_aggregate(struct icc_node *node,
>>> +				  u32 tag, u32 avg_bw, u32 peak_bw,
>>> +				  u32 *agg_avg, u32 *agg_peak)
>>> +{
>>> +	*agg_avg = min((u64)avg_bw + (*agg_avg), (u64)U32_MAX);
>>> +	*agg_peak = max(*agg_peak, peak_bw);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +/*
>>> + * Memory Controller (MC) has few Memory Clients that are issuing memory
>>> + * bandwidth allocation requests to the MC interconnect provider. The MC
>>> + * provider aggregates the requests and then sends the aggregated request
>>> + * up to the External Memory Controller (EMC) interconnect provider which
>>> + * re-configures hardware interface to External Memory (EMEM) in accordance
>>> + * to the required bandwidth. Each MC interconnect node represents an
>>> + * individual Memory Client.
>>> + *
>>> + * Memory interconnect topology:
>>> + *
>>> + *               +----+
>>> + * +--------+    |    |
>>> + * | TEXSRD +--->+    |
>>> + * +--------+    |    |
>>> + *               |    |    +-----+    +------+
>>> + *    ...        | MC +--->+ EMC +--->+ EMEM |
>>> + *               |    |    +-----+    +------+
>>> + * +--------+    |    |
>>> + * | DISP.. +--->+    |
>>> + * +--------+    |    |
>>> + *               +----+
>>> + */
>>> +static int tegra_mc_interconnect_setup(struct tegra_mc *mc)
>>> +{
>>> +	struct icc_onecell_data *data;
>>> +	struct icc_node *node;
>>> +	unsigned int num_nodes;
>>> +	unsigned int i;
>>> +	int err;
>>> +
>>> +	/* older device-trees don't have interconnect properties */
>>> +	if (!of_find_property(mc->dev->of_node, "#interconnect-cells", NULL))
>>> +		return 0;
>>> +
>>> +	num_nodes = mc->soc->num_clients;
>>> +
>>> +	data = devm_kzalloc(mc->dev, struct_size(data, nodes, num_nodes),
>>> +			    GFP_KERNEL);
>>> +	if (!data)
>>> +		return -ENOMEM;
>>> +
>>> +	mc->provider.dev = mc->dev;
>>> +	mc->provider.set = tegra_mc_icc_set;
>>
>> Hmm, maybe the core should not require a set() implementation and we can
>> just make it optional instead. Then the dummy function would not be needed.
> 
> Eventually this dummy function might become populated with a memory
> latency allowness programming. I could add a comment into that function
> in the next version, saying that it's to-be-done for now.

Ah ok! Sounds good, thanks for clarifying!

>>> +	mc->provider.data = data;
>>> +	mc->provider.xlate = of_icc_xlate_onecell;
>>> +	mc->provider.aggregate = tegra_mc_icc_aggregate;
>>> +
>>> +	err = icc_provider_add(&mc->provider);
>>> +	if (err)
>>> +		goto err_msg;
>>
>> Nit: I am planning to re-organize some of the existing drivers to call
>> icc_provider_add() after the topology is populated. Could you please move
>> this after the nodes are created and linked.
> 
> Are you planning to remove the provider's list-head initialization from
> the icc_provider_add() [1] and move it to the individual provider
> drivers, correct?

Yes, that would be the first step, but i need to post some patches first,
so let's keep it as-is for now. Sorry for the confusion.

Thanks,
Georgi
