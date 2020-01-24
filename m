Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C26681481BB
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2020 12:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391193AbgAXLWU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Jan 2020 06:22:20 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52772 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391184AbgAXLWT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jan 2020 06:22:19 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200124112216euoutp0283c84fe0dbfc7d183495f876229937c6~szsocKtMb1664016640euoutp02f
        for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2020 11:22:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200124112216euoutp0283c84fe0dbfc7d183495f876229937c6~szsocKtMb1664016640euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579864936;
        bh=7QgOgBbRwaO1gPunTQwolQO1mswbl0Pc5i8yAbUQ7qk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YZLOMn+A/X6tUtWKvkzA/UpAnpfqt0MdlZPtN/VIeL7jwui+D04mQCpyuPr3AFOa6
         SNFwANL99xOyfNmGSuxg34vGqZTHNSGdGgJKTQlomG32M5P75InIXYqgHCQ7K2H56V
         epn0RnABlf3bV80gvnQuysplVGeMvjp0U9u7UocU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200124112216eucas1p1beb2dd4f097b85d70af5ece129f5cf6c~szsoCkfQW0250602506eucas1p1v;
        Fri, 24 Jan 2020 11:22:16 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 31.64.60679.863DA2E5; Fri, 24
        Jan 2020 11:22:16 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200124112215eucas1p202d735ab621b1ed19fffb34fa54c6a3b~szsnqz4Lm2557325573eucas1p2B;
        Fri, 24 Jan 2020 11:22:15 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200124112215eusmtrp190437a0c868cb781a2c552b95a5b0c47~szsnp9YCU0042100421eusmtrp1h;
        Fri, 24 Jan 2020 11:22:15 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-4b-5e2ad368735f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F3.FC.08375.763DA2E5; Fri, 24
        Jan 2020 11:22:15 +0000 (GMT)
Received: from AMDC3555 (unknown [106.120.51.67]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200124112215eusmtip13e2ba550c7861f88bca97d78ccaa5b21~szsm5WRZf1680616806eusmtip1k;
        Fri, 24 Jan 2020 11:22:15 +0000 (GMT)
Message-ID: <0de33b1ae7c52270d11c606ecccc9af5f44d0421.camel@samsung.com>
Subject: Re: [RFC PATCH v3 5/7] devfreq: exynos-bus: Add interconnect
 functionality to exynos-bus
From:   Artur =?UTF-8?Q?=C5=9Awigo=C5=84?= <a.swigon@samsung.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        leonard.crestez@nxp.com, m.szyprowski@samsung.com,
        b.zolnierkie@samsung.com, krzk@kernel.org
Date:   Fri, 24 Jan 2020 12:22:14 +0100
In-Reply-To: <15795421-db12-8466-bb7e-688e6625cf4a@linaro.org>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRju29k5Ow63jlPwxaJoWaR5KbM4aJhG1In8EUH9KLwsPajkjR3n
        Ja28gJWmiAbaFCw1LxNvy0RXhthyeB1iaqRmUSYqKuYytYw2j2L/nvd53ud7nhc+EpMZcQcy
        IjqOVUYrIuWEWNjStTbgGj7kHHhsvNuabipqwOlR0zROl+oHcPr9z0WCLmzXEnT+ZJ6QNhob
        RXT1xBJOa7+O4PSQroSgl3P0iC4yvhHQdfoJET2WVk3QRQUzhO9uRqt5SDDjI68JZjLbIGBe
        VNxjmhZaBUxuswYxy9p9l0XXxadD2ciIeFbp7hMsDp+pNaHYkbOJb2ueYanosWcWsiKB8oSP
        FXqUhcSkjKpGUJfWhfODCUHTcAHGD8sIxuoNom1LcUcNwQtVZmF6dsvyHYFmUI9btiQUA5q2
        QmTBtlQIFHypE1owQZ2B/rEVgcVgR/1A0F9RvJmOUXoEcyvfNreE1CHQFQ1tuq0oH9iYNxF8
        tgvM9+Sad0hzgg1stNpaaIzaDxkvize7AjUvguf1K1tdz0HP53TEY1uYNTRv8Xuht+CRkMcc
        TLVN4rw5FYG2Uo/xgjeMD6wTljCMcoIGnTtP+0GXdkhkoYGSwod5G76DFPJbCjGelsCDTBkP
        5aB7IuWNAOm1I1tvMzC6tiTIQwfUO7eo/7tFvZP6FGEaZM+quKgwlvOIZhPcOEUUp4oOcwuJ
        idIi8zfr/WswtSLdn5udiCKR3FoCOU6BMlwRzyVFdSIgMbmdBF0zU5JQRdJtVhkTpFRFslwn
        2kMK5faSE2UzATIqTBHH3mLZWFa5rQpIK4dUVD+nqkx0GW67un5HnH/xSLdLckDPwbuZqtDz
        h+tnV12vpKwayi8Nekk9yvs6snP9/K1iX603KPuEyYtpK1W/p4xV1g03/BT+jsbsQHxdWzl1
        fyFesuYz+ym4LEU92birrUl6MuiCzPeU5N0vrxR1t7zFu6S0KsFxlSYyjrY3qhfkQi5ccdwZ
        U3KKf0AlGpJiAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsVy+t/xu7rpl7XiDC7eM7LYOGM9q8X1L89Z
        LeYfOcdqceXrezaL6Xs3sVlMuj+BxeL8+Q3sFivufmS12PT4GqvF5V1z2Cw+9x5htJhxfh+T
        xdojd9ktbjeuYLOYMfklmwO/x6ZVnWwed67tYfO4332cyWPzknqPje92MHn0bVnF6PF5k1wA
        e5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexsvV
        XxgLrjlVHF65kLmBcYpJFyMnh4SAicTsAyvZuhi5OIQEljJK7F/TwgqRkJD4uP4GlC0s8eda
        F1TRE0aJWx9XMoEkeAU8JFbtnM4IYgsLJEtMfriWBcRmE7CXOHv7GxNIg4jAZ0aJw4s+sYA4
        zAJHGSWenbjPDlLFIqAqsWvGZbBuTgE7ib9vv0Ct+MQocfz3a7AEs4CmROv23+wQd+hIvD3V
        BzSJA2i1oMTfHcIQJfISzVtnM09gFJyFpGMWQtUsJFULGJlXMYqklhbnpucWG+oVJ+YWl+al
        6yXn525iBEbqtmM/N+9gvLQx+BCjAAejEg+vRK9mnBBrYllxZe4hRgkOZiURXsYwoBBvSmJl
        VWpRfnxRaU5q8SFGU6B/JjJLiSbnA5NIXkm8oamhuYWlobmxubGZhZI4b4fAwRghgfTEktTs
        1NSC1CKYPiYOTqkGRvPHzqFrZX9WVn5OWCFz+MdHicbcJfeuV9oHz2CPu8Fjcd1smeZjQ4sM
        jwT7x2uOMSVr9rrp3ji3vCL8sMBaV4v3zxrDWI//MXqyaAOb14UkdrP8w7KNbDL7VvM2sLfq
        8Tv5PRe4x9N0c65nHv92kZc/Uhgvyl3dqlZYmcS4oPmigduGDadWKbEUZyQaajEXFScCAEak
        e/LqAgAA
X-CMS-MailID: 20200124112215eucas1p202d735ab621b1ed19fffb34fa54c6a3b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191220120145eucas1p295af63eed7b23982d8c49fcf875cec8c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191220120145eucas1p295af63eed7b23982d8c49fcf875cec8c
References: <20191220115653.6487-1-a.swigon@samsung.com>
        <CGME20191220120145eucas1p295af63eed7b23982d8c49fcf875cec8c@eucas1p2.samsung.com>
        <20191220115653.6487-6-a.swigon@samsung.com>
        <15795421-db12-8466-bb7e-688e6625cf4a@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Georgi,

On Wed, 2020-01-22 at 19:02 +0200, Georgi Djakov wrote:
> Hi Artur,
> 
> On 12/20/19 13:56, Artur Świgoń wrote:
> > This patch adds interconnect functionality to the exynos-bus devfreq
> > driver.
> > 
> > The SoC topology is a graph (or, more specifically, a tree) and its
> > edges are specified using the 'exynos,interconnect-parent-node' in the
> > DT. Due to unspecified relative probing order, -EPROBE_DEFER may be
> > propagated to ensure that the parent is probed before its children.
> > 
> > Each bus is now an interconnect provider and an interconnect node as well
> > (cf. Documentation/interconnect/interconnect.rst), i.e. every bus registers
> > itself as a node. Node IDs are not hardcoded but rather assigned at
> 
> Just to note that usually the provider consists of multiple nodes and each node
> represents a single master or slave port on the AXI bus for example. I am not
> sure whether this represents correctly the Exynos hardware, so it's up to
> you.
> 
> > runtime, in probing order (subject to the above-mentioned exception
> > regarding relative order). This approach allows for using this driver with
> > various Exynos SoCs.
> 
> This sounds good. I am wondering whether such dynamic probing would be useful
> for other platforms too. Then maybe it would make sense to even have a common DT
> property, but we will see.
> 
> Is this going to be used only together with devfreq?

Yes, this functions solely as an extension to devfreq, hence the slightly
unusual architecture (one icc_provider/icc_node per devfreq).

(Compared to a singleton icc_provider, this approach yields less code with
a very simple xlate()).

With exactly one icc_node for every devfreq device, I think I will actually
reuse the devfreq ID (as seen in the device name, e.g. the "3" in "devfreq3")
for the node ID. The devfreq framework already does the dynamic numbering
thing that I do in this patch using IDR.

> > Frequencies requested via the interconnect API for a given node are
> > propagated to devfreq using dev_pm_qos_update_request(). Please note that
> > it is not an error when CONFIG_INTERCONNECT is 'n', in which case all
> > interconnect API functions are no-op.
> 
> How about the case where CONFIG_INTERCONNECT=m. Looks like the build will fail
> if CONFIG_ARM_EXYNOS_BUS_DEVFREQ=y, so this dependency should be expressed in
> Kconfig.

I think adding:
	depends on INTERCONNECT || !INTERCONNECT

under ARM_EXYNOS_BUS_DEVFREQ does the trick.

> > 
> > Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
> > ---
> >  drivers/devfreq/exynos-bus.c | 144 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 144 insertions(+)
> > 
> > diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> > index 9fdb188915e8..694a9581dcdb 100644
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
> > +#define kbps_to_khz(x) ((x) / 8)
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
> > @@ -205,6 +216,39 @@ static void exynos_bus_passive_exit(struct device *dev)
> >  	clk_disable_unprepare(bus->clk);
> >  }
> >  
> > +static int exynos_bus_icc_set(struct icc_node *src, struct icc_node *dst)
> > +{
> > +	struct exynos_bus *src_bus = src->data, *dst_bus = dst->data;
> > +	s32 src_freq = kbps_to_khz(src->avg_bw);
> > +	s32 dst_freq = kbps_to_khz(dst->avg_bw);
> > +	int ret;
> > +
> > +	ret = dev_pm_qos_update_request(&src_bus->qos_req, src_freq);
> > +	if (ret < 0) {
> > +		dev_err(src_bus->dev, "failed to update PM QoS request");
> > +		return ret;
> > +	}
> > +
> > +	ret = dev_pm_qos_update_request(&dst_bus->qos_req, dst_freq);
> > +	if (ret < 0) {
> > +		dev_err(dst_bus->dev, "failed to update PM QoS request");
> > +		return ret;
> > +	}
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
> > @@ -419,6 +463,96 @@ static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
> >  	return 0;
> >  }
> >  
> > +static struct icc_node *exynos_bus_icc_get_parent(struct exynos_bus *bus)
> > +{
> > +	struct device_node *np = bus->dev->of_node;
> > +	struct of_phandle_args args;
> > +	int num, ret;
> > +
> > +	num = of_count_phandle_with_args(np, "exynos,interconnect-parent-node",
> > +					"#interconnect-cells");
> > +	if (num != 1)
> > +		return NULL; /* parent nodes are optional */
> > +
> > +	ret = of_parse_phandle_with_args(np, "exynos,interconnect-parent-node",
> > +					"#interconnect-cells", 0, &args);
> > +	if (ret < 0)
> > +		return ERR_PTR(ret);
> > +
> > +	of_node_put(args.np);
> > +
> > +	return of_icc_get_from_provider(&args);
> > +}
> > +
> > +static int exynos_bus_icc_init(struct exynos_bus *bus)
> > +{
> > +	static DEFINE_IDA(ida);
> > +
> > +	struct device *dev = bus->dev;
> > +	struct icc_provider *provider = &bus->provider;
> > +	struct icc_node *node, *parent_node;
> > +	int id, ret;
> > +
> > +	/* Initialize the interconnect provider */
> > +	provider->set = exynos_bus_icc_set;
> > +	provider->aggregate = icc_std_aggregate;
> > +	provider->xlate = exynos_bus_icc_xlate;
> > +	provider->dev = dev;
> > +	provider->inter_set = true;
> > +	provider->data = bus;
> > +
> > +	ret = icc_provider_add(provider);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = id = ida_alloc(&ida, GFP_KERNEL);
> > +	if (ret < 0)
> > +		goto err_id;
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
> > +	parent_node = exynos_bus_icc_get_parent(bus);
> > +	if (IS_ERR(parent_node)) {
> > +		ret = PTR_ERR(parent_node);
> > +		goto err_parent;
> > +	}
> > +
> > +	if (parent_node) {
> > +		ret = icc_link_create(node, parent_node->id);
> > +		if (ret < 0)
> > +			goto err_parent;
> > +	}
> > +
> > +	ret = dev_pm_qos_add_request(bus->devfreq->dev.parent, &bus->qos_req,
> > +					DEV_PM_QOS_MIN_FREQUENCY, 0);
> > +	if (ret < 0)
> > +		goto err_request;
> > +
> > +	return 0;
> > +
> > +err_request:
> > +	if (parent_node)
> > +		icc_link_destroy(node, parent_node);
> > +err_parent:
> > +	icc_node_del(node);
> > +	icc_node_destroy(id);
> > +err_node:
> > +	ida_free(&ida, id);
> > +err_id:
> > +	icc_provider_del(provider);
> > +
> > +	return ret;
> > +}
> > +
> >  static int exynos_bus_probe(struct platform_device *pdev)
> >  {
> >  	struct device *dev = &pdev->dev;
> > @@ -468,6 +602,16 @@ static int exynos_bus_probe(struct platform_device *pdev)
> >  	if (ret < 0)
> >  		goto err;
> >  
> > +	/*
> > +	 * Initialize interconnect provider. A return value of -ENOTSUPP means
> > +	 * that CONFIG_INTERCONNECT is disabled.
> > +	 */
> > +	ret = exynos_bus_icc_init(bus);
> > +	if (ret < 0 && ret != -ENOTSUPP) {
> > +		dev_err(dev, "failed to initialize the interconnect provider");
> > +		goto err;
> > +	}
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


