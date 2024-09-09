Return-Path: <linux-pm+bounces-13890-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A34AA971B83
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 15:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C8C91F24197
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 13:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5FD1B9B30;
	Mon,  9 Sep 2024 13:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gcQf9CRc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808FE1B29DE
	for <linux-pm@vger.kernel.org>; Mon,  9 Sep 2024 13:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725889618; cv=none; b=O02RNCVu8CxAAHgVkK1ZphYbMxrYWdHFzWDNhA7g4od6lAQ5X9LU+Dfk5FgFBdEkks5I52phDLn/okwSPlulkmJ81nzW4djoPc6m2eZwE7Aa/x/nSc6Ie4sGsU945lZM+xnhNFmx3vTPv6J/TUkLl1t0zCk+fVam5s5gDjOgtUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725889618; c=relaxed/simple;
	bh=yofj/sHugjNfCM5xFAWrUXJCYl4hU+JWG3UcnFdJcSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFToZJmxrJf5zQ174mKEK6uM/vRwZGZBEP+veyfGh4CtOqtz3ghO50cfb0wjf9A96KwLwRdBiD+NgI/za31VXJNFHqfa0XwdFhAMtTWKG+XvWK5S4vIHmJD3QFSekFcMkF8ePPatTteWeVYswfS9lORvNkNJiySr+WWSZce52b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gcQf9CRc; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-374ba78f192so2594696f8f.3
        for <linux-pm@vger.kernel.org>; Mon, 09 Sep 2024 06:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725889614; x=1726494414; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MZJMs+cM8b9Mb08rbw0E4k7M2yJ/iaCH56v82Ef4nN8=;
        b=gcQf9CRc1BkOcLXngdoUriuFCRg+CNJdzprBCwMI27untIfHWjuhN3H4DSppnfVmDB
         xHfC9Ntsl0w1Xafss0YTngGB28r4w1CqzTZlZZV3Hd8WWmcTeHRQ4VatVmnea7k4ytsx
         bgCyO8LRVOrHtgokZT/9czddQqC0aHy4KDot7Oeoo2aiLMtcswS/GCpSmxF4FIOg/4vr
         QwdORPEY5rKzhXXTwfWWD32yVyldM8JrX7BA1VyP/1RPM0UUrejhWLoj3IEihA0rS/Pg
         yLbuMv+VLqEKuxwqrsWJ0P9Cia1386A641WgFlQ+ziX8urXOFHMKxqU5SAfCLJxatEyn
         Bpmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725889614; x=1726494414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZJMs+cM8b9Mb08rbw0E4k7M2yJ/iaCH56v82Ef4nN8=;
        b=Duhy7OforNCEPV6ohR6mHaiCDPuLdxOeRWju2YSbNFtCBWqdi0DX+4Gyurht+UZPkl
         x+0T67wOoeSuqT1Fqz3a+HEqxhcWpTf341MceDkj02C8fWlUUY4iMsQ8ifrpHKaF4NIo
         LTAlepg5v2GbGPQYZ/mX8KjLA52JkHO2JRdwD5BkMdlRx1ZCyAsj5hyG070LO4rjG5uI
         8Pjo1lFAhYuDzaMGTpC/lk2c6bZaYYbdGHRNtV8nbRi95bjNauCtN/3jHRMhzyp2sLFN
         eWn/5rPNbkzySxZn5G9GUjPCDAtu6XIfroCAIKq4/C7Tz984h2gIMKuaPNT5ebY1s9oD
         PIjw==
X-Forwarded-Encrypted: i=1; AJvYcCX7c+tymzZd8cramzD+6wCYkaeqh5YzUxim3VjxbxV153VXstlA5vKEXRaZB0ILeTXDde4zX6RkGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4xISv681jikV6lkMNIIgJq0DoyJm2sk1TRrHdESR1Ngpydmnb
	X1c1l7EtgtE2HIO4Fpujp2ea47LWSfHKJdtRcZXL9MjBco34Py7VOQmc0dnyfzk=
X-Google-Smtp-Source: AGHT+IEzujh33gqo5aEHOZMhYofkl7B5FRX41EcrSbVa7WDJyVLKafsuHGKFLXaUVX+TNSU27NwchA==
X-Received: by 2002:a5d:460c:0:b0:374:c35e:de72 with SMTP id ffacd0b85a97d-378895c53e2mr6641996f8f.2.1725889613498;
        Mon, 09 Sep 2024 06:46:53 -0700 (PDT)
Received: from blmsp ([2001:4091:a247:83d8:caa7:e645:3612:56b6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895675bc9sm6091360f8f.56.2024.09.09.06.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 06:46:53 -0700 (PDT)
Date: Mon, 9 Sep 2024 15:46:52 +0200
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Kevin Hilman <khilman@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, 
	Nishanth Menon <nm@ti.com>, Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>, 
	Akashdeep Kaur <a-kaur@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] pmdomain: ti_sci: handle wake IRQs for IO daisy
 chain wakeups
Message-ID: <yaosrgbsnoujzpouxoyno6yl6vzuoz66fcc5hdylx7jbhodvap@qhcsmz7byi4v>
References: <20240906-lpm-v6-10-constraints-pmdomain-v4-0-4055557fafbc@baylibre.com>
 <20240906-lpm-v6-10-constraints-pmdomain-v4-3-4055557fafbc@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240906-lpm-v6-10-constraints-pmdomain-v4-3-4055557fafbc@baylibre.com>

On Fri, Sep 06, 2024 at 09:14:51AM GMT, Kevin Hilman wrote:
> When a device supports IO daisy-chain wakeups, it uses a dedicated
> wake IRQ.  Devices with IO daisy-chain wakeups enabled should not set
> wakeup constraints since these can happen even from deep power states,
> so should not prevent the DM from picking deep power states.
> 
> Wake IRQs are set with dev_pm_set_wake_irq() or
> dev_pm_set_dedicated_wake_irq().  The latter is used by the serial
> driver used on K3 platforms (drivers/tty/serial/8250/8250_omap.c)
> when the interrupts-extended property is used to describe the
> dedicated wakeup interrupt.
> 
> Detect these wake IRQs in the suspend path, and if set, skip sending
> constraint.
> 
> Tested-by: Dhruva Gole <d-gole@ti.com>
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>

Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>

Best
Markus

> ---
>  drivers/pmdomain/ti/ti_sci_pm_domains.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> index 1ab1e46924ab..566af9f055b8 100644
> --- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
> +++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> @@ -82,6 +82,15 @@ static inline void ti_sci_pd_set_wkup_constraint(struct device *dev)
>  	int ret;
>  
>  	if (device_may_wakeup(dev)) {
> +		/*
> +		 * If device can wakeup using IO daisy chain wakeups,
> +		 * we do not want to set a constraint.
> +		 */
> +		if (dev->power.wakeirq) {
> +			dev_dbg(dev, "%s: has wake IRQ, not setting constraints\n", __func__);
> +			return;
> +		}
> +
>  		ret = ti_sci->ops.pm_ops.set_device_constraint(ti_sci, pd->idx,
>  							       TISCI_MSG_CONSTRAINT_SET);
>  		if (!ret)
> 
> -- 
> 2.46.0
> 

