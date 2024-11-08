Return-Path: <linux-pm+bounces-17211-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0979C1F88
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 15:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1C1728395F
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 14:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156661EBA00;
	Fri,  8 Nov 2024 14:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WcCZTsE1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0E31E7C18
	for <linux-pm@vger.kernel.org>; Fri,  8 Nov 2024 14:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731077036; cv=none; b=Ca+amjt3uf3NErb4kJY7tdodaU+xHgX7xy9eDySX4NThNvnY59lvIECjWiKa36wKL5KRtBXNSpfmAMLYw+rreZD/bi7X0BSDAE3BhkCT4XfXc/fSy7q7K0O2VpyZtECeywJcTtfps0oXUKkkfNjGq6LMHkgT5gVCkhb2XEKMts8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731077036; c=relaxed/simple;
	bh=XaTovklCuDqB3hH/2b0HHiheZ90GDuR79nEFqG3RrTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ABM0UxU9nrCvFLQl5B8qWlgkT6fOnHHJWnI1pbmOTv4jQVI3ezLBB/343uqJaIV4pOuXjTWEum4EvQELc7luzGkeUfbDiY/bAchPSNQQ+o0dKhbPwiqBEKaGKvvZtHNmRQplyf7oQx3B1dNvhYTJcDAdHgfrZtovucK1obSC9kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WcCZTsE1; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731077035; x=1762613035;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XaTovklCuDqB3hH/2b0HHiheZ90GDuR79nEFqG3RrTU=;
  b=WcCZTsE1X34xmt4jKJyI/Z9mQp5JlTsPDZ4R82Agaus6PRF6ApP02OTz
   DpSjNy+SiNLaiuEr0AE/2iAnHa0PT1ZOWbSeGi0KpTcnY1PaHZbGLU60k
   OU7Ou6s1u6JmDpI1T10jsEhFiReP3e0fDOzmWGZ0TOJEiT/AsFaOWSva3
   YgWr/9f99hEbskeQ4/sGZJg5buqI5Gveorn1ZhlMI8ZIkcjoyJZBCpuzl
   4aB4pEh+5tQQ7yRU+5P5fVXmKdBD1fbdycF10GSM4mZKJJeB9XyMG0SGy
   H6WdIPkKbL/3+AbKn7rp9xvNSUUrFp/a02aZIuEiHbPB6gtS9qK7NAm3a
   w==;
X-CSE-ConnectionGUID: OBmHyf20Qfe4xlWUgtIEUQ==
X-CSE-MsgGUID: AKG1Vk2+SWy99/906agl0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="42061784"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="42061784"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 06:43:48 -0800
X-CSE-ConnectionGUID: EPy2sefuTAeV9UvXipRQDg==
X-CSE-MsgGUID: BbwiA8oIRse41hU2XnUVIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,138,1728975600"; 
   d="scan'208";a="85502262"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.16.81])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 06:43:42 -0800
Message-ID: <1e47ee3e-7439-4dc4-aef6-0ad2f82ee341@intel.com>
Date: Fri, 8 Nov 2024 16:43:37 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhc: Add PM QoS support for mmc driver
To: Madhusudhan Sana <quic_msana@quicinc.com>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: quic_cang@quicinc.com, quic_nguyenb@quicinc.com,
 quic_bhaskarv@quicinc.com, quic_mapa@quicinc.com, quic_narepall@quicinc.com,
 quic_nitirawa@quicinc.com, quic_rampraka@quicinc.com,
 quic_sachgupt@quicinc.com, quic_sartgarg@quicinc.com,
 Linux PM list <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <20241101024421.26679-1-quic_msana@quicinc.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20241101024421.26679-1-quic_msana@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/11/24 04:44, Madhusudhan Sana wrote:
> Register mmc driver to CPU latency PM QoS framework to improve
> mmc device io performance.

Not sure host controller drivers should really be manipulating
cpu_latency_qos in order to squeeze a bit more I/O performance.

> 
> Signed-off-by: Madhusudhan Sana <quic_msana@quicinc.com>
> ---
>  drivers/mmc/host/sdhci.c | 47 ++++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci.h |  4 ++++
>  2 files changed, 51 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index f4a7733a8ad2..ffcc9544a3df 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -359,6 +359,46 @@ static void sdhci_config_dma(struct sdhci_host *host)
>  	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
>  }
>  
> +/*
> + * sdhci_pm_qos_init - initialize PM QoS request
> + */
> +void sdhci_pm_qos_init(struct sdhci_host *host)
> +{
> +	if (host->pm_qos_enable)
> +		return;
> +
> +	cpu_latency_qos_add_request(&host->pm_qos_req, PM_QOS_DEFAULT_VALUE);
> +
> +	if (cpu_latency_qos_request_active(&host->pm_qos_req))
> +		host->pm_qos_enable = true;
> +}
> +
> +/*
> + * sdhci_pm_qos_exit - remove request from PM QoS
> + */
> +void sdhci_pm_qos_exit(struct sdhci_host *host)
> +{
> +	if (!host->pm_qos_enable)
> +		return;
> +
> +	cpu_latency_qos_remove_request(&host->pm_qos_req);
> +	host->pm_qos_enable = false;
> +}
> +
> +/*
> + * sdhci_pm_qos_update - update PM QoS request
> + * @on - True, vote for perf PM QoS mode
> + *     - False, vote for power save mode.
> + */
> +static void sdhci_pm_qos_update(struct sdhci_host *host, bool on)
> +{
> +	if (!host->pm_qos_enable)
> +		return;
> +
> +	cpu_latency_qos_update_request(&host->pm_qos_req, on ?
> +						0 : PM_QOS_DEFAULT_VALUE);
> +}
> +
>  static void sdhci_init(struct sdhci_host *host, int soft)
>  {
>  	struct mmc_host *mmc = host->mmc;
> @@ -384,6 +424,9 @@ static void sdhci_init(struct sdhci_host *host, int soft)
>  		host->reinit_uhs = true;
>  		mmc->ops->set_ios(mmc, &mmc->ios);
>  	}
> +
> +	sdhci_pm_qos_init(host);
> +	sdhci_pm_qos_update(host, true);
>  }
>  
>  static void sdhci_reinit(struct sdhci_host *host)
> @@ -2072,6 +2115,7 @@ void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>  
>  	clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
>  	sdhci_enable_clk(host, clk);
> +	sdhci_pm_qos_update(host, true);
>  }
>  EXPORT_SYMBOL_GPL(sdhci_set_clock);
>  
> @@ -3811,6 +3855,7 @@ int sdhci_suspend_host(struct sdhci_host *host)
>  		sdhci_writel(host, 0, SDHCI_SIGNAL_ENABLE);
>  		free_irq(host->irq, host);
>  	}
> +	sdhci_pm_qos_update(host, false);
>  
>  	return 0;
>  }
> @@ -3873,6 +3918,7 @@ int sdhci_runtime_suspend_host(struct sdhci_host *host)
>  	spin_lock_irqsave(&host->lock, flags);
>  	host->runtime_suspended = true;
>  	spin_unlock_irqrestore(&host->lock, flags);
> +	sdhci_pm_qos_update(host, false);
>  
>  	return 0;
>  }
> @@ -4987,6 +5033,7 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
>  	if (host->use_external_dma)
>  		sdhci_external_dma_release(host);
>  
> +	sdhci_pm_qos_exit(host);
>  	host->adma_table = NULL;
>  	host->align_buffer = NULL;
>  }
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index cd0e35a80542..685036ed888b 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -16,6 +16,7 @@
>  #include <linux/io.h>
>  #include <linux/leds.h>
>  #include <linux/interrupt.h>
> +#include <linux/devfreq.h>
>  
>  #include <linux/mmc/host.h>
>  
> @@ -675,6 +676,9 @@ struct sdhci_host {
>  
>  	u64			data_timeout;
>  
> +	struct pm_qos_request pm_qos_req;	/* PM QoS request handle */
> +	bool pm_qos_enable;			/* flag to check PM QoS is enable */
> +
>  	unsigned long private[] ____cacheline_aligned;
>  };
>  


