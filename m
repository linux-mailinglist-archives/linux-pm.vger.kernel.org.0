Return-Path: <linux-pm+bounces-28496-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E8EAD5B87
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 18:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E56E7A1B1C
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 16:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290C41E1DE9;
	Wed, 11 Jun 2025 16:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0a6hxOe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EBD1DF73C;
	Wed, 11 Jun 2025 16:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749658360; cv=none; b=dfTv895E47PUh2ycr1JvUlt3jkKubOlhdTutN+I88CYWb7Z0biqDe/CYRM4yehfAnOMido3K3EI79cbV9fwrtdS3jXgNjtMHvXZdPdD7+xQx3AnXIcvm+sEL2fPW8D9cC6jKmTZGUeTApg2Bt5o5OgUmz3KV6msjg3wAFLg/Wdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749658360; c=relaxed/simple;
	bh=ETANpm6EqFC2Vwo5F2XSqEIz4CNyxVCGrz3gt1R8QEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNLyYdDZ/bhOHS0D5+FnEYaOmojkl/5JYhCqYtzH61bueCWCfWUQxEnccTV23atHNktfp3gTs1vxWFd3wv6TmOsAn7WuCoXtWU+XxDQ29jADC3PkTDj2J00P8tE+7KzT3NB9Tw+VNZE1HmS9gmMLTZvbIg706MQZgvBB5zyzl2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0a6hxOe; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4772f48f516so11546361cf.1;
        Wed, 11 Jun 2025 09:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749658356; x=1750263156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cOqaKfMnsTaXLoIm60AN8TWGnnOtqMk25sFNi2p2JVQ=;
        b=i0a6hxOe0OkpB+adoCqMvueO6zPtfiWNWZhMzuF37LtHi3wVrD3lUnQCBoFtsI00GX
         81VekkmrLv3MHtISF8Q4W0Y/4ouFG0eAGowK1D6LSYd3OS8nps2TiMOkOF3Bfe+v+sKl
         PCwkg57ZTREUlex0cRWLmsLKGvEDGiXd/vPa9aGqKuYpKCOvpPKbFBIFFXPJCl7yMZ3i
         U/TCoALos1xPh5JesXhxWOAwf6DjrU1am2/dha7zB/RFhUIDF3mkrzfUqwuyXonds8zy
         xfVo8lRYUafmuh32m28iPe6x+iGFE1ifq6u3vHum+uOd6uP8OXKrRephqSwvzJUlyE48
         zwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749658356; x=1750263156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cOqaKfMnsTaXLoIm60AN8TWGnnOtqMk25sFNi2p2JVQ=;
        b=SR81NLkg/P0XvRAB9y7FivxSqA2SgW/PdJT/A9f6yisEVV/nC0d1V0vpTsB79QGaTE
         EeYJFMnWPVcLfFgb5B4fj2BPVe7EeDBqrprLP/p7oL2e7Xjl/mfOJFIc/jH13fYchk0X
         TLZFYNQ5R0mkv/J/nQ+5odxFTXHyF+PRqwhEJ1rNJWkglrgcLf3BM7adnwcw3rFsuCnb
         jMsmpr+o0lbark4YjNCTbsDV6X80Hkjm91sRq7130pUn0s8+X5gWr0XLMg2ZCpOGpxvI
         aofFpGs47hDVTj3Yy3MWH7yNGkhesYigM8XcCEJwX2UFwcQxJDXjcPOSrAm90Y2H7spH
         ATAw==
X-Forwarded-Encrypted: i=1; AJvYcCU/57Frjf3ydYGm4UDXvzJpf0TYxZk3otKJe+HGKKH4d1ZxRRhJIBQdwnEpiwyBUBamu8STydCMCWM=@vger.kernel.org, AJvYcCV7Iy0If3jWuJdJME0b6i/1aILjBRxVmRNeFpy4IrtuDFwTzcDM+cmmt2rXKp8z1mOHUI6sj6v4UzuJDwg=@vger.kernel.org, AJvYcCWDjxs8CzQF8jwLEDadXERbRuFv38GBVC8UZ9t32iuHLL0FxJv5aCiI930qqJz9Piwuy0S623k6wSVirODZiXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAwrkPcie37c5R5yrOSRRHx4Xyl7l/uKwt1WhicCQGJ5mXZD7S
	fmOGf+wd2quxCT14d1/c69Jwjjw/Pf2U/88oStEz94+8FG0JWKBIjKbp
X-Gm-Gg: ASbGncuFiyzKX2wG9qKuR01dSvNZ4VbJBX6iVrm6ppvkx1UIKNHebvof+v49MBsYdBJ
	a3f9gD4mHtC89hew7pDyLbGJRWbtKDiQKuPs6g06I6sj9egDg2QuEOfTLHjB/PmUWXcm/puS5qp
	xIYY/fSU58pJRE6r5k2hYCjp+FlGq/FVddqPh8hhMqRJhTFPdHJVeq3gFySmakgz3aDQdhCp7dG
	YpuXdNfW5hpKR3RPjmFj7/iTfU22HNLl8gwRLT/S29Y7KCkf4hrdO9kJfQ0q2u02iGQ0rfXWW0e
	4QS9trxEfypHaNEt2BKooRPPYKNXm8Zpsr24o9lso7nltjUyabh+9SW48ukvkPvCq52UdDVybSQ
	Oyoc7xhSyforcyoS9G/2HoWhtVBUBu1GBpFBVUqzXq9ITzOkNwqFv
X-Google-Smtp-Source: AGHT+IEMe8vZfIrYIwqDYE+r9WByE2MjWdEkrIHqjZbdRs6+a7OSfT547V0gOiWhYRsRip/9k9doxg==
X-Received: by 2002:a05:622a:40cb:b0:4a6:f4ca:68e4 with SMTP id d75a77b69052e-4a713cc71a7mr68712471cf.13.1749658356097;
        Wed, 11 Jun 2025 09:12:36 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a6f3f76489sm65762301cf.13.2025.06.11.09.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 09:12:35 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1654A1200043;
	Wed, 11 Jun 2025 12:12:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 11 Jun 2025 12:12:35 -0400
X-ME-Sender: <xms:8qpJaPRvPezLPDtHsufFcxiybXeO-M0Xr-CBxRSedeZWlWiKrxU-Ug>
    <xme:8qpJaAz_o919iftO5SHWP3bMoCFBmoSclibdJ_iuRgLpOZdzU2O6xQcHpLOEYWzka
    p3mBsg5_JGZrDf2Mg>
X-ME-Received: <xmr:8qpJaE24aDTD7k1gOQqlhwrDOrPiS2_1Iv9LRysUC9NgT83tQofuR4Pprw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduvdeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddu
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepieffjeehjeeludekfeeikefgteevjeeitdev
    kefghfetkedvieejfeegtdffvefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejje
    ekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhn
    rghmvgdpnhgspghrtghpthhtohepudelpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehvihhrvghshhdrkhhumhgrrheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprhgr
    fhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtghhlgieslhhinhhuthhroh
    hnihigrdguvgdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdp
    rhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgi
    drghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihg
    uhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrd
    gtohhmpdhrtghpthhtoheplhhoshhsihhnsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:8qpJaPASC1h95X96Q_ckIG60TlcdPVkotussSHusFTRp5Hp9OFxTsg>
    <xmx:86pJaIh0PkE69P7nBdMxFJbP2nTdODKMghM9nlexi4CHNoUXWGsmIA>
    <xmx:86pJaDpqkMIda32lafDX6N7dyy6FE-SfU9i5kcPl-SoedMdFfV2DFQ>
    <xmx:86pJaDjoAkNV33JMpTQKe9s_IZNxCchDqSWIwY2OUOC-bSC28OZGTQ>
    <xmx:86pJaLT8L9HTgLTSanbkRVJE3Mw45QC5MKVbr96yi-TfSqjpJUJLh7K7>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Jun 2025 12:12:34 -0400 (EDT)
Date: Wed, 11 Jun 2025 09:12:33 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Yury Norov <yury.norov@gmail.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 2/3] rust: Use CpuId in place of raw CPU numbers
Message-ID: <aEmq8fs1fHSB3z4i@tardis.local>
References: <cover.1749554685.git.viresh.kumar@linaro.org>
 <e790f17123beb45c6a811135ec3df8f0bd761c0e.1749554685.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <e790f17123beb45c6a811135ec3df8f0bd761c0e.1749554685.git.viresh.kumar@linaro.org>

On Tue, Jun 10, 2025 at 06:51:57PM +0530, Viresh Kumar wrote:
> Use the newly defined `CpuId` abstraction instead of raw CPU numbers.
> 
> This also fixes a doctest failure for configurations where `nr_cpu_ids <
> 4`.
> 
> The C `cpumask_{set|clear}_cpu()` APIs emit a warning when given an
> invalid CPU number - but only if `CONFIG_DEBUG_PER_CPU_MAPS=y` is set.
> 
> Meanwhile, `cpumask_weight()` only considers CPUs up to `nr_cpu_ids`,
> which can cause inconsistencies: a CPU number greater than `nr_cpu_ids`
> may be set in the mask, yet the weight calculation won't reflect it.
> 
> This leads to doctest failures when `nr_cpu_ids < 4`, as the test tries
> to set CPUs 2 and 3:
> 
>   rust_doctest_kernel_cpumask_rs_0.location: rust/kernel/cpumask.rs:180
>   rust_doctest_kernel_cpumask_rs_0: ASSERTION FAILED at rust/kernel/cpumask.rs:190
> 
> Fixes: 8961b8cb3099 ("rust: cpumask: Add initial abstractions")
> Reported-by: Miguel Ojeda <ojeda@kernel.org>
> Closes: https://lore.kernel.org/rust-for-linux/CANiq72k3ozKkLMinTLQwvkyg9K=BeRxs1oYZSKhJHY-veEyZdg@mail.gmail.com/
> Reported-by: Andreas Hindborg <a.hindborg@kernel.org>
> Closes: https://lore.kernel.org/all/87qzzy3ric.fsf@kernel.org/
> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

One nit below..

> ---
>  drivers/cpufreq/rcpufreq_dt.rs |  4 +--
>  rust/kernel/cpu.rs             |  4 +--
>  rust/kernel/cpufreq.rs         | 27 ++++++++++++------
>  rust/kernel/cpumask.rs         | 51 ++++++++++++++++++++++++----------
>  4 files changed, 59 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/cpufreq/rcpufreq_dt.rs b/drivers/cpufreq/rcpufreq_dt.rs
> index 94ed81644fe1..43c87d0259b6 100644
> --- a/drivers/cpufreq/rcpufreq_dt.rs
> +++ b/drivers/cpufreq/rcpufreq_dt.rs
> @@ -26,9 +26,9 @@ fn find_supply_name_exact(dev: &Device, name: &str) -> Option<CString> {
>  }
>  
>  /// Finds supply name for the CPU from DT.
> -fn find_supply_names(dev: &Device, cpu: u32) -> Option<KVec<CString>> {
> +fn find_supply_names(dev: &Device, cpu: cpu::CpuId) -> Option<KVec<CString>> {
>      // Try "cpu0" for older DTs, fallback to "cpu".
> -    let name = (cpu == 0)
> +    let name = (cpu.as_u32() == 0)
>          .then(|| find_supply_name_exact(dev, "cpu0"))
>          .flatten()
>          .or_else(|| find_supply_name_exact(dev, "cpu"))?;
> diff --git a/rust/kernel/cpu.rs b/rust/kernel/cpu.rs
> index 6a3aecb12468..7549594fad7f 100644
> --- a/rust/kernel/cpu.rs
> +++ b/rust/kernel/cpu.rs
> @@ -127,9 +127,9 @@ fn from(id: CpuId) -> Self {
>  /// Callers must ensure that the CPU device is not used after it has been unregistered.
>  /// This can be achieved, for example, by registering a CPU hotplug notifier and removing
>  /// any references to the CPU device within the notifier's callback.
> -pub unsafe fn from_cpu(cpu: u32) -> Result<&'static Device> {
> +pub unsafe fn from_cpu(cpu: CpuId) -> Result<&'static Device> {
>      // SAFETY: It is safe to call `get_cpu_device()` for any CPU.
> -    let ptr = unsafe { bindings::get_cpu_device(cpu) };
> +    let ptr = unsafe { bindings::get_cpu_device(cpu.into()) };


I generally found that `u32::from(cpu)` is more clear than `cpu.into()`,
but it's up to you. Same for the rest of `cpu.into()` cases.

Regards,
Boqun

>      if ptr.is_null() {
>          return Err(ENODEV);
>      }
[...]

