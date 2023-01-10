Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E439664FFD
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jan 2023 00:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbjAJXhB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Jan 2023 18:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234948AbjAJXhA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jan 2023 18:37:00 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AD93FA18
        for <linux-pm@vger.kernel.org>; Tue, 10 Jan 2023 15:36:58 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id t5so8972747wrq.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Jan 2023 15:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fxOjkVkboXRnISG7GaZo9vjhTrmTTUvqEXeMahatA7M=;
        b=WjR2YnPJqFFObwyC0JtfVB5IfTk7/pOBxZoJx3koapx+PjfwufQCb/S8O89Ts8nHej
         Z4jpnzoSjcV5USy/jnGO9utG98Hpc4tieOC+9LfAgzr4MtWXUUSrCOEQVG0jCCiChnn+
         C9b9i8nVxRzHe76M9+HaZLOOUfmrqJido/mTt8roLyMIk0r+MQCSyQ3DkgwlEKPKFXPu
         Gp/66WAU1048EX7Q7TE/S/yTScJxMnNJg8rxSKNS1yXBg6xtTWrRytzZmdji3NHww8Nu
         jA6uf31OGyfHb+k9oKakjOu7eaSAsvVZWX/+euRLQn7g5iJVIuw3VcZyH5HTLbwf4UHX
         sTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fxOjkVkboXRnISG7GaZo9vjhTrmTTUvqEXeMahatA7M=;
        b=JMNDhhcA6Pa0wXlV5C45Jk+GiHJV6jtQ0XsQCSqpkHb1aNtbLzLltnbFp91Nr6qhT3
         QYW3KNiuhAhnnetAjT5FjaOt/941jA6DudCC5FHqhBYfe6JBHdbCmq1N2Il5M5JYvdpF
         sdJDAIFZcnfjVXH3Tq03690nJ8W0vier36swzAzTYs9Kme68toqLJe4SZF39N4IcJbyj
         eeroFwsQp2uqzXvXl9//4WnkW9Ii751D455gSh+5+WbAml7eCUEu/aN9pTKrCsfXqti8
         lR4kL88JCuSXkSgRDNqldLegjQWtAoESLFWAKkXG6s+UPaecTglOpwP2X+HDGhGAE7TJ
         0HzQ==
X-Gm-Message-State: AFqh2krKW7aXUmKvaR69g7ADtY76xQOfXQp397fDTHxmKBiKOlDXgJJg
        zfmlzhDXg/Jiu9Fu/nxykb69QA==
X-Google-Smtp-Source: AMrXdXv+YWValqJb6tVXeuld6jcHpgsCyBCn4r8Fp8XunPfyWjoD2u8VSVdiWKodErTXk7y5vAPqhA==
X-Received: by 2002:adf:a4de:0:b0:2a9:89e:2b53 with SMTP id h30-20020adfa4de000000b002a9089e2b53mr15529548wrb.45.1673393817487;
        Tue, 10 Jan 2023 15:36:57 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id t14-20020adfeb8e000000b002baa780f0fasm12191553wrn.111.2023.01.10.15.36.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 15:36:56 -0800 (PST)
Message-ID: <49f02945-0f37-b046-dae7-417ab0148bff@linaro.org>
Date:   Tue, 10 Jan 2023 23:36:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 03/10] interconnect: qcom: rpm: Always set QoS params
 on QNoC
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Georgi Djakov <djakov@kernel.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230110132202.956619-1-konrad.dybcio@linaro.org>
 <20230110132202.956619-4-konrad.dybcio@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230110132202.956619-4-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/01/2023 13:21, Konrad Dybcio wrote:
> On newer SoCs, QoS parameters and RPM bandwidth requests are wholly
> separate. Setting one should only depend on the description of the
> interconnect node and not whether the other is present. If we don't
> vote through RPM, QoS parameters should be set regardless, as we're
> requesting additional bandwidth by setting the interconnect clock
> rates.
> 
> With NoC (the old-SoC bus type), this is not the case and they are
> mutually exclusive (so, the current upstream logic is correct).
> 
> For BIMC however, newer SoCs expect QoS params to be always set
> (like QNoC) whereas older ones (like MSM8998) hang up completely when
> doing so, hence this will be addressed in the next commit.
> 
> The Fixes tag references the commit in which this logic was added, it
> has since been shuffled around to a different file, but it's the one
> where it originates from.
> 
> Fixes: f80a1d414328 ("interconnect: qcom: Add SDM660 interconnect provider driver")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/interconnect/qcom/icc-rpm.c | 20 ++++++++++++++++----
>   1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
> index cd1eab3d93ba..0516b74abdc7 100644
> --- a/drivers/interconnect/qcom/icc-rpm.c
> +++ b/drivers/interconnect/qcom/icc-rpm.c
> @@ -246,15 +246,27 @@ static int qcom_icc_rpm_set(int mas_rpm_id, int slv_rpm_id, u64 sum_bw)
>   static int __qcom_icc_set(struct icc_node *n, struct qcom_icc_node *qn,
>   			  u64 sum_bw)
>   {
> +	struct qcom_icc_provider *qp = to_qcom_provider(n->provider);
> +	bool vote_ap, vote_rpm;
>   	int ret;
>   
> -	if (!qn->qos.ap_owned) {
> -		/* send bandwidth request message to the RPM processor */
> +	if (qp->type == QCOM_ICC_QNOC) {
> +		vote_ap = true;
> +		vote_rpm = true;
> +	} else {
> +		vote_ap = qn->qos.ap_owned;
> +		vote_rpm = !vote_ap;
> +	}
> +
> +	if (vote_rpm) {
> +		/* Send bandwidth request message to the RPM processor */
>   		ret = qcom_icc_rpm_set(qn->mas_rpm_id, qn->slv_rpm_id, sum_bw);
>   		if (ret)
>   			return ret;
> -	} else if (qn->qos.qos_mode != -1) {
> -		/* set bandwidth directly from the AP */
> +	}
> +
> +	if (vote_ap && qn->qos.qos_mode != NOC_QOS_MODE_INVALID) {
> +		/* Set QoS params from the AP */
>   		ret = qcom_icc_qos_set(n, sum_bw);
>   		if (ret)
>   			return ret;

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
