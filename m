Return-Path: <linux-pm+bounces-23009-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1752FA466B9
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 17:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D15F42747A
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 16:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C3C21CFEE;
	Wed, 26 Feb 2025 16:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRZId4xf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D53220694;
	Wed, 26 Feb 2025 16:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740586658; cv=none; b=XO3E0PnoWYQ52msUZr4sT+fZyeAehpRJyP5S2Qr2lfzSnZ799pmCCkfhNzwAj0YA5FQ0sZEJk/xIp8aZI4TnDtBzHrB/zv8RpPmCPui8XdOeF2QXAZ/BcLdIJ8Cj7P0GZpKNmnM55OAmREGx4Mrd/fWyUFFbQBaZi0LB1+rAA4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740586658; c=relaxed/simple;
	bh=p+rEInh5x8k2va/qGDSY6xNcd5VCL+2UkWvotiVe6qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8ctONfR1cttyOL6QCF2gXLfPOuBNSkrlzdZjlzAJrPBP3Tqm/G52SnNSLWCkdTbFoY95Bh956kY4xVovnKBE7udAZcA0xb6A4aYT6QZ/bwuRgY5wsrZ3H38q9NwXmP+GfMEM26Woof8O32NxnIiA3M9YlcStr9tBGjg955fa78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRZId4xf; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2210d92292eso59403675ad.1;
        Wed, 26 Feb 2025 08:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740586656; x=1741191456; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pqqE8TPgTHo5XiZCNnju5LBuzlT14gu1LDeKWI2DZxs=;
        b=hRZId4xfsql6WdscV+LYmHCUZmUbcOd2xezQ/m4RZ15iY0KYeEySCqPVaIOfi7Sk8z
         CfIZBx6QvrNR55KN7uchbz6v6tUQ7P00asakiBESHLWBiyfIoXUYepCfeiFOnxFkd4Xk
         4XH0nSu2nYYXCtbkCawiarnllvl4HBB2W/YFIaLeuWTtyOqIQJkmPv0xt+wYIMlBDO6w
         ceM7H/R1VsNmzzpni1CV0i20hqyfxdp1BMHiIZfXvmvflBmfVm6MMH6P9lwKJWRNE4Tt
         MdBED0QasB0LETe+kM2VC5rufwk9E627fnAwmjyBMvNoMeYyZBHGutGuf/wMNuEErErn
         oxYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740586656; x=1741191456;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pqqE8TPgTHo5XiZCNnju5LBuzlT14gu1LDeKWI2DZxs=;
        b=mqToQ3jkzf++urwNLphlfUOh+Zm/vTAfK15terux+R4NiHRZdswJRBN2JSwmf0AoMr
         7xhJYydN3azgLsrzx3n1e91LPmWSXgLQob8JYbeTZ8Om27G6ceoFjjaJhA2dNOV+61Y9
         Zsj+y/bgMw87Y7gsqreG5/JIOHCVBA1JZ5pMozjkqUqRCMQy6P+6JkG7nrP8pAON3y6l
         KJ4nlpEZ3wHq7nJIC9agkcsxTnM4TxyDBjoomt1uK12K9LbfdmLsZeMWg3h9OlM9bwk5
         3f9cIu4PtyVk7LBxWIvhX6kv0ee52pP7aG14Vlx2gPpFpnX8jX3n65xn6NOks371xx8n
         ZR9Q==
X-Forwarded-Encrypted: i=1; AJvYcCViPbhKUHCuyX9W6IECjOU3l+PuCJVMHCl51xaT0xc3ymcTwPvVPrE3PN2YZhdt6tiYEkZEj5HbiqYPgTI=@vger.kernel.org, AJvYcCWrODWSJIJCLJ8itVQh+eoHxEYmmIMZysLyG2C0NE9uj8nBMgtrZIVy12srDLZlKdjeZ3LbudRv8VN4IK3tTw8=@vger.kernel.org, AJvYcCXlLPL3FmIhv7YKhBv7DvzE4Z0oA/m0SzJ7k5nt+Qe9cLO3+40N4X54xI+4IggkxMDxjIHL9j4bdEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwp185e9Y5DO6kNGLgMzbT5L2vfbMkEQEVk6Z2BlN3pSOPN1TN
	tu0oAQ12akS79M80j/J2chAuHu6IRPsfTEzB9/ZjHzOdda20kMly
X-Gm-Gg: ASbGncsgm12W9iEdH8wAeJKtLVNexvJv80Snk605qivod0uqF34lNmj5bogmb1eZrzC
	4ykMFLEIxHUPw9PTNSVWN6w9tv4xhQ4ZPmNNpT20JSiruj+r/KgZxctPzY6EbFgRnahwFnDQx70
	ir6rjsyyzpys2XKoL53nhU5B4d/582GZ/7OOlyckDSh0hTcTsCAEyXPzEFNREzRf78OJj52KZ7v
	nu5sbqtjp4XZJdyQ4YKMYAaraWp0bPHOBQ1GDno/oE/WLdOZMMAHyTlk5U+jvfrZLae9N+6TfAL
	BkfXxRUzWadzZRArUqeB30WR8NSDFxeeGGV8S0Lx/59FlbTQAg==
X-Google-Smtp-Source: AGHT+IH8h2IxG3eh4Z6IeNx2FDs2WI0YxImOCdZZjE4/c53o1KddiVOiXptTcTDkc9A7LfuRetwA6w==
X-Received: by 2002:a17:902:c951:b0:215:431f:268f with SMTP id d9443c01a7336-2232008266emr55812535ad.10.1740586656347;
        Wed, 26 Feb 2025 08:17:36 -0800 (PST)
Received: from localhost (maglev-oncall.nvidia.com. [216.228.125.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2233254efacsm13220145ad.230.2025.02.26.08.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 08:17:35 -0800 (PST)
Date: Wed, 26 Feb 2025 11:17:33 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>, linux-pm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rust: Add cpumask helpers
Message-ID: <Z78-l1wBYk7nlR5i@thinkpad>
References: <20250224233938.3158-1-yury.norov@gmail.com>
 <20250224233938.3158-2-yury.norov@gmail.com>
 <9E7A81AA-6460-4F87-942E-2EEA145257F2@collabora.com>
 <20250225095054.fp5xdolezdh2yalc@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250225095054.fp5xdolezdh2yalc@vireshk-i7>

On Tue, Feb 25, 2025 at 03:20:54PM +0530, Viresh Kumar wrote:
> On 25-02-25, 06:43, Daniel Almeida wrote:
> > I don’t understand what is going on here. You apparently did not provide the
> > Rust code itself.
> > 
> > Usually, when I see a “in order to prepare for …” I expect the actual patch to
> > follow in the same series.
> > 
> > Right now - and correct me if I'm wrong - it seems like you’ve essentially added
> > dead code.
> 
> Rust abstractions:
> 
> https://lore.kernel.org/all/cover.1740475625.git.viresh.kumar@linaro.org/

Yes, it's a dead code. 

Cpumasks is a library, and people sometimes submit library code separately
from their main projects, so it becomes unused for a while. GENMASK_U128()
is one recent example.

I'm not happy about it, but I understand why people do so - it's important
for them to have stable API, and their big project may take longer to get
upstreamed.

So, if nobody's strongly opposite, I will move it myself. Alternatively,
we can ask Viresh to take over the patches and move them together with
his series.

Thanks,
Yury

