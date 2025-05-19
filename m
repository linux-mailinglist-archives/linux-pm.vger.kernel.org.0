Return-Path: <linux-pm+bounces-27323-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E316ABB71F
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 10:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A54CB18990C4
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 08:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BE526982F;
	Mon, 19 May 2025 08:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eakknYTZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6BB1F874C;
	Mon, 19 May 2025 08:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747643129; cv=none; b=sFqQVdqQvZ8VmiEaObeFbKZmlLu5PCxWVMYyH6rik5ZsBiR8Sv4BtzscaNPzMDxRfA6iEz3hlFnsSYZCOJO7mjrHcaWRydqFzlNAHuTfm4Dxz3RgOzMHYSsa2+fZspeTHWoYvt/Y8qbrJC5jMH1I8Dfc7AP7Zufn65K5CAUblAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747643129; c=relaxed/simple;
	bh=eMOjK4ny5tlsIE1Kv6uWa7nnzXuh9RGNZUWDU0nj4k0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u8Ji5LDKQFKFiRuXYst9akfkzw/cOuQ9ZzMvt6NEy/fce6idbOuimlZR0eTlWPHH9yG0hS/qC0UAvW1JFYVO4RBgBX4uWlXNI0FXS94bdlIk6m+0UEShLFQOgRN24EU/qHSrriytZsLXS/kPxlpbGrFrCL9Z6jJwV+YLZy3WJYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eakknYTZ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22e16234307so38362115ad.0;
        Mon, 19 May 2025 01:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747643127; x=1748247927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EB8Oc00xqk49eqIaVgN6SCH9WvXJ93D+KXaomxhB/Tw=;
        b=eakknYTZbt9qDky9IXXtQkeG5BHgQ//ZkJQ3lp7qfFH6IUYZ7dVfrZneyEZZUdr+XJ
         ZmumOGNNW3pC8S1A7jIkPa1ozuBTDcG3x86SmVdJ5wxAZvpxPQ60hL3nj8D8+MRGqUFp
         7/feHFNij3B//41g9EBdZf7rNkyvNyqeusd4za5EFuY5EA16Lp8paDDzUN8jr459xWk7
         87Jg6FYy2IkvgCVqqBJtikzk1JhSbn89zx9u2Nde1DAsD5QldTZ3j4YyZGnlypK/SKKg
         zJ8RrX3VIQjYjbh/KNu4SKcfUuYm6bmrVQf2FuZ/5p5nxIBrSX3wfpBVRCMDIGxEAFqY
         9nPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747643127; x=1748247927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EB8Oc00xqk49eqIaVgN6SCH9WvXJ93D+KXaomxhB/Tw=;
        b=XDI+nsrn6F0hIbAmZFAeFoljtHPWA4/MSzjDgqjJAq+RPQMI6qrAZd48wjp6o2P7AC
         +p/mq02yReYhgpHmkiCiUBCWX4Ii5gZOEpcc/8dcSo9mZbmnf5omnpssYNC9ssaIgH5c
         qZKOKludmMml8UlERV3k2xSHsStE0tRafdVX1xaAbKBve272EGRa5STrvR7XlGNO3Pek
         lghppxliWC/Z9W7OtRSIcQ2ei1vU83RDd1LD/FANOUy2z1oFdm7nCTiOf4kxfAkqWwsb
         0x3kTunabUP95yDkZH29lo2FSxGhjAZOgiaXjv904AJDSzebo25i/+3TZrkfPsJjZ8gZ
         FT4A==
X-Forwarded-Encrypted: i=1; AJvYcCUYbb1fcg0ceLY1T729SKaIDFMnMqtrpIDZFCxzHiQvqZb/Iwd876xGj4Hxkr3DGHe9HKQB+EvMu2A=@vger.kernel.org, AJvYcCV1FVtUI3HwojKwtQ7Mr4ioDBO3iHDQqB/LIBFsDC3jRnvS0bXYLvutyGpVICChzduPuu15QXEVZraFXKI2@vger.kernel.org, AJvYcCVFrPgQbp6Q9J4wEokMni47+WXHgUJ/6rLlJ1nS2vtGXUOrlmspFH9OEGyGKXn6RA01RGzyOvM1HWlHVTVQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzipIKXTd0tMWeSs13mfEEerfnG42x2elsOqUU2a5w8Xu0mLiuO
	+4+omqCZgBlpojpwEPbTrxNsyCa4XlbgiHRpqYKdXOW8UINuAQtF9ZvA
X-Gm-Gg: ASbGnctP+sGoFGhspbRWukxypaUI+Lxf1Ji5FGkhEZU4gHb9pC6wMSLFGR6UCodTJ6i
	CNA2gpv3Ks+nxd6A7QiZOJNSb307g2nh1DymnuenXzfSy8lDdLo17+zCHab9m3rLJ5eC2q5w8gg
	JPrWo5d/Z5dB4DF4MBX3GHqqLn2nZuCP4Y/S9SNv1MqPQNfop/E8a7QBzpIryfCdISVogoHHn3g
	u2ZveZB5ywby0Ja8VGGHh0Cn0+/UVtpz3O2pLuSLFvXkavpIGWr+jHyfPcA5Wov+G/8/U6+d9+2
	6nbuABNdS9SR6bFHwaTvqYBunNVD+XoF3i+F0F7Ehd6ONV6dZQ==
X-Google-Smtp-Source: AGHT+IH0FhaLeua24wAVXTMVkMGORVd6mm/ERqfZ62DUy9u0xQgAfyPXpBUDr58944/ivIlr9YjaJA==
X-Received: by 2002:a17:903:2f05:b0:22e:5406:4f62 with SMTP id d9443c01a7336-231b39d7456mr214023755ad.24.1747643127199;
        Mon, 19 May 2025 01:25:27 -0700 (PDT)
Received: from nuvole.. ([144.202.86.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-232046b3f98sm36107075ad.224.2025.05.19.01.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 01:25:26 -0700 (PDT)
From: Pengyu Luo <mitltlatltl@gmail.com>
To: neil.armstrong@linaro.org
Cc: djakov@kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH] interconnect: qcom: sm8650: enable QoS configuration
Date: Mon, 19 May 2025 16:23:05 +0800
Message-ID: <20250519082305.81258-1-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407-topic-sm8650-upstream-icc-qos-v1-1-93b33f99a455@linaro.org>
References: <20250407-topic-sm8650-upstream-icc-qos-v1-1-93b33f99a455@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 07 Apr 2025 17:16:47 +0200 Neil Armstrong <neil.armstrong@linaro.org> wrote:
> Enable QoS configuration for master ports with predefined values
> for priority and urgency forwarding.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

[...]

> +static const struct regmap_config icc_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.fast_io = true,
> +};

[...]

>  static const struct qcom_icc_desc sm8650_mc_virt = {
> +	.config = &icc_regmap_config,
>  	.nodes = mc_virt_nodes,
>  	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
>  	.bcms = mc_virt_bcms,

Hi, Neil. It seems that the config for clk_virt, mc_virt is not working
on some devices. My device Oneplus Pad 2(pineappleP variant, mtp based,
but without modem) shown the following.

Apr 30 01:56:16 oneplus-caihong kernel: qnoc-sm8650 interconnect-0: error -EINVAL: invalid resource (null)
Apr 30 01:56:16 oneplus-caihong kernel: qnoc-sm8650 interconnect-1: error -EINVAL: invalid resource (null)

Best wishes,
Pengyu

