Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C0B78EC96
	for <lists+linux-pm@lfdr.de>; Thu, 31 Aug 2023 13:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346156AbjHaLyu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Aug 2023 07:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244318AbjHaLyq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Aug 2023 07:54:46 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BA5E42
        for <linux-pm@vger.kernel.org>; Thu, 31 Aug 2023 04:54:42 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so4077669a12.0
        for <linux-pm@vger.kernel.org>; Thu, 31 Aug 2023 04:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693482881; x=1694087681; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/hD9FTxJbMKacozOlk38SeaYZ8nm15TjXdv4WV8+FzQ=;
        b=B7kaoMOkhaQEV8+d2OJLv/GMBYNhhr2mkjlrAX91TYhJYJM641006iI6xzluCknU3P
         zEz/z/zLUJzeWErbWpkeWLuxKP7DVxgSOJNFzq49XT3NFKdumtVa1tJ4NREpzfbQ/G76
         5kR5NgvgGyyNoKwnSciQEEywEqQhknhyKlJC6T7hdjJt97QGk9378vmKd+o+KtMzhvzw
         vX0rnhLTd+Zv6cIprR9iJtCKWuMRuqnUyQcsSghKvBut4vbt1N8XHsxJOZC2dAFOFb3o
         a6bzBV/mmeN2w4w9WCxaL45HlvE5MEwfMANvCQSus/L2Es757que78Rph5tRFnJ9o3k+
         EfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693482881; x=1694087681;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/hD9FTxJbMKacozOlk38SeaYZ8nm15TjXdv4WV8+FzQ=;
        b=QnvXt8srXVV+lZ9XnsbzOX5m5UIVqncx3tj/JagYAarA6I9UGx7i0J9O2mWMZT2NsH
         tchL2QveqRggmXFv8iMQM3VF1Y+AcsP06NbEbRw2gVqhy9JWtptQ95c3JCtv36lj8iK1
         yFEXdK5TYfsFSrE1gV3IxdnOFY2zudrIPx65ujCottBFwoZ27ifMnmtK8UqStucdLKUA
         ktQF5E5vvfoXgo2pOqoM3vrRRETUbCGuAq2ysWf0z9ZFFWUaiIATDaOxcj+cZmWnU5M7
         R2PudAnz7QPAkCRojErXWtghE/pwPP9F+D65eJtevk/YGGq1K2JoLNbWCWD4O49kvD6W
         mzSQ==
X-Gm-Message-State: AOJu0Yw3xym/CuZqaODK9etT3cNpc75EohV61K2ZUrAVA7lnHZpz6m61
        Cx6PWo0nUGsG+XZXx5XeOvjB5A==
X-Google-Smtp-Source: AGHT+IEv7SRBdXlCmMcMYVzriOzfH5+6r/nMV6Or12OHswNkE+1axAP7Y6sSExBTWPJjO3FYpjyL4Q==
X-Received: by 2002:a17:907:781a:b0:99c:5056:4e31 with SMTP id la26-20020a170907781a00b0099c50564e31mr3138983ejc.15.1693482881101;
        Thu, 31 Aug 2023 04:54:41 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id k13-20020a17090646cd00b00997e00e78e6sm673645ejs.112.2023.08.31.04.54.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 04:54:40 -0700 (PDT)
Message-ID: <728003b9-db27-fdc0-e761-197a02a38c24@linaro.org>
Date:   Thu, 31 Aug 2023 13:54:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 04/11] arm64: dts: qcom: pm7250b: make SID configurable
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20230830-fp5-initial-v1-0-5a954519bbad@fairphone.com>
 <20230830-fp5-initial-v1-4-5a954519bbad@fairphone.com>
 <b82f4683-e8b5-b424-8f7a-6d2ba1cab61f@linaro.org>
 <CV6NF0466658.20DGU7QKF2UBR@otso>
 <CAA8EJpr1+W3f08X-FpiiVrJ98kg52HaMwbbKn=fG15Whm4C8aQ@mail.gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAA8EJpr1+W3f08X-FpiiVrJ98kg52HaMwbbKn=fG15Whm4C8aQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 31/08/2023 13:33, Dmitry Baryshkov wrote:
> On Thu, 31 Aug 2023 at 13:13, Luca Weiss <luca.weiss@fairphone.com> wrote:
>>
>> On Wed Aug 30, 2023 at 12:06 PM CEST, Krzysztof Kozlowski wrote:
>>> On 30/08/2023 11:58, Luca Weiss wrote:
>>>> Like other Qualcomm PMICs the PM7250B can be used on different addresses
>>>> on the SPMI bus. Use similar defines like the PMK8350 to make this
>>>> possible.
>>>>
>>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>>> ---
>>>>  arch/arm64/boot/dts/qcom/pm7250b.dtsi | 23 ++++++++++++++++-------
>>>>  1 file changed, 16 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/pm7250b.dtsi b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
>>>> index e8540c36bd99..3514de536baa 100644
>>>> --- a/arch/arm64/boot/dts/qcom/pm7250b.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
>>>> @@ -7,6 +7,15 @@
>>>>  #include <dt-bindings/interrupt-controller/irq.h>
>>>>  #include <dt-bindings/spmi/spmi.h>
>>>>
>>>> +/* This PMIC can be configured to be at different SIDs */
>>>> +#ifndef PM7250B_SID
>>>> +   #define PM7250B_SID 2
>>>> +#endif
>>>
>>> Why do you send the same patch as v1, without any reference to previous
>>> discussions?
>>>
>>> You got here feedback already.
>>>
>>> https://lore.kernel.org/linux-arm-msm/f52524da-719b-790f-ad2c-0c3f313d9fe9@linaro.org/
>>
>> Hi Krzysztof,
>>
>> I did mention that original patch in the cover letter of this series.
>> I'm definitely aware of the discussion earlier this year there but also
>> tried to get an update lately if there's any update with no response.
> 
> I think the overall consensus was that my proposal is too complicated
> for the DT files.

I proposed to duplicate the entries. Do you keep QUP nodes in DTSI and
customize per address? No.

I definitely do not agree to these ifndef->define. Maybe using just
define would work (so drop ifndef->define), because this makes it
obvious and fail-safe if included in wrong place... except that it is
still not the define we expect. This is not the coding style present in
other DTSes.

The true problem how these SPMI bindings were created. Requiring SID
address in every child is clearly redundant and I think we do not follow
such approach anywhere else.

Best regards,
Krzysztof

