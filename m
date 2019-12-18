Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 393E4124503
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 11:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfLRKsg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 05:48:36 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50086 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfLRKsf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 05:48:35 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191218104832euoutp02c2a1c6d05320d2b1a5ab0775807e0c40~hcXnfHkHn2727827278euoutp02g
        for <linux-pm@vger.kernel.org>; Wed, 18 Dec 2019 10:48:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191218104832euoutp02c2a1c6d05320d2b1a5ab0775807e0c40~hcXnfHkHn2727827278euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576666112;
        bh=V23I87IP9W3FOEDeKEQDrstnF+dxDxFw8ePbIb+Djlk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=X82LBPWzdebiwERxx9mmKyjHfCldftL7mUKic3lLALhOKBBUxLhArpLeRhkHvagZ6
         yeajfmKfLrDKJKjAY+nrm8wHOEAnzlP7z0mtFEelItAKP9yLm+fOV22IozCvJngdzN
         NsPBmzfbl+wYK72fmcpzBNBR0JIXmPhaLO61pzZ0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191218104832eucas1p1b43e0be03190e68bb1a65d416ecea640~hcXnGqwoO3274832748eucas1p1Y;
        Wed, 18 Dec 2019 10:48:32 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 56.D9.60679.0040AFD5; Wed, 18
        Dec 2019 10:48:32 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191218104831eucas1p2fdf3fad04bf0604068e780a234f8cb38~hcXmqyPYX1525415254eucas1p2Q;
        Wed, 18 Dec 2019 10:48:31 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191218104831eusmtrp16e9db9ffda73d6f83066cd33e3bf4665~hcXmp845R1078710787eusmtrp1b;
        Wed, 18 Dec 2019 10:48:31 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-03-5dfa0400d452
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id CB.A1.07950.FF30AFD5; Wed, 18
        Dec 2019 10:48:31 +0000 (GMT)
Received: from AMDC3555 (unknown [106.120.51.67]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20191218104830eusmtip12a2a8a41bee3bfe0c56cec3c6bc2f016~hcXlt1aMS0087600876eusmtip1r;
        Wed, 18 Dec 2019 10:48:30 +0000 (GMT)
Message-ID: <c3c161af17023a90e0fd7a0f925dbdad8b928ff4.camel@samsung.com>
Subject: Re: [RFC PATCH v2 09/11] devfreq: exynos-bus: Add interconnect
 functionality to exynos-bus
From:   Artur =?UTF-8?Q?=C5=9Awigo=C5=84?= <a.swigon@samsung.com>
To:     Chanwoo Choi <chanwoo@kernel.org>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>, inki.dae@samsung.com,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        georgi.djakov@linaro.org,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 18 Dec 2019 11:48:30 +0100
In-Reply-To: <CAGTfZH1wVKBQAantrpqPP7+penwxeJud=gjH=5vVmKbzTGE=cQ@mail.gmail.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRju27nsbDQ5bpYvJpWLfhTlpdJOVJZRcCgCg/4USZ3ypJLXnbzk
        jzKtsHnXTFtaEaZLE3VNm0MjdSnkHS+ZGhKRkmlpXsiVkdtR7N/zPc/7PM/7wkdhym7ChQoJ
        v8prwrlQNSnHa5oXOnauwa0BnpbbKqYqv4JgsgZ6ceb97BjBPLZ0EEzv3A+Syas3kEz2SCbO
        dHZWShn9x2mCMXzuJ5gecwHJzKRZEJPf+VrClFs+Spmhm3qSyc/5Sh6mWUPpXZId7q8j2ZGU
        Fgn7sugGW/XdJGHTjaWInTFs9JeelR8I5ENDYniNh+8FefBEahMReT8grnKqjkxA5X5aJKOA
        3gONXVVSLZJTSlqP4Fv1PCE+ZhF0pmmXlRkE1hIzuWLJmJpGNqykSxB8MF0Xh0YR5NYX2ocU
        NAsJ8+MSG1bRPBSUv8JsmKQPQfvQvJ13ordC5c9mex1GZxGgr/lrT8WXhGnzJzuW0adgru+X
        VGzeAZPv0nEtopYKHGHRpLLRGL0JkqofYrYcoBekMJNilNhmgD4Ko+0y0aqC8RbjcowrtOak
        4iIW4EvtCCF6ExAYii2YKOyHppZuwpaD0dugwuwh0n7QljiIi/EOMDDpKK7gANk1eZhIKyD5
        jlKEajA/cBCNAIll/cvZLBiTCvBM5KZbPUX33ym61dYnCCtFzny0EBbEC7vC+Vh3gQsTosOD
        3C9FhBnQ0kdr/dsya0LmPxcbEU0h9VqF55qFACXBxQjXwhoRUJjaSTGUvEQpArlr8bwm4rwm
        OpQXGtEGClc7K3Y//RqgpIO4q/wVno/kNSuqhJK5JCBdoiY0F1QTLhPP4xu8Dlq7tMRIideN
        ihCfEO7RXFnUaPU5t6hhU/6JIznDPlihVXZscXiB5IZUsf5b1uteHL+V+sb0NrbPqbL2jKFo
        82/vxbh1rhti2ArBmePGjHH7LjcU97T5WovvtBt7pzLkz4pOd/d43PPeO9irP+mXlFqjxoVg
        zms7phG4f3zIkxhkAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsVy+t/xu7r/mX/FGiw5ZmCxccZ6VouJN66w
        WFz/8pzVYv6Rc6wWV76+Z7OYvncTm8Wk+xNYLM6f38BuseLuR1aLTY+vsVpc3jWHzeJz7xFG
        ixnn9zFZrD1yl93iduMKNosZk1+yOQh4bFrVyeZx59oeNo/73ceZPDYvqffY+G4Hk0ffllWM
        Hp83yQWwR+nZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunb
        JehlvOk5zFowLbZiw4c9bA2Max27GDk5JARMJPo/fGTsYuTiEBJYyiixZeVBNoiEhMTH9TdY
        IWxhiT/Xutggip4wSizfNp0RJMEr4CHR8O0VE4gtLJAqMWftdmYQm03AXuLs7W9gcREBVYkN
        n46xgjQzC0xklTi8/xHYBhagxMddD8EGcQoESny9+oMdxBYS+MMkMWmNIIjNLKAp0br9NzvE
        FToSb0/1sXQxcgAtFpT4u0MYokReonnrbOYJjIKzkHTMQqiahaRqASPzKkaR1NLi3PTcYiO9
        4sTc4tK8dL3k/NxNjMB43Xbs55YdjF3vgg8xCnAwKvHw3vj7I1aINbGsuDL3EKMEB7OSCO/t
        jp+xQrwpiZVVqUX58UWlOanFhxhNgd6ZyCwlmpwPTCV5JfGGpobmFpaG5sbmxmYWSuK8HQIH
        Y4QE0hNLUrNTUwtSi2D6mDg4pRoYN/7ut11/blPi3MP2nZZM6R1M5XacBxq05T9JSv6dX6O7
        a6601A+byGcdvVe8O1Ol7sk+VLqSELThTFvod7eMex1zluqvaGL3fbVf69S+j1kpyZ9PRyy/
        elTObpPktp2WM+bwn81q2nh62oQ/sxZEb/0kGnb+55+zARu3yyYv1Swqzy5PNT+VrcRSnJFo
        qMVcVJwIANH1SwDtAgAA
X-CMS-MailID: 20191218104831eucas1p2fdf3fad04bf0604068e780a234f8cb38
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
        <95ac6056bc6c790b1de7e975f44faa320fd9876f.camel@samsung.com>
        <CAGTfZH1wVKBQAantrpqPP7+penwxeJud=gjH=5vVmKbzTGE=cQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2019-12-18 at 19:39 +0900, Chanwoo Choi wrote:
> Hi,
> 
> 2019년 12월 18일 (수) 오후 7:19, Artur Świgoń <a.swigon@samsung.com>님이 작성:
> > 
> > Hi,
> > 
> > Thank you for the review.
> > 
> > On Mon, 2019-12-16 at 09:44 +0900, Chanwoo Choi wrote:
> > > Hi,
> > > 
> > > On 9/19/19 11:22 PM, Artur Świgoń wrote:
> > > > From: Artur Świgoń <a.swigon@partner.samsung.com>
> > > > 
> > > > This patch adds interconnect functionality to the exynos-bus devfreq
> > > > driver.
> > > > 
> > > > The SoC topology is a graph (or, more specifically, a tree) and most of
> > > > its edges are taken from the devfreq parent-child hierarchy (cf.
> > > > Documentation/devicetree/bindings/devfreq/exynos-bus.txt). Due to
> > > > unspecified relative probing order, -EPROBE_DEFER may be propagated to
> > > > guarantee that a child is probed before its parent.
> > > > 
> > > > Each bus is now an interconnect provider and an interconnect node as well
> > > > (cf. Documentation/interconnect/interconnect.rst), i.e. every bus registers
> > > > itself as a node. Node IDs are not hardcoded but rather assigned at
> > > > runtime, in probing order (subject to the above-mentioned exception
> > > > regarding relative order). This approach allows for using this driver with
> > > > various Exynos SoCs.
> > > > 
> > > > Frequencies requested via the interconnect API for a given node are
> > > > propagated to devfreq using dev_pm_qos_update_request(). Please note that
> > > > it is not an error when CONFIG_INTERCONNECT is 'n', in which case all
> > > > interconnect API functions are no-op.
> > > > 
> > > > Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
> > > > ---
> > > >  drivers/devfreq/exynos-bus.c | 153 +++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 153 insertions(+)
> > > > 
> > > > diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> > > > index 8d44810cac69..e0232202720d 100644
> > > > --- a/drivers/devfreq/exynos-bus.c
> > > > +++ b/drivers/devfreq/exynos-bus.c
> > > > @@ -14,14 +14,19 @@
> > > >  #include <linux/devfreq-event.h>
> > > >  #include <linux/device.h>
> > > >  #include <linux/export.h>
> > > > +#include <linux/idr.h>
> > > > +#include <linux/interconnect-provider.h>
> > > >  #include <linux/module.h>
> > > >  #include <linux/of.h>
> > > >  #include <linux/pm_opp.h>
> > > > +#include <linux/pm_qos.h>
> > > >  #include <linux/platform_device.h>
> > > >  #include <linux/regulator/consumer.h>
> > > > 
> > > >  #define DEFAULT_SATURATION_RATIO   40
> > > > 
> > > > +#define icc_units_to_khz(x) ((x) / 8)
> > > 
> > > icc_units_to_khz() -> kpbs_to_khz()
> > 
> > OK
> > 
> > > > +
> > > >  struct exynos_bus {
> > > >     struct device *dev;
> > > > 
> > > > @@ -35,6 +40,12 @@ struct exynos_bus {
> > > >     struct opp_table *opp_table;
> > > >     struct clk *clk;
> > > >     unsigned int ratio;
> > > > +
> > > > +   /* One provider per bus, one node per provider */
> > > > +   struct icc_provider provider;
> > > > +   struct icc_node *node;
> > > > +
> > > > +   struct dev_pm_qos_request qos_req;
> > > >  };
> > > > 
> > > >  /*
> > > > @@ -59,6 +70,13 @@ exynos_bus_ops_edev(enable_edev);
> > > >  exynos_bus_ops_edev(disable_edev);
> > > >  exynos_bus_ops_edev(set_event);
> > > > 
> > > > +static int exynos_bus_next_id(void)
> > > > +{
> > > > +   static DEFINE_IDA(exynos_bus_icc_ida);
> > > > +
> > > > +   return ida_alloc(&exynos_bus_icc_ida, GFP_KERNEL);
> > > > +}
> > > > +
> > > >  static int exynos_bus_get_event(struct exynos_bus *bus,
> > > >                             struct devfreq_event_data *edata)
> > > >  {
> > > > @@ -171,6 +189,38 @@ static void exynos_bus_passive_exit(struct device *dev)
> > > >     clk_disable_unprepare(bus->clk);
> > > >  }
> > > > 
> > > > +static int exynos_bus_icc_set(struct icc_node *src, struct icc_node *dst)
> > > > +{
> > > > +   struct exynos_bus *src_bus = src->data, *dst_bus = dst->data;
> > > > +   s32 src_freq = icc_units_to_khz(src->avg_bw);
> > > > +   s32 dst_freq = icc_units_to_khz(dst->avg_bw);
> > > > +
> > > > +   dev_pm_qos_update_request(&src_bus->qos_req, src_freq);
> > > 
> > > Have to check the return value.
> > > If return error, show the waring with dev_warn.
> > 
> > OK, I will change it to:
> > 
> > ret = dev_pm_qos_update_request(&src_bus->qos_req, src_freq);
> > if (ret < 0) {
> >         dev_warn(src_bus->dev, "failed to update PM QoS request");
> >         return ret;
> 
> If you return right after, better to use dev_err.
> If you use dev_warn, just show the warning message without return.

OK, I will use dev_err().

> > }
> > 
> > > > +   dev_pm_qos_update_request(&dst_bus->qos_req, dst_freq);
> > > 
> > > ditto.
> > 
> > OK (same as above).
> 
> ditto.
> 
> > 
> > > > +
> > > > +   return 0;
> > > > +}
> > > > +
> > > > +static int exynos_bus_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
> > > > +                               u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
> > > > +{
> > > > +   *agg_avg += avg_bw;
> > > > +   *agg_peak = max(*agg_peak, peak_bw);
> > > > +
> > > > +   return 0;
> > > > +}
> > > > +
> > > > +static struct icc_node *exynos_bus_icc_xlate(struct of_phandle_args *spec,
> > > > +                                        void *data)
> > > > +{
> > > > +   struct exynos_bus *bus = data;
> > > > +
> > > > +   if (spec->np != bus->dev->of_node)
> > > > +           return ERR_PTR(-EINVAL);
> > > > +
> > > > +   return bus->node;
> > > > +}
> > > > +
> > > >  static int exynos_bus_parent_parse_of(struct device_node *np,
> > > >                                     struct exynos_bus *bus)
> > > >  {
> > > > @@ -366,6 +416,101 @@ static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
> > > >     return 0;
> > > >  }
> > > > 
> > > > +static int exynos_bus_icc_connect(struct exynos_bus *bus)
> > > > +{
> > > > +   struct device_node *np = bus->dev->of_node;
> > > > +   struct devfreq *parent_devfreq;
> > > > +   struct icc_node *parent_node = NULL;
> > > > +   struct of_phandle_args args;
> > > > +   int ret = 0;
> > > > +
> > > > +   parent_devfreq = devfreq_get_devfreq_by_phandle(bus->dev, 0);
> > > > +   if (!IS_ERR(parent_devfreq)) {
> > > > +           struct exynos_bus *parent_bus;
> > > > +
> > > > +           parent_bus = dev_get_drvdata(parent_devfreq->dev.parent);
> > > > +           parent_node = parent_bus->node;
> > > > +   } else {
> > > > +           /* Look for parent in DT */
> > > > +           int num = of_count_phandle_with_args(np, "parent",
> > > > +                                                "#interconnect-cells");
> > > > +           if (num != 1)
> > > > +                   goto out; /* 'parent' is optional */
> > > > +
> > > > +           ret = of_parse_phandle_with_args(np, "parent",
> > > > +                                            "#interconnect-cells",
> > > > +                                            0, &args);
> > > 
> > > 
> > > Actually, I agree your approach. I think that it is very useful
> > > and necessary to guarantee the PM QoS requirements between devices.
> > > 
> > > But,
> > > As I already commented, I'm not sure that the "parent" property
> > > is proper for only this driver. If possible, you better to get
> > > the parent phandle through other way like OF graph.
> > > 
> > > If you suggest the standard way to make the tree between
> > > the exynos-bus, I'll agree.
> > 
> > As I commented in the answer to patch 08, I will use the
> > 'exynos,interconnect-parent-node' property for bus_display,
> > bus_leftbus and bus_dmc.
> 
> OK.
> 
> > 
> > > Also, for interconnect path, you have to add the connection
> > > between 'bus_display' and 'bus_leftbus' regardless
> > > of the existing 'devfreq' property.
> > > - bus_display - bus_leftbus - bus_dmc
> > > 
> > > > +           if (ret < 0)
> > > > +                   goto out;
> > > > +
> > > > +           of_node_put(args.np);
> > > > +
> > > > +           parent_node = of_icc_get_from_provider(&args);
> > > > +           if (IS_ERR(parent_node)) {
> > > > +                   /* May be -EPROBE_DEFER */
> > > > +                   ret = PTR_ERR(parent_node);
> > > > +                   goto out;
> > > > +           }
> > > > +   }
> > > > +
> > > > +   ret = icc_link_create(bus->node, parent_node->id);
> > > > +
> > > > +out:
> > > > +   return ret;
> > > > +}
> > > > +
> > > > +static int exynos_bus_icc_init(struct exynos_bus *bus)
> > > > +{
> > > > +   struct device *dev = bus->dev;
> > > > +   struct icc_provider *provider = &bus->provider;
> > > > +   struct icc_node *node;
> > > > +   int id, ret;
> > > > +
> > > > +   /* Initialize the interconnect provider */
> > > > +   provider->set = exynos_bus_icc_set;
> > > > +   provider->aggregate = exynos_bus_icc_aggregate;
> > > > +   provider->xlate = exynos_bus_icc_xlate;
> > > > +   provider->dev = dev;
> > > > +   provider->data = bus;
> > > > +
> > > > +   ret = icc_provider_add(provider);
> > > > +   if (ret < 0)
> > > > +           goto out;
> > > 
> > > Return error without goto because there is no any requirement
> > > to free the resource before.
> > 
> > OK.
> > 
> > > > +
> > > > +   ret = id = exynos_bus_next_id();
> > > > +   if (ret < 0)
> > > > +           goto err_node;
> > > > +
> > > > +   node = icc_node_create(id);
> > > > +   if (IS_ERR(node)) {
> > > > +           ret = PTR_ERR(node);
> > > > +           goto err_node;
> > > > +   }
> > > > +
> > > > +   bus->node = node;
> > > > +   node->name = dev->of_node->name;
> > > > +   node->data = bus;
> > > > +   icc_node_add(node, provider);
> > > > +
> > > > +   ret = exynos_bus_icc_connect(bus);
> > > > +   if (ret < 0)
> > > > +           goto err_connect;
> > > > +
> > > > +   ret = dev_pm_qos_add_request(bus->devfreq->dev.parent, &bus->qos_req,
> > > 
> > > Check whether this line is over 80 char.
> > 
> > It looks like 77 columns to me.
> > 
> > > 
> > > > +                                DEV_PM_QOS_MIN_FREQUENCY, 0);
> > > 
> > >       Check the return value.
> > 
> > OK.
> > 
> > > 
> > > > +
> > > > +out:
> > > 
> > > Remove this goto due to not necessary.
> > > 
> > > > +   return ret;
> > > 
> > >       return 0;
> > 
> > OK.
> > 
> > Please also note that this function as well as exynos_bus_icc_connect()
> > will
> > slightly change in v3 due to the changes regarding DT properties.
> > 
> > > 
> > > > +
> > > > +err_connect:
> > > > +   icc_node_del(node);
> > > > +   icc_node_destroy(id);
> > > > +err_node:
> > > > +   icc_provider_del(provider);
> > > > +
> > > > +   return ret;
> > > > +}
> > > > +
> > > >  static int exynos_bus_probe(struct platform_device *pdev)
> > > >  {
> > > >     struct device *dev = &pdev->dev;
> > > > @@ -415,6 +560,14 @@ static int exynos_bus_probe(struct platform_device *pdev)
> > > >     if (ret < 0)
> > > >             goto err;
> > > > 
> > > > +   /*
> > > > +    * Initialize interconnect provider. A return value of -ENOTSUPP means
> > > > +    * that CONFIG_INTERCONNECT is disabled.
> > > > +    */
> > > > +   ret = exynos_bus_icc_init(bus);
> > > > +   if (ret < 0 && ret != -ENOTSUPP)
> > > > +           goto err;
> > > 
> > > Print error message.
> > >       dev_err(dev, "failed to initialize the interconnect provider");
> > 
> > OK.
> > 
> > > 
> > > > +
> > > >     max_state = bus->devfreq->profile->max_state;
> > > >     min_freq = (bus->devfreq->profile->freq_table[0] / 1000);
> > > >     max_freq = (bus->devfreq->profile->freq_table[max_state - 1] / 1000);
> > > > 

-- 
Artur Świgoń
Samsung R&D Institute Poland
Samsung Electronics


