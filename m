Return-Path: <linux-pm+bounces-37717-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BCEC461FB
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 12:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 940B34E92D1
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 11:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE85309F07;
	Mon, 10 Nov 2025 11:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZOP6MOQ8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B45307ACF
	for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 11:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762772879; cv=none; b=oOx9FNYFUp8cIor6+K8kp9f4Ybpx7FKABQu5xeRQaz7IByKD3UK67tlHM+YRxRRZXaZHHON6v9TzFodW6V4vEoxD20kFl72UirV77BojUi0W2W61/B0OOe3LVtlWBPc4sARm4zK7JvqxuFrkSlOeqkM98557nVdt5Nc5tYsao7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762772879; c=relaxed/simple;
	bh=PV0nu9hpPV+PdL37EjWKyESOoKW7BglfhP4iUdE0IM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FFynPFthD4BDqnjmpp0z8k45uwYYz8sh9YS7dLm+LoD6jaF6ffmsKhyxDVEuvRgjgN7jg7EsYcaKSZTFrd52L8I+vCu8ABuoc7XQfsdqrhlAuunkdH25IKLYY2S6ePCo3TfCHRDPHG1IemVqOgwV1Rp6zIKgTHqMgsTjg43X/98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZOP6MOQ8; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso2257881b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 03:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762772877; x=1763377677; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1teV5v5SqS6pFrvXlRn/4yX/VJMz/VkOekGlZHXTNkk=;
        b=ZOP6MOQ8viMXp+whHMIuW+CMg2hu0pQXkgyYI8k3GLd+x8dAKuwj139adqiERa7q2z
         Kx1XSXD0qcGppkvALKE5yvXAy3yWZM+SWUEfT5pM2cvFMjpwgMgJogSVv5JhK/Utpm6N
         3RCqf9kscgsLLaSAkbf1oAoNGVtnVLkoOBn2PxhmoduepLzAFxwNsf+5Z4as3RJHqnQm
         5CcX/esJPeIG/EDFgix2FsucaBn6sdzTcvwlNlyjVuNJTYrSCdtaC8ARSE72pTFyILXi
         ojlsxRFMznyD2xp9VNm8+3mWde8tfTY+bR/UTg2M3N3y3qLxoeUjJQdgQLrndqUpCnZ1
         AS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762772877; x=1763377677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1teV5v5SqS6pFrvXlRn/4yX/VJMz/VkOekGlZHXTNkk=;
        b=ej153iX9bSbUzrb1I8mVW90EbQeRAxqSpZ0hF41caNDj/0JuIwDxh8SbeySjSh+T1p
         zzVujwLpajiVOfFC2/hjEGRPu9W+woEMYUahHnsSR6amsbWyI+W4y9uQ1Q8gTzO7/7iG
         BLYrRAjL7LjLj/5z1HSicJkzgEFevOMMLnx4EXC/au6h092HN+W+JilMYVCK/LVtKlxA
         nSoLTc5Q3wh5pfrkJYTS7abJFihDAzzPWIjbSTWxdMGho0O/KTfeQU0GbwYhH7zs9heR
         IRcDhPHecYLfON+LWdzmH1qOU318yqO4ecnKb7a+c/FpwfdgLwYQxDgICGvOiD0fFIZL
         3yug==
X-Forwarded-Encrypted: i=1; AJvYcCVgg1eSblh2Sxg1LB2YQxezvDY38HPtPQR9hV1XYWghKc51KjdaWm/j0jSKpxiRB7jugvD/t8eDRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzajhv8bSFRTZ40Tnfb9m4ubsfZW4pevarkSpH5ODrYVv9HbQCf
	7K2WArJtf1juPhUgrxkwq4SavMewoud5s23KE/aO2P54LnKMlk47NzHT5zD30IHHREw=
X-Gm-Gg: ASbGncuH+AhqdnMoGCmohBtmPg5mXQk0zph8uKiAuwTEk5CHeRnFhvlC5GgdRQXuMya
	MNlrGStwbCw27jVxgvh57sSlvORrLiir4W/r5fwa348mo3ROrc5s7c2O8KRhL79CABIwM/mvEVf
	BGJX1rzSOLx38U+BPlrga9Dgj1OcX2yl5WuQLCW4j2BZAyfp0RFPNyLcVQVAMTK7BvqxrDdfOS5
	S7PKhMDbkS3UaCyT1k76P3U6BMNwzooAR7Th0xHazT5fZGNxxmhkBXX/INATx/Df2PjI0xC+fIi
	re5mXf3K2hhuAMSYE7G2Fw0o0OzGTchx3PdP53oCOhoB9sbGEAKWSVtP0XoCtoU7npHzsJGNZCQ
	ufsf4EXJkAFTwIE5o8u5dYOS7AEpsq8epsZhAUsCjZuOTAGmGQoyB68UARYeoOwxLgFuV64hcsN
	HjNHgC+SNdeLY=
X-Google-Smtp-Source: AGHT+IEI5dvtjpf7UreD77ujcsma8Qc91uG0xXgrZUKvQ1Ri3S/fmPHsBQ3EzHdR5mFgTf1mYnto9Q==
X-Received: by 2002:a05:6a00:1990:b0:7aa:2d04:ccf6 with SMTP id d2e1a72fcca58-7b2232f8c80mr9070041b3a.0.1762772877004;
        Mon, 10 Nov 2025 03:07:57 -0800 (PST)
Received: from localhost ([122.172.86.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9c09cd6sm11397368b3a.23.2025.11.10.03.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 03:07:56 -0800 (PST)
Date: Mon, 10 Nov 2025 16:37:54 +0530
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
Subject: Re: [PATCH 04/13] cpufreq: sun50i: Simplify with
 of_machine_device_match()
Message-ID: <awphoxojc3benzdam47mcx7pqty26ohrwpgv46kimg7nl53rqc@szq3aqjqsbrc>
References: <20251106-b4-of-match-matchine-data-v1-0-d780ea1780c2@linaro.org>
 <20251106-b4-of-match-matchine-data-v1-4-d780ea1780c2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106-b4-of-match-matchine-data-v1-4-d780ea1780c2@linaro.org>

On 06-11-25, 20:07, Krzysztof Kozlowski wrote:
> Replace open-coded getting root OF node and matching against it with
> new of_machine_device_match() helper.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

