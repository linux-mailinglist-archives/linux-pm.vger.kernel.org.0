Return-Path: <linux-pm+bounces-29247-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D079AE344B
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 06:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B2A43AF1E1
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 04:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533071B2186;
	Mon, 23 Jun 2025 04:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RNIz7TiT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17E52FB2
	for <linux-pm@vger.kernel.org>; Mon, 23 Jun 2025 04:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750652564; cv=none; b=Z4zz+r0r+JMe8ENFnidMz9OHDyZAE4CJAJs0XUSe/yl9GsV+6KWIn+QwkxDPwffWJ8UfgtmtJ4erVfd4kG4+yJCh9ulo/ujpBLbMIui0DmYWLMv2k6YvdFRKj4D+DWrLdajUgefrHMKReGQulVxB9ipUrPgmcDRusToRLCGr1NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750652564; c=relaxed/simple;
	bh=5st921uDKTkKgU9TnR9YHhTWnF9x4IKBuHUsPF/rAnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LSx+QDTyQ3lDAFHIN4p+BtjzSTOwu3Bjo+wfbfschxwU+9D2k2IpuVK7U3oCHD4SSqkhfAQp7n2pmc6InvUiBPob2mq86QiLa1954M0TGLu/zF964ScUrJtm4L9nSiHHXvwWryOnzPIDzlr1cd7XPSOgNjqgGxgdadObIGekFFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RNIz7TiT; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7424ccbef4eso2762872b3a.2
        for <linux-pm@vger.kernel.org>; Sun, 22 Jun 2025 21:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750652562; x=1751257362; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5le86o5MqelUxj2e52/BUzqyGfWPs3z+KMJ1+yNcPzE=;
        b=RNIz7TiTIAXBb2+QIkWrigkzTdXFQwbQUtb553PGcs75/uylo91RYCbTX2F+NzkbjI
         KwPKJ0u0HOB/JAfsNwq6O3Zi0E+f4onqRi5IBCEe4z+AOzCg/JYs5QE4DLDPGnVF0xGe
         TCOWdwtnlfCmN9lnuwjtWc7gPIfZyTW3pIlp/82VALG1ImZK7ixKWzKqy/RdAMWQZkfb
         cqEyKZPGkbITuTCDHulW2iUD+yD6ifhqwIk50bsz8nggK48IAg6O0JJVP2XZA619z22f
         OvOwrSnLHU2OlYS3XVAKADami5u55iUC7K1S2S/t0KXE1E6qMVELi3YCKqs5mRzNrY41
         8Xkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750652562; x=1751257362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5le86o5MqelUxj2e52/BUzqyGfWPs3z+KMJ1+yNcPzE=;
        b=mxn6Nu1qz3FHvu3rVDro2yKC+z6LB9GWb6DD2J9CagIcOruvK9ehv4s0DHxfLOzx8i
         QbnGQ9L4SlnjVaaVw6hslhfsbP0aEHyg1cFOEpuX/QzPqLFUAkDTQeXkbzDd4EhbunlV
         SIMfaD1qZGqp2a+9WNIajBVYlKKjxDezt8pF0SHO0a2VKvTcsTyFpBAnxN0FnouTOQFu
         3Z3QyKovQr7f31u6F+6jVuZYZ6NtTp6FrevK+fFxAVaycukl4oBLRl5Ke661iNX4MKJ3
         CF6eZbg3OCRkqQWL/jETqRvF4DabyOTIinB4Dyahvjuo101zUJKdQm6/e+6c89U0g+TL
         SvOA==
X-Forwarded-Encrypted: i=1; AJvYcCVgQLY0C0PskTdM6uF7mncr8iGYsW6HXnQdE5t2elbip8uadnr1pfdcuuln1wK1WjBa6/4LPaAySg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtJB0AwuwmjVuE2u2XWhvVRQ7xGonUntln++QTMHvp2Cg0QtPz
	L9btD20h2tZi76kdn9z1SkKouwMZ0x3NyQDtuoZvHXDeglP64L+U/SWt5BLCUNGgZtk=
X-Gm-Gg: ASbGncs+FDpyTb+so+zgQ5kcRKoN93Z/kmNYJXYLt10lMbcmM2WgBgUiA8ejxZtYQyM
	4KDZvWPDa6s1LHgSttipX7HIdiBWV//OCiOpiUNeSOjhCmPMylp9Q7ynzrgEnq2wvyX96psvbHO
	KfI2qNClnW2anQu753Isr5z4ubeNeFqV7nuzwAuc9TTNWOkPRSj7aOhcBVl1W6aYiqJ6BnSmBnW
	GlTsX6dOQxYDLlD/Mn+E8zjaz6jdtA+4/vFBVdgeerxQePaxOYTO+hVvOTbLAeJwsycGT00Dh7h
	EpvduZnJseDoUFWj8d9XAdZm8hhMdr0/JomLanbi4FEG8OuP7ZDDE/Wf8T9A50+6iZdSQXRXIg=
	=
X-Google-Smtp-Source: AGHT+IE5TuInEJuZ3oFFcgdcOzCV6/0HecXdCRlo90x7islTcM4Alv43ENFRCRPNZUw0wjGIr3K+EQ==
X-Received: by 2002:a05:6a20:729d:b0:21d:375a:ee33 with SMTP id adf61e73a8af0-22026e8226amr18176424637.9.1750652562097;
        Sun, 22 Jun 2025 21:22:42 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a6743basm7412269b3a.142.2025.06.22.21.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 21:22:41 -0700 (PDT)
Date: Mon, 23 Jun 2025 09:52:39 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Abhinav Ananthu <abhinav.ogl@gmail.com>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org,
	linux-pm@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: opp: use c_* types via kernel prelude
Message-ID: <20250623042239.4sea6d6lmamfrc4w@vireshk-i7>
References: <20250620095920.20765-1-abhinav.ogl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620095920.20765-1-abhinav.ogl@gmail.com>

On 20-06-25, 15:29, Abhinav Ananthu wrote:
> Update OPP FFI callback signatures to use `c_int` from the `kernel::prelude`,
> instead of accessing it via `kernel::ffi::c_int`.
> 
> Although these types are defined in a crate named `ffi`, they are re-exported
> via the `kernel::prelude` and should be used from there. This aligns with the
> Rust-for-Linux coding guidelines and ensures ABI correctness when interfacing
> with C code.
> 
> Signed-off-by: Abhinav Ananthu <abhinav.ogl@gmail.com>
> Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  rust/kernel/opp.rs | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied. Thanks.

-- 
viresh

