Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAEA72DC5C
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jun 2023 10:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241008AbjFMIZa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Jun 2023 04:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237764AbjFMIZ3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jun 2023 04:25:29 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22C4E4E
        for <linux-pm@vger.kernel.org>; Tue, 13 Jun 2023 01:25:24 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f6283d0d84so6331247e87.1
        for <linux-pm@vger.kernel.org>; Tue, 13 Jun 2023 01:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686644723; x=1689236723;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F4ixw4xWTs3rJNnL8G6eiXhtwXpy6n06cNpG8Z4nKTY=;
        b=RbHeb7veI2Kdlb7asuxhP7ksdM5VkbyTG261IIwL+nG/+hu1bJvspj4ijIYxr0UvIg
         xkWIDyfG0KhGOAq0+aqFeTwLph9gvcBS4SruAS5OTUUShCrNMMvxtchL+XDvH0jHiIvR
         Bcy9ec5BIAiliJFqPrh6bqLfM5FGLt8PNL4rJwT0Zxdx2TlXWRYUwKFrt2dDalvx/gr9
         USBx87e9Iht9AWwiJy5X29fnYgALEejmp3OcRqJXwIRa9gPz1LXcv3IdppPuvm/wdCMy
         rc89RPazWjqTPfpCjHL4KfIAeH40knlJXCqWDmU6WYL3ZSDuMLkmyY5G1n4yB+1+JkEO
         1kEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686644723; x=1689236723;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F4ixw4xWTs3rJNnL8G6eiXhtwXpy6n06cNpG8Z4nKTY=;
        b=joYSAkgOajdeH5YqaL4pR7Pjc//Y+ihwCvf5ypEwE0pM2CtuuHkCeYHYF/vPrh/Gt4
         5j+75m5LsPseexqcStKp1MUSkG0J3CkcPXxVgM9jTjHZ5e6MCQrAvlJ4cSExymq+LFtI
         L5Rb9adMS90u6DLx8gw0tbWJbMogtO73lHg6+Vg7UVERBI0Co11exfB88fqNCXtWe8F4
         7akHNZym8QBnXOrExo97Q8UdLkn1gje3mpAEGqFDkhe8leHB0on5v0iVyfmqQ6TlQWzM
         c94oJSLMCYFaSO/ouuZajkz2tDZI5f0BMksK3Q1XcnLFTbOcMY0E3MNdrGOgEyEKqBKC
         nwgA==
X-Gm-Message-State: AC+VfDwenvEq7b5Porv/Rp+XRBhec9b35i4e8Gx6iupe9Ztz4PRFaEun
        x63zvofhlmL4Kb3ke/tYh0LpKw==
X-Google-Smtp-Source: ACHHUZ7r47vQ3MyWQCdq68QcbgIUmC0wTN9B2tjrjOdXfofm3h3VHlJf3oFPzEa6nhiyIi56iM4r7w==
X-Received: by 2002:a05:6512:503:b0:4f0:124:b56b with SMTP id o3-20020a056512050300b004f00124b56bmr4880954lfb.7.1686644723189;
        Tue, 13 Jun 2023 01:25:23 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:b5a8:28ff:af00:a97f? ([2a05:6e02:1041:c10:b5a8:28ff:af00:a97f])
        by smtp.googlemail.com with ESMTPSA id 6-20020a05600c230600b003f41bb52834sm13734723wmo.38.2023.06.13.01.25.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 01:25:22 -0700 (PDT)
Message-ID: <1c77c762-8557-b82d-219e-9d4d6fb0fa31@linaro.org>
Date:   Tue, 13 Jun 2023 10:25:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 09/10] dt-bindings: thermal: convert bcm2835-thermal
 bindings to YAML
Content-Language: en-US
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-pm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
References: <20230604121223.9625-1-stefan.wahren@i2se.com>
 <20230604121223.9625-10-stefan.wahren@i2se.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230604121223.9625-10-stefan.wahren@i2se.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04/06/2023 14:12, Stefan Wahren wrote:
> Convert the DT binding document for bcm2835-thermal from .txt to YAML.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

