Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A61A40F81E
	for <lists+linux-pm@lfdr.de>; Fri, 17 Sep 2021 14:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbhIQMmr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Sep 2021 08:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbhIQMmq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Sep 2021 08:42:46 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAC1C061574
        for <linux-pm@vger.kernel.org>; Fri, 17 Sep 2021 05:41:24 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id y132so7237298wmc.1
        for <linux-pm@vger.kernel.org>; Fri, 17 Sep 2021 05:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8L9xblep16e49FpEMcjJPX36O9S5sP+1ZMCJZZAcM1A=;
        b=Zlg0RMyIUnruJRCSbzsnLq+eMG0/29T8sAkvtM0RTiVz7OXX6hiuq45yVy/ffP9kAG
         fK/F+rRdLOXORF6WTah3UjmgLA4hI4yiHlaZcpYoUgKSchd0v3IAzqkDZT6tqTBnYM3M
         AD/j+mLGwzIn6TANVTYoDeOXh74nmXJzhF1BZxy4l2FIrj6DSnb4MpBjZCzjCPHapXLo
         f0fLGvHJ5OoERVjXJ5w2uVlIfm+p9efPfiCg7p0sAvpyKEmgduFHA//+XnOBsL2E+EyN
         CbSMN+cBxx1HRHywTA7g09A0LeoiWuLy/aCNh78rknd+vZBNqHXjX/TZ0YmHH5ZHc35S
         nPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8L9xblep16e49FpEMcjJPX36O9S5sP+1ZMCJZZAcM1A=;
        b=cEfq7DArNQ17IAEzqUSqqKjEpjP4+fxOazuTI2xIKyaDDIjoxbT2Cr0SJWqH7PLsz/
         /YFenRXG3Tql17N331LaMC78q4mUtmHgWv6Bi9i3cOQKt43rxX/U2g12mUEqT/Q2LWQ2
         lNFcTyiTRmWNn/1p+T8Uu+Cd285+4RLJppVP+6Pf1T8L6dc5oRZyER9oyjaS34Qpn3GM
         wfO7jGY2Gko0r5MeUTp8a12oLWY/Wkg/JBMB/UaaQ6MwwR4V26XGxOkFKxF+AWjMTmOO
         aE1t1LCX5Pjk0U86YqFmZt4PRCzKK1QtuXqNo6eowCWs9NyYf6zUvg//MM+kljT7ylUV
         VOYA==
X-Gm-Message-State: AOAM531/W0uAfJyqrEj9RGownPOYxA0RrFyhiMaQt8QS9FH7HFG8K6j5
        P6KkGXCgFLux9I0cSeFkqWvrNTxctISGcw==
X-Google-Smtp-Source: ABdhPJzzgR/rHp5puKqSVZrzAs1oIA3JRcqHIp0G7enBP9XWkQb3cpkstNanbqrUyOKT1qlRTkZAtQ==
X-Received: by 2002:a05:600c:414d:: with SMTP id h13mr14924930wmm.121.1631882483259;
        Fri, 17 Sep 2021 05:41:23 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:6b11:6374:882d:42a0? ([2a01:e34:ed2f:f020:6b11:6374:882d:42a0])
        by smtp.googlemail.com with ESMTPSA id l26sm10532391wmi.25.2021.09.17.05.41.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 05:41:22 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Add a generic virtual thermal sensor
To:     Alexandre Bailon <abailon@baylibre.com>, rui.zhang@intel.com,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.tseng@mediatek.com, khilman@baylibre.com, mka@chromium.org
References: <20210917072732.611140-1-abailon@baylibre.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <bd347d14-0b42-f9ed-bf15-080c929e1cb7@linaro.org>
Date:   Fri, 17 Sep 2021 14:41:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210917072732.611140-1-abailon@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17/09/2021 09:27, Alexandre Bailon wrote:
> This series add a virtual thermal sensor.
> It could be used to get a temperature using some thermal sensors.
> Currently, the supported operations are max, min and avg.
> The virtual sensor could be easily extended to support others operations.
> 
> Note:
> Currently, thermal drivers must explicitly register their sensors to make them
> available to the virtual sensor.
> This doesn't seem a good solution to me and I think it would be preferable to
> update the framework to register the list of each available sensors.

Why must the drivers do that ?

> Changes in v2:
> - Fix some warnings / errors reported by kernel test robot
> - rename some struct and functions with a more accurate name
> - update the dt bindings: rename type attribute to aggregation-function
> - factorize a little bit the aggregation functions
> 
> Alexandre Bailon (2):
>   dt-bindings: Add bindings for the virtual thermal sensor
>   thermal: add a virtual sensor to aggregate temperatures
> 
>  .../thermal/virtual,thermal-sensor.yaml       |  67 +++
>  drivers/thermal/Kconfig                       |   8 +
>  drivers/thermal/Makefile                      |   1 +
>  drivers/thermal/virtual-sensor.h              |  51 +++
>  drivers/thermal/virtual_sensor.c              | 400 ++++++++++++++++++
>  include/dt-bindings/thermal/virtual-sensor.h  |  15 +
>  6 files changed, 542 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/virtual,thermal-sensor.yaml
>  create mode 100644 drivers/thermal/virtual-sensor.h
>  create mode 100644 drivers/thermal/virtual_sensor.c
>  create mode 100644 include/dt-bindings/thermal/virtual-sensor.h
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
