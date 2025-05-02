Return-Path: <linux-pm+bounces-26586-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAC5AA77E2
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 18:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29050168093
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 16:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9B925D20C;
	Fri,  2 May 2025 16:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBkKfka6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D898D2550CD;
	Fri,  2 May 2025 16:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746204998; cv=none; b=e9kTqUyc5WEQ4k4zvegPoOAO+1pem1y1V9iddm2d8hoHqO/c7J1+WNcDWKwiS3/A6CO8ltlCn9vHt/RUbqZ3Eg+0o5LkGCXMZEmFWzacXU/H55LwD6y9dDNULU/Pd+2iOVd2B45mHSHN0+n0+NxUZkvA5ctK/RvAWnsz2+znHl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746204998; c=relaxed/simple;
	bh=GBHups5I+gIu6whqi8BvCYhA5MweTY00AdsyfZPYn9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oOdoy6tOpo5nUx/GSQUvVm11WkkwIu2pJYxuEuZab0LXLR7YtAJmcTPfncgASgsmBlvbUdSiPd1WonTaEOM2UQr4zrBmigvZZWvK4O7FS1l9x4ppwUblSp1e5MUNxrG2/TLx8uFc+XI6gSrBk58/smsosCRAPzNcYJgKUqACfkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBkKfka6; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-736b0c68092so2229406b3a.0;
        Fri, 02 May 2025 09:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746204996; x=1746809796; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FI9or1Ma4PHqswRmQGj0F/KO6MGilj/TeQYw7Kc/iS0=;
        b=nBkKfka6R8It4tcbyf/6SY/t9U1jo4m3YGneeJ0fQ4UjXFPtN1jc2qqfWVdBDf2h12
         v5Hg86M0105SW2h2sLIbz8XywYX77KbryDrCFpvYJMIxZr9wLIyvWsoqpv/LSb1jpoQF
         0MIWEJmOqDANLLs6r/XTRSIkeH4Dov8yzgw+zvi16kF3orVHejK7ineYGqLvSfVnewWd
         UJnr/BWN1wdXQh1AaaEtmmmlhLfRYzOUI+odZV3V3P6RCratQlYPc+BmcItZDt2/QkO9
         YPFsBuJq9TKtbwZ+2n0XdWwB02llh+kqdwY5MX4xeRKAWkeGHK/VqLk9SYI2dlFYsYAe
         iSMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746204996; x=1746809796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FI9or1Ma4PHqswRmQGj0F/KO6MGilj/TeQYw7Kc/iS0=;
        b=GeKpzR8JuAVgLIjitNl1jXJmkL0mzw89HfAo3WqGNBAZdtgCT0UhznvScFuAN02phz
         lPXjFuMmzJhH1+m2suP7jtE6fsVDe8zlfH89cGAOmid6n8Xd4qND4D1eIREXdlV54nMl
         OwR6vH2eT4U8rhVlxKhAo6s2tOZ1q3V0hxwgz+hD9bDqHtTqOEbVtfUvtfpiT2FU3toA
         EEM0CRuFWzUlUiJSbMlI1SRvCdID9qKkuwS8HYQoyTq7NpNbcFVmzzF4rhQyLHxgetSO
         RqWlPvD9vdyrDcLq2xa7xgppnyseeqaY8CC171EDphOmjLEl5Lj+yU7TQXWA+39c4/1o
         WoXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF8oKJEkO9zdRim+n1LfXp8mR36UUACvILTTdmHdLQDUB7DTjB46iY8VI7N+pfbvrDTwvHsUaNjeDFtYWSQ9o=@vger.kernel.org, AJvYcCWKDPgTT6vm8YUSADhyQl8AXsq3C9lPPFIFTHtoCjSgwpE3N6SGP1SVC1TYy77U2TqcotM5sRjH8fI5KUI3@vger.kernel.org, AJvYcCXQPgv6DjBn4L03BsCj07c0ww61bjCyD+vKEvtpmCnTRHzc+ASE/fzhnOwX84WoUIipksnjK8txT40=@vger.kernel.org, AJvYcCXqQkUzxFboL2liArtNhcu4TF/APP6zU8Nmq+Vfeob25PFtZ4XFez8dRSCKrRkurW7F5TCKIm3BUlw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj+SBNxJ2y7XQn8HbK2GNMSHhj79MccDisY9CInyH31XjH6eMb
	gaAAsDw0fk3vzDfDLgAH2CJBYRLOiSA6PmjpnsGgPJrFqgfLcrps
X-Gm-Gg: ASbGnctgTvq86Qc/Oa6BRptfjpz9yKrqOr1lfoDvI4f9SGeyQQQaKTs/OYM86iqKxfS
	btFXCHn4o19AscbaEDzxv3KYAhHz/GbOZUVz/uo5lsdUeqUkmAg/+wOqmdKeZKBWybQV/v1PKGz
	q0/eU7w9bsMdeecStl881xFnvNXghMgfqibQUMu2yN9r/gAWVbW5S3fiynOecKd+Cnskf/tkWAL
	frWMoRNLsNri6v2SuGgRK8nGgmzT/FAfn3h6ULCswjFWtQkV4I8PX0Sj5uGl7JnWdT5t5eLg6oj
	lPOLOretaluROBA6Pi2ftQBkBUp51Wu74TfacH/W
X-Google-Smtp-Source: AGHT+IFADEip8AGWv+PRev2ND75le8BrTNt8vAuOXih7lmn25wXP4jLWsoV3+kT0W3JJXCuQ/tT5qQ==
X-Received: by 2002:a05:6a00:ab86:b0:736:ab1d:83c4 with SMTP id d2e1a72fcca58-740587626dbmr5168007b3a.0.1746204996089;
        Fri, 02 May 2025 09:56:36 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74058d7a47esm1825655b3a.29.2025.05.02.09.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 09:56:35 -0700 (PDT)
Date: Fri, 2 May 2025 12:56:33 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	Burak Emir <bqe@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V11 01/15] rust: cpumask: Add few more helpers
Message-ID: <aBT5QSEBG4H_wz3E@yury>
References: <cover.1745218975.git.viresh.kumar@linaro.org>
 <944ee57ad1b190f6975c739802b4d93166bd00c5.1745218975.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <944ee57ad1b190f6975c739802b4d93166bd00c5.1745218975.git.viresh.kumar@linaro.org>

On Mon, Apr 21, 2025 at 12:52:08PM +0530, Viresh Kumar wrote:
> Add few more cpumask helpers that are required by the Rust abstraction.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>

> ---
>  rust/helpers/cpumask.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/rust/helpers/cpumask.c b/rust/helpers/cpumask.c
> index 2d380a86c34a..eb10598a0242 100644
> --- a/rust/helpers/cpumask.c
> +++ b/rust/helpers/cpumask.c
> @@ -7,16 +7,41 @@ void rust_helper_cpumask_set_cpu(unsigned int cpu, struct cpumask *dstp)
>  	cpumask_set_cpu(cpu, dstp);
>  }
>  
> +void rust_helper___cpumask_set_cpu(unsigned int cpu, struct cpumask *dstp)
> +{
> +	__cpumask_set_cpu(cpu, dstp);
> +}
> +
>  void rust_helper_cpumask_clear_cpu(int cpu, struct cpumask *dstp)
>  {
>  	cpumask_clear_cpu(cpu, dstp);
>  }
>  
> +void rust_helper___cpumask_clear_cpu(int cpu, struct cpumask *dstp)
> +{
> +	__cpumask_clear_cpu(cpu, dstp);
> +}
> +
> +bool rust_helper_cpumask_test_cpu(int cpu, struct cpumask *srcp)
> +{
> +	return cpumask_test_cpu(cpu, srcp);
> +}
> +
>  void rust_helper_cpumask_setall(struct cpumask *dstp)
>  {
>  	cpumask_setall(dstp);
>  }
>  
> +bool rust_helper_cpumask_empty(struct cpumask *srcp)
> +{
> +	return cpumask_empty(srcp);
> +}
> +
> +bool rust_helper_cpumask_full(struct cpumask *srcp)
> +{
> +	return cpumask_full(srcp);
> +}
> +
>  unsigned int rust_helper_cpumask_weight(struct cpumask *srcp)
>  {
>  	return cpumask_weight(srcp);
> -- 
> 2.31.1.272.g89b43f80a514

