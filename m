Return-Path: <linux-pm+bounces-33518-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD9CB3D894
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 07:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBD16178851
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 05:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CCF1FFC46;
	Mon,  1 Sep 2025 05:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DV4flMyH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F221E0DD8
	for <linux-pm@vger.kernel.org>; Mon,  1 Sep 2025 05:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756704049; cv=none; b=Q2He3jYVP52hrSfrEcnJm14xMlM/FKMVchrGLJe7yjdVSQFMLbbR8gOKyoyoQV+qS9nU24V4xoKLhDYN2HBSqjIppMvu6pEG6BjleRRm0ILIty9SBBxEp3fNpp8ZW3VDftcIz3U1Cekgn6YO7iU7p6SFy6uk1cNymQCHySBs89Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756704049; c=relaxed/simple;
	bh=tkBChYR4K8prjKACAdbWtOwcTV9LWv5kMgMrfH96fmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8ADwAsLPo9AgO0qkDIorcmINMT0zEEhJDRSS7/G66g6T1ViZOgDUj2zEP1UyWRWFNaOp9cYo5Mv+IrzmxKLhGlpjWwiiileFxZN/+QMpKDYnO7Mi4J0WrGRcrT0+PIc/UrihQQP92H4BqktUkZyQoJEtlngwBDPlP5qF8vFOUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DV4flMyH; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24457f581aeso35529745ad.0
        for <linux-pm@vger.kernel.org>; Sun, 31 Aug 2025 22:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756704047; x=1757308847; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+wf6pebIPuJaWGNGVYougDPoqTbfqQo2QN0zscbx9wE=;
        b=DV4flMyHkH849fkb4BtEGxTEZb+KtEJsb0YvpP+V8Ug9rAi/3V1reVHMh9teG5BZeS
         59r5f9/3cpn5eIefmmaonaRRm2ORPmVjul8d9gTgAvSK7c5RvRT63LH6vgL5B8AI17Xg
         8rkXXVBsVwySJ0U+QC0yo6ZUj2j/qCZJ3sIf0xK1nMpGqWPZ+iXer5JKNvRRuuI8qtA0
         A+LwHm21y30HZeCGJ+mYxpgqJjHDtFpPB1uOI6AUGRz9xzoAMETGWYLj40JpaPNZSUbt
         P0GOC5so3i6r8cnVwfkY7PETI1+jy+2QbfETsHMun/Qhcg6p8EAEglgzUsg3nbBo6btM
         ZUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756704047; x=1757308847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wf6pebIPuJaWGNGVYougDPoqTbfqQo2QN0zscbx9wE=;
        b=q9pOqRzzCcyiVrq+WQGfjDn0zreEeXbIcMDNk2swDP0yXT3/tD3Ib6MPUOkMHY7ymH
         winW5OoewyA8anTIz5ZbCIxGp7gDlS9bb1Yo8JkysyzouUToGxLjaRJ1T6HBYNNyzO27
         h3FYnEnQmXP+pmA8z5S6qkbJyrtiWPfhxSlKuiD8tn8lUHlsXkkarZS0veO37E+ymbxF
         kfHUwhBA6Sv0foOxIbzc/GjWlXX8A86oA8ije08R5yTxSvY4jKaKx/HxVTudoArddFP6
         aYZZprV993e+N50ToNLPrv8y2oWjAIgps3lSu2P/WrtEywwMUxoidiSl3zE/6OrmQhlc
         NL/g==
X-Forwarded-Encrypted: i=1; AJvYcCWVlsFYzeOGZTnjE4ZnOBnq8z5RCJmYXpwaYor7AVPVmhCzCRMbCRRPixbj5Wogr7IO6hAhI29Xug==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh98xAyRyBV24ejnhsStTIe1Xx1/94e7SN9LZswcfGe5rMIbHS
	0GicTFq4OiG9t/SLiI2tbkgtK6CYKJwU5cHmQk/kxM98UaIX29CyWrrF9c7y/aRrSnU=
X-Gm-Gg: ASbGnctqqOM2ixPcNggMUcGOH0+12ueTogQcJgGrpD93zFrg04M500GvgxmWNzhGlBP
	wiBjFapMWDnXeesPRy+qeoWAcy79RQtpf3DkYUdC2c/oVA7IPCQSnD3aJM0u6Jf1VQbjRQFhhOF
	ulrHGCd8OpG/yeEchJ7g3zULqQN+YO/Lp3hltKwLUHvAeXNmxsCMnwLPBMYH/I+obJFiMPzkSSI
	zATn3k/Kp2er9K+G+o2ZLb/I/5OWSkEt8+Fg3eFt9lqfO/KDwp+Eu4CJMMBDvogSp3Ta9f7N+IA
	He+uayYd2JHsIfMuUJTfvFWUXAE2dSAo5dcpsenE/UbHr4WgEcV2tVH4+LTJKTlIrHTpmdle+jq
	fPrc0NnQQwNS6UPadg5LFrGEs
X-Google-Smtp-Source: AGHT+IFiku1vWnikojoaU2D4teEQs5rxhjU+GtOPjQKLGItwIy20kQ8nIhlQ6l3ScSsZBAVpkdATyg==
X-Received: by 2002:a17:902:d2c1:b0:248:d674:2b5 with SMTP id d9443c01a7336-24944a3c860mr81521735ad.18.1756704047474;
        Sun, 31 Aug 2025 22:20:47 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249067df2e9sm90187735ad.152.2025.08.31.22.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 22:20:46 -0700 (PDT)
Date: Mon, 1 Sep 2025 10:50:44 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dennis Beier <nanovim@gmail.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq/longhaul: handle NULL policy in longhaul_exit
Message-ID: <20250901052044.qtjcd5q2ycch2n6c@vireshk-i7>
References: <20250830144431.159893-1-nanovim@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250830144431.159893-1-nanovim@gmail.com>

On 30-08-25, 16:43, Dennis Beier wrote:
> longhaul_exit() was calling cpufreq_cpu_get(0) without checking
> for a NULL policy pointer. On some systems, this could lead to a
> NULL dereference and a kernel warning or panic.
> 
> This patch adds a check using unlikely() and returns early if the
> policy is NULL.
> 
> Bugzilla: #219962
> 
> Signed-off-by: Dennis Beier <nanovim@gmail.com>
> ---
>  drivers/cpufreq/longhaul.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cpufreq/longhaul.c b/drivers/cpufreq/longhaul.c
> index ba0e08c8486a..49e76b44468a 100644
> --- a/drivers/cpufreq/longhaul.c
> +++ b/drivers/cpufreq/longhaul.c
> @@ -953,6 +953,9 @@ static void __exit longhaul_exit(void)
>  	struct cpufreq_policy *policy = cpufreq_cpu_get(0);
>  	int i;
>  
> +	if (unlikely(!policy))
> +		return;
> +
>  	for (i = 0; i < numscales; i++) {
>  		if (mults[i] == maxmult) {
>  			struct cpufreq_freqs freqs;

Applied. Thanks.

-- 
viresh

