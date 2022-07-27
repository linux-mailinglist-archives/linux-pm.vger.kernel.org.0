Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB535822A2
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jul 2022 11:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbiG0JCu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jul 2022 05:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbiG0JCu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jul 2022 05:02:50 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB1411C0E
        for <linux-pm@vger.kernel.org>; Wed, 27 Jul 2022 02:02:48 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-31e623a4ff4so168390167b3.4
        for <linux-pm@vger.kernel.org>; Wed, 27 Jul 2022 02:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lMfKgfMggMNo3eihisQlQcnwku84/adCCeUBHxwgFgY=;
        b=AVctTuCDLV66HgOOebgeRV0S1c8FJndDasQlXmmcLGkjwPJsXQhTimeMepc3Vj4wqO
         pdTiIh44L7gXx816XA0kVVCujErNu5wfVFJbs79Lin6dgfieUxrgLZjAxSpBt6TkOIU8
         eKjmpPmUdgob41bpl+2pj8RQEfmF2NdaPc95fauCu/bAWIKMgjWLsEcfPx5ZcLB7NpNt
         Fnk0ygntA2pshSJrbCspJh36vwLl61Q2ga4JTo5x9MBOQ8IWqkuZ98nV61I0Pfh6rFBl
         SDwDF/br+DhrVHUmzLqHoD9XbGuwyWKd1mc54eDSrIZZRBj8WXbRAya0F1q0kWusr2mD
         MoHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lMfKgfMggMNo3eihisQlQcnwku84/adCCeUBHxwgFgY=;
        b=lz5QgHB5ZN1atQclYvEZuxiV4qX+l3JrAo18J3qBSlPASfpHv9KOIZkDadWAAGAJHz
         Ca5+XfeTL08VsHjFmNt6yzARZieTkiAG61VEK0s7MPcRDQEpV2g60Yc7jHakJuEEFg3w
         ZdyrALfccLnQzHT+h+OABa51SeJTWN4XzEpPnm0n5xQvGq4+fvK8po8IO+9Pi4oL4cbR
         giEdD8G7JYUC7d2sxRhyHR1bEQ1rfv7ycfSdhWhaYOuP1gJUfinq4CLMqPmaXaHwury4
         bJS2R1JjBTzrIgFbmobTADVtO6GGTRwUh13dlrqulvrhzd4OAyQA6+th1k6SiQxW+73B
         EF3A==
X-Gm-Message-State: AJIora/5B4E4cnn4mpY6XX2aAFYOnWOawzx9cB0LSY5O53WawupQotG7
        nKmtpUpZRj95gK0j7cWimTqthpykmKLDjMBXc7Gr7A==
X-Google-Smtp-Source: AGRyM1vHX+qKTMq6tfqznzj4BNItgMsLSP5R9D+chOdqP/40r06PtcoFkng2x2B+2afSmTdaPGf6uhJXJv31xOyY2sk=
X-Received: by 2002:a81:ad60:0:b0:31e:68a9:be1 with SMTP id
 l32-20020a81ad60000000b0031e68a90be1mr17834847ywk.244.1658912567588; Wed, 27
 Jul 2022 02:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220726135506.485108-1-bchihi@baylibre.com> <20220726135506.485108-3-bchihi@baylibre.com>
 <1658866142.328871.782232.nullmailer@robh.at.kernel.org>
In-Reply-To: <1658866142.328871.782232.nullmailer@robh.at.kernel.org>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Wed, 27 Jul 2022 11:02:11 +0200
Message-ID: <CAGuA+ooAHSvFAQC4mg7inOXO_bLvZv5Req=vm3PE6Pkjtf_vsA@mail.gmail.com>
Subject: Re: [PATCH v8 2/6] dt-bindings: thermal: Add binding document for
 LVTS thermal controllers
To:     Rob Herring <robh@kernel.org>
Cc:     rui.zhang@intel.com, rex-bc.chen@mediatek.com,
        daniel.lezcano@linaro.org, amitk@kernel.org, mka@chromium.org,
        linux-kernel@vger.kernel.org, abailon@baylibre.com,
        robh+dt@kernel.org, p.zabel@pengutronix.de, matthias.bgg@gmail.com,
        linux-pm@vger.kernel.org, rafael@kernel.org, khilman@baylibre.com,
        fan.chen@mediatek.com, linux-arm-kernel@lists.infradead.org,
        krzk+dt@kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org, louis.yu@mediatek.com,
        james.lo@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 26, 2022 at 10:09 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, 26 Jul 2022 15:55:02 +0200, Balsam CHIHI wrote:
> > This patch adds dt-binding documents for mt8192 and mt8195 thermal controllers.
> >
> > Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> > Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> > ---
> >  .../thermal/mediatek,mt8192-lvts.yaml         | 73 ++++++++++++++++++
> >  .../thermal/mediatek,mt8195-lvts.yaml         | 75 +++++++++++++++++++
> >  2 files changed, 148 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/thermal/mediatek,mt8192-lvts.yaml
> >  create mode 100644 Documentation/devicetree/bindings/thermal/mediatek,mt8195-lvts.yaml
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> Error: Documentation/devicetree/bindings/thermal/mediatek,mt8195-lvts.example.dts:32.36-37 syntax error
> FATAL ERROR: Unable to parse input tree
> make[1]: *** [scripts/Makefile.lib:383: Documentation/devicetree/bindings/thermal/mediatek,mt8195-lvts.example.dtb] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1404: dt_binding_check] Error 2
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/patch/
>
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit.
>
Hello Rob,

Thank you for the feedback.
I'm updating my dt-bindings check tools, fixing, and I will resend ASPA.

Best regards,
Balsam.
