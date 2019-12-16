Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E23CE11FC3B
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2019 01:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfLPAiY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Dec 2019 19:38:24 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:46546 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfLPAiY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Dec 2019 19:38:24 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191216003820epoutp015322406dafd56a61903058162471b59b~gswQ08hyk0310703107epoutp01I
        for <linux-pm@vger.kernel.org>; Mon, 16 Dec 2019 00:38:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191216003820epoutp015322406dafd56a61903058162471b59b~gswQ08hyk0310703107epoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576456700;
        bh=kAbYo1SH4VLzd8YFV0ywGCsP2GIOLdJ6A3u+vQzFZrk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=C9au0hg+CbGO+dyOkPr35hAewHEXEJNTfxdco8Ip5O0H/89kmX7HqL+fLDB2mB1Xp
         k0/NV3kvq9pef297vkBGzJo36ag8BsyoAZiWdpzElgG+iZ1RlcQGd5WSlV/UrsQEeq
         L1EK+kln4jupi4Jtr6tazNaHxY8zJlsIeU+bNfDY=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191216003819epcas1p2773876204c6909056d0c378ffbd746d0~gswQSrmtD2928429284epcas1p2r;
        Mon, 16 Dec 2019 00:38:19 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.158]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47bj6x2SSdzMqYkp; Mon, 16 Dec
        2019 00:38:17 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        B3.73.57028.5F1D6FD5; Mon, 16 Dec 2019 09:38:13 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191216003813epcas1p4205461d6f6cc2170d4c6b5f141baddae~gswKMrUyi0615706157epcas1p4n;
        Mon, 16 Dec 2019 00:38:13 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191216003813epsmtrp217cb6bb1508303e9597f220d4ed51d0d~gswKL2Jvb0872808728epsmtrp2O;
        Mon, 16 Dec 2019 00:38:13 +0000 (GMT)
X-AuditID: b6c32a35-50bff7000001dec4-92-5df6d1f54d3e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EA.D9.06569.4F1D6FD5; Mon, 16 Dec 2019 09:38:12 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191216003812epsmtip1b24c79040c9440eecbe4499ce106d86e~gswJ7kmhH0036800368epsmtip19;
        Mon, 16 Dec 2019 00:38:12 +0000 (GMT)
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
Message-ID: <35053bad-3f08-190a-0ffa-9aacd16da272@samsung.com>
Date:   Mon, 16 Dec 2019 09:44:48 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20190919142236.4071-10-a.swigon@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOJsWRmVeSWpSXmKPExsWy7bCmru7Xi99iDbb3Klrcn9fKaLFxxnpW
        i/lHzrFaXPn6ns1i+t5NbBaT7k9gsTh/fgO7xYq7H1ktNj2+xmpxedccNovPvUcYLWac38dk
        sfbIXXaL240r2CxmTH7J5sDvsWlVJ5vHnWt72Dzudx9n8ti8pN5j47sdTB59W1YxenzeJBfA
        HpVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0t5JC
        WWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwLJArzgxt7g0L10vOT/XytDAwMgUqDAh
        O+P3q3/sBf2OFctfTmVvYHxs3MXIySEhYCKx9vxV9i5GLg4hgR2MEjO+nGOBcD4xSrz6t58J
        wvnGKHGj8Q0zTMvUv9/ZIBJ7GSVOfXsDVfWeUeLtq0VMIFXCAqkSc9ZuZwZJiAj8Z5Q4vWwl
        K4jDLHCMUWLvnZ8sIFVsAloS+1/cYAOx+QUUJa7+eMzYxcjBwStgJ3HgITdImEVAVWJa52+w
        1aICYRInt7Uwgti8AoISJ2c+YQEp5xSwkli21xskzCwgLnHryXwmCFteonnrbLAbJASOsUs8
        /baWFeIFF4nF3degbGGJV8e3sEPYUhKf3+1lg7CrJVaePMIG0dzBKLFl/wWoBmOJ/UsnM4Es
        ZhbQlFi/Sx8irCix8/dcRojFfBLvvvawgpRICPBKdLQJQZQoS1x+cJcJwpaUWNzeyTaBUWkW
        km9mIXlhFpIXZiEsW8DIsopRLLWgODc9tdiwwBA5ujcxghO1lukOxinnfA4xCnAwKvHwOmR/
        ixViTSwrrsw9xCjBwawkwpuq/TlWiDclsbIqtSg/vqg0J7X4EKMpMLAnMkuJJucDs0heSbyh
        qZGxsbGFiaGZqaGhkjgvx4+LsUIC6YklqdmpqQWpRTB9TBycUg2Mh6eUBzFt+Ros//jsMYnL
        Cw5rrI39rF7ktW+tp/TDo6KLG69N7GVlvMjAxvg95Hkx6/kvd04say/pjlG3MHb783+hg1TH
        jhPfV31JLL53U+5SeUK4a9KnZ2s4Hi+JM3d7/m5JvnxBzAS+6Lqis51LZk449N519xORpekR
        c2/vDyyc6KI6YbHrAiWW4oxEQy3mouJEAA596pDqAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsWy7bCSnO6Xi99iDRo+2Vjcn9fKaLFxxnpW
        i/lHzrFaXPn6ns1i+t5NbBaT7k9gsTh/fgO7xYq7H1ktNj2+xmpxedccNovPvUcYLWac38dk
        sfbIXXaL240r2CxmTH7J5sDvsWlVJ5vHnWt72Dzudx9n8ti8pN5j47sdTB59W1YxenzeJBfA
        HsVlk5Kak1mWWqRvl8CV8fvVP/aCfseK5S+nsjcwPjbuYuTkkBAwkZj69ztbFyMXh5DAbkaJ
        jVNWMEIkJCWmXTzK3MXIAWQLSxw+XAxR85ZRYu/UTawgNcICqRJz1m5nBkmICPxnlHjYdowR
        xGEWOMYo8XHFelaIlj2MEtd3TGcDaWET0JLY/+IGmM0voChx9cdjRpAVvAJ2EgcecoOEWQRU
        JaZ1/mYGsUUFwiR2LnnMBGLzCghKnJz5hAWknFPASmLZXm+QMLOAusSfeZeYIWxxiVtP5jNB
        2PISzVtnM09gFJ6FpHsWkpZZSFpmIWlZwMiyilEytaA4Nz232LDAKC+1XK84Mbe4NC9dLzk/
        dxMjOGK1tHYwnjgRf4hRgINRiYfXIftbrBBrYllxZe4hRgkOZiUR3lTtz7FCvCmJlVWpRfnx
        RaU5qcWHGKU5WJTEeeXzj0UKCaQnlqRmp6YWpBbBZJk4OKUaGCXO/yriCJ7nlCQQPi+cyapl
        k+uTsMSWw33z8uZPrjrdtiZC0+ZbcQHnzcQ6v0nnM3bvTa/bcDeP/e+Xu55vHqo/nlvBwrCv
        epry3gXshitX/TSdtPlo76GcVztPPbT7LvX06PVceQ7L/YskNW+Y6MziPuYx/WLvHoG2KSzu
        lsf5J8Wf/M1fxa/EUpyRaKjFXFScCAB/o+6Y1AIAAA==
X-CMS-MailID: 20191216003813epcas1p4205461d6f6cc2170d4c6b5f141baddae
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
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 9/19/19 11:22 PM, Artur Świgoń wrote:
> From: Artur Świgoń <a.swigon@partner.samsung.com>
> 
> This patch adds interconnect functionality to the exynos-bus devfreq
> driver.
> 
> The SoC topology is a graph (or, more specifically, a tree) and most of
> its edges are taken from the devfreq parent-child hierarchy (cf.
> Documentation/devicetree/bindings/devfreq/exynos-bus.txt). Due to
> unspecified relative probing order, -EPROBE_DEFER may be propagated to
> guarantee that a child is probed before its parent.
> 
> Each bus is now an interconnect provider and an interconnect node as well
> (cf. Documentation/interconnect/interconnect.rst), i.e. every bus registers
> itself as a node. Node IDs are not hardcoded but rather assigned at
> runtime, in probing order (subject to the above-mentioned exception
> regarding relative order). This approach allows for using this driver with
> various Exynos SoCs.
> 
> Frequencies requested via the interconnect API for a given node are
> propagated to devfreq using dev_pm_qos_update_request(). Please note that
> it is not an error when CONFIG_INTERCONNECT is 'n', in which case all
> interconnect API functions are no-op.
> 
> Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
> ---
>  drivers/devfreq/exynos-bus.c | 153 +++++++++++++++++++++++++++++++++++
>  1 file changed, 153 insertions(+)
> 
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index 8d44810cac69..e0232202720d 100644
> --- a/drivers/devfreq/exynos-bus.c
> +++ b/drivers/devfreq/exynos-bus.c
> @@ -14,14 +14,19 @@
>  #include <linux/devfreq-event.h>
>  #include <linux/device.h>
>  #include <linux/export.h>
> +#include <linux/idr.h>
> +#include <linux/interconnect-provider.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/pm_opp.h>
> +#include <linux/pm_qos.h>
>  #include <linux/platform_device.h>
>  #include <linux/regulator/consumer.h>
>  
>  #define DEFAULT_SATURATION_RATIO	40
>  
> +#define icc_units_to_khz(x) ((x) / 8)

icc_units_to_khz() -> kpbs_to_khz()

> +
>  struct exynos_bus {
>  	struct device *dev;
>  
> @@ -35,6 +40,12 @@ struct exynos_bus {
>  	struct opp_table *opp_table;
>  	struct clk *clk;
>  	unsigned int ratio;
> +
> +	/* One provider per bus, one node per provider */
> +	struct icc_provider provider;
> +	struct icc_node *node;
> +
> +	struct dev_pm_qos_request qos_req;
>  };
>  
>  /*
> @@ -59,6 +70,13 @@ exynos_bus_ops_edev(enable_edev);
>  exynos_bus_ops_edev(disable_edev);
>  exynos_bus_ops_edev(set_event);
>  
> +static int exynos_bus_next_id(void)
> +{
> +	static DEFINE_IDA(exynos_bus_icc_ida);
> +
> +	return ida_alloc(&exynos_bus_icc_ida, GFP_KERNEL);
> +}
> +
>  static int exynos_bus_get_event(struct exynos_bus *bus,
>  				struct devfreq_event_data *edata)
>  {
> @@ -171,6 +189,38 @@ static void exynos_bus_passive_exit(struct device *dev)
>  	clk_disable_unprepare(bus->clk);
>  }
>  
> +static int exynos_bus_icc_set(struct icc_node *src, struct icc_node *dst)
> +{
> +	struct exynos_bus *src_bus = src->data, *dst_bus = dst->data;
> +	s32 src_freq = icc_units_to_khz(src->avg_bw);
> +	s32 dst_freq = icc_units_to_khz(dst->avg_bw);
> +
> +	dev_pm_qos_update_request(&src_bus->qos_req, src_freq);

Have to check the return value.
If return error, show the waring with dev_warn.

> +	dev_pm_qos_update_request(&dst_bus->qos_req, dst_freq);

ditto.

> +
> +	return 0;
> +}
> +
> +static int exynos_bus_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
> +				    u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
> +{
> +	*agg_avg += avg_bw;
> +	*agg_peak = max(*agg_peak, peak_bw);
> +
> +	return 0;
> +}
> +
> +static struct icc_node *exynos_bus_icc_xlate(struct of_phandle_args *spec,
> +					     void *data)
> +{
> +	struct exynos_bus *bus = data;
> +
> +	if (spec->np != bus->dev->of_node)
> +		return ERR_PTR(-EINVAL);
> +
> +	return bus->node;
> +}
> +
>  static int exynos_bus_parent_parse_of(struct device_node *np,
>  					struct exynos_bus *bus)
>  {
> @@ -366,6 +416,101 @@ static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
>  	return 0;
>  }
>  
> +static int exynos_bus_icc_connect(struct exynos_bus *bus)
> +{
> +	struct device_node *np = bus->dev->of_node;
> +	struct devfreq *parent_devfreq;
> +	struct icc_node *parent_node = NULL;
> +	struct of_phandle_args args;
> +	int ret = 0;
> +
> +	parent_devfreq = devfreq_get_devfreq_by_phandle(bus->dev, 0);
> +	if (!IS_ERR(parent_devfreq)) {
> +		struct exynos_bus *parent_bus;
> +
> +		parent_bus = dev_get_drvdata(parent_devfreq->dev.parent);
> +		parent_node = parent_bus->node;
> +	} else {
> +		/* Look for parent in DT */
> +		int num = of_count_phandle_with_args(np, "parent",
> +						     "#interconnect-cells");
> +		if (num != 1)
> +			goto out; /* 'parent' is optional */
> +
> +		ret = of_parse_phandle_with_args(np, "parent",
> +						 "#interconnect-cells",
> +						 0, &args);


Actually, I agree your approach. I think that it is very useful
and necessary to guarantee the PM QoS requirements between devices.

But,
As I already commented, I'm not sure that the "parent" property 
is proper for only this driver. If possible, you better to get
the parent phandle through other way like OF graph.

If you suggest the standard way to make the tree between
the exynos-bus, I'll agree.

Also, for interconnect path, you have to add the connection
between 'bus_display' and 'bus_leftbus' regardless
of the existing 'devfreq' property.
- bus_display - bus_leftbus - bus_dmc

> +		if (ret < 0)
> +			goto out;
> +
> +		of_node_put(args.np);
> +
> +		parent_node = of_icc_get_from_provider(&args);
> +		if (IS_ERR(parent_node)) {
> +			/* May be -EPROBE_DEFER */
> +			ret = PTR_ERR(parent_node);
> +			goto out;
> +		}
> +	}
> +
> +	ret = icc_link_create(bus->node, parent_node->id);
> +
> +out:
> +	return ret;
> +}
> +
> +static int exynos_bus_icc_init(struct exynos_bus *bus)
> +{
> +	struct device *dev = bus->dev;
> +	struct icc_provider *provider = &bus->provider;
> +	struct icc_node *node;
> +	int id, ret;
> +
> +	/* Initialize the interconnect provider */
> +	provider->set = exynos_bus_icc_set;
> +	provider->aggregate = exynos_bus_icc_aggregate;
> +	provider->xlate = exynos_bus_icc_xlate;
> +	provider->dev = dev;
> +	provider->data = bus;
> +
> +	ret = icc_provider_add(provider);
> +	if (ret < 0)
> +		goto out;

Return error without goto because there is no any requirement
to free the resource before.

> +
> +	ret = id = exynos_bus_next_id();
> +	if (ret < 0)
> +		goto err_node;
> +
> +	node = icc_node_create(id);
> +	if (IS_ERR(node)) {
> +		ret = PTR_ERR(node);
> +		goto err_node;
> +	}
> +
> +	bus->node = node;
> +	node->name = dev->of_node->name;
> +	node->data = bus;
> +	icc_node_add(node, provider);
> +
> +	ret = exynos_bus_icc_connect(bus);
> +	if (ret < 0)
> +		goto err_connect;
> +
> +	ret = dev_pm_qos_add_request(bus->devfreq->dev.parent, &bus->qos_req,

Check whether this line is over 80 char.

> +				     DEV_PM_QOS_MIN_FREQUENCY, 0);

	Check the return value.

> +
> +out:

Remove this goto due to not necessary.

> +	return ret;

	return 0;

> +
> +err_connect:
> +	icc_node_del(node);
> +	icc_node_destroy(id);
> +err_node:
> +	icc_provider_del(provider);
> +
> +	return ret;
> +}
> +
>  static int exynos_bus_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -415,6 +560,14 @@ static int exynos_bus_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		goto err;
>  
> +	/*
> +	 * Initialize interconnect provider. A return value of -ENOTSUPP means
> +	 * that CONFIG_INTERCONNECT is disabled.
> +	 */
> +	ret = exynos_bus_icc_init(bus);
> +	if (ret < 0 && ret != -ENOTSUPP)
> +		goto err;

Print error message.
	dev_err(dev, "failed to initialize the interconnect provider");

> +
>  	max_state = bus->devfreq->profile->max_state;
>  	min_freq = (bus->devfreq->profile->freq_table[0] / 1000);
>  	max_freq = (bus->devfreq->profile->freq_table[max_state - 1] / 1000);
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
