Return-Path: <linux-pm+bounces-19206-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CC69F14D1
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 19:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF2F27A038E
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 18:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443011E570B;
	Fri, 13 Dec 2024 18:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LuwtijXt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9E21E25F8
	for <linux-pm@vger.kernel.org>; Fri, 13 Dec 2024 18:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734113982; cv=none; b=cJH9TvEBAD+tPLBNOqKGufopGBnHm1QgKCaXUWEwyWjN3A9IrNKFEOLf2PqbH14vwjeSTkoOoJIJIqQkpeh/4aZBi5tKzFkLEm06/rMiGjRQ485W+MMYbZ7b0FVIAlbfvNNmnUCoxQWLLt7C1zwm5R5XepvM9d31Z40Yn+MtDiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734113982; c=relaxed/simple;
	bh=IXFSUo9E+OzDGGUDNTXnj4BxB8uJdqmPFLE01xbjzvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJPxW1sU+xYM7mBjre46cjF5YPoolToAA0wgWkWRFuzxhJ9qIKMZWBSxpdVlCZcz3TmkquisrBqLUswiJJdbP5iONnlYfpO4dPUV5KG9fGySID5VbaGhU6ZCRWfSOrFXrEf32/E3l07REb0S5wVOir38Mwi+p1644NGi+yyzgwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LuwtijXt; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa69107179cso393665566b.0
        for <linux-pm@vger.kernel.org>; Fri, 13 Dec 2024 10:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734113978; x=1734718778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=twtqvRoan+eYnSO74DE1z5GWOoJn7U/yFtJVJQT99vU=;
        b=LuwtijXtu/TRtp8x3r3V33FBl+U2XY24OHV1c/q5xZEQNVUAWx0/XcHoyz7AgdfO+d
         XAw5FBiJkP64DW9W2Jo7harql/rFbt9X8oM+KvWxgUGB7I9rfT5xhZyH3sl4pM6D5iPU
         mwc4PnpD0mZm8PZRJrvlHstWEBlNAbiYpBCc7wT0uTuOQuurKsIFGJAyh35qzKCKYzdb
         U6esIPbmRThhXK9yU/D9QuaujiJZkttnMMOoJLfDq5R/i6PDaIBXeLHcZtaOFce5bRM0
         YBvkMoZ/Mch32Skz2fuJa+WFCTMBeBtv4Z1TWzDWztJqWsdWPZSItWXjsH+6kedfBVRZ
         o+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734113978; x=1734718778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twtqvRoan+eYnSO74DE1z5GWOoJn7U/yFtJVJQT99vU=;
        b=opm8l8gxWvgwSw4sXPP9xyzzAw1uqd5hihJd1IhUeOEUIkq0vJDVlTkQJ72tr3BGQH
         sA1x+i8b9wEXfvdZIOJtZuL3wK1mtxOUtAIhktPNyp+nW3gRcpXKJacDhxadPkA1Mmgq
         mzZDOln4VgVonVAP0WMgqtbyOXrbqZW7nHwkriVNyaMMGQaS5AbcjseOWYhltzTcO6E8
         bUcpwg8b1clY4SyxIpHC/Ct9oKJ4phRXxGhT+lRaosroGzqp4gV/+oodotcz5V1q9AA8
         rJGQbcXoO+0gdRWs0qWDzzQzLr8NIhT6fsUwTrVff8TjU6Mh9CypJI1nW8ILxf1SpDds
         mP7g==
X-Forwarded-Encrypted: i=1; AJvYcCWnfGiFrvUub4V6ygC3WfAjxtXtqa1FvcFww7nqNxyXJom8T0t07cfpsL9s5VlHYHQtSZnrrwPPUA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBKiejNtuxXXS2r0fDa15HsRJXlfTuRbnHZP0ZA6ACiA44zeci
	FTwlj6lynZeztaX9aj7tIEpQmMqkIy1G5Otn4rgH/xEgRjeGFUyrsMhLrfu8/lE=
X-Gm-Gg: ASbGncs4e8/a+xPE2P2PvkfmkGlQXr+8YkuqBhnMBQ8XY/eH6+fBc1qIwFzwQ9BYffq
	3qHWdBPLb6tnJWp997VjtFY432BN3rXZEWT4INrV0VrF90Go3y8LrqwW4QF0IiSxJ8/PWqVq/US
	L+LLoWDR2xKYzOjP8RiZ1RMHpYz0EodDVKSDP6C+sNZaEB7htNSsxVEF9PTO7MVuun6j43ZNSbQ
	P9fR2KDIr1V581esV0O1NHWCkZAPgyn1E/XWWTnwpuHHNNoJ846XOeNDSw802DDapLw
X-Google-Smtp-Source: AGHT+IFInGnVF4NBCAH9r+c7HVFvAHAWd9NOi/wF6K5xsJ3aU4eMArDXdSpkJ1YVcIZmOno3oVCykA==
X-Received: by 2002:a17:907:9615:b0:aa6:5603:e03d with SMTP id a640c23a62f3a-aab77ed3aefmr369683966b.59.1734113978431;
        Fri, 13 Dec 2024 10:19:38 -0800 (PST)
Received: from linaro.org ([2a02:2454:ff21:ef80:79ff:3949:ffc2:a553])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9638ac24sm286066b.137.2024.12.13.10.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 10:19:37 -0800 (PST)
Date: Fri, 13 Dec 2024 19:19:34 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RFT PATCH] Revert "power: sequencing: request the WLAN enable
 GPIO as-is"
Message-ID: <Z1x6ti2KaMdKS1Hn@linaro.org>
References: <20241203141251.11735-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203141251.11735-1-brgl@bgdev.pl>

On Tue, Dec 03, 2024 at 03:12:51PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> This reverts commit a9aaf1ff88a8cb99a1335c9eb76de637f0cf8c10.
> 
> With the changes recently merged into the PCI/pwrctrl/ we now have
> correct ordering between the pwrseq provider and the PCI-pwrctrl
> consumers. With that, the pwrseq WCN driver no longer needs to leave the
> GPIO state as-is and we can remove the workaround.
> 

Should probably revert commit d8b762070c3f ("power: sequencing:
qcom-wcn: set the wlan-enable GPIO to output") as well?

> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/power/sequencing/pwrseq-qcom-wcn.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/sequencing/pwrseq-qcom-wcn.c b/drivers/power/sequencing/pwrseq-qcom-wcn.c
> index 682a9beac69eb..bb8c47280b7bc 100644
> --- a/drivers/power/sequencing/pwrseq-qcom-wcn.c
> +++ b/drivers/power/sequencing/pwrseq-qcom-wcn.c
> @@ -379,7 +379,7 @@ static int pwrseq_qcom_wcn_probe(struct platform_device *pdev)
>  				     "Failed to get the Bluetooth enable GPIO\n");
>  
>  	ctx->wlan_gpio = devm_gpiod_get_optional(dev, "wlan-enable",
> -						 GPIOD_ASIS);
> +						 GPIOD_OUT_LOW);
>  	if (IS_ERR(ctx->wlan_gpio))
>  		return dev_err_probe(dev, PTR_ERR(ctx->wlan_gpio),
>  				     "Failed to get the WLAN enable GPIO\n");
> -- 
> 2.30.2
> 

I'm not sure why but applying this patch brings back the error I had
before. It does seem like setting wlan-enable GPIO happens early enough,
but maybe some timing is still wrong.

[   17.132161] <gpiod_set_value_cansleep(ctx->wlan_gpio, 1);>
[   17.480619] ath12k_pci 0004:01:00.0: of_irq_parse_pci: failed with rc=134
[   17.491997] ath12k_pci 0004:01:00.0: pci device id mismatch: 0xffff 0x1107
[   17.492000] ath12k_pci 0004:01:00.0: failed to claim device: -5
[   17.492075] ath12k_pci 0004:01:00.0: probe with driver ath12k_pci failed with error -5

Any ideas/suggestions?

Thanks,
Stephan

