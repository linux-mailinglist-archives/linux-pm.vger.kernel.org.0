Return-Path: <linux-pm+bounces-28347-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C21DEAD312A
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 11:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85CD43B5E85
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 09:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EA21A8401;
	Tue, 10 Jun 2025 09:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WxskI7jB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532A2280A5A
	for <linux-pm@vger.kernel.org>; Tue, 10 Jun 2025 09:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749546312; cv=none; b=ql8/Rd9Vn04OTIHIZ/hmwF9deq1ZhAd+i937k+4t82y3DMOEvc8q7kLPp2Ddp5MDEAejktltrfB/H7gwIq/pFj8L02Tb5D3Lj1Xv2DV6Vw1d2Up+GG+PLZJ9d2L+hKJVy6VIpaEE8IzRk4nakQATX8hDSaDBPPDrDlQxSbAbwvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749546312; c=relaxed/simple;
	bh=3GM1WRqVYQXAazSmtHqVXUifnN2sHGlrFP+6YGCoYhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GaxBa0rm5mciFmr3ky3QGHKxZR/gB0NytVXSaIMVJUs5A7zxH3CqdeT/tXNceKOjojSnh4zYi7DSI2kzPFONt5yYehb2xkos2YEvVu9bP48XoOhHMV/hB8Oj3oHcAVE+jD1CApBenqHqLiUKLsaEghhyF7mjAqIngEFj45IWRZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WxskI7jB; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-311d27eb8bdso3204407a91.0
        for <linux-pm@vger.kernel.org>; Tue, 10 Jun 2025 02:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749546309; x=1750151109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MxpjoO2mYPkQZpQAdh6mmcVEOjQK1F3ewQIY1Y/f3Y4=;
        b=WxskI7jBlYVLJXQyulu04qcMectt4Trgg6Nk4LjbJt8g2h4vWZ2GRPeEbsmOrPi9JK
         YzpstdZ950QKrKYmEb6VAFH5/XcyWkq0D5hYAxGC+2N6UXouQqFZbh7exahs7xADUNo/
         H5AOZ/Uy+OtzFM/s3xyj3Wxj04nKze2tL5UyrltR1DgAmto64ZIIHYNOfqXQ1ayGthau
         VjO13WMzgd9v0SskStzsNi2JiKSzS0n0zBv+g0y9PnLNTM6M2yKDleYrtixyehpz6rFW
         vSCtNnVh7A2jdytMVmH/3xK44kzS7w52aPZpNi+4o40I+WhfQeeG0EyNZ0QyW+Ovdm0y
         vnVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749546309; x=1750151109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxpjoO2mYPkQZpQAdh6mmcVEOjQK1F3ewQIY1Y/f3Y4=;
        b=NuUKoqDVrK70aJZXIYnKvmadGA3eHWWHsGgfrWYvydPDC89nGDRrzbblDiQixzszaJ
         xkVJtnQADz09ksJsRvIqpdyVfes2WJLJ+Tn0Ef0T6du0XrjYf0ROviUesGdhR+0sPcd3
         JoLOaMl2ZysoVyBfeKTYRQXl3NEDMhA1DbFoGrzJU4KvAfmq2lP7Ha9cXjq6Nv2DC/2P
         3qyk+xjeAHYZxFFgTl9C/XG9mFLu7SKX/yfesUJKHQ2TQHOg3VI3D7srY+uQoy/xCnws
         msWmT89kcCs9Ad0szGAOI1z46mL9x5lAO9QLS4fxemsBlehb3PnDWHuQ18+aybNTjCFP
         NDBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIg7RMtZ9SRhtvaK/jgYlab1oVefoJuB+Une6oAcl0Wo1r+XZ0JbbJyvrHpKOB/JldLomMAEFzAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMvHPHi22yjcVfZ3ypypPbgGRxUa9QSzmTNoscE9P4hoClUs1H
	Geb2jnY1BKrdoSCrXgTDj3KyZIsZwm/As2ZZRMKRnYP+kG1q4kxOHxeVm1FFVfAsV8I=
X-Gm-Gg: ASbGncu9072k5DE/1qkdKQtkI8KcpqKLak3ebUU5yMjzdo9rm/KPnkd5CFBgJBugFRE
	t2bQZF1t/5OOztnVDomBZYEQPZAn6/hDIre/dTkbWPohmfKHzMXCNS2oiVFrGMhp+KIrv61oGH1
	KQwFv+Rd7KalE9j5Ybl/ldCw9+8HyoTA6WeTLEGYZ1svPdv5vdG0o2Skas5RDn3gIISSQChTJ3p
	1kSKOjM2LDf6frpIUZmpRFbLyPcfA0Y2CFZGqoK2pbHWdAiSNVVrFumu2Bo5F0r6k83h3cVy0jI
	W7Pa9LMtk89oXU9wsTIQzEkddnDl1YJm/wKN9+sL5g9p5EeBkSsoIgjwnC9BzbM=
X-Google-Smtp-Source: AGHT+IHHYZrKaT/gzmS9tsVK3hFeYuSn3Ec8BLsyZRN7hNdemDEI/1VCu0avcGXTkJj/JdBACM9Kxg==
X-Received: by 2002:a17:90b:53c8:b0:311:d3a5:572a with SMTP id 98e67ed59e1d1-313a15739ecmr2416667a91.8.1749546308712;
        Tue, 10 Jun 2025 02:05:08 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31349fc373esm6863637a91.32.2025.06.10.02.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 02:05:08 -0700 (PDT)
Date: Tue, 10 Jun 2025 14:35:06 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Benno Lossin <lossin@kernel.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Yury Norov <yury.norov@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>, Nishanth Menon <nm@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] rust: Use consistent "# Examples" heading style in
 rustdoc
Message-ID: <20250610090506.24lmdltnqldsra6a@vireshk-i7>
References: <70994d1b172b998aa83c9a87b81858806ddfa1bb.1749530212.git.viresh.kumar@linaro.org>
 <DAIQ4GUF8JGO.2EL4XVGRV06R0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DAIQ4GUF8JGO.2EL4XVGRV06R0@kernel.org>

On 10-06-25, 10:51, Benno Lossin wrote:
> @Miguel, if you take this, then:
> 
> Acked-by: Benno Lossin <lossin@kernel.org>

Thanks Benno.

> For such a small change I don't mind upstreaming it myself, but if
> Viresh wants to have a merged GitHub PR in pin-init, then we can take it
> that route.

I am fine with anyone picking it up.

FWIW, I have sent a V2 now with your Ack.

-- 
viresh

