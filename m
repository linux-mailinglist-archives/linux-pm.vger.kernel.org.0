Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17CA679EF5
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jan 2023 17:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbjAXQk5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Jan 2023 11:40:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233521AbjAXQk4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Jan 2023 11:40:56 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8524862E
        for <linux-pm@vger.kernel.org>; Tue, 24 Jan 2023 08:40:31 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id l41-20020a05600c1d2900b003daf986faaeso11400249wms.3
        for <linux-pm@vger.kernel.org>; Tue, 24 Jan 2023 08:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p5CdgtjGUNx9xYKIZte0y4ycWmDexwRQIUIxQ6tWTHs=;
        b=jgDjdQPlJG8loqFBlxuut9n3wmlfn5rGbQgVG5K7Q1eg4kNWPatML2H8jtVpBxAKcH
         u1Uhdf9VthDHJEWPvMJTNREwwLkvoyiJaXqmq4DYB8pe110wm/ss1xlvUU0eaxFuT86q
         pXQd8hJVugzlAv0HC3axvtp2QiRH1wUo8B5yTss+Nh7zfvr1iMXQFznVTJoW9z39arln
         OstIuuB+8fU3wyvAcqq0I8tG5nYX/eGfIEvqQkOi3HVDzfmSKwEQ2qDfaicJc/uNbppC
         Vz5NIRyKZTmVmJDXPCAKKr/karh8H51LtK2i///upRc1qXxo5radFtAu6HrW9GQpESDo
         GSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p5CdgtjGUNx9xYKIZte0y4ycWmDexwRQIUIxQ6tWTHs=;
        b=60iYIchUIJ6Uhmd1Q4fGhxti/MZr6yDDixCnvCc/N490COYqe/XNtsprPha0UZbBwQ
         IagSLDwt9sXJInGgj9ndomA9AYh9WOoycnajYaVLKPWlV4EG16EQocXZSd5aPmlDwsgX
         g+IYLT8DX+Tcaszo8AC0aFiQdkSzdNkFKTnoNj2SnP7bUiPAk3yTPsPn0DLcCAN/WKNw
         HDcu9I7ZTu+02vWF2D1KAUhuDicu0kKNEA6Tt2W4A9BKUIFqE3GgPPjy9S/SN2BtnrLZ
         WPmKcElbg/q4nAnE84/IAPXNkhMnjYfjIlvxBZ3ygLb8ab9la9B+B/znufuKcIzjHlaY
         UMvA==
X-Gm-Message-State: AFqh2kqt5chUHvh3c4oSkron/yvdI7WyOMFmXWdNCxGCkhBrdkc6z2lj
        JvtPMZsQ5Z1g+r2QR9WCpO1RcQ==
X-Google-Smtp-Source: AMrXdXtIPLw44bxgX+91criAbr8NNm8pepLZdVXuERkZ0SBD4iC8yciSfrm5O9rovH83qq2SeMSI1Q==
X-Received: by 2002:a05:600c:3488:b0:3d2:370b:97f4 with SMTP id a8-20020a05600c348800b003d2370b97f4mr36445797wmq.16.1674578429812;
        Tue, 24 Jan 2023 08:40:29 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id o4-20020a05600c2e0400b003db305bece4sm2315561wmf.45.2023.01.24.08.40.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 08:40:29 -0800 (PST)
Message-ID: <1f70f2a2-3bc2-586f-67da-76b1c8379ff6@linaro.org>
Date:   Tue, 24 Jan 2023 17:40:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1] thermal: intel: int340x: Fix unitialized variable
 error
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Dan Carpenter <error27@gmail.com>
References: <2685606.mvXUDI8C0e@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2685606.mvXUDI8C0e@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24/01/2023 17:38, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If PATC evaluation fails in int340x_thermal_zone_add(), trip_cnt will
> not be initialized when allocating the trips array later.
> 
> Address this by initializing trip_cnt to 0.
> 
> While at it, move the status variable definition lower for better
> code readability.
> 
> Fixes: d58c653e9e26 ("thermal: intel: int340x: Use generic trip points")
> Reported-by: Dan Carpenter <error27@gmail.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

