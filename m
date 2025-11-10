Return-Path: <linux-pm+bounces-37715-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A98C461E2
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 12:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4117A3A4E75
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 11:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5F8307AFC;
	Mon, 10 Nov 2025 11:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pITaHv7F"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBAB3074B2
	for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 11:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762772837; cv=none; b=R40r7tJWZD4v6pp9EmW3yabwvysnZmc98kRyezNOthJC8cjxU+Q8G89hWav1NX3PuZYZffmspJ63PKsPvrL9z11M2KtAnE47JubbcGT16drkfMihcVJXII2q/To+yq7tDs4CUzWXNBz6uoKqAWWWHO3Acs1RKjlzwXu2yQdS8Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762772837; c=relaxed/simple;
	bh=y9Rc2TSg2Orx+cZa9j2QdmCSgqy1wVj5vvqljCG9AMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2Uifnwfu8w0zpgR+0VNu1PrZjz0uEIU6h9X4MwtXNW9voo+qEdhOARQraARidV18R8DHlBqjfcelUnqcyjR+a+wHnHZP/KwLHNv4NwFL6GEkJDI++m7YyyCRwvEIZ/KATTR8gvKhJ5isW1HBou6pUgfq7h441kBQghIfaZqZcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pITaHv7F; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso2343138b3a.3
        for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 03:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762772834; x=1763377634; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TZrYqw2/O2UZmuuLXYkU5bIjhuFDnuqQ3/E5dCC+u7U=;
        b=pITaHv7FQd7Ixj+gmMcfdIpoCp452jsxe5wrcUQnPkmqLdRptFvnTrXkBLEmj1B3dY
         8T9yTfQcHwQlEDmQgVFb+uYgN8AiJAeC2iB59o3D9AY8ZwfpNMKDvxDxp2L+iYYepaGE
         7G+M4Fq0mSIte22N7kwZJot8nVqApdjdpAdrW+WeZ4TqOvNVJ978ZtDu6PIfo/s2Sbqp
         vOuOTn/MdTjzOK+VLNxHxn5KGFq2MprbrWECDW0RGd9RTHUTbAUm8rCmmaCJC9v3mKJK
         d8BJB9xKbSsLq5nXQEyu3sl6CEJpSZMvKsMe+ej0jRPga47fzdAS8+Vz7WyPiWkCzn2x
         CAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762772834; x=1763377634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TZrYqw2/O2UZmuuLXYkU5bIjhuFDnuqQ3/E5dCC+u7U=;
        b=oOBIUnYYRQNwCHJsaNkjbu/pXf3H6nqJhWNw/hWW7TeHbarM0egVHMGpeMtBkrhbjR
         FvPStzMVrSO3Pkp+AQRmqJYESy9mcwjgENBh/FS0Nfbchvr9rcyzixVvDjuJZQ1TmT2U
         cx3CPW6mQgC4GkiERSZ89FvfjzN/o9jurbJr5+HdPP4yScLUwQBc+1/NaGKt0Id+rwLe
         dwscf5q+CodJA96Cz9xTfcC5N4qMnuCV00e3xjKZoT9bPgl7Sh9l/C0/77GwhTXZBU3r
         2qk7hsrR6RBSbU2nZdVUVY5KiwryX2pTnKkmZ2s+H1Ti1LP2UbtXAPj7MB21KVYS3vPY
         cEEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuv+gcdUt1xnovYne+/g7pspcVl35nQfqcoLYCQW7FnLAbiDL9sghWTu6HU4FWVRvLyYx9iRQsnA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMI2s6npsG9VRmfY14TxyID2f264kAS+QDvWQx9cPFTHG3pKDC
	OWvBS/7COI8a/eDbCbXCe88rPqfTVr0ImMdgfz+/bmjW2ttU2wDfaj9innavlqgegdc=
X-Gm-Gg: ASbGncsQHJxn/uRr+axdM5k5rEvl1xgZO3/uURHJlKCQPX1PUA9iYyZu50Tj4IbgRXA
	8iwOAWAzaKnUkRlbmBTZzzp1NEJnYQ8mtJbF95X8oBNG6AVPM7AlaSe9Ip/LH2ZtRFzDoGANiYw
	QYH3t6Am0yL/9vnOJvaAOjOANtC7myUvOY53TQXZe/wcx//vaAo3L+kXMFSsWt9gPAYbEg2adYY
	R/nv1cptipRuPMAA3jgEdL8Vu6fdiSADNNEHSAkJ4rxc9e0NlofGQghZCS/65LVUL+rZfpjTYhj
	V0tkV8ci85oJLF294ZSFo1um6nFo8xxtuKeb/0s1HfzND/0fveOUlO0soTuK2ejM3SDGT2Rn+NW
	NFovrFp8A1IQYNFXFr+SfPMlW5umAz77vbZuIAqmO9Oo2ErLFJS5o4QpMiq7unhbQpJBlBAnyYR
	FL+hMmuxDuGZw=
X-Google-Smtp-Source: AGHT+IEEBmMVZO0k0MIdHGG3oOt1wzE07GZr0Rosgte3T2/mK8NYjyyq/dXAAAQzolcEZu8MEC+rkQ==
X-Received: by 2002:a05:6a20:12c1:b0:350:d523:80a4 with SMTP id adf61e73a8af0-353a314ff11mr11044525637.28.1762772834004;
        Mon, 10 Nov 2025 03:07:14 -0800 (PST)
Received: from localhost ([122.172.86.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c953cf79sm11625705b3a.3.2025.11.10.03.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 03:07:13 -0800 (PST)
Date: Mon, 10 Nov 2025 16:37:11 +0530
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
Subject: Re: [PATCH 02/13] cpufreq: dt-platdev: Simplify with
 of_machine_get_match_data()
Message-ID: <qg6xxh3vwbfnl3z6otlr2bue2paig7w3agbpbauuzmppiof3q5@e4xjlcfu43cw>
References: <20251106-b4-of-match-matchine-data-v1-0-d780ea1780c2@linaro.org>
 <20251106-b4-of-match-matchine-data-v1-2-d780ea1780c2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106-b4-of-match-matchine-data-v1-2-d780ea1780c2@linaro.org>

On 06-11-25, 20:07, Krzysztof Kozlowski wrote:
> Replace open-coded getting root OF node, matching against it and getting
> the match data with two new helpers: of_machine_get_match_data() and
> of_machine_device_match().
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

