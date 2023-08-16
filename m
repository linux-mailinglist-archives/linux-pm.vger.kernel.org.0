Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4476A77ED9E
	for <lists+linux-pm@lfdr.de>; Thu, 17 Aug 2023 01:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347106AbjHPXED (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Aug 2023 19:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347132AbjHPXDn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Aug 2023 19:03:43 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0622D40;
        Wed, 16 Aug 2023 16:03:24 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-586a684e85aso76741447b3.2;
        Wed, 16 Aug 2023 16:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692227004; x=1692831804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=14Y4PnSZD+AWELkkOV5EhbFkig7uI2PkD6OuZnm0uRc=;
        b=ZvDYQIuraumOQfPyDlsoewwPhl1eHz0Nej1DcEJ1W3D+EtajuuDXfsz7ccCxZigBeu
         liKhDFmxgoNX1EeAQpS6+6IPI2pLzEx3I1nQfc5jjlXj3db4c2DeocRT0tF9zQ0woQ4M
         36qhZ2BAMkyAOgYU5O8LjaRFWO5CKAFHQkv+ggaZi0s3GpuqKY/bndi9dL/QDhasTXdT
         yk91z9+9WRsqnGU5Og8BTxoEV+NdqsIEvagdUN1ZYJUN5lbbp2UuoCyHZScuCFM9h6Q8
         Ns1ypUUcAUfpPti/NjUioIXisQdsyTMR1e9/H0I13KTgWd1vVqb+wOCrr58w+jkJk6gR
         +kyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692227004; x=1692831804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14Y4PnSZD+AWELkkOV5EhbFkig7uI2PkD6OuZnm0uRc=;
        b=d6JcSeH03Smj+7r9eLKu0qhXSBGTYaa8I19m2HCr2FivoqKrkGtPmX4YG5rh/g4GZT
         vEU7wa131FHt86YRq7YaMFSkvT7/N4Ve77KlN8zO4zBO5jvWS/sEPpHsH9umAFNSOsAc
         lySYnBAhB8Vr288oMyKgNCJnw8j0icj+aJGdHPFoC5cLpTaJY/LiLqpwkH6bF50GZI/A
         VZL3sH1EyCo7I+nP4FCtZ/5Qco2hQAcnlakGuS1E+5VtOTL3ov8gIeRPDBbXLubz6lD/
         pHeo7bhuG4RvqKyIJWaJg0iH+ykRBbt+CBqOJlyfPDnguFT0bfE7a0V9b3XwiWz4jIVM
         Jj4w==
X-Gm-Message-State: AOJu0YyFIbDOrBTn72lEsR0hT5FMf4kDri25X6WPrlshLG6f5Yf4093T
        c0Fp4OYLBrQ6KbeD+q7oSqK4MVopEUI=
X-Google-Smtp-Source: AGHT+IE/6FlWPVtFAZtYs8px7qlhku3MpHBUisCflrI1zNJWpGYhmRS+2tmFk4NB8DPBVKQj/xhUrQ==
X-Received: by 2002:a81:6205:0:b0:586:c0bc:77aa with SMTP id w5-20020a816205000000b00586c0bc77aamr3363265ywb.24.1692227003822;
        Wed, 16 Aug 2023 16:03:23 -0700 (PDT)
Received: from localhost ([2607:fea8:529e:7800::5ee])
        by smtp.gmail.com with ESMTPSA id z16-20020a81c210000000b005463e45458bsm4263179ywc.123.2023.08.16.16.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 16:03:23 -0700 (PDT)
Date:   Wed, 16 Aug 2023 19:03:21 -0400
From:   Richard Acayan <mailingradian@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: interconnect: add SDM670 OSM L3
 compatible
Message-ID: <ZN1VuZCwd8xYsEkV@radian>
References: <20230815223108.306018-5-mailingradian@gmail.com>
 <20230815223108.306018-6-mailingradian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815223108.306018-6-mailingradian@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 15, 2023 at 06:31:10PM -0400, Richard Acayan wrote:
> Add the compatible for the OSM L3 interconnect used in the Snapdragon
> 670.
>
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

The subject line should be "dt-bindings: interconnect: OSM L3: add
SDM670 compatible" to follow the same format as other patches to this
file.

>  Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> index 9d0a98d77ae9..21dae0b92819 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> @@ -21,6 +21,7 @@ properties:
>            - enum:
>                - qcom,sc7180-osm-l3
>                - qcom,sc8180x-osm-l3
> +              - qcom,sdm670-osm-l3
>                - qcom,sdm845-osm-l3
>                - qcom,sm6350-osm-l3
>                - qcom,sm8150-osm-l3
> -- 
> 2.41.0
>
