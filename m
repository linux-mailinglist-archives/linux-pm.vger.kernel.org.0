Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3D113D5B6
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2020 09:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgAPIIg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jan 2020 03:08:36 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44865 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbgAPIIg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jan 2020 03:08:36 -0500
Received: by mail-wr1-f65.google.com with SMTP id q10so18114358wrm.11
        for <linux-pm@vger.kernel.org>; Thu, 16 Jan 2020 00:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pDZeIUUeVkDXcMgdUokp5B95jJ/wYdNnrmrwJEAkSm0=;
        b=na1PKEcYS7SjEAfl9iCaU0H/Co3Z/V2YYmFUpBq86gGTeP44+2VWq7VmeMMqCtFS+f
         agtZkdii0DGf5aoewoOTIFMxTQu9TQNn8C6JoNw1Xp2MvjDJE49PqmIxpJ9NT0nF7Ji4
         FH/2XOKcAVpfrEXcFjAYw13Cu60h987YrS4v8qzHZEYIujeqV9TvmMBKgpmPYO8mklI9
         JLKbtJ2uOQCMQZTy4k8lEfvaYx+Jo1r2WONlm4TMFlfrTsJ1we1X+cqUtlwomLQS4oc+
         3YL1aNiv6P2wpqgYYH8PXbd3s2JUBfBf/es7tsq+U+cMEqhIzHyvdyqar7an0QcyABJX
         JjXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=pDZeIUUeVkDXcMgdUokp5B95jJ/wYdNnrmrwJEAkSm0=;
        b=ZSy2iXbdVV4hFWaSnMlBdfuCZari55SrRdHmYBb09w/7Z6Hfp8lfUzITB0SjCLhoKU
         54+1WELXOo3mYFn0uH3azURS5sUdVb5DERjTLeOjWznHavFbdReeR8u8Wx+UjSt4526d
         6sDt8zUZuE8Q0yoWP1SVO4CKfgyjCpHyY2gP+8wyqdhte4ndRSK4LuckCSl2TwkngUrE
         zxf6oNWxr3+4VdNdDJUUKgLY33ONhiaux1W1R3leivr05tEbIRgtyjLPCWMm/wxISbvU
         13KxQy5SeS1vR74gTPaHQpyc8CH3A7qx16XdWvvZCvGPkZlvI+91PanG72SI7JhhABtk
         D/0g==
X-Gm-Message-State: APjAAAW/bN+B8s8Bi1DnLyPnjHGcAe1HAxm1T3MFc2ky/v36uM8WTzf2
        l3U/t1CLk2A1soISSXmBiJxLJg==
X-Google-Smtp-Source: APXvYqzGoq80WD/aA/SG9rJXQJ577Qa+QJ6azPndG4Mz8UTtixo3aVZq4gmdAb8RvM75gPybW12TtA==
X-Received: by 2002:adf:90e7:: with SMTP id i94mr1805499wri.47.1579162112765;
        Thu, 16 Jan 2020 00:08:32 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:6c63:1b50:1156:7f0f? ([2a01:e34:ed2f:f020:6c63:1b50:1156:7f0f])
        by smtp.googlemail.com with ESMTPSA id r6sm28994157wrq.92.2020.01.16.00.08.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2020 00:08:32 -0800 (PST)
Subject: Re: [PATCH] thermal: intel_pch_thermal: Add PCI ids for Lewisburg
 PCH.
To:     Andres Freund <andres@anarazel.de>,
        Tushar Dave <tushar.n.dave@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200115184415.1726953-1-andres@anarazel.de>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b7f5365a-08bb-fb5d-ddc9-b81774c5c942@linaro.org>
Date:   Thu, 16 Jan 2020 09:08:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200115184415.1726953-1-andres@anarazel.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Rui,

are you fine with this patch?


On 15/01/2020 19:44, Andres Freund wrote:
> I noticed that I couldn't read the PCH temperature on my workstation
> (C620 series chipset, w/ 2x Xeon Gold 5215 CPUs) directly, but had to go
> through IPMI. Looking at the data sheet, it looks to me like the
> existing intel PCH thermal driver should work without changes for
> Lewisburg.
> 
> I suspect there's some other PCI id's missing. But I hope somebody at
> Intel would have an easier time figuring that out than I...
> 
> Signed-off-by: Andres Freund <andres@anarazel.de>
> ---
>  drivers/thermal/intel/intel_pch_thermal.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/intel/intel_pch_thermal.c
> index 4f0bb8f502e1..1f3ff0d489ef 100644
> --- a/drivers/thermal/intel/intel_pch_thermal.c
> +++ b/drivers/thermal/intel/intel_pch_thermal.c
> @@ -23,6 +23,7 @@
>  #define PCH_THERMAL_DID_SKL_H	0xA131 /* Skylake PCH 100 series */
>  #define PCH_THERMAL_DID_CNL	0x9Df9 /* CNL PCH */
>  #define PCH_THERMAL_DID_CNL_H	0xA379 /* CNL-H PCH */
> +#define PCH_THERMAL_DID_LWB	0xA1B1 /* Lewisburg PCH */
>  
>  /* Wildcat Point-LP  PCH Thermal registers */
>  #define WPT_TEMP	0x0000	/* Temperature */
> @@ -272,6 +273,7 @@ enum board_ids {
>  	board_wpt,
>  	board_skl,
>  	board_cnl,
> +	board_lwb,
>  };
>  
>  static const struct board_info {
> @@ -294,6 +296,10 @@ static const struct board_info {
>  		.name = "pch_cannonlake",
>  		.ops = &pch_dev_ops_wpt,
>  	},
> +	[board_lwb] = {
> +		.name = "pch_lewisburg",
> +		.ops = &pch_dev_ops_wpt,
> +	},
>  };
>  
>  static int intel_pch_thermal_probe(struct pci_dev *pdev,
> @@ -398,6 +404,8 @@ static const struct pci_device_id intel_pch_thermal_id[] = {
>  		.driver_data = board_cnl, },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_CNL_H),
>  		.driver_data = board_cnl, },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_LWB),
> +		.driver_data = board_lwb, },
>  	{ 0, },
>  };
>  MODULE_DEVICE_TABLE(pci, intel_pch_thermal_id);
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

