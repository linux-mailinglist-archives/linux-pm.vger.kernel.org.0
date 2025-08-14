Return-Path: <linux-pm+bounces-32363-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64837B25A5B
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 06:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AEA27ABFD1
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 04:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5304A1F09A3;
	Thu, 14 Aug 2025 04:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pNbGFJM3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D1D1E1A17
	for <linux-pm@vger.kernel.org>; Thu, 14 Aug 2025 04:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755144914; cv=none; b=s1c1v2qxdgjjFI5fSLShSM3KpCTRD4vA/IAyRdB1ABHZWhsP9xeAYxH2C54WWYeThfllUCBR5qgqjcd1X+4iJo5UFVik5idEcDDSHNfXd7+XPXz6pe2g096c2YZBgG9IkePS1Bp0BgLUU6lsymMo0M5sVbfsEidmUZlZDVDl/zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755144914; c=relaxed/simple;
	bh=iHbUtFxOXhf7il6cDn7qoU0zrfBE97XzO4Li8Mythgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QdYWRZUL8Jn12uVxuHui+SrRm4judg6O2l3ijYisqQ+dO8scRE47iR5rrIMiUR7LA4ge5bzUOGZN7QP6Cjcr1KG7gD5hKHtDYx5mK7VL735fyOv/G2brwS35xgsUkU96nimMhC7NL1i70Q4wdhetGxd1CX0mqByDoOTXBcVuQRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pNbGFJM3; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b4716f46a2eso316324a12.0
        for <linux-pm@vger.kernel.org>; Wed, 13 Aug 2025 21:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755144911; x=1755749711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sWxfCtON1zed9A8C3GYhEYa8VInQ0SpyFdE2rQUbX1c=;
        b=pNbGFJM3r7Fp0rL4gKREFbOHswsDoHAePNGJ1kmjZ2X87eguaDnER+nTNt6Tn+kqYz
         TyHMKRLOPUsJwPAdUBWddF/nxreZkEBsgmoQXpel7GnXjJKoFhDi1NeX+XK4zu7jPMFj
         4N13aNme+MJgNqk5t5VcXxgz6eomieRPrZB9uS7npzTK/SgaTuYXbm48+kTI9G9aBuWP
         SAgeMgcEY54Wl0rTqoL9W8/xKSAEw5orXW1ZiAFIMA8qjPfRrg9BW3fiPrrgVOEV4PqR
         w288Q1XscVAC6jaQmOW67EyZ4+TyGSJ75vZODf3CKh1jJd8PeJ0PrFb/ZXCSEU/IjsCi
         bJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755144911; x=1755749711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sWxfCtON1zed9A8C3GYhEYa8VInQ0SpyFdE2rQUbX1c=;
        b=AVDygTUtGuB2bc+OKuz7dBD+uYjWJCvgUmIPzOuZB782kEZe7oS+XFmdAhNnaFwLKQ
         Kbnlj5pmr7MwWfPwHoAWva5JnDW/g/CkGuE0IUbZeHmBg1gQ0ZRKgkrb1tc0AxuB8K/z
         NZcaRswJgvUt8YtcuWgGtaRsujT/a7u3qP3Z7f89lzl8Qxh+xwCVHQ0J5zLYptf5dFD+
         bD9U52HQI8TDsFnqwnLklpJpKpz0fLhCNuMgEhs0DubaXOw820BUedUsXhz9B6VYO7xo
         KCxljjlUhnQU3I8eYvkyaOC7gpX82lyxZVj8z6C9V2YjmWGtL3fikBZDl1iw1xi0VFKN
         8C4w==
X-Forwarded-Encrypted: i=1; AJvYcCXWRRHaHbxw5v2mkrDJmAlEXgO0fLUxcG9NDcLXYvdc2dU/Dq5N/VJETdFLN+iav08/k2JsbcSamQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhrxAqxaQYfMiYcc4TNv9jBYri4Lr2DC3xQnUyn68VR0c6URb5
	WhzM99ADLqwZsNsr6/I3XTm6U87dT2L99YdynD6o+mo6DHdtqKryRpUZpXLbYGG794U=
X-Gm-Gg: ASbGncuVu3Vc3tLaIM3yAZlOtaU7tc6OShar/IvHiaAoRYRUO+hsLDKhAVwJAmJXzOR
	qb6OixWYztIsMWq8c8L3JLDB37DCRbccgd4cxay9M/FH6hvptpqsgleY3+FVIOFDIcRirA/nmJ4
	GFPJVTnSBb3U/pGBZmjqbYOCKsj8sLR1o02luUlk7u4RUyElgvoRqIBDSn3FffR6l82dulj1EPm
	MBBVx0T0c3RebOxMAzoPcnH1qkYB+R1U1ciPVpsCxerFjNEcgQeafVatIrZGUqRa2/v0g0EuhL7
	vRK0hQTyci5jrgCM/rANKtWUIENax8s5oVgtxhsJvZ8GYkoxnSm5kdLPQma6pKFpihQ53lVULIG
	dZCJCF7P+cY47Ds/5/ZorUt8t
X-Google-Smtp-Source: AGHT+IHt40bX0FwSrzcBQt9NOrie8YIvE0Bd/aZbf1eDUrCgWfF/cOlo6cUv942myCO6XkFRZpWJjg==
X-Received: by 2002:a17:902:ef46:b0:243:80d:c513 with SMTP id d9443c01a7336-244584c278amr22862505ad.4.1755144910690;
        Wed, 13 Aug 2025 21:15:10 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef6e45sm337724835ad.22.2025.08.13.21.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 21:15:09 -0700 (PDT)
Date: Thu, 14 Aug 2025 09:45:07 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Breno Leitao <leitao@debian.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Jens Axboe <axboe@kernel.dk>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 06/19] rust: cpufreq: replace `kernel::c_str!` with
 C-Strings
Message-ID: <20250814041507.sqkdumgaxfcalkhb@vireshk-i7>
References: <20250813-core-cstr-cstrings-v2-0-00be80fc541b@gmail.com>
 <20250813-core-cstr-cstrings-v2-6-00be80fc541b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813-core-cstr-cstrings-v2-6-00be80fc541b@gmail.com>

On 13-08-25, 11:59, Tamir Duberstein wrote:
> C-String literals were added in Rust 1.77. Replace instances of
> `kernel::c_str!` with C-String literals where possible.
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <lossin@kernel.org>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  drivers/cpufreq/rcpufreq_dt.rs | 5 ++---
>  rust/kernel/cpufreq.rs         | 3 +--
>  2 files changed, 3 insertions(+), 5 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

