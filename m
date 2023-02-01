Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F42A6864A6
	for <lists+linux-pm@lfdr.de>; Wed,  1 Feb 2023 11:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbjBAKqa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Feb 2023 05:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjBAKqa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Feb 2023 05:46:30 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0A440E1;
        Wed,  1 Feb 2023 02:46:29 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id e6so9806684plg.12;
        Wed, 01 Feb 2023 02:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AUIDXs9pFeYpg0JJL8STfbB3nM1CcCUhwisXrhJfAAM=;
        b=l8WNEQ9SvYdyZQRAjfm5ablK3/zs4fuOHehguRkSkPQFTErQbOdaF3orWDwzhXNZ7k
         xVgDKuAnHEJZma73Oj0ME2D2yKsRfJTiBl8uU87GgpbYEAKxGWx2vwQWd3oBMOQ3GmaZ
         l0RutbLAcEFrt/5yigdM0NTq2zVklxU+xJ2Oda/TcDsscsKcih65OzsOR0+ecn7zwZyJ
         GMj727581SM7ERTRmgmtMRikN9pxzMRx7N1MZLhYsfg/zCE9QgCbwfJmNupF05NV/spP
         gBqwO3v+s8iMfAkvP8ycX5rh6mNBvHwSUBMMQXF7+HQouJ6BWvf0DRyMcJIh40cEEULL
         Dq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AUIDXs9pFeYpg0JJL8STfbB3nM1CcCUhwisXrhJfAAM=;
        b=Gy/GR+CJoyHamumeCb2nbypskHheZpO2kn4YjbOR97PN4/Q9gEDIHvzSbOodm8au65
         iaj62rviPnC6Sva/G7GMLh0EOTm08Qvz4qnkoz4QJmtGuzA90i8f7Dp/aOkuYXWKznSY
         PpnAITjVgsQUulCwJQnl39672yMSXaXyo332w2sl21Z6/viE04fUxE/s2dAuGiy7eMsb
         zLhFdpDebOI3kHs5jKZPAKguo5MSQQo0oAeSn4T2ET/w1rEDQpwERcWNwnDj6BzGxzJz
         kwkAPQ7Yh2JFn83LXvgePM/4cJwJr1a+5JS2BCJ6VSUEdpcQDM8/ggd6x37UHDrZSXb8
         6p7A==
X-Gm-Message-State: AO0yUKXfZkIw2RmbEmUv70sxd2nPe8nHDzT4CvCED9VV0+/xsJfERegU
        gvXSiTi2ZpXCI7BB/TfKGlg9a0sfRgJeZQ==
X-Google-Smtp-Source: AK7set/zh0nW9LMqP9zql8cFuqWvXMtng3dDc+aZmg4qrmFTMIs9ZtUBAbQuoTLao22Hf1JxYAHFVw==
X-Received: by 2002:a17:902:db05:b0:192:aecb:232b with SMTP id m5-20020a170902db0500b00192aecb232bmr2682092plx.18.1675248388482;
        Wed, 01 Feb 2023 02:46:28 -0800 (PST)
Received: from [172.30.1.94] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id x17-20020a170902821100b001963c423400sm11393855pln.240.2023.02.01.02.46.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 02:46:28 -0800 (PST)
Message-ID: <c8f09693-75b9-1266-6133-f31e7bfbb4cf@gmail.com>
Date:   Wed, 1 Feb 2023 19:46:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: Add Qualcomm CCI
 dt-bindings
Content-Language: en-US
To:     Jun Nie <jun.nie@linaro.org>, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, cw00.choi@samsung.com
Cc:     bryan.odonoghue@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20230201080227.473547-1-jun.nie@linaro.org>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20230201080227.473547-1-jun.nie@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

In order to track the changes of dt-binding, 
please add the info as following:

diff --git a/MAINTAINERS b/MAINTAINERS
index 7f86d02cb427..e13e61218987 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6047,6 +6047,7 @@ S:        Maintained
 T:     git git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git
 F:     Documentation/devicetree/bindings/devfreq/
 F:     Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
+F:     Documentation/devicetree/bindings/interconnect/qcom,cci.yam
 F:     drivers/devfreq/
 F:     include/linux/devfreq.h
 F:     include/trace/events/devfreq.h


On 23. 2. 1. 17:02, Jun Nie wrote:
> Add devicetree binding of Qualcomm CCI on MSM8939.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  .../bindings/interconnect/qcom,cci.yaml       | 81 +++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,cci.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,cci.yaml b/Documentation/devicetree/bindings/interconnect/qcom,cci.yaml
> new file mode 100644
> index 000000000000..100c440ba220
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,cci.yaml
> @@ -0,0 +1,81 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interconnect/mediatek,cci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Cache Coherent Interconnect (CCI) frequency and voltage scaling
> +
> +maintainers:
> +  - Jun Nie <jun.nie@linaro.org>
> +
> +description: |
> +  Qualcomm Cache Coherent Interconnect (CCI) is a hardware engine used by
> +  MSM8939. The driver is to scale its frequency and adjust the voltage in
> +  hardware accordingly. The voltage provider is modeled as power domain on
> +  MSM8939, so power domain dts node is required.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,msm8939-cci
> +
> +  clocks:
> +    maxItems: 1
> +
> +  operating-points-v2: true
> +  opp-table:
> +    type: object
> +
> +required:
> +  - compatible
> +  - clocks
> +  - operating-points-v2
> +  - nvmem-cells
> +  - power-domains
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    cci: cci {
> +        compatible = "qcom,msm8939-cci";
> +	clocks = <&apcs2>;
> +	operating-points-v2 = <&cci_opp_table>;
> +	power-domains = <&cpr>;
> +	nvmem-cells = <&cpr_efuse_speedbin_pvs>;
> +    };
> +
> +    cci_opp_table: cci-opp-table {
> +	compatible = "operating-points-v2";
> +
> +	cci_opp1: opp-200000000 {
> +	       opp-hz = /bits/ 64 <200000000>;
> +	       opp-supported-hw = <0x3f>;
> +	       required-opps = <&cpr_opp3>;
> +	};
> +
> +	cci_opp2: opp-297600000 {
> +	       opp-hz = /bits/ 64 <297600000>;
> +	       opp-supported-hw = <0x3f>;
> +	       required-opps = <&cpr_opp12>;
> +	};
> +
> +	cci_opp3: opp-400000000 {
> +	       opp-hz = /bits/ 64 <400000000>;
> +	       opp-supported-hw = <0x1>;
> +	       required-opps = <&cpr_opp14>;
> +	};
> +
> +	cci_opp4: opp-400000000 {
> +	       opp-hz = /bits/ 64 <400000000>;
> +	       opp-supported-hw = <0x3e>;
> +	       required-opps = <&cpr_opp15>;
> +	};
> +
> +	cci_opp5: opp-595200000 {
> +	       opp-hz = /bits/ 64 <595200000>;
> +	       opp-supported-hw = <0x3f>;
> +	       required-opps = <&cpr_opp17>;
> +	};
> +    };

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

