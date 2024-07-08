Return-Path: <linux-pm+bounces-10745-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D65929C84
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 08:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E724D281141
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 06:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC9D1BDDB;
	Mon,  8 Jul 2024 06:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RFFiqZsa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E8517545
	for <linux-pm@vger.kernel.org>; Mon,  8 Jul 2024 06:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720421549; cv=none; b=VYEMjyh5BbLXtdPTEHmJRSqOLybWQ9w64w8k8xf9fu8Za1FIod7gVgzhw2ZKgvPx2XRuyCBaNg+6Dzk4hJBH5emtmwGsPfc3nIOci2jJhrGXxTCzD0qircIPRSdKptMPxJqqU1EbyXAeuGTgh6ROl7iy0o05JsJOtrOHF7xYL7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720421549; c=relaxed/simple;
	bh=l2FIO3fCqBGmXOF5K6tW+a19O8tFfegMu7Ea4neklnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHjyn41g6t3Alh4e9FKyIWqbmHrGtf6a8F3+zircLF0z+MZ8oA/5My1we0R1/kv7rn5OSCXihEQlkDkx1LtPiKo7ZpdazPPvIQ+er6RI3tOmLHkO3ANkdoyCZA3OiLRgtDMPsFP0bVNSNMCMBdGEBzsv/mCbM/+jViGExEZ1RmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RFFiqZsa; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-383e7a29808so15087775ab.3
        for <linux-pm@vger.kernel.org>; Sun, 07 Jul 2024 23:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720421545; x=1721026345; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+DS07n3S2EpZ5vKJ03RyX8V+ApT3KBt/z3ClQ42xfto=;
        b=RFFiqZsa93lgN4L2ybRuE1iIgzzWKmQx6Plink61hltm+xQrYzzYF5z8S+vK4ibqSF
         CbF+FK9DxfndMwJgGwsaLyNipXDmGpimihM1OyTQoMHL2TbCvr3n86MR+vsg0z5wh17T
         k+ifdEckHPTaWtWIRHxa6khT5bMdL+vi4OHIgSiCcGNYHeNvei3atuttii8JDA81ksut
         OE8RibZrAhCpEM2bsyvSOPGUpfeNsMC8fzMoR9la36cOQt1QFq5rrcUth6TT3ZDUOtn3
         BsEmlTkSitrp0GZYVx0CJk9PuGMC6cKtsqz04o5ymD4M+yXTalbhxFLoEsAfP8JgdGpi
         EQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720421545; x=1721026345;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+DS07n3S2EpZ5vKJ03RyX8V+ApT3KBt/z3ClQ42xfto=;
        b=Tj+7Zd9sqsy9dTD4q43qRUOwiiZQde7WWrjPgQpUE/c8h/j/hmW10lFNsKz7D2b7KR
         /DpU8C90/gjd1DS23AJM+yuItP+CJfYJE5CrMiJQaZUP+0hWKGFtHtkUh1fkWH1p6nLr
         uQ1sM1bjoYAnn3Ox4A1GF5jhkZSHPuEnMF4Y98qBIaplJVJy+kb3elq18OPqOPexUWkp
         ixLlrQiafqB923m6a0fgQybxgAVO5nGxcNQWa+E8r7DzRSzfPgY69ZG+b22gbGGpV9co
         O4R6OlaVCJs6dJOnvjZMF6FcvJmi5HYHGkBkT8p7Aolko9hN1TCD4PzxydXjudlWnyvk
         naJw==
X-Forwarded-Encrypted: i=1; AJvYcCVaPPJ6m42CcDFPDfaFFjWnXGiffmukhHVS0zPNprZyNU/KVv2JC3YB3eXWC2QhUsobmbiYj4rrZD3FhJk1fDXUNt6MwUQzick=
X-Gm-Message-State: AOJu0YyWYs7qVJlhwyjE++0TWPoFYUcOXrf3xDhUP0ICW65gHpooBiGk
	rntYQ/rwEGvQkJ49MgLl5V4Kx9K4K8oiruTwXiOWoj3vvcXdbnay06bNSy44vnk=
X-Google-Smtp-Source: AGHT+IFBya5V2xQbhJizaPr/Q8T7hEPEzcZGX3jK6EfAM0X5nJdKs0HW0u+/neZnaqmpTki+tnx14w==
X-Received: by 2002:a05:6e02:1d86:b0:376:4049:69d2 with SMTP id e9e14a558f8ab-38398710582mr172377945ab.6.1720421545272;
        Sun, 07 Jul 2024 23:52:25 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b2248b69esm3094293b3a.144.2024.07.07.23.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jul 2024 23:52:24 -0700 (PDT)
Date: Mon, 8 Jul 2024 12:22:22 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	kernel@collabora.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] cpufreq: mediatek: Use dev_err_probe in every error
 path in probe
Message-ID: <20240708065222.iip3hzlffn2dthjg@vireshk-i7>
References: <20240705-mtk-cpufreq-dvfs-fail-init-err-v2-1-3a7f91b02ab0@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240705-mtk-cpufreq-dvfs-fail-init-err-v2-1-3a7f91b02ab0@collabora.com>

On 05-07-24, 11:54, Nícolas F. R. A. Prado wrote:
> Use the dev_err_probe() helper to log the errors on every error path in
> the probe function and its sub-functions. This includes
> * adding error messages where there was none
> * converting over dev_err/dev_warn
> * removing the top-level error message after mtk_cpu_dvfs_info_init() is
>   called, since every error path inside that function already logs the
>   error reason. This gets rid of the misleading error message when probe
>   is deferred:
> 
>     mtk-cpufreq mtk-cpufreq: failed to initialize dvfs info for cpu0
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
> Changes in v2:
> - Fixed one occurrence of the error code being set after the usage
> - For the paths that need to set the `ret` variable to the error code,
>   changed them so they set it from dev_err_probe()'s return, in a single
>   line.
> - Link to v1: https://lore.kernel.org/r/20240628-mtk-cpufreq-dvfs-fail-init-err-v1-1-19c55db23011@collabora.com
> ---
>  drivers/cpufreq/mediatek-cpufreq.c | 72 ++++++++++++++++++--------------------
>  1 file changed, 34 insertions(+), 38 deletions(-)

Applied. Thanks.

-- 
viresh

