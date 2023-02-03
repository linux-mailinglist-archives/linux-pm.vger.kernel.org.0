Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A47E6898E8
	for <lists+linux-pm@lfdr.de>; Fri,  3 Feb 2023 13:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbjBCMf3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Feb 2023 07:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbjBCMfU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Feb 2023 07:35:20 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4991316ACF
        for <linux-pm@vger.kernel.org>; Fri,  3 Feb 2023 04:35:12 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id bg26so3784022wmb.0
        for <linux-pm@vger.kernel.org>; Fri, 03 Feb 2023 04:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0fS5h/6A8JqyaZ0AF5IugOshgaAjg1/k1ZgrK3n4WYo=;
        b=nUBWefrCTlVLguPtGahCXnxqTOLdmiJzegJUWs0kasPrEsNLjwP+xhBI8rwLu62YOz
         YLJ2lwCeVM3efZlThlK8v3QdFbRv/E/qrPoS+rUPSvxh5pjLUI8p9MKBMMTcZ638RcPI
         ZnVBxYsnVYQFBcMjg9FbFX6+GAkFL3ZlKHSpIwQKTMW2NmmxyaBTqXQwG0qu7GqUFzbl
         Ev7kHMaj2z0lbTObcZPnSwMBvl/3YYSOtetdMoLkUl8A2+9v11OskQEtg2ALkmrmRTK0
         BZtDjBx/HaH5KKFlCVqP+UmJgtyfRM/3qcVZnqVUWC692BmA913f3nLl0FVEXJiY3cGN
         dd7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0fS5h/6A8JqyaZ0AF5IugOshgaAjg1/k1ZgrK3n4WYo=;
        b=oINn8SZbdTACO+ziIMctc41Zd1q/Yluf4E7H1p9PE9M56LDXTxwCmNrdS3bGIucNet
         HBmeRqbCZZo0GtOYecpbMYTKzJt+90AY7SzAohi3dz3S6Gxw54pJOvm1E/Wnte8k/cBq
         aJR4VqeEJaxM5Phtq4zLnkMNPX8shoVjjUT+QkvXnYOqmnBDWFqq1V5U0/KEw3uPSJJw
         bKE+jvD1HGpzdsex8zqWSBHBZnowFxo+jL3W7iY6ebTzLZbf6DiKigLJaxinw3Ro7BGS
         J818GqQb9rfx3XHBGsnZRi78LPtClTMQ0VHO+1Z2sVbuWJ8aDosGJWWuHzM60eZqFYD4
         gbvA==
X-Gm-Message-State: AO0yUKWp0gKDjUAbZLiSCjKdQ9A6kKF1IvB8w8VddiFAOfXOn5kv9y8a
        V0Fd2UGxKnxs8L5wh46KlxGtqA==
X-Google-Smtp-Source: AK7set9n7hhpjyjI6s+IRKBEa3a9h5wmUDUXkS1L5NWrawy7DRPpdQZxuiMzFiz08oatXJozgCxUDw==
X-Received: by 2002:a05:600c:1c16:b0:3de:c612:df56 with SMTP id j22-20020a05600c1c1600b003dec612df56mr9134223wms.15.1675427710851;
        Fri, 03 Feb 2023 04:35:10 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id k10-20020a7bc30a000000b003dfee43863fsm265822wmj.26.2023.02.03.04.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 04:35:10 -0800 (PST)
Message-ID: <bcfb143d-1d1b-590b-ac7d-7624f9069708@linaro.org>
Date:   Fri, 3 Feb 2023 13:35:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 1/3] dt-bindings: reset: syscon-reboot: Add priority
 property
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220820102925.29476-1-pali@kernel.org>
 <20221226114513.4569-1-pali@kernel.org>
 <20230122112744.vdfho4mzpgm6oucm@pali>
 <20230203121610.zung35qrozvoauz6@mercury.elektranox.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230203121610.zung35qrozvoauz6@mercury.elektranox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03/02/2023 13:16, Sebastian Reichel wrote:
> Hi,
> 
> On Sun, Jan 22, 2023 at 12:27:44PM +0100, Pali Rohár wrote:
>> On Monday 26 December 2022 12:45:11 Pali Rohár wrote:
>>> This new optional priority property allows to specify custom priority level
>>> of reset device. Prior this change priority level was hardcoded to 192 and
>>> not possible to specify or change. Specifying other value is needed for
>>> some boards. Default level when not specified stays at 192 as before.
>>>
>>> Signed-off-by: Pali Rohár <pali@kernel.org>
>>
>> Reminder: Any plan how to handle these patches?
> 
> Please don't top-post :) Sorry, I'm a bit slow with processing
> patches this cycle. Technically this was also throwing a DT
> warning reported by the bot, so I expected a new version. Anyways,
> I fixed the DT warning myself and applied patches 1-2.

Everyone was expecting new version, so that checks pass. We should not
take known-broken code, because then the duty to check for other errors
is on you Sebastian. :)

Best regards,
Krzysztof

