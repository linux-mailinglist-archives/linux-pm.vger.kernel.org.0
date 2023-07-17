Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E053755E22
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jul 2023 10:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjGQIPj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Jul 2023 04:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbjGQIPi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jul 2023 04:15:38 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF21138
        for <linux-pm@vger.kernel.org>; Mon, 17 Jul 2023 01:15:37 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fba86f069bso6520439e87.3
        for <linux-pm@vger.kernel.org>; Mon, 17 Jul 2023 01:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689581735; x=1692173735;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AxftnQ3CNTrVOjYH5VYYCvLOpYPsnqVN2ihvqFHedaY=;
        b=OaVyt1x/nakusfj9bPvL0EcjR/vJkisACkK7ke8H60mvPHsrvxgoGQ8bdW/Lx5uHth
         gtM8yXWDIjieGQYIHC4esKxgVf/2Hc+Qeyy0+T0kF6FKWgfmA2niCjj0l7wzQ8GCalfu
         8V5/sPuLDMmZxgIVo+n4tvdDXLHEV9dsUWUOGN80egP+FK5f8+rctieFRPq2JJclgdT8
         +SxnIKYiEPXDso4Qsp5WAKUwPmL+J25e83BGsfZg9uqyMWFfx6+spg7NMVzeJJxMncbl
         9zTltd/XjzlF3MfHZbyF4N2mDdLYoJJls7JY+a/3l/I0Uh5YKglHiQ4ZRerCnmaey/Du
         yjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689581735; x=1692173735;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AxftnQ3CNTrVOjYH5VYYCvLOpYPsnqVN2ihvqFHedaY=;
        b=AlXu/eBXVlSVIkBcL7O2DhvkclsVxzV1A0r3Nc5NpbRi+CSBw1AslFm1Q4u8XCRbtl
         mdc3kCQ0q1aBWxoYW8L0yYLcjYgJEnERY77HOmvcrz4Xo57Wi9z6aeqi+Y3xXQTKHd5Z
         QO+o7WzE/ggeCaajK0JXrwNlOVd2rgzCgEaG37YCd/eq9OUaeAi3jd93Vd/xwah/RbVo
         YVLk7uCGr5JZdVLF9Uat9hx//BL+BEEVkLQN1fohXKbRdJZvDU5torH3XKNsMLZLNzJO
         hamuJqY1cfly4QqIXa0SWsvTytsOuVnMVi/xFD2k4NqyQIPdoFvHlLJG7hdfOBitzAL2
         2rYw==
X-Gm-Message-State: ABy/qLaGr1AeisV4G1tHttSz6qlEn1FDkM96jxYnj57YhZrwfztvqzVg
        XjA31GHJpEH6XrKlFrxlkHI/Mw==
X-Google-Smtp-Source: APBJJlHTmB2ZXqSG2Z7ZQZs43rQgaUnAYkwbYO1fUQdKuwiQICnK30oLhvBIZeIvvQfOxDto3Ng5Sw==
X-Received: by 2002:ac2:4da3:0:b0:4f8:6e52:68ae with SMTP id h3-20020ac24da3000000b004f86e5268aemr6790640lfe.31.1689581735260;
        Mon, 17 Jul 2023 01:15:35 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.144.39])
        by smtp.gmail.com with ESMTPSA id e14-20020a5d65ce000000b0031437ec7ec1sm18700656wrw.2.2023.07.17.01.15.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 01:15:34 -0700 (PDT)
Message-ID: <045467d8-1122-b1d3-07b6-bddd92bfa9b3@linaro.org>
Date:   Mon, 17 Jul 2023 10:15:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] soc: bcm: Explicitly include correct DT includes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230714175130.4067236-1-robh@kernel.org>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230714175130.4067236-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rob,

On 14/7/23 19:51, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.

"before it was"?

> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   drivers/soc/bcm/bcm63xx/bcm-pmb.c       | 1 -
>   drivers/soc/bcm/bcm63xx/bcm63xx-power.c | 1 -
>   2 files changed, 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

