Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03D4E8941E
	for <lists+linux-pm@lfdr.de>; Sun, 11 Aug 2019 23:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfHKVOe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Aug 2019 17:14:34 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55763 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfHKVOe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Aug 2019 17:14:34 -0400
Received: by mail-wm1-f66.google.com with SMTP id f72so10396828wmf.5;
        Sun, 11 Aug 2019 14:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PszWHvsLW/V6ZIB/afDy1WXCmSMBx8K80OqoFKRpWh8=;
        b=fG0PSTuiukHcjUI+CKoLX7LrppjKawyg62flNpJVoVJ2lP7lZog5dTPwS5OPLR1MVR
         3FT/iTW7ksED0tg9OZQOM2mpg7vGPo3/qP+uLF9XVIuPwokNkX0MvbHgDOz98rUnIWE8
         LpJSSfaxStjdJitospeus04UjuJFKB8yO9OtPc4oLPLhb7T7WTuzQLHyiMATekCdiscL
         T+sURDuZAlMXOj7aHLeYQB1ZFUBsFClhxb6lrDpJf+7hl6LITkpN1otjp5NErC9kpaqP
         asTQAxmlwm/HYJMQaaDFCbN8nZayFZtPUMBEjh2Qh+j/3kWglrmD6qB410Fzrkoo6RFk
         gGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PszWHvsLW/V6ZIB/afDy1WXCmSMBx8K80OqoFKRpWh8=;
        b=K4aM5mYb/9YtSvDC3JeZOsrWIOY3vUAVwPPXqcg1Ypf7vUaX7U94w/uume7gT+sRaF
         EXPAQCEJxTfvzmKq8vusP/tffUcdOwQ1CnLR1YmzdC0jfQudgXs4YNDn0AfRiGzbOEc3
         wuGx/r13ViWc7BoMjcng3sZNjOx7riq9p/dPp/Bs5R/sfGiqGcj3nmyn+gdCZRPcQ2Vv
         2JRQQEDmkODlN6/1h8q8SOLCtW4Sr2U9n6vo6rvlDZqyTLM3cIYLqDSM2ReuIM1NhHEI
         Z5c5oJpd7k6GmwvrSwkQyz204UBj+CtxfWPlAutzqA2UCDqiJ2XN80dtfrSUn/SKiYT2
         sCTw==
X-Gm-Message-State: APjAAAW7ldMANCFVt4kW8aVxBFfM+9ioNtJVJ9O2NZfdWq8dl5RpTb2m
        14WOLSzeL9yvNC8YOe5TN7JK28fxbwbv8g==
X-Google-Smtp-Source: APXvYqzH7S9vOiayMX06yEUTN1laxhsJ3ePYWknAWl8ojDlgYEwAhy1f7wQcZAvlXBJybcSJoh9W9Q==
X-Received: by 2002:a1c:a6c8:: with SMTP id p191mr23065963wme.99.1565558071411;
        Sun, 11 Aug 2019 14:14:31 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:1f1:d0f0::4e2b:d7ca? ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id c15sm46855416wrb.80.2019.08.11.14.14.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 14:14:30 -0700 (PDT)
Subject: Re: [PATCH v5 00/18] add thermal driver for h6
To:     Yangtao Li <tiny.windzz@gmail.com>, rui.zhang@intel.com,
        edubezval@gmail.com, daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        nicolas.ferre@microchip.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190810052829.6032-1-tiny.windzz@gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Message-ID: <f479c162-4eac-f320-3583-b9ddbef79b1a@gmail.com>
Date:   Sun, 11 Aug 2019 23:14:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190810052829.6032-1-tiny.windzz@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Yangtao,

On 10/08/2019 07:28, Yangtao Li wrote:
> This patchset add support for A64, H3, H5, H6 and R40 thermal sensor.

Could you add the device-tree configuration in the same series?
This will allow user to test it.

Thanks,
Clément

> 
> Thx to Icenowy and Vasily.
> 
> BTY, do a cleanup in thermal makfile.
> 
> Icenowy Zheng (3):
>    thermal: sun8i: allow to use custom temperature calculation function
>    thermal: sun8i: add support for Allwinner H5 thermal sensor
>    thermal: sun8i: add support for Allwinner R40 thermal sensor
> 
> Vasily Khoruzhick (1):
>    thermal: sun8i: add thermal driver for A64
> 
> Yangtao Li (14):
>    thermal: sun8i: add thermal driver for h6
>    dt-bindings: thermal: add binding document for h6 thermal controller
>    thermal: fix indentation in makefile
>    thermal: sun8i: get ths sensor number from device compatible
>    thermal: sun8i: rework for sun8i_ths_get_temp()
>    thermal: sun8i: get ths init func from device compatible
>    thermal: sun8i: rework for ths irq handler func
>    thermal: sun8i: support mod clocks
>    thermal: sun8i: rework for ths calibrate func
>    dt-bindings: thermal: add binding document for h3 thermal controller
>    thermal: sun8i: add thermal driver for h3
>    dt-bindings: thermal: add binding document for a64 thermal controller
>    dt-bindings: thermal: add binding document for h5 thermal controller
>    dt-bindings: thermal: add binding document for r40 thermal controller
> 
>   .../bindings/thermal/sun8i-thermal.yaml       | 157 +++++
>   MAINTAINERS                                   |   7 +
>   drivers/thermal/Kconfig                       |  14 +
>   drivers/thermal/Makefile                      |   9 +-
>   drivers/thermal/sun8i_thermal.c               | 596 ++++++++++++++++++
>   5 files changed, 779 insertions(+), 4 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml
>   create mode 100644 drivers/thermal/sun8i_thermal.c
> ---
> v5:
> -add more support
> -some trival fix
> ---
> 2.17.1
> 
> 
