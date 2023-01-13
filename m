Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5212A66949D
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jan 2023 11:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240413AbjAMKtV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Jan 2023 05:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241328AbjAMKre (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Jan 2023 05:47:34 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FD43E87A
        for <linux-pm@vger.kernel.org>; Fri, 13 Jan 2023 02:47:33 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id v2so9668983wrw.10
        for <linux-pm@vger.kernel.org>; Fri, 13 Jan 2023 02:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nCKq+3CeXspv0d8FXq+drklgU4PqbEbjubXP8s8ISNY=;
        b=zQM1ROKNS0lv0njzO8IlF8kS6u62cYpa9djllCqR8EyFB9jz/YeZGIIzf1YTPzEA3u
         RW9uZMnjVnS/JQL3Eew3HhXn2Zx0cKtFUP9oUkFR0NWErEjkNLq36WuC9R8X1xqjrzgm
         oh9wT/ZZFN2QFWVQtfF5In4t6K66RWlY8Fd7pJtyX0HXnbORsSthKyk0Tap1DxSCRwgV
         Z1EgvJhEqTgB9B+nE+HMKPPisuu9XfHKMYg1qRS8qV1o1SQ59HzLeLwQNC557YoKjjVn
         boei+WiOLV6zYg1b6KaenzPWMUI+MhTEJ0FDH8kSnOz0UTTQWRBr1RFtRPevT0rBS2U5
         DuPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nCKq+3CeXspv0d8FXq+drklgU4PqbEbjubXP8s8ISNY=;
        b=rkYAOVnCt9WyTydcZRZhoRGNH0C1eXcELCJr0kjOEy2xc4nV7s2aWBbmJ7jFJ6wn+K
         uUuhZXfYX4BQJbgoa9LRxhc9BWP7WtYlDlyPMK7Ufws2+lAxJqRqpTjGc1D5174apaUT
         P+6EJYoftjrcqOQM1ZkRsfHWkcDlk9M288mtZTCQ80VIikIIChgrgHtTDVg9v0cdC/Ql
         dZSAeBbbZ0sDQ2hDpiM8rfsZenwPV5eubcTCplogGZ693Vgawdq5kAjzSdQsNgA08h9z
         5enLD5ppGAZgpSkiVEuJKg5yhh2qVcwYNoFscrjt5d4eyDz8zWTxPZJAtnP65hakYoF7
         apww==
X-Gm-Message-State: AFqh2kqJKFcnVaWFKB2n7OhYd6vBJpqUBsaAs2dR3jDPoC8HyoWRTxBh
        ParKPn1jo6ftwhn7ngt7ibN1lQ==
X-Google-Smtp-Source: AMrXdXulZs7fMY6nmb7bBhCC1eHU5O0QOYBucr/XwAPS1BKnehd+EoVOMBDJsbVYl/P6L2fkBk9RkA==
X-Received: by 2002:adf:fad0:0:b0:2bd:e539:46e0 with SMTP id a16-20020adffad0000000b002bde53946e0mr781170wrs.46.1673606851768;
        Fri, 13 Jan 2023 02:47:31 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id n10-20020a5d6b8a000000b002425787c5easm18553532wrx.96.2023.01.13.02.47.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 02:47:31 -0800 (PST)
Message-ID: <3dc0b861-04fe-317e-9c9a-39c238b71dd2@linaro.org>
Date:   Fri, 13 Jan 2023 11:47:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v10 1/6] thermal/drivers/mediatek: Relocate driver to
 mediatek folder
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, bchihi@baylibre.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
References: <20230112152855.216072-2-bchihi@baylibre.com>
 <202301130353.wbXPctIq-lkp@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <202301130353.wbXPctIq-lkp@intel.com>
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

On 12/01/2023 21:08, kernel test robot wrote:

[ ... ]

> All warnings (new ones prefixed by >>):
> 
>>> drivers/thermal/mediatek/auxadc_thermal.c:562: warning: expecting prototype for raw_to_mcelsius(). Prototype was for raw_to_mcelsius_v1() instead

That has been fixed by:

https://lore.kernel.org/all/20230113064449.15061-1-rdunlap@infradead.org/

and applied in the thermal/linux-next branch


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

