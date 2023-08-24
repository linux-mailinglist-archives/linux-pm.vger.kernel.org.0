Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C1D786F48
	for <lists+linux-pm@lfdr.de>; Thu, 24 Aug 2023 14:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237003AbjHXMkV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Aug 2023 08:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238628AbjHXMkQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Aug 2023 08:40:16 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF75170C
        for <linux-pm@vger.kernel.org>; Thu, 24 Aug 2023 05:40:14 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-52557cc5e7bso8581351a12.0
        for <linux-pm@vger.kernel.org>; Thu, 24 Aug 2023 05:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692880812; x=1693485612;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wqMVuZgSs+Wu8Z+ehdcmYCmlouSlct+heFdmNRVbxgA=;
        b=FIIljaCMS3LSAeyIwGG1CFHuk2amuKWkzFuUPAWNzTZVyoeIg97RcEyJkTNv1AOC4R
         bUfZ8ZwJG1jNq1FzLnH4TVhJXMtiBMxTIFBgOokj5QQG7FCfPuimrHeeVxJ5n8lCP2wc
         YiAMaKMi7q6EI9txbhyIKrnUtzLnixK9Fc9tFua9N0Ga5iXAjrWWyBnHfQxiUEx63+H4
         bwnoKKrnVUIJieeXJQy67Lhk0jWP5HmSymaxiFHnBqLhROG0nBZHAhqZD30Vo1stVrAa
         p9D9y67QUvlhYRhPfvm5M1ZxpMJGk/yKHWv4Uq+T3WEQY4XrVzJbSEzYjtsBtrpUFU4E
         5F8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692880812; x=1693485612;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wqMVuZgSs+Wu8Z+ehdcmYCmlouSlct+heFdmNRVbxgA=;
        b=S0EiBqyvjcEyY185r4D0YPp2uQQCj4kSQlrkyPqy4JRSF7C0yRopkOjFEFt5P0NFdZ
         cR852UmfbqA3cBOjBmDJZUHrVu/oazrncdhvUF5kYoljC6egL6wS9fIZhbt5C+tWX4qU
         892euZ6xjARkkeE0PNpUztnT9me5vCbh3J7Bji2D+Q04ibI6Ty4l+VUNojLm+na4etrp
         bY+i7FgivG3VbL5lj7Rk7f97Mp84k24/INPZ2QF04EzMibBhxKVIdSMjRfxWIDIOV188
         47gTilKV3UpYGDEuK+n8i6rQ89AOxfWVdGzCnQ9DmQuQnp9MpQAoO+GxAnvbRFYehrLQ
         kjmw==
X-Gm-Message-State: AOJu0YxrfFcUjIhtF4W0lt79pKAa5/jpctmk4cfUnomI/0nN8Zene5jn
        0bXcZFjsm7Wn1j85Ls41guyHKA==
X-Google-Smtp-Source: AGHT+IEjcG+DIJTiu+zFCt/pQNZPjv8quz5M9OOkFjSmEnD6DO15qu9MPOQeD2ffsT+uLol9dT4AhA==
X-Received: by 2002:aa7:d9c7:0:b0:529:4642:7933 with SMTP id v7-20020aa7d9c7000000b0052946427933mr13040061eds.36.1692880812560;
        Thu, 24 Aug 2023 05:40:12 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id l15-20020a056402124f00b0051dfa2e30b2sm10559541edw.9.2023.08.24.05.40.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 05:40:12 -0700 (PDT)
Message-ID: <46a562b5-6984-3b41-3c41-c346107b4c96@linaro.org>
Date:   Thu, 24 Aug 2023 14:40:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] power: supply: bq24190: Support bq24193
Content-Language: en-US
To:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Cc:     Alexandre Courbot <acourbot@nvidia.com>,
        azkali <a.ffcc7@gmail.com>, CTCaer <ctcaer@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230824112741.201353-1-linkmauve@linkmauve.fr>
 <20230824112741.201353-2-linkmauve@linkmauve.fr>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230824112741.201353-2-linkmauve@linkmauve.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24/08/2023 13:27, Emmanuel Gil Peyrot wrote:
> From: Alexandre Courbot <acourbot@nvidia.com>
> 
> This charger is working with the driver as-is, so enable it to be probed.
> 
> It is used in the Nintendo Switch for instance.
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  Documentation/devicetree/bindings/power/supply/bq24190.yaml | 1 +
>  drivers/power/supply/bq24190_charger.c                      | 2 ++

Please run scripts/checkpatch.pl and fix reported warnings. Some
warnings can be ignored, but the code here looks like it needs a fix.
Feel free to get in touch if the warning is not clear.

Bindings are always separate.

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching.

>  2 files changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/bq24190.yaml b/Documentation/devicetree/bindings/power/supply/bq24190.yaml
> index d3ebc9de8c0b..92a28d3c3070 100644
> --- a/Documentation/devicetree/bindings/power/supply/bq24190.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/bq24190.yaml
> @@ -18,6 +18,7 @@ properties:
>      enum:
>        - ti,bq24190
>        - ti,bq24192
> +      - ti,bq24193
>        - ti,bq24192i
>        - ti,bq24196
>  
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
> index ef8235848f56..a56122b39687 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -2018,6 +2018,7 @@ static const struct dev_pm_ops bq24190_pm_ops = {
>  static const struct i2c_device_id bq24190_i2c_ids[] = {
>  	{ "bq24190" },
>  	{ "bq24192" },
> +	{ "bq24193" },
>  	{ "bq24192i" },
>  	{ "bq24196" },
>  	{ },
> @@ -2027,6 +2028,7 @@ MODULE_DEVICE_TABLE(i2c, bq24190_i2c_ids);
>  static const struct of_device_id bq24190_of_match[] = {
>  	{ .compatible = "ti,bq24190", },
>  	{ .compatible = "ti,bq24192", },
> +	{ .compatible = "ti,bq24193", },
>  	{ .compatible = "ti,bq24192i", },
>  	{ .compatible = "ti,bq24196", },

We should really stop doing this. All of them are compatible, aren't they?

Best regards,
Krzysztof

