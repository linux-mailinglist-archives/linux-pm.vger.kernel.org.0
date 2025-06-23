Return-Path: <linux-pm+bounces-29251-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF85BAE35A4
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 08:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32BED1700F3
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 06:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08E11E5B7A;
	Mon, 23 Jun 2025 06:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u+oJqfox"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE6C1DED4A
	for <linux-pm@vger.kernel.org>; Mon, 23 Jun 2025 06:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750659736; cv=none; b=rlTRJIzZHWFJE9vkQkWdh0aocz4Me3a8blz8GBPZXxJraIjXV148nvnvWl9f8ljXa7QwMNeBH6nFDYqb/d3og/R7Bu0xc+4Pyar552fH7IgdnuRFMd74DMPEn1B3J20qqZK7DQirUTPTaDd8Uf6cNeDt3Rzpu9q8tTQoAU6HqkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750659736; c=relaxed/simple;
	bh=0GviJ4C43LDU6PSrh2071vRUi2rtBfBORn6lykbuEsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvFnMGl+dAca73KiAspENyWGpvH2TqK0T19ZbzUC025P7vnvxXKs/TUUmPBExaZCSsFZDR3ZzYjKSAIcp1kY3OMC5fsxYt/jvJa4cwEK1hxZDiLkYHusnYfn3/lcm/MHHkP9zo+DqQ3e+0Q/U959mytcm/CMAttyCFIN7B8DuyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u+oJqfox; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3137c20213cso3796483a91.3
        for <linux-pm@vger.kernel.org>; Sun, 22 Jun 2025 23:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750659733; x=1751264533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZjaVo7z5thcmzA/Idtk2W4NhEJVEWcJtCaNKpGwgS2c=;
        b=u+oJqfoxE1BDc1eJwUUis1/T12Yqa9kCGnmN2ISJ6NGL4Y90YTjNpLcrHWi2vC7sRN
         V7k7BJyQhMSUMtHnH7VwPrTi0ApD257hQSBDPWlbwRnnmV8VWzNUqcZH8U11ZKU+pE6D
         hW1qhi+Kr7GNBRRFQi35gamyh6WI7ysOV4gxCoI2xvX0CiY24IsIjPSklaXOQyTBaDYC
         knHRmrkvJebx7VBrgNq6a2PDzN/2Bx/t52idVdQU1St5ukmK1HArRMG54H3zBrnzHQV4
         QECnIgveaWKpT8qVfotGB5w3LBcIoVxWX+EHnrjCPB5r7gRk42Uw1BMb7mGARpZN5WKx
         mqAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750659733; x=1751264533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZjaVo7z5thcmzA/Idtk2W4NhEJVEWcJtCaNKpGwgS2c=;
        b=W971SSFI8iG3wYEZSEW+icGDefcjKeTZh0dgSVG/ya2IdQnZn/IXLRkl8PqocOW3b8
         92f/6woEXRr9/f4GQYTatvxKBqWS9IQcp5yuJXM8LPqvfTmeHeBpRt2TTU7pDYuZQZFe
         saTgdC1+COo2KGoTWOO5aeDdlijdfqrPtcSpVlruGDuN0+f4cM3/gDNakThhGiKsPWFx
         ISA9EV0VLMcr+8R3tgiLlcfoV2yRngtK5nmMe5lVdkHRCWiIDu6ZbmmyWDPLYej6dXUx
         PWhRG4esKz1Zmkm0NymWl7ldC6gQB01q6ljDNP4snEOgsCmVlWZEpqKr8M35Es1u97L/
         TJrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVo92hsL6c9Vy67MeLTd5aQNKCHJ33ZTMFu9DCnlfEZxEr/LGppxUViwayC5Hhsw1XBIxz6BBwuVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLrhpPSK0FNedU+sXepcUuMko+f4pulY7fYbsU6dwy79Vg67ZD
	LaobyriqTUjxJ9Rs2KyS04RbceHTCbTTadDgpPNEb+00KAyWzCQrcVgB62LLt4KO4ls=
X-Gm-Gg: ASbGncufCDPKt4e0af9fVPPXnMhQ4gCr0fDanYj9RG3qm4zYM/kZpTUMK5CZ6qJPe+t
	Rh7WRS59i7+RK7lqEKBRh6eHLTqL+6rS3t7dVuxlFfAx4Y7EigQA3y8zG5ICP++z3tRsidA/fP2
	EtZ6l305FKZB3tqr3fvu7w499kNAm9+tK9k+fTW7pgTCIbUfSlvoJJ1PtR58tBMtpTHFUqen/5g
	/14emdbiPjYk5lr3pUkqT3xZPyIObETUdK772Rv88IMIIcQAZQOVmCkv73vlvp4xMQVZbjpyfB0
	1g2FlXAJqI+U5X+KDs7EuYIN2tetCta6iX4pa115elYR6DCQt+3wRGoQUCQCgtE=
X-Google-Smtp-Source: AGHT+IHTC8DDc643Bby1AguMJbpjpU8RoaZSO7asfpNMZjv5HFpnG7zervZfVFZEkHAcEV/Plpb2eg==
X-Received: by 2002:a17:90b:1fcc:b0:311:b0ec:135b with SMTP id 98e67ed59e1d1-3159d8d6282mr19886141a91.24.1750659733212;
        Sun, 22 Jun 2025 23:22:13 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d860a3c9sm75875175ad.95.2025.06.22.23.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 23:22:12 -0700 (PDT)
Date: Mon, 23 Jun 2025 11:52:10 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Michal Rostecki <vadorovsky@protonmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Jens Axboe <axboe@kernel.dk>, Benno Lossin <lossin@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	llvm@lists.linux.dev, linux-pci@vger.kernel.org,
	nouveau@lists.freedesktop.org, linux-block@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v12 4/5] rust: replace `kernel::c_str!` with C-Strings
Message-ID: <20250623062210.she33z5hfouu5jgj@vireshk-i7>
References: <20250619-cstr-core-v12-0-80c9c7b45900@gmail.com>
 <20250619-cstr-core-v12-4-80c9c7b45900@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619-cstr-core-v12-4-80c9c7b45900@gmail.com>

On 19-06-25, 11:06, Tamir Duberstein wrote:
>  drivers/cpufreq/rcpufreq_dt.rs        |  5 ++---
>  rust/kernel/clk.rs                    |  6 ++----
>  rust/kernel/cpufreq.rs                |  3 +--

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

