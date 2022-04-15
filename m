Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD25502555
	for <lists+linux-pm@lfdr.de>; Fri, 15 Apr 2022 08:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344779AbiDOGNy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Apr 2022 02:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240302AbiDOGNx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Apr 2022 02:13:53 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D7E9D0CA
        for <linux-pm@vger.kernel.org>; Thu, 14 Apr 2022 23:11:25 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id n134so2527797iod.5
        for <linux-pm@vger.kernel.org>; Thu, 14 Apr 2022 23:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hth57rc9flgI5m/YWiERoaDPCoaY7k8I1BMtgGL+V+Y=;
        b=msTzY8eSFKW/3mFmZ9lVowCymgcEumQdHKnLmPoK2AIQM5U2BaaSAmtjO2PKaxVJlz
         2ES6raB6JnSfMCwORjUEBdMJCP/IKWm7oEkIpJi7Ccsa63N57Xk5Z7E4OYu8Sgfv605W
         X2EpJ5uI7jXptNEMkbCMggrukuselAizifurv9hRWvp20KQQjqGEI/tiObfvLIU2zRvm
         Yz6zO6HUX37CkAlBqIEJvy8HvscIiG16enT7d45uHZVgVelRnaPR8dEjuElmtFPTrwqb
         BHHk0qAUzLAqSiDOfu0DgaJBrsy0J2AbneaUcCebHcM0ughM68guTlvQCenAdyULrrCn
         hI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hth57rc9flgI5m/YWiERoaDPCoaY7k8I1BMtgGL+V+Y=;
        b=dIUHx441t8Q/fn7qW3m9rQMAe2st8kHNDpMQbQh5Q1Tny12btn5pctI0+w0zt0YyFM
         2VCvUByncEtxv11PiAwtEP00ZdRZUe/g7u9oFj0XsiwjBJ5n8yNW5eDwW7dw/UMjHx9m
         W3mUaUOvDAflt9FSWrtuACAe/EdR19SRJmDyXKdM6uBjKzZw4XMix/QEjU5G7KwcAXLs
         UQtLCfhyMaA/wZ5QQO65szis/gIG+o2Zxhg93LU6oBHNDLzthPj8TavhMM+KuymGkRTE
         lOiUmOz1Jm2WnSWZfCA4jbBu7I6caxzu/XMWOu3KWWgpj1qoR4l4TWqP/zIO+N+BEPBx
         PHhw==
X-Gm-Message-State: AOAM53316hX0oeXrSL575O6Heh249NDl/jIaD6FqIl5NHu7x6f2+Y7NV
        zgxmPcuYwmORIN/B1Jyer9W+xdgLGVh+VaSFrMcRBQ==
X-Google-Smtp-Source: ABdhPJyZ09w41DsSsnD+yZXGRzZeRuMf7sXpcaFWmdYFro5NPh1kmpFg/dv3eWJHhL0eqh7mxqj1hftj0f6IdG4RkOs=
X-Received: by 2002:a05:6638:2509:b0:328:5838:f080 with SMTP id
 v9-20020a056638250900b003285838f080mr281369jat.163.1650003084905; Thu, 14 Apr
 2022 23:11:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220415055916.28350-1-rex-bc.chen@mediatek.com>
 <20220415055916.28350-15-rex-bc.chen@mediatek.com> <CACb=7PXmA_n-xAb+ZkRJdTXu=Enbf6NbyxVa3VC1zmJwsrgQ1w@mail.gmail.com>
In-Reply-To: <CACb=7PXmA_n-xAb+ZkRJdTXu=Enbf6NbyxVa3VC1zmJwsrgQ1w@mail.gmail.com>
From:   Hsin-Yi Wang <hsinyi@google.com>
Date:   Fri, 15 Apr 2022 14:10:58 +0800
Message-ID: <CACb=7PX_qNOk+XhxZUj_OrCnn1Fqw_4P-3Dc4pQLBTYQkY4qfw@mail.gmail.com>
Subject: Re: [PATCH V3 14/15] arm64: dts: mediatek: Add MediaTek CCI node for MT8183
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     rafael@kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, krzk+dt@kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tim Chang <jia-wei.chang@mediatek.com>, roger.lu@mediatek.com,
        Kevin Hilman <khilman@baylibre.com>,
        angelogioacchino.delregno@collabora.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        "Andrew-sh . Cheng" <andrew-sh.cheng@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Apr 15, 2022 at 2:06 PM Hsin-Yi Wang <hsinyi@google.com> wrote:
>
> On Fri, Apr 15, 2022 at 1:59 PM Rex-BC Chen <rex-bc.chen@mediatek.com> wrote:
> >
> > Add MediaTek CCI devfreq node for MT8183.
> >
> > Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> > ---
> >  arch/arm64/boot/dts/mediatek/mt8183-evb.dts    | 4 ++++
> >  arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 4 ++++
> >  arch/arm64/boot/dts/mediatek/mt8183.dtsi       | 7 +++++++
> >  3 files changed, 15 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> > index 8953dbf84f3e..7ac9864db9de 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> > @@ -412,6 +412,10 @@
> >
> >  };
> >
> > +&cci {
> > +       proc-supply = <&mt6358_vproc12_reg>;
> > +};
> > +
> >  &cpu0 {
> >         proc-supply = <&mt6358_vproc12_reg>;
> >  };
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> > index 0f9480f91261..4786a32ee975 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> > @@ -230,6 +230,10 @@
> >         status = "okay";
> >  };
> >
> > +&cci {
> > +       proc-supply = <&mt6358_vproc12_reg>;
> > +};
> > +
> >  &cpu0 {
> >         proc-supply = <&mt6358_vproc12_reg>;
> >  };
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > index 4ae3305d16d2..334728413582 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > @@ -280,6 +280,13 @@
> >                 };
> >         };
> >
> > +       cci: cci {
> > +               compatible = "mediatek,mt8183-cci";
> > +               clocks = <&apmixedsys CLK_APMIXED_CCIPLL>;
> > +               clock-names = "cci_clock";
> > +               operating-points-v2 = <&cci_opp>;
>
> hi Rex,
>
> cci_opp is not defined in dts.
>
It's in the previous patch. Please ignore this comment.

> > +       };
> > +
> >         cpus {
> >                 #address-cells = <1>;
> >                 #size-cells = <0>;
> > --
> > 2.18.0
> >
