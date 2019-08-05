Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1155881779
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2019 12:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbfHEKuM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Aug 2019 06:50:12 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37278 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728520AbfHEKuL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Aug 2019 06:50:11 -0400
Received: by mail-lf1-f65.google.com with SMTP id c9so57502539lfh.4;
        Mon, 05 Aug 2019 03:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QQyVc+vK6ut2H0EG3cdDkucf3SZC0gbmKE/5o4Bm72I=;
        b=l+hxbhJ5A2G+CiX6S/ucjwNgK6YG4cRCO+fATV6YsGv1HWP8zgWZEMGvqqcfHy4cwC
         DoT62oUQtZP70wA62cDV4yZv1gjoj+r/rtuthaQfnyX6tGOmaMQXcGaXvxEPDxWfKPcm
         ImhDgPsdikVBORVOJa4tbEPdHa46e1Fy0G0hKuOidDmHZ0ucaqwWBLLj5fpJkm8B8PR6
         Tc6+puPFpiI7euURISTNr4sw/jv+uNYlXelMv/tYzL9x+iOrCeWanjfZXyBQKXkfnDtg
         QsHeqSX+CQonsYIJ1C8U5rV653ZncxJRKwPQ3uq/PwJzLDklOM2MJa0sewO+6GuqoAKl
         u0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QQyVc+vK6ut2H0EG3cdDkucf3SZC0gbmKE/5o4Bm72I=;
        b=gEeJqBHLkfcHRKJAohG4UBH90WwhM+ydqmQ4aJXOfDoOvI3Z+kj7urHqslxBO7Chet
         nrZSfDzFLbEWCt/RkID7zYx2QSHnoQdTvCuggQTQOrly1KUlsgijwwgld0wuOD3atRr0
         z5WWEXjC6CI3jstSMd6lZIjI8rupwx7PoSBG6o1sarORTEWkv64aAApYvUnMrpFStVq0
         JrebJCozdkLuUTaG6/lBWur5cqJ3cLS+MiDK4Kna4eOM6q8H5kdSrIo9KjzTMFCwxW5H
         ekh3oRfELkS7yF+BMFE8VH0zCspIZsz/KAKbUWSWWKpsFdTXH3O/QL4Wxnaxu0qcZatj
         Ge4w==
X-Gm-Message-State: APjAAAX+Ida2n8Ih5nqjpyKGlMdR6kpoVum8akCdvZUYbHdaoqxuEKld
        dVWxw0xmz96dKv4Buaj0TMvoE5dM
X-Google-Smtp-Source: APXvYqwCMD+UPHgwi0+gii65cCcprbuoYyXe5kKadJL+bGPq6VyxKoiIx5GYVs6OAThHmSQPKiw0Kg==
X-Received: by 2002:a05:6512:4c8:: with SMTP id w8mr5749003lfq.98.1565002208653;
        Mon, 05 Aug 2019 03:50:08 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.googlemail.com with ESMTPSA id n10sm14787543lfe.24.2019.08.05.03.50.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 03:50:07 -0700 (PDT)
Subject: Re: [PATCH v7 01/20] pinctrl: tegra: Add suspend and resume support
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
 <1564607463-28802-2-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <6b1482f6-0578-f602-d8d1-541d86303ce2@gmail.com>
Date:   Mon, 5 Aug 2019 13:50:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1564607463-28802-2-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

01.08.2019 0:10, Sowjanya Komatineni пишет:
> This patch adds support for Tegra pinctrl driver suspend and resume.
> 
> During suspend, context of all pinctrl registers are stored and
> on resume they are all restored to have all the pinmux and pad
> configuration for normal operation.
> 
> Acked-by: Thierry Reding <treding@nvidia.com>
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/pinctrl/tegra/pinctrl-tegra.c | 59 +++++++++++++++++++++++++++++++++++
>  drivers/pinctrl/tegra/pinctrl-tegra.h |  3 ++
>  2 files changed, 62 insertions(+)
> 
> diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.c b/drivers/pinctrl/tegra/pinctrl-tegra.c
> index 186ef98e7b2b..e3a237534281 100644
> --- a/drivers/pinctrl/tegra/pinctrl-tegra.c
> +++ b/drivers/pinctrl/tegra/pinctrl-tegra.c
> @@ -631,6 +631,58 @@ static void tegra_pinctrl_clear_parked_bits(struct tegra_pmx *pmx)
>  	}
>  }
>  
> +static size_t tegra_pinctrl_get_bank_size(struct device *dev,
> +					  unsigned int bank_id)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct resource *res;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, bank_id);
> +
> +	return resource_size(res) / 4;
> +}
> +
> +static int tegra_pinctrl_suspend(struct device *dev)
> +{
> +	struct tegra_pmx *pmx = dev_get_drvdata(dev);
> +	u32 *backup_regs = pmx->backup_regs;
> +	u32 *regs;
> +	size_t bank_size;
> +	unsigned int i, k;
> +
> +	for (i = 0; i < pmx->nbanks; i++) {
> +		bank_size = tegra_pinctrl_get_bank_size(dev, i);
> +		regs = pmx->regs[i];
> +		for (k = 0; k < bank_size; k++)
> +			*backup_regs++ = readl_relaxed(regs++);
> +	}
> +
> +	return pinctrl_force_sleep(pmx->pctl);
> +}
> +
> +static int tegra_pinctrl_resume(struct device *dev)
> +{
> +	struct tegra_pmx *pmx = dev_get_drvdata(dev);
> +	u32 *backup_regs = pmx->backup_regs;
> +	u32 *regs;
> +	size_t bank_size;
> +	unsigned int i, k;
> +
> +	for (i = 0; i < pmx->nbanks; i++) {
> +		bank_size = tegra_pinctrl_get_bank_size(dev, i);
> +		regs = pmx->regs[i];
> +		for (k = 0; k < bank_size; k++)
> +			writel_relaxed(*backup_regs++, regs++);
> +	}

I'm now curious whether any kind of barrier is needed after the
writings. The pmx_writel() doesn't insert a barrier after the write and
seems it just misuses writel, which actually should be writel_relaxed()
+ barrier, IIUC.

It's also not obvious whether PINCTRL HW has any kind of write-FIFO and
thus maybe read-back + rmb() is needed in order ensure that writes are
actually completed.

The last thing which is not obvious is when the new configuration
actually takes into effect, does it happen immediately or maybe some
delay is needed?

[snip]
