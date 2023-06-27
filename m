Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE80D73FD7B
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jun 2023 16:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjF0OMa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Jun 2023 10:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjF0OMM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jun 2023 10:12:12 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41FF2D70
        for <linux-pm@vger.kernel.org>; Tue, 27 Jun 2023 07:11:47 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-bd0a359ca35so3122653276.3
        for <linux-pm@vger.kernel.org>; Tue, 27 Jun 2023 07:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687875106; x=1690467106;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WXrJhVf+jnZIfJ+cq7/++Rt0kUOtjIR654ZWVYK8IXA=;
        b=muMy6ccIPvOVieHq3jydY3E+pk7Ux7eU+8fTqZc64cbKAXPQn9G7P9CLs49Km6ZNLH
         +og5pE5dYoTSo4Nv0G9IuKJxLxYT/3kR4daUo9KSmpcrqnCZEpirJpdO4bhhDz4viIeW
         a6kr2p8yLGcr0LFje5IlBM9yAMKXINXjr7d7oJSW0RhWpDH/i1wAz39HiojB0lh54hqM
         uHL0HHBzjWTYe36pue47SQ7vwC/ejhmkYHexaE/mv9RDPVPfX9EgSFWDPArb1eCM/71O
         NQXSsv28l7DJwmFDtp1RLWlnXdeIAbU66JY4JQdEp6MqgMz+lplOX7EUq0EXcUzAln0e
         L1LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687875106; x=1690467106;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WXrJhVf+jnZIfJ+cq7/++Rt0kUOtjIR654ZWVYK8IXA=;
        b=GvKo1H9gkrT4jZI12v2pzyb3SyjfbbFzvAPKuqoi5ZUN998SMoHCSJqQAz38HIvQ1M
         0Ry+wJ57Xta3439siqgazyuQRErfwdrUDi6YAj3lR0DeOgCtRMaywPQMvz5jSHoTesPp
         yFZ4b0q+GC0GodssGesBnEQmL83AAcT1v24wayv74/kEfmh7ggDgsx22wAnVrIntrybM
         lNzo0eiCgIUSnpJeKzy/3rFOvbzvO+9wif+j2uqsEAgOH9xFhgvxdUEoH+MUGcMaITFx
         HC3nDTFJzTH80vUxLCbA1aCTzH54naygIx2xmoCdeJzI5PILmiMhlM4jCD7/Cs34VzSk
         FY8Q==
X-Gm-Message-State: AC+VfDwTLs0vMA0aA4mBsbJd8aQgaOpjRDVf6ptmVGfVbuz1ZN07RHJP
        C+8aKUj8UBgKxYiSigYYcxoHCS8iSrKfZXmjlscmDg==
X-Google-Smtp-Source: ACHHUZ70lgoIJLXZa0oFwfw4edZsuXErq+66PpsBrsvx2dF/b15nid3DcEG0tPlISlTBDYPEdt1KKo8KpAHjIj4O1Dw=
X-Received: by 2002:a25:3d81:0:b0:c1c:9285:64c2 with SMTP id
 k123-20020a253d81000000b00c1c928564c2mr4483834yba.50.1687875106693; Tue, 27
 Jun 2023 07:11:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230625202547.174647-1-dmitry.baryshkov@linaro.org>
 <20230625202547.174647-18-dmitry.baryshkov@linaro.org> <0f139da8-ae01-fc28-d14c-0ea207cf760e@linaro.org>
 <2232c6e7-cbca-30c1-9ec5-1cea7f759daf@linaro.org> <8217b8db-cd27-185d-c6b5-e32009202c21@linaro.org>
In-Reply-To: <8217b8db-cd27-185d-c6b5-e32009202c21@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 27 Jun 2023 17:11:35 +0300
Message-ID: <CAA8EJpq8J4fQoqrt3Jdf3C_mGUQdqaNbybdPD-zhEYxmB7DTcg@mail.gmail.com>
Subject: Re: [PATCH v2 17/26] ARM: dts: qcom: apq8064: add simple CPUFreq support
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 27 Jun 2023 at 15:13, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> On 26.06.2023 21:49, Dmitry Baryshkov wrote:
> > On 26/06/2023 19:40, Konrad Dybcio wrote:
> >> On 25.06.2023 22:25, Dmitry Baryshkov wrote:
> >>> Declare CPU frequency-scaling properties. Each CPU has its own clock,
> >>> how
> >> however?
> >
> > yes
> >
> >>
> >>> all CPUs have the same OPP table. Voltage scaling is not (yet)
> >>> enabled with this patch. It will be enabled later.
> >> Risky business.
> >
> > But it works :D
> On your machine ;)

On two nexus-7 and one ifc6410.

>
> [...]
>
> >>>   +    kraitcc: clock-controller {
> >>> +        compatible = "qcom,krait-cc-v1";
> >> Are we sure we don't wanna rework this compatible? Check the comment in
> >> drivers/clk/qcom/krait-cc.c : krait_add_sec_mux()
> >
> > I remember that comment. I'd rather not introduce another compat string for such old hw. Would there be any direct benefits?
> >
> I'd say that the one we have here never made much sense.. Perhaps (since
> nobody used it for 10 years) it would make sense to remodel it..

Well we have the bindings for this driver. And also it was used by the
OpenWRT people, IIRC.
Thus I don't feel comfortable with throwing out old compat strings.

>
> Konrad
> >>
> >>
> >>> +        clocks = <&gcc PLL9>, /* hfpll0 */
> >>> +             <&gcc PLL10>, /* hfpll1 */
> >>> +             <&gcc PLL16>, /* hfpll2 */
> >>> +             <&gcc PLL17>, /* hfpll3 */
> >>> +             <&gcc PLL12>, /* hfpll_l2 */
> >>> +             <&acc0>,
> >>> +             <&acc1>,
> >>> +             <&acc2>,
> >>> +             <&acc3>,
> >>> +             <&l2cc>;
> >>> +        clock-names = "hfpll0",
> >>> +                  "hfpll1",
> >>> +                  "hfpll2",
> >>> +                  "hfpll3",
> >>> +                  "hfpll_l2",
> >>> +                  "acpu0_aux",
> >>> +                  "acpu1_aux",
> >>> +                  "acpu2_aux",
> >>> +                  "acpu3_aux",
> >>> +                  "acpu_l2_aux";
> >>> +        #clock-cells = <1>;
> >>> +        #interconnect-cells = <1>;
> >>> +    };
> >>> +
> >>>       sfpb_mutex: hwmutex {
> >>>           compatible = "qcom,sfpb-mutex";
> >>>           syscon = <&sfpb_wrapper_mutex 0x604 0x4>;
> >>> @@ -933,6 +1100,9 @@ qfprom: qfprom@700000 {
> >>>               #address-cells = <1>;
> >>>               #size-cells = <1>;
> >>>               ranges;
> >>> +            speedbin_efuse: speedbin@c0 {
> >>> +                reg = <0x0c0 0x4>;
> >>> +            };
> >> Newline between properties and subnodes & between individual subnodes,
> >> please
> >
> > ack.
> >
> >>
> >> Konrad
> >>>               tsens_calib: calib@404 {
> >>>                   reg = <0x404 0x10>;
> >>>               };
> >



-- 
With best wishes
Dmitry
