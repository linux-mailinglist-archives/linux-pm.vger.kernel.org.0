Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2AD21DEDC3
	for <lists+linux-pm@lfdr.de>; Fri, 22 May 2020 18:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730571AbgEVQ5X (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 May 2020 12:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730536AbgEVQ5W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 May 2020 12:57:22 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9856C05BD43
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2020 09:57:21 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id v19so3472780wmj.0
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2020 09:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H0fk+YgnvJQdHJy1RoTIxISz+5f4dnnX1kWqMJdIiTs=;
        b=mJgRhNZUV8CHq1RmFWq7pxbyvsO0FpeEolI6sdLDMYOWVj7bN0R5fgJTzTQh2UAcMf
         W7g3g4Oi45lMempvhGJgtWGWviaNUQedF2O0PzS+CbjwXpt7q5HpHU5Fb9W/uVFkPd67
         X9f5FjJczWK80YgE51DwsqlAaMmapRlzlt2jZ2eBvFNCPZS7ouR+YOyc4YAIpS8xk318
         EXFub2WKjTNwwryAYe6wi8LYvaMb8CpMJgdNc7g3yKPqicUOJACJNLkUDgqS3tUY87PX
         kM3KUiwSsBRtX4d2YfXKdTZ63ZdlrExIimJuo8wxEGasLH5lrVq9ZoYGyBjjNAmPOCzF
         czvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H0fk+YgnvJQdHJy1RoTIxISz+5f4dnnX1kWqMJdIiTs=;
        b=HLbOu/qBmrlX/1+OTpYfpIrOLzK+gh+cQbwfNHHIAuIRKR6NM8M0UWKWOhQKWWwUuU
         FysM2K0n3rhEGMAEl+2CgEyJSDw1O9pjFAJ6mcNwFhaasjhBsFAJa/+/GTWEgssBkMml
         xZbLn6yC602RVUnoHObc6510QQ1S6D2eYDRzISj5fLnSlxLMgoCrSoZbPLpjGMZLjUgm
         dqfFMto5SyXo8SVLJmop9TcNuK5RvQ4nZXrtn08ttvNiLX+vwYT8gpX6MxsUNOJTLK8t
         KHH9SIqkke66DeeUspyM1XGercu7ABNiqSoxHhaQfGNnp/1HSn5o80Mqr2neR5TEwpqg
         fWpw==
X-Gm-Message-State: AOAM533Gxh6Yh/V4OKm8eCZ1wO7Nq1deTJvSrcn0nvCOeGvzsMyO4BL0
        EMM6U4tnZATLRufj6oGUuF9uMT6YOmJ1mA==
X-Google-Smtp-Source: ABdhPJzc7gjWBkYuh9qSlhxc3eMgYPGZvCjw95agKu8mdcnuOAzuJsZb0eW/lo8vLU77CVVsDE60BQ==
X-Received: by 2002:a1c:5685:: with SMTP id k127mr14863903wmb.50.1590166640540;
        Fri, 22 May 2020 09:57:20 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:a82f:eaec:3c49:875a? ([2a01:e34:ed2f:f020:a82f:eaec:3c49:875a])
        by smtp.googlemail.com with ESMTPSA id t14sm9673168wrb.56.2020.05.22.09.57.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2020 09:57:19 -0700 (PDT)
Subject: Re: [PATCH 4/4] thermal: qoriq: Add platform dependencies
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Jens Axboe <axboe@kernel.dk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-ide@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200507112955.23520-1-geert+renesas@glider.be>
 <20200507112955.23520-5-geert+renesas@glider.be>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <e4a72b09-52e5-d145-2b64-50e5d636527a@linaro.org>
Date:   Fri, 22 May 2020 18:57:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200507112955.23520-5-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07/05/2020 13:29, Geert Uytterhoeven wrote:
> The QorIQ Thermal Monitoring Unit is only present on Freescale E500MC
> and Layerscape SoCs, and on NXP i.MX8 SoCs.  Add platform dependencies
> to the QORIQ_THERMAL config symbol, to avoid asking the user about it
> when configuring a kernel without support for any of the aforementioned
> SoCs.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied, thanks



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
