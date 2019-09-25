Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD22BD8D4
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2019 09:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442529AbfIYHMu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Sep 2019 03:12:50 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:48115 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442450AbfIYHMt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Sep 2019 03:12:49 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190925071247euoutp0177fc63f5ab6a9100cf251bb51016a884~HnPQMNpIF0658906589euoutp01Q
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2019 07:12:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190925071247euoutp0177fc63f5ab6a9100cf251bb51016a884~HnPQMNpIF0658906589euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569395567;
        bh=TZZfMZ9X+Kf4BVzoP45bIuxZ5Fy+9T8yDoeDsO9sUz8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=kZRl1eiLDpEv1q6Q8eMd9GZehBRuYa+QTdO/nuq5ozYsE16nQL3z7rcFrWX82lW9K
         xvOkohFS8J9ivzbRiyluu0Z57XtfHN6r4/F8oZyCYzFkKCb14xaCruaqpg8UuiQzWT
         1cCD2IWnRpXpkW7YZTOLyXHeHh/NXDNAsFC+RydI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190925071246eucas1p249ddf52261b715e4f53b1c2a108f2b8a~HnPPwvR4o0506205062eucas1p2v;
        Wed, 25 Sep 2019 07:12:46 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id DF.29.04374.E631B8D5; Wed, 25
        Sep 2019 08:12:46 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190925071246eucas1p2df0c05c3910aa1b0de48cf044c2aba1d~HnPPVqxm90509705097eucas1p2f;
        Wed, 25 Sep 2019 07:12:46 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190925071246eusmtrp153808a83ff9df7fea2f2a9d66989fd01~HnPPUeDn90245602456eusmtrp1X;
        Wed, 25 Sep 2019 07:12:46 +0000 (GMT)
X-AuditID: cbfec7f5-4f7ff70000001116-a8-5d8b136ecea7
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B6.F6.04166.E631B8D5; Wed, 25
        Sep 2019 08:12:46 +0100 (BST)
Received: from AMDC3555 (unknown [106.120.51.67]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20190925071245eusmtip20fdb64259c8802281f99716a99e9d436~HnPOg8RWf1311813118eusmtip2h;
        Wed, 25 Sep 2019 07:12:45 +0000 (GMT)
Message-ID: <9b6a744b732e2cbf95df4da203f94a039a39af21.camel@samsung.com>
Subject: Re: [RFC PATCH v2 09/11] devfreq: exynos-bus: Add interconnect
 functionality to exynos-bus
From:   Artur =?UTF-8?Q?=C5=9Awigo=C5=84?= <a.swigon@samsung.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Artur =?UTF-8?Q?=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        myungjoo.ham@samsung.com, inki.dae@samsung.com,
        sw0312.kim@samsung.com, georgi.djakov@linaro.org,
        leonard.crestez@nxp.com, m.szyprowski@samsung.com,
        b.zolnierkie@samsung.com, krzk@kernel.org
Date:   Wed, 25 Sep 2019 09:12:45 +0200
In-Reply-To: <e004bedd-294b-172b-5e34-bf7afcfd04bc@samsung.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SaUwTYRD16x5dqiVLQZkg0diIB/HGhI0HYKJmf3n+QkN0kQ2itCVdwAON
        HHIrIBjAWo9EkCsNUDkqKhJsxACKAgEFGkjkiCiXgIIiSrsQ/PfmzXvzZpKhMEUz4UIFqUN5
        rZoLVpIyvOL1dNNmtWOy37aG2fVM9/1YxJRmFxNM+8QAwTwwvyOY1skRksl6YSSZ9O40nGlq
        KpEy+ZYxgjF+biOYlio9yYzfNCMmu6lawhjMFinTGZVPMtkZX0gfmjUWJpJsV9tzku1OrpOw
        T3KusaXDJgmbUlaI2HHjqiPSE7I9AXxwUDiv3ep1Wnb29614LGTq4MWSrnxpJDJ5JiE7Cuid
        EP8tDU9CMkpB5yMoLTNhYjGBoCavkBSLcQQ9Od+lC5bO1sR5VR6Cjpjq+aIfQdF0O2lVyWkW
        ckyNmBU70jzoDZU2TNLe8Lbzh8RqcKKHEfS+HLW5Mfq6BAZ0g3OrUBROu8GzvrVWaDdn6Go8
        LiZvgqH6FJtCTjvAH5Ojlcbo1RBTftc2BehJKdTcbydE/X5ITXhKitgRBuvK5i9whYaMG7iI
        Beh72k2I5kgExsdmTGzshld1HwhrGEZvhOKqrSK9DxqjO2w7AG0PH4ccxB3sIb0iCxNpOSTE
        KUSohKo79qIRILqobX42C2UxejwNrdEt3qL77xbdYupDhBUiZz5MUAXygoeav7BF4FRCmDpw
        yxmNyojmPq1htm7ShKpn/GsRTSHlMrkPkeSnILhw4ZKqFgGFKZ3kOtc5Sh7AXbrMazWntGHB
        vFCLVlK40lkesaTnpIIO5EL58zwfwmsXuhLKziUS1RftMntWBBd4se8jDlx+lNqbh5fL9Rmq
        pX97vFsCoqISZW/6RzUFa92yfUoOh5PN55Z/7fV/sMP3yrtj/pU/zZmcZuTXVQ+V2lR+x7XX
        b3A0RePhstkycHtFrmYmN9HBsiGGyzy299M6B29DyL24MYt+yr3lkFd09dHpcMmIwTdWiQtn
        ue3umFbg/gFJ5/arZQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsVy+t/xe7p5wt2xBt172Czuz2tltNg4Yz2r
        xfUvz1kt5h85x2px5et7NovpezexWUy6P4HF4vz5DewWK+5+ZLXY9Pgaq8XlXXPYLD73HmG0
        mHF+H5PF2iN32S1uN65gs5gx+SWbg4DHplWdbB53ru1h87jffZzJY/OSeo+N73YwefRtWcXo
        8XmTXAB7lJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5d
        gl7G74ntzAU/3Co23FnB3sC4w7yLkZNDQsBE4vaVTuYuRi4OIYGljBIrzh5ihEhISHxcf4MV
        whaW+HOtiw2i6AmjxNH2T2wgCV4BD4klO84wg9jCAqkSc9ZuB7PZBOwlzt7+xgTSICLwnlHi
        w/Z37CAOs0Abk8Shvs1AYzk4WARUJXY/VQExOYEa7pwJhljwhVHi9ImZYJuZBTQlWrf/Zoe4
        Qkfi7ak+FpB6XgFBib87hCFK5CWat85mnsAoOAtJxyyEqllIqhYwMq9iFEktLc5Nzy021CtO
        zC0uzUvXS87P3cQIjNdtx35u3sF4aWPwIUYBDkYlHl4H1q5YIdbEsuLK3EOMEhzMSiK8s2SA
        QrwpiZVVqUX58UWlOanFhxhNgb6ZyCwlmpwPTCV5JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE
        0hNLUrNTUwtSi2D6mDg4pRoYc+qe7TrXcM66S+/4g85rqzPMJbKXzrVvm9s1J2ae26GVOg4L
        c1l0+nSlfXuUXQLXOQcYP/zj/lFETaFUparp+onTHwOr3Y2d2ViCZfXO71hgl/Hy7Ias+Rqr
        BN4qPn733Ndv85UQxYLVbyayCDwSfmwtKzDz4omWS0kzW0tDWcS+6/9bzdqhxFKckWioxVxU
        nAgAgGARVu0CAAA=
X-CMS-MailID: 20190925071246eucas1p2df0c05c3910aa1b0de48cf044c2aba1d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190919142329eucas1p2e53992eab9ec6b404f716f955b3c228e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190919142329eucas1p2e53992eab9ec6b404f716f955b3c228e
References: <20190919142236.4071-1-a.swigon@samsung.com>
        <CGME20190919142329eucas1p2e53992eab9ec6b404f716f955b3c228e@eucas1p2.samsung.com>
        <20190919142236.4071-10-a.swigon@samsung.com>
        <e004bedd-294b-172b-5e34-bf7afcfd04bc@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Wed, 2019-09-25 at 16:03 +0900, Chanwoo Choi wrote:
> Hi,
> 
> I need the time to dig the ICC framework
> to understand them detailed. After that, I'll review this.
> 
> Basically, I agree this approach. But, I'm wondering
> the existing binding method between 'bus_leftbus' and 'bus_dmc'.
> From before, I thought that devfreq framework need to
> enhance the binding method between parent devfreq device
> and passive devfreq device instead of 'devfreq' property.
> 
> On this patch, use the same binding way between
> 'bus_leftbus' and 'bus_dmc' with 'parent' property
> as following:
> 
> +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> @@ -106,6 +106,7 @@
>  &bus_leftbus {
>  	devfreq-events = <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
>  	vdd-supply = <&buck3_reg>;
> +	parent = <&bus_dmc>;
>  	status = "okay";
>  };
> 
> I'm not sure about continuing to use this method for new feature.
> If possible, hope to replace the existing binding style
> with new method like of_graph. Actually, I don't know the correct method.

Adding the 'parent' binding was the simplest solution to create this
RFC to show the concept of using interconnect functionality in devfreq.
I agree that a method like of_graph is probably more elegant. I am open
to suggestions.

> On 19. 9. 19. 오후 11:22, Artur Świgoń wrote:
> > From: Artur Świgoń <a.swigon@partner.samsung.com>
> > 
> > This patch adds interconnect functionality to the exynos-bus devfreq
> > driver.
> > 
> > The SoC topology is a graph (or, more specifically, a tree) and most of
> > its edges are taken from the devfreq parent-child hierarchy (cf.
> > Documentation/devicetree/bindings/devfreq/exynos-bus.txt). Due to
> > unspecified relative probing order, -EPROBE_DEFER may be propagated to
> > guarantee that a child is probed before its parent.
> > 
> > Each bus is now an interconnect provider and an interconnect node as well
> > (cf. Documentation/interconnect/interconnect.rst), i.e. every bus registers
> > itself as a node. Node IDs are not hardcoded but rather assigned at
> > runtime, in probing order (subject to the above-mentioned exception
> > regarding relative order). This approach allows for using this driver with
> > various Exynos SoCs.
> > 
> > Frequencies requested via the interconnect API for a given node are
> > propagated to devfreq using dev_pm_qos_update_request(). Please note that
> > it is not an error when CONFIG_INTERCONNECT is 'n', in which case all
> > interconnect API functions are no-op.
> > 
> > Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
> > ---
> >  drivers/devfreq/exynos-bus.c | 153 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 153 insertions(+)
> > 
> > diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> > index 8d44810cac69..e0232202720d 100644
> > --- a/drivers/devfreq/exynos-bus.c
> > +++ b/drivers/devfreq/exynos-bus.c
> > @@ -14,14 +14,19 @@
> >  #include <linux/devfreq-event.h>
> >  #include <linux/device.h>
> >  #include <linux/export.h>
> > +#include <linux/idr.h>
> > +#include <linux/interconnect-provider.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> >  #include <linux/pm_opp.h>
> > +#include <linux/pm_qos.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/regulator/consumer.h>
> >  
> >  #define DEFAULT_SATURATION_RATIO	40
> >  
> > +#define icc_units_to_khz(x) ((x) / 8)
> > +
> >  struct exynos_bus {
> >  	struct device *dev;
> >  
> > @@ -35,6 +40,12 @@ struct exynos_bus {
> >  	struct opp_table *opp_table;
> >  	struct clk *clk;
> >  	unsigned int ratio;
> > +
> > +	/* One provider per bus, one node per provider */
> > +	struct icc_provider provider;
> > +	struct icc_node *node;
> > +
> > +	struct dev_pm_qos_request qos_req;
> >  };
> >  
> >  /*
> > @@ -59,6 +70,13 @@ exynos_bus_ops_edev(enable_edev);
> >  exynos_bus_ops_edev(disable_edev);
> >  exynos_bus_ops_edev(set_event);
> >  
> > +static int exynos_bus_next_id(void)
> > +{
> > +	static DEFINE_IDA(exynos_bus_icc_ida);
> > +
> > +	return ida_alloc(&exynos_bus_icc_ida, GFP_KERNEL);
> > +}
> > +
> >  static int exynos_bus_get_event(struct exynos_bus *bus,
> >  				struct devfreq_event_data *edata)
> >  {
> > @@ -171,6 +189,38 @@ static void exynos_bus_passive_exit(struct device *dev)
> >  	clk_disable_unprepare(bus->clk);
> >  }
> >  
> > +static int exynos_bus_icc_set(struct icc_node *src, struct icc_node *dst)
> > +{
> > +	struct exynos_bus *src_bus = src->data, *dst_bus = dst->data;
> > +	s32 src_freq = icc_units_to_khz(src->avg_bw);
> > +	s32 dst_freq = icc_units_to_khz(dst->avg_bw);
> > +
> > +	dev_pm_qos_update_request(&src_bus->qos_req, src_freq);
> > +	dev_pm_qos_update_request(&dst_bus->qos_req, dst_freq);
> > +
> > +	return 0;
> > +}
> > +
> > +static int exynos_bus_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
> > +				    u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
> > +{
> > +	*agg_avg += avg_bw;
> > +	*agg_peak = max(*agg_peak, peak_bw);
> > +
> > +	return 0;
> > +}
> > +
> > +static struct icc_node *exynos_bus_icc_xlate(struct of_phandle_args *spec,
> > +					     void *data)
> > +{
> > +	struct exynos_bus *bus = data;
> > +
> > +	if (spec->np != bus->dev->of_node)
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	return bus->node;
> > +}
> > +
> >  static int exynos_bus_parent_parse_of(struct device_node *np,
> >  					struct exynos_bus *bus)
> >  {
> > @@ -366,6 +416,101 @@ static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
> >  	return 0;
> >  }
> >  
> > +static int exynos_bus_icc_connect(struct exynos_bus *bus)
> > +{
> > +	struct device_node *np = bus->dev->of_node;
> > +	struct devfreq *parent_devfreq;
> > +	struct icc_node *parent_node = NULL;
> > +	struct of_phandle_args args;
> > +	int ret = 0;
> > +
> > +	parent_devfreq = devfreq_get_devfreq_by_phandle(bus->dev, 0);
> > +	if (!IS_ERR(parent_devfreq)) {
> > +		struct exynos_bus *parent_bus;
> > +
> > +		parent_bus = dev_get_drvdata(parent_devfreq->dev.parent);
> > +		parent_node = parent_bus->node;
> > +	} else {
> > +		/* Look for parent in DT */
> > +		int num = of_count_phandle_with_args(np, "parent",
> > +						     "#interconnect-cells");
> > +		if (num != 1)
> > +			goto out; /* 'parent' is optional */
> > +
> > +		ret = of_parse_phandle_with_args(np, "parent",
> > +						 "#interconnect-cells",
> > +						 0, &args);
> > +		if (ret < 0)
> > +			goto out;
> > +
> > +		of_node_put(args.np);
> > +
> > +		parent_node = of_icc_get_from_provider(&args);
> > +		if (IS_ERR(parent_node)) {
> > +			/* May be -EPROBE_DEFER */
> > +			ret = PTR_ERR(parent_node);
> > +			goto out;
> > +		}
> > +	}
> 
> 
> 
> > +
> > +	ret = icc_link_create(bus->node, parent_node->id);
> > +
> > +out:
> > +	return ret;
> > +}
> > +
> > +static int exynos_bus_icc_init(struct exynos_bus *bus)
> > +{
> > +	struct device *dev = bus->dev;
> > +	struct icc_provider *provider = &bus->provider;
> > +	struct icc_node *node;
> > +	int id, ret;
> > +
> > +	/* Initialize the interconnect provider */
> > +	provider->set = exynos_bus_icc_set;
> > +	provider->aggregate = exynos_bus_icc_aggregate;
> > +	provider->xlate = exynos_bus_icc_xlate;
> > +	provider->dev = dev;
> > +	provider->data = bus;
> > +
> > +	ret = icc_provider_add(provider);
> > +	if (ret < 0)
> > +		goto out;
> > +
> > +	ret = id = exynos_bus_next_id();
> > +	if (ret < 0)
> > +		goto err_node;
> > +
> > +	node = icc_node_create(id);
> > +	if (IS_ERR(node)) {
> > +		ret = PTR_ERR(node);
> > +		goto err_node;
> > +	}
> > +
> > +	bus->node = node;
> > +	node->name = dev->of_node->name;
> > +	node->data = bus;
> > +	icc_node_add(node, provider);
> > +
> > +	ret = exynos_bus_icc_connect(bus);
> > +	if (ret < 0)
> > +		goto err_connect;
> > +
> > +	ret = dev_pm_qos_add_request(bus->devfreq->dev.parent, &bus->qos_req,
> > +				     DEV_PM_QOS_MIN_FREQUENCY, 0);
> > +
> > +out:
> > +	return ret;
> > +
> > +err_connect:
> > +	icc_node_del(node);
> > +	icc_node_destroy(id);
> > +err_node:
> > +	icc_provider_del(provider);
> > +
> > +	return ret;
> > +}
> > +
> >  static int exynos_bus_probe(struct platform_device *pdev)
> >  {
> >  	struct device *dev = &pdev->dev;
> > @@ -415,6 +560,14 @@ static int exynos_bus_probe(struct platform_device *pdev)
> >  	if (ret < 0)
> >  		goto err;
> >  
> > +	/*
> > +	 * Initialize interconnect provider. A return value of -ENOTSUPP means
> > +	 * that CONFIG_INTERCONNECT is disabled.
> > +	 */
> > +	ret = exynos_bus_icc_init(bus);
> > +	if (ret < 0 && ret != -ENOTSUPP)
> > +		goto err;
> > +
> >  	max_state = bus->devfreq->profile->max_state;
> >  	min_freq = (bus->devfreq->profile->freq_table[0] / 1000);
> >  	max_freq = (bus->devfreq->profile->freq_table[max_state - 1] / 1000);
> > 
> 
> 
-- 
Artur Świgoń
Samsung R&D Institute Poland
Samsung Electronics


