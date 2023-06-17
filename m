Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D461733F05
	for <lists+linux-pm@lfdr.de>; Sat, 17 Jun 2023 09:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjFQHMf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 17 Jun 2023 03:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbjFQHMc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 17 Jun 2023 03:12:32 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A95B211D
        for <linux-pm@vger.kernel.org>; Sat, 17 Jun 2023 00:12:31 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f8c74af64fso11887735e9.1
        for <linux-pm@vger.kernel.org>; Sat, 17 Jun 2023 00:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686985949; x=1689577949;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SHuRK5yrOAZzHQ9WBWjIol/EVx+4lKJS52e0FUFGTIA=;
        b=WYmeWxy/fblK4tTo5Kko5JcGQqtD97d7Pwz9T27oxY49f7Rk1/Y7+TL9JcYKVzg8gd
         9k5WLt/jfmVe2bNcJHyP4hHslgvbbSRlu79hMtGJjclh7W3CApPwMfBJP2iDfXOq3I7t
         t/FhNh7/qBru1saWiMkNUIPegPLhNVpiA7JzZaIQCk4IgaJfvr/XkRiUxZe1VijyFUPM
         rx7/6kSQUPlCGx8/h+FWBDYfaJkb2GllJ/o8Jc4Vi3oP5xNlRd6cDVoc52ovKQPLEEzu
         zto88ihFiT5aOkIEnIWKSUZIlslTxV6WQOlJWNCSpd/YuF+ojwqwfMMqy6dq56+2dWOb
         4ftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686985949; x=1689577949;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SHuRK5yrOAZzHQ9WBWjIol/EVx+4lKJS52e0FUFGTIA=;
        b=HY6V5WtBnR1DlaX8Qh7t2gxLSCQpdrwM8XzTCWBC1RiJz+OU4hUaxrYqeJDJmrLzuo
         TlBlCRUlusewjmqtgivoEZo5qMeUZHsHLEmtuo6ZYA78/nG3I6I8KVGKqPk5Q+celbEn
         WTD0mk1qTAPaWmRIGpexciJJKdFiQiLpfs6Ob7x4FIs6wNWbXUwBoNBCtQHuLfD3B1lv
         SEtWPPLDQ7SiDoC8LiDq46MoNtcmsMedHR0C/wFTWGGOJtMEnZvkcnmHadr2VSxyv357
         808bi2pG4tGL5sp/dkxRJ9j1rgzfQScvIlPgHKfpe8bU/fmWll+ck85EVT4kTrRRReE9
         WvcQ==
X-Gm-Message-State: AC+VfDwhI/W8fosR08Yz+/PNoMDUSWYKkVsjHDOZIVNF0pUw2KH/VYy6
        jgq51lro7ja1CxeixMZTVpLiNg==
X-Google-Smtp-Source: ACHHUZ4Ud7lQ8ejx3wbY/Gp18DoNVMVg+GQ8oKKNeAmLL51OE2FZE59bFzPi6e1YEfX6Eas25160GQ==
X-Received: by 2002:a7b:c8c2:0:b0:3f9:5d0:b71d with SMTP id f2-20020a7bc8c2000000b003f905d0b71dmr203135wml.30.1686985949539;
        Sat, 17 Jun 2023 00:12:29 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:4aa0:8c56:eebe:c05c? ([2a05:6e02:1041:c10:4aa0:8c56:eebe:c05c])
        by smtp.googlemail.com with ESMTPSA id k24-20020a7bc318000000b003f733c1129fsm4114574wmj.33.2023.06.17.00.12.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jun 2023 00:12:29 -0700 (PDT)
Message-ID: <422def66-911e-9e2b-34a4-f595776f43dd@linaro.org>
Date:   Sat, 17 Jun 2023 09:12:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] thermal/drivers/loongson2: Fix thermal zone private data
 access
To:     zhuyinbo <zhuyinbo@loongson.cn>
Cc:     rafael@kernel.org, loongson-kernel@lists.loongnix.cn,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        zhanghongchen <zhanghongchen@loongson.cn>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
References: <8ca44091-35fd-cc24-9896-0317772c5620@loongson.cn>
 <20230616143407.689515-1-daniel.lezcano@linaro.org>
 <9c12ece8-3a85-105b-d8d3-208fe816734a@linaro.org>
 <323267b7-3dbc-8982-7f16-08672b19039b@loongson.cn>
Content-Language: en-US
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <323267b7-3dbc-8982-7f16-08672b19039b@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17/06/2023 03:52, zhuyinbo wrote:
> 
> 
> 在 2023/6/16 下午10:35, Daniel Lezcano 写道:
>> On 16/06/2023 16:34, Daniel Lezcano wrote:
>>> The thermal zone device won't be accessible directly anymore.
>>>
>>> Use the private data accessor.
>>
>> To be folded with your next version
>>
> 
> 
> okay, If I understand correctly, I will make this patch as a independent
> [3/3] patch of the v15 series patch.

It is better to merge it with your patch 2 in order to prevent a git 
bisecting error (no need to add a my signoff or whatever)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

