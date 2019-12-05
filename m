Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDDC31139EA
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 03:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbfLECaH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Dec 2019 21:30:07 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:61345 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728459AbfLECaH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Dec 2019 21:30:07 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191205023002epoutp02f1e05cf4a8ea00a243ad3f6d977a5836~dWLppUcaM1647516475epoutp02G
        for <linux-pm@vger.kernel.org>; Thu,  5 Dec 2019 02:30:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191205023002epoutp02f1e05cf4a8ea00a243ad3f6d977a5836~dWLppUcaM1647516475epoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575513002;
        bh=xbucTyOyREF5meUyQSLulUXE71x8nxaKe9G52STj/fU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=kM3AmubES3GAbwHu2NP1Io1QtURJ/lGDaA+lBNM3Ozrdum9oLHJENbSwBnlFkagO9
         X1WjXU4ZRWpq9ROaaCN7GOBK2L8zBvgL3GCFWm7r3g7wRJJTP5POyP/f+/6hnvNsmX
         8GEGdutfrIKXhUb3uTmXaHkKxcgbgLPOtFHiGIQE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191205023001epcas1p106a6b1a5dd25d446e3ef1ba24b210f38~dWLpFOQRT1269412694epcas1p1F;
        Thu,  5 Dec 2019 02:30:01 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.158]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47T06v08VNzMqYky; Thu,  5 Dec
        2019 02:29:59 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        B7.12.48019.6AB68ED5; Thu,  5 Dec 2019 11:29:58 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191205022958epcas1p17f0a9e0e9eab0cf0a694488a6ea600e8~dWLmIOJO13049230492epcas1p1Z;
        Thu,  5 Dec 2019 02:29:58 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191205022958epsmtrp10453ecaaba8a07de06d53e080f850b2a~dWLmHYiXM2210222102epsmtrp1T;
        Thu,  5 Dec 2019 02:29:58 +0000 (GMT)
X-AuditID: b6c32a38-23fff7000001bb93-2b-5de86ba6e638
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        ED.94.10238.6AB68ED5; Thu,  5 Dec 2019 11:29:58 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191205022958epsmtip2895550fb1dc64ea8aa192e53892d5d02~dWLl2eFut2086620866epsmtip2Z;
        Thu,  5 Dec 2019 02:29:58 +0000 (GMT)
Subject: Re: [RFC PATCH v2 09/11] devfreq: exynos-bus: Add interconnect
 functionality to exynos-bus
To:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     myungjoo.ham@samsung.com, inki.dae@samsung.com,
        sw0312.kim@samsung.com, georgi.djakov@linaro.org,
        leonard.crestez@nxp.com, m.szyprowski@samsung.com,
        b.zolnierkie@samsung.com, krzk@kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <1050604c-00e7-ca81-032b-1aee9a3f8c9f@samsung.com>
Date:   Thu, 5 Dec 2019 11:36:12 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <9b3b21d3e4678946724531c58ad7f9c7a3993a95.camel@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBJsWRmVeSWpSXmKPExsWy7bCmnu6y7BexBkfmWFvcn9fKaLFxxnpW
        i/lHzrFaXPn6ns1i+t5NbBaT7k9gsTh/fgO7xYq7H1ktNj2+xmpxedccNovPvUcYLWac38dk
        sfbIXXaL240r2CxmTH7J5sDvsWlVJ5vHnWt72Dzudx9n8ti8pN5j47sdTB59W1YxenzeJBfA
        HpVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0t5JC
        WWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwLJArzgxt7g0L10vOT/XytDAwMgUqDAh
        O2PXJO2Cg94Ve5+vYGpgbLPtYuTkkBAwkdj/qJe5i5GLQ0hgB6PEjdfL2CGcT4wSe2a9ZoVw
        vjFKLL3dwQzTcvz+aTaIxF5Giat7t0G1vGeU2PnxKQtIlbBAqsSctdvBBosI/GeUOL1sJdgs
        ZoFjjBJ77/wEq2IT0JLY/+IGG4jNL6AocfXHY0YQm1fATmLOnVfsIDaLgIrErM0XmEBsUYEw
        iZPbWqBqBCVOznwCNodTwFPi7JZ3YDazgLjErSfzmSBseYnmrbPBrpAQ2Mcu8fbaWSaIJ1wk
        Tm3+zwphC0u8Or6FHcKWknjZ3wZlV0usPHmEDaK5g1Fiy/4LUA3GEvuXTgYaxAG0QVNi/S59
        iLCixM7fcxkhFvNJvPvawwpSIiHAK9HRJgRRoixx+cFdqBMkJRa3d7JNYFSaheSdWUhemIXk
        hVkIyxYwsqxiFEstKM5NTy02LDBBju9NjOBUrWWxg3HPOZ9DjAIcjEo8vA2bnscKsSaWFVfm
        HmKU4GBWEuHdJvE0Vog3JbGyKrUoP76oNCe1+BCjKTC0JzJLiSbnA/NIXkm8oamRsbGxhYmh
        mamhoZI4L8ePi7FCAumJJanZqakFqUUwfUwcnFINjByVHvcKJxmYdO9xMG3ssVqSMOlE0fGK
        v5c7ps9waWtcskBo+jPbPw+KTMMirv3u3N6/uvBOhWHcvLuzre+XLzmbz2p354j5uh1vr/K1
        e/m5cS11MrFdKr7ygmVdReQkTZMNr4QZ/8d4T/28+Gx+w5LTW1o0p6f637jY0vTt+04P3zce
        TU93f1FiKc5INNRiLipOBABRkh746wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsWy7bCSvO6y7BexBsc+iVvcn9fKaLFxxnpW
        i/lHzrFaXPn6ns1i+t5NbBaT7k9gsTh/fgO7xYq7H1ktNj2+xmpxedccNovPvUcYLWac38dk
        sfbIXXaL240r2CxmTH7J5sDvsWlVJ5vHnWt72Dzudx9n8ti8pN5j47sdTB59W1YxenzeJBfA
        HsVlk5Kak1mWWqRvl8CVsWuSdsFB74q9z1cwNTC22XYxcnJICJhIHL9/mq2LkYtDSGA3o8Sf
        ZX/ZIRKSEtMuHmXuYuQAsoUlDh8uhqh5yyixc+t0VpAaYYFUiTlrtzODJEQE/jNKPGw7xgji
        MAscY5T4uGI9K0TLBiaJ27/6wVrYBLQk9r+4wQZi8wsoSlz98ZgRxOYVsJOYc+cV2GoWARWJ
        WZsvMIHYogJhEjuXPGaCqBGUODnzCQuIzSngKXF2yzswm1lAXeLPvEvMELa4xK0n85kgbHmJ
        5q2zmScwCs9C0j4LScssJC2zkLQsYGRZxSiZWlCcm55bbFhgmJdarlecmFtcmpeul5yfu4kR
        HLNamjsYLy+JP8QowMGoxMPbsOl5rBBrYllxZe4hRgkOZiUR3m0ST2OFeFMSK6tSi/Lji0pz
        UosPMUpzsCiJ8z7NOxYpJJCeWJKanZpakFoEk2Xi4JRqYFze2724vVslWKfUn/l5WdSdutXi
        pWaLDs+LN3onPj+4ZP+sT34vTnbfNahS/Pxk42fJ9hSnkIuT5ZLY9k3YeD+r+NrFmPPcNhOq
        uH0PaGnu2Rl4LFbv1/+Ebd96u/bET8peV9Xe8cg12l+mZWFz4S5bv+V8PPuaGPNrTq2Yd8BI
        /b/GpG63V0osxRmJhlrMRcWJAPwoDGfVAgAA
X-CMS-MailID: 20191205022958epcas1p17f0a9e0e9eab0cf0a694488a6ea600e8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190919142329eucas1p2e53992eab9ec6b404f716f955b3c228e
References: <20190919142236.4071-1-a.swigon@samsung.com>
        <CGME20190919142329eucas1p2e53992eab9ec6b404f716f955b3c228e@eucas1p2.samsung.com>
        <20190919142236.4071-10-a.swigon@samsung.com>
        <e004bedd-294b-172b-5e34-bf7afcfd04bc@samsung.com>
        <9b3b21d3e4678946724531c58ad7f9c7a3993a95.camel@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Artur,

On 12/3/19 2:05 AM, Artur Świgoń wrote:
> Hi Chanwoo,
> 
> On Wed, 2019-09-25 at 16:03 +0900, Chanwoo Choi wrote:
>> Hi,
>>
>> I need the time to dig the ICC framework
>> to understand them detailed. After that, I'll review this.
> 
> Any updates on this topic?

I'm sorry for delaying the review of  this topic related to icc.
The review and merge of devfreq pm-qos feature will be finished over soon.
Because this series depends on the devfreq pm-qos feature

I'll dig into ICC related patches for exynos and imx[1].
[1] https://lore.kernel.org/linux-arm-kernel/008f2fa973b23fc716d678c5bd35af54@akkea.ca/T/
[PATCH RFC v6 0/9] interconnect: Add imx support via devfreq

> 
> Regardless of the purpose of this RFC, I think patches 01-04
> are still beneficial to devfreq. I can rebase and post them
> as a separate series if you wish.

Yes. please split out patch1-4 from this series
and send them based on linux-next.git separately.

> 
>> Basically, I agree this approach. But, I'm wondering
>> the existing binding method between 'bus_leftbus' and 'bus_dmc'.
>> From before, I thought that devfreq framework need to
>> enhance the binding method between parent devfreq device
>> and passive devfreq device instead of 'devfreq' property.
>>
>> On this patch, use the same binding way between
>> 'bus_leftbus' and 'bus_dmc' with 'parent' property
>> as following:
>>
>> +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
>> @@ -106,6 +106,7 @@
>>  &bus_leftbus {
>>  	devfreq-events = <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
>>  	vdd-supply = <&buck3_reg>;
>> +	parent = <&bus_dmc>;
>>  	status = "okay";
>>  };
>>
>> I'm not sure about continuing to use this method for new feature.
>> If possible, hope to replace the existing binding style
>> with new method like of_graph. Actually, I don't know the correct method.
>>
>>
>> On 19. 9. 19. 오후 11:22, Artur Świgoń wrote:
>>> From: Artur Świgoń <a.swigon@partner.samsung.com>
>>>
>>> This patch adds interconnect functionality to the exynos-bus devfreq
>>> driver.
>>>
>>> The SoC topology is a graph (or, more specifically, a tree) and most of
>>> its edges are taken from the devfreq parent-child hierarchy (cf.
>>> Documentation/devicetree/bindings/devfreq/exynos-bus.txt). Due to
>>> unspecified relative probing order, -EPROBE_DEFER may be propagated to
>>> guarantee that a child is probed before its parent.
>>>
>>> Each bus is now an interconnect provider and an interconnect node as well
>>> (cf. Documentation/interconnect/interconnect.rst), i.e. every bus registers
>>> itself as a node. Node IDs are not hardcoded but rather assigned at
>>> runtime, in probing order (subject to the above-mentioned exception
>>> regarding relative order). This approach allows for using this driver with
>>> various Exynos SoCs.
>>>
>>> Frequencies requested via the interconnect API for a given node are
>>> propagated to devfreq using dev_pm_qos_update_request(). Please note that
>>> it is not an error when CONFIG_INTERCONNECT is 'n', in which case all
>>> interconnect API functions are no-op.
>>>
>>> Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
>>> ---
>>>  drivers/devfreq/exynos-bus.c | 153 +++++++++++++++++++++++++++++++++++
>>>  1 file changed, 153 insertions(+)
>>>
>>> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
>>> index 8d44810cac69..e0232202720d 100644
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
>>> +#define icc_units_to_khz(x) ((x) / 8)
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
>>> @@ -59,6 +70,13 @@ exynos_bus_ops_edev(enable_edev);
>>>  exynos_bus_ops_edev(disable_edev);
>>>  exynos_bus_ops_edev(set_event);
>>>  
>>> +static int exynos_bus_next_id(void)
>>> +{
>>> +	static DEFINE_IDA(exynos_bus_icc_ida);
>>> +
>>> +	return ida_alloc(&exynos_bus_icc_ida, GFP_KERNEL);
>>> +}
>>> +
>>>  static int exynos_bus_get_event(struct exynos_bus *bus,
>>>  				struct devfreq_event_data *edata)
>>>  {
>>> @@ -171,6 +189,38 @@ static void exynos_bus_passive_exit(struct device *dev)
>>>  	clk_disable_unprepare(bus->clk);
>>>  }
>>>  
>>> +static int exynos_bus_icc_set(struct icc_node *src, struct icc_node *dst)
>>> +{
>>> +	struct exynos_bus *src_bus = src->data, *dst_bus = dst->data;
>>> +	s32 src_freq = icc_units_to_khz(src->avg_bw);
>>> +	s32 dst_freq = icc_units_to_khz(dst->avg_bw);
>>> +
>>> +	dev_pm_qos_update_request(&src_bus->qos_req, src_freq);
>>> +	dev_pm_qos_update_request(&dst_bus->qos_req, dst_freq);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int exynos_bus_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
>>> +				    u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
>>> +{
>>> +	*agg_avg += avg_bw;
>>> +	*agg_peak = max(*agg_peak, peak_bw);
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
>>> @@ -366,6 +416,101 @@ static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
>>>  	return 0;
>>>  }
>>>  
>>> +static int exynos_bus_icc_connect(struct exynos_bus *bus)
>>> +{
>>> +	struct device_node *np = bus->dev->of_node;
>>> +	struct devfreq *parent_devfreq;
>>> +	struct icc_node *parent_node = NULL;
>>> +	struct of_phandle_args args;
>>> +	int ret = 0;
>>> +
>>> +	parent_devfreq = devfreq_get_devfreq_by_phandle(bus->dev, 0);
>>> +	if (!IS_ERR(parent_devfreq)) {
>>> +		struct exynos_bus *parent_bus;
>>> +
>>> +		parent_bus = dev_get_drvdata(parent_devfreq->dev.parent);
>>> +		parent_node = parent_bus->node;
>>> +	} else {
>>> +		/* Look for parent in DT */
>>> +		int num = of_count_phandle_with_args(np, "parent",
>>> +						     "#interconnect-cells");
>>> +		if (num != 1)
>>> +			goto out; /* 'parent' is optional */
>>> +
>>> +		ret = of_parse_phandle_with_args(np, "parent",
>>> +						 "#interconnect-cells",
>>> +						 0, &args);
>>> +		if (ret < 0)
>>> +			goto out;
>>> +
>>> +		of_node_put(args.np);
>>> +
>>> +		parent_node = of_icc_get_from_provider(&args);
>>> +		if (IS_ERR(parent_node)) {
>>> +			/* May be -EPROBE_DEFER */
>>> +			ret = PTR_ERR(parent_node);
>>> +			goto out;
>>> +		}
>>> +	}
>>
>>
>>
>>> +
>>> +	ret = icc_link_create(bus->node, parent_node->id);
>>> +
>>> +out:
>>> +	return ret;
>>> +}
>>> +
>>> +static int exynos_bus_icc_init(struct exynos_bus *bus)
>>> +{
>>> +	struct device *dev = bus->dev;
>>> +	struct icc_provider *provider = &bus->provider;
>>> +	struct icc_node *node;
>>> +	int id, ret;
>>> +
>>> +	/* Initialize the interconnect provider */
>>> +	provider->set = exynos_bus_icc_set;
>>> +	provider->aggregate = exynos_bus_icc_aggregate;
>>> +	provider->xlate = exynos_bus_icc_xlate;
>>> +	provider->dev = dev;
>>> +	provider->data = bus;
>>> +
>>> +	ret = icc_provider_add(provider);
>>> +	if (ret < 0)
>>> +		goto out;
>>> +
>>> +	ret = id = exynos_bus_next_id();
>>> +	if (ret < 0)
>>> +		goto err_node;
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
>>> +	ret = exynos_bus_icc_connect(bus);
>>> +	if (ret < 0)
>>> +		goto err_connect;
>>> +
>>> +	ret = dev_pm_qos_add_request(bus->devfreq->dev.parent, &bus->qos_req,
>>> +				     DEV_PM_QOS_MIN_FREQUENCY, 0);
>>> +
>>> +out:
>>> +	return ret;
>>> +
>>> +err_connect:
>>> +	icc_node_del(node);
>>> +	icc_node_destroy(id);
>>> +err_node:
>>> +	icc_provider_del(provider);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>>  static int exynos_bus_probe(struct platform_device *pdev)
>>>  {
>>>  	struct device *dev = &pdev->dev;
>>> @@ -415,6 +560,14 @@ static int exynos_bus_probe(struct platform_device *pdev)
>>>  	if (ret < 0)
>>>  		goto err;
>>>  
>>> +	/*
>>> +	 * Initialize interconnect provider. A return value of -ENOTSUPP means
>>> +	 * that CONFIG_INTERCONNECT is disabled.
>>> +	 */
>>> +	ret = exynos_bus_icc_init(bus);
>>> +	if (ret < 0 && ret != -ENOTSUPP)
>>> +		goto err;
>>> +
>>>  	max_state = bus->devfreq->profile->max_state;
>>>  	min_freq = (bus->devfreq->profile->freq_table[0] / 1000);
>>>  	max_freq = (bus->devfreq->profile->freq_table[max_state - 1] / 1000);
>>>
>>
> 
> Best regards,
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
