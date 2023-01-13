Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F3B6693EC
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jan 2023 11:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240868AbjAMKUm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Jan 2023 05:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240464AbjAMKUh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Jan 2023 05:20:37 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C706A0F7
        for <linux-pm@vger.kernel.org>; Fri, 13 Jan 2023 02:20:33 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id m3so14947652wmq.0
        for <linux-pm@vger.kernel.org>; Fri, 13 Jan 2023 02:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qeK7zBle1ZG8rV3Y7IGNN3bCq+zsGncHZ2BZANEY/2E=;
        b=u90TOsedAG5PruNssZwJ3VR4f6qnkzc8XgchIvdKCtH/wj87kHdywB1sloPpydYhP0
         IyWctUAbUQJQw0K7kh4NgC342XKpyMnM5buQ7TXSeVEjZq0ecOzYCvgkyuYh1pBAt5N1
         jIyBszkYXbKNXKy0EkgTPiYkKrkIE1TPzUkPHZytlYplu+BI1D8lJ9Xj1UukoqlZuv25
         yRNHjXWgp7h3uKBMPhHg8kNzoA6ZIsUOOLVu7c6kyNsf4tCe5gdtvfiS8O185EXX3cAR
         qbmVI5Iz3+dZIyzeZFB0Lx4P40QlWIkvtmBymBZkj4bJQd48hKvhuJ2uy0s+J/s92/Fz
         clSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qeK7zBle1ZG8rV3Y7IGNN3bCq+zsGncHZ2BZANEY/2E=;
        b=YSYcJkqmISbJ8527Tr5ZwG3CKnIGYRcIs8L1PcFMFUGa5fhcWscGnhvMevB0R6F5kt
         KkPNDrjyY3DUB3UCA9/oCFVLeTb3AqeNy3FIqEacb6Z6aczU0dnfGfOqMqz0Pjxk9yc7
         cKqqvRVBvI8RUPMLYrQUb+6mzQtYcWS1Pb1HGZ8Kykfjy/YZdlsXQVU3P6uHJ/WknfrA
         bPFYPJ8bAb6B4ilzfEyu4gYMy1TDBioKghRH4dI5A/9ck7Tfi1BqP0OkyhuKXbKcc04s
         tiqgC7TDuximkRFl3I+JnMVYN8UanKdMjesuy62XEVMbviehSO7HgsuH7NCd6mFIyJYv
         GIkg==
X-Gm-Message-State: AFqh2kopE50r/tExYExMfXJ6moFygGGnyVYU+9YKAaLKX0ILQDUYFPE6
        dksHcKDgnBDC39YuNuhAcugPoA==
X-Google-Smtp-Source: AMrXdXuhhYEJ7t5G1KF89cVh8Tloh/FZBKX5kD0tp9/HIy0e3XB/M1kRbQYwrXKq94eyzY1a6QkTYQ==
X-Received: by 2002:a05:600c:4e13:b0:3c6:e63d:fcfc with SMTP id b19-20020a05600c4e1300b003c6e63dfcfcmr57949084wmq.35.1673605231785;
        Fri, 13 Jan 2023 02:20:31 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id c18-20020adffb52000000b0025e86026866sm21746450wrs.0.2023.01.13.02.20.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 02:20:31 -0800 (PST)
Message-ID: <35b1b4bb-dcbd-3c71-5619-775677721898@linaro.org>
Date:   Fri, 13 Jan 2023 11:20:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] thermal: rockchip: fix kernel-doc warnings
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20230113064500.16103-1-rdunlap@infradead.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230113064500.16103-1-rdunlap@infradead.org>
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

On 13/01/2023 07:45, Randy Dunlap wrote:
> Don't use "/**" to begin non-kernel-doc comments.
> Convert one function description to kernel-doc format.
> Prevents these kernel-doc warnings:
> 
> drivers/thermal/rockchip_thermal.c:64: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>   * The max sensors is two in rockchip SoCs.
> drivers/thermal/rockchip_thermal.c:179: warning: expecting prototype for TSADC Sensor Register description(). Prototype was for TSADCV2_USER_CON() instead
> drivers/thermal/rockchip_thermal.c:1342: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>   * Reset TSADC Controller, reset all tsadc registers.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Amit Kucheria <amitk@kernel.org>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-rockchip@lists.infradead.org
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

