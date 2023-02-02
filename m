Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06491687D24
	for <lists+linux-pm@lfdr.de>; Thu,  2 Feb 2023 13:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbjBBMVO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Feb 2023 07:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbjBBMVM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Feb 2023 07:21:12 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4F3719BD
        for <linux-pm@vger.kernel.org>; Thu,  2 Feb 2023 04:21:06 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id t18so1552295wro.1
        for <linux-pm@vger.kernel.org>; Thu, 02 Feb 2023 04:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SPQJ6bxHg/yelMtyF7kqC0ws4/k6rGCTtzA0YxWKka8=;
        b=dGE/ZV+mmvzUfSFNtck0wutpFejQZQM5REEwKPt7deJukEQxz5sVzVVtlgf7929oJJ
         DY5CIJleCkiCdzM3mb6WV91ojhS0ulw1XoA6tvw0Z56muhxJYSvPHlT47DIqAGBIALG2
         4R8xGdtOYG3cowQsa4i/NQgLB46uVe75vm3QYUB1Uo7sTrMpbjb00cyCb5rh1XhX1q8A
         tbWSlPqAftfjAbvAKW2NgMKU9OyBBuHtuLH7GLcH4CXJPUKsg9n12PsLYrnpcln31CDt
         8w8FrX8/CRNgN3ziEQLFA6soV1QCSovpFMOvWdCy4yNdGmG0DHpOx9R2XPtPC2G8/yYK
         DDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SPQJ6bxHg/yelMtyF7kqC0ws4/k6rGCTtzA0YxWKka8=;
        b=lgCzuD6QwdQwF6XqPC6hLWKmoQ5DQlEm8pSiw+X08bDUcSeFrewtau6ErirWJFMoqy
         sNvpbsmtKXr74wWNfsdtzI33ddR+0O33K62cyU32zPGT4GBMi9uWAFqvRX6PQvBxZen+
         XeSh+S3eKPWcXCleIly5SyEvOrC1c8H7DanYAgVB0J9LOE06oQv5VgNdl/fhreoXnnFj
         txCvDp/GvyYdkwsqSygRTjSewA4jdL5j+dXBdGMvrr27C92+MnYuoVXiBbchNjnWngn7
         wcHgm5ejamPjPf8t7sLQ14qLRUM0I3CI15SnyGwoN8GRId0EWBV6v4OqOQNH/R4i2do6
         jHuA==
X-Gm-Message-State: AO0yUKVFkZVKUxsKVy+tYJjAir4+h8UWTY2Rw1wC/vlP0t2svs52/Ec1
        Pb85hd1hozk0ZpsimLdVrQVIjg==
X-Google-Smtp-Source: AK7set/gb819HqwrsQ+nb2WO/IlwO/ioEW4xbTc3kBA6UN9EqdAdsUSQJwhNOL6uVdkStYU80Yn9Dw==
X-Received: by 2002:adf:d1cc:0:b0:2bf:9465:641 with SMTP id b12-20020adfd1cc000000b002bf94650641mr6616710wrd.65.1675340465539;
        Thu, 02 Feb 2023 04:21:05 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h1-20020adfe981000000b002bfb02153d1sm22303218wrm.45.2023.02.02.04.21.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 04:21:05 -0800 (PST)
Message-ID: <d3bdbf47-3efd-4933-2364-c0c3a9e94cc4@linaro.org>
Date:   Thu, 2 Feb 2023 13:21:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 17/23] memory: tegra: fix interconnect registration race
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>
References: <20230201101559.15529-1-johan+linaro@kernel.org>
 <20230201101559.15529-18-johan+linaro@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230201101559.15529-18-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01/02/2023 11:15, Johan Hovold wrote:
> The current interconnect provider registration interface is inherently
> racy as nodes are not added until the after adding the provider. This
> can specifically cause racing DT lookups to fail.
> 
> Switch to using the new API where the provider is not registered until
> after it has been fully initialised.
> 
> Fixes: 06f079816d4c ("memory: tegra-mc: Add interconnect framework")
> Cc: stable@vger.kernel.org      # 5.11
> Cc: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

(or tell me if I should take it via memory-controllers)

Best regards,
Krzysztof

