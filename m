Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA42709E35
	for <lists+linux-pm@lfdr.de>; Fri, 19 May 2023 19:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjESRdM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 May 2023 13:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjESRdH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 May 2023 13:33:07 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8A6D9
        for <linux-pm@vger.kernel.org>; Fri, 19 May 2023 10:32:34 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-6238200c584so15206866d6.3
        for <linux-pm@vger.kernel.org>; Fri, 19 May 2023 10:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684517552; x=1687109552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=olbEzSqx/IH1TMQ25mCAKgCIHwNjsr/5MQNXRJjOzZ4=;
        b=HrhpqN9gM/psWbxK3a76k6HsKCFyBjqJxbyuapYDmo/EhBTaMd/R6PDTqTyUTh9omd
         uzZkCT77EDuWcm1xgTwQRC34nF51f7icAh5WGj49BA3WIl+TnIQ1TV2EoNKHQ+Ow9wWu
         Pgl64mkeiBXqC7wbWrpGLGMI/Dp5AtqGWax/ctp3dXWNjOfjbbBOEcCtuj/J4iHNGTZC
         nrdgkBMeI7fZnCmXru7uHYoZUqPYUDLeMVEk9JuaHgYkGTU75VyMVuI8mSD1bINFLkVy
         cuuhwCEUIeysioN6m9TwfVyoJuOZbFShQmGbjV2LeGrc9zGmir15u2aOkEKb7y7pIEeR
         1wyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684517552; x=1687109552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=olbEzSqx/IH1TMQ25mCAKgCIHwNjsr/5MQNXRJjOzZ4=;
        b=iJimb0rFQCYhiC0c+Qd4pJk9rpF8cNAtk+4Gp211T5mypTgtsUbOj1CpnD8Uh+E9X8
         XuPHWpr4THiUfcuApLHwQHIGsovtrTZSKTJInLvZkInnElQNq1EtHMwMxXVSwBDN5kCF
         E27oi0IegwwVDCHfFkp1xYasd/LzP9tZECX+cs/ObRT9Ccf5tm7w6vxkDSfPUREbJfTi
         cKFQQ565e2Tz/YesV0tc0juPgKL7DzC7ID11fDqAOUkhCdltNGRcv//qjGCLMfyv794f
         diVtnqhJafqt3sA+7LtXuyVSNvbQLa0OZeRSDYYq3SW59UqeDcNuK6lZdJA8bJtBbiTR
         1qSg==
X-Gm-Message-State: AC+VfDw0nzQyCy/2gVcJHV+sRY34UUniTeznKlIUK+hNIRUct5vdLhDQ
        yEWOWHDx1h8C/2SJNe6nI1SuaMX3ajSaFVJKEZh1Og==
X-Google-Smtp-Source: ACHHUZ4Xl4kXNMwDTrQ8PsgJ7TyY9mUD5MkfEEWL4wSSJpPIPKsNjazEBZaVlU4VQpr5zXcyFWGP9tQ7MQO51qyZO4g=
X-Received: by 2002:a05:6214:20e2:b0:622:7b7f:ed3a with SMTP id
 2-20020a05621420e200b006227b7fed3amr4624386qvk.16.1684517551596; Fri, 19 May
 2023 10:32:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230512001334.2983048-1-dmitry.baryshkov@linaro.org>
 <20230512001334.2983048-3-dmitry.baryshkov@linaro.org> <ZGeyO6MRBSPf7b1y@google.com>
In-Reply-To: <ZGeyO6MRBSPf7b1y@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 19 May 2023 10:32:20 -0700
Message-ID: <CAKwvOdn-w2QPmq9_CmpHFurWyo9DiAiMEf0wus6ufW5g+8LKGQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] interconnect: add clk-based icc provider support
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-pm@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 19, 2023 at 10:30=E2=80=AFAM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, May 12, 2023 at 03:13:32AM +0300, Dmitry Baryshkov wrote:
> > For some devices it is useful to export clocks as interconnect provider=
s,
> > if the clock corresponds to bus bandwidth.
> >
> > For example, on MSM8996 the cluster interconnect clock should be scaled
> > according to the cluster frequencies. Exporting it as an interconnect
> > allows one to properly describe this as the cluster bandwidth
> > requirements.
> >
> > Tested-by: Yassine Oudjana <y.oudjana@protonmail.com>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>
> Hi Dmitry,
> Apologies if this has already been reported elsewhere, but our CI is red
> for linux-next today for allmodconfig builds:
>
> >> ERROR: modpost: missing MODULE_LICENSE() in drivers/interconnect/icc-c=
lk.o

I also suspect these 2 additional errors are related to this series?
>> Error: ERROR: modpost: "icc_clk_register" [drivers/clk/qcom/clk-cbf-8996=
.ko] undefined!
>> Error: ERROR: modpost: "icc_clk_unregister" [drivers/clk/qcom/clk-cbf-89=
96.ko] undefined!

>
> https://github.com/ClangBuiltLinux/continuous-integration2/actions/runs/5=
024096989/jobs/9011763868
>
> Can you PTAL?
>
> > ---
> >  drivers/interconnect/Kconfig     |   6 ++
> >  drivers/interconnect/Makefile    |   2 +
> >  drivers/interconnect/icc-clk.c   | 168 +++++++++++++++++++++++++++++++
> >  include/linux/interconnect-clk.h |  22 ++++
> >  4 files changed, 198 insertions(+)
> >  create mode 100644 drivers/interconnect/icc-clk.c
> >  create mode 100644 include/linux/interconnect-clk.h
> >
> > diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfi=
g
> > index d637a89d4695..5faa8d2aecff 100644
> > --- a/drivers/interconnect/Kconfig
> > +++ b/drivers/interconnect/Kconfig
> > @@ -15,4 +15,10 @@ source "drivers/interconnect/imx/Kconfig"
> >  source "drivers/interconnect/qcom/Kconfig"
> >  source "drivers/interconnect/samsung/Kconfig"
> >
> > +config INTERCONNECT_CLK
> > +     tristate
> > +     depends on COMMON_CLK
> > +     help
> > +       Support for wrapping clocks into the interconnect nodes.
> > +
> >  endif
> > diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makef=
ile
> > index 97d393fd638d..5604ce351a9f 100644
> > --- a/drivers/interconnect/Makefile
> > +++ b/drivers/interconnect/Makefile
> > @@ -7,3 +7,5 @@ obj-$(CONFIG_INTERCONNECT)            +=3D icc-core.o
> >  obj-$(CONFIG_INTERCONNECT_IMX)               +=3D imx/
> >  obj-$(CONFIG_INTERCONNECT_QCOM)              +=3D qcom/
> >  obj-$(CONFIG_INTERCONNECT_SAMSUNG)   +=3D samsung/
> > +
> > +obj-$(CONFIG_INTERCONNECT_CLK)               +=3D icc-clk.o
> > diff --git a/drivers/interconnect/icc-clk.c b/drivers/interconnect/icc-=
clk.c
> > new file mode 100644
> > index 000000000000..0db3b654548b
> > --- /dev/null
> > +++ b/drivers/interconnect/icc-clk.c
> > @@ -0,0 +1,168 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (c) 2023, Linaro Ltd.
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/device.h>
> > +#include <linux/interconnect-clk.h>
> > +#include <linux/interconnect-provider.h>
> > +
> > +struct icc_clk_node {
> > +     struct clk *clk;
> > +     bool enabled;
> > +};
> > +
> > +struct icc_clk_provider {
> > +     struct icc_provider provider;
> > +     int num_clocks;
> > +     struct icc_clk_node clocks[];
> > +};
> > +
> > +#define to_icc_clk_provider(_provider) \
> > +     container_of(_provider, struct icc_clk_provider, provider)
> > +
> > +static int icc_clk_set(struct icc_node *src, struct icc_node *dst)
> > +{
> > +     struct icc_clk_node *qn =3D src->data;
> > +     int ret;
> > +
> > +     if (!qn || !qn->clk)
> > +             return 0;
> > +
> > +     if (!src->peak_bw) {
> > +             if (qn->enabled)
> > +                     clk_disable_unprepare(qn->clk);
> > +             qn->enabled =3D false;
> > +
> > +             return 0;
> > +     }
> > +
> > +     if (!qn->enabled) {
> > +             ret =3D clk_prepare_enable(qn->clk);
> > +             if (ret)
> > +                     return ret;
> > +             qn->enabled =3D true;
> > +     }
> > +
> > +     return clk_set_rate(qn->clk, icc_units_to_bps(src->peak_bw));
> > +}
> > +
> > +static int icc_clk_get_bw(struct icc_node *node, u32 *avg, u32 *peak)
> > +{
> > +     struct icc_clk_node *qn =3D node->data;
> > +
> > +     if (!qn || !qn->clk)
> > +             *peak =3D INT_MAX;
> > +     else
> > +             *peak =3D Bps_to_icc(clk_get_rate(qn->clk));
> > +
> > +     return 0;
> > +}
> > +
> > +/**
> > + * icc_clk_register() - register a new clk-based interconnect provider
> > + * @dev: device supporting this provider
> > + * @first_id: an ID of the first provider's node
> > + * @num_clocks: number of instances of struct icc_clk_data
> > + * @data: data for the provider
> > + *
> > + * Registers and returns a clk-based interconnect provider. It is a si=
mple
> > + * wrapper around COMMON_CLK framework, allowing other devices to vote=
 on the
> > + * clock rate.
> > + *
> > + * Return: 0 on success, or an error code otherwise
> > + */
> > +struct icc_provider *icc_clk_register(struct device *dev,
> > +                                   unsigned int first_id,
> > +                                   unsigned int num_clocks,
> > +                                   const struct icc_clk_data *data)
> > +{
> > +     struct icc_clk_provider *qp;
> > +     struct icc_provider *provider;
> > +     struct icc_onecell_data *onecell;
> > +     struct icc_node *node;
> > +     int ret, i, j;
> > +
> > +     onecell =3D devm_kzalloc(dev, struct_size(onecell, nodes, 2 * num=
_clocks), GFP_KERNEL);
> > +     if (!onecell)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     qp =3D devm_kzalloc(dev, struct_size(qp, clocks, num_clocks), GFP=
_KERNEL);
> > +     if (!qp)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     qp->num_clocks =3D num_clocks;
> > +
> > +     provider =3D &qp->provider;
> > +     provider->dev =3D dev;
> > +     provider->get_bw =3D icc_clk_get_bw;
> > +     provider->set =3D icc_clk_set;
> > +     provider->aggregate =3D icc_std_aggregate;
> > +     provider->xlate =3D of_icc_xlate_onecell;
> > +     INIT_LIST_HEAD(&provider->nodes);
> > +     provider->data =3D onecell;
> > +
> > +     icc_provider_init(provider);
> > +
> > +     for (i =3D 0, j =3D 0; i < num_clocks; i++) {
> > +             qp->clocks[i].clk =3D data[i].clk;
> > +
> > +             node =3D icc_node_create(first_id + j);
> > +             if (IS_ERR(node)) {
> > +                     ret =3D PTR_ERR(node);
> > +                     goto err;
> > +             }
> > +
> > +             node->name =3D devm_kasprintf(dev, GFP_KERNEL, "%s_master=
", data[i].name);
> > +             node->data =3D &qp->clocks[i];
> > +             icc_node_add(node, provider);
> > +             /* link to the next node, slave */
> > +             icc_link_create(node, first_id + j + 1);
> > +             onecell->nodes[j++] =3D node;
> > +
> > +             node =3D icc_node_create(first_id + j);
> > +             if (IS_ERR(node)) {
> > +                     ret =3D PTR_ERR(node);
> > +                     goto err;
> > +             }
> > +
> > +             node->name =3D devm_kasprintf(dev, GFP_KERNEL, "%s_slave"=
, data[i].name);
> > +             /* no data for slave node */
> > +             icc_node_add(node, provider);
> > +             onecell->nodes[j++] =3D node;
> > +     }
> > +
> > +     onecell->num_nodes =3D j;
> > +
> > +     ret =3D icc_provider_register(provider);
> > +     if (ret)
> > +             goto err;
> > +
> > +     return provider;
> > +
> > +err:
> > +     icc_nodes_remove(provider);
> > +
> > +     return ERR_PTR(ret);
> > +}
> > +
> > +/**
> > + * icc_clk_unregister() - unregister a previously registered clk inter=
connect provider
> > + * @provider: provider returned by icc_clk_register()
> > + */
> > +void icc_clk_unregister(struct icc_provider *provider)
> > +{
> > +     struct icc_clk_provider *qp =3D container_of(provider, struct icc=
_clk_provider, provider);
> > +     int i;
> > +
> > +     icc_provider_deregister(&qp->provider);
> > +     icc_nodes_remove(&qp->provider);
> > +
> > +     for (i =3D 0; i < qp->num_clocks; i++) {
> > +             struct icc_clk_node *qn =3D &qp->clocks[i];
> > +
> > +             if (qn->enabled)
> > +                     clk_disable_unprepare(qn->clk);
> > +     }
> > +}
> > diff --git a/include/linux/interconnect-clk.h b/include/linux/interconn=
ect-clk.h
> > new file mode 100644
> > index 000000000000..0cd80112bea5
> > --- /dev/null
> > +++ b/include/linux/interconnect-clk.h
> > @@ -0,0 +1,22 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (c) 2023, Linaro Ltd.
> > + */
> > +
> > +#ifndef __LINUX_INTERCONNECT_CLK_H
> > +#define __LINUX_INTERCONNECT_CLK_H
> > +
> > +struct device;
> > +
> > +struct icc_clk_data {
> > +     struct clk *clk;
> > +     const char *name;
> > +};
> > +
> > +struct icc_provider *icc_clk_register(struct device *dev,
> > +                                   unsigned int first_id,
> > +                                   unsigned int num_clocks,
> > +                                   const struct icc_clk_data *data);
> > +void icc_clk_unregister(struct icc_provider *provider);
> > +
> > +#endif
> > --
> > 2.39.2
> >



--=20
Thanks,
~Nick Desaulniers
