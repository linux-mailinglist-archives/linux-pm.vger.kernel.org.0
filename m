Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9727C8974
	for <lists+linux-pm@lfdr.de>; Fri, 13 Oct 2023 18:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjJMP7o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Oct 2023 11:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbjJMP7Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Oct 2023 11:59:25 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E0E101
        for <linux-pm@vger.kernel.org>; Fri, 13 Oct 2023 08:59:18 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40675f06f1fso21874285e9.1
        for <linux-pm@vger.kernel.org>; Fri, 13 Oct 2023 08:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697212757; x=1697817557; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YxW+eJtcnC0E0SJpXFcLjjbQKwvukxtZrwKx+nQrH3k=;
        b=zNmY2jAvrN0XlBf4GAjyiyOm+GbF39VAjmGmyN2seNrSXCdP/OaibwuyYwzAhQs5li
         TbL/L1gO+j8p34+qNDH8ea5O6uHsfflTQXxXAC0Hf8EEJuZUcbhsekW+b/zay6APGCOz
         9wN1Tx7XaqRY8ZlmNoxPxhL52NilHszOIy7Fyvf3GGQzHDjOE1x7EwFSLRsFVS4SvlPA
         NYeVkvebRfNJdEGUwXjPzNWYBe9N15sBuFckce/0nb9z0FG3Yd5PVPwjPofn1M1P4wZP
         44PlgyuucrXgHKGej2W91XtM3BJtLgZvr9XLESehDo3O986zuGnNS+xajFjZ2ySXnZlo
         0CtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697212757; x=1697817557;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YxW+eJtcnC0E0SJpXFcLjjbQKwvukxtZrwKx+nQrH3k=;
        b=SZo/ZJUNjhbkb272SkDQvxu6YIPWNazbft+ctPIh0PbV2t0TEOPm18PW7CGY9OV5B4
         srtOVciCaEoa2veqITaZH+hKpFBtLhgrKXeKYkZmlc28DnFs3peowM40v2oqrrAsHLn6
         O8trGPEy+q2iUadpHeXDhH0w7L2ynzWMTTU+HiR5Gb7/pxt6RoFFlmUaSPmn286DBAYM
         mKBU624aI2MioaN2EDIL2Id8Y3CK27SQpoUjRl0viKR81R1ImZeOHMHnd/aAqS37Wqtc
         XdSu94QU/dPS9ONtMbIuhhSVaU0RN0WB+s6gBL6K5zDqGUCDshRwZPm5lx2jGwsqysXW
         VtAg==
X-Gm-Message-State: AOJu0YxlkVacdVAVfA9tIwBcaw+/EcVLbFrhMfiMuaOPF6wkxY+4RPyZ
        iZWYpzqt3Ko1gQeNL4y2mYV/zQ==
X-Google-Smtp-Source: AGHT+IECqTwQVm4ULj3UM8Bat5aO219Wvjuq7wSOK2sIHlyPCLUn51JLF1j/zKPnu6q6ak+kSLtdVg==
X-Received: by 2002:a05:600c:5198:b0:401:c7ec:b930 with SMTP id fa24-20020a05600c519800b00401c7ecb930mr470965wmb.10.1697212757331;
        Fri, 13 Oct 2023 08:59:17 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id m39-20020a05600c3b2700b003fee567235bsm529436wms.1.2023.10.13.08.59.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 08:59:17 -0700 (PDT)
Message-ID: <076c0672-8656-4af2-9960-7c31589d8794@linaro.org>
Date:   Fri, 13 Oct 2023 17:59:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/13] dt-bindings: thermal: tegra: Add
 nvidia,thermal-zones property
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Jon Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20231012175836.3408077-1-thierry.reding@gmail.com>
 <20231012175836.3408077-4-thierry.reding@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20231012175836.3408077-4-thierry.reding@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/10/2023 19:58, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The throttle configurations need to be associated with one or more
> thermal zones before they can be enabled, so introduce a new property,
> called nvidia,thermal-zones, that contains a list of phandles to the
> thermal zones for which a throttle configuration is applicable.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v2:
> - new patch to hook up throttling with thermal zones
> 
>   .../bindings/thermal/nvidia,tegra124-soctherm.yaml           | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml
> index 0eb6277082fe..359344f60a6e 100644
> --- a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml
> +++ b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml
> @@ -161,6 +161,11 @@ properties:
>                 throttling is engaged after the OC event is deasserted.
>               default: 0
>   
> +          nvidia,thermal-zones:
> +            $ref: /schemas/types.yaml#/definitions/phandle
> +            description: A list of phandles to the thermal zones that this
> +              throttle configuration applies to.
> +

 From a DT perspective, I believe it is more correct to point to the 
devices the hardware throttling mechanism applies to instead of the 
thermal zones which is kind of software component

>     # optional
>     nvidia,thermtrips:
>       $ref: /schemas/types.yaml#/definitions/uint32-matrix

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

