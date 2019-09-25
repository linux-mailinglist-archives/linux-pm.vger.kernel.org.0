Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21200BD8A2
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2019 08:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405433AbfIYG7E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Sep 2019 02:59:04 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:36308 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405259AbfIYG7D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Sep 2019 02:59:03 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190925065858epoutp03c61bf7fab51d7f4abdd8b0a0a7f4c9c5~HnDMoptFY2491024910epoutp03F
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2019 06:58:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190925065858epoutp03c61bf7fab51d7f4abdd8b0a0a7f4c9c5~HnDMoptFY2491024910epoutp03F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569394738;
        bh=xQWzs/pedDJSsxtEmCy1Lrdn5MIpIiQkDtODnQQwnt4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=MmG2Ln/Ap9AIivrRhGYnn4AfbRbR3xdJc5B7yng4eOosvouTXSduW7wwtpwDBJRv3
         sMBtBHxOkbMH843tdlmTyOLB2FREKXYOWKobFXMIsAcD+Ctl9dBNqSOIfZFtXOLCz6
         EZU2LvTdOGDUM3n4kq5INcY85AH0o0hmdQ/G1CpU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190925065858epcas1p4b71b876c150beaf3a5710898fd9f6e1d~HnDMEEACA0631506315epcas1p4W;
        Wed, 25 Sep 2019 06:58:58 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.156]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 46dTRz2X8szMqYkg; Wed, 25 Sep
        2019 06:58:55 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        9C.4F.04085.F201B8D5; Wed, 25 Sep 2019 15:58:55 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190925065854epcas1p281f94f5d17ffa46a8805ae596c3a1c29~HnDJDKRQq1907419074epcas1p2b;
        Wed, 25 Sep 2019 06:58:54 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190925065854epsmtrp29f7422eb9abc7dca7a1a1033d07d6d62~HnDJCLF1C2870428704epsmtrp2g;
        Wed, 25 Sep 2019 06:58:54 +0000 (GMT)
X-AuditID: b6c32a37-e19ff70000000ff5-b5-5d8b102f6860
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C8.8F.04081.E201B8D5; Wed, 25 Sep 2019 15:58:54 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190925065854epsmtip2f99ad334c976ac4fbb5c45aa33ef7c1a~HnDIkt6tm0309903099epsmtip2L;
        Wed, 25 Sep 2019 06:58:54 +0000 (GMT)
Subject: Re: [RFC PATCH v2 09/11] devfreq: exynos-bus: Add interconnect
 functionality to exynos-bus
To:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        myungjoo.ham@samsung.com, inki.dae@samsung.com,
        sw0312.kim@samsung.com, georgi.djakov@linaro.org,
        leonard.crestez@nxp.com, m.szyprowski@samsung.com,
        b.zolnierkie@samsung.com, krzk@kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <e004bedd-294b-172b-5e34-bf7afcfd04bc@samsung.com>
Date:   Wed, 25 Sep 2019 16:03:17 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190919142236.4071-10-a.swigon@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEJsWRmVeSWpSXmKPExsWy7bCmvq6+QHeswdHtwhaHjm1lt7g/r5XR
        YuOM9awW84+cY7W48vU9m8X0vZvYLCbdn8Bicf78BnaLFXc/slpsenyN1eLyrjlsFp97jzBa
        zDi/j8li7ZG77Ba3G1ewWcyY/JLNQcBj06pONo871/awedzvPs7ksXlJvcfGdzuYPA6+28Pk
        0bdlFaPH501yARxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkou
        PgG6bpk5QB8oKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgosC/SKE3OLS/PS9ZLz
        c60MDQyMTIEKE7Iz5u9oZCtY6FDx+lwHWwPjGuMuRk4OCQETiZ6fR5i6GLk4hAR2MEpMnXqA
        FcL5xCix8+FRRgjnG6PEkZNbmGBajj7ZwgaR2Mso8WH/K6j+94wSrZ8usoJUCQukSsxZu50Z
        JCEi8J9R4vSylWCDmQU6mSR+P98BVsUmoCWx/8UNNhCbX0BR4uqPx4wgNq+AncTbJVuZQWwW
        AVWJc3Mvg+0WFYiQ+PTgMCtEjaDEyZlPWLoYOTg4Bawklu31BgkzC4hL3HoynwnClpdo3job
        7AgJgXPsErsXn2OF+MFF4vC/xVC2sMSr41vYIWwpic/v9rJB2NUSK08eYYNo7mCU2LL/AlSD
        scT+pZOZQBYzC2hKrN+lDxFWlNj5ey4jxGI+iXdfe1hBSiQEeCU62oQgSpQlLj+4Cw1GSYnF
        7Z1sExiVZiH5ZhaSF2YheWEWwrIFjCyrGMVSC4pz01OLDQuMkeN7EyM4fWuZ72DccM7nEKMA
        B6MSD68Da1esEGtiWXFl7iFGCQ5mJRHeWTJAId6UxMqq1KL8+KLSnNTiQ4ymwMCeyCwlmpwP
        zC15JfGGpkbGxsYWJoZmpoaGSuK8HukNsUIC6YklqdmpqQWpRTB9TBycUg2MVvMv3FNcuTD2
        gmh7+DOGzZP2Hbgkq55abDeb33tBw5QNv39b/FOZnL6g1+J2z9n7B6eznD9Yvudj1+lE/yj9
        lV3PuR9lsB+pz/TP357Vnu6RIOwz/c6Pf0XaVxXC/N+VOebO/LX1Xtj0y8+DNi10F5xidujb
        mRy57b2hvN9YnrpOCQ8x+G8Sq8RSnJFoqMVcVJwIAFdOVcn1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsWy7bCSvK6eQHeswYFl2haHjm1lt7g/r5XR
        YuOM9awW84+cY7W48vU9m8X0vZvYLCbdn8Bicf78BnaLFXc/slpsenyN1eLyrjlsFp97jzBa
        zDi/j8li7ZG77Ba3G1ewWcyY/JLNQcBj06pONo871/awedzvPs7ksXlJvcfGdzuYPA6+28Pk
        0bdlFaPH501yARxRXDYpqTmZZalF+nYJXBnzdzSyFSx0qHh9roOtgXGNcRcjJ4eEgInE0Sdb
        2LoYuTiEBHYzSpz/sokdIiEpMe3iUeYuRg4gW1ji8OFiiJq3jBKNy0+ygdQIC6RKzFm7nRkk
        ISLwn1HiYdsxRhCHWaCTSWLxlh8sEC17GCWu75gO1sImoCWx/8UNMJtfQFHi6o/HjCA2r4Cd
        xNslW5lBbBYBVYlzcy8zgdiiAhESh3fMgqoRlDg58wkLyEmcAlYSy/Z6g4SZBdQl/sy7xAxh
        i0vcejKfCcKWl2jeOpt5AqPwLCTds5C0zELSMgtJywJGllWMkqkFxbnpucWGBYZ5qeV6xYm5
        xaV56XrJ+bmbGMFxrKW5g/HykvhDjAIcjEo8vA6sXbFCrIllxZW5hxglOJiVRHhnyQCFeFMS
        K6tSi/Lji0pzUosPMUpzsCiJ8z7NOxYpJJCeWJKanZpakFoEk2Xi4JRqYNQrT3HimzA785p8
        0qtKR5GWRS5LLrHxmrv1B3/9bcz752uh7DzeH2c3r3rAsWzV/5tnIk6c7dAw4dtUUi6ssF0i
        4+bLJc1zOyYnuPFa+0s9OHR1gU7iB7uWLwK+nBX9/IoMZZeXmR2fXF8y0eDE8fp0s9f/Yye/
        zXqXdfe73y7Lng8BkZd+GCuxFGckGmoxFxUnAgBW+oGG3wIAAA==
X-CMS-MailID: 20190925065854epcas1p281f94f5d17ffa46a8805ae596c3a1c29
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

I need the time to dig the ICC framework
to understand them detailed. After that, I'll review this.

Basically, I agree this approach. But, I'm wondering
the existing binding method between 'bus_leftbus' and 'bus_dmc'.
From before, I thought that devfreq framework need to
enhance the binding method between parent devfreq device
and passive devfreq device instead of 'devfreq' property.

On this patch, use the same binding way between
'bus_leftbus' and 'bus_dmc' with 'parent' property
as following:

+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -106,6 +106,7 @@
 &bus_leftbus {
 	devfreq-events = <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
 	vdd-supply = <&buck3_reg>;
+	parent = <&bus_dmc>;
 	status = "okay";
 };

I'm not sure about continuing to use this method for new feature.
If possible, hope to replace the existing binding style
with new method like of_graph. Actually, I don't know the correct method.


On 19. 9. 19. 오후 11:22, Artur Świgoń wrote:
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
> +	dev_pm_qos_update_request(&dst_bus->qos_req, dst_freq);
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
> +				     DEV_PM_QOS_MIN_FREQUENCY, 0);
> +
> +out:
> +	return ret;
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
> +
>  	max_state = bus->devfreq->profile->max_state;
>  	min_freq = (bus->devfreq->profile->freq_table[0] / 1000);
>  	max_freq = (bus->devfreq->profile->freq_table[max_state - 1] / 1000);
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
