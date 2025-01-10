Return-Path: <linux-pm+bounces-20178-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F1CA08619
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 04:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04276169FFE
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 03:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F3A204F8D;
	Fri, 10 Jan 2025 03:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="luJQGfA/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C6A502B1
	for <linux-pm@vger.kernel.org>; Fri, 10 Jan 2025 03:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736481390; cv=none; b=FcbkFDWBv/antWzkRMcBpMe+QbXNzqVuNUD9vZdJPlTmdKOBWNJVRl/teZ6Fra6k5zsnw2+Ips5jtJVK8mjTdulDvXodUM2fSgewjrMuw6gLADTnMzFeiAxnvxEstgZ9S/pxRXFgoap57t6/IuqEpKyuQOWR7QJM0V2fM2tw/F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736481390; c=relaxed/simple;
	bh=egLtB4HLGdZ8+oco+9+ID2uoTuwSzhJS4XgyxGLRmGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJ8cLBJP2G4F8kJt/0Ajn4QE1fQknvdYbpUhmeS0B9Sr+lzyhMdRvHrjhFUplQjrY9IiCQAsqzb35CbaPg1yI21O6s2juoNY5ediUbnyPKWFVwZ0jIMw4nc0OWPBpVjXpFdT5vspK7IJ3B6WZysN3TagoNoiOIsT+f1cFs0tM7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=luJQGfA/; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21a1e6fd923so35447035ad.1
        for <linux-pm@vger.kernel.org>; Thu, 09 Jan 2025 19:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736481387; x=1737086187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RR70wLeoCQ1eXpWC969kci7NhDWn4+pUF9Yw82krK6o=;
        b=luJQGfA/k3RHOnQYwccyd3Ef3KJEjrclq/0uT/yxYaZHL942PfD8W8Ja9MhCNQ6oJO
         R3GbCrLxNDoV9zhcE98jdTjlNFQiT28HRQSw9x/SPI6POPRyan6h5pOD/uBhpYX3AJOj
         9kQSYlobogqkRzkzELtb0yrB18Nw49deG9np2fvf1aDbS4Vt6ia3BbpoAsVlSzZAQF7A
         TlnWF28GL8eWJbWqr4RJTzztbR95tG2WXsExUhlimnGjHMt+qSz+37vvwbOxdbo873fs
         qkNpu8rZ+5cP13fcGAv9FTWDlbJd4Wu9BrggWFUNor2mDfGVMUPtjoL3h/YD3ENG5JEw
         Hylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736481387; x=1737086187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RR70wLeoCQ1eXpWC969kci7NhDWn4+pUF9Yw82krK6o=;
        b=Wh0e+VR022hR0uGnM09tYwrbsMczCCo+1kRD8F4N74BZJxRjCjTezDGFl43r6zJlyq
         vId4UPqs0/iw+BT5KsOLFJCRZCBsJ1d0YiuV1Be0MPxYb7MkFfH40EIItkRB5Bq3zMQ/
         OEmYZjpa5qHjNG0EOEbpN8LtLb3ietjKRFpIug6OfqZYFcexK487e1fviMw2BsNHgf44
         zbxSrwKPpH2vRl/WAlDbaW6RVn5LkFyEd7h64tYO5h+MMRNNB0fn7t4fv/HDUiQeTfHl
         fPkVLBybITiYtlzMXMXtpN4S/xugJl2IzTgB53LhG/XtU/5m5mD0Tjh0HAnwvnR5KhZM
         RVHA==
X-Forwarded-Encrypted: i=1; AJvYcCWSmoq9qRYKtc7WV2oMad7F0BkLHFmC5/D2GmSMoa3AAYUYPpELR6oABtdKbxp+pqrCe1TAoo/+lg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0/wAwxpeuIzkW4pMj1nfpP+bKYatLmYstw7h9J2rJ7SPjQJ8P
	RUuZdJTb+s7hUIDW2OWkwmx4xNtDoizDsQKu+YzvxBprhA+j8TsDVCzH31B/f6U=
X-Gm-Gg: ASbGncspTd02MmoJ4AKfR39vHUQqVh08yLRm3BcgA2JwLO18tMnxbDI5JUnFLW4XNIV
	75/33fQLz9mnDhohMb7i1lWPtMNXVTbDKLSqUVsPXUpdAW+3a8/aqXEyIyBB1ZeKvWxU0TAv8xL
	t//d1FVi0kh8Ga6cNQlae3F9u+1W+A8TiecXueXSPmn5/rR/yp4djItmq1LFSALs3B3KSd7owJP
	5a62yWdZRfsuYkepBgbu1TL+NAKIN70SvCj5XcEKbPEXfz7Ax3JRsSuS+c=
X-Google-Smtp-Source: AGHT+IEunIAD9f4eEA0vglmkpTO9Q4e7DF1K+CQ6YgG884ITThUtecdS0LjbKH//YuZcwL4Fb/98ug==
X-Received: by 2002:a05:6a00:1ca1:b0:72a:8b8f:a0f1 with SMTP id d2e1a72fcca58-72d21fd29eemr14066244b3a.20.1736481387167;
        Thu, 09 Jan 2025 19:56:27 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40549408sm603419b3a.23.2025.01.09.19.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 19:56:26 -0800 (PST)
Date: Fri, 10 Jan 2025 09:26:24 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Cody Eksal <masterr3c0rd@epochal.quest>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Yangtao Li <tiny.windzz@gmail.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
	Vinod Koul <vkoul@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
	Parthiban <parthiban@linumiz.com>,
	Andre Przywara <andre.przywara@arm.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 12/13] cpufreq: sun50i: add a100 cpufreq support
Message-ID: <20250110035624.wm52tnag3lneuwtz@vireshk-i7>
References: <20241031070232.1793078-1-masterr3c0rd@epochal.quest>
 <20241031070232.1793078-13-masterr3c0rd@epochal.quest>
 <20241111041311.hleaz5fgipsyxigm@vireshk-i7>
 <CAGb2v646NHFAni=P+iC8OZsWMpg0PJc=kYbuWaY=C0-W-q6qAw@mail.gmail.com>
 <20241111055504.2f3szrd5ahudvtqm@vireshk-i7>
 <CAL_JsqJJ5A+nYKg1aU5zqGZsmtNJxpS3Gw04pSH-3xOkQ9Vzew@mail.gmail.com>
 <20250109225312.GA434678-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109225312.GA434678-robh@kernel.org>

On 09-01-25, 16:53, Rob Herring wrote:
> > You missed the binding patch, so
> > "allwinner,sun50i-a100-operating-points" is undocumented. Can you pick
> > that up please.
> 
> Still not applied, so I applied it.

Somehow missed your previous email. Sorry about that.

-- 
viresh

