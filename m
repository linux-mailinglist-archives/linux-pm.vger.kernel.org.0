Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B285110EDCC
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2019 18:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbfLBRFV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Dec 2019 12:05:21 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:44183 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbfLBRFV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Dec 2019 12:05:21 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191202170518euoutp0139368d2e1e0be616cb4ac003a7d3e90c~cnMANcgSr1088010880euoutp017
        for <linux-pm@vger.kernel.org>; Mon,  2 Dec 2019 17:05:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191202170518euoutp0139368d2e1e0be616cb4ac003a7d3e90c~cnMANcgSr1088010880euoutp017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575306318;
        bh=st3c9KPKtPtiDw5raSov1qy5fVYNC0lFSVzRu5QYeQw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mGd8TmKgUfIkFckj4SZrMmPAUbBhpsn4iq0b3y3wx40p+Xac8B1mVzol8wrrQtt9s
         MQgici/jsdSZAsbDI0SbKHayrm97/tCQp6FhPiMwnRL/NVgBvJ7E5soaoI6ptmzGjS
         1DMXh2nLlbaWa+yMsD/ZKUfNPR0l8dt0g5BlYSnA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191202170517eucas1p2bd2c406bcdac2cc0142d77454aaa4ac8~cnL-zLzZs2657226572eucas1p2D;
        Mon,  2 Dec 2019 17:05:17 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 5E.63.60698.D4445ED5; Mon,  2
        Dec 2019 17:05:17 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191202170517eucas1p1d9298087e553dbc9d9986dc7ec41d669~cnL-fddXR2466624666eucas1p1L;
        Mon,  2 Dec 2019 17:05:17 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191202170517eusmtrp1624e4c831d116920e8ed941cf479123f~cnL-er8Lk2436324363eusmtrp1W;
        Mon,  2 Dec 2019 17:05:17 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-c1-5de5444d1904
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 67.B7.08375.D4445ED5; Mon,  2
        Dec 2019 17:05:17 +0000 (GMT)
Received: from AMDC3555 (unknown [106.120.51.67]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20191202170516eusmtip1dab1e87cd2d1bc05270ebbc122ad427f~cnL_vWgkg2058220582eusmtip1e;
        Mon,  2 Dec 2019 17:05:16 +0000 (GMT)
Message-ID: <9b3b21d3e4678946724531c58ad7f9c7a3993a95.camel@samsung.com>
Subject: Re: [RFC PATCH v2 09/11] devfreq: exynos-bus: Add interconnect
 functionality to exynos-bus
From:   Artur =?UTF-8?Q?=C5=9Awigo=C5=84?= <a.swigon@samsung.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     myungjoo.ham@samsung.com, inki.dae@samsung.com,
        sw0312.kim@samsung.com, georgi.djakov@linaro.org,
        leonard.crestez@nxp.com, m.szyprowski@samsung.com,
        b.zolnierkie@samsung.com, krzk@kernel.org
Date:   Mon, 02 Dec 2019 18:05:16 +0100
In-Reply-To: <e004bedd-294b-172b-5e34-bf7afcfd04bc@samsung.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+3YuO46mxyn5YpI0KFIqrSQPFc3A6lR0769CauXRRXMbO2pX
        aGpWswvLiKkZWkqZIdpaSyUNdTnJ5TLLvKaUFllqtTLsojmPYf893/s9v+d5P/goTOYkAqmD
        mkROr1Gq5aQEt9WPNi3aHN0fE95+O4K5m1VKMK++vSeYPHsTwbz4Pkwy5ioLyWT2mHDG5SoT
        M0XdXwjG8raVYFoqc0nGfcGOmCxXtYgpsXeLmc6UIpLJuvyBjPJhLcVGku1qfUiyPeccIvZe
        4Un27lC5iL1oLUas2zJnm3i3ZFUspz6YzOnDVu+TqMZHunBd37ojI+M1uAHlR2YgLwroCEi/
        ko1nIAklo4sQuCoMmHD4hqCvw0Z6XDLajaC9ff0/wmS8RAqmWwieFaZPEe8QvLE4xRmIoqQ0
        C7/c4R7Aj+Ygt+QB5tEkrYCnnSMij9+fHppoePR5EsboegRVXaO4x4XT86C08gbpCfKaILqc
        O4XmhTD45CIu5PvCn3I/zxijgyHt/tXJGKAHxfB0PA8X/NFgNbswQfvBgMMqFnQQNF4+P+Xh
        ob+ihxBgAwLLTfsUsBLqHM2EpwyjQyb2CRPGa8CZ2jG5A9De0DboK+zgDZk2MyaMpXD2tEyQ
        cqjM9hZAgNQ7rVPZLFjTcnETmpsz/Zac/96SM92aj7BiFMAl8QnxHL9Mwx1ezCsT+CRN/OID
        2gQLmvhjjWOO7+Wo+vf+WkRTSD5TqvrZFyMjlMn80YRaBBQm95faoD9GJo1VHj3G6bV79Ulq
        jq9FsylcHiA9PqN3j4yOVyZyhzhOx+n/3Yoor0ADskg+BoUGGW6rgnszfRqQPORlzYZPKXFx
        z19fMBY0JrapV8z2qzSbZLusFQvK2rRo4OO1weVDGyN9xrp3bFXMt29P/HFP5/I9FuVStK4d
        1kbvGG6ZNSeteNz2VZcZYtzyeNPSwOaWs+uizCeJDRWnCgrNDWea4zbXZasiTihSrm9CcpxX
        KZeEYnpe+RcvRCOVXwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsVy+t/xu7q+Lk9jDSadk7PYOGM9q8X1L89Z
        LeYfOcdqceXrezaL6Xs3sVlMuj+BxeL8+Q3sFivufmS12PT4GqvF5V1z2Cw+9x5htJhxfh+T
        xdojd9ktbjeuYLOYMfklmwO/x6ZVnWwed67tYfO4332cyWPzknqPje92MHn0bVnF6PF5k1wA
        e5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexv9v
        d1gKnrhVfPt/kKWBcYF5FyMnh4SAicSEzolsXYxcHEICSxklFv64ygaRkJD4uP4GK4QtLPHn
        WhdU0RNGiftN34ASHBy8Ah4Svz8bgNQIC6RKzFm7nRnEZhOwlzh7+xsTSL2IwHtGiQ/b37GD
        OMwCJxgldl57DraBRUBVYv2uRWwggziBOu6cCYZY8IVR4vSJmWCbmQU0JVq3/2aHuEJH4u2p
        PhaIxYISf3cIQ5TISzRvnc08gVFwFpKOWQhVs5BULWBkXsUoklpanJueW2yoV5yYW1yal66X
        nJ+7iREYpduO/dy8g/HSxuBDjAIcjEo8vBm/nsQKsSaWFVfmHmKU4GBWEuHdJvE0Vog3JbGy
        KrUoP76oNCe1+BCjKdA7E5mlRJPzgQkkryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpiSWp2
        ampBahFMHxMHp1QD4xwzzmRWFu2nVWu/Gh1cKP3HKfr4nLcPGmINrbe1OsZEsDBu9yl/teeS
        4oqzRjGB+QoHd7J/27eF7+oNxoh1+ksvt6Vx/JX+usJGOrNk1sR4N4tpG5ZGc1+6lfrQrzNt
        x+Xvj2wdu1dtbepIzN74l+uz2pxbjjVPOsX1Tl03Sr0ScHf1e5P2w0osxRmJhlrMRcWJALqT
        cq7oAgAA
X-CMS-MailID: 20191202170517eucas1p1d9298087e553dbc9d9986dc7ec41d669
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

Hi Chanwoo,

On Wed, 2019-09-25 at 16:03 +0900, Chanwoo Choi wrote:
> Hi,
> 
> I need the time to dig the ICC framework
> to understand them detailed. After that, I'll review this.

Any updates on this topic?

Regardless of the purpose of this RFC, I think patches 01-04
are still beneficial to devfreq. I can rebase and post them
as a separate series if you wish.

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
> 
> 
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

Best regards,
-- 
Artur Świgoń
Samsung R&D Institute Poland
Samsung Electronics


