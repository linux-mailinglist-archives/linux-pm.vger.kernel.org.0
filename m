Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEED2078E7
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jun 2020 18:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404501AbgFXQSX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jun 2020 12:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404431AbgFXQSX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jun 2020 12:18:23 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1F6C061573
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2020 09:18:23 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 17so3101681wmo.1
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2020 09:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ep4axTkVGVLCuhtuT35jZm6JhAHbveyPDFnU1RqKcwk=;
        b=kCQk2B5n3euUJtKQUmXdSLEj18Epwj/MT4SbLwc2X2yoiWvBfc6DwFfbX01zqCWPgw
         ZSR/JwfcZCdfMA86UwospdQbGDBXTljQVW5u4WjzFaPNEjLrqr9TXcU0CT/LDquUIpj8
         RhB6/mmO9vw52a1u9onC9yOeh7cVEFukdKAKy075lSgxV0ZX3nKRZe17g/tnuufbgq/I
         fy3Pg4wTH4t4DZVjtj3VA0LXlp71YV2gglpwEWYenGt8PvuC3maTyXTmYkdCcR0plkOh
         V/gib2puLtCIKQBDl6Em7qrvsIteftBYRGbp2+kyFlV+W7hLYAESg5m0aSHs80u7c2wo
         jCAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ep4axTkVGVLCuhtuT35jZm6JhAHbveyPDFnU1RqKcwk=;
        b=g4c9FN6dYQmTwe6bpNPiuiP1f+TowlIfQlmcf4Pd8Xqc/esHRmTBMNaTPLVWM7C/x0
         BUOiAy8ATBjUuHurrYSmA4yShwZpO0HkTOfNPBUB9QM9WDlN/AaS6RKvl8nRld8iOpBg
         tOa74mgpzpTU0QetAx4uJZdf38+ot/IdY2cNDsXEbq1gynyaE/UQFf5C6WqLWpUJAcqN
         cykj2/Zv7XzeOJziG0Db2hW7pHXopsZ7s27FW1a/SYghAw67rh1Ju4PYtpEAK0BYvG1A
         aaH++UOp0eIs7Dr4QFG35+209HkyakSziYRdEpy5C1Z33J26gN0w3BF7OktiD1RMZrDL
         f2nQ==
X-Gm-Message-State: AOAM532VS55f3Fi/SGePpLLQpQNwrXfiJSGTZMlQaAvpNjtKYEODJsHY
        Viy8jWOdqydh8tL0JQbj7bFlwQ==
X-Google-Smtp-Source: ABdhPJywrZdrK8cLnjsmr7ze8a6BieFMrMQGdWM/h1IEYFHJJd7qz4Cypeu6xovAeVfEv4wDgJ5Jpg==
X-Received: by 2002:a1c:6102:: with SMTP id v2mr29243006wmb.6.1593015502060;
        Wed, 24 Jun 2020 09:18:22 -0700 (PDT)
Received: from [192.168.0.41] (lns-bzn-59-82-252-131-168.adsl.proxad.net. [82.252.131.168])
        by smtp.googlemail.com with ESMTPSA id q128sm8525304wma.38.2020.06.24.09.18.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 09:18:21 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] thermal: add support for the MCU controlled FAN on
 Khadas boards
To:     Neil Armstrong <narmstrong@baylibre.com>, lee.jones@linaro.org
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        amit.kucheria@verdurent.com,
        Amit Kucheria <amit.kucheria@linaro.org>
References: <20200624161528.12664-1-narmstrong@baylibre.com>
 <20200624161528.12664-2-narmstrong@baylibre.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <b2c3e3f2-21dd-2fe1-bed0-8576bb2ffcc8@linaro.org>
Date:   Wed, 24 Jun 2020 18:18:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200624161528.12664-2-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24/06/2020 18:15, Neil Armstrong wrote:
> The new Khadas VIM2 and VIM3 boards controls the cooling fan via the
> on-board microcontroller.
> 
> This implements the FAN control as thermal devices and as cell of the Khadas
> MCU MFD driver.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
> Hi Daniel,
> 
> Is it ok Lee applies this patch via the MFD tree since it depends on
> the linux/mfd/khadas-mcu.h header ?

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

[ ... ]

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
