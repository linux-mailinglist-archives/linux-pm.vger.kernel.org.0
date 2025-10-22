Return-Path: <linux-pm+bounces-36617-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E872CBF9B9B
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 04:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 254E2565904
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 02:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A58220F3E;
	Wed, 22 Oct 2025 02:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ns7datzf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA9E1F7580
	for <linux-pm@vger.kernel.org>; Wed, 22 Oct 2025 02:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761100071; cv=none; b=nzSjhcDcQEXZZrs0r1pkFAy6LjPXqO4qWdo+hfM8Dsm0WWMejwCrL6K4n4FkrOWCvgipcOxkpVCmAEd4CeKrh1/W9VCChViOyM9AUDFdUW+9oa8Qgs+sFLqk2q/fa9JmsY9vrjthI0bfwzN3Heze7uBLQBWSNH0FfSyXYAIDTHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761100071; c=relaxed/simple;
	bh=gtxXSsibCJLZR4eJo0X6XeizsPLCRJKnPsqSUiDcNsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUkB44fuLKUqqc7RiGXX0pn3ZdJO9KoguXuYIXq8lqKuTxdK6TSZFWoqjMOBvAO27gj3UgwkLgCrHDMPHP27MwM5Tc+3FfnncdtqKAvwlPKbAmWPXU5eiDZk0X+R0463Y60n9JBSwx0hTBu8jx3sad9SUq1R0rzaqEgdWO9RA0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ns7datzf; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-793021f348fso5643189b3a.1
        for <linux-pm@vger.kernel.org>; Tue, 21 Oct 2025 19:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761100069; x=1761704869; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xqmP8PXFVjPtIGVNVJySqdODosEn/uc3qt8eNXsbPts=;
        b=ns7datzf8icGOKTONAAVfZEYX2gMWHAvcdFwbStWebO0Rl/Du5QVFmBnXqRSoiZU6F
         ptf5P7YAZ3aoE7s/Q6aHquXgljNMj4Z+TxXz/HRHggRHwGLOK6rVwuXlMjLRhzddmEyc
         /a6aU+en3DTez+1SXNrDFb3/tQ6sHTGk02umTReHZF43Y/BdECOHhJXF60IYCuXL+cJN
         NTZLYpFA7z5SJO5wFP7WkGsflKczPbG4jpAELRMI5vtL3D6j75XXzKArcmcPSy5dvNNL
         kPHckmZcRpjqHq1jtHBqc67JbXw2PwDBNFk0/Ma9yM29KWvHwFt4UmMzb3KAngK/Rsi7
         4FSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761100069; x=1761704869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqmP8PXFVjPtIGVNVJySqdODosEn/uc3qt8eNXsbPts=;
        b=UWAYoyRXsJohxZdVyLn5IdKmACWELESOEQam0bldg8VtOFlfvscRmQoOhwZ3Efz/MN
         CJuS4jkfJSlc5d5pPohyW1RQQMWJeMHT+yrg67/Y4oUAZlL52pG0r5d4K/p2oQhabgfz
         j1HECkMRH03XEt+MNvHmLHvUANjVjNDWMVJKst/Z1dCxNaqklZ6UsO1VmAM4a43b4I6l
         BTDDEvIe9aJTDJWJP58bFzhfBzuvMmWSpFPypKe/dzRa/WR11AoZOA7BcaTuMdfKZWK5
         klSTDDM1LRRTH1khM2Z43IF2+qweo2wsCuxZx+dIPD6zFJAfIIQAVZeVof/zvEI2GrNA
         j16g==
X-Forwarded-Encrypted: i=1; AJvYcCXBKSwpf/crLBEfN/IYcho5SDakrCQhe75nnnUlFMzKRnwiO2pNrxSf6xWKixTUcfjQg7QR+YBVUg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKjU2qRSVZD8Fi5UgwHXygiEeMQc+ZoHxfRJy4+OcvuJ1JgwU0
	922SNzWXfM2FTdmjM2uOxBYdVrLym4ql11wKmqPVjDNGDC6hP1A1nuljTNXVBX1pExs=
X-Gm-Gg: ASbGncuQ5zwIEtWkgQG+IfCUoLvR1iHZ4XFrAq0F5VIIAuBla/F+iUnR4j5V49/oVHc
	ixk4fQM2iu/pNRHi3pGSpAmT2tqTvUAXBn1okdXmVxGY2UXnD5OXe1vtE2wXg1mbZ5JdVmJzoKq
	RB5CPH4lGQL3M19vDRFHW7Horil3104t2D3Lr2BStm1IKSL7Wk3y6Mij+AGZkpw6Nty/dWnqLjz
	2CmhSluW9/I4SEumfOfOtgv81Id+a0038Bz4x0kzNumPvRLSxyyrKN83dKUDyRWYjYxBORX1zw5
	/DaI9KCSnE5CpQab0BZCU2t3xwOZ4R1ySCI/HKynzfG9Ur+70hN8j7nQyJEo7xMaTD79Z2t9rka
	nGF6dnDMpsaphOtGp5ydDw2mKjGeL/ypoVm2BlSMRvHBWo8AI0fjrYJWAay+cEQkhiWaLcKDcni
	z8oQ==
X-Google-Smtp-Source: AGHT+IEkOxWVQSWldQc/gAwbJEjuX6oOPBwr0g1WUs0jQjHOfnCn6OF8lZVM21AQiTMGEA1gGzxfjQ==
X-Received: by 2002:a05:6a20:9144:b0:334:3a1d:536 with SMTP id adf61e73a8af0-334a8536f36mr26023352637.17.1761100069036;
        Tue, 21 Oct 2025 19:27:49 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e2247a7cfsm940817a91.11.2025.10.21.19.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 19:27:48 -0700 (PDT)
Date: Wed, 22 Oct 2025 07:57:46 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: tamird@gmail.com, Liam.Howlett@oracle.com, a.hindborg@kernel.org, 
	airlied@gmail.com, alex.gaynor@gmail.com, arve@android.com, axboe@kernel.dk, 
	bhelgaas@google.com, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	brauner@kernel.org, broonie@kernel.org, cmllamas@google.com, dakr@kernel.org, 
	dri-devel@lists.freedesktop.org, gary@garyguo.net, gregkh@linuxfoundation.org, jack@suse.cz, 
	joelagnelf@nvidia.com, justinstitt@google.com, kwilczynski@kernel.org, 
	leitao@debian.org, lgirdwood@gmail.com, linux-block@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, llvm@lists.linux.dev, 
	longman@redhat.com, lorenzo.stoakes@oracle.com, lossin@kernel.org, maco@android.com, 
	mcgrof@kernel.org, mingo@redhat.com, mmaurer@google.com, morbo@google.com, 
	mturquette@baylibre.com, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, nm@ti.com, 
	ojeda@kernel.org, peterz@infradead.org, rafael@kernel.org, russ.weight@linux.dev, 
	rust-for-linux@vger.kernel.org, sboyd@kernel.org, simona@ffwll.ch, surenb@google.com, 
	tkjos@android.com, tmgross@umich.edu, urezki@gmail.com, vbabka@suse.cz, 
	vireshk@kernel.org, viro@zeniv.linux.org.uk, will@kernel.org
Subject: Re: [PATCH v18 14/16] rust: clk: use `CStr::as_char_ptr`
Message-ID: <rd2jyc57e5p6zjhypnxkfnjwsnihs5tsr7r55qnuwbho5jmkxh@53grgiitw725>
References: <20251018-cstr-core-v18-0-ef3d02760804@gmail.com>
 <20251018180319.3615829-1-aliceryhl@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018180319.3615829-1-aliceryhl@google.com>

On 18-10-25, 18:03, Alice Ryhl wrote:
> From: Tamir Duberstein <tamird@gmail.com>
> 
> Replace the use of `as_ptr` which works through `<CStr as
> Deref<Target=&[u8]>::deref()` in preparation for replacing
> `kernel::str::CStr` with `core::ffi::CStr` as the latter does not
> implement `Deref<Target=&[u8]>`.
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/clk.rs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

