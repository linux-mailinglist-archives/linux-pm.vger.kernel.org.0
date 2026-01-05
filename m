Return-Path: <linux-pm+bounces-40173-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 185FBCF1D62
	for <lists+linux-pm@lfdr.de>; Mon, 05 Jan 2026 06:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E089300889E
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jan 2026 05:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6032494ED;
	Mon,  5 Jan 2026 05:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LpocV50H"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195B41D9663
	for <linux-pm@vger.kernel.org>; Mon,  5 Jan 2026 05:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767589301; cv=none; b=f4xNxZ0eZBC5mKx5+tDGqO4mx9oPcqm8qhvvaTYYD59LrXV58IvqcHHFOqwGNDUxoVSCoTIR9/iLNdiPtTNsA6lHBXqcgn1vznDxoSH9Wqb4O/mS90Qha6JXfmyfPEsph2xtOLH4+NARYZRRuV+3j61olg8lE86KGFYnQ1kA50A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767589301; c=relaxed/simple;
	bh=bOgzM3bvThcr/PL1q+HHJz7YTcppqCfwWatkCNSbNko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VD5vs9hxjJ8igYPBU/2EXTpOVl3qC2ZzvsRZxKHb9vo96qbQqpq7ia2iuTNjor0f3Gr4yBsK79Kn2VncumRu44W3LNnz5Xv1cJ0937vNMWarD3J9ukKG0LA3mxXhB7zsW+VHVjnP6MYQLGBLCJRZ2EAf+DVYRCkeKepPETOq+8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LpocV50H; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-7e1651ae0d5so10461708b3a.1
        for <linux-pm@vger.kernel.org>; Sun, 04 Jan 2026 21:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767589298; x=1768194098; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aZKO0eB3ugHv1XJFcKwPh1TEGqr93QeMnjxj+W7yaoY=;
        b=LpocV50HToVX1UqIqzGzoojy0jKyFSmnJwDn+4qd9bIUUOJjtQqBZS776rm5IMFRkT
         Cmbxk1oeFTUGWn1Xmk7xIzcq0TsRd9x1YmcrUYGuM+axC3+V1RruXTQoSBENuSR8D6qu
         j7PZj6u3jHj6sCDF9S9UgHN1CP50PYzMNoHWYvx8tKzWxjEVRXS+1RomcDx8NeycWYlr
         /jhbYTzbK49y/EL+42NLLhnHThICbwPYIShvceeKKOTDus7YBev8l1aea/momv0Zp8kE
         nj029jIR3ZMiTZhCc/U4RChmgz6RLa5sZbWxpfCtXdr0f1p7iRb7zPThM2QRjRZ/9Ae8
         C8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767589298; x=1768194098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aZKO0eB3ugHv1XJFcKwPh1TEGqr93QeMnjxj+W7yaoY=;
        b=e24wpBuQ8r4V4vPCT7o2V+vg/v/ee8UkOEgrpexWjMwQ9Xu6Vyvczyocki76+3ijPs
         tlLQAmt9CpT86Jdk+AKQRIkaaNStHnPAyhLL8MvHgn1BDe9dTAh9s7+5w8DNk/K6Ijev
         x9EmagFp3YkuM9xYka8xdPk97KTJuOnXV1TqtoK6iMjhM4v2jJcWNadCUNhJSS+tLjqc
         oiD7y7yFYI2hKzu5IPYYt6CM7GGKV6diHsYaELM7qhwyBFr6/Hc1VDPPquc1NuCZXLo0
         r4RMXpiLtreMtvBb9HqxubD6FBBevz7ZtXJeYVVboae4C4fEKCvVo3OXXZ5HXqZvrT2B
         RqSw==
X-Forwarded-Encrypted: i=1; AJvYcCUBIb+b9lJalH1ZbYPEoIT7gontF8e3g2JUKmnKEVTIHhY6SVOLTwWHdSrVrVjFQTYCtaZogmkPiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLbnNXmIsN6AQz4ePzL848lvShUG2Vby5f27zOP5HUvkat9fLS
	ueUbRpVDYiMNtOYMHWlfdTzJ57RMV2CPBxJtIghHS7Bnxy831z/E+lfpW37QJMb/gE4=
X-Gm-Gg: AY/fxX46ZJ4aT1dGGn8vAOZLcKJFehhRFlCL3tmZa3KuowTSq4fWXR0vdsOd6Ze8+Or
	qghQLHvM5fALdA7RwuWcuVa7JSJYGcENlo2mvg2t0y9L+8TKJODs4ZVI+JSUFTTlc1xhjDYmks9
	Kz2RxRj8OTe5+OGFNqPUPZgoFFksiei4jR+OWiGeoICRB9e4HfV1gjnTwFUyxQe/dNmLg/SLVCS
	ZkxB4cP1vtYrS0V0f+mZRsm/vmgXiaU5bpAoAH7mORt+84YwHjBx4bg/ENMCX0o82FUIxv07C+v
	jvnrdl8FBY7JqYQCq1bZyzU4UGXDjdFQGwyBIJXRL2UVZoHoB9B1o32ozRc687KBESdGvaeEAnz
	xRgPAxGuNoFsLobExLydgPecnzmk4Th6I/iyQvtaoMErKJ60/EHz2b6e/2d+kBokwKZmN35cwBH
	UFcnuF8lBqBJU=
X-Google-Smtp-Source: AGHT+IERB4/fG8UikeszTNDBmlG8rNFg2rlgQaYzzWQKOuSq+0vtIqjVkr9KgjSkflu3ZWHVKiRaDA==
X-Received: by 2002:a05:6a20:4325:b0:35e:5bcd:8310 with SMTP id adf61e73a8af0-376a7fe52f8mr41359422637.32.1767589297954;
        Sun, 04 Jan 2026 21:01:37 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f476ec31dsm4911064a91.3.2026.01.04.21.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 21:01:37 -0800 (PST)
Date: Mon, 5 Jan 2026 10:31:33 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Tamir Duberstein <tamird@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Tamir Duberstein <tamird@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] rust: cpufreq: replace `kernel::c_str!` with C-Strings
Message-ID: <62mbftgf5cvvaelbtnwjclimyzi7lpmxxlu5uqfzqrkzja3efn@fgijwgonqsp3>
References: <20251222-cstr-cpufreq-v1-1-2d99dfc88cbb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251222-cstr-cpufreq-v1-1-2d99dfc88cbb@gmail.com>

On 22-12-25, 13:29, Tamir Duberstein wrote:
> From: Tamir Duberstein <tamird@gmail.com>
> 
> C-String literals were added in Rust 1.77. Replace instances of
> `kernel::c_str!` with C-String literals where possible.
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <lossin@kernel.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  drivers/cpufreq/rcpufreq_dt.rs | 5 ++---
>  rust/kernel/cpufreq.rs         | 3 +--
>  2 files changed, 3 insertions(+), 5 deletions(-)

Applied. Thanks.

-- 
viresh

