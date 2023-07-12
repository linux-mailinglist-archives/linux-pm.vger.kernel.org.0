Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBD7750578
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jul 2023 13:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbjGLLFY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Jul 2023 07:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbjGLLFI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jul 2023 07:05:08 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56371BFD
        for <linux-pm@vger.kernel.org>; Wed, 12 Jul 2023 04:04:58 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6686ef86110so3799901b3a.2
        for <linux-pm@vger.kernel.org>; Wed, 12 Jul 2023 04:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689159898; x=1691751898;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X+Wews26f42B6F9NTm9t3y/Vvrs3vkKSsYOfJ3lYI4g=;
        b=OyK6WdTylTqy9PFIcce1pJLUJLUocI+YBV+8pdGNvV/naLoWIFntcEUpET8VSW/mpQ
         zo8nPQiuP9Gs5yUls/Fu9vxKoNhl/m8PsE3qKgmOiBNqq4/my8c7nrsdq2yxzNc5bL6y
         yYV12JuSCohVqzKMIQuYkoKhhOnYvHItakCffumWH0rJDcvjBiXQbWUnn0hEN/tizbDp
         AvzBlO6lEVvv+O19N6pqj+wIXZA7YOIAjRSSMvtRpL1ljD4oNKYqx5KlaY67p7VE52e2
         /7DrYNjb7Yr7KHo61RBNQNsWlEVKpylZ+UH651e1FJTDRsdDnn6JABoJxdE47Prnn8nw
         0DSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689159898; x=1691751898;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X+Wews26f42B6F9NTm9t3y/Vvrs3vkKSsYOfJ3lYI4g=;
        b=B0icpLvsfyqJzcimqR67M8CpinwqAO8WJQ+sTbze+DpXdRPrYrU6u35wQcMH3uj2jC
         EZA5T3c/FOoMS0rNQJwPVE+wqmmU3Xo/It4DvTjG0Y2filI7w2tJFHoM1O3deFoOUHir
         GVvJPOQUOm6ktzEvjYAdVVY1tWrh93SQB4IUQ26P9WZLKV/xbnbNoQEocNoI+ju6nT1S
         2XsUBP9Yg81go/g65Sjs0N/bOydhV7mjR1TxWmuyvkQDq3rI/WK2veFIA8GdBwuMKQTK
         rQhj8N/3TBkSaI2ltqp/AgRpbCy9BkOrdIXxNlS9+ChJuhFo6IAaOR9EAdXmAM0iLlJy
         ULBw==
X-Gm-Message-State: ABy/qLZ2mRx86fFGGro8KITZC9lgn9EfvTkx52GLNJREsNkDi4/R620l
        BzxV9o2dHrGgkW1LgmgZWXYi
X-Google-Smtp-Source: APBJJlGQSug18X2OGpNOMHJbWPVpjx5GUBIKk//oNJJvwBCNO4UOIQdTEpX4pdNZskUjsIHaJiwabQ==
X-Received: by 2002:a05:6a20:841a:b0:12f:f9af:3a2a with SMTP id c26-20020a056a20841a00b0012ff9af3a2amr19054477pzd.54.1689159898113;
        Wed, 12 Jul 2023 04:04:58 -0700 (PDT)
Received: from thinkpad ([117.207.27.131])
        by smtp.gmail.com with ESMTPSA id jj1-20020a170903048100b001b9cd746c03sm3661330plb.194.2023.07.12.04.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 04:04:57 -0700 (PDT)
Date:   Wed, 12 Jul 2023 16:34:42 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
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
Subject: Re: [PATCH 02/14] dt-bindings: opp: Increase maxItems for opp-hz
 property
Message-ID: <20230712110442.GS102214@thinkpad>
References: <20230712103213.101770-1-manivannan.sadhasivam@linaro.org>
 <20230712103213.101770-3-manivannan.sadhasivam@linaro.org>
 <20230712103921.rvut4r2kgqe6k42e@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230712103921.rvut4r2kgqe6k42e@vireshk-i7>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 12, 2023 at 04:09:21PM +0530, Viresh Kumar wrote:
> On 12-07-23, 16:01, Manivannan Sadhasivam wrote:
> > Current limit of 16 will be exhausted by platforms specifying the frequency
> > for 9 clocks using opp-hz, like Qcom SDM845 SoC: 9 * 2 (64 bits) = 18
> 
> You missed mentioning why you are multiplying by 2 here (I suppose one
> place for /bits/ 64 and one for <freq>.
> 
> Also full stop (.) is missing at the end.
> 

Ok.

- Mani

> > So let's increase the limit to 32 which should be enough for most platforms
> > (hopefully).
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/opp/opp-v2-base.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
> > index 47e6f36b7637..e2f8f7af3cf4 100644
> > --- a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
> > +++ b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
> > @@ -56,7 +56,7 @@ patternProperties:
> >            need to be configured and that is left for the implementation
> >            specific binding.
> >          minItems: 1
> > -        maxItems: 16
> > +        maxItems: 32
> >          items:
> >            maxItems: 1
> >  
> > -- 
> > 2.25.1
> 
> -- 
> viresh

-- 
மணிவண்ணன் சதாசிவம்
