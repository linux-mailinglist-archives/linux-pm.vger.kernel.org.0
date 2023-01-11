Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7EC6659B1
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jan 2023 12:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjAKLFj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Jan 2023 06:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbjAKLFe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Jan 2023 06:05:34 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9888E2653
        for <linux-pm@vger.kernel.org>; Wed, 11 Jan 2023 03:05:31 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id g10so10829438wmo.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Jan 2023 03:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nI6TmedA3bBtWw0iWBdVWzklstq2fzCdNWRkOyK90aM=;
        b=MIbPMoDFQpXJnkYpst7gbyXfRCptyzZ1QJ+xcxilEfba6xL2gWM0D23DCFFT3iR0QA
         9TQIxqeD30/Yi/W7e963uP+SByqqpsZsWRJe3xogcCKpXBEq06CaKAfS24/gRPcg3X42
         6cldBLgnbCuuHCmcgRN4ZkphRuZ1o5tCe9wkareuBQLJDju8erivKQF9c2zbw4r6Q+cp
         L745uO4dTa97V6AFhoKHx1SFl2k03N/NIwJOTTmV3jWHAjiMaYlruCwxpjkBvp22LiPO
         bHsCd2a2pLpLWGL7Z+NW0YrfhicqQ3a9MFZHsepY+V4onmQ2HryUVIft3LEnhK0CaGfa
         WTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nI6TmedA3bBtWw0iWBdVWzklstq2fzCdNWRkOyK90aM=;
        b=I4Wf+jAKrJoDCV84EraBOTvvtopHIQifB7qI3k92umc2vWrXKHLdK+Zsox5T5PjRfr
         cpmnl8vJ9UOvx1KrHz7d+ro5P7TuS+ffdaDkzyOrnWv9pv3UDsJAoZgTzJmEBeJTyjXv
         sqoide8K63FwZ5v6trV/ISqrIJ/otuDVuFwk4DNrZJWBN9PSl1/hruaR1ocPRoMCfZu8
         f1QJ4bb19DY7zchSIAFka1qpBS4pFqFFCKxIFylPEtnaF1BGb/3RkLZlAFDgJP16JgvM
         61YSvmjD9x6Zx4lQutQRxtwZOa7XS46G8KNjJcjPaCTjubNGEQOPLCj/Bd7nZ00yevpF
         RGMA==
X-Gm-Message-State: AFqh2krMV0K6e0hHFAVAMb3fFlt97DgIFbvHwNZYcLL6tTeiHFe/nS9b
        FcghsxVI2zGAxa+HGzTwnGHYyw==
X-Google-Smtp-Source: AMrXdXv+xpJ6Z4H9tDgiAiZbtZVebAraSoT8X3gbLtj/4gT1G1FXxsn1P9IKLHr5xB0QwDCzweVlYA==
X-Received: by 2002:a05:600c:1911:b0:3d9:8635:a916 with SMTP id j17-20020a05600c191100b003d98635a916mr49031679wmq.9.1673435130098;
        Wed, 11 Jan 2023 03:05:30 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id x7-20020a05600c188700b003c701c12a17sm21353305wmp.12.2023.01.11.03.05.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 03:05:29 -0800 (PST)
Message-ID: <5d8cb46a-e2bc-a066-ecf4-9daaba33b6ec@linaro.org>
Date:   Wed, 11 Jan 2023 11:05:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 06/10] interconnect: qcom: rpm: Rename icc desc clocks
 to bus_blocks
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Georgi Djakov <djakov@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230110132202.956619-1-konrad.dybcio@linaro.org>
 <20230110132202.956619-7-konrad.dybcio@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230110132202.956619-7-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/01/2023 13:21, Konrad Dybcio wrote:
> Rename the "clocks" (and _names) fields of qcom_icc_desc to
> "bus_clocks" in preparation for introducing handling of clocks that
> need to be enabled but not voted on with aggregate frequency.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

I'd like to further review the clock changes you need to rebase onto 
linux-next

Applying: interconnect: qcom: rpm: Rename icc provider num_clocks to 
num_bus_clocks
error: patch failed: drivers/interconnect/qcom/icc-rpm.h:23
error: drivers/interconnect/qcom/icc-rpm.h: patch does not apply
Patch failed at 0004 interconnect: qcom: rpm: Rename icc provider 
num_clocks to num_bus_clocks
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

---
bod
