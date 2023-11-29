Return-Path: <linux-pm+bounces-473-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 889BC7FD728
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 13:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9AE01C20964
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 12:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643BB1DA43;
	Wed, 29 Nov 2023 12:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SUQpyNhy"
X-Original-To: linux-pm@vger.kernel.org
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EC9D44;
	Wed, 29 Nov 2023 04:52:45 -0800 (PST)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 4A7136606F5E;
	Wed, 29 Nov 2023 12:52:43 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1701262363;
	bh=GLJxqZFecjsx3758/CBoDDz8MENJNNKHfPIeFyZAwxE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SUQpyNhyfJkloRn5ImAsWnurFL9KiM6q1N54IG3+bcijklAodqRNhsOwHw4sCDnta
	 lk7Matn5B50lHTYSiwUMYml3qhwQELBgKor8tkNv8QJEeAh9yiTmLNSk8412o+691X
	 jWo3zoPd+fGzi86jfQc33uP8tDA+ymeXfv3ynNTAoHG7thoolkhCCmkZvT+b9ZJdew
	 6xYsWuh2sUkqSjdEqIOwQVMolFelTr7+etw0lJpZ3t9EWQ5/+UD6wbHI2PPt4DVO4h
	 YYfiqEhoHWQvm//VtENf4tVUFqqj+5Z58GXDyxgrH/gT3+ey5fu0/j1FKX4+M4tE7o
	 dGDuDSNizDhxg==
Message-ID: <fd645c33-1b16-4825-b9ea-eecb578dd2a0@collabora.com>
Date: Wed, 29 Nov 2023 13:52:40 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain: mediatek: fix race condition in power on/power
 off sequences
Content-Language: en-US
To: Eugen Hristev <eugen.hristev@collabora.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-pm@vger.kernel.org
Cc: eballetbo@kernel.org, ulf.hansson@linaro.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20231129113120.4907-1-eugen.hristev@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231129113120.4907-1-eugen.hristev@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 29/11/23 12:31, Eugen Hristev ha scritto:
> It can happen that during the power off sequence for a power domain
> another power on sequence is started, and it can lead to powering on and
> off in the same time for the similar power domain.
> This can happen if parallel probing occurs: one device starts probing, and
> one power domain is probe deferred, this leads to all power domains being
> rolled back and powered off, while in the same time another device starts
> probing and requests powering on the same power domains or similar.
> 
> This was encountered on MT8186, when the sequence is :
> Power on SSUSB
> Power on SSUSB_P1
> Power on DIS
> 	-> probe deferred
> Power off DIS
> Power off SSUSB_P1
> Power off SSUSB
> 
> During the sequence of powering off SSUSB, some new similar sequence starts,
> and during the power on of SSUSB, clocks are enabled.
> In this case, powering off SSUSB fails from the first sequence, because
> power off ACK bit check times out (as clocks are powered back on by the second
> sequence). In consequence, powering it on also times out, and it leads to
> the whole power domain in a bad state.
> 
> To solve this issue, added a mutex that locks the whole power off/power on
> sequence such that it would never happen that multiple sequences try to
> enable or disable the same power domain in parallel.
> 
> Fixes: 59b644b01cf4 ("soc: mediatek: Add MediaTek SCPSYS power domains")
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>

I don't think that it's a race between genpd_power_on() and genpd_power_off() calls
at all, because genpd *does* have locking after all... at least for probe and for
parents of a power domain (and more anyway).

As far as I remember, what happens when you start .probe()'ing a device is:
platform_probe() -> dev_pm_domain_attach() -> genpd_dev_pm_attach()

There, you end up with

	if (power_on) {
		genpd_lock(pd);
		ret = genpd_power_on(pd, 0);
		genpd_unlock(pd);
	}

...but when you fail probing, you go with genpd_dev_pm_detach(), which then calls

	/* Check if PM domain can be powered off after removing this device. */
	genpd_queue_power_off_work(pd);

but even then, you end up being in a worker doing

	genpd_lock(genpd);
	genpd_power_off(genpd, false, 0);
	genpd_unlock(genpd);

...so I don't understand why this mutex can resolve the situation here (also: are
you really sure that the race is solved like that?)

I'd say that this probably needs more justification and a trace of the actual
situation here.

Besides, if this really resolves the issue, I would prefer seeing variants of
scpsys_power_{on,off}() functions, because we anyway don't need to lock mutexes
during this driver's probe (add_subdomain calls scpsys_power_on()).
In that case, `scpsys_power_on_unlocked()` would be an idea... but still, please
analyze why your solution works, if it does, because I'm not convinced.

Cheers,
Angelo

> ---
>   drivers/pmdomain/mediatek/mtk-pm-domains.c | 24 +++++++++++++++++-----
>   1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> index d5f0ee05c794..4f136b47e539 100644
> --- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
> +++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> @@ -9,6 +9,7 @@
>   #include <linux/io.h>
>   #include <linux/iopoll.h>
>   #include <linux/mfd/syscon.h>
> +#include <linux/mutex.h>
>   #include <linux/of.h>
>   #include <linux/of_clk.h>
>   #include <linux/platform_device.h>
> @@ -56,6 +57,7 @@ struct scpsys {
>   	struct device *dev;
>   	struct regmap *base;
>   	const struct scpsys_soc_data *soc_data;
> +	struct mutex mutex;
>   	struct genpd_onecell_data pd_data;
>   	struct generic_pm_domain *domains[];
>   };
> @@ -238,9 +240,13 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>   	bool tmp;
>   	int ret;
>   
> +	mutex_lock(&scpsys->mutex);
> +
>   	ret = scpsys_regulator_enable(pd->supply);
> -	if (ret)
> +	if (ret) {
> +		mutex_unlock(&scpsys->mutex);
>   		return ret;
> +	}
>   
>   	ret = clk_bulk_prepare_enable(pd->num_clks, pd->clks);
>   	if (ret)
> @@ -291,6 +297,7 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>   			goto err_enable_bus_protect;
>   	}
>   
> +	mutex_unlock(&scpsys->mutex);
>   	return 0;
>   
>   err_enable_bus_protect:
> @@ -305,6 +312,7 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>   	clk_bulk_disable_unprepare(pd->num_clks, pd->clks);
>   err_reg:
>   	scpsys_regulator_disable(pd->supply);
> +	mutex_unlock(&scpsys->mutex);
>   	return ret;
>   }
>   
> @@ -315,13 +323,15 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
>   	bool tmp;
>   	int ret;
>   
> +	mutex_lock(&scpsys->mutex);
> +
>   	ret = scpsys_bus_protect_enable(pd);
>   	if (ret < 0)
> -		return ret;
> +		goto err_mutex_unlock;
>   
>   	ret = scpsys_sram_disable(pd);
>   	if (ret < 0)
> -		return ret;
> +		goto err_mutex_unlock;
>   
>   	if (pd->data->ext_buck_iso_offs && MTK_SCPD_CAPS(pd, MTK_SCPD_EXT_BUCK_ISO))
>   		regmap_set_bits(scpsys->base, pd->data->ext_buck_iso_offs,
> @@ -340,13 +350,15 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
>   	ret = readx_poll_timeout(scpsys_domain_is_on, pd, tmp, !tmp, MTK_POLL_DELAY_US,
>   				 MTK_POLL_TIMEOUT);
>   	if (ret < 0)
> -		return ret;
> +		goto err_mutex_unlock;
>   
>   	clk_bulk_disable_unprepare(pd->num_clks, pd->clks);
>   
>   	scpsys_regulator_disable(pd->supply);
>   
> -	return 0;
> +err_mutex_unlock:
> +	mutex_unlock(&scpsys->mutex);
> +	return ret;
>   }
>   
>   static struct
> @@ -700,6 +712,8 @@ static int scpsys_probe(struct platform_device *pdev)
>   		return PTR_ERR(scpsys->base);
>   	}
>   
> +	mutex_init(&scpsys->mutex);
> +
>   	ret = -ENODEV;
>   	for_each_available_child_of_node(np, node) {
>   		struct generic_pm_domain *domain;



