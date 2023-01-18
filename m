Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A76672A5F
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jan 2023 22:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjARVZP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Jan 2023 16:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjARVY4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Jan 2023 16:24:56 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802F3630A6
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 13:24:54 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so2320872wma.1
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 13:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DCqzYAGXvRtLAjxxpIF3ytH9cKaozsC7FyVAZziQiDo=;
        b=gfxbRG1yS40vpY4OIJpTCM55FK2tNlgVC3W4IiUqmcDXKHDbnfBMUjedMFCMH/ZmZm
         xVIZuPpExGHeQrAHweuH9rTmR8wUxB3itqMKziuxXoGXkvi2jMqPSeCMQg7bNPhCDWce
         6UFXL1IiuT0W64K9DoXmXC/1feGZ54IEKshK8tODRcK6CfwRt+kgoyB4a7GgVNx9YpF7
         yhEM8dgTL1DTteFh1g5IaB2xTwlFibaf3QyIMmgLvhoNoZVg6Mz8cKOF3myTRb1BBQdJ
         0iK/bjE1fCFVIWZEv3rRAW3PWAsO+E6aGaxeEun98X25tflOL2BAqAxW0XFOsUHC+VeE
         oLbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DCqzYAGXvRtLAjxxpIF3ytH9cKaozsC7FyVAZziQiDo=;
        b=0DCH9aoEkGKiqLGC+jrQQK6RgDDLAGWZFtrAMfi3mBr+/cQglzQ22JyhOcmk/lPrdM
         IiVYfxv3zufvEP+JhFH5Hs/JLO1YGqMXxVmh8fWOXpkAWaQo+dh01doD3kCabvO1S+DJ
         n1FGS5VoG7kebuVgPVcx+0cXeAzIFORn0JN7HFzs4S+baVntibZrvARfW3YQXEnBeod+
         tulAMnM7r0JfbEpfoASezfd4AnawukZH2bWfvCZPe9W4fkPxwdQmIeIoGX/IVy2+ojYZ
         DC/CXl5hywxu28qRYyPhKhLp/l2lehe1KQK00XpEEzR8b1f7plJ3pDSD0Rs7YkrKlVpu
         gm/g==
X-Gm-Message-State: AFqh2koENQyx2H19R/75I7+6rzjGNpTcoIScL0PD3GvNL1/UAHygKEcS
        bF3AjlkWwgUoU8p20OKxhNOslA==
X-Google-Smtp-Source: AMrXdXvfYwcENXAPvZFHMl2qo8K6r2Sx9rcaaEI21AAl3zPp9Z0PAa1TFXYyvwNQO/hm+b5a6MHzvA==
X-Received: by 2002:a05:600c:1695:b0:3d3:4ae6:a71b with SMTP id k21-20020a05600c169500b003d34ae6a71bmr7849969wmn.2.1674077092997;
        Wed, 18 Jan 2023 13:24:52 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id v20-20020a05600c215400b003d358beab9dsm2910677wml.47.2023.01.18.13.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 13:24:52 -0800 (PST)
Message-ID: <42badcdd-771e-ac4f-77b3-8c40e12ebcc9@linaro.org>
Date:   Wed, 18 Jan 2023 22:24:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: =?UTF-8?Q?Re=3a_=5bPATCH=5d_thermal/drivers/rockchip=3a_Use=c2=a0de?=
 =?UTF-8?Q?vm=5fplatform=5fget=5fand=5fioremap=5fresource=28=29?=
Content-Language: en-US
To:     ye.xingchen@zte.com.cn
Cc:     rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        heiko@sntech.de, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <202301181639300333679@zte.com.cn>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <202301181639300333679@zte.com.cn>
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

On 18/01/2023 09:39, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>   drivers/thermal/rockchip_thermal.c | 4 +---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

