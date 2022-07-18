Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD71577977
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jul 2022 03:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbiGRB6w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 Jul 2022 21:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiGRB6v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Jul 2022 21:58:51 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B7BF02
        for <linux-pm@vger.kernel.org>; Sun, 17 Jul 2022 18:58:49 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id c6so7794149pla.6
        for <linux-pm@vger.kernel.org>; Sun, 17 Jul 2022 18:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CokcQbp76rvQZ9pFN70oiecOHjxj+5itFymAFXRWP/w=;
        b=m4ieBHKCCwFZ384POZtd2o6j31IhBWp6vMOQyD01RAFflwhAJMOiCvVA6AqtHOFHiJ
         xIST7kGxmkJvEjRh7kiaSqhkOSOjFJu0LdI31wqlAnV873qAdYcp7P78Y5ROQiBnQc0Z
         FLgnpdZK1PtLqbRa7ANbrnu2wspZzXYRf7afzfEGlQm7sayAO5FAPUsYWZ4jR9CLHL1Q
         gAjBDOKb1zyQdDfl7BGYzfYhvNQaODNfl9eMuNAjIZWnyIWPea/4lgZtDJnPkYzqPleH
         u7C8Ig5tHmPOwM9P7sqIcOvqLE3TLEXp+hBw94yyW0uNiZ467nkCadPUjkoEw9JU/GQO
         I0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CokcQbp76rvQZ9pFN70oiecOHjxj+5itFymAFXRWP/w=;
        b=nBnQxSawDL81u1dgxWYLpg+4mzCsnqlrYik4HZlfbZDuX87W6NzCcsKsHlx+E0/x4O
         ueWNRu1Hu33nzSpaSVujE/pfzDKBrh4wUs3pIk5w6FwXz7S+xbvBHwOKFCmkgWpdvT3o
         BsveZtbISCAh4KGzh3Mtry2xbEfI9boGHdCbHwnWjy9QHYIzQGE8XIhIgsLY+hnq7xcz
         tRkqU7wDY2hTJJ1eYWm23ewXtlO+IXgI5vfK+vNJraMEBIjhao21hxFIDUikZLOFsLrz
         rPkkhDWbMVKFURnGNc25Ns2L+u7J3HBqRKXahLbB1AiZrH0L/W145FHVVwx3NHPw6fth
         whcA==
X-Gm-Message-State: AJIora/TUyJ/NxTM433sMIqzyRbwNem9ZeW5TUwCEDCVxeI7UVH/P/Df
        itf+AqpXJVEieuUv1D4PwMRdUg==
X-Google-Smtp-Source: AGRyM1vIfihkqBtkEsdM480xDTf0pZmVCt+QrVqHWkFHuHDk0VjD562Z9iUFwwdfPKoSVYZZswiVpQ==
X-Received: by 2002:a17:902:b287:b0:16c:2ae8:5bcb with SMTP id u7-20020a170902b28700b0016c2ae85bcbmr25855619plr.164.1658109528966;
        Sun, 17 Jul 2022 18:58:48 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id w15-20020a63c10f000000b004114cc062f0sm6900906pgf.65.2022.07.17.18.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 18:58:48 -0700 (PDT)
Date:   Mon, 18 Jul 2022 07:28:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] dt-bindings: cpufreq: cpufreq-qcom-hw: Add SM6375
 compatible
Message-ID: <20220718015846.y7s7l5tj2eywfllt@vireshk-i7>
References: <20220716193257.456023-1-konrad.dybcio@somainline.org>
 <20220716193257.456023-5-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220716193257.456023-5-konrad.dybcio@somainline.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16-07-22, 21:32, Konrad Dybcio wrote:
> Add compatible for EPSS CPUFREQ-HW on SM6375.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> index 2f1b8b6852a0..24fa3d87a40b 100644
> --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> @@ -25,6 +25,7 @@ properties:
>        - description: v2 of CPUFREQ HW (EPSS)
>          items:
>            - enum:
> +              - qcom,sm6375-cpufreq-epss
>                - qcom,sm8250-cpufreq-epss
>            - const: qcom,cpufreq-epss

Applied. Thanks.

-- 
viresh
