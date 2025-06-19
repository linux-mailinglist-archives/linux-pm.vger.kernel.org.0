Return-Path: <linux-pm+bounces-29060-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3160ADFF95
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 10:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD24C3A5237
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 08:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6197824E01D;
	Thu, 19 Jun 2025 08:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qQsG0xbj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70663085D7
	for <linux-pm@vger.kernel.org>; Thu, 19 Jun 2025 08:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750320966; cv=none; b=APsX2Gh24JIjtDILLMF6dSYyUA/qfAtlbO9REYODnq72u3uyHAlubG4R1GeRL6ocMvGAvItzbnwAWM+KFsbu9e7/SgCSDV653eiae14CJ9TRClH5QhKK3DY/1ql69MBPO6AtEabAuIPZwxcyKQJms9mlKxsHRVt1qfWEhlh5wbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750320966; c=relaxed/simple;
	bh=zbCaHIDni1is8/1VUzP5in34Xsb1zCdrBhY2rcfVogM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmsf1SOz9VhUKSIAqK3AXaxMUwHJt5yiZy430b/CvKDnAB7oxXImA0a6liKg0zAzUvuliEnDVN1erTf2GHiPTVN2exsq2bouMkq5MtqHHVAq6GP1kKhPpxuIkIYSnIwXMrKjDGPBpLZpbozBhQrwrGMwINOfyyE2RJeTuiZnzrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qQsG0xbj; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-23526264386so5946655ad.2
        for <linux-pm@vger.kernel.org>; Thu, 19 Jun 2025 01:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750320964; x=1750925764; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K0QlyepxER9o+isFGhwtQG1hSRbSpj4GjpamIkQZ6oo=;
        b=qQsG0xbjn3QQjdKCT6K4nV5hSKDGkVVfOVAlZXb+BZmsHZkxUJb0hSMauTp9X9yAFj
         tI5HpZA3l2xoYCOWyOebCUcHUdeQ1QbCG/o31/qBTVqPQSVerGuxP10z010M+IHY2vGM
         kK438Sj9uBUAYFW0g17ZLSuNwtZeeBThCQ2xUU+qEeNs2+9FVnFU7StpQO+cDKZRJ70+
         +osnwZvUoPy/eMs9f2KAft8sX4G791n6AtFovKHTdh9YwaAjFpBF7FflFlXU7BbKu0Pp
         7FVzarF7RAH9M0lEv1WfPnUEqCf3A2HrEIyVuHb34j0wrZJM+oUoaGEAD/uAidf7EE+G
         +5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750320964; x=1750925764;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0QlyepxER9o+isFGhwtQG1hSRbSpj4GjpamIkQZ6oo=;
        b=RMs0lvHpRWUa+3JR4Tzajo3x6y49A53+sT+noMSo1yTuSt2bn+wv2Tw6oYL7PcKsHF
         GJ5TLor8LBLYohGFbQmTsPmJHUWiQGVzraOEbqNOjEkvohPEiQShE+KLUgUzAwXcnI2K
         JI7SXRMPqO/sLGetBkQdUbvX7Ef0nESuawxKVXMOUSRCD5xA4AswPgKtW80CQLz2CB+U
         mYXQ8DrV77pJsIrTp1BoBiTxr/CvAz3NcvMiiLR+xxBoWAHGVUzxY1tMl+EGLXzCn09W
         7bJHqppEbkZBd8Prs2rrULbpw6S7PhWKU+KI+2jzASvmq1lTSpz9oK1PcFOAgDIgc8/W
         +kKA==
X-Forwarded-Encrypted: i=1; AJvYcCU2aUwt9cgqpsJi1ydUVk96J3kmH9DmINqWqImJByjLRD/i6KmYlcv9dKmhyFNkZHi18UXLSr8idg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIVk8ifqs4LYSXfUeRpiMC4Ym6xWVKTpP/9Bl2xj7rQcPsh7Ix
	nXCzkuhWANBVWN1KDRHU6QSYPkX5csakFkW3AxVHp71DL+Cp+S639iYLZXG803iTDeA=
X-Gm-Gg: ASbGncs4t63FRHBTJ84XpVaJ3GsPSMY1Eu9FQuCKwMSPAo13Q/31QUo7mFTMPFLDPEa
	RbhTKaJviLfof2AksemK/0b8p7fFVlKCwh2NYfsEJIagkBNaUd12pfpHP1hDTchdC0iJwQn5nh3
	UDvHqnvMJ+Eur3fO6DGlLud82vKSZzKvOqaKLW1xzwu2nNFmO1A3uIDKnKiUfjmIQOo3l4k/by/
	IxfomHbMDcTmxgfYGVtrFCSPQa2Vv/d/Pb/XnmrZa9mw9LoyWC0EMHKf+Bu5UpPmvpifUlOOHVd
	HYhY9W4FHqp3sn/0ilZRHl77qCu47C6xpGJcfbs9MXpezg+Ma7QbSyz00ukY5N8=
X-Google-Smtp-Source: AGHT+IEawLEh5ih0nom5h84EhiR42/JMCNTCVEdgMiTCqrC/LqbAHFqUFmpjyl3R9tYM3sjCCxQHtw==
X-Received: by 2002:a17:902:ce0f:b0:234:986c:66d5 with SMTP id d9443c01a7336-2366b3137b5mr354396845ad.5.1750320964113;
        Thu, 19 Jun 2025 01:16:04 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d8a4d6csm114635095ad.88.2025.06.19.01.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 01:16:03 -0700 (PDT)
Date: Thu, 19 Jun 2025 13:46:01 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Abhinav Ananthu <abhinav.ogl@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] rust: cpufreq: Ensure C ABI compatibility in all
 unsafe
Message-ID: <20250619081601.yeulh36lhrqxo4ep@vireshk-i7>
References: <20250613101815.18092-1-abhinav.ogl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613101815.18092-1-abhinav.ogl@gmail.com>

On 13-06-25, 15:48, Abhinav Ananthu wrote:
> Update all `unsafe extern "C"` callback functions in the cpufreq module to
> use `kernel::ffi` types (`c_int`, `c_uint`, etc.) instead of Rust-native
> types like `i32`, `u32`, or `usize`.
> 
> This change ensures that all Rust callbacks have signatures that are
> ABI-compatible with their corresponding C counterparts, which is critical
> for FFI correctness and safety.
> 
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1170
> Signed-off-by: Abhinav Ananthu <abhinav.ogl@gmail.com>
> ---
>  rust/kernel/cpufreq.rs | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)

Applied. Thanks.

There are few users of kernel::ffi::* in cpufreq.rs and opp.rs, if you want to
convert them as well.

-- 
viresh

