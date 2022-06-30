Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82DF560FE9
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jun 2022 06:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbiF3EKr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jun 2022 00:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbiF3EKl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jun 2022 00:10:41 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52913D49A
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 21:10:37 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id j7so777753wmp.2
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 21:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=208GMSX5gYG7ZWlHbNAB3NjhHqI6KTTBfChR003rass=;
        b=ZBR/J5DP3+qcmhyEQ1VO2wpXe/UUJTp7es5GEp/vqhLQlbDlm9ZRQ7P/5i2b2bZ2CG
         OFdYcGwYPUme38hdaK9BIxvKL9Hd8HlE5eGL3NiwkCALMUS+iZWfakRwtQzUoVkQ3GTh
         5k6N5muLCg2gs5Im2J+bQml/YMXRNzjW9yRg2C3HPJwoL9z+mlA69Gy/wCwCnNkeZT0p
         onHwPKImlHQDPpGW54CwRItOTrK3mytalJ3VGaeLry1DA6Mu0+mvGZHmg+882qKm8GP3
         OoAR4Y/t0uK1Yhl+3M1DobF6G5DbJzFfeKf1eduWM9sweLPA4/SP6ECznmXZqiiSn/LU
         yLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=208GMSX5gYG7ZWlHbNAB3NjhHqI6KTTBfChR003rass=;
        b=dSzmN1JzMqqMHzAILI9Hn6jC3vDTlGAwDPug1d20rBHk++ulF3wp4/2RtYhmLIFueF
         z4zB6ybLkFtC2fXcGJRznUgopa+DBO7pCMIw5t7QCtjhYqXchBVcehKte6/UG19qCl3O
         7UAatAvx/+54JOUp7miTlRgABqOwRoeNfLpLe5L2JuJC3MuIGb2xF6sdcA+UyQv84ICL
         kRmO9WNeTjshZx49wIUUmZLwNjvnhrSQlMXY+nP6nFn8O/4flm83/WfMjqB1TFYanLte
         L4z+mAbhDKyVJeIONRtZAI6Cz0sEqjnh5OBA0+hVaAs309m2bN6/nRNYtDQnYanIlXm5
         Wepg==
X-Gm-Message-State: AJIora8Bo5bFxmHsIjcehTA/6v6UT5h4faauSacOQ8YrzQyAbqhCNGeZ
        hNaWZpZ11704yC2GfiUcJLvgrw==
X-Google-Smtp-Source: AGRyM1vJ5a/hVCn9v/GNPHBHfodqb9V2qpq0FRrTdnp69bxOdOwcudYmU5tDSPC6GAfQsnfNyZNogA==
X-Received: by 2002:a05:600c:350:b0:3a0:4910:9ebc with SMTP id u16-20020a05600c035000b003a049109ebcmr7574533wmd.148.1656562236349;
        Wed, 29 Jun 2022 21:10:36 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id bk20-20020a0560001d9400b0021b8b998ca5sm17092678wrb.107.2022.06.29.21.10.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 21:10:35 -0700 (PDT)
Message-ID: <3168903b-6850-a9eb-ead5-1389aa37485c@nexus-software.ie>
Date:   Thu, 30 Jun 2022 05:10:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RESEND PATCH 1/5] dt-bindings: opp: Add missing compat devices
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        ilia.lin@kernel.org, robh+dt@kernel.org, agross@kernel.org,
        linux-pm@vger.kernel.org, rafael@kernel.org,
        bjorn.andersson@linaro.org, krzk+dt@kernel.org,
        viresh.kumar@linaro.org, linux-arm-msm@vger.kernel.org
References: <20220629130303.3288306-1-bryan.odonoghue@linaro.org>
 <20220629130303.3288306-2-bryan.odonoghue@linaro.org>
 <1656542219.641791.1042479.nullmailer@robh.at.kernel.org>
From:   Bryan O'Donoghue <pure.logic@nexus-software.ie>
In-Reply-To: <1656542219.641791.1042479.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29/06/2022 23:36, Rob Herring wrote:
> On Wed, 29 Jun 2022 14:02:59 +0100, Bryan O'Donoghue wrote:
>> A number of devices listed in drivers/cpufreq/qcom-cpufreq-nvmem.c appear
>> to be missing from the compatible list.
>>
>> Cc: ilia.lin@kernel.org
>> Cc: robh+dt@kernel.org
>> Cc: krzk+dt@kernel.org
>> Cc: devicetree@vger.kernel.org
>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> ---
>>   .../devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml     | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: /: cpus:cpu@0: 'power-domains' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: /: cpus:cpu@0: 'power-domain-names' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: /: cpus:cpu@1: 'power-domains' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: /: cpus:cpu@1: 'power-domain-names' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: /: cpus:cpu@100: 'power-domains' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: /: cpus:cpu@100: 'power-domain-names' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: /: cpus:cpu@101: 'power-domains' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: /: cpus:cpu@101: 'power-domain-names' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: /: opp-table-0:opp-307200000: 'required-opps' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: /: opp-table-0:opp-1401600000: 'required-opps' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: /: opp-table-0:opp-1593600000: 'required-opps' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: /: opp-table-1:opp-307200000: 'required-opps' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: /: opp-table-1:opp-1804800000: 'required-opps' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: /: opp-table-1:opp-1900800000: 'required-opps' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: /: opp-table-1:opp-2150400000: 'required-opps' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/patch/
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.
> 

Well I didn't see those errors but, I don't mind fixing them.

I'll do a V2 for these
