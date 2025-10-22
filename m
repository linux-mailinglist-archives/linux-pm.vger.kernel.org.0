Return-Path: <linux-pm+bounces-36640-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D07A7BFB5FB
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 12:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89EE719C2636
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 10:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4D82472A8;
	Wed, 22 Oct 2025 10:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q5eXYtvb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69A430E83A
	for <linux-pm@vger.kernel.org>; Wed, 22 Oct 2025 10:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761128443; cv=none; b=WUyanBj+snmdCsFXq2NyzlR2q+C9y3M6pKHZzH2NzqEZ/pWJeSGjs4EuJCVU9HJj3dtqYSufCGqiY7g/XuZ5X2Dbv/BPszEzV0EBUbjub2sqkHcSxoHle66+F0QCPFnFLuuMBQG7dzQYiR4p9E0pzgJmNa7Ywa1zAqWrD9V0z2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761128443; c=relaxed/simple;
	bh=bsLcKTPJEYIr6iWd2hSD2/QqBkscjLQjYwtElmBwUuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppvFl6HLNeWwfJTD7YAovDoUbYDYKlBH0RPaqugLniS91KOQ2xLbl3WhNT/5AAwG1sfS5MeyywV2jfmvQ5ZR71YZR68jSB9UwlcHZkwKyHsw9ZqjYMxQdrvmD+Ks+ftCDuYKMnkvknaxIB7ZX2ZXdlmrGy1HGYquRr5muagcZW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q5eXYtvb; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-33c4252c3c5so4841821a91.0
        for <linux-pm@vger.kernel.org>; Wed, 22 Oct 2025 03:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761128441; x=1761733241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v+BERCfgvcR5X/QpiR51/cu4DL63bwSFg1M/A5GNtaI=;
        b=Q5eXYtvbRn1VEpYB+ckss1F1GCQzUuvuD/3fl40yNikmpxtheQ7sMn5qQvpyDoulT+
         NuvQXfh9fYXtofOxyEbl6d7RyO70TDEpg64rLRY8Z4vUP9uKQlEXiNkM1M+iM6F81x/F
         ua9PH5RaMRdzQEV2yy93eyH5PdcySO3Av4XbIIZheaM0qTCVtAjaw4K1QPiveyzwKtZk
         IHMzU7jBq7zstnoUb6xfZhwSbD/kOa0yLlP1eyBnchlHBEhyO1/otNkfaRLrm8zT1jgP
         a1tsraAlVachrcTJG4BJNiELwejevit8YN2V0suucIcaXRrV24RUpbMYkEFrEBAwVusc
         SddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761128441; x=1761733241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+BERCfgvcR5X/QpiR51/cu4DL63bwSFg1M/A5GNtaI=;
        b=bnOTTGo1SjbQEbArRYCcqmrvPx3PS+fBWgtc0oTe4cQO8c8wPLBMdL0Lp0BbG+VtBz
         RepHw9VmowB5iblRfTR0r4ayToeSPJwRBJC2GyXWPj3TSjs7jdYSPu/JGNoE/g/Du575
         9Q6exzOOJ8LN/IVIxsZWcwZMx9r0HaSK16mtaLjjlesWKcyRAlrZ9cq5ZYMQuCp+jjnV
         6n39ynWttYjYMDDCTmjW84uk3s6stphnOHaD3ykrnuo92Ibh1X4VQsoosm5Ea+9N1/Zn
         IGKfhsEeZzq/NWapbZ9DkcnHMEhTyjwZKyX1Tgw/EJmaqbsSUjR1zVba/p3j2WUZtg9x
         KrPQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7gQVPqt57yD0a2ri43hfNhYAcMG1+jOGNHPVe/603/xoCiPsKXhwuJ63hx0b9ddnK+Jr9Q3+0yA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyleIvVeIDvJx/9mROd3WUfuDGmrEDAw7gb8Tr1R0uZslNorm4L
	XfAu7c6gN+pTh48bPnKcT7kotO9Yhvr4qb3a2cVBxkMQlUpiqw93+L6HeolQ5Ew7N60=
X-Gm-Gg: ASbGncu9Ta0iLzmF0htT6aZulZ6dsv5lF3b6CSzaQUA7J6F63UPmAi1X5T3vuXeumxj
	I+bsLuYvHeqmOPBGt1U9ObTmDPFreD74K/cB37KU71xs7zVyDmRXsh5TCDVzWSIkUFLc4Cwljx5
	Na18tpXcZc2xJiCv84JvnpSrX9lqDporWMzvSML+MRHJBXtJIhm09rD3bDHxY9ezP3nKazQPKtn
	3NtZe2EdLsrUfwDqtJqCxSi48mQKlaH20UIaymoNoDv4AmYGOi9TBXJTBwoSBTJJpUp4QIcUV4r
	lLqkE9ssaPAkvkOHgcPM7gOk/aAwKhDmppBwPrhCtD+Ulttk1YEiZ/1nK6YKqaU2kfwCoczcZdN
	7H8vDVUYtjAhOsedo9E1l/oZd8O6jgCXQmajFRQ08fwmmwDMohGXavXco8wTrIN1UjTnXxodapr
	QnIwlt5GaKLZIC
X-Google-Smtp-Source: AGHT+IEPudXWObjJLDv2XWqM26sgZsiKQXdb5QBSpUD/P+viWtBD0+IrqTmFx+e1SWZr7yyFfz4vMg==
X-Received: by 2002:a17:90b:5105:b0:32d:dc3e:5575 with SMTP id 98e67ed59e1d1-33bcf8625b0mr23541723a91.5.1761128440788;
        Wed, 22 Oct 2025 03:20:40 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223f0124sm2159272a91.11.2025.10.22.03.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 03:20:40 -0700 (PDT)
Date: Wed, 22 Oct 2025 15:50:37 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Joe Perches <joe@perches.com>
Cc: Ally Heev <allyheev@gmail.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andy Whitcroft <apw@canonical.com>, workflows@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dan Carpenter <dan.carpenter@linaro.org>, David Hunter <david.hunter.linux@gmail.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, linux-pm <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] checkpatch: add uninitialized pointer with __free
 attribute check
Message-ID: <a6yf3ms7smzjfcm54z7khg6g3zpepqwxcbhwzm74dk33famolr@s2at2tnyxoed>
References: <20251021-aheev-checkpatch-uninitialized-free-v1-1-18fb01bc6a7a@gmail.com>
 <5e11f1bacb6430e1331f02e3e0e326a78e5b0d12.camel@perches.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e11f1bacb6430e1331f02e3e0e326a78e5b0d12.camel@perches.com>

On 21-10-25, 10:06, Joe Perches wrote:
> There are many uses in drivers/opp/ that could be updated where
> the initialization is done after the definition like the below:
> (I've added the opp maintainers to the cc's)
> 
> drivers/opp/core.c-unsigned long dev_pm_opp_get_max_clock_latency(struct device *dev)
> drivers/opp/core.c-{
> drivers/opp/core.c:     struct opp_table *opp_table __free(put_opp_table);
> drivers/opp/core.c-
> drivers/opp/core.c-     opp_table = _find_opp_table(dev);

https://lore.kernel.org/all/45a64ff434a027c296d1d5c35f442e51378c9425.1761128347.git.viresh.kumar@linaro.org/

-- 
viresh

