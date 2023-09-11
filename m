Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8E779BE29
	for <lists+linux-pm@lfdr.de>; Tue, 12 Sep 2023 02:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238611AbjIKVG3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Sep 2023 17:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237902AbjIKNU3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Sep 2023 09:20:29 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EABCD7
        for <linux-pm@vger.kernel.org>; Mon, 11 Sep 2023 06:20:24 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9936b3d0286so586650066b.0
        for <linux-pm@vger.kernel.org>; Mon, 11 Sep 2023 06:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694438423; x=1695043223; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=H6ROeUkGbQ9Rsp3Ap+XbILwaeJ+lJZmemhX/U4xe7Go=;
        b=CrPldppNBhZzFat6Cf/IAgYlUK2d5z5UWRPxo1iG15CXyL3OcF8eUFKFSmNR5Kp5Hc
         K37drkwuM6SbP63P2TTLe8yf7seBg8NKG7oZF5jCub5AO5IQVYnVyFE8jwoXj6L5r5mm
         ezcno/G2sgVCJY/YNqMB8c1t5g2QVZYmw98TtY7Z2CMBNilFSwkIZhpMptebR0ssVQFj
         dgnOtHk6jM3PW2yzKijnYtgbhcO7xbeDLYHGb9L8AqNGHGPODXRU+ZE57BJlPMQYM0NJ
         Asmo/LAErkZvJ0eE7IfXbOWmFfNmK54RAIjGPWA96g1vboIP1X/dQvIlMunp4ioP1Y1Q
         fJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694438423; x=1695043223;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6ROeUkGbQ9Rsp3Ap+XbILwaeJ+lJZmemhX/U4xe7Go=;
        b=M02yAPKWT12dEZJiZGLIA/5CETQHBksSZQFqavOLshX2gdn0leDftJ53zFdXCnu7h1
         XieqPNxUUU26YnQ7bPux+j1Cw7KMx/wdRjUvBjElPdSSu2Fper9mFHAuV0dke+v7gSIc
         AMtN08lxqWBACdeIGqbZC22MYm0cXdF1WVffEijzNvyUtjHgNhAxNtyyzvUQAPHPZYFC
         0wz4Oz+LT4nuzMNsohsxi3vJ8lLlAKrHm4Ik4tJ0X+BXnL8VbM1kJU7KRKG7xcN+ET+c
         3vcX4XHWi0LL6qvumtWG9epwSUk1LQePTLA1Ejlpi/eS4YCtsL2JaXHdD2kCbrDsy3As
         u3ww==
X-Gm-Message-State: AOJu0YxJhBJP7eEF2sv7IhGN0f2pU1gIHhh+qS92FIiNxnM2dLzTVEqy
        hjCRY/wEdzjqlF2jQbEDvx2XtQ==
X-Google-Smtp-Source: AGHT+IGgYyfvssT4sNtFxUVZDRaUT+8hl2/TVvIOpsTMRx7+mL+0pcQnZkJK2xnZN0g15Oh+sSqCaw==
X-Received: by 2002:a17:906:21b:b0:99b:e5c3:2e45 with SMTP id 27-20020a170906021b00b0099be5c32e45mr9047002ejd.28.1694438422953;
        Mon, 11 Sep 2023 06:20:22 -0700 (PDT)
Received: from [192.168.37.41] (178235177061.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.61])
        by smtp.gmail.com with ESMTPSA id g2-20020a1709064e4200b009929ab17bdfsm5309746ejw.168.2023.09.11.06.20.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 06:20:22 -0700 (PDT)
Message-ID: <7ee011cc-af29-4fb3-8eca-678ec317ba3f@linaro.org>
Date:   Mon, 11 Sep 2023 15:20:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] genpd: qcom: rpmpd: Add MSM8917, MSM8937 and QM215
To:     =?UTF-8?Q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>,
        linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230911131627.13494-1-otto.pflueger@abscue.de>
 <20230911131627.13494-3-otto.pflueger@abscue.de>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230911131627.13494-3-otto.pflueger@abscue.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11.09.2023 15:16, Otto Pflüger wrote:
> MSM8917 uses the SMPA2 and LDOA3 regulators provided by the PM8937 PMIC
> for the VDDCX and VDDMX power domains in voltage level mode,
> respectively. MSM8937 also uses this PMIC and the same regulators.
> 
> QM215 is typically paired with a PM8916 PMIC and uses its SMPA1 and
> LDOA2 regulators in voltage level mode.
> 
> Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
> ---
Generally one-per-commit is the consensus.

> +
>  static struct rpmpd *sdm660_rpmpds[] = {
>  	[SDM660_VDDCX] =	&cx_rwcx0_lvl,
>  	[SDM660_VDDCX_AO] =	&cx_rwcx0_lvl_ao,
> @@ -764,6 +853,8 @@ static const struct of_device_id rpmpd_match_table[] = {
>  	{ .compatible = "qcom,msm8226-rpmpd", .data = &msm8226_desc },
>  	{ .compatible = "qcom,msm8909-rpmpd", .data = &msm8916_desc },
>  	{ .compatible = "qcom,msm8916-rpmpd", .data = &msm8916_desc },
> +	{ .compatible = "qcom,msm8917-rpmpd", .data = &msm8917_desc },
> +	{ .compatible = "qcom,msm8937-rpmpd", .data = &msm8917_desc },
Don't add two compatibles pointing to the same thing, or you'll
get an angry response from Krzysztof :D

You can do:

compatible = "qcom,msm8937-rpmpd", "qcom,msm8917-rpmpd";

and document the fallback in bindings

Konrad
