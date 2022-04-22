Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF56350BED2
	for <lists+linux-pm@lfdr.de>; Fri, 22 Apr 2022 19:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbiDVRjK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Apr 2022 13:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbiDVRjD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Apr 2022 13:39:03 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6F41002F1
        for <linux-pm@vger.kernel.org>; Fri, 22 Apr 2022 10:36:00 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id u15so17671658ejf.11
        for <linux-pm@vger.kernel.org>; Fri, 22 Apr 2022 10:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=gcGu16UtHNcJMaljpwgCxg9/Y7hdibwAAQTqTsz4orY=;
        b=m59yJ0YM+fTtTMluLJHSPbZqTKw2yrlcB7rn0kAAsirMZ9Feosc0T2CvLTs7UhrlFW
         ah+n7r8omYlF1P502KsWEICfSiA+2+qdIdX0vcv/zfEavG+v/SjIpnhdAwoSp4jVwCCk
         DFa28zWCXST+X9xyeuqKsbcAo88ZFLsGfC+BJ4SUbpXRKdaQeiUcjDMn+ZtjwO9treEc
         mtGTXyDzS6+fkRCTsSj3pvi3aO7Rz3mZV1FJVcNSVJ7LaUUWXmeuFZUGhP/0+tpPV8AG
         VEwsfOPspe+Qd9eWy1YF4dmuKf+JCIiXrBM4817HsVs2bUR/YuO47NOFG55yXMDt0b5z
         he+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=gcGu16UtHNcJMaljpwgCxg9/Y7hdibwAAQTqTsz4orY=;
        b=UX4OKH2wH+KSMtVy2xLxp0fxGej1NZa1w/4/YNEJwamexbecbHUJJlcQ4PFqBcAUWG
         E4qEWz2AnNCucZfmr3xtxowA3fsoDi2t9hU4UlWCg2f2Sns5Tuw2A0F7OybsRNwk385i
         by3GAjFUyaD6c2Zd6LroyWJxwH9VD7t3ZV1t1GGaEoLdcdZGTPDk6YEpdKEPybCXGz0F
         IH8DDIlQ6su9j/XZXvPTDcLxAFdh7YMwWYJB6EG68mVI605MQMOk2iE6jSJYs1ZIOzFw
         KIDRzsnpRyNfoCJ8UwGZWcck7AgwLj6Zo4eIXhBQyfiKyCpvVe6FdKyckOwcK+mj8ihQ
         F8Fw==
X-Gm-Message-State: AOAM531cWYNCGL6bdF8K5PJu4H7Q0tHahQNUKZF/e1Z6FvZ6B02yokXD
        d/t6dJPJjKKgFFzTFxzaZnNomg==
X-Google-Smtp-Source: ABdhPJzFbgLTY01c3uCTHOltXeHcVv4qu5BdqenO4C1F1MyF3ijzLpR3KfjJwJ6gjX4Kgph3GoN0pg==
X-Received: by 2002:a17:906:c14a:b0:6e8:76d0:e0eb with SMTP id dp10-20020a170906c14a00b006e876d0e0ebmr5030477ejc.412.1650648894899;
        Fri, 22 Apr 2022 10:34:54 -0700 (PDT)
Received: from [192.168.0.234] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id jr16-20020a170906a99000b006e4c05e8919sm950871ejb.35.2022.04.22.10.34.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 10:34:54 -0700 (PDT)
Message-ID: <811bf944-a230-ab9b-583a-840e57af8a1e@linaro.org>
Date:   Fri, 22 Apr 2022 19:34:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V4 01/14] dt-bindings: cpufreq: mediatek: Add MediaTek CCI
 property
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        matthias.bgg@gmail.com
Cc:     jia-wei.chang@mediatek.com, roger.lu@mediatek.com,
        hsinyi@google.com, khilman@baylibre.com,
        angelogioacchino.delregno@collabora.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220422075239.16437-1-rex-bc.chen@mediatek.com>
 <20220422075239.16437-2-rex-bc.chen@mediatek.com>
 <f2e5a34b-ed02-91a1-bc7b-fecaa95e227e@linaro.org>
In-Reply-To: <f2e5a34b-ed02-91a1-bc7b-fecaa95e227e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22/04/2022 19:26, Krzysztof Kozlowski wrote:
> On 22/04/2022 09:52, Rex-BC Chen wrote:
>> MediaTek Cache Coherent Interconnect (CCI) uses software devfreq module
>> for scaling clock frequency and adjust voltage.
>> The phandle could be linked between CPU and MediaTek CCI for some
>> MediaTek SoCs, like MT8183 and MT8186.
>> Therefore, we add this property in cpufreq-mediatek.txt.
>>
>> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
>> ---
>>  .../devicetree/bindings/cpufreq/cpufreq-mediatek.txt         | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
>> index b8233ec91d3d..3387e1e2a2df 100644
>> --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
>> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
>> @@ -20,6 +20,11 @@ Optional properties:
>>  	       Vsram to fit SoC specific needs. When absent, the voltage scaling
>>  	       flow is handled by hardware, hence no software "voltage tracking" is
>>  	       needed.
>> +- mediatek,cci:
>> +	MediaTek Cache Coherent Interconnect (CCI) uses the software devfreq module to
>> +	scale the clock frequency and adjust the voltage.
> 
> Devfreq is a SW mechanism, it should not be part of bindings description.
> 
>> +	For details, please refer to
>> +	Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
> 
> Since the file does not exist, I have troubles reviewing it. First of
> all, you already have "mediatek,cci-control" property in DT, so why
> using different name?
> 
> Second, it looks like you want to put devfreq into bindings instead of
> using proper interconnect bindings.

Actually judging by the driver this looks like some
device-boot-time-ordering, so I wonder whether this is a proper way to
express it.


Best regards,
Krzysztof
