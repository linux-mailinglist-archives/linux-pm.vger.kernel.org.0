Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577122A47BF
	for <lists+linux-pm@lfdr.de>; Tue,  3 Nov 2020 15:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbgKCOPH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Nov 2020 09:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729343AbgKCONT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Nov 2020 09:13:19 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920E3C0613D1;
        Tue,  3 Nov 2020 06:13:18 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id m8so13147932ljj.0;
        Tue, 03 Nov 2020 06:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=f971NpGAxJTOMIWGzmZfoD6Qg23wMvOQqSw5+pPEYq8=;
        b=mC3EAqx4mz0BZUOT7ZHITszgY9OOxUk1yX30bvTDpDqmUOqTcDCSgoZGNSJk8iMQPi
         0hoDwvIoci519dc0p5yJNwKM0TdKAPCcHNd2hts+kQrjaVJGWNQm8rZqX5t/C96nwazS
         hIJuNeBXKkUcV/MbKLQ5lkgJi94lAeiWsW54dLtzu1OSa9LBoAER06zGIOMi32ENUOSK
         jKNl6nrZjjJIqfqEFLnCH5pMMnRUaTtRBlhrMZe+DlcwVz19KL+breYHFGkFmBmb175p
         Qr2TG3XrNhtrmi+QkxvKIx51XIPjns3cj5ql4+02LYt6LngUBQ+JicuBg2Var8efxmaD
         gpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=f971NpGAxJTOMIWGzmZfoD6Qg23wMvOQqSw5+pPEYq8=;
        b=dnrejXiIowx/imGkB9Fl8ij4/v0n85bSq45LithjlETihAPyNvtiwdc2hXNc8Kpzi2
         iDTSZ09qf09S1ImabIlvUiuQL/OnO9YMQJ0I3y43GX1xA8qYCO8uVtg/i8m/SG4OHvGk
         wlLWlGX8w1tAQtDXRFeOVlemAnsxSPjWbUkIN/VnNw9Nz4+IuSF7Wqsr/aaf+IF814e1
         ACBnjXJcLFc6iBrAiszoTkJdm5DXkluutL85YOD66reQ/cDkYNa1wj3V6LMFJCMhAnU2
         zB0RaOHu+PjRZrE3RVZNck4eIeht/ZpXz8w9yMQ4jKmVDXYpc6eNuPQP+5KFX6h5HVLO
         NnFw==
X-Gm-Message-State: AOAM5321WOF0jx4i+QwcjR9qjmnNbUJO2QtGKj75kPcYN5dyc3NZWgUa
        VoZFVISgH36LYW6fB5D/LCZYjhUyvbiDUtYphg8/T8dm/1+F/w==
X-Google-Smtp-Source: ABdhPJwsmSD/NJffq1/IuqpIedYKyTEdlHZMDluPm5T1JTIGXkjlVn9YQrQFFCMIVwFmhu/2kvElcVTFCpPbf0Fid+I=
X-Received: by 2002:a2e:8041:: with SMTP id p1mr4345835ljg.460.1604412796961;
 Tue, 03 Nov 2020 06:13:16 -0800 (PST)
MIME-Version: 1.0
References: <20201030125149.8227-1-s.nawrocki@samsung.com> <CGME20201030125301eucas1p218b0e654cb4c826b05280f28836da8d9@eucas1p2.samsung.com>
 <20201030125149.8227-3-s.nawrocki@samsung.com> <88af4e53-6c7a-c2e6-ad28-a9d6bb5bf623@samsung.com>
 <6cc9a2f8-9d9a-68b7-9f47-e16fefb18d88@samsung.com>
In-Reply-To: <6cc9a2f8-9d9a-68b7-9f47-e16fefb18d88@samsung.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Tue, 3 Nov 2020 23:12:40 +0900
Message-ID: <CAGTfZH3seoTUd68pq+RCSs9BfnmkUaeoipML=85aUPyvcWZ6fw@mail.gmail.com>
Subject: Re: [PATCH v7 2/6] interconnect: Add generic interconnect driver for
 Exynos SoCs
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sylwester,

On Tue, Nov 3, 2020 at 8:32 PM Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
>
> On 03.11.2020 10:37, Chanwoo Choi wrote:
> > On 10/30/20 9:51 PM, Sylwester Nawrocki wrote:
> >> This patch adds a generic interconnect driver for Exynos SoCs in order
> >> to provide interconnect functionality for each "samsung,exynos-bus"
> >> compatible device.
> >>
> >> The SoC topology is a graph (or more specifically, a tree) and its
> >> edges are specified using the 'samsung,interconnect-parent' in the
> >
> > samsung,interconnect-parent -> interconnects?
>
> Yes, I will rephrase the whole commit message as it's a bit outdated now.
>
> I've changed the sentence to:
> "The SoC topology is a graph (or more specifically, a tree) and its
> edges are described by specifying in the 'interconnects' property
> the interconnect consumer path for each interconnect provider DT node."
>
> >> DT. Due to unspecified relative probing order, -EPROBE_DEFER may be
> >> propagated to ensure that the parent is probed before its children.
> >>
> >> Each bus is now an interconnect provider and an interconnect node as
> >> well (cf. Documentation/interconnect/interconnect.rst), i.e. every bus
> >> registers itself as a node. Node IDs are not hardcoded but rather
> >> assigned dynamically at runtime. This approach allows for using this
> >> driver with various Exynos SoCs.
> >>
> >> Frequencies requested via the interconnect API for a given node are
> >> propagated to devfreq using dev_pm_qos_update_request(). Please note
> >> that it is not an error when CONFIG_INTERCONNECT is 'n', in which
> >> case all interconnect API functions are no-op.
> >>
> >> The bus-width DT property is to determine the interconnect data
> >> width and traslate requested bandwidth to clock frequency for each
> >> bus.
> >>
> >> Signed-off-by: Artur =C5=9Awigo=C5=84 <a.swigon@samsung.com>
> >> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>
> >> +++ b/drivers/interconnect/exynos/exynos.c
>
> >> +struct exynos_icc_priv {
> >> +    struct device *dev;
> >> +
> >> +    /* One interconnect node per provider */
> >> +    struct icc_provider provider;
> >> +    struct icc_node *node;
> >> +
> >> +    struct dev_pm_qos_request qos_req;
> >> +    u32 bus_clk_ratio;
> >> +};
> >> +
> >> +static struct icc_node *exynos_icc_get_parent(struct device_node *np)
> >> +{
> >> +    struct of_phandle_args args;
> >> +    struct icc_node_data *icc_node_data;
> >> +    struct icc_node *icc_node;
> >> +    int num, ret;
> >> +
> >> +    num =3D of_count_phandle_with_args(np, "interconnects",
> >> +                                     "#interconnect-cells");
> >> +    if (num < 1)
> >> +            return NULL; /* parent nodes are optional */
> >> +
> >> +    /* Get the interconnect target node */
> >> +    ret =3D of_parse_phandle_with_args(np, "interconnects",
> >> +                                    "#interconnect-cells", 0, &args);
> >> +    if (ret < 0)
> >> +            return ERR_PTR(ret);
> >> +
> >> +    icc_node_data =3D of_icc_get_from_provider(&args);
> >> +    of_node_put(args.np);
> >> +
> >> +    if (IS_ERR(icc_node_data))
> >> +            return ERR_CAST(icc_node_data);
> >> +
> >> +    icc_node =3D icc_node_data->node;
> >> +    kfree(icc_node_data);
> >> +
> >> +    return icc_node;
> >> +}
> >
> > I have a question about exynos_icc_get_parent().
> > As I checked, this function returns the only one icc_node
> > as parent node. But, bus_display dt node in the exynos4412.dtsi
> > specifies the two interconnect node as following with bus_leftbus, bus_=
dmc,
> >
> > When I checked the return value of exynos_icc_get_parent()
> > during probing for bus_display device, exynos_icc_get_parent() function
> > only returns 'bus_leftbus' icc_node. Do you need to add two phandle
> > of icc node?
>
> Yes, as we use the interconnect consumer bindings we need to specify a pa=
th,
> i.e. a <initiator, target> pair. When the provider node initializes it wi=
ll
> link itself to that path. Currently the provider driver uses just the fir=
st
> phandle.

As I knew, the interconnect consumer bindings use the two phandles
in the interconnect core as you commented. But, in case of this,
even if add two phandles with interconnect consumding binding style,
the exynos interconnect driver only uses the first phandle.

Instead, I think we better explain this case into a dt-binding
document for users.

> > +++ b/arch/arm/boot/dts/exynos4412.dtsi
> > @@ -472,7 +472,7 @@
> >                         clocks =3D <&clock CLK_ACLK160>;
> >                         clock-names =3D "bus";
> >                         operating-points-v2 =3D <&bus_display_opp_table=
>;
> >                         interconnects =3D <&bus_leftbus &bus_dmc>;
> >                         #interconnect-cells =3D <0>;
> >                         status =3D "disabled";
> >                 };
>
> --
> Regards,
> Sylwester
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



--=20
Best Regards,
Chanwoo Choi
