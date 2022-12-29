Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE3B658C63
	for <lists+linux-pm@lfdr.de>; Thu, 29 Dec 2022 12:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbiL2Ltn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Dec 2022 06:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbiL2Ltf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Dec 2022 06:49:35 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7382413CCC
        for <linux-pm@vger.kernel.org>; Thu, 29 Dec 2022 03:49:32 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 192so20291421ybt.6
        for <linux-pm@vger.kernel.org>; Thu, 29 Dec 2022 03:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SMZY5GKkIZdtFn2VB5QoHnavLrmfpGhxUvDe0o6KUfs=;
        b=xpgoaJlJk1lqQPCOch1wBqHpKePorz1dLIGF2tl13rZH/2PP3/hMMBYL/IL0aGTvj+
         RGiJ501yjtzZo7Dnq6QPU8BM/y6NL51rV923CrTSkJ9nfl0p7uLEYo9BDuRnDmk6Ijt5
         b+bz+V+K88Z8LLgiMEsutsPoYLlSiCsHBm2gUoo8k3WljYJ9XUJUZHddKp+n2UYiEkWa
         a7d44BwKqoonu779chIvhwETOg8Ez4GTPWNdEfU7+e8v+pJMsTwfnnHFKMbNomHsKiyQ
         QZQ0qKksyn2gKIONg7zxwS0oDy1Bin/HHwaaleoyScB7vFfMXBXpuglw/4mmZNvcO8Bl
         i7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SMZY5GKkIZdtFn2VB5QoHnavLrmfpGhxUvDe0o6KUfs=;
        b=hmXNh+XPPMi/qDAIRvXsYa0ruJ35njer3PYssM6Srh+1/KDhAeqtCzEXsYDUKPDiuo
         WVSlMhORLbNGsII72sgXtv59yeOXmYPXqMJ7cT+960C9q3ujO29DLu+Nln7x3TS9mn1E
         Xbev/HpBpuy4+lwGIpyGUlNhQ8o4WJIdJI7QTPfd/daL/7c5CT3su5aH4jrhbJKzeVjw
         F9j2p/win8o93a9zCPgnqO/rRX3iaHIS+Owg8EBk3+4M1KtP63Bz/7DfOmpGftR7fHMu
         d/fyTcDq9+BxcntEKegpWznG1fc3oNyT3WJ0grTGxebKLoqTNsS0f173CvHzso11HyDi
         TwfA==
X-Gm-Message-State: AFqh2kp29rN9aCSnvjHELJNo+K1GGYb+Z2S2mR7Onq7UGGVlViGXWxTt
        MfvmyZdudppnj9JeX0wwAbHMHXmzNt6uZFP3vf03pg==
X-Google-Smtp-Source: AMrXdXvd+lyJXI5hv8754ycpuNviaF6tdhWrqA4bqUGaa3bf1ChZ8rRfLDud92irEB5xcYMRgM0PJl7fbAm6eIW9788=
X-Received: by 2002:a25:e90c:0:b0:73a:3b94:47fc with SMTP id
 n12-20020a25e90c000000b0073a3b9447fcmr3130365ybd.152.1672314571695; Thu, 29
 Dec 2022 03:49:31 -0800 (PST)
MIME-Version: 1.0
References: <20221229030106.3303205-1-dmitry.baryshkov@linaro.org>
 <20221229030106.3303205-3-dmitry.baryshkov@linaro.org> <ef9d5f72-e39a-e32c-5d7d-4a6ee57101aa@linaro.org>
In-Reply-To: <ef9d5f72-e39a-e32c-5d7d-4a6ee57101aa@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 29 Dec 2022 13:49:20 +0200
Message-ID: <CAA8EJppp967vZNaMBDmB7HaU_EaCJfvUxFFHikb9oXRohGSCBg@mail.gmail.com>
Subject: Re: [PATCH v5 02/20] dt-bindings: thermal: tsens: support per-sensor
 calibration cells
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 29 Dec 2022 at 10:35, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 29/12/2022 04:00, Dmitry Baryshkov wrote:
> > Allow specifying the exact calibration mode and calibration data as nvmem
> > cells, rather than specifying just a single calibration data blob.
> >
> > Note, unlike the vendor kernel the calibration data uses hw_ids rather
> > than software sensor indices (to match actual tsens usage in
> > thermal zones).
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  .../bindings/thermal/qcom-tsens.yaml          | 95 +++++++++++++++++--
> >  1 file changed, 85 insertions(+), 10 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> > index f3660af0b3bf..4bb689f4602d 100644
> > --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> > +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> > @@ -81,18 +81,63 @@ properties:
> >      maxItems: 2
> >
> >    nvmem-cells:
> > -    minItems: 1
> > -    maxItems: 2
> > -    description:
> > -      Reference to an nvmem node for the calibration data
> > +    oneOf:
> > +      - minItems: 1
> > +        maxItems: 2
> > +        description:
> > +          Reference to an nvmem node for the calibration data
> > +      - minItems: 5
> > +        maxItems: 35
> > +        description: |
> > +          Reference to nvmem cells for the calibration mode, two calibration
> > +          bases and two cells per each sensor
> >
> >    nvmem-cell-names:
> > -    minItems: 1
> > -    items:
> > -      - const: calib
> > -      - enum:
> > -          - calib_backup
> > -          - calib_sel
> > +    oneOf:
> > +      - minItems: 1
> > +        items:
> > +          - const: calib
> > +          - enum:
> > +              - calib_backup
> > +              - calib_sel
> > +      - minItems: 5
> > +        items:
> > +          enum:
>
> This should not be an enum but a list of const... unless "holes" are
> expected (e.g. s0_p1 and s5_p2, without ones in between).

Yes, this is the case. See the msm8916.dtsi changes. There is no
sensor with hw_id 3, so the sequence is: ... s2_p1, s2_p2, s4_p1,
s4_p2,....

Same applies to the msm8939 (no sensor #4).

Note: if there was support for the prefixItems, I'd have probably
marked mode/base1/base2 to be the first items of the array.

>
> > +            - mode
> > +            - base1
> > +            - base2
> > +            - s0_p1
> > +            - s0_p2
> > +            - s1_p1
> > +            - s1_p2
> > +            - s2_p1
> > +            - s2_p2
> > +            - s3_p1
> > +            - s3_p2
> > +            - s4_p1
>
>
> Best regards,
> Krzysztof
>


-- 
With best wishes
Dmitry
