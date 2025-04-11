Return-Path: <linux-pm+bounces-25277-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4223A862E4
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 18:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFDE419E296F
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 16:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40A12144DF;
	Fri, 11 Apr 2025 16:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKpB/9z1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1228478F45;
	Fri, 11 Apr 2025 16:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744387665; cv=none; b=EGMsX7lcuV/Ul/gu5zJkGyq75rODpLNIaCf4IKyNdjeqnSd8X8XVqASyYyrp9Gmu06/k5i1+8Xu/v8XXu4al/VUY1h8YACv1iAAiunFUUIhwF1rpkiCPiMWPqgrT3U/hhZALzl4sslIZHKheVZkUTXwWpU75UxabTKFco3VTRBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744387665; c=relaxed/simple;
	bh=62MRMmZqQC/emagflICIZ4N1OBFtw1P5mArm6eWQI1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLBElH0eCsBZw3/2aNpH9tbzkm/nIgkEuXwAfGi3uBq7tDqz6MFcvdBvZpVrYjxsRNr7jRJou7FQ5nVjLkteowTnjzUVudzsM7V0I1cTMxea8OH1ztErZF0Odvb7ciV0FEmzbfqGMuEp5ueECmY9fwg/guAxU9nlQROJvjmjRnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKpB/9z1; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-736c277331eso3150165b3a.1;
        Fri, 11 Apr 2025 09:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744387663; x=1744992463; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7NCc2G2kByYmch6+idHD1dvRRPTby9dT9KjT7z2UwxQ=;
        b=VKpB/9z1nwHZcfZGqWyDMuRBBHqEarxZv4iRPo4eVEGg42K7Mc7o0GisYfKkJq5bk8
         6KC//b+fNdX5CboDG4pum9W8LTPbJMel9TMhHK2tIOJxroiTzmWbZZicwug5APPXi6fO
         XnQE9tlx5MiypSZFwwtos3+VtNpECtix8KPGAuivBHsfwRlpKUWPFNmpb3bXJpSmBI4s
         mjngdzefU6L+8fzIkW3hx1yJXybauSgyTvu7vM/Zo5U9vO3j4N2dG15n4bAu2Y2psaXN
         JaGQUbyJW9le7lXheY20HRDHolBEQ1vU78GQLry74UPuz+6fO+U+3XW57z3XpJaJ9tac
         dN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744387663; x=1744992463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7NCc2G2kByYmch6+idHD1dvRRPTby9dT9KjT7z2UwxQ=;
        b=GKOUN9lCvoPlIQF/3p3AnutHorVqsRiezi4Ou+7OGr0DN6CTYS11E3rL9bRCNkKWin
         cYyN2DOipOoc1THh0prDLYv/hGrgJcaW50jfMx3gjXRluEkOvphN3P/3okxOd9OkOhQ4
         KfVKqXvn8EevRUgH0by6eMmzPepuKbo4nua9lqyUDNQR+SecgA3giWZAartKoeamzdbc
         V6ubw7l6ffuTNwwhtYCuNAKHGpzsaFM4RSNp4V2DdRimd/wrLL7hvJ0YrNOKUR7ArScv
         ek3V27n02YT8p76XNSKYgGswYZbdiDBzxX5QmURASSHCbTTON18p9x7mg59G2FZ2Ot8P
         YvJw==
X-Forwarded-Encrypted: i=1; AJvYcCUq+4tFF6UBFqQOZq3cR0CAO2oz16gnImtVNI8f67AUmg3c5bUP3D19XAb+K69NUsCmabAztbl5bgo=@vger.kernel.org, AJvYcCWqz5n4FXjvPj1Fpj/g+xvt/0U1Lvl2P02kovbBrFCMBPXsuuxzu/rSv6UphT5Fbeclvmjw8PyMuPQ7oZAMjBk=@vger.kernel.org, AJvYcCXG+KT4IewCMKv38lH7vVZCmVCPE8rfqsOBLni5us+OzGouwDPX9OM8VMgV2AcSZPJzuzp+1uKL0qE=@vger.kernel.org, AJvYcCXtv6TJCjtzUM4jeyyEIeaciTYh8PrzFe0Df3otuutVJon3utcT8mrDkhnKQTy1X8gO3VcVuWA9+cbac5hY@vger.kernel.org
X-Gm-Message-State: AOJu0YxrjX7xexyFmEqEIaa7xMfb8U4YqbSr2imwiz35SdIC1DI1DGUA
	1PWSqDKFqx2hc5ML2v4lrVgxBp7+Gu4FCVURShhFSR36viF96cx9
X-Gm-Gg: ASbGncvic8+ntJgP6N3ojmsDKsujlp6bfjBaws7opcFj2zvoVme3n9KgEHSKeuVxoEL
	S5tovN92knsuNsG3taq0TMXa12gkddmFr4V0lr3GMM+Szb+KtKoKGe43lVaaM5Itet1n1HcTpVd
	EmnoPfVoABI5EqAFistuceVljfH9vtjrjYu1RVWSdGF/fWPtjVcxfWaCwOSwwKenZiAxYL+2Wtc
	GEaxAFbpwjvhprQWM6O+HgH1ovKZYguFhCPbLdkLmRbheTpUZa1Vp9Y6F4YGH91i+zQuSjLw7eA
	Drl2990V2nAplnafPG80i1Pxj1UGPuRQgByGJ0bw
X-Google-Smtp-Source: AGHT+IG38RnNE2cQHtptce8kSm9+pS6wCRqFcqxOz4wGNYYeuCVJwvF6rpCwjA0rcpis4oJfnWcb5A==
X-Received: by 2002:a05:6a21:9d91:b0:1f3:3864:bbe0 with SMTP id adf61e73a8af0-2017953ac13mr4925687637.8.1744387663065;
        Fri, 11 Apr 2025 09:07:43 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a2d3a250sm4210141a12.62.2025.04.11.09.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 09:07:42 -0700 (PDT)
Date: Fri, 11 Apr 2025 12:07:40 -0400
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
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	Burak Emir <bqe@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V9 08/17] cpufreq: Use enum for cpufreq flags that use
 BIT()
Message-ID: <Z_k-TFCkLWu9eiFt@yury>
References: <cover.1744366571.git.viresh.kumar@linaro.org>
 <efbdd8212a90175c293313de961c34d13b9f4b43.1744366571.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efbdd8212a90175c293313de961c34d13b9f4b43.1744366571.git.viresh.kumar@linaro.org>

On Fri, Apr 11, 2025 at 04:25:07PM +0530, Viresh Kumar wrote:
> The BIT() macro is too complex for Rust's bindgen to interpret as

The BIT() is as simple as '1 << nr'. How that it's so complex for that
tool to realize that '1 << 2' is the constant?

> integer constants. This results in many of the cpufreq macros being
> undefined in Rust auto-generated bindings. By replacing the "#define"
> macros with an "enum", we ensure that bindgen can properly evaluate
> these values, enabling their seamless use in Rust code.
> 
> No intentional functional impact.

The code you're wiping is perfectly correct. And you clearly state
that one of your tools is broken. Please fix your tool or find any
other solution.

We don't touch correct code, sorry.
 
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  include/linux/cpufreq.h | 96 ++++++++++++++++++++++-------------------
>  1 file changed, 51 insertions(+), 45 deletions(-)
> 
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 400fee6427a5..354ae35fe708 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -298,11 +298,12 @@ static inline void cpufreq_stats_record_transition(struct cpufreq_policy *policy
>   *                      CPUFREQ DRIVER INTERFACE                     *
>   *********************************************************************/
>  
> -#define CPUFREQ_RELATION_L 0  /* lowest frequency at or above target */
> -#define CPUFREQ_RELATION_H 1  /* highest frequency below or at target */
> -#define CPUFREQ_RELATION_C 2  /* closest frequency to target */
> -/* relation flags */
> -#define CPUFREQ_RELATION_E BIT(2) /* Get if possible an efficient frequency */
> +enum {
> +	CPUFREQ_RELATION_L = 0, /* lowest frequency at or above target */
> +	CPUFREQ_RELATION_H = BIT(0), /* highest frequency below or at target */
> +	CPUFREQ_RELATION_C = BIT(1), /* closest frequency to target */
> +	CPUFREQ_RELATION_E = BIT(2), /* Get if possible an efficient frequency */
> +};
>  
>  #define CPUFREQ_RELATION_LE (CPUFREQ_RELATION_L | CPUFREQ_RELATION_E)
>  #define CPUFREQ_RELATION_HE (CPUFREQ_RELATION_H | CPUFREQ_RELATION_E)
> @@ -424,52 +425,57 @@ struct cpufreq_driver {
>  
>  /* flags */
>  
> -/*
> - * Set by drivers that need to update internal upper and lower boundaries along
> - * with the target frequency and so the core and governors should also invoke
> - * the diver if the target frequency does not change, but the policy min or max
> - * may have changed.
> - */
> -#define CPUFREQ_NEED_UPDATE_LIMITS		BIT(0)
> +enum {
> +	/*
> +	 * Set by drivers that need to update internal upper and lower
> +	 * boundaries along with the target frequency and so the core and
> +	 * governors should also invoke the diver if the target frequency does
> +	 * not change, but the policy min or max may have changed.
> +	 */
> +	CPUFREQ_NEED_UPDATE_LIMITS		= BIT(0),
>  
> -/* loops_per_jiffy or other kernel "constants" aren't affected by frequency transitions */
> -#define CPUFREQ_CONST_LOOPS			BIT(1)
> +	/*
> +	 * loops_per_jiffy or other kernel "constants" aren't affected by
> +	 * frequency transitions.
> +	 */
> +	CPUFREQ_CONST_LOOPS			= BIT(1),
>  
> -/*
> - * Set by drivers that want the core to automatically register the cpufreq
> - * driver as a thermal cooling device.
> - */
> -#define CPUFREQ_IS_COOLING_DEV			BIT(2)
> +	/*
> +	 * Set by drivers that want the core to automatically register the
> +	 * cpufreq driver as a thermal cooling device.
> +	 */
> +	CPUFREQ_IS_COOLING_DEV			= BIT(2),
>  
> -/*
> - * This should be set by platforms having multiple clock-domains, i.e.
> - * supporting multiple policies. With this sysfs directories of governor would
> - * be created in cpu/cpu<num>/cpufreq/ directory and so they can use the same
> - * governor with different tunables for different clusters.
> - */
> -#define CPUFREQ_HAVE_GOVERNOR_PER_POLICY	BIT(3)
> +	/*
> +	 * This should be set by platforms having multiple clock-domains, i.e.
> +	 * supporting multiple policies. With this sysfs directories of governor
> +	 * would be created in cpu/cpu<num>/cpufreq/ directory and so they can
> +	 * use the same governor with different tunables for different clusters.
> +	 */
> +	CPUFREQ_HAVE_GOVERNOR_PER_POLICY	= BIT(3),
>  
> -/*
> - * Driver will do POSTCHANGE notifications from outside of their ->target()
> - * routine and so must set cpufreq_driver->flags with this flag, so that core
> - * can handle them specially.
> - */
> -#define CPUFREQ_ASYNC_NOTIFICATION		BIT(4)
> +	/*
> +	 * Driver will do POSTCHANGE notifications from outside of their
> +	 * ->target() routine and so must set cpufreq_driver->flags with this
> +	 *  flag, so that core can handle them specially.
> +	 */
> +	CPUFREQ_ASYNC_NOTIFICATION		= BIT(4),
>  
> -/*
> - * Set by drivers which want cpufreq core to check if CPU is running at a
> - * frequency present in freq-table exposed by the driver. For these drivers if
> - * CPU is found running at an out of table freq, we will try to set it to a freq
> - * from the table. And if that fails, we will stop further boot process by
> - * issuing a BUG_ON().
> - */
> -#define CPUFREQ_NEED_INITIAL_FREQ_CHECK	BIT(5)
> +	/*
> +	 * Set by drivers which want cpufreq core to check if CPU is running at
> +	 * a frequency present in freq-table exposed by the driver. For these
> +	 * drivers if CPU is found running at an out of table freq, we will try
> +	 * to set it to a freq from the table. And if that fails, we will stop
> +	 * further boot process by issuing a BUG_ON().
> +	 */
> +	CPUFREQ_NEED_INITIAL_FREQ_CHECK		= BIT(5),
>  
> -/*
> - * Set by drivers to disallow use of governors with "dynamic_switching" flag
> - * set.
> - */
> -#define CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING	BIT(6)
> +	/*
> +	 * Set by drivers to disallow use of governors with "dynamic_switching"
> +	 * flag set.
> +	 */
> +	CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING	= BIT(6),
> +};
>  
>  int cpufreq_register_driver(struct cpufreq_driver *driver_data);
>  void cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
> -- 
> 2.31.1.272.g89b43f80a514

