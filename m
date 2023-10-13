Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CE37C899E
	for <lists+linux-pm@lfdr.de>; Fri, 13 Oct 2023 18:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbjJMQD3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Oct 2023 12:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbjJMQD3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Oct 2023 12:03:29 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AD2BE
        for <linux-pm@vger.kernel.org>; Fri, 13 Oct 2023 09:03:27 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40651a726acso22648295e9.1
        for <linux-pm@vger.kernel.org>; Fri, 13 Oct 2023 09:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697213005; x=1697817805; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xx6K0FskEAaNWRG638yIMXb8r7uj2KVeRv0dm9cYNzM=;
        b=iae+qF2UN+i/r55rXJj4ORGuXlPWaTobyT2a7383wZdK67HSYA37zQHtWfm19Hy1KO
         j4M6f6Wr8xg4/YmmwShBqhQJOkQv3rW9aZUUWrR8zSYFlgjjGca81ZDVFlAkNRUCCpuh
         wfKourp8Gyrv0O9XPzMpiAJtL0Vivvu14Q+8BA1T5CDzPRjY8CkxnKi+nuB4/s79F1hv
         ZZZldyykrxgrTanQWf3w/PzyiANjBIBJU/x+Mm1vsQm2HMbI4lex/I4NMCyfoXRC7DH2
         q/Gz90pjmM5nbpUHvnDJ3GzgU1eRUN4MT7o1oo5O1A3dteKE3sq9rcEDf7K0VAh4oT8t
         RBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697213005; x=1697817805;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xx6K0FskEAaNWRG638yIMXb8r7uj2KVeRv0dm9cYNzM=;
        b=DnYeRYV6D3vus3KOnyJuhdoWAC2FdJkh9dOZ8ttdw5KSNEGPu6U31xrS/N42G0RHQm
         bIKHViR5qKz0R02hiKK+/47kC9pDchjD6yutfXRhaGMbmmE4u05GwUIpUS7jX2H1wWmt
         mU/sYnD3QQ6RBJ6sw7WDsf2z9ileALBpMAg3a8FQuJPTwdIIag5wUxAOXwXp2XVATvva
         NdbtK5YVpxgRg9JoBZia6il8BFjcfFMWeh9RZI5n1hxlz0j6Lf89I1YdogEpe/cT1hgy
         kWt63irYZnfWM1a2v8OaGbG2noi8gg3FFvXxj+M8pDzGYEVgo8TxMdiE5J7vMNLxA6F/
         6ZEQ==
X-Gm-Message-State: AOJu0YzHHEm6AFjVK0adhK4KhtRTakZHih4l1L24BgN9lKb6zGic47++
        mI8npBST+Aia/Jin5RE9ahdOvg==
X-Google-Smtp-Source: AGHT+IHTx4Svao1YPkAoYlFXL4PxadChOE1NmjC3y481c1DwVzUNw4GSKlTczNN6ZeAfLuheD6aXUw==
X-Received: by 2002:a1c:7209:0:b0:405:a30:151e with SMTP id n9-20020a1c7209000000b004050a30151emr24594313wmc.12.1697213005512;
        Fri, 13 Oct 2023 09:03:25 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id n15-20020a05600c3b8f00b004064741f855sm511983wms.47.2023.10.13.09.03.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 09:03:25 -0700 (PDT)
Message-ID: <019fe8de-2fe4-4854-96d3-9f64b18f1a1f@linaro.org>
Date:   Fri, 13 Oct 2023 18:03:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: max77620: Remove duplicate error message
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Chauvet <kwizart@gmail.com>
References: <20231013155104.1781197-1-thierry.reding@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20231013155104.1781197-1-thierry.reding@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13/10/2023 17:51, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The thermal_of_zone_register() function already prints an error message
> when appropriate, so remove the extra one from the MAX77620 thermal
> driver.
> 
> This fixes a spurious error message when no thermal zone was defined
> for the MAX77620 in device tree.
> 
> Reported-by: Nicolas Chauvet <kwizart@gmail.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

