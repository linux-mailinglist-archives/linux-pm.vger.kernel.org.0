Return-Path: <linux-pm+bounces-28520-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BB0AD6531
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 03:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3767C3ABF08
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 01:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2494E136E37;
	Thu, 12 Jun 2025 01:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aS8zANfF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303AA13AD26
	for <linux-pm@vger.kernel.org>; Thu, 12 Jun 2025 01:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749692539; cv=none; b=U1UNlkkg/I8A61/r6lVfd2YAK/W/kRLUVBeoMhrzFD0ao+oCYDPYsMmkfCxv/gZ8rW+TROJtLMTT6G7P4Kp2TQtkwNg1tE4WzFsAtydXnltrAZI6cDFb6eRrSdRZGMOHc2YOAlkGWJVFseszob9A5v4McGUtrEo9qvAK551718c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749692539; c=relaxed/simple;
	bh=yekqGRUYYLfu4rmZNRUCu0QzvWyE3YgMNmc+9ucJ2S0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5IiPYg5MOIer5SodFflP2Tqts7e6R8Uz4ZDMTrn5SOLzVoGjCQCI1TQ7xTg6CX1MRqiO5KlZV7qa1nRsCyrdjtN98ADwPrShukfnN/c/vu2DnLahKddQkIWfPZ94YnVDmMbD9ZYnMj2KX7maO4fTVj2srhDXRqaxv7lZxmgEPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aS8zANfF; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2353a2bc210so4152035ad.2
        for <linux-pm@vger.kernel.org>; Wed, 11 Jun 2025 18:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749692535; x=1750297335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6GMTYoO/hH1xieNN1bEgiAsAF7Z3yvr8fWaDaLPOgs0=;
        b=aS8zANfFOoewlnHoxS75gB9a2NKvfc3aVwtpEuYLvBRkUgLVdbajvUugYuQnlpiNgX
         O1vKvdtO31ytv5O8Mpv6Revr0jOt5r0H3cQboSyBx5UpHSu2FM7rNHau145oNwt24JgM
         SuPLRI3E8lOxkoeS5jsYVmwIEgpwgtHa1VWEqgKk7D5ZtMSX3gB4Cqk71BJhAsNiyXN7
         dX0Z3h29YqnKsTl0q3Gv+PLrMWZF6BXjyYldCXIP9LmhSs6CdjrHtCVjTwZqVrkYp5S5
         W+ktguZtboDEG+3XOVE7id4b+mzh+bJz//xjj3N8qzHy7CnlD4GLKsYG5jWbJ4wm3aZo
         dfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749692535; x=1750297335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GMTYoO/hH1xieNN1bEgiAsAF7Z3yvr8fWaDaLPOgs0=;
        b=cglvu6+c8CI1Af5iZJYM4tmGoGpbLxijHMWTULWkVgplMHLqmr1jnwPD/rxfmwLRS6
         rNExiqG9VPX0IYcuq+1kPBgFvzGYq4ZKe1oudCMVyWIw+nxM0vcYg87RyBUxSWVbObLz
         EDxsQUoCJYUw+Y/aCFKrS2gIi80NptFMBsEIV0fw38yojhjZ4Hkv3imcg0XRSzZqevbU
         DY2uhY06O5fEh6xa2zi8MTXdZCg6vUG3Y/l0Pa/cHAsacmaKCOetJ3w6zv75ViLX1DAU
         mzG91WCBEfJDKvn8ysLWwlT6vMRYdhhETGmOK5DseY3OscbAWdzz8u1SCGL7QaVRKHH6
         31Rw==
X-Forwarded-Encrypted: i=1; AJvYcCU/jYE440Yq13Qxa0kSjdg+hJjH+BusOBo953Jizdnp2qKSUxSAVzbzhZnd+ct+MqO13eqnviA0XA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrPaDA07uEz7Ewpz7ScdW4RTXfWCLE/vpVZenHCwnPeEM/7FWs
	AYCLJFJEDU2336UzDGA/+CnNX5TJWfqyKlsxOyOfI3+vLKqD685KRx41maIyFRY8JbQ=
X-Gm-Gg: ASbGncuzWMokvQ70AbtIoFgo0q0OhiTdVmvRpA0U7DPFKJyJ7SylC1fSb8lX7pzdpD2
	Q/6ssuCVguYMMk39gQERuAZW+21esrcCg8nLM5BlWQ5UE0Fzo0H5zKMJwut+jPoz1sTLVL6gqQ0
	e7YOfex9c10w5o22HoyOKxBA3MPvgMMGIzYcuPSaZxFMQoLem/LkTA7My5834OTqhDIS4cr1Ihd
	Cl5HWWgZdkJzfLgddUG57fiYs6E43Wv3KJqIX2lElw9pbbI+3s99Omnh1L0s9aoq7jxoyy+x39T
	HBP0iN1a+A2HJq8QcvdAhC6HunfXQOeqCZqNdUhd4VOsWCKWPkK2tiaLjX6C2es=
X-Google-Smtp-Source: AGHT+IEYQuQrQ9pSkTkNr1pxDJTIIU0K6qyK009mvjKSvoQj1EO38HYFTD6dT0wcT093olcResSw9Q==
X-Received: by 2002:a17:903:2346:b0:234:d2fb:2d13 with SMTP id d9443c01a7336-2364c8d1932mr20654285ad.18.1749692535270;
        Wed, 11 Jun 2025 18:42:15 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2364e7195c0sm2365445ad.209.2025.06.11.18.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 18:42:14 -0700 (PDT)
Date: Thu, 12 Jun 2025 07:12:10 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Andreas Hindborg <a.hindborg@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Yury Norov <yury.norov@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>, Nishanth Menon <nm@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH V2] rust: Use consistent "# Examples" heading style in
 rustdoc
Message-ID: <20250612014210.bcp2p6ww5ofvy6zh@vireshk-i7>
References: <ddd5ce0ac20c99a72a4f1e4322d3de3911056922.1749545815.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddd5ce0ac20c99a72a4f1e4322d3de3911056922.1749545815.git.viresh.kumar@linaro.org>

On 10-06-25, 14:33, Viresh Kumar wrote:
> Use a consistent `# Examples` heading in rustdoc across the codebase.
> 
> Some modules previously used `## Examples` (even when they should be
> available as top-level headers), while others used `# Example`, which
> deviates from the preferred `# Examples` style.
> 
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Acked-by: Benno Lossin <lossin@kernel.org>
> ---
> V1->V2:
> - Don't change the header level for the example in workqueue.rs.
> - Update the commit log accordingly.
> - Add Ack from Benno.
> 
>  rust/kernel/block/mq.rs  |  2 +-
>  rust/kernel/clk.rs       |  6 +++---
>  rust/kernel/configfs.rs  |  2 +-
>  rust/kernel/cpufreq.rs   |  8 ++++----
>  rust/kernel/cpumask.rs   |  4 ++--
>  rust/kernel/devres.rs    |  4 ++--
>  rust/kernel/firmware.rs  |  4 ++--
>  rust/kernel/opp.rs       | 16 ++++++++--------
>  rust/kernel/pci.rs       |  4 ++--
>  rust/kernel/platform.rs  |  2 +-
>  rust/kernel/sync.rs      |  2 +-
>  rust/kernel/workqueue.rs |  2 +-
>  rust/pin-init/src/lib.rs |  2 +-
>  13 files changed, 29 insertions(+), 29 deletions(-)

Miguel,

If you are okay, I can also take this via the PM tree along with my other rust
fixes for next rc.

-- 
viresh

