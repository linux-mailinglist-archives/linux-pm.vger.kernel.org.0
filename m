Return-Path: <linux-pm+bounces-32118-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA2DB1FFB1
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 08:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1AC9179194
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 06:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C672D8DA9;
	Mon, 11 Aug 2025 06:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PN0emzbw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECD22853EF
	for <linux-pm@vger.kernel.org>; Mon, 11 Aug 2025 06:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754895495; cv=none; b=KT0A01Q7aTohsQjurKhcNH4MfYb7+TuQuXYO1OVX8dnDJIaVnKkLInBZdJJSbxRKRVz5NddUJzxqEG0wQ3Oelw5qn6x7GY4fq6qy23SDTS4cSqcx8OVSOEAfdITRiNZppM8Y3OBToILmlePLDxmjl3QB2+hV6/TWQDSxjYqu6DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754895495; c=relaxed/simple;
	bh=mPEn2tUqV0VDvUBivVCyIGNkt25kHVG5g2vC4oAjlTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4iEDAPfePNKStxvPpdqcsuPt2DRHX/HNrWJCkEqzil0wY3WFvYfgo3gkCtYr1t+/jfArD+fh9wIgfig5Kg7SKu7sCNi+WB15JNmd0vviB90rlP2hH4XikBt/ur03dpojgzFXIf69SLRFTNbytjFEmAjYiII48agaM2aLonEmSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PN0emzbw; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-31ecd1f0e71so4741072a91.3
        for <linux-pm@vger.kernel.org>; Sun, 10 Aug 2025 23:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754895493; x=1755500293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qj4hp02pi3+Fvas+cfw51dF8x4V7PPZb3b5a0f26w30=;
        b=PN0emzbw6uynRdmul2tVtnoZo1+B3SmROmVyVgOAHRyFPts8QCvJnFAIsKyRilQ+Cl
         n2QpXFi9s9R1DvNw186YfIECMlbBPfNAPcb9kKRq5GMcf+/oU+Niom9JH/UdW2scpaQf
         HbGOYcGAkWwIXSU6qa1z5L4tS3mMQzH4N1uQf2YTusXisCWhuESsIyI3O/74oU3bihqY
         wEaFjgq+MpcXM/EE8F74kHhUJcIbqJes5hIJtHuF26vIc3xje2zhW8JSph+ggBSRUi5f
         wSROj/3yCxS1HfS09TvMI4yxP+oGw1uo4qfRvjLKWWEtbZjSIrsDak4mHFXD6I3Dupnu
         bprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754895493; x=1755500293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qj4hp02pi3+Fvas+cfw51dF8x4V7PPZb3b5a0f26w30=;
        b=QA+M7X+cwfsIPYuOAOVsoROGnC4MlqzxypyXhIgzKbNx85bjL08Pa5abrQ0ZA7Jsvf
         quSQkiii6dJ9esGmpP8IPAzT/3ayWkEL5GnAEbWRK0LiMyJ6zoo/L/A7v90bId/dK3Fy
         avS0JyhHxiWi/pDtkyAiI+2BTZaCT35wdFdoVv/5DH6eM4AIP2rhuESLR7FmBOWxhiOD
         mTZGXKesa2wYb1+r5jc7F4xfHAi8tpYR+H21QjkfFX587xk/5QBNbQDyZJYluSlXl/Kt
         YcZ7YNcVz3l83umdzmNsdUS0Gem7i4WM+Z+d18DmmKtxbNRdCQYlCJsfaIkKQLpyLzHt
         waCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKSGaNj5fEwmjcE5ZVFLN/bFZgbLNXs8IK3yqjjbtnIQDq3EpWw2eFlfh9X96RmgfiWWSdv3dFQg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0WUrPK974fMVntGAN7mEqZ5Tc4n7xQXjyLJXWzeSgViin/S09
	319AHGW77OhwOtPDREVXGR8sfi2w3Lz7yQf32M8DsHwoh+MW07Iiw2beuVEzzpeNe6EThBlorTW
	2Nyqw
X-Gm-Gg: ASbGnctO4Oc9l7C//Lq7l4RN76Q2f+W6zUMfLPs5sR75pEaHxB05qJKN4dn2tgFMzjp
	IyWNqK9MnCtmhfaAi+BkmuB39mPSHkgsBOuCiNZXXqCE3LdvUlnl4GuRsYE0oa2chDQ1C/X1+Vd
	DCoTPaydv0V8FTjderopHSRH8jcvpIUXr5PlH2V3p/E8hNKvAq8rESZV/xAFXy3+T2+S0/PDk/j
	RsSilG+aXIRP26GG/EKe2aQTPnZWtJidoiDxC0pgHz2YYiPGJ/5/jhAihjRR+xr47JtrAtw/U+8
	Qa2J4WZBxSl9cu9VbEHO7ld5m+AMDRrO6SLe10nry9l+4gmo5tZmbkrwa7oad1C2pshV3XpIlRR
	ik2WCOB1YpsKPwwrtQcJ/mp6jTxhWhf13Ixg=
X-Google-Smtp-Source: AGHT+IGLtc7a//OfFj6ZG9+B3qw4ntIvd3AReQNNqvydUWUlWk7x6oot8u6tFdHA1E3a4aWom236mQ==
X-Received: by 2002:a17:90b:4a82:b0:311:a314:c2ca with SMTP id 98e67ed59e1d1-321839d795fmr16326481a91.6.1754895493053;
        Sun, 10 Aug 2025 23:58:13 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-321624ed650sm7427532a91.6.2025.08.10.23.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 23:58:12 -0700 (PDT)
Date: Mon, 11 Aug 2025 12:28:09 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: BowenYu <yubowen8@huawei.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxarm@huawei.com,
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com,
	lihuisong@huawei.com, zhenglifeng1@huawei.com
Subject: Re: [PATCH] cpufreq: Remove unused parameter in
 cppc_perf_from_fbctrs()
Message-ID: <20250811065809.nwfdfjwidoacqtca@vireshk-i7>
References: <20250730030649.151272-1-yubowen8@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730030649.151272-1-yubowen8@huawei.com>

On 30-07-25, 11:06, BowenYu wrote:
> Remove the unused parameter cppc_cpudata* cpu_data in 
> cppc_perf_from_fbctrs().
> 
> Signed-off-by: BowenYu <yubowen8@huawei.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)

Applied. Thanks.

-- 
viresh

