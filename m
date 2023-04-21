Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5BA6EA47E
	for <lists+linux-pm@lfdr.de>; Fri, 21 Apr 2023 09:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjDUHSC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Apr 2023 03:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjDUHR7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Apr 2023 03:17:59 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC2DE69
        for <linux-pm@vger.kernel.org>; Fri, 21 Apr 2023 00:17:34 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-506bdf29712so9676923a12.0
        for <linux-pm@vger.kernel.org>; Fri, 21 Apr 2023 00:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682061442; x=1684653442;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D8FJvP1BD0tDx6NIZl+M/d1F52rRHkvVZml0FlFOiDU=;
        b=LxyhVBykO2Nl4UGUEb6e3uAz1gyBZ4HLLnAE9gBSTjurD1v1Xu2xlZApBnF8PIYn7O
         +yB9vskucWQiMNiNjvt8HrWhgypU34cDUvbiKT18Qs6+uo+U5byjg+vqqFObYImfd616
         0fZzoiE4w8ZP4LOweQ/pb73ah0EYQByoM5x8GtT898SPBFhsHSkV3DLA4SeZAS4I9PmX
         DOQBKP3PXvcLe1j7abvR2Zi4gEdDyT6aaUBaTUUAUn6Mla0sKTAA38EMAfkmYNMkBczC
         GZjcRb38/2yQJaCm0LCmsn2EUxbGs8AEpUugS4U/P9+oljecA5Y5357n8TTgrxvNL9ER
         vLGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682061442; x=1684653442;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D8FJvP1BD0tDx6NIZl+M/d1F52rRHkvVZml0FlFOiDU=;
        b=MDEkO9oi5h3cLh76k/y8p0sZ+B9rB6/bvahW+kSuZr38/gxHC6EXwHp95JctS0a49I
         sTh1n18quaFM07rJbO9MIwQfLmGPfK3jbX8RhclCi5TGFV/mtEC7ZWCoulnZrMDWcZnl
         scBDS9M963yqfiRZUjuGEsOIjKqhqhGWkN8dmdlWoEUZxEsXkiiphZj5CSbT8GGdmJOO
         UqzhgZVnVPzYpm3QKVWtZY2JPuuigh7Sf7gPwcxLSaTiKmNa7n7XBDiy8oYL3yVhrdJX
         McEykAF77bCuvynvZ482d9NIuXKnm06cY1QW6g6itH8CMiX93TVp12Tkb6gqNbCsM4Ft
         Xx6g==
X-Gm-Message-State: AAQBX9cgsUkj8AJZ/HDIcIqsxCYrjIZn5LnDjDY/8v6fJZSkMO6ixKGI
        Ly1wd7Q6UcgaYQqhzqA8jDuG3w==
X-Google-Smtp-Source: AKy350YC3h8J32Hjg0FT3P4ttM41Elc3cqf0pgTVnfqTnoNqiv7mnOlDEsmhPWN2tSmQx7H6mieNZQ==
X-Received: by 2002:a05:6402:4306:b0:4bf:b2b1:84d8 with SMTP id m6-20020a056402430600b004bfb2b184d8mr8906008edc.19.1682061442438;
        Fri, 21 Apr 2023 00:17:22 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:668b:1e57:3caa:4d06? ([2a02:810d:15c0:828:668b:1e57:3caa:4d06])
        by smtp.gmail.com with ESMTPSA id d21-20020aa7c1d5000000b005027d31615dsm1525564edp.62.2023.04.21.00.17.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 00:17:22 -0700 (PDT)
Message-ID: <9ce1e719-9bfe-cba3-ed8d-fe9dcd1abc8a@linaro.org>
Date:   Fri, 21 Apr 2023 09:17:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v13 1/2] thermal: loongson-2: add thermal management
 support
To:     zhuyinbo <zhuyinbo@loongson.cn>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>, wanghongliang@loongson.cn,
        zhanghongchen <zhanghongchen@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
References: <20230221095355.9799-1-zhuyinbo@loongson.cn>
 <1af930f6-51ae-c986-3eeb-556b2fa34047@linaro.org>
 <070bd997-b70b-ede1-fe71-dcf410aa3c1a@loongson.cn>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <070bd997-b70b-ede1-fe71-dcf410aa3c1a@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21/04/2023 04:00, zhuyinbo wrote:
> 
> 
> 在 2023/4/20 下午11:54, Krzysztof Kozlowski 写道:
>> On 21/02/2023 10:53, Yinbo Zhu wrote:
>>> This patch adds the support for Loongson-2 thermal sensor controller,
>>> which can support maximum 4 sensors, each sensor contains a sampling
>>> register and a control register. The sampling register is used to obtain
>>> the temperature in real time, the control register GATE field is used to
>>> set the threshold of high or low temperature, when the input temperature
>>> is higher than the high temperature threshold or lower than the low
>>> temperature threshold, an interrupt will occur.
>>>
>>> Signed-off-by: zhanghongchen <zhanghongchen@loongson.cn>
>>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>>> ---
>>> Change in v13:
>>> 		1. Add a description about that how works the sensor.
>>> 		2. Drop the COMPILE_TEST.
>>
>> Why? We want to compile test. We really, really want.
>>
> 
> I noted a commit "8df4ef3eaa62b" that accoring to Daniel's reminder.

The commit is for OF! That's not the case here. Your driver is limited
to chosen ARCH.

Best regards,
Krzysztof

