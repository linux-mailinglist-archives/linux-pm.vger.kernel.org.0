Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA7C641DF7
	for <lists+linux-pm@lfdr.de>; Sun,  4 Dec 2022 17:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiLDQkX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Dec 2022 11:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiLDQkW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Dec 2022 11:40:22 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F11E1E
        for <linux-pm@vger.kernel.org>; Sun,  4 Dec 2022 08:40:21 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id w15so15308991wrl.9
        for <linux-pm@vger.kernel.org>; Sun, 04 Dec 2022 08:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wbNKJgqamf76QS4A7riHRQ/K/kQjFtOAWIhBQTumKHQ=;
        b=xHGdBi84weUIxIzDT1mYhxwPaFtjMpVnPXMwVxTFMk7BsowhXoG0D+2gWtYa8z4h2d
         3pEmiAP1v1p4mmjjSOtZOGg8n+9uQpo+6sRaaVXtEntR5fdes3m/JKSvT8+uxrHweGoe
         xxHls0AWWr+ZGFrCoaOlcl8qcHF2zKEAhhGKxH5NDD/b/6tSrRV3DvBOBqXnMaTllqu2
         ZKLKy/5zkflIEB8bAC2OOjVpa4tfCvqJ/Ln07AZlgU2zlwc4FEplE+qgZGtLZGqrF703
         PpM8kVKCZTuYhdaLowtdnOkoBwiv/2O1WTpfzT95IJh0yfUXUWdspjLiqzgSYPobxVRl
         wBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wbNKJgqamf76QS4A7riHRQ/K/kQjFtOAWIhBQTumKHQ=;
        b=lkxRt+3kP0ogTs05TdHcJDcBoiSjXKwtrTeMWxWsoRSJc2P+SPhcyLK8Ij6gttOYyt
         +fab8T6BYX7iHf2gcAzDDIhked9MryNYMpe5ucrQj8xTkRIQo+j5D8LjX1mEUHjWWjny
         LiaW90DXk9XPvBY3BAWcPmlO4DDA7BKQzStnNVWG9BuCgvPzoOKNGuBxaV9U4IpNTF3s
         /7WlUqASUCV/PcGsCTko8N4nwM5eXOfGUSG7WEfF2hZ556a3itQ8/+4Hdw5iiE4fZ/gC
         ODFGL2OwZCI7zBYF8j0f3cjRxhHJ/R7nCVSMg7tdXhI02gpASG+eBjll+xdFT4wVRlhI
         C1xw==
X-Gm-Message-State: ANoB5pkedphIV87SPC9G+uph4PGTycMep/7Qk/QYS1B82A/RCHVtezWU
        BMld+i0vjzqas4sJmkwdnLbdKQ==
X-Google-Smtp-Source: AA0mqf5pX7sHWt7L7PETaiw7GUTCGcD+YISEEYnvFmfUMY9ugjib98oKRwTOzTkkFV1fgorTt7rgbw==
X-Received: by 2002:adf:efcb:0:b0:242:5ff0:6d8a with SMTP id i11-20020adfefcb000000b002425ff06d8amr1553837wrp.135.1670172019766;
        Sun, 04 Dec 2022 08:40:19 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id l9-20020a05600c1d0900b003cf878c4468sm21165858wms.5.2022.12.04.08.40.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Dec 2022 08:40:19 -0800 (PST)
Message-ID: <c2155e23-d381-c4fb-f98f-be505665f49a@linaro.org>
Date:   Sun, 4 Dec 2022 17:40:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] thermal/core/power allocator: Remove a useless include
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <9adeec47cb5a8193016272d5c8bf936235c1711d.1669459337.git.christophe.jaillet@wanadoo.fr>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <9adeec47cb5a8193016272d5c8bf936235c1711d.1669459337.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26/11/2022 11:42, Christophe JAILLET wrote:
> This file does not use rcu, so there is no point in including
> <linux/rculist.h>.
> 
> Remove it.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

