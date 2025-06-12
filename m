Return-Path: <linux-pm+bounces-28533-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE92AD6DB6
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 12:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0114B163DFB
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 10:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE22234971;
	Thu, 12 Jun 2025 10:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZAZH+8yC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEF322FF22
	for <linux-pm@vger.kernel.org>; Thu, 12 Jun 2025 10:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749724188; cv=none; b=tuGXx2iPojBR6NKLW8B8pWCFmHCRrN8z7x0VcCGXqbG5wdYcx78XchAYMvEoLvHjDJnMGkRJA9CeMcl6upDysiolIYlAAc7Zi9fZwxc3on1LTsopIABzzbY1DDzFqSsau3EYM4hvBKWyXdkveBUPUSGkJ4dHsZDs0opBGQ5EIHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749724188; c=relaxed/simple;
	bh=LBiZjj1c04h2wKgu6SjWXxVcIMRnF5MvTTsJHW2Ksb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e59pRKYtUQUhElM1orzboSBhKyjjcyiLAnVCNrdPkQQ2ZjM5bsTcBDAbFggKO01lqJIFrCxJzX1Al5+xhMIi+WgCJ8BLlEqCqtyYDEhIMxUb/cMyhPyiT0+wqG650s9ypnEYPxmwRHVHEzMLPRjiGYrHVdCV61nBmGYUTFV17XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZAZH+8yC; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-879d2e419b9so633953a12.2
        for <linux-pm@vger.kernel.org>; Thu, 12 Jun 2025 03:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749724186; x=1750328986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=djUr5zaU07dnze6b12sZ98Cx0swbt49r2vx4mVIURNg=;
        b=ZAZH+8yCPSa6m8A5OO5z0I+JsTAU0Y16O2nTUn0F+56+r4H3gZVnoAs43LeHeEbCeb
         UU1ENxbcN8vJW7HEkqhS377VhZC/Km7dSCLKUTzgmqpQ0KG/5J7pLYpGferDpDhSFNaZ
         cnDcxUrkg7pU8gF4FPVKPAtJpx0tWNY9mmXLaq1j+5gE6IHIBR84s5wB5IYhwBshbdr5
         i0KHpk8mZS2oginkAgTPBGveVcfmeNxyAg01OzNEOfwIAwv6arYqDiFpyCW+FvCXBkEw
         hFZRX+FKPwJpl1Ocp+Se7/g49JGvOL4Tf09aWrDf6rVJXIVu/pY0xVFJUa4CfQFZhq6/
         sGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749724186; x=1750328986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=djUr5zaU07dnze6b12sZ98Cx0swbt49r2vx4mVIURNg=;
        b=Oj+exjXqgkFOls8VBCVV4t3x3tioA8rdZAlDH4wuZKr3JeO0P7rUCQFtjTY36GQS7e
         i+N6EGEyxBvE5D63ZfC6dN4yRU6epjgFNtRCmG0zegiWGUZYKlhkLADRCQE46f4d4gcR
         gN7FN8iBuKybI67HEL6Cr2OuKncWtP8CwToCRLyf3D/7vS+LMGQ4kW//VU9ZqBWeXOGd
         aZeJcSOgYKnegZXUHU8SUagSPlmDKACX+jXPcPzGtUdTrfy9jr+xbHE/SV08901odhuK
         +LYVl4pvWUW6w7XkNqRpAQlsEWy6SbaSVmYAybq+rY0lYUwpMdecuL33f2umrnslL9nd
         mQqg==
X-Forwarded-Encrypted: i=1; AJvYcCUXd7jUjYjruf6sz+2LP7ewQcinfGjLcS9wvl0SoDj1DhwCB0n1Ywpvj05of0bkscEEpNpl3+FspQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1aFFd2KcZ5lPPlZbbvnJ+T3yaP5LKDx9DaeXOxpNajT1QstaG
	SCo5MB5cATslcqackshhb+wTzs2qPlQIzAONDPXpDy+CE0m1n6W+VaM1t2HvwGx3v9Y=
X-Gm-Gg: ASbGnctVTbY5xICyne+l5D0h/+Z1/4cHR0/vHM2EY8HyHHLJINKuKgav0ni08tbq/Os
	Z4cqVEISc5CbmVVbn8kioXKfbbadkTuiQa/t+rrU/CxuYp6SVZ2ADKPQDIEu7CYwvnGIQGszEbm
	QVpx1b/6JplTrOkV1For3TpLgTwryAexJQFO6lndeUKQ0IXQJtj6jQI7+yPNp3ok+uaV+dnF+hn
	9+as3eJsBIv2mcfEY5Q1poz+bP50391J8PoQjSfdonbdzuTubtYCsIzWgKXYbKLTCuKsP2jwMMI
	Uo6/+SanIVfCtAhn/RgoPBiCQidRlgRAsJYvIkFDJfLQkBNemJX5SnEVcLt0mqJIGcuqR6QBoA=
	=
X-Google-Smtp-Source: AGHT+IGj6zH2i6FSYnQuoWZbvieZJ82el41fbjoepfDccYSCZ6jY6ZrPdhwat+GRxvtW+AAp+Hs2QQ==
X-Received: by 2002:a17:90b:4986:b0:312:e618:bd53 with SMTP id 98e67ed59e1d1-313af1e44a0mr8462248a91.26.1749724185738;
        Thu, 12 Jun 2025 03:29:45 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2364e61b4besm10717505ad.27.2025.06.12.03.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 03:29:45 -0700 (PDT)
Date: Thu, 12 Jun 2025 15:59:42 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
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
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH V2] rust: Use consistent "# Examples" heading style in
 rustdoc
Message-ID: <20250612102942.iqdqmu3dolmgtmio@vireshk-i7>
References: <ddd5ce0ac20c99a72a4f1e4322d3de3911056922.1749545815.git.viresh.kumar@linaro.org>
 <20250612014210.bcp2p6ww5ofvy6zh@vireshk-i7>
 <CANiq72=m+O7p==Fte4HA7kmt0DKaKmkeAQ-J1kVtyTKDKibgcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72=m+O7p==Fte4HA7kmt0DKaKmkeAQ-J1kVtyTKDKibgcA@mail.gmail.com>

On 12-06-25, 12:22, Miguel Ojeda wrote:
> Do you need it there? It is trivial, so it probably does not matter,
> but mistakes are still possible (like it happened in v1). Since it
> touches files from a few maintainers, it would be best to put it
> across the "global" Rust tree (ideally with their Acked-by), and Cc
> everyone (e.g. Tejun added now).
> 
> I also have a fixes PR to send, but I was not planning to take this as
> a fix since it is not marked as such.
> 
> But I don't want to delay you. If you need the changes, then I would
> suggest just applying the parts that modify your files, and we clean
> up the rest later.

I don't need this for my request. You can pick it at a later time.

Thanks.

-- 
viresh

