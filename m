Return-Path: <linux-pm+bounces-11390-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D14093BD17
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2024 09:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D0F21F22124
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2024 07:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9726F16F830;
	Thu, 25 Jul 2024 07:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d/Mpx76N"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253702773C
	for <linux-pm@vger.kernel.org>; Thu, 25 Jul 2024 07:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721892410; cv=none; b=ePftMZFIvUg4b4bOn0SsH4r4FQN+il5qyPyLUHH4KwAdXnShXUbIe2wrJNM6EJjRX28Ldbnp4nVNwJerUk86mYb3va3bbajjrDMlWLyhNcL2myms1kfJYt+3zyfRjigIGVZexXCN5nxgfkqeVGjWS10+hBZc/oq521fK80BMdRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721892410; c=relaxed/simple;
	bh=tKPefqgTDnup3MvvY9fJp6KP28+Qto27xhG7wD/859Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhEHc6D64oGQaN19TXmB6kA5Ifc+WpTWWS/4bN/1s85FWHbtgyCi/f2TxcewpmEYjcXBGuQFw0MMlxBdXl9QnhTTtvT/siNgw0eH40FEVTsj8j7g4pLo3Q4e+LdzlxsO9NYeWL1ulAuj7JJbQ9ABD3d8IS65nJV1R+WCslLZqE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d/Mpx76N; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70d2e68f5a8so467980b3a.3
        for <linux-pm@vger.kernel.org>; Thu, 25 Jul 2024 00:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721892408; x=1722497208; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3q5HcmtrWAnPNTpXMegj65YWsUrKJvUrcP825ZJd0RU=;
        b=d/Mpx76NEjTiON77vp/vwVlkjwcgjkBZZeHpaM+nroEHsR+SNODOXvnJFinmqx1/85
         coQ4J32JnxKml01Yux1hs9e9LysV01LfFUXrf7SWjfDN3dvkkh6TvyymtFQ3zADr5PVF
         BhdeGpCCBj+gymKXdCyjECmbzOt0YBJtRJP01YdaQq3IcXFTR42K5iXRDpClNzg97ON5
         zSsI1guFPOEScDvo9I17n+YdtApe362YVL5YJHnc3AkaLTcpfcgxU5VmiZgejbXsb18X
         r/kAAcn9GFa23uTHl/z0cuBMLEtCAnJQIXpRDv3Rd+fE+eqzQIA0fXrCjqCVJBgqKoSD
         3pcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721892408; x=1722497208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3q5HcmtrWAnPNTpXMegj65YWsUrKJvUrcP825ZJd0RU=;
        b=SvBcOvnaoa9da8dMkUOBGaWXUwNMyzjeDas5OZVA/N5WQNvT++ZPZoC7Uu9/qMF4zo
         8LLEM0jLPYqiks1SwsYdOSuAR615R5NpQFUO7vlQRCQQD0QtNhbwWkBUBYnl54KAoMnw
         nsSYDI/fX58KgQ1Zh+yQnbA1us8dm6XCEdJ/YvZgsxTygSoaS2xThGQfsXKdsJQEDbiT
         J0dTjUjwaHXcnSmPUpXtodD8fefe4yLEk5pIbynOxW7Q8IVH1G7lDnQug6c6d8mZjpto
         jskVF5laMPiij+ZQr2vxZAMaQ3gynpLGTw7Q8tnWUNVr5E4KZCOg76kyqah0J8YYHn0K
         KyAw==
X-Forwarded-Encrypted: i=1; AJvYcCVc5k0cnRi/7ZIlw+BsjV+W57gmJX1zPoeHALLlcYqAs8Izg10zJst8OW469owHckq9RhZQrQ5FE1+d0BTBkI34pQDL6wP9CME=
X-Gm-Message-State: AOJu0YxKvmS4HcpXgG5Au7jJo1+1DJFxWtm7pmITitJPgSqEeN9+7l5c
	GPE/rdkZ3NCq3EdgyXY9Up5rU5w8JPNU899B3r6CJtFYv/EM1v4EVKgpj6ACD9U=
X-Google-Smtp-Source: AGHT+IFf8IuRqTdvt+rSkeNwKKCpAbrFn5dG1AnuJJx6iUv0Giio0LguW6Fgk1lAv6cI7r6gAcfloQ==
X-Received: by 2002:a05:6a21:2d08:b0:1c2:8dcf:1b8f with SMTP id adf61e73a8af0-1c47b16661emr1239292637.7.1721892408486;
        Thu, 25 Jul 2024 00:26:48 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7cc4912sm7592335ad.69.2024.07.25.00.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 00:26:47 -0700 (PDT)
Date: Thu, 25 Jul 2024 12:56:45 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] OPP: Drop redundant _opp_attach|detach_genpd()
Message-ID: <20240725072645.chmy2wp7khdymm6j@vireshk-i7>
References: <20240723144610.564273-1-ulf.hansson@linaro.org>
 <20240723144610.564273-5-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723144610.564273-5-ulf.hansson@linaro.org>

On 23-07-24, 16:46, Ulf Hansson wrote:
> There no longer any users of _opp_attach|detach_genpd(), hence let's drop
> it along with the corresponding exported functions.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/opp/core.c     | 96 +-----------------------------------------
>  drivers/opp/opp.h      |  3 +-
>  include/linux/pm_opp.h | 38 +----------------
>  3 files changed, 3 insertions(+), 134 deletions(-)

Nice !

-- 
viresh

