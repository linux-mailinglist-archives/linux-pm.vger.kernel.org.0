Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2737A63F4
	for <lists+linux-pm@lfdr.de>; Tue, 19 Sep 2023 14:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbjISM4w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Sep 2023 08:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbjISM4w (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Sep 2023 08:56:52 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A4BF3
        for <linux-pm@vger.kernel.org>; Tue, 19 Sep 2023 05:56:46 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9a648f9d8e3so746794366b.1
        for <linux-pm@vger.kernel.org>; Tue, 19 Sep 2023 05:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695128205; x=1695733005; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aNRRNVww+5807GnHAPONA2RcVUeOwfzBI7YrYLaiKvk=;
        b=RP8TEhvCe2PBv5I0TFmltmZQk+JEPVzQXWUTXm6q8t8OW9EhnWReEtf9d77XNpxrGZ
         7G9WEqw83v+n5+AIekYzhQYfpU+0ZNCnD4nCuTa1sHyDFt9rN4rfgxLqehX6W6oQVhBA
         tVXp+r6zuRNfwE/P5N1Noorp+1uuwhFluE+eVoglm86w6YttzyUSdQpHb4nYkyertzbz
         wddv8e/mbR1aS/qIX07nuMTkSmfgFLY1ZBNy8TpKwnh/xKxhoVJQn5rDl6QhufvCGklJ
         Klwo5GIx4F74dZtzULxzlmW7frgGHOf8zdRLL0Ckcy/BWAvamsaFQgZ4Eq1dDE6varWP
         oCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695128205; x=1695733005;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aNRRNVww+5807GnHAPONA2RcVUeOwfzBI7YrYLaiKvk=;
        b=hA6NVcgBSzYrg8YEYvOseybp1CE5u3Ie3R+Aa2PmWKkTTChxXSVbwXYv1NxHcd0EZc
         WSDbtSdRopwd65h3VkdCYbng2ubqn7IfvTqUJenkNPO94ZI4EobGV2BUQALgQd60h4nm
         BjIOXimEdHkBK3Bh1t45m6GBd/7QP0Mgg7wkmETnCwJYMCd0cs5DVnR8wKjUwPMjqElH
         IzNFGTsHkOw3HZcEq+bUF/Tvxa3U4galdaOU6npLqGzWFudEtxsW7ElUfjXymGGJ3jT2
         XUkHRQEAesWN3ZHa8b1NHROAGuWWuKaGStfAsLqGgdb1n7t5aagV6nM/QrkeV9TGXpPE
         pugg==
X-Gm-Message-State: AOJu0YxmXu+Hbw6Y1pyPVmZe5NijU8Nw/O9M4xScKNV0zaSBrSvLz0jA
        Kt8aQlSMDwxOsGfDjAPcMSQ+MQ==
X-Google-Smtp-Source: AGHT+IELn3QkWc/JwrxzYHVIzfvU2A25NoAvgTcAX3CKqfChLXXYG+NJEhkcxaBBMVrL3zQf+qflAw==
X-Received: by 2002:a17:907:60c7:b0:9ad:8a29:f26a with SMTP id hv7-20020a17090760c700b009ad8a29f26amr10237919ejc.63.1695128204786;
        Tue, 19 Sep 2023 05:56:44 -0700 (PDT)
Received: from [172.20.24.238] (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id mf13-20020a170906cb8d00b0099caf5bed64sm7665767ejb.57.2023.09.19.05.56.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 05:56:44 -0700 (PDT)
Message-ID: <156f4705-ca1a-f82e-9282-534a22183f37@linaro.org>
Date:   Tue, 19 Sep 2023 14:56:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V2 1/4] dt-bindings: thermal: qcom-tsens: Add ipq5018
 compatible
Content-Language: en-US
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dmitry.baryshkov@linaro.org
References: <20230915121504.806672-1-quic_srichara@quicinc.com>
 <20230915121504.806672-2-quic_srichara@quicinc.com>
 <03b0cafa-49c7-8838-b116-927c9649cbd3@linaro.org>
 <f5aee51d-0345-1294-a85b-ea96ed937685@linaro.org>
 <1f09339e-b3b5-874c-4874-199e8c7ae890@quicinc.com>
 <ee19e076-8f9c-c5b2-3e25-2832dbdab25b@linaro.org>
 <affb1f63-c1ed-f0cc-ea79-887ae61b9b90@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <affb1f63-c1ed-f0cc-ea79-887ae61b9b90@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19/09/2023 14:48, Sricharan Ramabadhran wrote:
> 
> 
> On 9/19/2023 6:02 PM, Krzysztof Kozlowski wrote:
>> On 19/09/2023 09:22, Sricharan Ramabadhran wrote:
>>>
>>>
>>> On 9/15/2023 6:15 PM, Krzysztof Kozlowski wrote:
>>>> On 15/09/2023 14:43, Krzysztof Kozlowski wrote:
>>>>> On 15/09/2023 14:15, Sricharan Ramabadhran wrote:
>>>>>> IPQ5018 has tsens v1.0 block with 4 sensors and 1 interrupt.
>>>>>>
>>>>>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>>>>>> ---
>>>>>>    [v2] Sorted the compatible and removed example
>>>>>>
>>>>>
>>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>
>>>> No, unreviewed. Your driver says it is not compatible with
>>>> qcom,tsens-v1. This does not look right :/
>>>>
>>>
>>>    Yes it is V1 IP, but since there is no RPM, to enable the IP/SENSORS
>>>    have to do those steps after calling init_common. Similar reason
>>>    added a new feat as well in patch #2 as well. Hence for this,
>>>    new compatible was required.
>>
>> I dud not write about new or old compatible ("compatible" as noun). I
>> wrote that it is not compatible ("compatible" as adjective) with v1.
>>
> 
>   Ho, in that case, yes it is not compatible with V1 init and features
>   because of 'no rpm'. So in that case, should this be documented
>   as a separate version of 'V1 without rpm' ?

It should not be mixed with regular v1, just as new entry there. I don't
think fallback is needed - just use SoC specific compatible.

Best regards,
Krzysztof

