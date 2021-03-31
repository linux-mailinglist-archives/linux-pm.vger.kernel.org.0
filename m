Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1343504C2
	for <lists+linux-pm@lfdr.de>; Wed, 31 Mar 2021 18:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbhCaQhL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Mar 2021 12:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233966AbhCaQhH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Mar 2021 12:37:07 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0324C06174A
        for <linux-pm@vger.kernel.org>; Wed, 31 Mar 2021 09:37:06 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so1470543wmj.2
        for <linux-pm@vger.kernel.org>; Wed, 31 Mar 2021 09:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TnvnZxOACqCq+A8twXUOuSk4g7qmxy4JPsXlvzDSCsc=;
        b=rVpz048TIOhPnZDI0bFHdGqg55LctDMZMTVOT50l44L5oV4G7tLmigNzUYIXcdhhpd
         Oyz//g08P72Um05QQaR18j89EZ11DwdlpvhfuZRQXC8BofyTZjos8+s4a0fds6WCfKu3
         wGxpnvsF1hHt/yJ2vz6haC53ujxLVDfC7iif46SeiDVhbcUdO0gOGKb6KMs6ln3EQSZk
         DV2RzlGaguhQ+Y3irWAffBKKphz1FiPRMdsK0muP8RwChE/EsZPA+JL+S6YPua6hvhSR
         viCRJJlsG9OkYuTObmyLtCUv3lh6V0pVmG7fpk9gNkpSGICsZTGhwwqfF0dpiRVb+ktm
         Tblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TnvnZxOACqCq+A8twXUOuSk4g7qmxy4JPsXlvzDSCsc=;
        b=bqTkjvtizMXhFTeVizFkYCq5HXgAptdWivxAbxIBqxUroTsLz0sm6kXYkPOujstU43
         kqqBeRTJnOsBcxSlHNY9dap2zkXrIluAsh6iSMqn/v5bOthaKijLCCwHeNf6oS63khNN
         AFNLo87yP9dumlDPbMeNTwO99Qow17XoXIyqkbenDmxxymzWOMAnRQwwhbbV5DZwGO+F
         Vw7LzdIFolYSUICiso0BTbzW6C8h5B0l4NupfWUZTUtfj8alAQArF2K8nyor2JhKPwd1
         pA8MnlfQp41F1Tzld8EibTamiYU1z0oyeR45UjF9nowDmY6keVhil9Sq4b4qBJRLQULI
         8JTQ==
X-Gm-Message-State: AOAM533bkgxXWMq+6doRgBjSEnJYqzCU25j3Iij8Nc6GQdhpMRX9TxCw
        PpxEA5f0SJZ5pfBLEQ9qioPD0w==
X-Google-Smtp-Source: ABdhPJz10HL+5/BOj1Bk7HPn6MnV8AJUkitxTA4JqmwUj3KT9mJHDIeqkbfrMVp0zqjv6uSNDkz5Wg==
X-Received: by 2002:a1c:3c8a:: with SMTP id j132mr3861932wma.127.1617208625431;
        Wed, 31 Mar 2021 09:37:05 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:1573:1dd5:899d:6362? ([2a01:e34:ed2f:f020:1573:1dd5:899d:6362])
        by smtp.googlemail.com with ESMTPSA id q207sm6798719wme.36.2021.03.31.09.37.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 09:37:04 -0700 (PDT)
Subject: Re: [PATCH] thermal: ti-soc-thermal: of_device.h is included twice
To:     Wan Jiabing <wanjiabing@vivo.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>, Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
References: <20210323021430.141218-1-wanjiabing@vivo.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <9d835b9f-e687-ff6a-89d3-3e15f95b0f83@linaro.org>
Date:   Wed, 31 Mar 2021 18:37:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210323021430.141218-1-wanjiabing@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23/03/2021 03:14, Wan Jiabing wrote:
> linux/of_device.h has been included at line 25, so remove 
> the duplicate one at line 35.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---

Thanks for your patch.

It was actually already fixed [1].

   -- D.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/commit/?h=thermal/next&id=7440e912b0fe755d80b958a65859ebabb5338cf8


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
