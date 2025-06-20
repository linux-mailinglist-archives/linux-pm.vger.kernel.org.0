Return-Path: <linux-pm+bounces-29152-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 091F7AE1813
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 11:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A669016E6C6
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 09:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23CE283FEC;
	Fri, 20 Jun 2025 09:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kaenU0K5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B82C283CA2
	for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 09:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750412614; cv=none; b=ApGlgH+evgHuTiSzg3mNMwPvUsHj2g+vauQSgWfLAYM+wIdCjHdtftMKTXeyU15PMts8UYwTY3u5SCEc/h0n481o4Fanlx0y1xEeoRgCg3kePDbvjJpl86n4krpjjOLPiVJAAzsjL65mINYEnClDHhtvxz3hdinfdgMJyH5HWBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750412614; c=relaxed/simple;
	bh=CUC8O2VwMALRnRhIMKIyIO0HIrPO1m4KYTOieiWxaKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O9/QmZ57q0Da+c5LoVpcaE5PhuotDa2YCpYpYtAuwjA5iHP+Ar+p+/8jTk86E6dg8p8VNG7tqe4evFHy5t9ExWln1Mgyk/ftSSeMVThU27HxylcLW2Qd6MTDcXFKgsXI3NxFITmb/ySmmWcgeSpMT+00o3SdB9+7s3NdMhkux3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kaenU0K5; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2363e973db1so11225155ad.0
        for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 02:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750412612; x=1751017412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wE7pUg075HF0iK/42gsiTO9zjRo3RhObajlGQz8mgyY=;
        b=kaenU0K5xwreuuRH9D1/lqNy1Tdbx6jkH5EMXMmIm9A7s4LBp/4URb8+2AZ0ZIoiD1
         XJupMph/R78jG53xs5I1ClWkm50WqmnyGqRidkCFQMYBJbVkQj0+OOp5l1xtjMRWX0JF
         6PTowu8kd3YXoxalE5wPZtOTTkD0DFEtsjNJ/ZueuXhrB7Oov1F7RiHZKRu0viJswSWS
         HGCPkN5wJJ9v416Lb26UCXeLyEJvUwHDpBBAXNCcQXtKXAxQoWeX8vURILK8yq/JbkCa
         lyWimYG4wgtGN20+wRcjm2utXV4tl0FJKc/jrdteOaa5JypA0BZc3biQPGzu1LY34Dhf
         MOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750412612; x=1751017412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wE7pUg075HF0iK/42gsiTO9zjRo3RhObajlGQz8mgyY=;
        b=VVpzOheAkOeMeOGmgoSskHC7P92mAMYhug4RsFcTRVM/LBW/c9RwFU+0I10W+Qk6P1
         3Bmh7ZcWWcES4HPZUSqtd8aO52r2t+ogyU6jZ/F0X0Loi91H338aHSe79T5VyaGVBYe0
         WBpFoYdhSkheIbUr0Wo9CBDO1kHtp/szgZJZGw8lBnISQOaxzlyKNulrEoL0E7D+drbr
         7JUEIMXdBQPqw2UGUCeoqQxnyRuBkZ4jp9vmy4gwXC5We+yf5NW1ZULyE1JWZjKc9SBl
         GYxzSwo8qaty/zqeA8D8PGPvo9OUFATJLQLjy2oZJcKRXYlo6Lzu9TIkUGHe1E2mpsFA
         VTZw==
X-Forwarded-Encrypted: i=1; AJvYcCVLk1ii6gYAPFKy0Wr17S+yZU9t3UdCoTCv1MOcx3FFUtJlzLRNCkATWcNyuJHweC95zmOMoJqOcg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh5XN8PLH65ZEcauCl2bgVraPEplhFNdEKglsj8VBRNERlj/WZ
	H2dmE8Jqgho2v7ZeIuwe26wZWs6EPrx/9VanqCzGxAFYO1WSq5dhFVLTg5V/rglfy78=
X-Gm-Gg: ASbGncvjhwadaw57nh53OImNAjzMtn+idswn2jFabpRe1xnmYRb3toYT+TINkxS/GkN
	vvCd4WfO6tdJqcASqGomJ41dkFEm4WH0c4TQuIMZCpvmURfEkjsJL9kRBzcKW5LOcuUax05KFeX
	QRxJ4013o2mPcl+p3U20q5aEGP8DuZmeen9+nqpglXV5+9ok4UQ8warT6moEMxvckHy7ohgBOA4
	AtiX7yi1wlk7nfgPd/qNgPOkHOGV4s4HE2USb1Nckk+9ItsscnyqEa/Y/X/v93k6hrB2p+3LGIy
	RWz1DHbI/Bx4fIyJSUwg1ZFLokAp1hoWX6O1WaOWIQpzVJpCwXjDbhtBUdtViGfLq8CA1zWY8Q=
	=
X-Google-Smtp-Source: AGHT+IGYtaGOuL8gI+YuufgD5d5TBG2eLVkJT8YBCXNPrn8oqs8NULxbod37t1rWLg/LGuPoK+SXRQ==
X-Received: by 2002:a17:903:19cb:b0:231:ad5a:fe9c with SMTP id d9443c01a7336-237db06e6e4mr28537095ad.15.1750412612490;
        Fri, 20 Jun 2025 02:43:32 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d869c5a1sm13860205ad.192.2025.06.20.02.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 02:43:32 -0700 (PDT)
Date: Fri, 20 Jun 2025 15:13:30 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Abhinav Ananthu <abhinav.ogl@gmail.com>
Cc: rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, dakr@kernel.org, linux-pm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: cpufreq: use c_ types from kernel prelude
Message-ID: <20250620094330.m3batzq7oknwk4lz@vireshk-i7>
References: <20250620085229.18250-1-abhinav.ogl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620085229.18250-1-abhinav.ogl@gmail.com>

On 20-06-25, 14:22, Abhinav Ananthu wrote:
> Update cpufreq FFI callback signatures to use `c_int` from the `kernel::prelude`,
> rather than accessing it explicitly through `kernel::ffi::c_int`.
> 
> Although these types are defined in the `ffi` crate, they are re-exported
> via `kernel::prelude`. This aligns with the Rust-for-Linux coding
> guidelines and ensures proper C ABI compatibility across platforms.
> 
> Signed-off-by: Abhinav Ananthu <abhinav.ogl@gmail.com>
> Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  rust/kernel/cpufreq.rs | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)

Applied. Thanks.

-- 
viresh

