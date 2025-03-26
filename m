Return-Path: <linux-pm+bounces-24528-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CFAA71D21
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 18:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2ED93B14F1
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 17:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C239121930A;
	Wed, 26 Mar 2025 17:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t4Wh1CsL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BA9218851
	for <linux-pm@vger.kernel.org>; Wed, 26 Mar 2025 17:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743010050; cv=none; b=TJb6ox4XO12ThH9ppzkZhNyGLt7P94yP5Suo7LVbsMah1WC0s48a3Y659GPBWW2b7HJmr0qbGK8j31grN3JnaDh4Yx6sd4OH3TO1HkBowERfCOL8yQtUBvdiDjDeCjGGgc/a+gMm0QrLHiCfnMbtD+PNt2W65cSv/azlgBKPmmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743010050; c=relaxed/simple;
	bh=Ia0PhGqMAWsDXOgtSFy+lOQ9RdAXbV6IFBmUJ8CCJqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+HnTQ05GwLbkfJHrpNMq1TfJt+D9C/lKm6Ojd8CeDAOnOv5lmKVvh8jRnSo4AVyzoloGB6YewD2/UJayPu9GDrnUHdF+9iyoX7Gxws6l0qzAX6K+kwTK9Z6D0Sy6Af/u9ZPhTwydbZIk6WnQIFNq0o0UiCPaliZO2sLGCCrUOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t4Wh1CsL; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3995ff6b066so8419f8f.3
        for <linux-pm@vger.kernel.org>; Wed, 26 Mar 2025 10:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743010046; x=1743614846; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AmZkparCYXGJTs69cCKzbri2rokqJs8Vn/sQzSyVbbc=;
        b=t4Wh1CsL2svvyBUuhydk+dZrq2I+hmYv3kDIUaxDDFPIXC5WwULU0szXacsRS2LFZx
         Lz/Vt2BjzrobPXRwBtnpXSFUVyWg2z53XhjxT2q+vQ8f+Ioydg6Sw9djz11LZwxCFbdo
         dy0RuahKl9h0h7XidBLRJS6KJEu6wou9qtPTQJpYeQSUYxd5dUDhyUL+pX+erwsUgqCb
         HkGvbvos2fQdl0szQZY4JTT9QmfPxw+gZtmqfxq2iFgYJ1AKFUyRfGv00WEOuu6eRanF
         2GYjlzWjnFhgY+0gcm4V5CL3ch03Nfv1d27v0LGwYfW0JZn1ujy3kZsrOZtwKS/EGR/g
         VUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743010046; x=1743614846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AmZkparCYXGJTs69cCKzbri2rokqJs8Vn/sQzSyVbbc=;
        b=Yaa3gLieg+u0umUlt40Pt0Em5H68ts9vqT/1T/utjZEc00rTQ8J8sF7Q8wnFFHG0Hd
         UsSHq5OUcyumbjZTsrs00oxtNwA6KmSJnpT7IzluVKcW96ykddT+z1lC9vBL0kTFyti3
         GipXjkClBoTFsow2w8OTMGeCbW6miQkbB+pTbE8CSPCrHPq6JjDzejXyUrfUY3BbWWWQ
         hTUsTTgkGFqRoORgRuvvikdGSiLMcFPet064zIbRAtVA9Y58XGdrLcO3P3FrCt9OGfwH
         SPVL6pP4W/1A6C4u0WU75zTici/i80lE3ohbKgGnLw46ZbzEgSWEktgmL40FAJNb6msi
         zrxA==
X-Forwarded-Encrypted: i=1; AJvYcCWQxKG2jWkTunuKWVgu6KsItwGMDb8aLnN6LtFK+uC/z8o6AaYW49tEvQmtXSjNr+RlVovqqq7m5w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnrAO50SEskP89zgM7V5aHUHB8JDO8ZMsbg3Ematg3hKMI33NC
	6IrqNdC7h/g2Nl+BfJGxpZTVHchZymiP5w+5ZrcMqFu/cJvLyQsO63WHIkRPmKE=
X-Gm-Gg: ASbGncvl5kPZzDKFUQcZkx2nd0rKUGfbm45RQtrGtOguqZxdusJq3nVmrgNFmrK9mR4
	r3HMvUFPkt4b3+5JeB6MxMOCtc4KpyipHpQUo3lqg2hBZS5YnfkrcbG2Mq1ASQOpXtjC1s82QxM
	gtrHFSMKdotj+DMN7sPY0tfW80JfwOKObLNMg91kDlFTNgcwuk5/eQD4p0ZWJ6orwDFPQ/grC98
	hjCHznloQi8M0/mER3x6wxOrNJelNkQgSe/wRNzjzTmPUmcGIB1TqVJrJ1y3SSxE7Yv9by9HZsM
	lHu451CTiEzdN7WBFaBwv26ie7uGdTLw9KlImKt9wUBSOFs67g==
X-Google-Smtp-Source: AGHT+IF8JYC9RlfIgQWP+kttTdJQ6dCebku0km1zLXYhnZmeNWIVC/9PMLhPpGbPN39BUDBfYGZUvA==
X-Received: by 2002:a5d:64c7:0:b0:391:49f6:dad4 with SMTP id ffacd0b85a97d-39ad176b9e5mr291880f8f.41.1743010046120;
        Wed, 26 Mar 2025 10:27:26 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d830f5f22sm8644785e9.30.2025.03.26.10.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 10:27:25 -0700 (PDT)
Date: Wed, 26 Mar 2025 20:27:23 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Dzmitry Sankouski <dsankouski@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] power: supply: max77705: Fix error code in
 max77705_get_health()
Message-ID: <1c61a172-f623-4698-b753-9c53af9b1275@stanley.mountain>
References: <0ea50e87-2b63-4062-8c2a-17537495f481@stanley.mountain>
 <658c41d0-734b-4397-9687-80b6a219c61c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <658c41d0-734b-4397-9687-80b6a219c61c@linaro.org>

On Wed, Mar 26, 2025 at 06:14:13PM +0100, Krzysztof Kozlowski wrote:
> On 21/03/2025 15:34, Dan Carpenter wrote:
> > Return -EINVAL if the health is bad.  Don't return success.
> > 
> > Fixes: a6a494c8e3ce ("power: supply: max77705: Add charger driver for Maxim 77705")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >  drivers/power/supply/max77705_charger.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/power/supply/max77705_charger.c b/drivers/power/supply/max77705_charger.c
> > index 329b430d0e50..0e347353c41e 100644
> > --- a/drivers/power/supply/max77705_charger.c
> > +++ b/drivers/power/supply/max77705_charger.c
> > @@ -285,7 +285,7 @@ static int max77705_get_health(struct max77705_charger_data *charger, int *val)
> >  	if (is_online) {
> >  		ret = max77705_get_vbus_state(regmap, val);
> >  		if (ret || (*val != POWER_SUPPLY_HEALTH_GOOD))
> > -			return ret;
> > +			return -EINVAL;
> 
> 
> I don't think this is right. First, your commit msg should mention why
> returning -EINVAL in such case.
> 
> Second, if get_vbus_state succeeded, but 'val' is not good (e.g.
> overvoltage), the callback is supposed to return 0 as success of
> retrieving the data, no? So the user-space can read 'val' and figure out
> whatever it needs to figure out (overvoltage).
> 

Yeah.  What you're saying makes sense, especially in context.  I misread
the code.

regards,
dan carpenter


