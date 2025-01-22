Return-Path: <linux-pm+bounces-20813-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6CFA1941B
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 15:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A001B7A0357
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 14:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00AE21420F;
	Wed, 22 Jan 2025 14:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wZ9kE0R/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D66145A18
	for <linux-pm@vger.kernel.org>; Wed, 22 Jan 2025 14:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737556695; cv=none; b=YAEio+w8mPIxcbs7KgTqmoJhBMhYgKs+NbIoIPkOZt8NDmGvbBMa+orhOnjPd98ScdZnZMHWi+Tgxr7itiNJCp7q1mlmpYg4OWfipHYOQmV9ZBC3wqkxj6//gLKvWKkcwKwvE0K1Z/izacxmvMUQ8hmWhiLOGB5hQG9/rzylm6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737556695; c=relaxed/simple;
	bh=mmUxMJ6D295FPfIkByhKohQ5sM9At8FovJKGVVwBaOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AkXlCCF5lSVrQlUted31ySuLK3LcbcgPWqN6pPchzP5YPcAU8DZ4iPL5SGE2RGz3SOfVgDj97TL1mGlhd9a7MfMlhbjDI9JUYEekau3x7vgG3BKaln9KPJVyRAiahV4hVaFQFn2x54ndBclMYdbb7rfYnFTRiL+Ry+pKkgzwJYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wZ9kE0R/; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21669fd5c7cso125903175ad.3
        for <linux-pm@vger.kernel.org>; Wed, 22 Jan 2025 06:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737556693; x=1738161493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A7oe3oxBlbNLrA51+/iZ7xTjxkXjstCHhMW3t6qQe5M=;
        b=wZ9kE0R/Pdx6Tk8fvq7mEhNXk0hTodv14JHu5dInJXksM3ozOyt6ppoTxaofn33mA/
         UT69l6AQxjRJ7EBJjP0bqJf+l0V/8DlzPSNA/B8oKdkmSwSfc/6H6Makdwb2222QSoLY
         Au6thnBJ/EjMZKd9+SFKBwZXLOnX7beWIXO/4dckMMBYo7MgGjrMJw9siGyu6gY5JyfK
         iqw/+mDzzcGeAiEzjjrlEdwaQj2CCxawaXyEbrzBAo+JW8CSkmKtCkNPrHm5DOLSipuh
         /G+owxqr6ta6gr8gnmLpn7wB6X39MRjfgFR0ak2DwHlgOHTk+ukkDEb2Agyx4yIOukV+
         RVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737556693; x=1738161493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7oe3oxBlbNLrA51+/iZ7xTjxkXjstCHhMW3t6qQe5M=;
        b=TqTlhvemrhjM3cZuSlgoxFr666ClRnVTn2IUV5gy0DrA0Xo55iH59aNddvmYa1tHcD
         1reUihiXSwvyoofBdeMJvS40JhSj/lX/twHKm/ti7BRGGalYu8a4YeIUjfwPk9xx1joz
         Wmq5ioVZEYmqm3lcuLQEgDn9cdcZmnB6oQB/h9XDp3VaWpEzoEqMx67FScgFC7YWtEsw
         8pOhrLxsqSvMoX+VyXu6Sx+LoBASOcirYsCQTkEyyw0qSHIAMKFYqu8ae7audOVvFP5W
         gO0C1I4KoaCA+l1lTUNvwPAFn3rvIYMbZI8ZG3s+FiTTb7RyuWy27cm4ACQExBAxESQD
         NMwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtR1slNQV5RN3k8cUDwGMzHFOaO++XD4R6hvjy+3Zz/KGsEXjZLQM1AmIRPVXGd2US/edAikwRqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMKA43NAOq3IuS51863XcpuBtRzTOFjlprwHeAQ2GZbcbQEPDr
	WAbVQfFZYaMqUyvogrZBBcgj7grci34VcZjuxbSmBPl7ROtARwa4xoDZmfxZCMQ=
X-Gm-Gg: ASbGncvpszKCdUcwUhMdQqZiR7B6lUlXcDLFTEB3X5tbqbchZ+u58msWuSRd7qb6X6H
	6E/bj3nHFljUMP3OyPPu/TpIFmQB1yaKVxSB1XlOhKO82QNaKfuCdk2dLXRDP6zggpH9JdGksxj
	bjVqMxJK5NJZzMJ09wiaH1ymhTXseH4cyrxPqAgZxaNR2Qw8yaDrej4TfnYe03XvK3VJBJXm6Bd
	BSqp7RvcJhmbnp4gSkbdrAL6SGKV+hkRLdH2t4nxkuyy8SYDmoUMYWvJgkbSe+XXB3pxtwu
X-Google-Smtp-Source: AGHT+IFEZnS24okXDcrrm/sT/fH0xlL4+dFvMOfgSXuD/OhLXvOPTny09cOpOIKKCXBB/6EhI64J0g==
X-Received: by 2002:a17:902:ec8f:b0:216:6d48:9177 with SMTP id d9443c01a7336-21c352c7976mr318465665ad.11.1737556693318;
        Wed, 22 Jan 2025 06:38:13 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a9bdf0b43aasm10668624a12.66.2025.01.22.06.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 06:38:12 -0800 (PST)
Date: Wed, 22 Jan 2025 20:08:09 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Anisse Astier <anisse@astier.eu>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
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
Subject: Re: [PATCH v2] rust: macros: enable use of hyphens in module names
Message-ID: <20250122143809.gpbhvz4tz3j547pn@vireshk-i7>
References: <20250122131812.466080-1-anisse@astier.eu>
 <20250122133952.501055-1-anisse@astier.eu>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122133952.501055-1-anisse@astier.eu>

On 22-01-25, 14:39, Anisse Astier wrote:
> Some modules might need naming that contains hyphens "-" to match the
> auto-probing by name in the platform devices that comes from the device
> tree.
> 
> But rust identifiers cannot contain hyphens, so replace the module name
> by an underscore anywhere we'd use it as an identifier.
> 
> Signed-off-by: Anisse Astier <anisse@astier.eu>
> ---
> Hello,
> 
> Change since v1:
>  - rebase on branch rfl/staging/dev

Tested-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks for the fix.

-- 
viresh

