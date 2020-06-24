Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E20206C2C
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jun 2020 08:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388998AbgFXGIU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jun 2020 02:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388164AbgFXGIU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jun 2020 02:08:20 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93899C061573;
        Tue, 23 Jun 2020 23:08:18 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o2so1299478wmh.2;
        Tue, 23 Jun 2020 23:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J3AVCftaR9EPyVJSqZvDpFIlU9LAhorW3LOOtyD+8K4=;
        b=mvpTvHX5ybEUwBm8lbbmhcm7Hb632yIgI6KI1i1azenZ+I3ggc9FqJDZwNHLXL3qos
         5dwJL/iOANuTSGlR8vWIw1SrWmS85nbTWPF6V9W7HHTkJvLCYnMQ6HFJGNHx/8kVAIJH
         brm41FjXgrhl8XZ4vJpFY24H11fOvruoV9kCE72crRSgVu6oVtI5xtQ9Jz2P7IeOlKSo
         iR6a9tNwEgLkUvcL+sw7FxaLp1PtM+NM2o1XISKc4xtaoxIJ1w7uyyp5nR63MCmVVzRl
         3dgJUkWoWZIXDH/FKWIj5Od6rqeYZpqmPrtv1JK+wjr0Jz3Oacmh/h8kvJW6jQdtNldu
         2YEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J3AVCftaR9EPyVJSqZvDpFIlU9LAhorW3LOOtyD+8K4=;
        b=LPFmVBX1lGidbhS7VzFexuQQIp/eABOCKLi5JNLuyzTG8wRZX3fc5++bvUEED4y5ra
         BshHa5wx6bu5ueu+NwI1DJsNvEfKAu1E2oiCMjTqan5MvSbSAS7MPt7sS2jUvGq/+oGA
         xSZ1tphQilSlMXdG7OzPXtsG8N81OWhA1HQp/a8MCat7fkKIXiL8xiDH5k49NSrV6oPz
         RlmT/UTvF22cnWY5qqqhuKiJgfkmItdCy4WQn3bjA45TK+p+UB7W7iYxyWM1B9IUloug
         FfUx4D6BEXDJrVTRNaT1nvUmSu2vcYzt1Mcr3Of1QoLHdKuX9x5F+VlUJAu8TCkYMoZC
         wuQg==
X-Gm-Message-State: AOAM5303Ty4UMCh38+wVO6vlbDiJxUo2YrTZTnHVOFrRiYY8h+p1aHqj
        94YLqQa2ajK6UBjrPrAB+RI=
X-Google-Smtp-Source: ABdhPJxiESCVTYPKA7k2CylgKyTPo+uTpECT+lsNYvSmat+X3RolB7tU7PK118c4exFljWMvSRQoCw==
X-Received: by 2002:a7b:c18f:: with SMTP id y15mr20639263wmi.85.1592978897172;
        Tue, 23 Jun 2020 23:08:17 -0700 (PDT)
Received: from ?IPv6:2a04:241e:500:9200:593:409e:3935:5922? ([2a04:241e:500:9200:593:409e:3935:5922])
        by smtp.gmail.com with ESMTPSA id k185sm3352122wmk.47.2020.06.23.23.08.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 23:08:16 -0700 (PDT)
Subject: Re: [PATCH v4 0/6] PM / devfreq: Add dynamic scaling for imx8m ddr
 controller
To:     Martin Kepplinger <martin.kepplinger@puri.sm>,
        leonard.crestez@nxp.com
Cc:     Anson.Huang@nxp.com, a.swigon@partner.samsung.com,
        abailon@baylibre.com, abel.vesa@nxp.com, aisheng.dong@nxp.com,
        angus@akkea.ca, cw00.choi@samsung.com, devicetree@vger.kernel.org,
        fabio.estevam@nxp.com, georgi.djakov@linaro.org,
        kernel@pengutronix.de, krzk@kernel.org, kyungmin.park@samsung.com,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-imx@nxp.com, linux-pm@vger.kernel.org, mark.rutland@arm.com,
        martink@posteo.de, mka@chromium.org, mturquette@baylibre.com,
        myungjoo.ham@samsung.com, ping.bai@nxp.com, rjw@rjwysocki.net,
        robh@kernel.org, saravanak@google.com, sboyd@kernel.org,
        shawnguo@kernel.org, viresh.kumar@linaro.org
References: <cover.1573252696.git.leonard.crestez@nxp.com>
 <20200622135858.15891-1-martin.kepplinger@puri.sm>
From:   Leonard Crestez <cdleonard@gmail.com>
Message-ID: <e8440abf-e51f-9846-f2af-a1a44a7fd89a@gmail.com>
Date:   Wed, 24 Jun 2020 09:08:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200622135858.15891-1-martin.kepplinger@puri.sm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 6/22/20 4:58 PM, Martin Kepplinger wrote:
> hi Leondard,
> 
> before using this patchset I'd like to ask: Do you have plans to create
> an update and push this forward? It is useful.

Hello.

I am no longer with NXP and don't have access to imx hardware right now.

However the series that you replied to is very old and was accepted many 
months ago. You shouldn't have to apply out-of-tree kernel patches.

--
Regards,
Leonard
