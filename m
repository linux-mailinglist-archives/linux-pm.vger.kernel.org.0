Return-Path: <linux-pm+bounces-29059-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC186ADFF46
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 09:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DE0A188C93C
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 07:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB66225A34D;
	Thu, 19 Jun 2025 07:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JQbawT8v"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2789E2475CB
	for <linux-pm@vger.kernel.org>; Thu, 19 Jun 2025 07:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750319970; cv=none; b=KaTAX+n2MqX+KV7NbR4IcWzUrie3gjt33S5iJaapAiPKpwPWZ92cu+WhDRHEPV2m/k7jGn3s0nluQmXvfDlopPCtuZKT1mKwDaJWATKlRwtIEHmbZkwT8HBCcwJf8PxO+HM0q1lEJgTKVTOe6OGUZt3x9z+ZAjOXxdouK7/jUyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750319970; c=relaxed/simple;
	bh=qmTIT7TE5o1AMakCWk3TpcXBKxAE1s7w+sHy2Jg1Ohg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZRFxAWHGUpNruUCQcchyNOUDshOLQo853r27M4uWyOcU9ZQsgvn43ysSRVAu6lRgNPJHIjKEvIbEX9lXwnqs9yHOkiQiWdjL/tQ/kvyw5oLVwpN55Qxvh8UrrIO/ilT0DPHhlBeepYk0ZZl00BBXnR12TYVFByVm7Uvfyb1e2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JQbawT8v; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-747fc77bb2aso367639b3a.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Jun 2025 00:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750319968; x=1750924768; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cInoigfZTtwglkgDR0xmxDXjKijNgKERgzu95Txxg1s=;
        b=JQbawT8vXjHrPpgSDiE1rFd2j3uEEi2DZDhzu88zYO3p+PlrjE6vhHDKVEsEQWUVMJ
         x+d15zGQnG6RnIVCxnTDYczGQygUO7tM2sxWQSCZuZIxbvgJIoIopgUsyv7XF9uHyHOY
         /4xHhVxUQfdMFX2ryT8mLwsh+PIm1Kj7ut68LllZCgzSY9yTF8+x5UC7FDyqM0fD0INi
         h3BaUmQvk1fS6bBdpbdNYEmPQxYbKqkSI0wEh3byA/Iq2Wf0ajZJ8OGptrLMlU8w4/ly
         YYtEQ9fqQs/tjsMuVT7aidnMegCf3Ns6Mt9BwJS9nmzJ5dbPQubeK+96JusCVNMH3tYT
         Ovpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750319968; x=1750924768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cInoigfZTtwglkgDR0xmxDXjKijNgKERgzu95Txxg1s=;
        b=m63WhUIKWtlWgvxgR6iJXihHvyRRQQsQr/DoC9hVQjQGA1SGDb04EoX/Nh6Ae4ViQG
         3BbivVMxqil/apo3Zysdtc3EZUs09FaO5GAdNcTwvHecprNAmuXp0NC/eTw3Wq5plvrW
         1vvgz+pqSDL93DazPk3mjglNKIA7IcSJ17MXjQmhMajUa+Z8eFQ4f166WhhiU07BDwd6
         MKLJVxgmqQfyiiCJ84gs8qtMwJWuUZ0dSFR1rGMGBgJ3e3BmW0UmQNn/7WMDbXtCARQy
         aZBWbCdD1GT7OPgVymF7E8IG/sfGe03b1xoynuxIJ5Xj867w/nXXPF0fvMBGm6IagEPb
         6M9A==
X-Forwarded-Encrypted: i=1; AJvYcCVY4KK4OaGpopUFRSWbdLzvIttgd4nu1PR4bVftUUrlakHcbaGErBHjoBxbBbRL+7EV0EsntmE8/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIncCSiF1/E3x9OKcPwzF4XJzBweKZ32hO4ZYN0sO6dLbm9G0/
	0t/AQCuiWARb7DaQAj80qqLrTYelBVCyR3YLTC28IzCeZZ0eIiJ1cnXbEHBRXoMB0O4=
X-Gm-Gg: ASbGncvHXd5Zh1iJkPWiSIwLvNJLs0y5EA/eiIKb7KaXKxX1J7b03Nli3S5pIBVN6Bl
	OPnXiQ6tO1TuBeZ66WGIt54c7QGt5EG6FZ6ma5Vv+VQviCf86YoaOK9KhiyfJX5HmV1w0q8KSCI
	vLLhLinXVy87dD2C5zp2VIZ/Jc1ss4wb2Dgwpo1CAMmCkVZdLuscpmjqPz3Y+jncCafnACXbhv1
	74ksteDgxFI3EM0dDKY/iX8UL3Gqk+S/eeqdXERSNItXgZI19gkSIs+p+lz5Kywht37WyGS9QCV
	rsgclUddv5jDK8uLygrjMygTKVThpYeENlnFkN+q8uSfhlutyH95CuAIm8NpJfo=
X-Google-Smtp-Source: AGHT+IEHfU6bbYUYkS6wqhh+4RphCH4wKMlMEHQgk9iyWb8pXPgDQPEQZzKXARvmNYDg3J/wIX8yOg==
X-Received: by 2002:a05:6a00:3928:b0:742:a111:ee6f with SMTP id d2e1a72fcca58-7489ce3cd70mr22825218b3a.10.1750319968295;
        Thu, 19 Jun 2025 00:59:28 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488ffecfc5sm12951000b3a.13.2025.06.19.00.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 00:59:27 -0700 (PDT)
Date: Thu, 19 Jun 2025 13:29:25 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Abhinav Ananthu <abhinav.ogl@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
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
Message-ID: <20250619075925.b2s4ngza75kc3dsj@vireshk-i7>
References: <20250613101815.18092-1-abhinav.ogl@gmail.com>
 <20250619065713.hm5ye2uhikaei2xo@vireshk-i7>
 <CANiq72muPYoPGLrb7jYWMqbWgknMuWJSPMdFPRQMFduFsDTs0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72muPYoPGLrb7jYWMqbWgknMuWJSPMdFPRQMFduFsDTs0Q@mail.gmail.com>

On 19-06-25, 09:32, Miguel Ojeda wrote:
> In any case, from now on, one should just refer to them directly as
> `c_*` (please use the `kernel` prelude for that) -- please see:
> 
>     https://docs.kernel.org/rust/coding-guidelines.html#c-ffi-types
> 
> I hope that helps!

Thanks.

-- 
viresh

