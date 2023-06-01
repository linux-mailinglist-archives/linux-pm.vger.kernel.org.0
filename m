Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A13718F81
	for <lists+linux-pm@lfdr.de>; Thu,  1 Jun 2023 02:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjFAA3F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 May 2023 20:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjFAA3E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 May 2023 20:29:04 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FE011F
        for <linux-pm@vger.kernel.org>; Wed, 31 May 2023 17:29:02 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-ba827a34ba8so237352276.0
        for <linux-pm@vger.kernel.org>; Wed, 31 May 2023 17:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685579342; x=1688171342;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NEEjlzeLxFQftTZQSpKJW7Jq+wnau68354KXBq6LZXM=;
        b=DASrcWJUigO5nWpOPk4tjfh5Q25y9tW2ZNCwtl31oosKOjljcct+SiTn3TZeN3yQc4
         EJ2Mhq07DbjHMZEWvgSauYe9bI6j68f9z6jvw2dcYl6YlsatEX8ggHKKBCAVd18yaTlT
         cLZGlLL/cK3XJBvKKrvFNd3DFJ8Jk8l7QWSfgiyYDI1qut/k81copaH0XHDiTLzrhdKl
         nymb+vvf0h3AIC1PvmRMVqAE9voOMuVqyhXlwZmleEQ+s4/zdkBF5gXUhIiAEP/cb4oQ
         e/XD4AigUJSTvNw/N2l3H68F92eQDNZ1sSsEDzIlzbMcz0NgTGdyS2m27pqioJmTNjc/
         g+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685579342; x=1688171342;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NEEjlzeLxFQftTZQSpKJW7Jq+wnau68354KXBq6LZXM=;
        b=jbr3jZsRixrVm/2TAiUDJcG85/F3vV4kNP6d5xfDLiyI7jPN4b+3BD8s+IP6GlIDF0
         asqqHCYWdSHqYqK4cg9LrWJVaJZpL0WLj3XY0mxWHGFrJzSPiCuhucm1YyeFAP36q24l
         /6Orm39VGsxjQY7gcqtTkUB56lyhqB1wk7sY5/uwfGCAdLOzuNHy2L0amaRcTiFnYKyW
         pirmauvz94OzSpOot5Fe1gbhlBHq5PQPwFeuuhoGXELXlB8CYyxrtV+5oVyURl4ZmSdL
         T1EVgiexKta8R0O2AWWTKKL+3W2ZmJcTRXdwiXsYfYL9CjXG8R6JO9Sjb343z2mFEdLo
         5RJA==
X-Gm-Message-State: AC+VfDyfeqeu6/UqSyNYNLEogsdKCh13f/00qYKBaPyrWep+ij0h6/gW
        SD7/G0d6GmGEx1m0xFwW8rRq6WHLebn244cdrRisTA==
X-Google-Smtp-Source: ACHHUZ5iUMfJV/FOMlr08ahtzPGqh8EXAdjkfAkBYn2H1tsCyIX1DSM2KkkhEy6vsvNjLD1u9b8Hs3L79AxVpBIaYpk=
X-Received: by 2002:a25:b08f:0:b0:b9a:6a68:b8da with SMTP id
 f15-20020a25b08f000000b00b9a6a68b8damr8271454ybj.25.1685579342118; Wed, 31
 May 2023 17:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230531014248.3824043-1-dmitry.baryshkov@linaro.org>
 <20230531014248.3824043-2-dmitry.baryshkov@linaro.org> <3a0deecb-8235-8cf5-262e-8cb8d2349a4c@linaro.org>
In-Reply-To: <3a0deecb-8235-8cf5-262e-8cb8d2349a4c@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 1 Jun 2023 03:28:51 +0300
Message-ID: <CAA8EJprhZCzL_0Htpjm0=Uur7AdkZLe_1Tw+uaBPwUXSOeTRyQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: power: reset: qcom-pon: define pm8941-pon
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 31 May 2023 at 21:59, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 31/05/2023 03:42, Dmitry Baryshkov wrote:
> > On PM8941 pon doesn't store the reset reason. However we still need the
> > wrapping node for pwrkey and resin nodes. Add bindings for pm8941-pon
> > device.
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  .../devicetree/bindings/power/reset/qcom,pon.yaml    | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> > index d96170eecbd2..eb3c88e501ef 100644
> > --- a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> > +++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> > @@ -19,6 +19,7 @@ properties:
> >    compatible:
> >      enum:
> >        - qcom,pm8916-pon
> > +      - qcom,pm8941-pon
> >        - qcom,pms405-pon
> >        - qcom,pm8998-pon
> >        - qcom,pmk8350-pon
> > @@ -56,13 +57,22 @@ required:
> >  unevaluatedProperties: false
> >
> >  allOf:
> > -  - $ref: reboot-mode.yaml#
> > +  - if:
> > +      not:
> > +        properties:
> > +          compatible:
> > +            contains:
> > +              const: qcom,pm8941-pon
> > +    then:
> > +      $ref: reboot-mode.yaml#
>
> Are you sure that this works, so pm8941 does not allow mode-*
> properties? I am afraid they would still be considered evaluated, thus
> your if-not is not effective.

Yes, I checked that they trigger the schema validation error. If you'd
prefer I can extend this 'if' with explicit 'mode-*: false'.


-- 
With best wishes
Dmitry
