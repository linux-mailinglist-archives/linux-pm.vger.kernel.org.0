Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEE7879DB
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2019 14:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406783AbfHIMX4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Aug 2019 08:23:56 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44536 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfHIMXz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Aug 2019 08:23:55 -0400
Received: by mail-lj1-f195.google.com with SMTP id k18so91884329ljc.11;
        Fri, 09 Aug 2019 05:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A1HPVMRsBqcKy05KBjxSg7lyV3HqfZKuZNZQi3MF1mg=;
        b=J06qtqLjakr5Hcy4/e+K5oPTVFpTYCtY5tbNh1HZN6dpBMFQcqF8V5V+vSqthpUDLZ
         N7klJ7UJ9xLFIhUTlTjQoH+D3DgKbbIC0NxbSOx1T5Uq0DknSyMpBdUfoQgeD4pZ1kA2
         ctvbov+nUS03HBNQ4TMMem9KMi2EzZXk/sjPB0GCOTyywUi9/YiV89M8453zOigpngxr
         9xcEWPwzn8nvTNMUAU2/6Bw5Gij3ntw/X88bY4K23fn7mS9mo+Xh+5eqk/d3Cn8wuL5e
         xZHkxFJsfROBE72D4efsulnxkBveXwdcUJKyuPdjjjejIAhBz7qmkYF9V23UVOpiKFYb
         2fZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A1HPVMRsBqcKy05KBjxSg7lyV3HqfZKuZNZQi3MF1mg=;
        b=QDjVY7zVedZUSCB72PlfBB8Kr/MKmoiWgFOs4HOZDEJ8nwDGBBEfmXEiX6E6eNib1a
         MdQmYHLxeEvXd232oolj0h7gsjGOzV24qxZEOE0t1vDbjgNrRfEqXcgmMXeJDoz8r2D+
         WqXouhbsPspTbUrXrAx4oWsLPmmUkjBfNarUctIYsxMMDsVJ/5MXOPERbXNW1eRQCPIm
         1YY892Bshg2T79HqvAJbvUaGUUWrLVW9UzqLzgoPj7ff5DDwXLFgLVNPHeED+tuOGgsc
         QvuBp9gpYzR9cBEsieqvVep7hl1GmIlalrxD0mZjN5vCkRfRL0X5QTDn2t3C5sSxvKcL
         P4NA==
X-Gm-Message-State: APjAAAXT2aMmcL8meMnXJAHzZA+hhHoQR3/wLkjtXJYE06P1eSe0RDzl
        W311+8cJv73TgRq9TvEYDf6N+EwJ
X-Google-Smtp-Source: APXvYqxgsiVmbxWMqZ/3p+acivIhoZqlLbgkDoIHpSeueGUl0rMZ+w2EfN22SlxkbxZC0D2FcTYMEA==
X-Received: by 2002:a2e:8396:: with SMTP id x22mr11652925ljg.135.1565353431899;
        Fri, 09 Aug 2019 05:23:51 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.34.218])
        by smtp.googlemail.com with ESMTPSA id h84sm19373205ljf.42.2019.08.09.05.23.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 05:23:51 -0700 (PDT)
Subject: Re: [PATCH v8 11/21] clk: tegra: clk-dfll: Add suspend and resume
 support
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
 <1565308020-31952-12-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <eb4fdab8-aba3-7f0c-a391-d751674fd03e@gmail.com>
Date:   Fri, 9 Aug 2019 15:23:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1565308020-31952-12-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

09.08.2019 2:46, Sowjanya Komatineni пишет:
> This patch implements DFLL suspend and resume operation.
> 
> During system suspend entry, CPU clock will switch CPU to safe
> clock source of PLLP and disables DFLL clock output.
> 
> DFLL driver suspend confirms DFLL disable state and errors out on
> being active.
> 
> DFLL is re-initialized during the DFLL driver resume as it goes
> through complete reset during suspend entry.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/clk/tegra/clk-dfll.c               | 56 ++++++++++++++++++++++++++++++
>  drivers/clk/tegra/clk-dfll.h               |  2 ++
>  drivers/clk/tegra/clk-tegra124-dfll-fcpu.c |  1 +
>  3 files changed, 59 insertions(+)
> 
> diff --git a/drivers/clk/tegra/clk-dfll.c b/drivers/clk/tegra/clk-dfll.c
> index f8688c2ddf1a..eb298a5d7be9 100644
> --- a/drivers/clk/tegra/clk-dfll.c
> +++ b/drivers/clk/tegra/clk-dfll.c
> @@ -1487,6 +1487,7 @@ static int dfll_init(struct tegra_dfll *td)
>  	td->last_unrounded_rate = 0;
>  
>  	pm_runtime_enable(td->dev);
> +	pm_runtime_irq_safe(td->dev);
>  	pm_runtime_get_sync(td->dev);
>  
>  	dfll_set_mode(td, DFLL_DISABLED);
> @@ -1513,6 +1514,61 @@ static int dfll_init(struct tegra_dfll *td)
>  	return ret;
>  }
>  
> +/**
> + * tegra_dfll_suspend - check DFLL is disabled
> + * @dev: DFLL device *
> + *
> + * DFLL clock should be disabled by the CPUFreq driver. So, make
> + * sure it is disabled and disable all clocks needed by the DFLL.
> + */
> +int tegra_dfll_suspend(struct device *dev)
> +{
> +	struct tegra_dfll *td = dev_get_drvdata(dev);
> +
> +	if (dfll_is_running(td)) {
> +		dev_err(td->dev, "dfll is enabled while shouldn't be\n");
> +		return -EBUSY;
> +	}
> +
> +	reset_control_assert(td->dvco_rst);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(tegra_dfll_suspend);
> +
> +/**
> + * tegra_dfll_resume - reinitialize DFLL on resume
> + * @dev: DFLL instance
> + *
> + * DFLL is disabled and reset during suspend and resume.
> + * So, reinitialize the DFLL IP block back for use.
> + * DFLL clock is enabled later in closed loop mode by CPUFreq
> + * driver before switching its clock source to DFLL output.
> + */
> +int tegra_dfll_resume(struct device *dev)
> +{
> +	struct tegra_dfll *td = dev_get_drvdata(dev);
> +
> +	reset_control_deassert(td->dvco_rst);

This doesn't look right because I assume that DFLL resetting is
synchronous and thus clk should be enabled in order for reset to
propagate inside hardware.

> +	pm_runtime_get_sync(td->dev);

Hence it will be better to remove the above reset_control_deassert() and
add here:

	reset_control_reset(td->dvco_rst);

> +	dfll_set_mode(td, DFLL_DISABLED);
> +	dfll_set_default_params(td);
> +
> +	if (td->soc->init_clock_trimmers)
> +		td->soc->init_clock_trimmers();
> +
> +	dfll_set_open_loop_config(td);
> +
> +	dfll_init_out_if(td);
> +
> +	pm_runtime_put_sync(td->dev);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(tegra_dfll_resume);
> +
>  /*
>   * DT data fetch
>   */
> diff --git a/drivers/clk/tegra/clk-dfll.h b/drivers/clk/tegra/clk-dfll.h
> index 1b14ebe7268b..fb209eb5f365 100644
> --- a/drivers/clk/tegra/clk-dfll.h
> +++ b/drivers/clk/tegra/clk-dfll.h
> @@ -42,5 +42,7 @@ int tegra_dfll_register(struct platform_device *pdev,
>  struct tegra_dfll_soc_data *tegra_dfll_unregister(struct platform_device *pdev);
>  int tegra_dfll_runtime_suspend(struct device *dev);
>  int tegra_dfll_runtime_resume(struct device *dev);
> +int tegra_dfll_suspend(struct device *dev);
> +int tegra_dfll_resume(struct device *dev);
>  
>  #endif /* __DRIVERS_CLK_TEGRA_CLK_DFLL_H */
> diff --git a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
> index e84b6d52cbbd..2ac2679d696d 100644
> --- a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
> +++ b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
> @@ -631,6 +631,7 @@ static int tegra124_dfll_fcpu_remove(struct platform_device *pdev)
>  static const struct dev_pm_ops tegra124_dfll_pm_ops = {
>  	SET_RUNTIME_PM_OPS(tegra_dfll_runtime_suspend,
>  			   tegra_dfll_runtime_resume, NULL)
> +	SET_SYSTEM_SLEEP_PM_OPS(tegra_dfll_suspend, tegra_dfll_resume)
>  };
>  
>  static struct platform_driver tegra124_dfll_fcpu_driver = {
> 

