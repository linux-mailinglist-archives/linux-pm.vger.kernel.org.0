Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 510217D933
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2019 12:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbfHAKTr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Aug 2019 06:19:47 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43744 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729011AbfHAKTq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Aug 2019 06:19:46 -0400
Received: by mail-lj1-f195.google.com with SMTP id y17so44250549ljk.10;
        Thu, 01 Aug 2019 03:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qbGQqDyP4I1vZkjeDZo9wGdk45jbF0KxTGH8jXP197g=;
        b=E98kil5/2siIUzhmuhvr3z1YHCVBNiMZXPgRIyWkJy1eNiHpf/Eyuqog6Yi6nw2UsZ
         ABuTyDkW+V5WBOubzQbVw2lSoCqum5eEPO4LXAeoFIUzDmTqoHThzYoEeZLWlZqYwwXZ
         MsK2hr1D0ZwGEuMuySWyH/KJdVa1GJ0vOpaqvzWGehkfRVgXn8M9hciTthH3Va94gDXR
         LYwEMKfJMxv5kL0CaEdlDRpltbWhsimAGbO/hr8uz0s99wHR4kthgnn3E13wDjwVJtkK
         B/HddEE/XlN7BMMguLRmYwQY1+ybpbKZuzIcftmlW8zL5Nv5HuYHvsP56O0Xh8A18MCM
         kWVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qbGQqDyP4I1vZkjeDZo9wGdk45jbF0KxTGH8jXP197g=;
        b=hVizi4g8IbKMKLyNaoU7rrQIum+P+7lPPDpOhW7AsPco7fDQ9DT0t8tUrGk76rHAJq
         C0Yo33mvbNVtTaRIfBVh1Ah4K7v1edg4Ho1ME7ODeDJkistDXbTZ15RHypDSguI2dJ+1
         7eAMvVk8zMxxtucB/lDun4ObqNQCoI0py7lbekAEfCkRNmzFezjn8Rz4iTQ6wo5yyi/S
         j3kvwlKlulQZq8649FzEYCMGmdiyGcbTGak7V9nwusqS85N8fjUMcsnfmnKncnu6yTcd
         vtY2fRoUL0v7Wyf/yV3qz31UEDmFjtvjHCUWiwSQLG3sWhasqEEqxQ+azMZhVtxHdP33
         gIQw==
X-Gm-Message-State: APjAAAWIXWRyScO8PDN9egZZt6d3B+DjoTeQW/I/zVoMgXW3lydmfo5r
        EIXI8SiGfQL/4ayUX6DE4FU49nB3
X-Google-Smtp-Source: APXvYqwdvGuAK11haADpf9hjMBw4A9Agn+8VknX0OhGBVMakqacS53S5tb8msbbplu2+LmM4ZxcwHg==
X-Received: by 2002:a2e:9a10:: with SMTP id o16mr6628153lji.95.1564654783466;
        Thu, 01 Aug 2019 03:19:43 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.googlemail.com with ESMTPSA id y194sm12134537lfa.5.2019.08.01.03.19.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 03:19:42 -0700 (PDT)
Subject: Re: [PATCH v7 10/20] clk: tegra: clk-dfll: Add suspend and resume
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
References: <1564607463-28802-1-git-send-email-skomatineni@nvidia.com>
 <1564607463-28802-11-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <4400ffef-685f-b9e6-3b07-4790f851282c@gmail.com>
Date:   Thu, 1 Aug 2019 13:18:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1564607463-28802-11-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

01.08.2019 0:10, Sowjanya Komatineni пишет:
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
> index f8688c2ddf1a..9900097ec2aa 100644
> --- a/drivers/clk/tegra/clk-dfll.c
> +++ b/drivers/clk/tegra/clk-dfll.c
> @@ -1513,6 +1513,62 @@ static int dfll_init(struct tegra_dfll *td)
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
> +
> +	pm_runtime_irq_safe(td->dev);

Please see my previous reply.
