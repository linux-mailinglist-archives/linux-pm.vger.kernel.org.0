Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10EC019FA51
	for <lists+linux-pm@lfdr.de>; Mon,  6 Apr 2020 18:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbgDFQkN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Apr 2020 12:40:13 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40103 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729488AbgDFQkM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Apr 2020 12:40:12 -0400
Received: by mail-wr1-f68.google.com with SMTP id s8so197435wrt.7
        for <linux-pm@vger.kernel.org>; Mon, 06 Apr 2020 09:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NgLl7HHSoLMH6wWDMAS/slExign8Bsc9NbQ/c/sVCug=;
        b=aNvHE5D671GXZ8oV3SdiIYeuNCd6IxEYlIYPCTCYq0MmTbXw3gp/BQ0kbVc0zO0XEN
         8vmpAna2SLdH/vT4Wy5P2I6YgEiZCrWhWv+QSMhsec+5krD80cqLNRHP9WoBXJVf8g3O
         sijUrTyVkAAkhX6zkx8aZJHE7XlOf+0RiNdCyRZy63a3R1kR6CHJVPdeYgBOyt+dVppm
         fGc2VExSve5vmHykEsAC6pKnoJ99IZ9pd5gwXS6IQ5lgwIPRNdjUvWNrgDenHw+JT3GA
         pd0k0LZhn1sr9iVs7S+JSuxC/25O7yPgebagu1JGTxa+eIIZaRlW0wvcNLlROKZLgnoF
         dNBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=NgLl7HHSoLMH6wWDMAS/slExign8Bsc9NbQ/c/sVCug=;
        b=X5lVvSBFIQRCJ7PLyWXqp76gch4XqGQ+SVhO+ijCTOp6vJiZSn+RBbyaGIqFuyvRVt
         wRn0NgzWefF1h+7ZeucASrK3MC7KH9TFL1nu1LoeqNFYddyIRtU5p/3Du+zwhwKujbs7
         YJ44BDzIgCIegVNY1/55vx0Zu/oPiQ6TzJx1QLQRBOjHfzCuliGrQ6kPihVTLdk4F+v+
         IXZVdloyIS4Q5VpicRvCOdNZzd7PCTsOzeA77fKmG6q/eyKRoTFtad/qvEF7A7EDAomD
         AwwF9ohd8TuHymPQACHytkNUPHjd71MgVleXXX96uE6ll1IlBHZNzIiUkYjTJldQXPX2
         e3OA==
X-Gm-Message-State: AGi0PuY5qJXbmLZFS/rDJnBpXilqin0z3kJtQRO8uB0+S2v4bOiDY2O8
        ZU2V278Sr3AvrqyL4FX2QgeoIg==
X-Google-Smtp-Source: APiQypLzGRhZvCUulrdZtWRMfjVXOxZf54dtj2/PsNeoJ4slTbBhRzqUC3MaFxUjEqaBkHjrXolDmQ==
X-Received: by 2002:adf:f841:: with SMTP id d1mr22628wrq.381.1586191209261;
        Mon, 06 Apr 2020 09:40:09 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:b51c:42dc:1499:2880? ([2a01:e34:ed2f:f020:b51c:42dc:1499:2880])
        by smtp.googlemail.com with ESMTPSA id u22sm133042wmu.43.2020.04.06.09.40.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 09:40:08 -0700 (PDT)
Subject: Re: [PATCH v5 2/4] thermal: k3: Add support for bandgap sensors
To:     Keerthy <j-keerthy@ti.com>, rui.zhang@intel.com, robh+dt@kernel.org
Cc:     amit.kucheria@verdurent.com, t-kristo@ti.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        mark.rutland@arm.com
References: <20200331075356.19171-1-j-keerthy@ti.com>
 <20200331075356.19171-3-j-keerthy@ti.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <3dce9790-1414-0768-7e47-07cdfba52aab@linaro.org>
Date:   Mon, 6 Apr 2020 18:40:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200331075356.19171-3-j-keerthy@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 31/03/2020 09:53, Keerthy wrote:
> The bandgap provides current and voltage reference for its internal
> circuits and other analog IP blocks. The analog-to-digital
> converter (ADC) produces an output value that is proportional
> to the silicon temperature.
> 
> Currently reading temperatures only is supported.
> There are no active/passive cooling agent supported.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---

[ ... ]

> +static int k3_bandgap_probe(struct platform_device *pdev)
> +{
> +	int ret = 0, cnt, val, id, reg_cnt = 0;

We missed 'reg_cnt' which is not used.

[ ... ]

> +	/* Register the thermal sensors */
> +	for (id = 0; id < cnt; id++) {
> +		data[id].sensor_id = id;
> +		data[id].bgp = bgp;
> +		data[id].ctrl_offset = K3_VTM_TMPSENS0_CTRL_OFFSET +
> +					id * K3_VTM_REGS_PER_TS;
> +		data[id].stat_offset = data[id].ctrl_offset + 0x8;
> +
> +		val = readl(data[id].bgp->base + data[id].ctrl_offset);
> +		val |= (K3_VTM_TMPSENS_CTRL_SOC |
> +			K3_VTM_TMPSENS_CTRL_CLRZ |
> +			K3_VTM_TMPSENS_CTRL_CLKON_REQ);
> +		val &= ~K3_VTM_TMPSENS_CTRL_CBIASSEL;
> +		writel(val, data[id].bgp->base + data[id].ctrl_offset);
> +
> +		data[id].ti_thermal =
> +		devm_thermal_zone_of_sensor_register(dev, id,
> +						     &data[id],
> +						     &k3_of_thermal_ops);
> +		if (IS_ERR(data[id].ti_thermal)) {
> +			dev_err(dev, "thermal zone device is NULL\n");
> +			ret = PTR_ERR(data[id].ti_thermal);
> +			goto err_alloc;
> +		}
> +
> +		reg_cnt++;
> +	}

[ ... ]


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
