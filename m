Return-Path: <linux-pm+bounces-26659-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B84AA9912
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 18:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F37481888F62
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 16:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2B6268684;
	Mon,  5 May 2025 16:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PMeVruwr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D50C1A841B
	for <linux-pm@vger.kernel.org>; Mon,  5 May 2025 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746462727; cv=none; b=EJbYkUBONm+4eMyxnWlWtn9C3PM6bBjH6Lcrz3fW5OW58iiC3XK37f6XNEQxJ8R/4euQZdgb4GRVo0FX8AGe+ORbORXRUygC4NYpzl4QQkMO/XHq5tGnkKDzMlTsJN5ioZQF5ojdT9q5GmMxFBXaOx9tODP5imKIMhzHRVcO2hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746462727; c=relaxed/simple;
	bh=shkAZuvCH2RU/ckc8VuwX9a+2DZnjJ7l1ZckrK9OVyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVHFhLsmBk1Jbp8PY7mhid568GCRnqetufYJm6hz+ARlgClQxsqlavZHbi0W/k+WbHrdVIrwXowX1tHTs9tokQDOIsHfMSNVlOrux5YBDRNjmJ1fJ8GdNK4Tv2/CmqJCYSVK+YI1rH1ruFcQOMEuAOS8gH6sNpQZrBrlIPMVB8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PMeVruwr; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b061a775ac3so4385996a12.0
        for <linux-pm@vger.kernel.org>; Mon, 05 May 2025 09:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746462725; x=1747067525; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P8zp6pDtJvcq027DnBZDXmCmCGpXlaf9vo9MS7U/Xtg=;
        b=PMeVruwrOGDyctAeFNqflnY/WkCJi87BWj9pvpDrCllzWm0IeTmZIVQTfPgohdAUtW
         NMV/WV2s3q61ItxnNfcKfeDusJ7K5vgaqHIg8ypJSnfTiPvWPB3Ts0G9s9pec3yTAJkJ
         WxY+y20LkKEC/yPPuLXrTYULeC5zLuD7wYlhHWKWLoCPhPRH11P7AKjVL3ECDCnpkdMO
         Uar/cLBlvgvYp5cVejUV8R/OO/vXT6OhovycqJ5VSPawMQinQnkPJqGSDApNceJV2Dpg
         oIXsu7/pMEW/XC8H/T29NWuAFreVTBUQcCEsTmZWX8TgtSyClulOt3+z+z0ZtoilfgFf
         99Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746462725; x=1747067525;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P8zp6pDtJvcq027DnBZDXmCmCGpXlaf9vo9MS7U/Xtg=;
        b=xNWvGf3dHkRc8DO5qtd8Y2m8xatiF28mpXqTsygZ2tkORAOSqlHQcEWNUksCLNbKQ4
         0Vl4ar1t8PMXehsWCJK74ZlMDmwfhhtR0gGM2E612dfNvYl8uNbQFdEW044Fi17eVKfX
         OM14r1DP7Wxbm2NOpJLwZyFNoJD5TI2zbLAwlDUG9/AZZUZdVAkZ2drhe9Gw3Ndp8SD1
         E/EI1GDPptDabT53qvMnfBShBpK8rEZmoVWwbAIq33sGYRVlPbK9xee4zQX801P8Z1sj
         mave5O4PPLq93o3tCjYp039SqQL54RbkhSRA52XDTM0k1eAdlIMa31p6g8aW6eFMf+v7
         gvlA==
X-Forwarded-Encrypted: i=1; AJvYcCUJz+MuewmmFfU75i4v4UckIrCLN/uqeljmffWdnMN5Tod/oKXQP3FY6HtsnuzcmumKSOrmG6hUVA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0a3fdZHWoyV5K0S6awILoLfRcxEQT0QFzI0W2BNKHQDTUkfqx
	YDK3EKSHjUsl4ABfL9bcnHXSzOLHdreO0X+QmSiLcUHxqJZoCiLGKZLViOWeew==
X-Gm-Gg: ASbGncv453mGZjnWOaXP77hJVaFXQVgLqRC98EXyLy0jISe1DWGbbtlDUfaxgUvy/nB
	Xijl8glQkAzVkiOhfjzb0poPIQwG52X+1f+wIY6Xgp/fN3H4wcCxbmuyI9vK+9sFJuTOvRiy2ym
	YTxQpp6jquI8Bm4opBilcsXqVNUINZYGE8LQ0XIVkPpguS1Qe3gyX62FNHy7IPlmaynRwrbMkKL
	nCBIb6EGitmdRTY1We+HypLj1yReUDU8Ddsbqs06NegKHHymt7gZDeZ4hwhALU9Ax+w1+uNia/q
	1LJocV0aaHNJ4dsRfKx7Nbwn1LRRltFKcONMINI0hdO49MKsXGY=
X-Google-Smtp-Source: AGHT+IFmJNMq5Zm0Lx/iI+jAiEoLSglq132RPDiKeb9iy7s27eldL13qMLmaPmS7wnylnwCLW1L1wQ==
X-Received: by 2002:a05:6a21:3a4a:b0:1f5:9175:2596 with SMTP id adf61e73a8af0-20e9660571emr11256518637.13.1746462725573;
        Mon, 05 May 2025 09:32:05 -0700 (PDT)
Received: from thinkpad ([120.60.48.235])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1fb3c3d6bcsm5794666a12.61.2025.05.05.09.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 09:32:05 -0700 (PDT)
Date: Mon, 5 May 2025 22:01:54 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: webgeek1234@gmail.com
Cc: Thomas Gleixner <tglx@linutronix.de>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 4/4] PCI: tegra: Drop unused remove callback
Message-ID: <idddypjxxtiie3tllfk47krcydlno4lnhbkik4wakekcyu7c2d@iurtu6bjzeey>
References: <20250505-pci-tegra-module-v4-0-088b552c4b1a@gmail.com>
 <20250505-pci-tegra-module-v4-4-088b552c4b1a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250505-pci-tegra-module-v4-4-088b552c4b1a@gmail.com>

On Mon, May 05, 2025 at 09:59:01AM -0500, Aaron Kling via B4 Relay wrote:
> From: Aaron Kling <webgeek1234@gmail.com>
> 
> Debugfs cleanup is moved to a new shutdown callback to ensure the
> debugfs nodes are properly cleaned up on shutdown and reboot.
> 

Both are separate changes. You should remove the .remove() callback in the
previous patch itself and add .shutdown() callback in this patch.

And the shutdown callback should quiesce the device by putting it in L2/L3 state
and turn off the supplies. It is not intended to perform resource cleanup.

- Mani

> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  drivers/pci/controller/pci-tegra.c | 19 ++-----------------
>  1 file changed, 2 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> index 1539d172d708c11c3d085721ab9416be3dea6b12..cc9ca4305ea2072b7395ee1f1e979c24fdea3433 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -2674,27 +2674,12 @@ static int tegra_pcie_probe(struct platform_device *pdev)
>  	return err;
>  }
>  
> -static void tegra_pcie_remove(struct platform_device *pdev)
> +static void tegra_pcie_shutdown(struct platform_device *pdev)
>  {
>  	struct tegra_pcie *pcie = platform_get_drvdata(pdev);
> -	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
> -	struct tegra_pcie_port *port, *tmp;
>  
>  	if (IS_ENABLED(CONFIG_DEBUG_FS))
>  		tegra_pcie_debugfs_exit(pcie);
> -
> -	pci_stop_root_bus(host->bus);
> -	pci_remove_root_bus(host->bus);
> -	pm_runtime_put_sync(pcie->dev);
> -	pm_runtime_disable(pcie->dev);
> -
> -	if (IS_ENABLED(CONFIG_PCI_MSI))
> -		tegra_pcie_msi_teardown(pcie);
> -
> -	tegra_pcie_put_resources(pcie);
> -
> -	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
> -		tegra_pcie_port_free(port);
>  }
>  
>  static int tegra_pcie_pm_suspend(struct device *dev)
> @@ -2800,7 +2785,7 @@ static struct platform_driver tegra_pcie_driver = {
>  		.pm = &tegra_pcie_pm_ops,
>  	},
>  	.probe = tegra_pcie_probe,
> -	.remove = tegra_pcie_remove,
> +	.shutdown = tegra_pcie_shutdown,
>  };
>  builtin_platform_driver(tegra_pcie_driver);
>  MODULE_AUTHOR("Thierry Reding <treding@nvidia.com>");
> 
> -- 
> 2.48.1
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

