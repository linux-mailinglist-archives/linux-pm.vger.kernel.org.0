Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41C1C12443B
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 11:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfLRKSO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 05:18:14 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36619 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbfLRKSN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 05:18:13 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191218101811euoutp0290506b6f25ee51a7971fbaa93f3ab94e~hb9HSCY9Q0591005910euoutp02c
        for <linux-pm@vger.kernel.org>; Wed, 18 Dec 2019 10:18:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191218101811euoutp0290506b6f25ee51a7971fbaa93f3ab94e~hb9HSCY9Q0591005910euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576664291;
        bh=N0T5HYi3ubUwLNNp1DxL+xadTg/5+z1v5HM8GBeHkXo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=MsbNACOY8piqQahTp98SMpK8RzQPC7RZwM5tW9MX1TKy/pWH88/NJsmeEObEQHxfv
         4h9ttH7H9PvgSYMNDIDPPrFEHjEXjYBUMb1yTi/8a3+rISNsNeEGel1dNGxUlf+FZn
         ghM1hDLrk91+5jciEkece8M/LegMZdFRZuFD8u+4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191218101811eucas1p275a6236b2084bcd7314a437058eb6011~hb9G4ncIo2973429734eucas1p2a;
        Wed, 18 Dec 2019 10:18:11 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 15.15.60679.2ECF9FD5; Wed, 18
        Dec 2019 10:18:11 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191218101810eucas1p22bd9592b85550f9d9bb9ac75a9c6c74e~hb9GZuCtP2973429734eucas1p2Z;
        Wed, 18 Dec 2019 10:18:10 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191218101810eusmtrp132fcdf3d7335afbb962c2dcdcd1ef911~hb9GSW5Ht2314423144eusmtrp1s;
        Wed, 18 Dec 2019 10:18:10 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-f0-5df9fce2cd82
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 59.9B.08375.2ECF9FD5; Wed, 18
        Dec 2019 10:18:10 +0000 (GMT)
Received: from AMDC3555 (unknown [106.120.51.67]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20191218101809eusmtip2fe7dd1b2ce6fae47d2e6cf05af05c25f~hb9Fn_HBk1189211892eusmtip2l;
        Wed, 18 Dec 2019 10:18:09 +0000 (GMT)
Message-ID: <95ac6056bc6c790b1de7e975f44faa320fd9876f.camel@samsung.com>
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
Date:   Wed, 18 Dec 2019 11:18:09 +0100
In-Reply-To: <35053bad-3f08-190a-0ffa-9aacd16da272@samsung.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+3Yum6ut02bspSLZtKAob104VHYB/zhgQhIRhFKzTio5lR0v
        GUFLo6auaRlpU2ha5I2wLVu2tIstBa9loeEFJTVT1DLtsrBo25nYf7/3ed/nfd4PPhEm6yTW
        iBKSUlltkjpRRYpxW7Oza+vIgjMm2PAFoy3FtQTdOz9O0LcdnQT9/vsXki5qtJL09aECnO7q
        eiCkKwdnCdo60kPQ7+ylJD131YHo4q5nAvq+Y1BI91+sJOniwgly/0rGWp1DMgM9DSQzlNci
        YB7evcBYZuoFjLGuGjFz1vWHhMfEe06xiQnprDZo7wlxfPkdG56SH3G2rDUb6ZB5Vy7yEQG1
        HYa7c0g3y6hKBL8tR3KR2MXzCMaudON8MYdgOG9CsOgw9M56GxUILr24Q/DFJwRtI689uyQU
        A9e+GT0sp1govf8YczNJ7YOO/h8Ct8GXmkEw+vwr5i4wqhlB44ATd0/h1AZ4MfvQk+fjcnwc
        dHizt8B0q9E1I3IlrII/9XK3jFF+kP2oxLMHqGkh6HNMJD8fDn3m1zjPcphsqRPyvA7aCg1e
        nYOxJ0MEb9YhsN5zYHxjN7xqeUu4wzBqE9Tag3j5ALRn9XluAEoKH6ZX8TdI4bqtCONlCegv
        y3hUgf2WlDcCZNX0eHczUJddihcgpWnpLab/3mJaSjUjrBop2DROE8dyoUlsRiCn1nBpSXGB
        J5M1VuT6ZW1/W+brkX0htglRIqRaIQle5oyREep0LlPThECEqXwl/XqXJDmlzjzHapOPa9MS
        Wa4JrRXhKoVkW/lEjIyKU6eyZ1g2hdUudgUinzU6dCzANiVs17yMUUaJjz791VDCdPQpTuTO
        Tm3cHK4YDSnYIT8/LolwSqUDccbUS/WxyrANVn1sR4Tyq2pSV6Hdf3juQlTZrtU7BwIsP8vG
        b1qqbJ8P+t+dXO4XHV3VYQsb87dwkWpOO9FaY6j5ceN0bL45OP70G6uCS5BkRG5aHqrCuXh1
        yGZMy6n/AYY/HAdhAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsVy+t/xe7qP/vyMNdg/S8xi44z1rBbXvzxn
        tZh/5ByrxZWv79kspu/dxGYx6f4EFovz5zewW6y4+5HVYtPja6wWl3fNYbP43HuE0WLG+X1M
        FmuP3GW3uN24gs1ixuSXbA78HptWdbJ53Lm2h83jfvdxJo/NS+o9Nr7bweTRt2UVo8fnTXIB
        7FF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GYsW
        b2Mp6PeuWHiqmbGBcYFVFyMnh4SAiUTP9Y8sXYxcHEICSxkl1v7cxwaRkJD4uP4GK4QtLPHn
        WhcbRNETRomZN/vZQRK8Ah4SEz/1gTUIC6RKzFm7nRnEZhOwlzh7+xsTSIOIwHtGiQ/b37GD
        OMwCJxgldl57DtbBIqAqceDjZiYQmxOo49HdI0wQK74AFX1cALaCWUBTonX7b3aIO3Qk3p7q
        AzqWA2i1oMTfHcIQJfISzVtnM09gFJyFpGMWQtUsJFULGJlXMYqklhbnpucWG+oVJ+YWl+al
        6yXn525iBEbqtmM/N+9gvLQx+BCjAAejEg+vAcPPWCHWxLLiytxDjBIczEoivLc7gEK8KYmV
        ValF+fFFpTmpxYcYTYH+mcgsJZqcD0wieSXxhqaG5haWhubG5sZmFkrivB0CB2OEBNITS1Kz
        U1MLUotg+pg4OKUaGOXdH39i+h69vbdQhY930YKXT348mr+N96f0O50zGs8rXjdcnah/cdom
        rejfyaJFShcnNz9bLb7VpVzOyUeh3iHPuyZ09TfWCG+No7UHl3+5Y1k5Tcdx/XtNF+u1ZQ8X
        ecXOSReK6169VnbjgfZXzqu1PAvbxM5Vu91PVEi6JXB3jf3crMWnDZVYijMSDbWYi4oTASlJ
        +9DqAgAA
X-CMS-MailID: 20191218101810eucas1p22bd9592b85550f9d9bb9ac75a9c6c74e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190919142329eucas1p2e53992eab9ec6b404f716f955b3c228e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190919142329eucas1p2e53992eab9ec6b404f716f955b3c228e
References: <20190919142236.4071-1-a.swigon@samsung.com>
        <CGME20190919142329eucas1p2e53992eab9ec6b404f716f955b3c228e@eucas1p2.samsung.com>
        <20190919142236.4071-10-a.swigon@samsung.com>
        <35053bad-3f08-190a-0ffa-9aacd16da272@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Thank you for the review.

On Mon, 2019-12-16 at 09:44 +0900, Chanwoo Choi wrote:
> Hi,
> 
> On 9/19/19 11:22 PM, Artur Świgoń wrote:
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
> 
> icc_units_to_khz() -> kpbs_to_khz()

OK

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
> 
> Have to check the return value.
> If return error, show the waring with dev_warn.

OK, I will change it to:

ret = dev_pm_qos_update_request(&src_bus->qos_req, src_freq);
if (ret < 0) {
	dev_warn(src_bus->dev, "failed to update PM QoS request");
	return ret;
}

> > +	dev_pm_qos_update_request(&dst_bus->qos_req, dst_freq);
> 
> ditto.

OK (same as above).

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
> 
> 
> Actually, I agree your approach. I think that it is very useful
> and necessary to guarantee the PM QoS requirements between devices.
> 
> But,
> As I already commented, I'm not sure that the "parent" property 
> is proper for only this driver. If possible, you better to get
> the parent phandle through other way like OF graph.
> 
> If you suggest the standard way to make the tree between
> the exynos-bus, I'll agree.

As I commented in the answer to patch 08, I will use the
'exynos,interconnect-parent-node' property for bus_display,
bus_leftbus and bus_dmc.

> Also, for interconnect path, you have to add the connection
> between 'bus_display' and 'bus_leftbus' regardless
> of the existing 'devfreq' property.
> - bus_display - bus_leftbus - bus_dmc
> 
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
> 
> Return error without goto because there is no any requirement
> to free the resource before.

OK.

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
> 
> Check whether this line is over 80 char.

It looks like 77 columns to me.

> 
> > +				     DEV_PM_QOS_MIN_FREQUENCY, 0);
> 
> 	Check the return value.

OK.

> 
> > +
> > +out:
> 
> Remove this goto due to not necessary.
> 
> > +	return ret;
> 
> 	return 0;

OK.

Please also note that this function as well as exynos_bus_icc_connect()
will
slightly change in v3 due to the changes regarding DT properties.

> 
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
> 
> Print error message.
> 	dev_err(dev, "failed to initialize the interconnect provider");

OK.

> 
> > +
> >  	max_state = bus->devfreq->profile->max_state;
> >  	min_freq = (bus->devfreq->profile->freq_table[0] / 1000);
> >  	max_freq = (bus->devfreq->profile->freq_table[max_state - 1] / 1000);
> > 
> 
> 

Best regards,
-- 
Artur Świgoń
Samsung R&D Institute Poland
Samsung Electronics


