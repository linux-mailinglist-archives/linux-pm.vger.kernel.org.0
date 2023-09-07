Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107F679790B
	for <lists+linux-pm@lfdr.de>; Thu,  7 Sep 2023 19:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238853AbjIGRAx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Sep 2023 13:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238432AbjIGRA2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Sep 2023 13:00:28 -0400
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7AF213E
        for <linux-pm@vger.kernel.org>; Thu,  7 Sep 2023 09:59:56 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-52e828ad46bso1602131a12.1
        for <linux-pm@vger.kernel.org>; Thu, 07 Sep 2023 09:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694105633; x=1694710433; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n+7VyO9HJQgcCdV1oziXjEck+bwNvVutHKF259s+mUE=;
        b=Aci/pDVymjFhyjBFSdB6tZcgyeeKhvUCAPy0/A+mhnhD75+uDq3qnAAz/zfPKUTvC/
         HEXgrP0wMH47UM3xu3HUfllYShstN6U9NIsm4pdDGlI4TT+s8Jcxc4tw9qwXlNY5YUnI
         TsXTjc50Hdp+/C10ZidoQci6lSXhF3i+aq0QX0vmhXAe5uufVW2HdXEDg4Je0CsQFtOy
         58hOQxyh3c6oUYo/rNOnbg3oA2XmSv2ZZKuPRaa3ZCscVa2z/dE6R3G/mNgjLlPQgRQt
         NZ791NloZ5yMqzX+CktZN8Ii8Xv57X3y6kk2dhF+wTkFACkm284RBRH6XAVXWN1tI4eq
         zDYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694105633; x=1694710433;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n+7VyO9HJQgcCdV1oziXjEck+bwNvVutHKF259s+mUE=;
        b=AB6K9JEetENVi2d30ISQhw/3GBZFvj/lf26vDafWmqwu/Nax5lI0iEox8U2m0dL/ZU
         1hKXrypYjJrmJb2FEy+uIKpBrYn8TAr1PD92MVj8huFfL8OmIPWtS+UPE1ueRHIhFw4k
         30VV8hMzW8Xje28hsRpgjVRgNBCQ5uZy4wYKBX/xYgDbmVbWcrbCzRpu0KA32R72YjWe
         cBcapy2JuV+bfwv+GabwXrJ7bjO5Vw+6pTsqZhzJZ+yj6N7l9kZtP3Ciuj7Y8rqIhVpb
         46QXWzF1xd81z3su5bOJC/CfuooX075wfdrMBVtM+l2dTURpRlyRhxhy1uLWCPYa8NUS
         nnWw==
X-Gm-Message-State: AOJu0YzPbv2Ji2Qdedc1Y8PUtxF1bUASv85xeOvfEBfJ9Nr+HbnbSxKa
        Lbi0DgoroL7v35mSQ6TzeL4BhUgXLBPdYufLro3kTA==
X-Google-Smtp-Source: AGHT+IH+CwVwCl1iJM6DtJhr1qBDbMzFIn3otLkKPSG2M+l5DaLO/pmOhn61jKGup+8AtmrqTLUZag==
X-Received: by 2002:a19:7710:0:b0:500:bd75:77d1 with SMTP id s16-20020a197710000000b00500bd7577d1mr3079574lfc.63.1694075519864;
        Thu, 07 Sep 2023 01:31:59 -0700 (PDT)
Received: from [192.168.37.232] (178235177204.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.204])
        by smtp.gmail.com with ESMTPSA id a9-20020aa7d749000000b005257da6be23sm9555588eds.75.2023.09.07.01.31.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 01:31:59 -0700 (PDT)
Message-ID: <b0508a69-130d-4b05-9dfc-399e482dc2ae@linaro.org>
Date:   Thu, 7 Sep 2023 10:31:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/10] clk: qcom: apss-ipq6018: ipq5332: add safe
 source switch for a53pll
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>,
        ilia.lin@kernel.org, agross@kernel.org, andersson@kernel.org,
        rafael@kernel.org, viresh.kumar@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        quic_kathirav@quicinc.com, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <cover.1693996662.git.quic_varada@quicinc.com>
 <5e3c29df2b42cceb8072b00546a78e1b99b2d374.1693996662.git.quic_varada@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 xsFNBF9ALYUBEADWAhxdTBWrwAgDQQzc1O/bJ5O7b6cXYxwbBd9xKP7MICh5YA0DcCjJSOum
 BB/OmIWU6X+LZW6P88ZmHe+KeyABLMP5s1tJNK1j4ntT7mECcWZDzafPWF4F6m4WJOG27kTJ
 HGWdmtO+RvadOVi6CoUDqALsmfS3MUG5Pj2Ne9+0jRg4hEnB92AyF9rW2G3qisFcwPgvatt7
 TXD5E38mLyOPOUyXNj9XpDbt1hNwKQfiidmPh5e7VNAWRnW1iCMMoKqzM1Anzq7e5Afyeifz
 zRcQPLaqrPjnKqZGL2BKQSZDh6NkI5ZLRhhHQf61fkWcUpTp1oDC6jWVfT7hwRVIQLrrNj9G
 MpPzrlN4YuAqKeIer1FMt8cq64ifgTzxHzXsMcUdclzq2LTk2RXaPl6Jg/IXWqUClJHbamSk
 t1bfif3SnmhA6TiNvEpDKPiT3IDs42THU6ygslrBxyROQPWLI9IL1y8S6RtEh8H+NZQWZNzm
 UQ3imZirlPjxZtvz1BtnnBWS06e7x/UEAguj7VHCuymVgpl2Za17d1jj81YN5Rp5L9GXxkV1
 aUEwONM3eCI3qcYm5JNc5X+JthZOWsbIPSC1Rhxz3JmWIwP1udr5E3oNRe9u2LIEq+wH/toH
 kpPDhTeMkvt4KfE5m5ercid9+ZXAqoaYLUL4HCEw+HW0DXcKDwARAQABzShLb25yYWQgRHli
 Y2lvIDxrb25yYWQuZHliY2lvQGxpbmFyby5vcmc+wsGOBBMBCAA4FiEEU24if9oCL2zdAAQV
 R4cBcg5dfFgFAmQ5bqwCGwMFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQR4cBcg5dfFjO
 BQ//YQV6fkbqQCceYebGg6TiisWCy8LG77zV7DB0VMIWJv7Km7Sz0QQrHQVzhEr3trNenZrf
 yy+o2tQOF2biICzbLM8oyQPY8B///KJTWI2khoB8IJSJq3kNG68NjPg2vkP6CMltC/X3ohAo
 xL2UgwN5vj74QnlNneOjc0vGbtA7zURNhTz5P/YuTudCqcAbxJkbqZM4WymjQhe0XgwHLkiH
 5LHSZ31MRKp/+4Kqs4DTXMctc7vFhtUdmatAExDKw8oEz5NbskKbW+qHjW1XUcUIrxRr667V
 GWH6MkVceT9ZBrtLoSzMLYaQXvi3sSAup0qiJiBYszc/VOu3RbIpNLRcXN3KYuxdQAptacTE
 mA+5+4Y4DfC3rUSun+hWLDeac9z9jjHm5rE998OqZnOU9aztbd6zQG5VL6EKgsVXAZD4D3RP
 x1NaAjdA3MD06eyvbOWiA5NSzIcC8UIQvgx09xm7dThCuQYJR4Yxjd+9JPJHI6apzNZpDGvQ
 BBZzvwxV6L1CojUEpnilmMG1ZOTstktWpNzw3G2Gis0XihDUef0MWVsQYJAl0wfiv/0By+XK
 mm2zRR+l/dnzxnlbgJ5pO0imC2w0TVxLkAp0eo0LHw619finad2u6UPQAkZ4oj++iIGrJkt5
 Lkn2XgB+IW8ESflz6nDY3b5KQRF8Z6XLP0+IEdLOOARkOW7yEgorBgEEAZdVAQUBAQdAwmUx
 xrbSCx2ksDxz7rFFGX1KmTkdRtcgC6F3NfuNYkYDAQgHwsF2BBgBCAAgFiEEU24if9oCL2zd
 AAQVR4cBcg5dfFgFAmQ5bvICGwwACgkQR4cBcg5dfFju1Q//Xta1ShwL0MLSC1KL1lXGXeRM
 8arzfyiB5wJ9tb9U/nZvhhdfilEDLe0jKJY0RJErbdRHsalwQCrtq/1ewQpMpsRxXzAjgfRN
 jc4tgxRWmI+aVTzSRpywNahzZBT695hMz81cVZJoZzaV0KaMTlSnBkrviPz1nIGHYCHJxF9r
 cIu0GSIyUjZ/7xslxdvjpLth16H27JCWDzDqIQMtg61063gNyEyWgt1qRSaK14JIH/DoYRfn
 jfFQSC8bffFjat7BQGFz4ZpRavkMUFuDirn5Tf28oc5ebe2cIHp4/kajTx/7JOxWZ80U70mA
 cBgEeYSrYYnX+UJsSxpzLc/0sT1eRJDEhI4XIQM4ClIzpsCIN5HnVF76UQXh3a9zpwh3dk8i
 bhN/URmCOTH+LHNJYN/MxY8wuukq877DWB7k86pBs5IDLAXmW8v3gIDWyIcgYqb2v8QO2Mqx
 YMqL7UZxVLul4/JbllsQB8F/fNI8AfttmAQL9cwo6C8yDTXKdho920W4WUR9k8NT/OBqWSyk
 bGqMHex48FVZhexNPYOd58EY9/7mL5u0sJmo+jTeb4JBgIbFPJCFyng4HwbniWgQJZ1WqaUC
 nas9J77uICis2WH7N8Bs9jy0wQYezNzqS+FxoNXmDQg2jetX8en4bO2Di7Pmx0jXA4TOb9TM
 izWDgYvmBE8=
In-Reply-To: <5e3c29df2b42cceb8072b00546a78e1b99b2d374.1693996662.git.quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7.09.2023 07:21, Varadarajan Narayanan wrote:
> Stromer Plus PLL found on IPQ53xx doesn't support dynamic
> frequency scaling. To achieve the same, we need to park the APPS
> PLL source to GPLL0, re configure the PLL and then switch the
> source to APSS_PLL_EARLY.
> 
> To support this, register a clock notifier to get the PRE_RATE
> and POST_RATE notification. Change the APSS PLL source to GPLL0
> when PRE_RATE notification is received, then configure the PLL
> and then change back the source to APSS_PLL_EARLY.
> 
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  drivers/clk/qcom/apss-ipq6018.c | 54 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/qcom/apss-ipq6018.c b/drivers/clk/qcom/apss-ipq6018.c
> index 4e13a08..ffb6ab5 100644
> --- a/drivers/clk/qcom/apss-ipq6018.c
> +++ b/drivers/clk/qcom/apss-ipq6018.c
> @@ -9,8 +9,11 @@
>  #include <linux/clk-provider.h>
>  #include <linux/regmap.h>
>  #include <linux/module.h>
> +#include <linux/clk.h>
> +#include <linux/soc/qcom/smem.h>
>  
>  #include <dt-bindings/clock/qcom,apss-ipq.h>
> +#include <dt-bindings/arm/qcom,ids.h>
>  
>  #include "common.h"
>  #include "clk-regmap.h"
> @@ -84,15 +87,64 @@ static const struct qcom_cc_desc apss_ipq6018_desc = {
>  	.num_clks = ARRAY_SIZE(apss_ipq6018_clks),
>  };
>  
> +static int cpu_clk_notifier_fn(struct notifier_block *nb, unsigned long action,
> +				void *data)
> +{
> +	u8 index;
> +	int err;
> +
> +	if (action == PRE_RATE_CHANGE)
> +		index = P_GPLL0;
> +	else if (action == POST_RATE_CHANGE)
> +		index = P_APSS_PLL_EARLY;
> +	else
> +		return 0;
> +
> +	err = clk_rcg2_mux_closest_ops.set_parent(&apcs_alias0_clk_src.clkr.hw,
> +						  index);
Adding a variable for clk_hw within the apcs_alias0 clock would
make this easier to digest, I think.

And if we wanna be even less error-prone, you can reference the
ops of this clock in an indirect way.

> +
> +	return notifier_from_errno(err);
> +}
> +
> +static struct notifier_block cpu_clk_notifier = {
> +	.notifier_call = cpu_clk_notifier_fn,
> +};
> +
>  static int apss_ipq6018_probe(struct platform_device *pdev)
>  {
>  	struct regmap *regmap;
> +	u32 soc_id;
> +	int ret;
> +
> +	ret = qcom_smem_get_soc_id(&soc_id);
> +	if (ret)
> +		return ret;
>  
>  	regmap = dev_get_regmap(pdev->dev.parent, NULL);
>  	if (!regmap)
>  		return -ENODEV;
>  
> -	return qcom_cc_really_probe(pdev, &apss_ipq6018_desc, regmap);
> +	ret = qcom_cc_really_probe(pdev, &apss_ipq6018_desc, regmap);
> +	if (ret)
> +		return ret;
> +
> +	switch (soc_id) {
> +	/*
> +	 * Only below variants of IPQ53xx support scaling
> +	 */
1. /* Keep this in a 1-line comment */

2. why? explain the reasoning in the commit message

Konrad
> +	case QCOM_ID_IPQ5332:
> +	case QCOM_ID_IPQ5322:
> +	case QCOM_ID_IPQ5300:
> +		ret = clk_notifier_register(apcs_alias0_clk_src.clkr.hw.clk,
> +						&cpu_clk_notifier);
> +		if (ret)
> +			return ret;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
>  }
>  
>  static struct platform_driver apss_ipq6018_driver = {
