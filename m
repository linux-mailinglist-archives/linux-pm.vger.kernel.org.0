Return-Path: <linux-pm+bounces-19277-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 786659F2AB2
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 08:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36C72168D17
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 07:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A590B1CEACD;
	Mon, 16 Dec 2024 07:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W8a1cwRe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F2B1CEAC1
	for <linux-pm@vger.kernel.org>; Mon, 16 Dec 2024 07:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734332770; cv=none; b=CmH9yY2xQIG8SkDbR5gEoiipO5466KpaUWG8bwdqduSP2g5N8I7h3yh23V80fxJj2Q7DJ+ovOzY8R8zPTYM/1Fym2lzAS8Y5pJPRUeVsnaG8dfkmygVaWLQCuQW+qoGRe5sRHwlvCl7DY0/xiZgUmXD5/cM46zfnV4BY0oq6UZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734332770; c=relaxed/simple;
	bh=I238hIWx+Cz/FYS1dqqAD1UvSMg2hrKOWPzfKgLdgzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdxRF/h7YGbxxhL4qko+Lq9S6Gyl9Q2yMFZzbN02q0ee7YEgu7VN1HzfZmF6tRE89EPm1l2/bCbVs3OePAL8lxkSt6rP86IZua1cuYB78wh4lxvjFp8EZC1Teu1nNsIWaBO2xuLqu4wWNFHRw68rSw/qP9h+qa3i40dsBj63kDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W8a1cwRe; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21631789fcdso30960485ad.1
        for <linux-pm@vger.kernel.org>; Sun, 15 Dec 2024 23:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734332768; x=1734937568; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ziUY36k0W7WB4ux5sJzImTve/z2GKofoJlBRVwKWqug=;
        b=W8a1cwReF3qGOL4xtCqxo8jmsIYarB4qqNJ/V+0dlpy5C4WbszUPEEg9qmvuLvHH95
         1Vy+j+PmQc2ABj/K7N9XmmWjAsEQMLNxnaX8IZ0CUEgFJQ2L+KQ+4rhz6AZK/3uPnwaq
         Ce1jwTduKGXbhf75oQtLYsT56+ADeA/wPsvEjIbMRLKT5gTWVByPA9GkUlLonJ9GErmN
         VljnxRzfzdifaKvvsPQswuc9spy9uxHtFY2siapjqYb0EyxZnOB3HU3w9r/nKEWoUAF/
         6FSeBAMvixfNY5JP8gRnMOar3iUoisA4CFvuqsgiSZa59ffAXDaKdlo7y+dsaPG3mr01
         ioTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734332768; x=1734937568;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ziUY36k0W7WB4ux5sJzImTve/z2GKofoJlBRVwKWqug=;
        b=d6LXgep3DR+snbDD0JjU74y2gSfw9eGrtUSvE2J0WJ5qwyAK9t/pFJvz36llSPpYOC
         g9jETum/2CWcDlizFZ3pC1e183pRAnVpTv6HfXGmR6gLdH9RPCUZXSz5yxzpOXLVmbx1
         Of5Z8ZzTcFX5qbTRLgfwh/mss6SdxED0UMiFD0ISUqaJZuRf6qatd9dHze3UwtxVUSOB
         ZbxUF9rcuCVSOR2iwqjtfg61UhVZqLOEwBgzNNLz/V9w7ehaf/qN2sk1Y8xOGDEr3nRv
         JMfDyMkR5n6syUI0kRJjGL/6dTddE5bGopwU6TQygkRVHSyKIsn6OYLNTGpxk5TfqYC7
         kxEg==
X-Forwarded-Encrypted: i=1; AJvYcCXmZAmGnXPLkePzZn8qFzc3wrUxWMh1lcjFWX0kgKUvbkfle9Sx8ldpYiPGu930Q1i0iQNvEtrXLw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2aSQpzOFSKXG2IHz+Y4iJ3iOoHeR2qzYFXLL8/d3+QbqKZb8H
	4lPm+9/YeTlqPomwKAfehAQXjsQsavy0/Jntl4wOS77LdByfmfWPQICmOmzwP3TM4YSg2BL1XqI
	=
X-Gm-Gg: ASbGncsz2UfhJNy8Q/NQvhRibpYsYC38ohKubq6Fn6QWjLBuUEs69/O4mz5f5ezNRkK
	8HgV0Q6kDKOs1KWq9YLTURIv3/91OROI5qEdsuXZ1pv5qKkfrV5YVOq9RctGVrLTQq9jyWL0V9A
	1CZcgl0+ZXyc53JeLbNS6ur6GuWMvgjhqZVEQYp5v7Acbi8wdFifV9CV5QG7bPz0IV/tHX4aMoT
	2+XlAOuiBygJslPaUnn018eYm7/s1UZcvpzOSNKPr5sjg4TCQK4rm+u6wcoZ5Dh0ng=
X-Google-Smtp-Source: AGHT+IEfZZiyHGK/1Nx+GCELiO0Jo8KYv56K/wIilz36vVZ/8tAo3OmYY9U/N6lMaVPZU9l74zQh9Q==
X-Received: by 2002:a17:903:230b:b0:216:3e87:ca00 with SMTP id d9443c01a7336-2178c893460mr217810835ad.28.1734332768003;
        Sun, 15 Dec 2024 23:06:08 -0800 (PST)
Received: from thinkpad ([120.60.56.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e64034sm36057015ad.231.2024.12.15.23.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 23:06:07 -0800 (PST)
Date: Mon, 16 Dec 2024 12:35:54 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RFT PATCH] Revert "power: sequencing: request the WLAN enable
 GPIO as-is"
Message-ID: <20241216070554.ym54ozdw45zhveo7@thinkpad>
References: <20241203141251.11735-1-brgl@bgdev.pl>
 <Z1x6ti2KaMdKS1Hn@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1x6ti2KaMdKS1Hn@linaro.org>

On Fri, Dec 13, 2024 at 07:19:34PM +0100, Stephan Gerhold wrote:
> On Tue, Dec 03, 2024 at 03:12:51PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > 
> > This reverts commit a9aaf1ff88a8cb99a1335c9eb76de637f0cf8c10.
> > 
> > With the changes recently merged into the PCI/pwrctrl/ we now have
> > correct ordering between the pwrseq provider and the PCI-pwrctrl
> > consumers. With that, the pwrseq WCN driver no longer needs to leave the
> > GPIO state as-is and we can remove the workaround.
> > 
> 
> Should probably revert commit d8b762070c3f ("power: sequencing:
> qcom-wcn: set the wlan-enable GPIO to output") as well?
> 
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  drivers/power/sequencing/pwrseq-qcom-wcn.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/power/sequencing/pwrseq-qcom-wcn.c b/drivers/power/sequencing/pwrseq-qcom-wcn.c
> > index 682a9beac69eb..bb8c47280b7bc 100644
> > --- a/drivers/power/sequencing/pwrseq-qcom-wcn.c
> > +++ b/drivers/power/sequencing/pwrseq-qcom-wcn.c
> > @@ -379,7 +379,7 @@ static int pwrseq_qcom_wcn_probe(struct platform_device *pdev)
> >  				     "Failed to get the Bluetooth enable GPIO\n");
> >  
> >  	ctx->wlan_gpio = devm_gpiod_get_optional(dev, "wlan-enable",
> > -						 GPIOD_ASIS);
> > +						 GPIOD_OUT_LOW);
> >  	if (IS_ERR(ctx->wlan_gpio))
> >  		return dev_err_probe(dev, PTR_ERR(ctx->wlan_gpio),
> >  				     "Failed to get the WLAN enable GPIO\n");
> > -- 
> > 2.30.2
> > 
> 
> I'm not sure why but applying this patch brings back the error I had
> before. It does seem like setting wlan-enable GPIO happens early enough,
> but maybe some timing is still wrong.
>

There should be no room for timing issue now :/
 
> [   17.132161] <gpiod_set_value_cansleep(ctx->wlan_gpio, 1);>
> [   17.480619] ath12k_pci 0004:01:00.0: of_irq_parse_pci: failed with rc=134
> [   17.491997] ath12k_pci 0004:01:00.0: pci device id mismatch: 0xffff 0x1107
> [   17.492000] ath12k_pci 0004:01:00.0: failed to claim device: -5
> [   17.492075] ath12k_pci 0004:01:00.0: probe with driver ath12k_pci failed with error -5
> 

Are you sure that this is the same error that you noticed before?

> Any ideas/suggestions?
> 

Can you verify that the pwrctrl driver's probe is completed *before* ath12k
driver starting to probe by adding the debug prints in both drivers?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

