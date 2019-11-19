Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 840C1102A46
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2019 18:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbfKSRAD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Nov 2019 12:00:03 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43698 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbfKSRAC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Nov 2019 12:00:02 -0500
Received: by mail-lj1-f196.google.com with SMTP id y23so24148254ljh.10;
        Tue, 19 Nov 2019 09:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EWN1ZpXN/f4GXP8V3XISkI6qP/p5d7CKryKCLpJongQ=;
        b=aV6b0zLK4e7wbM1ZqDppNii3W6Ag4g5//no+UHoUiVeNIQgXKDrnfxRLKpfBT8VqBo
         qBtgQiapfJ2JKvZBuaMVlROzz3SCBM1cugVluR5kWQm9fi25lc1zS5klcPis9FLahaOw
         /g53hBUEu5u43bK+URJzsoM4AP7d7MRZ0plD0maa7r8BksyFqTxy+wx+noGZ78dxUphQ
         DxNRXt5wJMus1KC/9ZmV+GbBAx4KC+htMC4PFs6IZTzwlKFHeHHv6gFLlOIhMrEdnbcX
         +NTUIVuLZB+X/Q55XOgdgGj4hV9lYO2GhTsR//EEFh5Kh29XPZZzEnlad3pPE9lF22WV
         u+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EWN1ZpXN/f4GXP8V3XISkI6qP/p5d7CKryKCLpJongQ=;
        b=L1HHSRhY2H1Rn9eTedq8IBNNCU+W+Q0vXhuJOZaoMWbV0oM1RU9KEguQ4550L6Uzvk
         kvtQzxI1rbPQS3BP8RqEHNCvOPW4ZUUhcp0n89BUYDDCcM2EsEyhPouaK2CHsfK6GSdi
         uEYPKGaeC4R8P8feMKU5X/3UxlVEZjOTXFzPg7k0z3WDG4vZtxKMRQLIwJasOkTwJAXH
         otXEB37f80unDeyrMMlREgqHkaM4EVdVRBfndQ7tomCa0t6+LsXuZdmbi8LXIogc4b1+
         52Lr9ymZoeawq8/ye1Qr7L2FcCK3BXaOUd2Px8sV7g1kKZvncHD/I9GtPX9cy5SD+Ulf
         DMYA==
X-Gm-Message-State: APjAAAXdKj715bdU3pGy+XZMP2oXh95M6eYsLJYfSOXM4xRVoL8tr5Jd
        qqtmu5cxHP0FOxcQOXCfcK8n3Bcm
X-Google-Smtp-Source: APXvYqzUJ15qHXRQXDdLUOjO7y7PndvAwTYq5Hd82LpDfgGl42VActAGgmwBJM+mFWepTDd8E6UwPQ==
X-Received: by 2002:a05:651c:390:: with SMTP id e16mr4856596ljp.196.1574182799913;
        Tue, 19 Nov 2019 08:59:59 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id 206sm1213375lfb.20.2019.11.19.08.59.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2019 08:59:59 -0800 (PST)
Subject: Re: [PATCH v1 12/29] interconnect: Add memory interconnection
 providers for NVIDIA Tegra SoCs
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
References: <20191118200247.3567-1-digetx@gmail.com>
 <20191118200247.3567-13-digetx@gmail.com> <20191119063139.GF2462695@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <044b17a8-7186-fec0-e786-5ec5a13e5873@gmail.com>
Date:   Tue, 19 Nov 2019 19:59:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191119063139.GF2462695@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

19.11.2019 09:31, Thierry Reding пишет:
> On Mon, Nov 18, 2019 at 11:02:30PM +0300, Dmitry Osipenko wrote:
> [...]
>> diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
>> index 1238e35653d1..593954324259 100644
>> --- a/include/soc/tegra/mc.h
>> +++ b/include/soc/tegra/mc.h
>> @@ -141,6 +141,11 @@ struct tegra_mc_reset_ops {
>>  			    const struct tegra_mc_reset *rst);
>>  };
>>  
>> +struct tegra_mc_icc_node {
>> +	const char *name;
>> +	unsigned int id;
>> +};
>> +
>>  struct tegra_mc_soc {
>>  	const struct tegra_mc_client *clients;
>>  	unsigned int num_clients;
>> @@ -160,6 +165,9 @@ struct tegra_mc_soc {
>>  	const struct tegra_mc_reset_ops *reset_ops;
>>  	const struct tegra_mc_reset *resets;
>>  	unsigned int num_resets;
>> +
>> +	const struct tegra_mc_icc_node *icc_nodes;
>> +	unsigned int num_icc_nodes;
>>  };
>>  
>>  struct tegra_mc {
>> @@ -184,4 +192,22 @@ struct tegra_mc {
>>  int tegra_mc_write_emem_configuration(struct tegra_mc *mc, unsigned long rate);
>>  unsigned int tegra_mc_get_emem_device_count(struct tegra_mc *mc);
>>  
>> +#ifdef CONFIG_INTERCONNECT_TEGRA
>> +int tegra_icc_mc_setup_interconnect(struct tegra_mc *mc);
>> +int tegra_icc_emc_setup_interconnect(struct device *emc_dev,
>> +				     unsigned int dram_data_bus_width_bytes);
>> +#else
>> +static inline int tegra_icc_mc_setup_interconnect(struct tegra_mc *mc);
>> +{
>> +	return 0;
>> +}
>> +
>> +static inline int
>> +tegra_icc_emc_setup_interconnect(struct device *emc_dev,
>> +				 unsigned int dram_data_bus_width_bytes)
>> +{
>> +	return 0;
>> +}
>> +#endif
> 
> Is there really any reason why we should make this support optional? It
> seems to me like we would always want this enabled once it's tested and
> known to work.

There is always some room for bugs, should be better to have an option
to disable ICC entirely (IMO).
