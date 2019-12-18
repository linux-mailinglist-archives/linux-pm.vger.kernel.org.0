Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97AAA12455B
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 12:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfLRLIu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 06:08:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:49926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbfLRLIt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 18 Dec 2019 06:08:49 -0500
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC99821D7D;
        Wed, 18 Dec 2019 11:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576667328;
        bh=tUaeqcN6CkS43pagf5qs7h+ZistztqDqO0wjuHQPfEA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lrImmIoFd+NrnZ9DpifGyXM3GIbpnVAIKNC9vRU6KiPqFVthAzltRKmAJsvo414SP
         cBL2TiGnNpr9Wkasn5LXyDGweB2zVBfTvv1CxMTkIj3rdo4ijmOuUCrS1DIXXyG+ge
         BThU+akJfCGPMGwHz4RBaNs0V1NNo6KBjkeYyH9g=
Received: by mail-lj1-f175.google.com with SMTP id z17so1632180ljk.13;
        Wed, 18 Dec 2019 03:08:47 -0800 (PST)
X-Gm-Message-State: APjAAAXnEikjIOWIoqdbSDK2YUwqR9+ltm9DavhvXaCx8P4TTHiq9D3d
        e6YihBbuvk+UYQPnQgjMjFNoQNpOSS3QQoCpSxk=
X-Google-Smtp-Source: APXvYqzzwkok4ysLB1UQSv2NrLCMMmJMEEkUWjEi1zn1zHAKMRYnIIpHYHZgMKhx1IkyluFOt6OFdYUDfYSvwOE37r8=
X-Received: by 2002:a05:651c:106f:: with SMTP id y15mr1330269ljm.63.1576667326015;
 Wed, 18 Dec 2019 03:08:46 -0800 (PST)
MIME-Version: 1.0
References: <20190919142236.4071-1-a.swigon@samsung.com> <CGME20190919142329eucas1p2e53992eab9ec6b404f716f955b3c228e@eucas1p2.samsung.com>
 <20190919142236.4071-10-a.swigon@samsung.com> <35053bad-3f08-190a-0ffa-9aacd16da272@samsung.com>
 <95ac6056bc6c790b1de7e975f44faa320fd9876f.camel@samsung.com>
 <CAGTfZH1wVKBQAantrpqPP7+penwxeJud=gjH=5vVmKbzTGE=cQ@mail.gmail.com> <c3c161af17023a90e0fd7a0f925dbdad8b928ff4.camel@samsung.com>
In-Reply-To: <c3c161af17023a90e0fd7a0f925dbdad8b928ff4.camel@samsung.com>
From:   Chanwoo Choi <chanwoo@kernel.org>
Date:   Wed, 18 Dec 2019 20:08:09 +0900
X-Gmail-Original-Message-ID: <CAGTfZH1SbN2FkQ9SuaT3zONhvmdRGz0MVD3oqHjyuYDXsfkjfg@mail.gmail.com>
Message-ID: <CAGTfZH1SbN2FkQ9SuaT3zONhvmdRGz0MVD3oqHjyuYDXsfkjfg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 09/11] devfreq: exynos-bus: Add interconnect
 functionality to exynos-bus
To:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>, inki.dae@samsung.com,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

If possible, I'd like to apply these patches to v5.6-rc1.
It is very useful feature to support the QoS for user device using memory b=
us.

2019=EB=85=84 12=EC=9B=94 18=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 7:48, =
Artur =C5=9Awigo=C5=84 <a.swigon@samsung.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=
=EC=84=B1:
>
> On Wed, 2019-12-18 at 19:39 +0900, Chanwoo Choi wrote:
> > Hi,
> >
> > 2019=EB=85=84 12=EC=9B=94 18=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 7:=
19, Artur =C5=9Awigo=C5=84 <a.swigon@samsung.com>=EB=8B=98=EC=9D=B4 =EC=9E=
=91=EC=84=B1:
> > >
> > > Hi,
> > >
> > > Thank you for the review.
> > >
> > > On Mon, 2019-12-16 at 09:44 +0900, Chanwoo Choi wrote:
> > > > Hi,
> > > >
> > > > On 9/19/19 11:22 PM, Artur =C5=9Awigo=C5=84 wrote:
> > > > > From: Artur =C5=9Awigo=C5=84 <a.swigon@partner.samsung.com>
> > > > >
> > > > > This patch adds interconnect functionality to the exynos-bus devf=
req
> > > > > driver.
> > > > >
> > > > > The SoC topology is a graph (or, more specifically, a tree) and m=
ost of
> > > > > its edges are taken from the devfreq parent-child hierarchy (cf.
> > > > > Documentation/devicetree/bindings/devfreq/exynos-bus.txt). Due to
> > > > > unspecified relative probing order, -EPROBE_DEFER may be propagat=
ed to
> > > > > guarantee that a child is probed before its parent.
> > > > >
> > > > > Each bus is now an interconnect provider and an interconnect node=
 as well
> > > > > (cf. Documentation/interconnect/interconnect.rst), i.e. every bus=
 registers
> > > > > itself as a node. Node IDs are not hardcoded but rather assigned =
at
> > > > > runtime, in probing order (subject to the above-mentioned excepti=
on
> > > > > regarding relative order). This approach allows for using this dr=
iver with
> > > > > various Exynos SoCs.
> > > > >
> > > > > Frequencies requested via the interconnect API for a given node a=
re
> > > > > propagated to devfreq using dev_pm_qos_update_request(). Please n=
ote that
> > > > > it is not an error when CONFIG_INTERCONNECT is 'n', in which case=
 all
> > > > > interconnect API functions are no-op.
> > > > >
> > > > > Signed-off-by: Artur =C5=9Awigo=C5=84 <a.swigon@partner.samsung.c=
om>
> > > > > ---
> > > > >  drivers/devfreq/exynos-bus.c | 153 +++++++++++++++++++++++++++++=
++++++
> > > > >  1 file changed, 153 insertions(+)
> > > > >
> > > > > diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exyno=
s-bus.c
> > > > > index 8d44810cac69..e0232202720d 100644
> > > > > --- a/drivers/devfreq/exynos-bus.c
> > > > > +++ b/drivers/devfreq/exynos-bus.c
> > > > > @@ -14,14 +14,19 @@
> > > > >  #include <linux/devfreq-event.h>
> > > > >  #include <linux/device.h>
> > > > >  #include <linux/export.h>
> > > > > +#include <linux/idr.h>
> > > > > +#include <linux/interconnect-provider.h>
> > > > >  #include <linux/module.h>
> > > > >  #include <linux/of.h>
> > > > >  #include <linux/pm_opp.h>
> > > > > +#include <linux/pm_qos.h>
> > > > >  #include <linux/platform_device.h>
> > > > >  #include <linux/regulator/consumer.h>
> > > > >
> > > > >  #define DEFAULT_SATURATION_RATIO   40
> > > > >
> > > > > +#define icc_units_to_khz(x) ((x) / 8)
> > > >
> > > > icc_units_to_khz() -> kpbs_to_khz()
> > >
> > > OK
> > >
> > > > > +
> > > > >  struct exynos_bus {
> > > > >     struct device *dev;
> > > > >
> > > > > @@ -35,6 +40,12 @@ struct exynos_bus {
> > > > >     struct opp_table *opp_table;
> > > > >     struct clk *clk;
> > > > >     unsigned int ratio;
> > > > > +
> > > > > +   /* One provider per bus, one node per provider */
> > > > > +   struct icc_provider provider;
> > > > > +   struct icc_node *node;
> > > > > +
> > > > > +   struct dev_pm_qos_request qos_req;
> > > > >  };
> > > > >
> > > > >  /*
> > > > > @@ -59,6 +70,13 @@ exynos_bus_ops_edev(enable_edev);
> > > > >  exynos_bus_ops_edev(disable_edev);
> > > > >  exynos_bus_ops_edev(set_event);
> > > > >
> > > > > +static int exynos_bus_next_id(void)
> > > > > +{
> > > > > +   static DEFINE_IDA(exynos_bus_icc_ida);
> > > > > +
> > > > > +   return ida_alloc(&exynos_bus_icc_ida, GFP_KERNEL);
> > > > > +}
> > > > > +
> > > > >  static int exynos_bus_get_event(struct exynos_bus *bus,
> > > > >                             struct devfreq_event_data *edata)
> > > > >  {
> > > > > @@ -171,6 +189,38 @@ static void exynos_bus_passive_exit(struct d=
evice *dev)
> > > > >     clk_disable_unprepare(bus->clk);
> > > > >  }
> > > > >
> > > > > +static int exynos_bus_icc_set(struct icc_node *src, struct icc_n=
ode *dst)
> > > > > +{
> > > > > +   struct exynos_bus *src_bus =3D src->data, *dst_bus =3D dst->d=
ata;
> > > > > +   s32 src_freq =3D icc_units_to_khz(src->avg_bw);
> > > > > +   s32 dst_freq =3D icc_units_to_khz(dst->avg_bw);
> > > > > +
> > > > > +   dev_pm_qos_update_request(&src_bus->qos_req, src_freq);
> > > >
> > > > Have to check the return value.
> > > > If return error, show the waring with dev_warn.
> > >
> > > OK, I will change it to:
> > >
> > > ret =3D dev_pm_qos_update_request(&src_bus->qos_req, src_freq);
> > > if (ret < 0) {
> > >         dev_warn(src_bus->dev, "failed to update PM QoS request");
> > >         return ret;
> >
> > If you return right after, better to use dev_err.
> > If you use dev_warn, just show the warning message without return.
>
> OK, I will use dev_err().
>
> > > }
> > >
> > > > > +   dev_pm_qos_update_request(&dst_bus->qos_req, dst_freq);
> > > >
> > > > ditto.
> > >
> > > OK (same as above).
> >
> > ditto.
> >
> > >
> > > > > +
> > > > > +   return 0;
> > > > > +}
> > > > > +
> > > > > +static int exynos_bus_icc_aggregate(struct icc_node *node, u32 t=
ag, u32 avg_bw,
> > > > > +                               u32 peak_bw, u32 *agg_avg, u32 *a=
gg_peak)
> > > > > +{
> > > > > +   *agg_avg +=3D avg_bw;
> > > > > +   *agg_peak =3D max(*agg_peak, peak_bw);
> > > > > +
> > > > > +   return 0;
> > > > > +}
> > > > > +
> > > > > +static struct icc_node *exynos_bus_icc_xlate(struct of_phandle_a=
rgs *spec,
> > > > > +                                        void *data)
> > > > > +{
> > > > > +   struct exynos_bus *bus =3D data;
> > > > > +
> > > > > +   if (spec->np !=3D bus->dev->of_node)
> > > > > +           return ERR_PTR(-EINVAL);
> > > > > +
> > > > > +   return bus->node;
> > > > > +}
> > > > > +
> > > > >  static int exynos_bus_parent_parse_of(struct device_node *np,
> > > > >                                     struct exynos_bus *bus)
> > > > >  {
> > > > > @@ -366,6 +416,101 @@ static int exynos_bus_profile_init_passive(=
struct exynos_bus *bus,
> > > > >     return 0;
> > > > >  }
> > > > >
> > > > > +static int exynos_bus_icc_connect(struct exynos_bus *bus)
> > > > > +{
> > > > > +   struct device_node *np =3D bus->dev->of_node;
> > > > > +   struct devfreq *parent_devfreq;
> > > > > +   struct icc_node *parent_node =3D NULL;
> > > > > +   struct of_phandle_args args;
> > > > > +   int ret =3D 0;
> > > > > +
> > > > > +   parent_devfreq =3D devfreq_get_devfreq_by_phandle(bus->dev, 0=
);
> > > > > +   if (!IS_ERR(parent_devfreq)) {
> > > > > +           struct exynos_bus *parent_bus;
> > > > > +
> > > > > +           parent_bus =3D dev_get_drvdata(parent_devfreq->dev.pa=
rent);
> > > > > +           parent_node =3D parent_bus->node;
> > > > > +   } else {
> > > > > +           /* Look for parent in DT */
> > > > > +           int num =3D of_count_phandle_with_args(np, "parent",
> > > > > +                                                "#interconnect-c=
ells");
> > > > > +           if (num !=3D 1)
> > > > > +                   goto out; /* 'parent' is optional */
> > > > > +
> > > > > +           ret =3D of_parse_phandle_with_args(np, "parent",
> > > > > +                                            "#interconnect-cells=
",
> > > > > +                                            0, &args);
> > > >
> > > >
> > > > Actually, I agree your approach. I think that it is very useful
> > > > and necessary to guarantee the PM QoS requirements between devices.
> > > >
> > > > But,
> > > > As I already commented, I'm not sure that the "parent" property
> > > > is proper for only this driver. If possible, you better to get
> > > > the parent phandle through other way like OF graph.
> > > >
> > > > If you suggest the standard way to make the tree between
> > > > the exynos-bus, I'll agree.
> > >
> > > As I commented in the answer to patch 08, I will use the
> > > 'exynos,interconnect-parent-node' property for bus_display,
> > > bus_leftbus and bus_dmc.
> >
> > OK.
> >
> > >
> > > > Also, for interconnect path, you have to add the connection
> > > > between 'bus_display' and 'bus_leftbus' regardless
> > > > of the existing 'devfreq' property.
> > > > - bus_display - bus_leftbus - bus_dmc
> > > >
> > > > > +           if (ret < 0)
> > > > > +                   goto out;
> > > > > +
> > > > > +           of_node_put(args.np);
> > > > > +
> > > > > +           parent_node =3D of_icc_get_from_provider(&args);
> > > > > +           if (IS_ERR(parent_node)) {
> > > > > +                   /* May be -EPROBE_DEFER */
> > > > > +                   ret =3D PTR_ERR(parent_node);
> > > > > +                   goto out;
> > > > > +           }
> > > > > +   }
> > > > > +
> > > > > +   ret =3D icc_link_create(bus->node, parent_node->id);
> > > > > +
> > > > > +out:
> > > > > +   return ret;
> > > > > +}
> > > > > +
> > > > > +static int exynos_bus_icc_init(struct exynos_bus *bus)
> > > > > +{
> > > > > +   struct device *dev =3D bus->dev;
> > > > > +   struct icc_provider *provider =3D &bus->provider;
> > > > > +   struct icc_node *node;
> > > > > +   int id, ret;
> > > > > +
> > > > > +   /* Initialize the interconnect provider */
> > > > > +   provider->set =3D exynos_bus_icc_set;
> > > > > +   provider->aggregate =3D exynos_bus_icc_aggregate;
> > > > > +   provider->xlate =3D exynos_bus_icc_xlate;
> > > > > +   provider->dev =3D dev;
> > > > > +   provider->data =3D bus;
> > > > > +
> > > > > +   ret =3D icc_provider_add(provider);
> > > > > +   if (ret < 0)
> > > > > +           goto out;
> > > >
> > > > Return error without goto because there is no any requirement
> > > > to free the resource before.
> > >
> > > OK.
> > >
> > > > > +
> > > > > +   ret =3D id =3D exynos_bus_next_id();
> > > > > +   if (ret < 0)
> > > > > +           goto err_node;
> > > > > +
> > > > > +   node =3D icc_node_create(id);
> > > > > +   if (IS_ERR(node)) {
> > > > > +           ret =3D PTR_ERR(node);
> > > > > +           goto err_node;
> > > > > +   }
> > > > > +
> > > > > +   bus->node =3D node;
> > > > > +   node->name =3D dev->of_node->name;
> > > > > +   node->data =3D bus;
> > > > > +   icc_node_add(node, provider);
> > > > > +
> > > > > +   ret =3D exynos_bus_icc_connect(bus);
> > > > > +   if (ret < 0)
> > > > > +           goto err_connect;
> > > > > +
> > > > > +   ret =3D dev_pm_qos_add_request(bus->devfreq->dev.parent, &bus=
->qos_req,
> > > >
> > > > Check whether this line is over 80 char.
> > >
> > > It looks like 77 columns to me.
> > >
> > > >
> > > > > +                                DEV_PM_QOS_MIN_FREQUENCY, 0);
> > > >
> > > >       Check the return value.
> > >
> > > OK.
> > >
> > > >
> > > > > +
> > > > > +out:
> > > >
> > > > Remove this goto due to not necessary.
> > > >
> > > > > +   return ret;
> > > >
> > > >       return 0;
> > >
> > > OK.
> > >
> > > Please also note that this function as well as exynos_bus_icc_connect=
()
> > > will
> > > slightly change in v3 due to the changes regarding DT properties.
> > >
> > > >
> > > > > +
> > > > > +err_connect:
> > > > > +   icc_node_del(node);
> > > > > +   icc_node_destroy(id);
> > > > > +err_node:
> > > > > +   icc_provider_del(provider);
> > > > > +
> > > > > +   return ret;
> > > > > +}
> > > > > +
> > > > >  static int exynos_bus_probe(struct platform_device *pdev)
> > > > >  {
> > > > >     struct device *dev =3D &pdev->dev;
> > > > > @@ -415,6 +560,14 @@ static int exynos_bus_probe(struct platform_=
device *pdev)
> > > > >     if (ret < 0)
> > > > >             goto err;
> > > > >
> > > > > +   /*
> > > > > +    * Initialize interconnect provider. A return value of -ENOTS=
UPP means
> > > > > +    * that CONFIG_INTERCONNECT is disabled.
> > > > > +    */
> > > > > +   ret =3D exynos_bus_icc_init(bus);
> > > > > +   if (ret < 0 && ret !=3D -ENOTSUPP)
> > > > > +           goto err;
> > > >
> > > > Print error message.
> > > >       dev_err(dev, "failed to initialize the interconnect provider"=
);
> > >
> > > OK.
> > >
> > > >
> > > > > +
> > > > >     max_state =3D bus->devfreq->profile->max_state;
> > > > >     min_freq =3D (bus->devfreq->profile->freq_table[0] / 1000);
> > > > >     max_freq =3D (bus->devfreq->profile->freq_table[max_state - 1=
] / 1000);
> > > > >
>
> --
> Artur =C5=9Awigo=C5=84
> Samsung R&D Institute Poland
> Samsung Electronics
>
>


--=20
Best Regards,
Chanwoo Choi
