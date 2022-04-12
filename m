Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06FA4FE887
	for <lists+linux-pm@lfdr.de>; Tue, 12 Apr 2022 21:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347614AbiDLTWy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Apr 2022 15:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352098AbiDLTWx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Apr 2022 15:22:53 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985AC2182C
        for <linux-pm@vger.kernel.org>; Tue, 12 Apr 2022 12:20:34 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id z19so19912538qtw.2
        for <linux-pm@vger.kernel.org>; Tue, 12 Apr 2022 12:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=chVyhFxixwoz7zNbu99F11TKHFQnl3/UVYBDPB80ZHY=;
        b=gXpCS89SV25uD/Y+1x2aHYvQ4vgt3R0Xu8swk6osxevhzyMgEDaPNW9ZP/NFJNuPHz
         28TaViXb9L44buYRbeek8mPQATl09OQ79rU7Z3vikUf8fC9CMeEtxoBc20+ak86yhtyJ
         frFm6Pn3raz0+A/40BKzY3O7/vPlZktKTHmUJQDZM+eSJneDV8Q6568Y70BWO4GhTcgy
         eVEoeFmqKEpZc2RCRauAr7aKhDGpHi/ukxgVxu4alQ5aDJTSCJAJ/pdyygki/zCHbuN+
         F1osIdGDrMeDJsLmaphrdl1NYjQqnyYcFDCrHCkgbVNURgnm8xNBbKuiqeudtRZSVYtY
         FakQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=chVyhFxixwoz7zNbu99F11TKHFQnl3/UVYBDPB80ZHY=;
        b=CzRQa2bfSpC+l5C2PTRT5rISwX55mCd/Pu0e2Lk7xaOViu1o5PCnxXoPepq1AjsdAB
         hRIut2wV3tOnIFmdnbvgZN1GmQ3wTRB7aANKJM4tvmKsfp2arbvl3hYTu3CD2pG1HBUw
         ZbBN4EPzVvO4W+Fc9xrDx1nrL8rGm0Da8O44DD/vHLzdaOyZpDs+1QI/WIEP3cUt7BQL
         yKO/pWWiliUmkCv+27CMSiavyE+LOoMFSeT5N1Q5VFxYWNLxnM+2hN+tYDvg0PXWUO9w
         yte29ftnyJwcsyjuZDaaJ7UuVbQ0EE857kAfsgf7LZ1HdS7CzG6YWt4sk9MmmGO32ZIA
         4VsQ==
X-Gm-Message-State: AOAM532GbRKm7H4krNahl+jc64MmBlKg00sDiYiie+Xkb5cEmkKh8M2v
        /nfG12Xer6CE2b5rD99t3GZtxIEaUQ6Z8zWOEiPZhA==
X-Google-Smtp-Source: ABdhPJyLIBZR72VaDtuzWmfwbKyURkZFlbzUnKCwIee1kql6f59UqrnPndVBLSVdTBBd76Xhj9Y/B4Xwa0ph4v4E8kU=
X-Received: by 2002:ac8:5a46:0:b0:2e2:2edd:374 with SMTP id
 o6-20020ac85a46000000b002e22edd0374mr4570468qta.295.1649791233793; Tue, 12
 Apr 2022 12:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220406002648.393486-1-dmitry.baryshkov@linaro.org>
 <20220406154028.EC897C385A3@smtp.kernel.org> <CAA8EJpod2cNOYr3g+DmdWo_2Ujv7-pW39fBKqcpCPvtVgP5-NQ@mail.gmail.com>
 <20220412184304.79012C385A8@smtp.kernel.org>
In-Reply-To: <20220412184304.79012C385A8@smtp.kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 12 Apr 2022 22:20:22 +0300
Message-ID: <CAA8EJppha+V77S6LAZW9us6XiVu9vD9X=RF+RKd+5cvCz+NxEg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] arm: qcom: qcom-apq8064: add separate device node
 for tsens
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 12 Apr 2022 at 21:43, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Dmitry Baryshkov (2022-04-06 12:57:30)
> > On Wed, 6 Apr 2022 at 18:40, Stephen Boyd <sboyd@kernel.org> wrote:
> > >
> > > Quoting Dmitry Baryshkov (2022-04-05 17:26:44)
> > > > Currently gcc-msm8960 driver manually creates tsens device. Instantiate
> > > > the device using DT node instead. This follow the IPQ8064 device tree
> > > > schema.
> > >
> > > Why can't the schema be changed?
> >
> > But these commits change the schema. They make apq8064 follow more
> > logical scheme of ipq8064.
> >
>
> Sounds like ipq8064 and apq8064 follow different schemas. Is there any
> benefit to harmonizing the two vs. just leaving it as it is in the dts
> and making the schema match whatever the dts has?

I'd prefer to harmonize them. It makes no sense to have two different
approaches for the single IP block (shared between ipq and apq/msm).
And having a separate device tree node for the tsens removes a
dependency from gcc on the nvmem/qfprom.
Note, upstream qcom-msm8960.dtsi doesn't describe tsens at all, so we
don't have to worry about it.

-- 
With best wishes
Dmitry
