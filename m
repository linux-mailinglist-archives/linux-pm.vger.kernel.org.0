Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47B19862E0
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2019 15:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733005AbfHHNS6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Aug 2019 09:18:58 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46516 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733007AbfHHNS6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Aug 2019 09:18:58 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190808131854euoutp023d8c6aab5aae330654a6c4195b0f3c2b~49ROBjBzJ0280702807euoutp02R
        for <linux-pm@vger.kernel.org>; Thu,  8 Aug 2019 13:18:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190808131854euoutp023d8c6aab5aae330654a6c4195b0f3c2b~49ROBjBzJ0280702807euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565270334;
        bh=YrgKSNRT+dj7apCNW4T1jfuthafLSeLBtWDgIzZDeRo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=fLgHndTRRu9fzFHGCWQWOmX8hYbrWPoSKw07wdaCpGbBzm+rt30vU2abzn1DCDi+X
         TgcAGOhqQ5mB0aeH0YUX5XSC4j8aiYmQxEb+v8QZjR+zlxMrWIw/nC+dEIolowCScF
         OeDFjSG46gNFWa6jClK1oqsgCb9vYzB9xVAmi0To=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190808131853eucas1p276e4d1c862c28aab5479ba275006ac19~49RNVAeoI2300123001eucas1p29;
        Thu,  8 Aug 2019 13:18:53 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 24.22.04309.D312C4D5; Thu,  8
        Aug 2019 14:18:53 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190808131853eucas1p1224b4a4b31516e3e838dd1736522fc83~49RMhqxGz3045330453eucas1p1w;
        Thu,  8 Aug 2019 13:18:53 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190808131852eusmtrp1c1067be0e387abfb1cd4b4007eba551b~49RMTNoTz2711327113eusmtrp1i;
        Thu,  8 Aug 2019 13:18:52 +0000 (GMT)
X-AuditID: cbfec7f4-afbff700000010d5-2b-5d4c213db3a5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A2.91.04117.C312C4D5; Thu,  8
        Aug 2019 14:18:52 +0100 (BST)
Received: from AMDC3555 (unknown [106.120.51.67]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20190808131852eusmtip2d918f27bb09551b9a3e87340bc126557~49RLtenih0261402614eusmtip2P;
        Thu,  8 Aug 2019 13:18:52 +0000 (GMT)
Message-ID: <7171e3c56b0dca8a81058e77dd76bd1e684e7778.camel@partner.samsung.com>
Subject: Re: [RFC PATCH 09/11] devfreq: exynos-bus: Add interconnect
 functionality to exynos-bus
From:   Artur =?UTF-8?Q?=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     krzk@kernel.org, myungjoo.ham@samsung.com, inki.dae@samsung.com,
        sw0312.kim@samsung.com, georgi.djakov@linaro.org,
        m.szyprowski@samsung.com
Date:   Thu, 08 Aug 2019 15:18:51 +0200
In-Reply-To: <5a82bf8a-d925-ba54-a26f-98b64bedc6e1@samsung.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLKsWRmVeSWpSXmKPExsWy7djPc7q2ij6xBm1/FS2uf3nOajH/yDlW
        iytf37NZTN+7ic1i0v0JLBbnz29gt9j0+BqrxeVdc9gsPvceYbSYcX4fk8XaI3fZLW43rmCz
        mDH5JZsDr8emVZ1sHneu7WHzuN99nMlj85J6j74tqxg9Pm+SC2CL4rJJSc3JLEst0rdL4Mq4
        sfsOY8HXkIpbP2MaGPc7dTFyckgImEhM/naRtYuRi0NIYAWjxIS781ggnC+MEu++XoJyPjNK
        bO99yw7TcvtBPztEYjmjxP/lx5lBEkICzxgl5kyUArF5BQIk+iY1soLYwgJJEgseXQSz2QTc
        Jf49vwK2T0TgHaPEk/0fmEEcZoGJjBLPj/9n6mLk4GARUJVYPC8EpIFTwF5iw/YmRojNOhJv
        T/WxgJTwCghK/N0hDBJmFpCXaN46G2yMhMA1dolJK1ZCXeoi8e/eGqheYYlXx7dAxWUkTk/u
        YYGwiyWe7rzPCtHcwCixadkRZoiEtcTh4yBXcwBt0JRYv0sfIuwo8bbvKDNIWEKAT+LGW0GI
        G/gkJm2bDhXmlehoE4IwtSQW/I6GaJSQaFp9DWq2h0TLo+fsExgVZyH8MgvJL7MQti5gZF7F
        KJ5aWpybnlpslJdarlecmFtcmpeul5yfu4kRmKhO/zv+ZQfjrj9JhxgFOBiVeHgLTnjHCrEm
        lhVX5h5ilOBgVhLhvVfmGSvEm5JYWZValB9fVJqTWnyIUZqDRUmct5rhQbSQQHpiSWp2ampB
        ahFMlomDU6qBMVGwRj6j9MKvJJ/zkjVXzoYtbn8+N361i8mdgn11e++1tu24FDqHcwH7xuJD
        5R9W6Cvcqdn24tzVSC9lbic/jwvXf6cbnnyrbZRsl7l1ae5cdesl6grPSxlVDsU8lZKL8n3D
        v/r+i1MNV4oPVRjdc/pjN3//xP3bv+2XLjdVPrXP+Z7GzVMfPZVYijMSDbWYi4oTAXz/dpBQ
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsVy+t/xe7o2ij6xBi9W61lc//Kc1WL+kXOs
        Fle+vmezmL53E5vFpPsTWCzOn9/AbrHp8TVWi8u75rBZfO49wmgx4/w+Jou1R+6yW9xuXMFm
        MWPySzYHXo9NqzrZPO5c28Pmcb/7OJPH5iX1Hn1bVjF6fN4kF8AWpWdTlF9akqqQkV9cYqsU
        bWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJdxY/cdxoKvIRW3fsY0MO536mLk
        5JAQMJG4/aCfvYuRi0NIYCmjREP3DkaIhITEx/U3WCFsYYk/17rYIIqeMEocO7GHCSTBKxAg
        0TepEaxIWCBJYsGji2A2m4C7xL/nV1hBGkQE3jNKfNj+DmwFs8AkRomj8/exdDFycLAIqEos
        nhcC0sApYC+xYXsTI8SGNiaJvjU7wTYwC2hKtG7/zQ5xho7E21N9YL28AoISf3cIQ5TISzRv
        nc08gVFwFpKOWQhVs5BULWBkXsUoklpanJueW2ykV5yYW1yal66XnJ+7iREYh9uO/dwCDIB3
        wYcYBTgYlXh4NeR9YoVYE8uKK3MPMUpwMCuJ8N4r84wV4k1JrKxKLcqPLyrNSS0+xGgK9M5E
        ZinR5HxgisgriTc0NTS3sDQ0NzY3NrNQEuftEDgYIySQnliSmp2aWpBaBNPHxMEp1cCYzyB6
        TzNJf/aOzdl7lWvnaG5K3uH53714et73H3vvn1/XOMu4f9qFW77rb1z7xWKzQ/DzPqAjz91+
        MVHT6tLt6fL+39xOH/rxa9LJcOWGCOly2W/xPScF380IDQxYwfzreFXtsYPT51Z0KLPV8jkx
        PFlUU2Fu/q6K0Uw2Plz65mvT+YKsR0OVWIozEg21mIuKEwGMNUpW2QIAAA==
X-CMS-MailID: 20190808131853eucas1p1224b4a4b31516e3e838dd1736522fc83
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190723122028eucas1p2eb75f35b810e71d6c590370aaff0997b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190723122028eucas1p2eb75f35b810e71d6c590370aaff0997b
References: <20190723122016.30279-1-a.swigon@partner.samsung.com>
        <CGME20190723122028eucas1p2eb75f35b810e71d6c590370aaff0997b@eucas1p2.samsung.com>
        <20190723122016.30279-10-a.swigon@partner.samsung.com>
        <5a82bf8a-d925-ba54-a26f-98b64bedc6e1@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Thank you for your remarks. I will take them into account while preparing RFCv2.

On Mon, 2019-07-29 at 10:52 +0900, Chanwoo Choi wrote:
> Hi,
> 
> On 19. 7. 23. 오후 9:20, Artur Świgoń wrote:
> > This patch adds interconnect functionality to the exynos-bus devfreq
> > driver.
> > 
> > The SoC topology is a graph (or, more specifically, a tree) and most of its
> > edges are taken from the devfreq parent-child hierarchy (cf.
> > Documentation/devicetree/bindings/devfreq/exynos-bus.txt). The previous
> > patch adds missing edges to the DT (under the name 'parent'). Due to
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
> > The devfreq target() callback provided by exynos-bus now selects either the
> > frequency calculated by the devfreq governor or the frequency requested via
> > the interconnect API for the given node, whichever is higher.
> 
> Basically, I agree to support the QoS requirement between devices.
> But, I think that need to consider the multiple cases.
> 
> 
> 1. When changing the devfreq governor by user,
> For example of the connection between bus_dmc/leftbus/display on patch8,
> there are possible multiple cases with various devfreq governor
> which is changed on the runtime by user through sysfs interface.
> 
> If users changes the devfreq governor as following:
> Before,
> - bus_dmc (simple_ondemand, available frequency 100/200/300/400 MHz)
> --> bus_leftbus(simple_ondemand, available frequency 100/200/300/400 MHz)
> ----> bus_display(passive)
> 
> After changed governor of bus_dmc,
> if the min_freq by interconnect requirement is 400Mhz,
> - bus_dmc (powersave) : min_freq and max_freq and cur_freq is 100MHz
> --> bus_leftbus(simple_ondemand) : cur_freq is 400Mhz
> ----> bus_display(passive)
> 
> The final frequency is 400MHz of bus_dmc
> even if the min_freq/max_freq/cur_freq is 100MHz.
> It cannot show the correct min_freq/max_freq through
> devfreq sysfs interface.
> 
> 
> 2. When disabling the some frequency by devfreq-thermal throttling,
> This patch checks the min_freq of interconnect requirement
> in the exynos_bus_target() and exynos_bus_passive_target().
> Also, it cannot show the correct min_freq/max_freq through
> devfreq sysfs interface.
> 
> For example of bus_dmc bus,
> - The available frequencies are 100MHz, 200MHz, 300MHz, 400MHz
> - Disable 400MHz by devfreq-thermal throttling 
> - min_freq is 100MHz
> - max_freq is 300MHz
> - min_freq of interconnect is 400MHz
> 
> In result, the final frequency is 400MHz by exynos_bus_target()
> There are no problem for working. But, the user cannot know
> reason why cur_freq is 400MHz even if max_freq is 300MHz.
> 
> Basically, update_devfreq() considers the all constraints
> of min_freq/max_freq to decide the proper target frequency.
> 
> 
> 3.
> I think that the exynos_bus_passive_target() is used for devfreq device
> using 'passive' governor. The frequency already depends on the parent device.
> 
> If already the parent devfreq device like bus_leftbus consider
> the minimum frequency of QoS requirement like interconnect,
> it is not necessary. The next frequency of devfreq device
> with 'passive' governor, it will apply the QoS requirement
> without any additional code.
> 
> > 
> > Please note that it is not an error when CONFIG_INTERCONNECT is 'n', in
> > which case all interconnect API functions are no-op.
> > 
> > Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
> > ---
> >  drivers/devfreq/exynos-bus.c | 145 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 145 insertions(+)
> > 
> > diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> > index 412511ca7703..12fb7c84ae50 100644
> > --- a/drivers/devfreq/exynos-bus.c
> > +++ b/drivers/devfreq/exynos-bus.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/devfreq-event.h>
> >  #include <linux/device.h>
> >  #include <linux/export.h>
> > +#include <linux/interconnect-provider.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> >  #include <linux/pm_opp.h>
> > @@ -23,6 +24,8 @@
> >  #define DEFAULT_SATURATION_RATIO	40
> >  #define DEFAULT_VOLTAGE_TOLERANCE	2
> >  
> > +#define icc_units_to_hz(x) ((x) * 1000UL / 8)
> > +
> >  struct exynos_bus {
> >  	struct device *dev;
> >  
> > @@ -31,12 +34,17 @@ struct exynos_bus {
> >  	unsigned int edev_count;
> >  	struct mutex lock;
> >  
> > +	unsigned long min_freq;
> >  	unsigned long curr_freq;
> >  
> >  	struct regulator *regulator;
> >  	struct clk *clk;
> >  	unsigned int voltage_tolerance;
> >  	unsigned int ratio;
> > +
> > +	/* One provider per bus, one node per provider */
> > +	struct icc_provider provider;
> > +	struct icc_node *node;
> >  };
> >  
> >  /*
> > @@ -61,6 +69,13 @@ exynos_bus_ops_edev(enable_edev);
> >  exynos_bus_ops_edev(disable_edev);
> >  exynos_bus_ops_edev(set_event);
> >  
> > +static int exynos_bus_next_id(void)
> > +{
> > +	static int exynos_bus_node_id;
> > +
> > +	return exynos_bus_node_id++;
> > +}
> > +
> >  static int exynos_bus_get_event(struct exynos_bus *bus,
> >  				struct devfreq_event_data *edata)
> >  {
> > @@ -98,6 +113,8 @@ static int exynos_bus_target(struct device *dev, unsigned
> > long *freq, u32 flags)
> >  	unsigned long old_freq, new_freq, new_volt, tol;
> >  	int ret = 0;
> >  
> > +	*freq = max(*freq, bus->min_freq);
> > +
> >  	/* Get new opp-bus instance according to new bus clock */
> >  	new_opp = devfreq_recommended_opp(dev, freq, flags);
> >  	if (IS_ERR(new_opp)) {
> > @@ -208,6 +225,8 @@ static int exynos_bus_passive_target(struct device *dev,
> > unsigned long *freq,
> >  	unsigned long old_freq, new_freq;
> >  	int ret = 0;
> >  
> > +	*freq = max(*freq, bus->min_freq);
> > +
> >  	/* Get new opp-bus instance according to new bus clock */
> >  	new_opp = devfreq_recommended_opp(dev, freq, flags);
> >  	if (IS_ERR(new_opp)) {
> > @@ -251,6 +270,35 @@ static void exynos_bus_passive_exit(struct device *dev)
> >  	clk_disable_unprepare(bus->clk);
> >  }
> >  
> > +static int exynos_bus_icc_set(struct icc_node *src, struct icc_node *dst)
> > +{
> > +	struct exynos_bus *src_bus = src->data, *dst_bus = dst->data;
> > +
> > +	src_bus->min_freq = icc_units_to_hz(src->peak_bw);
> > +	dst_bus->min_freq = icc_units_to_hz(dst->peak_bw);
> > +
> > +	return 0;
> > +}
> > +
> > +static int exynos_bus_icc_aggregate(struct icc_node *node, u32 avg_bw,
> > +				    u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
> > +{
> > +	*agg_peak = *agg_avg = peak_bw;
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
> > @@ -469,6 +517,95 @@ static int exynos_bus_profile_init_passive(struct
> > exynos_bus *bus,
> >  	return ret;
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
> > +			goto out;
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
> > +	id = exynos_bus_next_id();
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
> > @@ -517,6 +654,14 @@ static int exynos_bus_probe(struct platform_device
> > *pdev)
> >  			goto err;
> >  	}
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


