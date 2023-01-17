Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2AE866DEC0
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jan 2023 14:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237110AbjAQN1z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Jan 2023 08:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237028AbjAQN1w (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Jan 2023 08:27:52 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADD134C3A
        for <linux-pm@vger.kernel.org>; Tue, 17 Jan 2023 05:27:43 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id t5so26160259wrq.1
        for <linux-pm@vger.kernel.org>; Tue, 17 Jan 2023 05:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6chbDUAuHrxUbyVKpBcJKvsN+p8spnGiUQXBBl49CM0=;
        b=lwrFZMushhl6VyR6KAim71kMlSB2mtd68Z213EX19/RS3IGtebQCN7cj6KbBcMoiGq
         MfLeF6q0KO4kJ68dHlc3fwAyr3ChcvikGnrYZms95UgoZUdsVx85pM05hyx59k1NyaCE
         1PZadMzwdAXxzrko94vP3TpUAtAdRbXV7ry81UgPrOY+854PLIvkS51T0vMKcUIRuM55
         j9Foc7/Lo0xJ3xfee128G77SqqLUCQGsCKH/rcszF/4U4M4LeAlN41qEVL43r9dQZg2b
         P0wCcVu1NPzS7UeIQGqhDOpBJKiEn3mVrEm/14GtfNBs7Tg4yxe30oFDaJzXbffYwWRo
         SrXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6chbDUAuHrxUbyVKpBcJKvsN+p8spnGiUQXBBl49CM0=;
        b=j1rftz+m32nc89m63gQZ45i/1he2D5ZTYgaLUdjBipvFMh24IdrWrVBhlEF8otJNfx
         QxjWTbMPVuzqqIiui5N0+EWHzo0OpwfRy6fmO0p4xCLnzANEa5V9T3W1yQElEu2IPV66
         VPFq+ypg5TypA8FVOYWC3Njgm5mOQSKLq1VyE59rkpwC5xy7mBlf93HP+OZaTmO6wRPD
         FrccFk3ib3UYVxf3uMAar0lFXa6U5bkHNBNVoCXfCm+bcnYcLFOaiXanB6KVMQb3B081
         j+1lx+oxoK7WEuZy79FCGygIy3KQi9YA3AVEngJ7t8ZmZ+aP/DGS21TWlRBR04bG6nYb
         UgHg==
X-Gm-Message-State: AFqh2kq3V+LPtouvp1n6Y8y0yri0859Y8ITVKjbX99pUAuxvQBGyO9Pm
        jQgSNE97a7lQ2n5kRT266FX4fQ==
X-Google-Smtp-Source: AMrXdXt1+b/CIvboEcZBQEiOd8pl+O7FRMLXPmtVHXgGhIwzvNcEhDa+mhO4/1zH/z4fC2zV8bzQBA==
X-Received: by 2002:a5d:6910:0:b0:242:63e5:2451 with SMTP id t16-20020a5d6910000000b0024263e52451mr9715680wru.71.1673962062050;
        Tue, 17 Jan 2023 05:27:42 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id k18-20020adfb352000000b00241fab5a296sm29474388wrd.40.2023.01.17.05.27.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 05:27:41 -0800 (PST)
Message-ID: <6e35de82-e539-35c1-fcb1-10c02af9bb8c@linaro.org>
Date:   Tue, 17 Jan 2023 13:27:40 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 8/9] interconnect: qcom: rpm: Add a way to always set
 QoS registers
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Georgi Djakov <djakov@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230116132152.405535-1-konrad.dybcio@linaro.org>
 <20230116132152.405535-9-konrad.dybcio@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230116132152.405535-9-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 16/01/2023 13:21, Konrad Dybcio wrote:
> On newer SoCs (there's no clear boundary, but probably "new enough"
> means every interconnect provider is either BIMC or QNoC and there
> are no old-style NoC hosts) we're expected to set QoS registers
> regardless of the ap_owned param. Add a bool in the qcom_icc_provider
> and make the logic assume it's okay to set the registers when it's
> set.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/interconnect/qcom/icc-rpm.c | 2 +-
>   drivers/interconnect/qcom/icc-rpm.h | 2 ++
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
> index 509cadf398e9..343e6021a93a 100644

On next-20230116,

git am < 
~/Downloads/v3-1-9-interconnect-qcom-rpm-make-QoS-INVALID-default-separate-out-driver-data.patch
Applying: interconnect: qcom: rpm: make QoS INVALID default, separate 
out driver data
Applying: interconnect: qcom: rpm: Add support for specifying channel num
Applying: interconnect: qcom: rpm: Rename icc desc clocks to bus_blocks
Applying: interconnect: qcom: rpm: Add a way to always set QoS registers

error: patch failed: drivers/interconnect/qcom/icc-rpm.c:243
error: drivers/interconnect/qcom/icc-rpm.c: patch does not apply
error: patch failed: drivers/interconnect/qcom/icc-rpm.h:28
error: drivers/interconnect/qcom/icc-rpm.h: patch does not apply
Patch failed at 0004 interconnect: qcom: rpm: Add a way to always set 
QoS registers
hint: Use 'git am --show-current-patch=diff' to see the failed patch

Should I pick up another series from elsewhere to apply this ?

---
bod
