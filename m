Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5F4672A73
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jan 2023 22:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjARV1V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Jan 2023 16:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjARV0s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Jan 2023 16:26:48 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448E5646B0
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 13:26:28 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id iv8-20020a05600c548800b003db04a0a46bso2030341wmb.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 13:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BNWfMzcYeamkU9A3XHuXYup3vqVICXPwHRdJttshl/M=;
        b=obAuIdkG8VuuhCZCAxfhSKxsUvuWlxQ/jX9QW5cCs32svPYwdzoD9FMyk3in2n+U65
         KzPq1weteBDx6RTOF1VqsI3O+7kPq/cBowlRGy84OH4/hKaNm+iKNtIK3ACAByQzl1N6
         hL6y0T+whJfKLC5FFjEMFwKUAlsUTQNseYo0j1shVBCsI2LXsHFe0kLD6bfZecpfFnaz
         oD7s6kcaCHB7fgOJ2tXqEsoTPSVsatuWaRH/SG7u7rwiUTRXgOoseLFoKYV1N8wlJYQ0
         gD4Sb2+ELJKZMG0UrNeS+E1d4splOlsTBfT2wibPhHoRmrCCWVSkhD5MjN+Z8af+aURO
         DGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BNWfMzcYeamkU9A3XHuXYup3vqVICXPwHRdJttshl/M=;
        b=PJQMCAn9OSsaEP1sulniSd7t/H/Q8DmjhgI9N56pdP3T4lL/fiJuiN7HHTwCpvKtsr
         6ON8YiUjk5LuCLqgLjPxnRkQNPYHFb+iWBvTM/HlZDLQzoeY7/NjHEoTVzyFMSqiJlv7
         gl73CHUGwMXG3fXI3e4SKWtg9wVQFOSZlKSv5D7Ps5lPxtiKZH23a9EEchIzsRDGyVdk
         v3c2O1+hOngmb0Ze4m4h28M8qk22mOYyeIoN2pFMnJVP2S2Ct54mhueX52nD+SxTAa1S
         4ATAIkwUHWSa7KHSGNnty9B1aiM2Dkk8qgOsGXxw758xdsR84qvHPc4HfXANnJOCIikF
         Y6Wg==
X-Gm-Message-State: AFqh2kriyn+Wc2+hC28nOi3NnDtEKqmAT9AMC8HL+RjD+wJWA1WLLjIn
        X9JL8ov4ZQwJD9X22k8DloCYkw==
X-Google-Smtp-Source: AMrXdXumIxZ7ZIFmJzie7lBAasuJb4fWz+x1NAqSdv7PHesTMVvO/WmYlfjGGPpzt2B6bNRaZB4o8A==
X-Received: by 2002:a05:600c:214f:b0:3cf:7197:e67c with SMTP id v15-20020a05600c214f00b003cf7197e67cmr8010542wml.25.1674077186762;
        Wed, 18 Jan 2023 13:26:26 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id r8-20020a05600c35c800b003daf672a616sm3613617wmq.22.2023.01.18.13.26.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 13:26:26 -0800 (PST)
Message-ID: <55a4f910-f504-76d1-21ad-689ec570b4bf@linaro.org>
Date:   Wed, 18 Jan 2023 22:26:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] thermal: spear: Use
 devm_platform_get_and_ioremap_resource()
Content-Language: en-US
To:     ye.xingchen@zte.com.cn
Cc:     rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <202301181644433003839@zte.com.cn>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <202301181644433003839@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18/01/2023 09:44, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

