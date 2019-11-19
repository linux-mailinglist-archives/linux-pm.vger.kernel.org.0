Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 226AB102A14
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2019 17:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbfKSQ6E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Nov 2019 11:58:04 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36574 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728769AbfKSQ5x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Nov 2019 11:57:53 -0500
Received: by mail-lf1-f68.google.com with SMTP id r14so11036842lff.3;
        Tue, 19 Nov 2019 08:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j+gYl8HldvGbyx97hnAX9xUoG7AkMiMS7oU+UeQIp7E=;
        b=CuLivwxbWs7Wcoly7djIIVs9XgobzAL92vYSDeyg8DXLNM9dqJ87GCy2z05epyY/eH
         k2bniNhos/o7H5rA/XSVuuk7+EmuPuUdUcl7yDpq+goMg3V4cw/kD4sjKcvfqiElIo8j
         SvpUlWocaA52Oa+7Dw0HHiq6SM+UXZmx4VLf0zqE45psgcevhHkOWm49io2COxxv7dAR
         +FNtQfbJj+E6WU+zgrMbvYmmoaB5Qiopf4PEFT6BjQGTc/xDXp1br0Lk8o8uLoo+F4RD
         RZ4JrOOy6YuNJm1HxeO65M8ezAMXMYywgX8F5iEKh07EKN1Bilh1PWDsh8WdnzP5itd0
         R7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j+gYl8HldvGbyx97hnAX9xUoG7AkMiMS7oU+UeQIp7E=;
        b=f0lhm8Hy7D3/OTE7CsuK1N3YPqkom5uaCKo8o6IXjHKmaRe3dCaCVvP+VabJYIIl09
         2gDsxMjjamk3tVk9SCF62WP71kvcmdZaUoWg4AOHWk0ruUi7id1xwwlvDhZfHhTnvwHy
         b1LRbQ//7Iq/Q/d6QyW33c8SAOvmZ8dpv93S87OBlgAizyDzCemZ36Q/Z21VCM7eFeb4
         PcxhMQhZqrnS9T0fa2IK0H3tLN/Rqe4tp8v/ER/o9Kkq5o4W/3irS5hhAMyrpxqtYc3L
         CBGigsy+VFfIx2myrfpgAXT4D5g6mn91PMKlJk2gXo7EpW+6N0lSVZk7CFH3GmhG57kY
         GN5Q==
X-Gm-Message-State: APjAAAUae4KjrH3eQauOlrs9Z7NhUW8/WcUH4dUUlUkfzwu7Ghbf1ETB
        fQQLKV8KaOj/dRoF0x2KY0MLNbjK
X-Google-Smtp-Source: APXvYqz8vet4QWY5IUi4C6ihSYs+/14tbC3f6wpa0eTLtn7PYqBbI69ydT5j/A2C2hRcVFQx+8A1eQ==
X-Received: by 2002:ac2:44d4:: with SMTP id d20mr4812970lfm.88.1574182671483;
        Tue, 19 Nov 2019 08:57:51 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id 3sm10781212lfq.55.2019.11.19.08.57.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2019 08:57:51 -0800 (PST)
Subject: Re: [PATCH v1 23/29] memory: tegra124-emc: Register as interconnect
 provider
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
References: <20191118200247.3567-1-digetx@gmail.com>
 <20191118200247.3567-24-digetx@gmail.com>
Message-ID: <4ad5dca2-12c9-8e96-c68c-0dcdb9860fd9@gmail.com>
Date:   Tue, 19 Nov 2019 19:57:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191118200247.3567-24-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

18.11.2019 23:02, Dmitry Osipenko пишет:
> EMC now provides MC with memory bandwidth using interconnect API.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/tegra124-emc.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/memory/tegra/tegra124-emc.c b/drivers/memory/tegra/tegra124-emc.c
> index 2c73260654ba..c9478dcbeece 100644
> --- a/drivers/memory/tegra/tegra124-emc.c
> +++ b/drivers/memory/tegra/tegra124-emc.c
> @@ -25,6 +25,7 @@
>  #define EMC_FBIO_CFG5				0x104
>  #define	EMC_FBIO_CFG5_DRAM_TYPE_MASK		0x3
>  #define	EMC_FBIO_CFG5_DRAM_TYPE_SHIFT		0
> +#define EMC_FBIO_CFG5_DRAM_WIDTH_X64		BIT(4)
>  
>  #define EMC_INTSTATUS				0x0
>  #define EMC_INTSTATUS_CLKCHANGE_COMPLETE	BIT(4)
> @@ -1080,11 +1081,28 @@ static void emc_debugfs_init(struct device *dev, struct tegra_emc *emc)
>  		dev_err(dev, "failed to create debugfs entry\n");
>  }
>  
> +static unsigned int emc_dram_data_bus_width_bytes(struct tegra_emc *emc)
> +{
> +	unsigned int bus_width;
> +	u32 emc_cfg;
> +
> +	emc_cfg = readl_relaxed(emc->regs + EMC_FBIO_CFG5);
> +	if (emc_cfg & EMC_FBIO_CFG5_DRAM_WIDTH_X64)
> +		bus_width = 64;
> +	else
> +		bus_width = 32;

Looks like I got a bit confused while was looking at TRMs before, seems
this width is unrelated to the EMC channel at all. I'll try to revisit
this again.

> +	dev_info(emc->dev, "DRAM data-bus width: %ubit\n", bus_width);
> +
> +	return bus_width / 8;
> +}
> +
>  static int tegra_emc_probe(struct platform_device *pdev)
>  {
>  	struct platform_device *mc;
>  	struct device_node *np;
>  	struct tegra_emc *emc;
> +	unsigned int bus_width;
>  	u32 ram_code;
>  	int err;
>  
> @@ -1146,6 +1164,12 @@ static int tegra_emc_probe(struct platform_device *pdev)
>  	if (IS_ENABLED(CONFIG_DEBUG_FS))
>  		emc_debugfs_init(&pdev->dev, emc);
>  
> +	bus_width = emc_dram_data_bus_width_bytes(emc);
> +
> +	err = tegra_icc_emc_setup_interconnect(&pdev->dev, bus_width);
> +	if (err)
> +		dev_err(&pdev->dev, "failed to initialize ICC: %d\n", err);
> +
>  	return 0;
>  };
>  
> 

