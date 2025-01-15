Return-Path: <linux-pm+bounces-20458-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CCFA11AFA
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 08:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2729E1615A0
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 07:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B04422F38F;
	Wed, 15 Jan 2025 07:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KLky8OvK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9608F149C4D
	for <linux-pm@vger.kernel.org>; Wed, 15 Jan 2025 07:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736926520; cv=none; b=Yhl+bHN0WVDx0oTItP6cAjQhwmezH64YTAaCOIDWQpw+E/yF9BJQePX/2WK+f1Z7Ioi9um6ny3Mnw8t/dmACwFHXTkhRkA/eHtyir74kVUrDaRRKai4CC7P7s5BfkFVxTXbTHlapMDZqusWtbdLE6e0f4IRTGaodLZvLT1QIvgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736926520; c=relaxed/simple;
	bh=11VPTxtyMOy0jH306RWVp5Ck+NURrIO68klNa+MgS3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWfdWzaaBAOawCHE576flb7pwwmzzJdyOgueQ9TmPG9mrxgJIXuXmVVSL0A/dEDaChrUVuHBY1uFiWMpR5PM3jddidvc+FosJEO6AONGcOColzuc0mHXps+d5IXwaVeqF2DdAsrYuPjX7Shcv5ADcS71PtmMUu7o0QbBBUsqLSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KLky8OvK; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2166651f752so143972145ad.3
        for <linux-pm@vger.kernel.org>; Tue, 14 Jan 2025 23:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736926518; x=1737531318; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0NWa5KL8s6p5qgSV+6qKBun9f0W5BFFiHnMnLZXhgfY=;
        b=KLky8OvK+cUUR/7ez8HsCDuLIwp0vXjifW5RukXnLuo1Z7+YThQ7fAeiy6WlZLNHH0
         CCC69KvjUGLHML+D2EopJZYZNOuEOqX6Aty1SnR0XzUTMjOFUG81gySP878fxyIqXElx
         11pz/or4dn6+ivaM6CAN4AD6muN0Kub3XCpbsY6HupfE3bvKhRjDHMvZr8LXB/HXPhXG
         VbDbGlKrZDDkPRUhGfbuDYDQYn+royJx4INcN2l7MafUy2Log7bmj7On8fWT+LpP76wP
         U7Z3P1NM7nHhSOGkpi0cZH7fZk9SGcW3jl9F9Iqg+EOJr4HwcMFCNRmYfkBkUJakgTSg
         MvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736926518; x=1737531318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NWa5KL8s6p5qgSV+6qKBun9f0W5BFFiHnMnLZXhgfY=;
        b=d0BYPU1ajN74P72Ub7h5GzHmUobeUNiIlpIoznFnyWhTW8luneAxGmQpWHrU4CgZfE
         Fxza6y1/8cBhvRAQ+mV3BGWcWMqXG6CfBr6nYDBfS4ZRXGKSq6HfWSM6Zsv2nWpJ6jy4
         oVU5Fj9SzkotMRkyZXLNbY7oOtUsq5I5ezJYqxjHhVL89O16RqyMqqCb6D/KuSdurBqE
         wVu7XJcUdqvCV1KKGFbHFLuK6SOg+EfMBwUNqfYeAHTO1eRCHe1R7HJ52mz7FGuJBLoB
         4gR7xuslB/L8Q0EXuUYQEFHNSyRoeRkPn/3zOFv0sFrwZeRyU7rK/UPJ0yh1PLFZF38P
         osWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXj6reZvSMXGIAF8J61evDnUrYuXq9ExbX4Up/U8FxMT/+ccJYrIhmfDtcAsx5pTuO/cyD2Yi7PA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTOPLmUVzHPs0LDhKMURmVIF5qUPe3gN4F/sSJu6xlCCHCZD29
	vS9jrk8B2213gY4K2yV7GLHf5IRGagRNcfmJ6x1HlGNLhivkz0s/Ca+w2RlE83L2WSOQwNfsB+v
	0
X-Gm-Gg: ASbGncuY/v2AHrKQNbGmsBi0qZM9tHaPFBcVMu7hf49HsrJmWXO6tRKy1QewaAxcOEp
	3Uf0TV4Px2qetMyeeiSHE31bfqJlCfmrrxoQsdL7j+dtO+1xiXzR30++gkpE4ppGdFxWzuM9sA3
	2z+15hwnPcDNP3q3GbjhauFwlGJDRy54IzWdXc5QXY50Zm3ToFy9uB3TQam5fdDpMALTUWxDUyx
	rBKUbjRgUlAAgibeAkt9CVLZ3xPSghhIUKdbcU2ff2WtI12HYpiKixfcXg=
X-Google-Smtp-Source: AGHT+IEiNT1nLuxePVTdth6rqbDxmOGcOGriyBY9EmzmsE1Wlxp4xb0gRZNnWQTE9E2aYe+GUmmfLg==
X-Received: by 2002:a05:6a00:2406:b0:72d:8fa2:9999 with SMTP id d2e1a72fcca58-72d8fa29fbdmr1297689b3a.11.1736926517847;
        Tue, 14 Jan 2025 23:35:17 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40658a94sm8433203b3a.116.2025.01.14.23.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 23:35:17 -0800 (PST)
Date: Wed, 15 Jan 2025 13:05:15 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: [PATCH V7 04/16] rust: device: Add property_present()
Message-ID: <20250115073515.hxoflf65mq3pyhpx@vireshk-i7>
References: <cover.1736766672.git.viresh.kumar@linaro.org>
 <f43fe3f7b3151a89c261ad728b0f3bb2fc24caef.1736766672.git.viresh.kumar@linaro.org>
 <2025011429-gossip-hash-12e3@gregkh>
 <20250115071538.efb2ipmbmynvwt3p@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115071538.efb2ipmbmynvwt3p@vireshk-i7>

+Rob/Dirk,

On 15-01-25, 12:45, Viresh Kumar wrote:
> On 14-01-25, 19:42, Greg Kroah-Hartman wrote:
> > On Mon, Jan 13, 2025 at 04:52:59PM +0530, Viresh Kumar wrote:
> > > This implements Device::property_present(), which calls C APIs
> > > device_property_present() helper.
> > > 
> > > The new helper will be used by Rust based cpufreq drivers.
> > > 
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > ---
> > >  rust/bindings/bindings_helper.h | 1 +
> > >  rust/kernel/device.rs           | 7 +++++++
> > >  2 files changed, 8 insertions(+)
> > 
> > Want me to take this in my driver-core tree now for 6.14-rc1?
> 
> Sure, Thanks.

I now see that Rob/Dirk have sent [1] a bigger patch earlier which adds
this functionality along with other DT bindings. Though it isn't
merged yet.

-- 
viresh

[1] https://lore.kernel.org/all/20241122081257.1776925-1-dirk.behme@de.bosch.com/

