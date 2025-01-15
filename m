Return-Path: <linux-pm+bounces-20457-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 048B5A11ACB
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 08:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 241E9167552
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 07:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9963C1DB129;
	Wed, 15 Jan 2025 07:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sBTntoxq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20D41DB124
	for <linux-pm@vger.kernel.org>; Wed, 15 Jan 2025 07:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736925655; cv=none; b=uJtZMtKQFxFRvwPDA4B0yWtsu+SU/R0Tz39nxqnjVy8C+2mmbnGgGYGaswmW8GAR3GSxxoUaC62bl3aVP2AkdZMYHwzdU0HnGPL+L8LExbmQdZDoJ3/FkjR9r3qESz13wy3NbBFvNa9VmBDv6Uq7j4vY1E+56hk0VbQvbyYxlss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736925655; c=relaxed/simple;
	bh=XzikTHESV/Ntd+QZJyGj4RIIfngi4sP47YjuqZnhzsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8I78EbRsXaSdotwYWCP260kRTuWj2jnrMClw3qlPT4ZEIMJjyzzU80mvsUczJ1vCXuxwEouPrIsb0hSiMjdKOQUF30JXEOzi17NvBoTJGUQ9Yh1mOsyuxm6z4AY8UtEnezMLaQOkEq87EFaIpRkBV1K428zzUefk6b6qiad/pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sBTntoxq; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-216395e151bso7146055ad.0
        for <linux-pm@vger.kernel.org>; Tue, 14 Jan 2025 23:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736925653; x=1737530453; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1kjwDObLIoNVLT9aFZMLc7L3foW+ny81wcgNGFNn03E=;
        b=sBTntoxq5KeDz82lfHjRkFxW5bsG8iOykuHHptVsbVwRr2mfomjgqZSw8tAVpnBKvP
         uHBmmcnYkeS5QRdU9AePviTTj1CbxjX/bbIXv2e0V5KXD3YCRC5bdNMw1njxbKl4obdw
         2EsebPrG1xeW80Jpj+Ht5NrqPPzBBnLmliNmXcVYcverLtjmMvcuNjxR3J12H3GNsG/B
         B8fPUplYtvrmimHFgohh3QOj1rWZsVGWhgwPT1+nhUPQ0g3nangZUfq1VKewAFvd58RX
         o+O1UlK7viqoTT12h5x0eQgrY36BKfzfTZtQT+9anjs428a0WdHe3bdHYszqp2n4ETJh
         sm/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736925653; x=1737530453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1kjwDObLIoNVLT9aFZMLc7L3foW+ny81wcgNGFNn03E=;
        b=nvegOYAui7y5ZNm82VmD3ypcG/tOCNaFrOCq2IUCV/Q8X9gARpQfsxY92mQ3d0Sr2c
         NysWsWvB9nzzlRwLM6E7BaqHgvarngJBdVDh/7g/z+BSbkcYp3oxprhfWVaUp/QNquB8
         JKOekz8XTRsqFXZkpfCBgCr7BVGxMSaRY4RJEnX6kqJQBL8e0OG37ky+woAb+VcOgTl5
         lqbOsQ9n82aDzT5ycpfv6ie4T8yzyWbtH4CoE119L10WYOKRkv9LiPgz36PEfz8ayfjX
         s8hBkLXmp2Y8CyMYKIwce0j4g7BzL7rKaTaBQpb44NFhRsDvnilZgUnVk5AFK+azlxoq
         p5xg==
X-Forwarded-Encrypted: i=1; AJvYcCW+4Wzvw+yA2KaxTff3KWDdK23S15sm4MJAr30kQ9sotZHgClOhjbG5WxUScyfz3G1ilPvu3bRP/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdsDeX8fvId3k5WmZVhRpc9PD+1/UC+kOtnxstRxSm2+wnKJ7h
	LYbTTHDcy7vsBTJIQ9gmQ4wj9S4iiTAoCDeI3aESsWX7cG/rW1iklMKfaxuJxOk=
X-Gm-Gg: ASbGnctYn2gNqcN75v+eyEMKF6r+Mt9SaniVYfVOj4siFuUeavK48LZCl0fkd4toemt
	keIAykxJjr/Quly1w+CM+ZvYBm9Z3janI3Ln+/CLVJmLvCcl0J081uf6VxFEeT5IWuCMviCl3lD
	O085NSWkSFwSBDVYtf95/XvwWXP7WqzVLcGqpaIPhVjfAmbZjur4ZjewywAbI2BTu44vYNSFUkf
	qhmFiNCV7jcfWbIY38Qts20FB18P+LZBh0jDMdeuu3p2/IKTuiG+WVxp28=
X-Google-Smtp-Source: AGHT+IGy0vxxfR2SOnmLvnPHhpqikTCttSEjAwtRnd7DHfkn+LzyHQjPCuHwPcNBKZdRnrNDHmESvA==
X-Received: by 2002:a17:902:e54a:b0:215:7287:67bb with SMTP id d9443c01a7336-21befecb4dcmr38318775ad.0.1736925653297;
        Tue, 14 Jan 2025 23:20:53 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21bd2b910a1sm19109225ad.157.2025.01.14.23.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 23:20:52 -0800 (PST)
Date: Wed, 15 Jan 2025 12:50:50 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH V7 03/16] rust: cpu: Add from_cpu()
Message-ID: <20250115072050.72oeibi735k3pjdq@vireshk-i7>
References: <cover.1736766672.git.viresh.kumar@linaro.org>
 <854f7b8c9cbcc7f38fe5ed548290f41224478b40.1736766672.git.viresh.kumar@linaro.org>
 <2025011430-humiliate-expansive-2ea4@gregkh>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025011430-humiliate-expansive-2ea4@gregkh>

On 14-01-25, 19:44, Greg KH wrote:
> > +pub fn from_cpu(cpu: u32) -> Result<&'static Device> {
> > +    // SAFETY: The pointer returned by `get_cpu_device()`, if not `NULL`, is a valid pointer to
> > +    // a `struct device` and is never freed by the C code.
> 
> I thought it was pointed out that it could be freed when a cpu was
> hot-unplugged?  Or is that a different device in the cpu code?  We seem
> to have 2 of them and it's not obvious which is which :(

I did reply [1] to that earlier. The CPU can get unregistered but the
memory for the device is never freed (it is part of struct cpu). Some
calls on the CPU device may fail later on (if called for an unregisted
dev), but should never crash the kernel.

-- 
viresh

[1] https://lore.kernel.org/all/20250109063605.gmykltd6bnjaspwm@vireshk-i7/

