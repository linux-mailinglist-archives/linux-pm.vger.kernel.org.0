Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F75F671F05
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jan 2023 15:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjAROJQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Jan 2023 09:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjAROIp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Jan 2023 09:08:45 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D5A5A838
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 05:49:12 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id m21so49665368edc.3
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 05:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G30BJi2/lI3i/gPOom4F3etIxLNMJWHlp8bp3WOlmWA=;
        b=YvXgViN/NAqMsQFWPOTsr1Aam4UpXhknRuQKxUru7EMSvE4EwGcrIfa4YlX1AdqwcL
         NtJSbsPWe6WR5Sceo4y1cPe71XD5XhUL8Enr+ucm03z9yq7Da9ftWSL/wZzEgo7yoa4U
         5a3mtix87ZizPeA8C/RddrGH/I1z+gRvBn9nNyJ/AI28dvB5GvMkxlbgibDZq0c4I6il
         LjzAVgp7K8wX/eRHts6u2YRm5l/Vo7F7JsKKUC94Fgc7s7tI20fyFLm1IlynA7M2FFcl
         v6I3W3eutiixUE4qBk3J6GncY/BKV3zHFmyUL4KwQiNfOUn8gr2uhikraL/t+03fJvJu
         6/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G30BJi2/lI3i/gPOom4F3etIxLNMJWHlp8bp3WOlmWA=;
        b=GMfHxbwKGX9NaHa3/Uw+LTPBdd+qITfBYb6Vu1RDjfISGumKAKVbbhiiKp6odLgJOn
         HHxmbVQmNqbu5h7KjOn/sYdU4AjULHbKNPgwkUWfcMtLRYScCm1fTpgEaPcdb3a2oRzJ
         SdINqAu38m7jiXs6lX7AVjqW5uk+mQub0F38PHTj9yPt6pJw3ETscq15vQaCZYUQPvOG
         gqYWeJz9vbyTOHModR3/X1nEH7TXxNSm7jIANury8PWUYAfJntW7ioJsp8WKsTRlaBpr
         3ZjuBwEOO9qXl6OhqFOB+DMeUdPQpG6oHcjX+X/l5hR8mqWcMiM/HKgneAAUWkoqlJZF
         NzgQ==
X-Gm-Message-State: AFqh2kqo0bHgSFDQcWM/wRNL85A+A7OTpWsMsXaDWBjWWc5+WT+jiUyi
        0bTCXBygEqpncPxCg+yg+KoBiw==
X-Google-Smtp-Source: AMrXdXuPpwmJMkGYwMP82FgRokMShtyvMAoIHdPaU8gtPpT+cMCn5vv3cgeky//h6UQUe1sNphOzCQ==
X-Received: by 2002:a05:6402:5110:b0:492:846d:e86d with SMTP id m16-20020a056402511000b00492846de86dmr8661727edd.23.1674049751340;
        Wed, 18 Jan 2023 05:49:11 -0800 (PST)
Received: from [192.168.1.101] (abxh252.neoplus.adsl.tpnet.pl. [83.9.1.252])
        by smtp.gmail.com with ESMTPSA id d26-20020a056402401a00b0046c7c3755a7sm763716eda.17.2023.01.18.05.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 05:49:11 -0800 (PST)
Message-ID: <055aef46-2931-6985-ca7a-ef4ccd14ac21@linaro.org>
Date:   Wed, 18 Jan 2023 14:49:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 4/8] clk: qcom: smd-rpm: msm8936: Add PMIC gated
 RPM_SMD_XO_*
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, agross@kernel.org,
        andersson@kernel.org, djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        benl@squareup.com, shawn.guo@linaro.org, fabien.parent@linaro.org,
        leo.yan@linaro.org, dmitry.baryshkov@linaro.org
References: <20230117024846.1367794-1-bryan.odonoghue@linaro.org>
 <20230117024846.1367794-5-bryan.odonoghue@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230117024846.1367794-5-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 17.01.2023 03:48, Bryan O'Donoghue wrote:
> The XO crystal input is buffered through the PMIC and controlled by RPM.
> Create the relevant clock gate representation in the RPM clock definitions.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/clk/qcom/clk-smd-rpm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
> index 8f6e274c60301..6f23ca4828f44 100644
> --- a/drivers/clk/qcom/clk-smd-rpm.c
> +++ b/drivers/clk/qcom/clk-smd-rpm.c
> @@ -574,6 +574,8 @@ static const struct rpm_smd_clk_desc rpm_clk_msm8916 = {
>  };
>  
>  static struct clk_smd_rpm *msm8936_clks[] = {
> +	[RPM_SMD_XO_CLK_SRC]		= &clk_smd_rpm_branch_bi_tcxo,
> +	[RPM_SMD_XO_A_CLK_SRC]		= &clk_smd_rpm_branch_bi_tcxo_a,
>  	[RPM_SMD_PCNOC_CLK]		= &clk_smd_rpm_bus_0_pcnoc_clk,
>  	[RPM_SMD_PCNOC_A_CLK]		= &clk_smd_rpm_bus_0_pcnoc_a_clk,
>  	[RPM_SMD_SNOC_CLK]		= &clk_smd_rpm_bus_1_snoc_clk,
