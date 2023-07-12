Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADC8750EF2
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jul 2023 18:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbjGLQtN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Jul 2023 12:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjGLQtM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jul 2023 12:49:12 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005951BEF
        for <linux-pm@vger.kernel.org>; Wed, 12 Jul 2023 09:49:10 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6b71cdb47e1so6292473a34.2
        for <linux-pm@vger.kernel.org>; Wed, 12 Jul 2023 09:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689180550; x=1689785350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XIMtFIcFcFMC7yVVktduIclo5Hb2frGelq0Ttevbqw=;
        b=bbpMGD2mH/4sebZtFUaA1YI4AFZoXqyyGftCEOmPJQM5rSVShXO4RMve0X/cBdu88O
         ioSCwYZTYtZ/ZpYg6SMHoPFe2osO8lxFxWeBfZrx2YfE0lLf2MnCOwQnKXNxQSSRmb+W
         r1/7kcHGWSI1Dzll8UD8OvALDnJToSQCAJ03G28M/6s9qEf3sEpFbQ1hBO7m0Gc4FoCD
         5Wv77z9w5zzcC+RpfFXZTqQUkwRW1H/m0gu0/A27zw1GMg6RMO6npniu6Ni1/l9w2zwc
         a3WfF8yqebA4EufJlc+0tbH1gEkOQ8c949nV0L1CkJKFyfdfKiA1fR/pLjqx/C6Dpcqi
         SNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689180550; x=1689785350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2XIMtFIcFcFMC7yVVktduIclo5Hb2frGelq0Ttevbqw=;
        b=TD3AyozBAcQkvw2VtbkKAtvMP71uuZgreacGD3inEscF+jNZ9ILwwgrh4PW4SpKewm
         3EJvC+QStjdYpOCnzAXarwL3W7jI03otuA26hZF6jFR5SKjBxJo5fz9AXo4ulICtPlJt
         +3CNWm2NHBteRahdRcKm1+RgEf5HROnpIAP7dodvtdY0gqD2iMIz4EdCpfjq0P24mBs9
         NrQE7yr7FyzO45fOSrDbSmBbYlbZTMnvn3Gv0bLAkb47xHtH008lbiBPRIiEdT6oKrmn
         3BZxyIqceIHf+Ta6C1cS7IIQumszkQ1Iq9jJX80p9g3XubnuVU1b+uZJuEH8kZse0hFE
         X40A==
X-Gm-Message-State: ABy/qLYUPXQKEPisAnKiOlRQPrJy4D5Qr7pUcfZMYhRo+Ev3/hWdCOcm
        5l+KBdZzprXrppImaLxxq5J9mbqvomf4vjCT1pYL0w==
X-Google-Smtp-Source: APBJJlHRTRqvrEzKg8dyAYFefk7UU7UfK2KPwNB2P9NKMXcXF+8pQklpCd/FvcYYjO9f658CZnACG30agYz9dh+CtFg=
X-Received: by 2002:a05:6830:1056:b0:6b9:9de6:b9 with SMTP id
 b22-20020a056830105600b006b99de600b9mr1916498otp.38.1689180550256; Wed, 12
 Jul 2023 09:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230712103213.101770-1-manivannan.sadhasivam@linaro.org>
 <20230712103213.101770-14-manivannan.sadhasivam@linaro.org>
 <e6a5129a-db07-977d-2ecd-328a52cbcdc0@linaro.org> <20230712163406.GG102757@thinkpad>
In-Reply-To: <20230712163406.GG102757@thinkpad>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 12 Jul 2023 19:48:55 +0300
Message-ID: <CAA8EJpovHr1qxepVprk6UvnhKe+nu4VuziyKKgjV3UzommFz6g@mail.gmail.com>
Subject: Re: [PATCH 11/14] scsi: ufs: host: Add support for parsing OPP
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 12 Jul 2023 at 19:34, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Wed, Jul 12, 2023 at 04:15:12PM +0300, Dmitry Baryshkov wrote:
> > On 12/07/2023 13:32, Manivannan Sadhasivam wrote:
> > > OPP framework can be used to scale the clocks along with other entiti=
es
> > > such as regulators, performance state etc... So let's add support for
> > > parsing OPP from devicetree. OPP support in devicetree is added throu=
gh
> > > the "operating-points-v2" property which accepts the OPP table defini=
ng
> > > clock frequency, regulator voltage, power domain performance state et=
c...
> > >
> > > Since the UFS controller requires multiple clocks to be controlled fo=
r
> > > proper working, devm_pm_opp_set_config() has been used which supports
> > > scaling multiple clocks through custom ufshcd_opp_config_clks() callb=
ack.
> > >
> > > It should be noted that the OPP support is not compatible with the ol=
d
> > > "freq-table-hz" property. So only one can be used at a time even thou=
gh
> > > the UFS core supports both.
> > >
> > > Co-developed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.or=
g>
> > > ---
> > >   drivers/ufs/host/ufshcd-pltfrm.c | 116 ++++++++++++++++++++++++++++=
+++
> > >   1 file changed, 116 insertions(+)
> > >
> > > diff --git a/drivers/ufs/host/ufshcd-pltfrm.c b/drivers/ufs/host/ufsh=
cd-pltfrm.c
> > > index 0b7430033047..068c22378c88 100644
> > > --- a/drivers/ufs/host/ufshcd-pltfrm.c
> > > +++ b/drivers/ufs/host/ufshcd-pltfrm.c
> > > @@ -8,8 +8,10 @@
> > >    *        Vinayak Holikatti <h.vinayak@samsung.com>
> > >    */
> > > +#include <linux/clk.h>
> > >   #include <linux/module.h>
> > >   #include <linux/platform_device.h>
> > > +#include <linux/pm_opp.h>
> > >   #include <linux/pm_runtime.h>
> > >   #include <linux/of.h>
> > > @@ -17,6 +19,8 @@
> > >   #include "ufshcd-pltfrm.h"
> > >   #include <ufs/unipro.h>
> > > +#include <trace/events/ufs.h>
> > > +
> > >   #define UFSHCD_DEFAULT_LANES_PER_DIRECTION                2
> > >   static int ufshcd_parse_clock_info(struct ufs_hba *hba)
> > > @@ -205,6 +209,112 @@ static void ufshcd_init_lanes_per_dir(struct uf=
s_hba *hba)
> > >     }
> > >   }
> > > +static int ufshcd_opp_config_clks(struct device *dev, struct opp_tab=
le *opp_table,
> > > +                             struct dev_pm_opp *opp, void *data,
> > > +                             bool scaling_down)
> > > +{
> > > +   struct ufs_hba *hba =3D dev_get_drvdata(dev);
> > > +   struct list_head *head =3D &hba->clk_list_head;
> > > +   struct ufs_clk_info *clki;
> > > +   unsigned long freq;
> > > +   u8 idx =3D 0;
> > > +   int ret;
> > > +
> > > +   list_for_each_entry(clki, head, list) {
> > > +           if (!IS_ERR_OR_NULL(clki->clk)) {
> > > +                   freq =3D dev_pm_opp_get_freq_indexed(opp, idx++);
> > > +
> > > +                   /* Do not set rate for clocks having frequency as=
 0 */
> > > +                   if (!freq)
> > > +                           continue;
> >
> > Can we omit these clocks from the opp table? I don't think they serve a=
ny
> > purpose.
> >
>
> No, we cannot. OPP requires the clocks and opp-hz to be of same length. A=
nd we
> cannot omit those clocks as well since linux needs to gate control them.

Hmm, I thought we push the list of "interesting" clocks through
config->clock_names.

>
> > Maybe it would even make sense to move this function to drivers/opp the=
n, as
> > it will be generic enough.
> >
>
> There is already a generic function available in OPP core. But we cannot =
use it
> as we need to skip setting 0 freq and that's not applicable in OPP core a=
s
> discussed with Viresh offline.

Ack.

>
> - Mani
>
> > > +
> > > +                   ret =3D clk_set_rate(clki->clk, freq);
> > > +                   if (ret) {
> > > +                           dev_err(dev, "%s: %s clk set rate(%ldHz) =
failed, %d\n",
> > > +                                   __func__, clki->name, freq, ret);
> > > +                           return ret;
> > > +                   }
> > > +
> > > +                   trace_ufshcd_clk_scaling(dev_name(dev),
> > > +                           (scaling_down ? "scaled down" : "scaled u=
p"),
> > > +                           clki->name, hba->clk_scaling.target_freq,=
 freq);
> > > +           }
> > > +   }
> > > +
> > > +   return 0;
> > > +} > +
> > > +static int ufshcd_parse_operating_points(struct ufs_hba *hba)
> > > +{
> > > +   struct device *dev =3D hba->dev;
> > > +   struct device_node *np =3D dev->of_node;
> > > +   struct dev_pm_opp_config config =3D {};
> > > +   struct ufs_clk_info *clki;
> > > +   const char **clk_names;
> > > +   int cnt, i, ret;
> > > +
> > > +   if (!of_find_property(np, "operating-points-v2", NULL))
> > > +           return 0;
> > > +
> > > +   if (of_find_property(np, "freq-table-hz", NULL)) {
> > > +           dev_err(dev, "%s: operating-points and freq-table-hz are =
incompatible\n",
> > > +                    __func__);
> > > +           return -EINVAL;
> > > +   }
> > > +
> > > +   cnt =3D of_property_count_strings(np, "clock-names");
> > > +   if (cnt <=3D 0) {
> > > +           dev_err(dev, "%s: Missing clock-names\n",  __func__);
> > > +           return -ENODEV;
> > > +   }
> > > +
> > > +   /* OPP expects clk_names to be NULL terminated */
> > > +   clk_names =3D devm_kcalloc(dev, cnt + 1, sizeof(*clk_names), GFP_=
KERNEL);
> > > +   if (!clk_names)
> > > +           return -ENOMEM;
> > > +
> > > +   /*
> > > +    * We still need to get reference to all clocks as the UFS core u=
ses
> > > +    * them separately.
> > > +    */
> > > +   for (i =3D 0; i < cnt; i++) {
> > > +           ret =3D of_property_read_string_index(np, "clock-names", =
i,
> > > +                                               &clk_names[i]);
> > > +           if (ret)
> > > +                   return ret;
> > > +
> > > +           clki =3D devm_kzalloc(dev, sizeof(*clki), GFP_KERNEL);
> > > +           if (!clki)
> > > +                   return -ENOMEM;
> > > +
> > > +           clki->name =3D devm_kstrdup(dev, clk_names[i], GFP_KERNEL=
);
> > > +           if (!clki->name)
> > > +                   return -ENOMEM;
> > > +
> > > +           if (!strcmp(clk_names[i], "ref_clk"))
> > > +                   clki->keep_link_active =3D true;
> > > +
> > > +           list_add_tail(&clki->list, &hba->clk_list_head);
> > > +   }
> > > +
> > > +   config.clk_names =3D clk_names,
> > > +   config.config_clks =3D ufshcd_opp_config_clks;
> > > +
> > > +   ret =3D devm_pm_opp_set_config(dev, &config);
> > > +   if (ret)
> > > +           return ret;
> > > +
> > > +   ret =3D devm_pm_opp_of_add_table(dev);
> > > +   if (ret) {
> > > +           dev_err(dev, "Failed to add OPP table: %d\n", ret);
> > > +           return ret;
> > > +   }
> > > +
> > > +   hba->use_pm_opp =3D true;
> > > +
> > > +   return 0;
> > > +}
> > > +
> > >   /**
> > >    * ufshcd_get_pwr_dev_param - get finally agreed attributes for
> > >    *                            power mode change
> > > @@ -371,6 +481,12 @@ int ufshcd_pltfrm_init(struct platform_device *p=
dev,
> > >     ufshcd_init_lanes_per_dir(hba);
> > > +   err =3D ufshcd_parse_operating_points(hba);
> > > +   if (err) {
> > > +           dev_err(dev, "%s: OPP parse failed %d\n", __func__, err);
> > > +           goto dealloc_host;
> > > +   }
> > > +
> > >     err =3D ufshcd_init(hba, mmio_base, irq);
> > >     if (err) {
> > >             dev_err(dev, "Initialization failed\n");
> >
> > --
> > With best wishes
> > Dmitry
> >
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D



--=20
With best wishes
Dmitry
