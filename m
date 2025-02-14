Return-Path: <linux-pm+bounces-22057-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 453BEA3555B
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 04:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1D9B3AD154
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 03:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708DF1531C0;
	Fri, 14 Feb 2025 03:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NK5AKkm/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E401519AD
	for <linux-pm@vger.kernel.org>; Fri, 14 Feb 2025 03:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739504168; cv=none; b=cknDRdcIS6ISpMv/JAGvmQ+VHb72M+y9hY+Vvp5kA52wsI5Hc8g3nEm5j2/5wq7uyqqpBFrUVtG3qxa2nzrTtw+jUNIc6DMBFp2DbOvncX0rDDILfN1gJnxbriwO9LbJS3vhz74GocOujtNG5UQ792v4A2aCkmdFZhMrA5UX46E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739504168; c=relaxed/simple;
	bh=vMKEor5hreZ1dlWbtETrNJW5GK3fo/uguUnHcn/DwL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGlLEnOX1s/DMuOZhgo9bsko5r+LGmwRJ1ZEIVIBJAafTGZSKhmmr5HD78ukiMof/ksPrCRIrl4H2sexvMx52gVFTPINsZMbbHl5xVDjHjQuJXGZcfPXgmXeJq6a2eBhcNFGj7waDi0Y+7xnhm+vLCWl6N77Ly546rYFKJnkvCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NK5AKkm/; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-220bff984a0so28089755ad.3
        for <linux-pm@vger.kernel.org>; Thu, 13 Feb 2025 19:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739504166; x=1740108966; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qJWOFTUzjczTlnRMMm4MfirAqHPejhZpCYaLI3jfPow=;
        b=NK5AKkm/kfGVQsy4ZRu1tBryOatgarQyj+WpJst2003iPbLFKbQC3ja7QoOTyNaPV6
         0zTcb/iWTqU+icCsz0pR7dyA+wVqgzEDQJTAxXeXoz0/324733ShM4sO4HbOnEdehfOE
         k2Tkl4xwMz2B9pjd93r9mnF2sbTei0ge2dMepf1E3mxSOVW1oMgsUTeEIBk5Mo0ztPax
         iVADuEK58d0tzU+dvLeXmzsim0kmbE5sSx49CS6du7afo59Sxhrm2hRxy9BS5eOaVqm7
         6ntppZX6KGkDwsY9F6f7HR6QBFkokmaoBlb4gN27aRXBgRSoCK6ANMJUGgwrIJ/jH+jF
         XElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739504166; x=1740108966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qJWOFTUzjczTlnRMMm4MfirAqHPejhZpCYaLI3jfPow=;
        b=oXazCsOgSeZCEAA1cFz1CbR98F/Gp0R8cFpdhVJAkqGApwNFIY8FtlUzFOTtL8rXRZ
         dzl267XOdQxLMrX129C+clQW0B46ckTWhPynlMMSHSHPVZjRWBwDsoTd0A8UvsLlVEub
         RcaFMl/hhN+H7gaecftVZoFQ8fHvdR9CsCu+1P86RsU2zmdJpVC3NzrIlLcu4XuHqh4z
         3Aazng+FT8fPRltbqFezo/wT6YTiiVFT2UcKf5iHBZSMkyOBCrSuBM4YDi46btbN80la
         gvqwpnqm4a7Hq+MxuJKJieOBNjNMK9dacwVQeCTZWde+pYd5QXgicNw3aOvcjhpivj0E
         hIDg==
X-Forwarded-Encrypted: i=1; AJvYcCXkcZWlFzNbTP8K1FhB5l6lnaE5nJN2I7IgdcepSzfVyLgBR8dqBnT74P3PBxp0IusKD+hX3LPb0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwE5ONcnKxTKWDX4bBIVUooxXD1/KNCOn9Yx/Fdwvs4vnpGHDvh
	h43xIPvRmuECCvQ0dq58vlNy4TlgGE3n+HY/Tt0cHsWUpjhgbflX5JKORd34XJM=
X-Gm-Gg: ASbGncvkrTxfGVpqKItn/5RCnP1JPL5ZNHwQomVqyIW5fg0cjy056tcUiR2oXwe2JV2
	Su8c4rKIpGnVbUjxPhkyDrHZUmdGvHE9eieb0B3KZBwwIxxZFTmaeGt2LOwQ2U6wMkH4Zu7cPm9
	wCnI+8jNrX7WF6AtAcKcpm+5f1KiPs/L08DqlBO/xdvvSpMMWgrBkPlKZ6FPUewnnjWIssMQIQi
	dRSw3zyDH+zKozCmgn3qzeb3wc4gqyI9tbR6wnpS51xShukYQI6npZ6dBB2SvCmuoNNZr3oe1o2
	1+MyDpjjDLSF2p6hQA==
X-Google-Smtp-Source: AGHT+IH1VH4H6wqh/ikwjcQenmn4DFt2gxLMOXV05N/JZrNUG0kmpRxr8eP2IrIjgic5np9r8UgFDQ==
X-Received: by 2002:a17:903:2f89:b0:21f:3abc:b9e8 with SMTP id d9443c01a7336-220d215943dmr95010255ad.43.1739504166134;
        Thu, 13 Feb 2025 19:36:06 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d093sm19929755ad.128.2025.02.13.19.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 19:36:05 -0800 (PST)
Date: Fri, 14 Feb 2025 09:06:03 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 04/14] rust: Add cpumask helpers
Message-ID: <20250214033603.wijovkici3rutock@vireshk-i7>
References: <cover.1738832118.git.viresh.kumar@linaro.org>
 <db0166341ce824c157d0c58c240b3efc6aec6f6e.1738832118.git.viresh.kumar@linaro.org>
 <Z6qTelPSqpFk439l@thinkpad>
 <20250211042908.nyftiw7gtxosfjwc@vireshk-i7>
 <Z6t51xodSV21ER4M@thinkpad>
 <CANiq72=3MR9F9ur-aQYP4P81RBreAr=UiGg5iaSuFjjd5Q4Y7Q@mail.gmail.com>
 <Z66oWuLwY4X9Ou9D@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z66oWuLwY4X9Ou9D@thinkpad>

On 13-02-25, 21:20, Yury Norov wrote:
> I'm the right person to look after rust bindings for bitops, inevitably.
> I will take over patch 4/14 and submit it separately together with a
> new maintenance entry.
> 
> I will not maintain any rust code. For 5/14, after I'll send my series,
> Viresh, can you submit 5/14 separately and create a separate entry in
> MAINTAINERS. Please make me a reviewer there.

Sounds good. Thanks.

-- 
viresh

