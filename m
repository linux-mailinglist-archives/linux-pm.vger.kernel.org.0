Return-Path: <linux-pm+bounces-7049-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BC28B1A25
	for <lists+linux-pm@lfdr.de>; Thu, 25 Apr 2024 07:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54E8F1C21236
	for <lists+linux-pm@lfdr.de>; Thu, 25 Apr 2024 05:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DE239FD7;
	Thu, 25 Apr 2024 05:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="otpfreBf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B6F39AF0
	for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2024 05:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714021712; cv=none; b=POmb7og9vTJM07irlgeFe9zHoYKTrxX2SzxJt2vlaN1d/Btw7w1OcQcdVDlGbxaIK7KHR0YMJbZ2g7etfkQY4RoUNWwZJleeSE9U+OrUpG5itLUrWTCpKA+aG/NrEsi9Fp6ozsYPAkpA8z/zghDwiZ3jBQfRiFKi56qGSQZOtg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714021712; c=relaxed/simple;
	bh=N4Ty+El9tAcjw3QBXTN044KOd3tT2Ym9s58oTkqWx9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uv4dh9mNitzVkxSKC/6fwyzlIKijglsd/mZ6iiM/x2KkYl/4PVmdLHd11wCNPR6vw7Cw0yZ+iU4zIy1e7VNuSxlSt+ar0hvWFvkSF4ZVeKj46SBJnKdnrt4l480Gwz/+Rc/KyTSkjn+6vN2trwwPJuXJBr221hW/MNgnkN1LV/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=otpfreBf; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e4266673bbso4794605ad.2
        for <linux-pm@vger.kernel.org>; Wed, 24 Apr 2024 22:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714021711; x=1714626511; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qrmw5y3+0dGAzUFADTeqpuhqYtgOQVDO3UIxdvuDfY8=;
        b=otpfreBf0w1nb2icaPBDebv3Ur0n/ujJLJXh4Ssq3Rxdnky44X4rra0r6vKU+Vxx5I
         PoAAk30oB8tmLw9LRO5HupzJEIeCvP88ZpVlYr4Y9LtY4si0aBikZXuCBbcG2H2PKpld
         j8hg/XUbkaXhgoe9X15jPaY6y9MERgP+Q2fQ0vRbBqPw9CgpujHk8uEc9kwArQXq1SOb
         BfU4gx0h3gcLN72BOCCMrKFLLvgXt6YPt8a2wVNjga+SD/qbfCoLIE+Bpk9RHJrUEW77
         bO3cEjkeyd4QYWOIvI30MO9EMVNu6s5qkR1nNNeqMOxqZ/dmpKb/LEskc42uAXxGHCpL
         NjSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714021711; x=1714626511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qrmw5y3+0dGAzUFADTeqpuhqYtgOQVDO3UIxdvuDfY8=;
        b=PzSO97oQ7q98pGBHEczywyD37IW2NXXoSm2JFCH8BIcb3JWCI30F7pYG7G4usxa3B9
         uDK3hPrRQojRddHelM6HOVenDNYprNioo8niIpZPpjYtzIClk2L4mF4LxK1Rw9WpAlX0
         LMNheJpJk71ThVmls2/4VO0dftntKjZFmdTTVbEe3rYzzIDAidFFaSuJzRAn8Nxw69Mi
         Kxs6eKEfa5W8oslpUCXuuyfFy3uBQvIyCCp7es+Qr7+mwea/cEOlLu2nX58nUu7CudYT
         aynHcBG2x83Z8EWVg/lU51eu3+ELxvMdPuzYefOKPnKfYfuY/ZrEbjG1g/lSfNU5ZSZF
         9zlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUFuCelzQrWKJNjjZ/Fc37n1pr6yuM7qoGVhGkZYocfT64cmKy7B8zRmPEz5AXzXi5g3RPNtLkkCn88ErkBZmHo9/+5FyObLQ=
X-Gm-Message-State: AOJu0Yzj8vN8ZH5Xn+W+h6OzvDuBtaHq/ZaLNZqWMYU1FZeW16HcocO9
	uzdROvnV5p91hDREFHjWRAB1uQpSyLAze2T4hOt9r9CGFIbxONokmTztXru0p8g=
X-Google-Smtp-Source: AGHT+IH96vmh25j6BBEQazt7ICu3yODBTiA7HitL6kUOUPKSDrXvwY+WRBVCOtppGPgOl5/xC362JA==
X-Received: by 2002:a17:903:41cf:b0:1e3:e1e8:bb5 with SMTP id u15-20020a17090341cf00b001e3e1e80bb5mr6077593ple.28.1714021710657;
        Wed, 24 Apr 2024 22:08:30 -0700 (PDT)
Received: from localhost ([122.172.87.52])
        by smtp.gmail.com with ESMTPSA id y17-20020a17090322d100b001e5572a99c3sm12756023plg.207.2024.04.24.22.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 22:08:30 -0700 (PDT)
Date: Thu, 25 Apr 2024 10:38:28 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Andre Przywara <andre.przywara@arm.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] cpufreq: sun50i: fix error returns in
 dt_has_supported_hw()
Message-ID: <20240425050828.iqs7cjslxvb2fzn5@vireshk-i7>
References: <9bfe5703-b39b-4d98-9995-f6a7d0ea558d@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bfe5703-b39b-4d98-9995-f6a7d0ea558d@moroto.mountain>

On 24-04-24, 14:40, Dan Carpenter wrote:
> The dt_has_supported_hw() function returns type bool.  That means these
> negative error codes are cast to true but the function should return
> false instead.
> 
> Fixes: fa5aec9561cf ("cpufreq: sun50i: Add support for opp_supported_hw")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/cpufreq/sun50i-cpufreq-nvmem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied. Thanks.

-- 
viresh

