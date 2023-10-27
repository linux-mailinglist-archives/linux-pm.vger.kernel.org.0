Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952E47D8E26
	for <lists+linux-pm@lfdr.de>; Fri, 27 Oct 2023 07:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjJ0FaG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Oct 2023 01:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJ0FaG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Oct 2023 01:30:06 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA91E1A7
        for <linux-pm@vger.kernel.org>; Thu, 26 Oct 2023 22:30:03 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5b8a88038b4so2151626a12.1
        for <linux-pm@vger.kernel.org>; Thu, 26 Oct 2023 22:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698384603; x=1698989403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EDCChaj1gissqjEBEAMXe/0tc+K9t0+uAP8/ShNGqvA=;
        b=LNADWBZAnh8NUreCJD4I3fKYf5PCkPmAYq4KJbAXktmFrV16Xe+gaZJc7z+MOenP19
         ydXLRRg4bS7Xar3tZ5Zgv728l50zfg7wf4VITMa8oz9+U5yMRj8XxSysI4rhsf8zmoRH
         nOMT5ketnzbVFbd33vGWI6UGGC8E96WgZewF3N6Sicf19QycYvHQElk9fZpPtIIgUHok
         ZDiQFsyU9lbm7xbvIYNlPveyd+FzxpgAxAzXGZenE/RpFLNNdbm6Z7VhacumYmvP8AiR
         KAPrnJWD0Nc0X+Fmzkw6MDEify8v8BhRUtsNZZcVxyc+R6WRRf6JvmZXy18WCi905bPj
         mTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698384603; x=1698989403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDCChaj1gissqjEBEAMXe/0tc+K9t0+uAP8/ShNGqvA=;
        b=npkxfJ6krNjsw9JKFeEV48CQe9dlnwvSp6b36uMYmO3wprzF0AGeXq8nIc01ZTh9mZ
         nheyuYwxNbFHMFl63xRa3nS2CH/r0vwXzmsRRuybRmfESc40n7Hn2NwItUtlcMU6FRsW
         ngqlKcJW4dt+/xaS2aKURcCKKoMdIykQnpy5qvB6BjkU8Owe1oDgupnWgf8Q2xCZOFv+
         T2vJwCnSwDIOqAig9A3SaelT9LMqm+C3+gDi9BIJtVw84CUCp8vAyxnroHr+C9lphHaH
         snD670LvpUpzCG/jQQOTfsg7+aIsu697TUWO3u8c826Q48f8hX5WXQUnUYTOpLC9j+DE
         7/yw==
X-Gm-Message-State: AOJu0YxQaWIlCoKgwhbSEf6ylybtquUQQhThH1YvuCYFoNK2xpWUsVnO
        zIFBMQcBAXE077/RcwIEiNG4hA==
X-Google-Smtp-Source: AGHT+IEDdiUnBtNGv3NqKyoW3hwNthvCCMtRZ9osKz/+i+r83pEqPvuYCWs+QgwVReFiGJCBLU3PzA==
X-Received: by 2002:a17:90b:3a90:b0:277:5cd5:6f80 with SMTP id om16-20020a17090b3a9000b002775cd56f80mr5789495pjb.16.1698384603045;
        Thu, 26 Oct 2023 22:30:03 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id so3-20020a17090b1f8300b0027d0a60b9c9sm2554765pjb.28.2023.10.26.22.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 22:30:02 -0700 (PDT)
Date:   Fri, 27 Oct 2023 11:00:00 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: cpufreq: qcom-hw: document SM8560 CPUFREQ
 Hardware
Message-ID: <20231027053000.hitqlo4a6lusdgzw@vireshk-i7>
References: <20231025-topic-sm8650-upstream-bindings-cpufreq-v1-1-31dec4887d14@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025-topic-sm8650-upstream-bindings-cpufreq-v1-1-31dec4887d14@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25-10-23, 09:25, Neil Armstrong wrote:
> Document the CPUFREQ Hardware on the SM8650 Platform.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> For convenience, a regularly refreshed linux-next based git tree containing
> all the SM8650 related work is available at:
> https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm85650/upstream/integ
> ---
>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> index 0177d1ef0bf9..56fc71d6a081 100644
> --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> @@ -43,6 +43,7 @@ properties:
>                - qcom,sm8350-cpufreq-epss
>                - qcom,sm8450-cpufreq-epss
>                - qcom,sm8550-cpufreq-epss
> +              - qcom,sm8650-cpufreq-epss
>            - const: qcom,cpufreq-epss
>  
>    reg:

Applied. Thanks.

-- 
viresh
