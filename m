Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E611B595653
	for <lists+linux-pm@lfdr.de>; Tue, 16 Aug 2022 11:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbiHPJaT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Aug 2022 05:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbiHPJ3s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Aug 2022 05:29:48 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DD8113DDB
        for <linux-pm@vger.kernel.org>; Tue, 16 Aug 2022 00:49:46 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id by6so9831753ljb.11
        for <linux-pm@vger.kernel.org>; Tue, 16 Aug 2022 00:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=fWI5Vz3NEJENJRZgoHcLtgrcNY1EYtwbH+VSOPvp12g=;
        b=hcP6Yo679+KGkm7iKjYV4Vr2yzJpgGvZSXpatLMfra8Yd8ATOpGxxOJ63puZ7NNo/g
         GRiWIjHa6+stNgvPhNSaM3LPpOrMHmCuYlbm1vOUt+flHbBeVzTg+KStGFRdadBTiVEh
         jjMvPRn3fd53gkXZrkMttsiqdSJkfdE/v7kehmo3VVkKfXlvXAbkQ45vWFp0gHQeCDpB
         NukIWYd+SC5ik+hx3hDeaQaDFkTAqNFOXitHpvvA9a50oI2w7eyocv8mMnAciMHdl98c
         vHJK52El4kJ8ZDTlLlYSgW1uCbD5nFfvCGtMVND3zdtnx+ExpKMZlw+uTdvowPsaNH/w
         c3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=fWI5Vz3NEJENJRZgoHcLtgrcNY1EYtwbH+VSOPvp12g=;
        b=DN/F0JDQ3CYVk1Gur2hKaA0w+8hKTVJK/XlsdqWTXarN7/LuAHbdv+jC4FSCgVBBsk
         W8WFGY5dRjUYaPIHolip1KVXwrBJHLEPHJBkPiHQzKyU8dA8v/+Z8mqYJzsAwPHIp6d7
         L0jPT6mAdCrcLSMNpysm1Xh+iFAOR4Qtg2aaD76OiqvuHBvarOOKr70SXMH9Y4gGb+cD
         XShMsWJWseBxro5qXGwN2ESkh2/ZH+rlf4EHYS42u6myj8Rh0E6zTstSQUPYK0mPWm0S
         k1fNSgDRwzjtVbWmruMVedx+hHm9DSPO5snti5SkybyMjD74OC9Wp5821V7caiKGCmNe
         ac3A==
X-Gm-Message-State: ACgBeo3F8LhsHsbcPobvhN9F5gQryqWwr5ZyiUse1WoAI9V0LiW8WMvt
        f3USMytkvjTJKdQl0eH7Vaqrug==
X-Google-Smtp-Source: AA6agR7mpZwwb6aHmQDli3b3DRF0poXvShKgozZp5CGt2ZC03JxidPRufilBX+BbZyB3ZJK9CAL67g==
X-Received: by 2002:a2e:504:0:b0:25e:4599:4eef with SMTP id 4-20020a2e0504000000b0025e45994eefmr5958922ljf.288.1660636185863;
        Tue, 16 Aug 2022 00:49:45 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:1782:dd68:b0c1:c1a4? (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id c1-20020a056512324100b0047255d211b2sm1303086lfr.225.2022.08.16.00.49.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 00:49:45 -0700 (PDT)
Message-ID: <4834ec0e-79fb-43b9-bfc0-8bc42646a4d3@linaro.org>
Date:   Tue, 16 Aug 2022 10:49:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 5/7] dt-bindings: arm-smmu: Add compatible for Qualcomm
 SM6115
Content-Language: en-US
To:     Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Emma Anholt <emma@anholt.net>,
        Rob Clark <robdclark@chromium.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20220815100952.23795-1-a39.skl@gmail.com>
 <20220815100952.23795-6-a39.skl@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220815100952.23795-6-a39.skl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15/08/2022 13:09, Adam Skladowski wrote:
> Add compatible for the Qualcomm SM6115 platform to the ARM SMMU
> DeviceTree binding.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
