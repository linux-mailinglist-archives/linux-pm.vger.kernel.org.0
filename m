Return-Path: <linux-pm+bounces-29954-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42457AF0BD5
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 08:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B65B7ADA88
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 06:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426262253FE;
	Wed,  2 Jul 2025 06:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PmMtyj5j"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DC32248A4
	for <linux-pm@vger.kernel.org>; Wed,  2 Jul 2025 06:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751438355; cv=none; b=jKhIkYVuwsRzkgDB5k02DChj/KNmGVgbA6jO2XoXZjLoX5td/8FjzHqqi0OEZ7U51jdFElbE0HIU9bC+S2n87eNMGTnCXlZbENJpLRGiXDprq1OkO3en0q/X5+yeNchbXe4lmi4XmgE8iQ/mUhL/gCTxtXxzGqONDSMR+sk1ZXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751438355; c=relaxed/simple;
	bh=/eoPnEunEB76YC7IbsU/tHmmFPbDK2slXP9EaWP9oms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJChe9+ZKSX+1zL74MPvC71d5kliAFbdfGPFEe+GS/LjjCT9As9/gY5xRxniBDXxCldtSAlYSaRJ67E0UPduxOtyg5Ax0JUKL8IXuyxVutZ7SIdqB4M0zrM5U2W95+OKF/eIN3rhDwHk3XOpVsewf+12uJRcl/moNHVrwN82J0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PmMtyj5j; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-235f9ea8d08so58550575ad.1
        for <linux-pm@vger.kernel.org>; Tue, 01 Jul 2025 23:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751438353; x=1752043153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SW9FatXBBr9uVZr3p1oMLELHRqOke3lhi3vQmmUuOgY=;
        b=PmMtyj5j5ZoFsoC8w2h0GTszuNCycPPIkZ1IZCZltwXLSUr0zWT3p8A98VYCu0QyA4
         TbE88KJAcZEnTYkOqzxWD5SGXdvO82tdvtDNJwZq+nIi8ivt7EbOpdrdtRz7cAzhDh0h
         gAvXjgn3ohA7sw3FtkiaRtXBD1O9VDhWGzMxIWG63oxnCiGWCfb1xWyFqBhnYAfbW8yX
         92Lz0IT09KiLjcltJDfqmbB+YZj0kB/ko0J/rFxCv7hBg32YFFaq+yzU22kvmBVQzaqy
         RRtW6tkrgD0uv7sN660R5TYdtOlJaFngVSebLtll/jyxxt9G8slxsXeoyyE5zfvnW4mg
         iM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751438353; x=1752043153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SW9FatXBBr9uVZr3p1oMLELHRqOke3lhi3vQmmUuOgY=;
        b=rMx4NuiFH3rQ+pk2v573WAn80JETJdFeebvGf40X7+0Cl2uk6cqGebz2l5NuzIXLmh
         d7JW6BoJ7yly+OPfUIcJqJmtxPiNe9k2ZZ/MFe6gog7hxeYvxyr4Slmh93LcsgJ00h6H
         qL/nA2VVwBqeBZme1OtmvGpQOn3ZJyHtbu8YIW99vr4hAWtbIVPpgUkOI0oBqHDtWcAv
         Xl3S1RJJOidCJ6OHemqHx5hbFLHIcs+LCq27IcM0RhbkOwipfYY9qFkXF83fKqjgJi9p
         idhERobZtr/PWOipMQ96NdTQ9JUr46n1AgppJMQQbY15T8O26AgMm6py9mX5zuHx9tIE
         Khzg==
X-Forwarded-Encrypted: i=1; AJvYcCWr8ZZ2sfKuFC4TLrSg+gl36XM1fZ2bCnGVw2oJH2q1KhYMq1uYGVjpmheIl018SgT/t/17m7GhYA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHpI330NZ6RlFgzNPyCPhzOn0pUTirHU9bulKGTibGTGn0pLmg
	eIny0q0VPA8ylLb4JrtWNDrJoxqPKqeh+iPb5Nsgm5M+hM75JIDkeXEMx1H1r9MLrk0=
X-Gm-Gg: ASbGncuSM6bWSNMHNAC/wxEYRsF86oFTXt75bTA5L8bD/QwLy4/xgT4D6KSK49F+k19
	Ca5uQTZTPDewYhsYZL6WWoulUsAFBkJWZlrmB9GFEmKNChqHqilMki+zphb/GLDc68a3fAIQuK+
	OGThjHYFRkimhKGav8UaxxVt6LCodY7CGfNbTyk82SGxOonfSJkyllWTmWCc0qAXI3C5opI8GuP
	Ek/aVy+BjhI7zgZBtlYiRDLNu4pUxMP3erqqGW1qQ5XYNJtppyqEqBcIABL8fXo9KIK8IMLHM6/
	2wxkZHDo2eD0vxlQRpIPuu8mazP21bgshQDLzUBxb3tcNKYomsDZ7sDvoDvVpWA=
X-Google-Smtp-Source: AGHT+IEyC4KmfLegb1B82Q909aH2SFqeih6Xb6CMFnbeqXshdOd8HpJJu9yHcNKFqbkSWsfoNu5s9Q==
X-Received: by 2002:a17:903:1b04:b0:234:8a4a:ada5 with SMTP id d9443c01a7336-23c6e5b5d10mr21914435ad.37.1751438352997;
        Tue, 01 Jul 2025 23:39:12 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2f39bdsm128787855ad.80.2025.07.01.23.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 23:39:12 -0700 (PDT)
Date: Wed, 2 Jul 2025 12:09:09 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] cpufreq: armada-8k: Fix off by one in
 armada_8k_cpufreq_free_table()
Message-ID: <20250702063909.zeplodhdbvqscefm@vireshk-i7>
References: <7ae149bf-5e4d-40df-b1c2-31d5ef418f05@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ae149bf-5e4d-40df-b1c2-31d5ef418f05@sabinyo.mountain>

On 01-07-25, 17:30, Dan Carpenter wrote:
> The freq_tables[] array has num_possible_cpus() elements so, to avoid an
> out of bounds access, this loop should be capped at "< nb_cpus" instead
> of "<= nb_cpus".  The freq_tables[] array is allocated in
> armada_8k_cpufreq_init().
> 
> Cc: stable@vger.kernel.org
> Fixes: f525a670533d ("cpufreq: ap806: add cpufreq driver for Armada 8K")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/cpufreq/armada-8k-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

-- 
viresh

