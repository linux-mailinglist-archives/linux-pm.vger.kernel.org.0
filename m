Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626A3672A46
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jan 2023 22:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjARVTX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Jan 2023 16:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjARVTW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Jan 2023 16:19:22 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FBC2C65A
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 13:19:20 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so210555wms.2
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 13:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cgJgnga9mpLZ3f+1jsEl1MEcviaWUC0JRXqq+0JOYHk=;
        b=ko53AZJ/FcTOsjAWQ45BlxDmwa0p+Z7KPgTZhvtmyEa1c00T68l+ZjHPRIU+2WRxnZ
         bBbHM7gyBHiomWGck5P90FL7sdGNaSQ0IquWonbuHtLH6AS7rS/VIGLksC52nFiieTEW
         QWv77sk4RHedy0VXUOXIG6+zzeYjCvtvy7zjcf6BQti+rzhUbtLeVEl1uSyOLWXUcesB
         B4/ANyfmFfRxctnIEM2IXsosNd8Q+ztaB4UgbYKW6DlPMC0Mg/zVQseij7gMjJJgzRi6
         w72uljE92uAIlS+42b8FNa7YhAVSOcztbH06qlm6gK1fQrASdk+tj9VJbY3lKGlzYrlC
         vlkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cgJgnga9mpLZ3f+1jsEl1MEcviaWUC0JRXqq+0JOYHk=;
        b=56XEFo31ASmSVgqRIFVIuefXnqtuRke07E0ZDYyxpqkiCa03teIKLXMwAf3fz98LjN
         iq8U0sQZeCLY8MRJJ6xLS9qlbsLnHlgYkgc2FkIiZuIarQ3LAJTThmtL5LQvQrQWQ7Lq
         RmftlvSLqtlkIDe1kLcZnEOH+gb7C722EuBU6rK2br7CsATE6BxzNyhVWteXjYbIzKTr
         tygRPxlGhJjQ1aNqbswUNNMdprRVJIkzargn/PdetPk7/P8zKqjfZ2NC/s24TAI0E9AG
         lvtt/ijeWttlmSAABEneHJDCdth368wlZZOIN0Tb3J1dRA7owfB2fRlHFfrqOVRropBp
         QhoQ==
X-Gm-Message-State: AFqh2kqae07UmI1l7eGAEkBQIaZZUA3o/EVAcFbtuSTWcIzcP/HKC64j
        7gJ7op66KxE4svS7Z177DFstfg==
X-Google-Smtp-Source: AMrXdXsNmXS9Jhjn2IfGM5gFSqybi+pOnjL496Ex1FDIHmzovL2N58qHu7PAzbs5F/Mf9aHNgGEerA==
X-Received: by 2002:a05:600c:214:b0:3db:30f:bd72 with SMTP id 20-20020a05600c021400b003db030fbd72mr4110532wmi.8.1674076759370;
        Wed, 18 Jan 2023 13:19:19 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id w1-20020a1cf601000000b003daf681d05dsm3020549wmc.26.2023.01.18.13.19.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 13:19:19 -0800 (PST)
Message-ID: <170c5181-ec51-d4a6-b901-d82b51937751@linaro.org>
Date:   Wed, 18 Jan 2023 22:19:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] thermal: dove: Use
 devm_platform_get_and_ioremap_resource()
Content-Language: en-US
To:     ye.xingchen@zte.com.cn
Cc:     rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <202301181633059433484@zte.com.cn>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <202301181633059433484@zte.com.cn>
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

On 18/01/2023 09:33, ye.xingchen@zte.com.cn wrote:
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

