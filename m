Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361F96B75EE
	for <lists+linux-pm@lfdr.de>; Mon, 13 Mar 2023 12:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjCML1W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Mar 2023 07:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjCML1V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Mar 2023 07:27:21 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5F45A928
        for <linux-pm@vger.kernel.org>; Mon, 13 Mar 2023 04:27:19 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id p26so7690299wmc.4
        for <linux-pm@vger.kernel.org>; Mon, 13 Mar 2023 04:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678706838;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6RTjLb5cAp5kVPLrkYJRMh2ok+za0inDURjcisAo2wM=;
        b=JKQJqG+7zH3lOS46EN479hXbyMURz8Xx67o6DOpDVSVpo4JKQIM8PQoNyCSd92iP5R
         5asiFJbahskeuAHWilzvK+kLJzYdb75guG1VdJHmo6EutvQpVgqHtn2tbfDj/yMs5FNY
         Lsb4tRfWK6KI3rLCfdlAAKV/IDTaNrbftUgPhvarSVGoZSyJ3T8eACrcjz941ykQGFKv
         NO9FFjhDyGOy5MA0VcgibbU6yr0WmlbaytJdtD+u/QHq3CzH6E2zs99y0wFzUBuc30aS
         XNoiVNsVev8v7WunvFrhyvJMwErHP3XfgTI5TjaienF05imfD3heZdcQ8Kgj7MDD0b9P
         ek2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678706838;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6RTjLb5cAp5kVPLrkYJRMh2ok+za0inDURjcisAo2wM=;
        b=owCLuU3FAxq4ISkHJGNTcve2N/zkktztbcSVKChUuRO1uslmgGVwKU+gsRXRlJI1QZ
         ZJZGzptNl6KHr9dlpsZUJQ9LNx3fVuZvAzfRq/zzqxSc0vKSYEeJ0/jozjPUDjA4n0f+
         cBx7cAs1fQR0TAwACM1QUY6dfVSNVMKCY95V2VjuhzpS2qGX/fs4U/GtoNO0gfnuTOcw
         QeShzBA/tYx2HURSW6bqSw45A8qFgJKFrDK8ecnavwgKYMRsVLkypQWedNK9X2tYgsMh
         ycaXDT/dmPgG+JtJWXcjebKHK5GZdGDef2XBTJakF6613VpmdDCR+pdcts1fl4bzIXP1
         UYdg==
X-Gm-Message-State: AO0yUKXfrd5EU5yFiUE02LvyTs8iB3ZDJs7uutibHF1yNbixKeVcsRjH
        6SGnzRFnLjkKa4cwjsWB9X3XAg==
X-Google-Smtp-Source: AK7set90YWxcPUDg/pH/tBeAbfVE8a7tS+c8qSvuK5ZbA0HiETlVlnS82QnPwwK789kDdXT2GIGWUw==
X-Received: by 2002:a05:600c:c09:b0:3eb:253c:faae with SMTP id fm9-20020a05600c0c0900b003eb253cfaaemr10154938wmb.36.1678706838217;
        Mon, 13 Mar 2023 04:27:18 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:8522:ca6e:1db4:96c6? ([2a05:6e02:1041:c10:8522:ca6e:1db4:96c6])
        by smtp.googlemail.com with ESMTPSA id g14-20020a05600c310e00b003e8dcc67bdesm9347372wmo.30.2023.03.13.04.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 04:27:17 -0700 (PDT)
Message-ID: <811f4f11-eecc-7021-eb16-3da276975187@linaro.org>
Date:   Mon, 13 Mar 2023 12:27:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH -next] thermal: Use devm_platform_ioremap_resource()
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, rafael@kernel.org
Cc:     amitk@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230308062719.79522-1-yang.lee@linux.alibaba.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230308062719.79522-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08/03/2023 07:27, Yang Li wrote:
> According to commit 7945f929f1a7 ("drivers: provide
> devm_platform_ioremap_resource()"), convert platform_get_resource(),
> devm_ioremap_resource() to a single call to Use
> devm_platform_ioremap_resource(), as this is exactly what this function
> does.
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

