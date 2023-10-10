Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3207C7C0493
	for <lists+linux-pm@lfdr.de>; Tue, 10 Oct 2023 21:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjJJT0x (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Oct 2023 15:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjJJT0w (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Oct 2023 15:26:52 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762F594
        for <linux-pm@vger.kernel.org>; Tue, 10 Oct 2023 12:26:46 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-504a7f9204eso7414945e87.3
        for <linux-pm@vger.kernel.org>; Tue, 10 Oct 2023 12:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696966005; x=1697570805; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M+6rfPIT5Qs4nYSzMA/UOS/nCpICENl2aTb8ca8T/Zc=;
        b=oszXq2R5PF4Sxmjfoec91fhXte2lRaPiyRiMvo3KuDlapP3Kdpa0dAEvuxPlN1ckB4
         azPDc7pk7Bz6V48ObIgnfNkxmpJPBI3LRQP5bruvcjRX5se/7TbYHagb0A2f8FV013Hd
         zm+bGO8wM9QJ6S62RjX9T3ShF9dbZAYivXGGdfZwwsArkk0TiWVuLUUtPihQgnXGqguu
         72ONN+bCadOA/eSZ4BnTCYCyqHMVrKKE2xjTzb9U46NgiKcghIFvAFVhugY9AoefME5H
         9CwVs9kVUbmNRlH/zpu1cpnMDpbUIwR+vzod6qCcTfzFQqi777nLFf2vV2DRnvglovqo
         bayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696966005; x=1697570805;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M+6rfPIT5Qs4nYSzMA/UOS/nCpICENl2aTb8ca8T/Zc=;
        b=ZLmIkrm919jjOV22rxRzR1ezAU3aw9Ls9rwvqhdMQRyqt4n8WHgG9GHRN5b4OBW39B
         sJBv/N9tRVuAiN2+aCVHZC8IFq8fkpDdLHUu0gRdo51ZdnZabjJzVv9yZmm8afxjhJmn
         WLXsmrG53he2dJj1m709dzdXfNG9VHRHjMhhqhGQe2/XyEwg/NniNYcfyUn4dhKsdv50
         jSao+EsxPBYzUIm38EV7ZFTC1ZYc60he0L3gFKo+cCFQCXZnmoh5FLX+wUXPcJrgvr2i
         yhTkC6xP59+o5OqpnJ+0oIpFnKz5lmiOxRmjGlzkjZKKKj1dD2Foo+5g5iRlzUMdF99Z
         L7cg==
X-Gm-Message-State: AOJu0YzIYDvjBEADUJ765qCclZKyuWHpNR2spb8BSatlYXWcnZ0s0Nep
        +NC7f6EpjPIE5VJygm+qj/VLVw==
X-Google-Smtp-Source: AGHT+IFF5XFoH7IUXUg0uaL+/UGO9fbuPocNcepcEnAF4sm6ZJjbyl2BcOi6WWoOG40yH+aowuLq5Q==
X-Received: by 2002:ac2:5f90:0:b0:505:6fcd:dc41 with SMTP id r16-20020ac25f90000000b005056fcddc41mr13709463lfe.43.1696966004612;
        Tue, 10 Oct 2023 12:26:44 -0700 (PDT)
Received: from [172.30.204.182] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id d4-20020ac24c84000000b0050567a8b36esm1927443lfl.251.2023.10.10.12.26.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 12:26:44 -0700 (PDT)
Message-ID: <017265ae-c9d5-4ea0-94eb-9090945cbc91@linaro.org>
Date:   Tue, 10 Oct 2023 21:26:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] cpufreq: qcom-nvmem: add support for IPQ8064
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Robert Marko <robimarko@gmail.com>, ilia.lin@kernel.org,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230930102218.229613-1-robimarko@gmail.com>
 <20230930102218.229613-3-robimarko@gmail.com>
 <5b57e0e0-490e-464d-bdc8-5823ad8da2d8@linaro.org>
 <65255add.df0a0220.ff2f9.021d@mx.google.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <65255add.df0a0220.ff2f9.021d@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 10/10/23 16:08, Christian Marangi wrote:
> On Tue, Oct 10, 2023 at 03:39:54PM +0200, Konrad Dybcio wrote:
>>
>>
>> On 9/30/23 12:21, Robert Marko wrote:
>>> From: Christian Marangi <ansuelsmth@gmail.com>
>>>
>>> IPQ8064 comes in 3 families:
>>> * IPQ8062 up to 1.0GHz
>>> * IPQ8064/IPQ8066/IPQ8068 up to 1.4GHz
>>> * IPQ8065/IPQ8069 up to 1.7Ghz
>>>
>>> So, in order to be able to support one OPP table, add support for
>>> IPQ8064 family based of SMEM SoC ID-s and correctly set the version so
>>> opp-supported-hw can be correctly used.
>>>
>>> Bit are set with the following logic:
>>> * IPQ8062 BIT 0
>>> * IPQ8064/IPQ8066/IPQ8068 BIT 1
>>> * IPQ8065/IPQ8069 BIT 2
>>>
>>> speed is never fused, only pvs values are fused.
>>>
>>> IPQ806x SoC doesn't have pvs_version so we drop and we use the new
>>> pattern:
>>> opp-microvolt-speed0-pvs<PSV_VALUE>
>>>
>>> Example:
>>> - for ipq8062 psv2
>>>     opp-microvolt-speed0-pvs2 = < 925000 878750 971250>
>>>
>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>>> Signed-off-by: Robert Marko <robimarko@gmail.com>
>>> ---
>> [...]
>>
>>> +{
>>> +	int speed = 0, pvs = 0, pvs_ver = 0;
>>> +	int msm_id, ret = 0;
>>> +	u8 *speedbin;
>>> +	size_t len;
>>> +
>>> +	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
>>> +
>>> +	if (IS_ERR(speedbin))
>> The stray newline above this line triggers my OCD :D
>>
>>> +		return PTR_ERR(speedbin);
>>> +
>>> +	if (len != 4) {
>>> +		dev_err(cpu_dev, "Unable to read nvmem data. Defaulting to 0!\n");
>>> +		kfree(speedbin);
>>> +		return -ENODEV;
>>> +	}
>>> +
>>> +	get_krait_bin_format_a(cpu_dev, &speed, &pvs, &pvs_ver, speedbin);
>>> +
>>> +	ret = qcom_smem_get_soc_id(&msm_id);
>>> +	if (ret)
>>> +		return ret;
>> speedbin leaks here
>>
>> you can free it right after the get_krait.. call
>>> +
>>> +	switch (msm_id) {
>>> +	case QCOM_ID_IPQ8062:
>>> +		drv->versions = BIT(IPQ8062_VERSION);
>>> +		break;
>>> +	case QCOM_ID_IPQ8064:
>>> +	case QCOM_ID_IPQ8066:
>>> +	case QCOM_ID_IPQ8068:
>>> +		drv->versions = BIT(IPQ8064_VERSION);
>>> +		break;
>>> +	case QCOM_ID_IPQ8065:
>>> +	case QCOM_ID_IPQ8069:
>>> +		drv->versions = BIT(IPQ8065_VERSION);
>>> +		break;
>>> +	default:
>>> +		dev_err(cpu_dev,
>>> +			"SoC ID %u is not part of IPQ8064 family, limiting to 1.0GHz!\n",
>>> +			msm_id);
>>> +		drv->versions = BIT(IPQ8062_VERSION);
>>> +		break;
>>> +	}
>>> +
>>> +	/* IPQ8064 speed is never fused. Only pvs values are fused. */
>>> +	snprintf(*pvs_name, sizeof("speedXX-pvsXX"), "speed%d-pvs%d",
>>> +		 speed, pvs);
>> Then drop the format for `speed` and just throw in a zero!
>>
>> [...]
>>
>>> -	{ .compatible = "qcom,ipq8064", .data = &match_data_krait },
>>> +	{ .compatible = "qcom,ipq8064", .data = &match_data_ipq8064 },
>> This change demands a Fixes tag, because you're essentially saying "the
>> support for this SoC was supposedly there, but it could have never worked
>> and was broken all along".
>>
> 
> Mhhh actually no. We are just changing the opp binding and introducing
> hardcoded versions. But the thing worked and actually it's what was used
> before this change in openwrt. Also current ipq806x dtsi doesn't have
> any opp definition so no regression there. (and also 99% downstream either
> use openwrt or use qcom sdk where this implementation is not used at
> all)
> 
> Given these thing should we still add a fixes tag referencing the commit
> that introduced the compatible for qcom,ipq8064? It's quite problematic
> as this depends on qcom_smem_get_soc_id().
Fixes only hints auto backports, you shouldn't be worried about putting 
fixes on commits that fix bugs.

I see this as a "didnt work" -> "works" commit, which in my eyes 
qualifies as a fix.

Konrad
