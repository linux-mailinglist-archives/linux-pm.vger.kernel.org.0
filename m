Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2190F148531
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2020 13:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733160AbgAXMcU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Jan 2020 07:32:20 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40851 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732686AbgAXMcT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jan 2020 07:32:19 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so1767523wrn.7
        for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2020 04:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2DvfRhHynNvctGDhIqeR+A7ckBUP/GgKqU+ftyJEj8E=;
        b=QcqxNJa4FJnDj4SpaEVyp4D2B2IPaYqBMGC/maq+JnQRzhU+NEBZ0pf95egBsFNbBL
         J17y6kLTgygg5I9NbLrTchWHd0fqhQUIxqUYDKH3tm4NdEeydVGoOe7fv3mbbfRtaLmz
         NARCH2NodNr+ar1IIC+GVuwTKcXknaDWjgZkVjHmgOxdCG7HXKNq0Fz+3QehMXKKwtRy
         k1NWeE/Y4qW3i1uaq8YwWRJRt1lOFRa6+IP9U6pPUVKOrhsSCB4yK9yrN2PBGGeVSfkI
         UH829eXz53LcIGiUvvMabQ391A0YnIl2J9FYoUHaU2Af6rq6v632/d9MUsh4RBbon99H
         b6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2DvfRhHynNvctGDhIqeR+A7ckBUP/GgKqU+ftyJEj8E=;
        b=iVjsgwM2foQ5ZYQHHkvQg19Yp/SQxW4uNFDvqC2iPs8yxmnMO7ZWyYDfmiWyWHhsln
         LkT2vnEf1TSEUNz8tM9AEo5jEgg5QnLr02w7FBC5nO5tgQwEma4YCQox55QuIWqf1FSr
         Son0zbMbO4qlFbQ9F17uJc3O6Y/EM9kSs4xhuPyeSp+H4MQVIihBUsEt5oXRxYSrONfh
         SdBRRofJ1dkYmESTrDSWLtVTGnHhvcnPxUfTcUY40AixoPRfQW/LrQsj4tAs37dPjJ/E
         CiPiAM+JF7EtcLR1L1ZtZqR6KUAq+fuUu5OYNLQ0iS39IMJeyrVil3lJ57tmO0mmsUO+
         cp9w==
X-Gm-Message-State: APjAAAVfQV8nMThEJdpOMImUovMb32K3YIhIClW5nCp9jMCB3wTq5DMN
        WkZxVA1ccz5mcLkIYaiGIC1o3w==
X-Google-Smtp-Source: APXvYqzDAdDLZuyqLkswFIwJJPxGUAZE5C98kj6jNyQtTG2iqwxJUaeWHUIDU3//WV6i1/A3Ttkyzg==
X-Received: by 2002:adf:ef92:: with SMTP id d18mr3961599wro.234.1579869136650;
        Fri, 24 Jan 2020 04:32:16 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id n3sm6982315wrs.8.2020.01.24.04.32.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jan 2020 04:32:15 -0800 (PST)
Subject: Re: [RFC PATCH v3 5/7] devfreq: exynos-bus: Add interconnect
 functionality to exynos-bus
To:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        leonard.crestez@nxp.com, m.szyprowski@samsung.com,
        b.zolnierkie@samsung.com, krzk@kernel.org
References: <20191220115653.6487-1-a.swigon@samsung.com>
 <CGME20191220120145eucas1p295af63eed7b23982d8c49fcf875cec8c@eucas1p2.samsung.com>
 <20191220115653.6487-6-a.swigon@samsung.com>
 <15795421-db12-8466-bb7e-688e6625cf4a@linaro.org>
 <0de33b1ae7c52270d11c606ecccc9af5f44d0421.camel@samsung.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <58060878-c08d-dc40-7367-ae6e4391245b@linaro.org>
Date:   Fri, 24 Jan 2020 14:32:14 +0200
MIME-Version: 1.0
In-Reply-To: <0de33b1ae7c52270d11c606ecccc9af5f44d0421.camel@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Artur,

On 1/24/20 13:22, Artur Świgoń wrote:
> Hi Georgi,
> 
> On Wed, 2020-01-22 at 19:02 +0200, Georgi Djakov wrote:
>> Hi Artur,
>>
>> On 12/20/19 13:56, Artur Świgoń wrote:
>>> This patch adds interconnect functionality to the exynos-bus devfreq
>>> driver.
>>>
>>> The SoC topology is a graph (or, more specifically, a tree) and its
>>> edges are specified using the 'exynos,interconnect-parent-node' in the
>>> DT. Due to unspecified relative probing order, -EPROBE_DEFER may be
>>> propagated to ensure that the parent is probed before its children.
>>>
>>> Each bus is now an interconnect provider and an interconnect node as well
>>> (cf. Documentation/interconnect/interconnect.rst), i.e. every bus registers
>>> itself as a node. Node IDs are not hardcoded but rather assigned at
>>
>> Just to note that usually the provider consists of multiple nodes and each node
>> represents a single master or slave port on the AXI bus for example. I am not
>> sure whether this represents correctly the Exynos hardware, so it's up to
>> you.
>>
>>> runtime, in probing order (subject to the above-mentioned exception
>>> regarding relative order). This approach allows for using this driver with
>>> various Exynos SoCs.
>>
>> This sounds good. I am wondering whether such dynamic probing would be useful
>> for other platforms too. Then maybe it would make sense to even have a common DT
>> property, but we will see.
>>
>> Is this going to be used only together with devfreq?
> 
> Yes, this functions solely as an extension to devfreq, hence the slightly
> unusual architecture (one icc_provider/icc_node per devfreq).

Ok, thanks for clarifying.

> (Compared to a singleton icc_provider, this approach yields less code with
> a very simple xlate()).
> 
> With exactly one icc_node for every devfreq device, I think I will actually
> reuse the devfreq ID (as seen in the device name, e.g. the "3" in "devfreq3")
> for the node ID. The devfreq framework already does the dynamic numbering
> thing that I do in this patch using IDR.
> 

Sounds good.

>>> Frequencies requested via the interconnect API for a given node are
>>> propagated to devfreq using dev_pm_qos_update_request(). Please note that
>>> it is not an error when CONFIG_INTERCONNECT is 'n', in which case all
>>> interconnect API functions are no-op.
>>
>> How about the case where CONFIG_INTERCONNECT=m. Looks like the build will fail
>> if CONFIG_ARM_EXYNOS_BUS_DEVFREQ=y, so this dependency should be expressed in
>> Kconfig.
> 
> I think adding:
> 	depends on INTERCONNECT || !INTERCONNECT

Yes, exactly.

> under ARM_EXYNOS_BUS_DEVFREQ does the trick.
> 
>>>
>>> Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
>>> ---
>>>  drivers/devfreq/exynos-bus.c | 144 +++++++++++++++++++++++++++++++++++
>>>  1 file changed, 144 insertions(+)
>>>
>>> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
>>> index 9fdb188915e8..694a9581dcdb 100644
>>> --- a/drivers/devfreq/exynos-bus.c
>>> +++ b/drivers/devfreq/exynos-bus.c
>>> @@ -14,14 +14,19 @@
>>>  #include <linux/devfreq-event.h>
>>>  #include <linux/device.h>
>>>  #include <linux/export.h>
>>> +#include <linux/idr.h>
>>> +#include <linux/interconnect-provider.h>
>>>  #include <linux/module.h>
>>>  #include <linux/of.h>
>>>  #include <linux/pm_opp.h>
>>> +#include <linux/pm_qos.h>
>>>  #include <linux/platform_device.h>
>>>  #include <linux/regulator/consumer.h>
>>>  
>>>  #define DEFAULT_SATURATION_RATIO	40
>>>  
>>> +#define kbps_to_khz(x) ((x) / 8)
>>> +
>>>  struct exynos_bus {
>>>  	struct device *dev;
>>>  
>>> @@ -35,6 +40,12 @@ struct exynos_bus {
>>>  	struct opp_table *opp_table;
>>>  	struct clk *clk;
>>>  	unsigned int ratio;
>>> +
>>> +	/* One provider per bus, one node per provider */
>>> +	struct icc_provider provider;
>>> +	struct icc_node *node;
>>> +
>>> +	struct dev_pm_qos_request qos_req;
>>>  };
>>>  
>>>  /*
>>> @@ -205,6 +216,39 @@ static void exynos_bus_passive_exit(struct device *dev)
>>>  	clk_disable_unprepare(bus->clk);
>>>  }
>>>  
>>> +static int exynos_bus_icc_set(struct icc_node *src, struct icc_node *dst)
>>> +{
>>> +	struct exynos_bus *src_bus = src->data, *dst_bus = dst->data;
>>> +	s32 src_freq = kbps_to_khz(src->avg_bw);
>>> +	s32 dst_freq = kbps_to_khz(dst->avg_bw);
>>> +	int ret;
>>> +
>>> +	ret = dev_pm_qos_update_request(&src_bus->qos_req, src_freq);
>>> +	if (ret < 0) {
>>> +		dev_err(src_bus->dev, "failed to update PM QoS request");
>>> +		return ret;
>>> +	}
>>> +
>>> +	ret = dev_pm_qos_update_request(&dst_bus->qos_req, dst_freq);
>>> +	if (ret < 0) {
>>> +		dev_err(dst_bus->dev, "failed to update PM QoS request");
>>> +		return ret;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static struct icc_node *exynos_bus_icc_xlate(struct of_phandle_args *spec,
>>> +					     void *data)
>>> +{
>>> +	struct exynos_bus *bus = data;
>>> +
>>> +	if (spec->np != bus->dev->of_node)
>>> +		return ERR_PTR(-EINVAL);
>>> +
>>> +	return bus->node;
>>> +}
>>> +
>>>  static int exynos_bus_parent_parse_of(struct device_node *np,
>>>  					struct exynos_bus *bus)
>>>  {
>>> @@ -419,6 +463,96 @@ static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
>>>  	return 0;
>>>  }
>>>  
>>> +static struct icc_node *exynos_bus_icc_get_parent(struct exynos_bus *bus)
>>> +{
>>> +	struct device_node *np = bus->dev->of_node;
>>> +	struct of_phandle_args args;
>>> +	int num, ret;
>>> +
>>> +	num = of_count_phandle_with_args(np, "exynos,interconnect-parent-node",
>>> +					"#interconnect-cells");
>>> +	if (num != 1)
>>> +		return NULL; /* parent nodes are optional */
>>> +
>>> +	ret = of_parse_phandle_with_args(np, "exynos,interconnect-parent-node",
>>> +					"#interconnect-cells", 0, &args);
>>> +	if (ret < 0)
>>> +		return ERR_PTR(ret);
>>> +
>>> +	of_node_put(args.np);
>>> +
>>> +	return of_icc_get_from_provider(&args);
>>> +}
>>> +
>>> +static int exynos_bus_icc_init(struct exynos_bus *bus)
>>> +{
>>> +	static DEFINE_IDA(ida);
>>> +
>>> +	struct device *dev = bus->dev;
>>> +	struct icc_provider *provider = &bus->provider;
>>> +	struct icc_node *node, *parent_node;
>>> +	int id, ret;
>>> +
>>> +	/* Initialize the interconnect provider */
>>> +	provider->set = exynos_bus_icc_set;
>>> +	provider->aggregate = icc_std_aggregate;
>>> +	provider->xlate = exynos_bus_icc_xlate;
>>> +	provider->dev = dev;
>>> +	provider->inter_set = true;
>>> +	provider->data = bus;
>>> +
>>> +	ret = icc_provider_add(provider);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +
>>> +	ret = id = ida_alloc(&ida, GFP_KERNEL);
>>> +	if (ret < 0)
>>> +		goto err_id;
>>> +
>>> +	node = icc_node_create(id);
>>> +	if (IS_ERR(node)) {
>>> +		ret = PTR_ERR(node);
>>> +		goto err_node;
>>> +	}
>>> +
>>> +	bus->node = node;
>>> +	node->name = dev->of_node->name;
>>> +	node->data = bus;
>>> +	icc_node_add(node, provider);
>>> +
>>> +	parent_node = exynos_bus_icc_get_parent(bus);
>>> +	if (IS_ERR(parent_node)) {
>>> +		ret = PTR_ERR(parent_node);
>>> +		goto err_parent;
>>> +	}
>>> +
>>> +	if (parent_node) {
>>> +		ret = icc_link_create(node, parent_node->id);
>>> +		if (ret < 0)
>>> +			goto err_parent;
>>> +	}
>>> +
>>> +	ret = dev_pm_qos_add_request(bus->devfreq->dev.parent, &bus->qos_req,
>>> +					DEV_PM_QOS_MIN_FREQUENCY, 0);
>>> +	if (ret < 0)
>>> +		goto err_request;
>>> +
>>> +	return 0;
>>> +
>>> +err_request:
>>> +	if (parent_node)
>>> +		icc_link_destroy(node, parent_node);
>>> +err_parent:
>>> +	icc_node_del(node);
>>> +	icc_node_destroy(id);
>>> +err_node:
>>> +	ida_free(&ida, id);
>>> +err_id:
>>> +	icc_provider_del(provider);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>>  static int exynos_bus_probe(struct platform_device *pdev)
>>>  {
>>>  	struct device *dev = &pdev->dev;
>>> @@ -468,6 +602,16 @@ static int exynos_bus_probe(struct platform_device *pdev)
>>>  	if (ret < 0)
>>>  		goto err;
>>>  
>>> +	/*
>>> +	 * Initialize interconnect provider. A return value of -ENOTSUPP means
>>> +	 * that CONFIG_INTERCONNECT is disabled.
>>> +	 */
>>> +	ret = exynos_bus_icc_init(bus);
>>> +	if (ret < 0 && ret != -ENOTSUPP) {

I have been also thinking that all the code that you add in this patch would fit
nicely into a separate interconnect provider driver. Then instead of the above
icc_init() you can create a sub-device (platform_device_register_data() maybe?).
The separate driver will be handling just the interconnect functionality and
could be enabled on top of this devfreq driver.

Thanks,
Georgi

P.S. I think that grouping all the related patches into a single patch-set would
make reviewing them easier. Then we can decide about the merge path of each.

>>> +		dev_err(dev, "failed to initialize the interconnect provider");
>>> +		goto err;
>>> +	}
>>> +
>>>  	max_state = bus->devfreq->profile->max_state;
>>>  	min_freq = (bus->devfreq->profile->freq_table[0] / 1000);
>>>  	max_freq = (bus->devfreq->profile->freq_table[max_state - 1] / 1000);
>>>
>>
>>
