Return-Path: <linux-pm+bounces-33601-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB59B3F4B1
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 07:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5116E4E1F54
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 05:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D098D2E1742;
	Tue,  2 Sep 2025 05:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MXjDWCpC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9182DF15F
	for <linux-pm@vger.kernel.org>; Tue,  2 Sep 2025 05:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756791732; cv=none; b=HaPdsCtwDccxhBdYdVWIRDTnH4WhfXa7ni7QAq5zX82umISSGbgRV6sbJzRQJH6ERIdQF4FpKnua+wJMx4oOlrgqIB5WNALG2fQfJeZFKx2pxRobwmj0mVxDOFzHj35GpL84eTgiQ4/guGgKtc3852z6DaFPsX4G9khAnihI0Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756791732; c=relaxed/simple;
	bh=pZaGKPAZ4D4liWfovQ4DFxzR16FVRL9jBWQ0qKv61nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VoQGBLvo3m5R0WtUWJ1bDcLTJryZO+VnEjJKGFr0mHlQpDJT7MT5TMsTIZL/O0AuZbEy2xJQ+PGrhyvUPGKQGcpmgHpcrfs37LBUuMFGIO88Y7LL4S+HhJt81Vw3AiJbfYhzhOSng/u9CWNWOJj4uatwDLeXoY9z0nKbPgAmrUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MXjDWCpC; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-772679eb358so782331b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 01 Sep 2025 22:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756791730; x=1757396530; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=29jR3k9rMqRnPavHCfPYA2GU7BTpIOhCsdj5RSaJa9w=;
        b=MXjDWCpC3WOkjlOA6o+/CxydSLjRl/ViNkZwObKZY+dTrukdZ0TM9s89BXJ46p+OqK
         3VzgDUgJQfMoz4SaT9CUZIShj/1NYtb40q4U2RjuPlbrjySd8jmXiUROwqPfIwspAK1U
         KTuZmBA28bhanPywyg51uIN2/3129yivPN9SFiGU5CiyB1xTedF7HQsiZH9wdZngrmLg
         w3IiJvEony4C2HblDyl/GrDk1MwgZjgIldp72IrjBgb2UOTLmsv6YMPm31aMBnwptlWr
         rCcVoeENFhuzMPLiIOCuXluTvfIN3VXrPYe2y2PsOeSpwGThIcVBX/JDHCdut9Lq9s9q
         0hqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756791730; x=1757396530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29jR3k9rMqRnPavHCfPYA2GU7BTpIOhCsdj5RSaJa9w=;
        b=vbIpGhA2E7eKsz4ZvH/MIA9D8kIu8Qlf5R3egZRi4WwV7k5drJPhJZ6beVDPlj13TI
         HS7cArJoZMlaHPvd8qPGEWuxv1lXvFKULRD+kWaYc0HMo7h18h37Q448ZWggqWrfZUew
         G9jOf9mQJJrOduBnLmYB0nd/RcApsKDILj1ZX7dqwOgndMm1q1T7wHe4bvMdoFJUZg58
         tQ7xO7IaTZEvBaWq5bLm9Q58o8FgufdclkthOlTeXSENgxG7WpepV4RUt1I37eNfWcDN
         7e762TIo/y8vN1Gmf0kQp2Mz89D1UBLDe7MmiSjXRhc1LK9oIqWr4EROry/343zJ7OgU
         bG1w==
X-Forwarded-Encrypted: i=1; AJvYcCXoIPyfjWaF3Np6gWU3/d3QMCILphiZZ8FpGNJVaDHe7E5q/eEtViRh2RPkKSCpHn//NT16Kl1SVw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIqod2dpkB7lVskOXIHsJoKMqnHciCzzFdlZDolMIzfEoOJotN
	xl2Yej7+Ntgq+uzheZ0m0oRQkgp1yHitBwmq8r9d6/+TqoK7OomO7eQEM/we18DtTsw=
X-Gm-Gg: ASbGncuy2U6YpbTCZe5jAKvDlpD2IfL2T7YvPmbdQ2BN6FoV0KnmTWYlLVR8p6078G1
	nVe6RwNydhUI7dnFTFQD2uKq1maMWWua9eFYP0g9E0UfpORs4y41icr0hMlvDFRs1H6JtNiDjIC
	ueQJWHhXQ5B90XURmvSiXuAf9mQSGa9VKcxKW1DOGBJRrf2onMv1v54xhOHjz0He6Y2zx+nkmfD
	zRn2S3TiZqxiww2Z7vkTSlZBKdOR/8huAKZZJP2iDP4res+N3WomnqQsNB1wLam/HtRM+xVthWs
	+DJXOuNT46gDEY3+q0h6v8P1rR12fx2xklPjaYLxxYEX7mqI5NTl1+WtBQkwP5N+PIEi7tWaPl7
	oIVeIQokv/b/21lKdIuB9KZOK8ZmC23abuyc=
X-Google-Smtp-Source: AGHT+IHgtpeK6x+sOCjFIsM2TVd58y3MaGgb8bWKzH0H2wvyTxXZOIDRA7XC34qnep/kILfY/MTD2g==
X-Received: by 2002:a05:6a20:a105:b0:243:a02b:ca64 with SMTP id adf61e73a8af0-243d6e5d1a8mr14547776637.26.1756791730571;
        Mon, 01 Sep 2025 22:42:10 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd309439dsm11045404a12.43.2025.09.01.22.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 22:42:09 -0700 (PDT)
Date: Tue, 2 Sep 2025 11:12:07 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J . wysocki" <rafael@kernel.org>,
	zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] cpufreq: drop redundant freq_table argument in
 helpers
Message-ID: <20250902054207.zke5xg3su2vpdob3@vireshk-i7>
References: <20250901112551.35534-1-zhangzihuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901112551.35534-1-zhangzihuan@kylinos.cn>

On 01-09-25, 19:25, Zihuan Zhang wrote:
> This patchset updates the cpufreq core and drivers to fully adopt
> the new policy->freq_table approach introduced in commit
> e0b3165ba521 ("cpufreq: add 'freq_table' in struct cpufreq_policy").
> 
> Motivation:
> - The frequency table is per-policy, not per-CPU, so redundant
>   freq_table arguments in core helpers and drivers are no longer needed.
> - Removing the extra argument reduces confusion and potential mistakes.
> 
> Patch details:
> 
> 1. cpufreq: core: drop redundant freq_table argument in helpers
>    - Remove freq_table parameters in core helper functions.
>    - All helper functions now use policy directly.
> 
> 2. cpufreq: drivers: remove redundant freq_table argument
>    - Update cpufreq drivers to match the new core API.
>    - Calls that previously passed a separate freq_table argument
>    - No behavior changes, only API consistency.
> 
> Zihuan Zhang (3):
>   cpufreq: Drop redundant freq_table parameter
>   cpufreq: sh: drop redundant freq_table argument
>   cpufreq: virtual: drop redundant freq_table argument

Individual patches must not break kernel compilation, but compilation
breaks after the first patch itself in your series as you have not
updated all the users.

Merge all three into a single patch.

-- 
viresh

