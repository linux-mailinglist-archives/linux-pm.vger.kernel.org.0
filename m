Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AADA173DD54
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jun 2023 13:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjFZLWT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Jun 2023 07:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjFZLWM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Jun 2023 07:22:12 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F129B186
        for <linux-pm@vger.kernel.org>; Mon, 26 Jun 2023 04:21:48 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f122ff663eso3974405e87.2
        for <linux-pm@vger.kernel.org>; Mon, 26 Jun 2023 04:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687778491; x=1690370491;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ndfuu4K/62Z1mfzAu2i/EV3jgAx+UABuEd2Nf19BUW4=;
        b=YcJrp5YFigR4LueFKp+qCR3K6RaSCBiMFZyVVjlxJ7TuCTeAo4e8Ezhn87lF9XL2/B
         FAw/cpbALReCkZ98VsOGOvCV1/GZXr51SOSq0GfxvkL0ldPMlKC4KougpTdYCWLTDowS
         4J3wSUGcOac3IvECD5DqHo4iyNEt7F4TznEiiCgTjzLoi1KsOLUYQQIX5x4Jo1sDcxF+
         3/hOIWQ0i4KS6g5f33jufDRR5ute7rbHO/5Wf/be3bM7tZw2s7LDMkkab9viUO+oA3Y7
         SjhdXAbRFAuykNqCuVqJRNKG8T3RLnEEo3me6pbhLpxpSakeueFt28sqefCknzqtC9lJ
         H23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687778491; x=1690370491;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ndfuu4K/62Z1mfzAu2i/EV3jgAx+UABuEd2Nf19BUW4=;
        b=Ela8MFXHOJqZ8bJzY6Zus/dIb+KSVZXAGqXh/fKwiteupTcuJRuaUWJ6JWJaPBffvI
         1tLz47bN/6OXWzayawkKOByrhd3BLR0IuRIllP8a+TH1g8Az3ga6xkELIRfGpDCPi9Lu
         8JHZHE8rb1CTDlujui1BJYc3Bo7DK6yIoVWzqXsdxrPLoF8yLuO756hkw8bmnUehlB/V
         sNRbs79qLjsvdFXKM++/0k1jlCLeJir2+8dtuqRhmhi12c5rgO5F4JkfROWFYqrZmv9v
         qNH8R7K7hsNsHtAp6zM5a9pw7PqRdQZVyzEmpFXgIUYmLp9gAAnovpxB+qNHMUfYlfId
         e2CQ==
X-Gm-Message-State: AC+VfDyd9jf93YhAd3bUV++0bpLiLUjg+FmGH/JGj5VWYGtXE7DFxgcF
        S32Wp7hir8jZ4ehhlvZJqC0paQ==
X-Google-Smtp-Source: ACHHUZ5jjMSGqQWh0ZyXeLq9y5h1wTHubohcNdf3bOs+0UhnEHPd8HPrx+Z6epBGo0it/nrOaVktlA==
X-Received: by 2002:a19:ca02:0:b0:4f9:586b:dba1 with SMTP id a2-20020a19ca02000000b004f9586bdba1mr7603115lfg.4.1687778490946;
        Mon, 26 Jun 2023 04:21:30 -0700 (PDT)
Received: from [192.168.1.101] (abyk179.neoplus.adsl.tpnet.pl. [83.9.30.179])
        by smtp.gmail.com with ESMTPSA id q10-20020ac2528a000000b004f867f8d157sm1063570lfm.124.2023.06.26.04.21.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 04:21:30 -0700 (PDT)
Message-ID: <40e70fff-88dc-683e-0016-1a24389b75b8@linaro.org>
Date:   Mon, 26 Jun 2023 13:21:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 04/26] dt-bindings: clock: qcom,krait-cc: Krait core
 clock controller
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>
References: <20230625202547.174647-1-dmitry.baryshkov@linaro.org>
 <20230625202547.174647-5-dmitry.baryshkov@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230625202547.174647-5-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25.06.2023 22:25, Dmitry Baryshkov wrote:
> Define bindings for the Qualcomm Krait CPU and L2 clock controller. This
> device is used on old Qualcomm SoCs (APQ8064, MSM8960) and supports up
> to 4 core clocks and a separate L2 clock. Furthermore, L2 clock is
> represented as the interconnect to facilitate L2 frequency scaling
> together with scaling the CPU frequencies.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
Worth noting that there's no Krait cluster containing more than 4
cores and the last SoC using this uarch was released 10y ago, so
we can quite confidently say that the max cpu no won't change.

Konrad
>  include/dt-bindings/clock/qcom,krait-cc.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 include/dt-bindings/clock/qcom,krait-cc.h
> 
> diff --git a/include/dt-bindings/clock/qcom,krait-cc.h b/include/dt-bindings/clock/qcom,krait-cc.h
> new file mode 100644
> index 000000000000..ff69a0a968d8
> --- /dev/null
> +++ b/include/dt-bindings/clock/qcom,krait-cc.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (C) 2023 Linaro Ltd. All rights reserved.
> + */
> +
> +#ifndef __DT_BINDINGS_CLOCK_QCOM_KRAIT_CC_H
> +#define __DT_BINDINGS_CLOCK_QCOM_KRAIT_CC_H
> +
> +#define KRAIT_CPU_0		0
> +#define KRAIT_CPU_1		1
> +#define KRAIT_CPU_2		2
> +#define KRAIT_CPU_3		3
> +#define KRAIT_L2		4
> +
> +#define KRAIT_NUM_CLOCKS	5
> +
> +#endif
