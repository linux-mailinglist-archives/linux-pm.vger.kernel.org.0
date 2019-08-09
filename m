Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDFF878AE
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2019 13:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406452AbfHILdY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Aug 2019 07:33:24 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39895 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405723AbfHILdY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Aug 2019 07:33:24 -0400
Received: by mail-lf1-f68.google.com with SMTP id x3so15512581lfn.6;
        Fri, 09 Aug 2019 04:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s7beGUmfSnbzLxpw4htUELaVzRk7z/GPctQgdAnGulM=;
        b=J0WuyV2z3eLsE+RnZT5RKYBfKG96Iu0QqpOw8ph+yxHMliD+YSQ04GqnCsdbnpXlmg
         IIEi6blIqHhOyWkp8m3XGNzCE3916muRHSh8Yb5Up4Y34TMohdJn1r6F4dC495GrpLq5
         o/RjPi/vYNu7TOyqQ6UbRZjJdsDKCsVnOY6sKyjIghIcAKJ57c+gs6pq5uNqbl9nCrfj
         TV+BXb3zXqfd++z8yEPCCUPtrmNKpmz+n86DJbpYn5e65j61EMXRqq+UOb2qtFnFdML8
         OgBPARTMIiN+1TdXAggB9hx1T60qMuMecbUgTaTpt+yesC8h3F6uw2yI5xHgWnqe1Ihp
         /aMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s7beGUmfSnbzLxpw4htUELaVzRk7z/GPctQgdAnGulM=;
        b=Zm7XLuzWijmOIZEE+pHoIcLBzGuO82ClOOIYVWJbmwlTmovFEIcPVodwL28UaXLMpu
         xtucuFFjXrXNbhL/ChlCiGTxmSx4ypOC1MslX5Uhl3op59+SINHk6vbesIBlTrQOZfSn
         e17UKiIS0lwvYdUSe1TbzjS/7pPB/Hj4EkPy53tTYjoJK4VLALlRWPQM2SV7JBjt9SLQ
         30x8bXRvqvWe+VUCgYomL3RKoO6YcD1IYtnZj12LSKgALvd1x4yDGTlJvuZmtEQ2A6Pv
         WVb6Qkeiyi+TM5s+hiVfBNgxqaoqRbUTRS3wHcYuaj4uMv6wVWXht0d05YSFQ5ZWQHIO
         QHJQ==
X-Gm-Message-State: APjAAAWxg0wSfNWfBR5UYI7p80zdHXieR0dPzDUzN01Zs1wHcEvhuscQ
        doZ9HBIZC7vHI6rzqi74+4UgUDGf
X-Google-Smtp-Source: APXvYqwtQgfLjaNzX9n/3y+a0SCTRTrv3UhJKrqsYAyQjGbYLM67NNU3PwQptdso2nKkef/My3Wz7A==
X-Received: by 2002:ac2:484e:: with SMTP id 14mr12245198lfy.50.1565350400760;
        Fri, 09 Aug 2019 04:33:20 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.34.218])
        by smtp.googlemail.com with ESMTPSA id p13sm19436242ljc.39.2019.08.09.04.33.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 04:33:19 -0700 (PDT)
Subject: Re: [PATCH v8 05/21] clk: tegra: pll: Save and restore pll context
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, tglx@linutronix.de,
        jason@lakedaemon.net, marc.zyngier@arm.com,
        linus.walleij@linaro.org, stefan@agner.ch, mark.rutland@arm.com
Cc:     pdeschrijver@nvidia.com, pgaikwad@nvidia.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        jckuo@nvidia.com, josephl@nvidia.com, talho@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        mperttunen@nvidia.com, spatra@nvidia.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org
References: <1565308020-31952-1-git-send-email-skomatineni@nvidia.com>
 <1565308020-31952-6-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <68f65db6-44b7-1c75-2633-4a2fffd62a92@gmail.com>
Date:   Fri, 9 Aug 2019 14:33:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1565308020-31952-6-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

09.08.2019 2:46, Sowjanya Komatineni пишет:
> This patch implements save and restore of PLL context.
> 
> During system suspend, core power goes off and looses the settings
> of the Tegra CAR controller registers.
> 
> So during suspend entry pll context is stored and on resume it is
> restored back along with its state.
> 
> Acked-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/clk/tegra/clk-pll.c | 88 ++++++++++++++++++++++++++++-----------------
>  drivers/clk/tegra/clk.h     |  2 ++
>  2 files changed, 58 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
> index 1583f5fc992f..e52add2bbdbb 100644
> --- a/drivers/clk/tegra/clk-pll.c
> +++ b/drivers/clk/tegra/clk-pll.c
> @@ -1008,6 +1008,28 @@ static unsigned long clk_plle_recalc_rate(struct clk_hw *hw,
>  	return rate;
>  }
>  
> +static void tegra_clk_pll_restore_context(struct clk_hw *hw)
> +{
> +	struct tegra_clk_pll *pll = to_clk_pll(hw);
> +	struct clk_hw *parent = clk_hw_get_parent(hw);
> +	unsigned long parent_rate = clk_hw_get_rate(parent);
> +	unsigned long rate = clk_hw_get_rate(hw);
> +	u32 val;
> +
> +	if (clk_pll_is_enabled(hw))
> +		return;
> +
> +	if (pll->params->set_defaults)
> +		pll->params->set_defaults(pll);
> +
> +	clk_pll_set_rate(hw, rate, parent_rate);
> +
> +	if (!__clk_get_enable_count(hw->clk))

What about orphaned clocks? Is enable_count > 0 for them?

> +		clk_pll_disable(hw);
> +	else
> +		clk_pll_enable(hw);
> +}

[snip]
