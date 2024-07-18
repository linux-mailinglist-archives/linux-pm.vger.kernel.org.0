Return-Path: <linux-pm+bounces-11221-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAA5934696
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2024 05:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C54001F226E6
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2024 03:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503B129CFB;
	Thu, 18 Jul 2024 03:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nf7ruRec"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B121D556
	for <linux-pm@vger.kernel.org>; Thu, 18 Jul 2024 03:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721271962; cv=none; b=j+xv5wv2Oesizw3UAIGKohMBZVKCWAsTkVsUkCHijVb5KqMLVX/YuI2nG/npV33ZpwKQZkOswH3ufPhI7IfvkHL/bInHxpbGvT7xOwygYOHlBjx3UWH0CH2QsODlK7wOyW9YZ4cnpbSsAHO+Ee1s5p/9tjAbmTNl/w68H1B9HC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721271962; c=relaxed/simple;
	bh=3p1nHlyFmbd2Mqt/h3ECuwH02UH1qFkMjptXlGRXakM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgjnWwEhyIKxoY/rk89ATnVdXujHk/2kbH2nBRvweVcODAgzQseFTRrgGwrgt7aHRaLyZe1rmX7UR2SGbLp/eRYM5It1LBj+fuhmtgUhRXvWMMJ5JRxzqC22jm7TxBe/Ytycxl+kaGkftqkHWytRLe8UoORlIaLttNrXEQUT3d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nf7ruRec; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-78aeee1068aso197853a12.2
        for <linux-pm@vger.kernel.org>; Wed, 17 Jul 2024 20:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721271960; x=1721876760; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yeW6dMBKtWe8oDZj4BcQTEdzzbJoa7udjbLAE+AJzpw=;
        b=nf7ruRecmH17OyG5D6e3NRbhVcNXggf0gG9iOHljGVqvloxoQIPcHQKHUhmwsQoyga
         GSwfGqPA7JfQZbRLuo4RSmzBpMZWVXRE9Z5Gz14ZILTJRHrlYB9efcWlRTekLfvXC7Bq
         CXZuwjBf9zeisNKcMLGscV1niHTmykwIALM8MAJFtjjm4jjWy6eTOG1+XNOXyrnVHIaN
         yB8Zr7tDbSAs1h1QA3NWOOXBHWdew9ePme1Q7neATnw7s6hF1hPklM462Gbq4tW4bbja
         k7YiaLYo+3tDZGsXzGAm5lAfzG2oJEoe84Pmy6uXiKM13O74D8q8dZCEj46mOUEZkb3O
         VQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721271960; x=1721876760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yeW6dMBKtWe8oDZj4BcQTEdzzbJoa7udjbLAE+AJzpw=;
        b=dNPi6qgaUdh/feVsc8zZCFLHxwhMwBJpwfZdgWEYBLqtDkF6RGfYGevGq+uf7w8T3k
         3hsJO8JdmPSHyNQCR43hSJO7ShLShuXhBAq0W5mYkYUqD/y0R1N/yf0zaeid9XF1EbS4
         JYB5dXYNaQalJ+lV6wODmcdNGtEV75gS+izmofSnCSeMI/nAAsKxTeItw1BY1Ae1WbXE
         NEaeHIqZ3bSwlYD6u9nh+soZ/eFDcryTohuNtxrPIcFe6Op43wRPcMBqh4D53iTbE8lf
         LEvnPSLQHkyiGTxvFp7lLO3ALuS2GGtKA9ZVJfnfrMXRzwJlzLKyPsGqqCQVMpx/EyCU
         IOpw==
X-Forwarded-Encrypted: i=1; AJvYcCV3zdsrygtP654THOxqI2jHNIo+h/SWokEGZ3bVyRA4DRlUrImuJ+C9hgjRWfDFtMuTMaiwtSyYQULzLeYgcHfeanCQla60F1Y=
X-Gm-Message-State: AOJu0YxpA20Zp8WWAXcpz7plBLj7+JoVsdFzLA6fBIciBXobQNE8hp9C
	UWDUUS5Vqv+6f2S6yQiXapIeKHHiaALuVFSDh7oP3g78COlGm/KKlHYpotOtP5E=
X-Google-Smtp-Source: AGHT+IGZQrMHKumtV17odbuMLApq0aWGZDMpuPSD6YxnkxMLKUzBluzrVqhDLqn9KpZgTHq+5klwjQ==
X-Received: by 2002:a05:6a20:a11e:b0:1bd:253e:28e with SMTP id adf61e73a8af0-1c3fdc962c8mr4939585637.16.1721271960004;
        Wed, 17 Jul 2024 20:06:00 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc4bcab736sm18649325ad.233.2024.07.17.20.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 20:05:59 -0700 (PDT)
Date: Thu, 18 Jul 2024 08:35:56 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>, Nikunj Kela <nkela@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] OPP: Fix support for required OPPs for multiple PM
 domains
Message-ID: <20240718030556.dmgzs24d2bk3hmpb@vireshk-i7>
References: <20240625105425.pkociumt4biv4j36@vireshk-i7>
 <CAPDyKFpLfBjozpcOzKp4jngkYenqSdpmejvCK37XvE1-WbBY2g@mail.gmail.com>
 <20240701114748.hodf6pngk7opx373@vireshk-i7>
 <20240702051526.hyqhvmxnywofsjp2@vireshk-i7>
 <CAPDyKFoA9O5a6xZ+948QOzYqsRjk_0jJaSxeYRwx=76YsLHzXQ@mail.gmail.com>
 <20240711031356.rl2j6fqxrykmqfoy@vireshk-i7>
 <CAPDyKFocjOt+JyzcAqOfCnmTxBMZmPjMerSh6RZ-hSMajRhzEA@mail.gmail.com>
 <CAPDyKFoWgX=r1QtrcpEF-Y4BkiOtVnz4jaztL9zggo-=uiKsUg@mail.gmail.com>
 <20240711131637.opzrayksfadimgq4@vireshk-i7>
 <CAPDyKFqczrJzHApBOYRSg=MXzzd1_nSgQQ3QwKYLWzgZ+XY32A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqczrJzHApBOYRSg=MXzzd1_nSgQQ3QwKYLWzgZ+XY32A@mail.gmail.com>

On 11-07-24, 17:25, Ulf Hansson wrote:
> Right, I get your point.
> 
> Although, it seems to me that just limiting required-opps to
> performance-levels, could avoid us from having to enforce the OPPs for
> genpd. In other words, doing something along the lines of $subject
> patch should work fine.

I really don't want to design the code that way. Required OPPs don't
have anything to do with a genpd. Genpd is just one of the possible
use cases and I would like the code to reflect it, even if we don't
have any other users for this kind of stuff for now, but we surely
can. Just that those problems are solved differently for now. For
example, cache DVFS along with CPUs, etc.

And as I said earlier, it is entirely possible that the genpd OPP
table wants to configure few more things apart from just level, and
hence a full fledged set-opp is a better design choice.

> In fact, it looks to me that the required-opps handling for the
> *single* PM domain case, is already limited to solely
> performance-levels (opp-level), as there are no required_devs being
> assigned for it. Or did I get that wrong?

That's why the API for setting required-opps was introduced, to make
it a central point of entry for all use cases where we want to attach
a device.

-- 
viresh

