Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CA4797AE0
	for <lists+linux-pm@lfdr.de>; Thu,  7 Sep 2023 19:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbjIGRx5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Sep 2023 13:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbjIGRx4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Sep 2023 13:53:56 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A95171F
        for <linux-pm@vger.kernel.org>; Thu,  7 Sep 2023 10:53:34 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2bf66a32f25so1170241fa.2
        for <linux-pm@vger.kernel.org>; Thu, 07 Sep 2023 10:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694109195; x=1694713995; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xMSTYDQ50HhnANlql6muPVUl87KevIgXvVyLmlZvBH8=;
        b=XVr8kD5ogJDW3pDQKQQn4wB7xMjzMSNi0vNmO9W3J7MeYgiKIxtxNIEbT5CbchIQRH
         MbQKB18RM4JaA1Eixtf6TvOncmEfTEHE9pGm+klfkfg3BzRC/aLvlqtRITHRf/6XGjF6
         xHkPdDdBs/MhgD0K+fE07ZTyZVwDThpXYuaB7J1ygH0bZeLwwcXSIc9JYyJXA/67UcSm
         vCjblJM4/NMOfQWPq9rJ5PcZs+dTmhjwFkVY9rxt9LSKYEEVNtkvyE0trXECEAzyr8J2
         8MtqkmZ6rWLDUCwR5byOum4h7TgBVevmRArGL6Ioxeoehwk+z6mClYgMBPAm0qVeXKzP
         rOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694109195; x=1694713995;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xMSTYDQ50HhnANlql6muPVUl87KevIgXvVyLmlZvBH8=;
        b=WQh7zaVyys6SKf/KBy59cdQivq+vLsd0vNuY1e6fz2j2Bq83E47o3c+x7Om2pCAxOt
         5OE2zX1elflg0ZeN68USzeSs+svSPchTNilzqsEwbJwrF29T6EN8Qp7LfKuZrNr0Ch7a
         ckKeFq8hoeot5OyXSfkpMigWxQj8ek5f8ti1SCmPu894kuDuzB5zXD5WXIUEROnJLff9
         O4JtSwkmC6ZHzdTbVH3LQWfPL2H/dqvwdskSupPHlW6BdW86GDnyYiSm6FLD+ezgJyfK
         TnhEp2feYm9+E972bQjoCukj3McXWIJ0tW3Sxn0p7v7J9KdMsY6CJdpPMGnRFcVccpcV
         0Wow==
X-Gm-Message-State: AOJu0YzE1PO3r62SVA4Fs8M3US/adR1fiVQDkPCvbqQNjxN358+Q0x0Z
        kUIwh3ml/JfAMxQ5qKpCzWFCZzsgPKR01P/uNXFSTQ==
X-Google-Smtp-Source: AGHT+IGIWoO+JsIl+btYwsTt/97hX2FK/iSzcrjvhPOXGc45tZqwZG3mqa/vhoooqTuBhr7B7l/JKg==
X-Received: by 2002:a17:906:1db2:b0:9a5:d095:a8e1 with SMTP id u18-20020a1709061db200b009a5d095a8e1mr4006361ejh.11.1694072200050;
        Thu, 07 Sep 2023 00:36:40 -0700 (PDT)
Received: from [192.168.37.20] (178235177204.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.204])
        by smtp.gmail.com with ESMTPSA id f25-20020a170906495900b0099d9dee8108sm10149024ejt.149.2023.09.07.00.36.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 00:36:39 -0700 (PDT)
Message-ID: <5d4ba948-46e2-4b95-95a2-17775f4c9881@linaro.org>
Date:   Thu, 7 Sep 2023 09:36:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] clk: qcom: Use HW_CTRL_TRIGGER flag to switch
 video GDSC to HW mode
Content-Language: en-US
To:     Jagadeesh Kona <quic_jkona@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@qti.qualcomm.com>, linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>
References: <20230816145741.1472721-1-abel.vesa@linaro.org>
 <20230816145741.1472721-5-abel.vesa@linaro.org>
 <2fc0d771-cee2-4826-a62a-56ed4bfad3a2@linaro.org>
 <ZOXiUzxfs1cj3SWT@linaro.org>
 <07e93a9d-69ac-41b7-aa21-b855b97bf801@linaro.org>
 <ef1439f8-4a9b-53b4-34be-1229b39d2310@quicinc.com>
 <8257f7b3-dfb8-4683-85de-600f3b1ed54b@linaro.org>
 <f37d2dd8-d625-048e-9c21-bba710b40086@quicinc.com>
 <b5ae2ad9-f6c7-47d6-bab8-3f3fdb6b43e2@linaro.org>
 <8c88bca4-b562-0122-1451-ef9de7fd8737@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <8c88bca4-b562-0122-1451-ef9de7fd8737@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7.09.2023 07:55, Jagadeesh Kona wrote:
> 
> 
> On 9/4/2023 9:32 PM, Konrad Dybcio wrote:
>> On 4.09.2023 11:27, Jagadeesh Kona wrote:
>>>
>>>
>>> On 9/2/2023 5:33 PM, Konrad Dybcio wrote:
>>>> On 28.08.2023 08:48, Jagadeesh Kona wrote:
>>>>>
>>>>>
>>>>> On 8/26/2023 4:17 PM, Konrad Dybcio wrote:
>>>>>> On 23.08.2023 12:41, Abel Vesa wrote:
>>>>>>> On 23-08-16 19:56:46, Konrad Dybcio wrote:
>>>>>>>> On 16.08.2023 16:57, Abel Vesa wrote:
>>>>>>>>> From: Jagadeesh Kona <quic_jkona@quicinc.com>
>>>>>>>>>
>>>>>>>>> The current HW_CTRL flag switches the video GDSC to HW control mode as
>>>>>>>>> part of GDSC enable itself, instead of that use HW_CTRL_TRIGGER flag to
>>>>>>>>> give consumer drivers more control and switch the GDSC mode as and when
>>>>>>>>> required.
>>>>>>>>>
>>>>>>>>> HW_CTRL_TRIGGER flag allows consumer drivers to switch the video GDSC to
>>>>>>>>> HW/SW control modes at runtime using dev_pm_genpd_set_hwmode API.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>>>>>>>>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>>>>>>>>> ---
>>>>>>>> Do we have any use for the HW_CTRL flag?
>>>>>>>>
>>>>>>>> Perhaps it should be renamed to HW_CTRL_ALWAYS?
>>>>>>>>
>>>>>>>> Or even better, *if and only if* that is necessary, add a common
>>>>>>>> property like "always_hw_managed" to the genpd code?
>>>>>>>
>>>>>>> The HW_CTRL flag is still needed for the consumers that expect the GDSC
>>>>>>> to be have the HW control bit set right after it gets enabled.
>>>>>> Guess the correct question here would be.. Are there any?
>>>>>>
>>>>>
>>>>> Yes, Display GDSC(mdss_gdsc) is required to be controlled always in HW control mode when it is enabled.
>>>> Oh really?
>>>>
>>>> Looking at msm-5.10 techpack, only the SDE RSC driver seems to
>>>> trigger regulator fast mode (so, enabling gdsc hw_ctrl on downstream).
>>>>
>>>
>>> Yes, on downstream, display GDSC has only one consumer(SDE RSC driver) and there are no other consumers. SDE RSC driver switches the GDSC to hw control mode once GDSC is enabled and leaves it in hw control mode. Thanks!
>> Sorry for pulling your tongue here a bit, but would it only concern
>> RPMh SoCs? Designs like SM6115 don't implement RSCs, should they not
>> have HW_CTRL enabled at all times?
>>
> 
> Yes, for RPMh SoCs which have display RSC block, GDSC is switched to HW control mode. For SoCs which doesn't have display RSC block, display driver controls the GDSC in SW mode on downstream. Thanks!
Thanks for explaining!

One last question, I promise.. Should we switch the MDSS GDSC to
HW_CTRL mode only after we start controlling the DISP RSC from Linux,
or should it be done regardless (because of the RPMh solving algos)?

Konrad
