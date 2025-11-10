Return-Path: <linux-pm+bounces-37716-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F10C461F4
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 12:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70B3E3B8F29
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 11:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6DC308F0B;
	Mon, 10 Nov 2025 11:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AYl3H+E6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE253074B1
	for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 11:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762772850; cv=none; b=TK5Bh6pR2HkCDSsNSO2LwtfGwrL8FLUtQ3U9TRCoAnEiruuw7i5XlPI9PWN3MeNwDNflJ/ZTLUZnawRJ7KIPTZgzlZ1dVK4395egSKqUtKNhXLi5xKE/e13EpX3ddM2yhp4K3Di3Wfezez3V1bVanM28PSYCvwXQnTrJKz3Xsyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762772850; c=relaxed/simple;
	bh=P9gC+lGzjtMArrtoyqNulbP4U/Rr/r9sqlbgUdghZh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNY132f8JBz/rmApLYBSPydGMz7jupM1/L4RHhKmh8qXmYy/1+nlTxw/UFaWsA5pSge3mxyEbF3jpCelxLYDk0wNMxY2JRSV+6lKq9mEXfEJllHsNFpaAB57AxYgm9VdclUYN246Sd+gli8+qU1SGloLPEE2+glsa1HsyUOehfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AYl3H+E6; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso2449859b3a.2
        for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 03:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762772848; x=1763377648; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l1rfVf8CR6nXwtwA2s4abFfmksXss6f4ONY3gj9LEKk=;
        b=AYl3H+E6yMrrrrIq0CYTN5ssxJXa2EHFHx+ESaNyCZaBPjsB5yBPVFN07QC3IfzdZv
         fc/RFcb0W0kPOxXNr6K5+PF1zTjSKLkWduJKAEoZbbzN8eyDl5LZenrQzhU1BXYrv2r3
         gu/00GVcSMvK5lyVdh1b9K/GsBNFyLrpGLMl8KjaiaJr0Odninhk5h0U9CfHW4Srn6MJ
         luLr6bJBgYPzMCCmO3TNhzq2QD3H6OpURz2oWLGwIKRSeLl6dUKBG/nxfrQz3w1eIma0
         zRxeyvfdSqu1Ab1dPi3Dqln5EiAW4BEOPZvjJd566QxOQSDsUC4XmTTqsZJoO2EFGnJb
         IgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762772848; x=1763377648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l1rfVf8CR6nXwtwA2s4abFfmksXss6f4ONY3gj9LEKk=;
        b=wXhiqwEyS41FBLxgJF7aO8cmLNnm/eMr8+oa7QOeXkvoIQkWwlR9yVIvUupS7zruph
         bcvbTRzOPz3nY1ptp5w7ONH9RK7a7NJPLKkSGoK3Ss4aLs2D67Oo1Sx9ZzZmoQ8FrxzN
         fxEGDPwiVsFNj2rP9UwTwViYcjmgwzYbpy//7+RCesR12VU/gqZfOMfvIwMDYB5PkclA
         wWLK99s80m1D81rVQu7JdDEvnlWgupy9V3nciBz8TskS1P6UNyFcrh8CL+funwhvZy71
         J2qSV4s0WRMepdCQWhfGz+VYD9FPT+wZ2KtMay21wlvrvKzoNA7eX7JyBb/pobcvyavM
         6fPw==
X-Forwarded-Encrypted: i=1; AJvYcCWafZ6iOReGf2GWXuZD4TN61TwzUq9yVoB8CS2moo3InzSvZ22+41g4sxaE04ln1XSgfrz+JC5I0A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzsASeIuZGOOFT+vwEPX05tq3osIdSqhrSXRmRFj78HBTYgsU1K
	Vizg27Qcy6P6BA45FouqB1Cqf7WWmoRRlZGRgKZ/hX5XB7L0ykLX2uAF+khgbE9hpzs=
X-Gm-Gg: ASbGncs2Y0IqXYokZarGEGtyrmRIogTBT9pI6iVlruf7s5NihxXdp/FgFhWvlMJRlW1
	ryY9LiwpSiiPZtiPc/UMD0ZTUbykSWu5ek1yzcZDkFO3/irPIlb9xsHjp4iI9kAaEDAdHYJh8p3
	lkNZZggQSMq/1Wl4bdza+MZVTkSKpjrH3ZLCgM+L8lIwxmrO2Mh1oXNbdd8Kt2bMRigQ9gfOojD
	nEqA/1p07gw2talnOkymHAQmOXCxuxQQ/IPx8f93Yksjv54rfHPzVBbshrnTXDzMLnHqI3MOk/p
	bF5m5MKul/u2KVJhv93WaIeuaACUhkTlXZeelLaoW7uBBRlL8k+g2eSYKxtrRSZ38aTmHp8bVcS
	h5nfYrqAtsbq/y/WO8Gdkas5rEdkhSUiLL+dL2PY23VQ0lRqM5eMvf6Pn2OVCmBIDeUixlnb+5x
	Ca
X-Google-Smtp-Source: AGHT+IFLmvoREqyCOsxdVYWioPfB8QTyekqamyvK/6SevugbTh8+Sr7Hzt8HMarNXUtUBmALUpoibA==
X-Received: by 2002:a17:903:46c5:b0:295:fbc7:d282 with SMTP id d9443c01a7336-297e566886emr96785235ad.27.1762772847847;
        Mon, 10 Nov 2025 03:07:27 -0800 (PST)
Received: from localhost ([122.172.86.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c8ef47sm143941675ad.74.2025.11.10.03.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 03:07:27 -0800 (PST)
Date: Mon, 10 Nov 2025 16:37:25 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Yangtao Li <tiny.windzz@gmail.com>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Maximilian Luz <luzmaximilian@gmail.com>, 
	Hans de Goede <hansg@kernel.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 03/13] cpufreq: mediatek: Simplify with
 of_machine_get_match_data()
Message-ID: <elghyjazfcsbwh4tmyfgfrbstfgpijgmlfu5kytbg7yvjtx2rf@v3riwtqr4itv>
References: <20251106-b4-of-match-matchine-data-v1-0-d780ea1780c2@linaro.org>
 <20251106-b4-of-match-matchine-data-v1-3-d780ea1780c2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106-b4-of-match-matchine-data-v1-3-d780ea1780c2@linaro.org>

On 06-11-25, 20:07, Krzysztof Kozlowski wrote:
> Replace open-coded getting root OF node, matching against it and getting
> the match data with new of_machine_get_match_data() helper.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

