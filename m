Return-Path: <linux-pm+bounces-20291-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D96A0B013
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 08:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC21E3A6836
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 07:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313CB2327A3;
	Mon, 13 Jan 2025 07:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gnP9Ss1U"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BAC231CB1
	for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 07:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736753446; cv=none; b=fvBp+NGe1AflxxXOEbykYrO6zxpjxlNu2G1xAHR+x5K/xB1D8ZidcLMlWVbKFmyGonq9aVmxK0O9m6fclJbCVyYTeuEUGJn8mPS1bS+b/1eDOSwQxiyreknzF0UeXFC7xgFRQeX1sorm31qevzb9Te6KzgNp31kqizAO1JBJRPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736753446; c=relaxed/simple;
	bh=XCzrP3WQSLZQqESesBk9CKFvGYZYd/fUYezUehJaPts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmSjeJ19TPROq9HKCJxSMgDyAufOMz4XYRqUYmbhmaS0wz4vhwXgietbyo/cf/B6+dlcDkSOzC5TgENWRagV9Mg5RokYHvT4/P7y9kWZsvtF3wVbzCUWyC4bj+AHjBsJQVCviNfDOUx7eHZEJ+sbtBiOEJC/50JmQ7TfciscQSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gnP9Ss1U; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2164b662090so63159185ad.1
        for <linux-pm@vger.kernel.org>; Sun, 12 Jan 2025 23:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736753444; x=1737358244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YqwN0q6pF8+vOtEosRTVgbClVpFGaMH4Eyenu50vCEc=;
        b=gnP9Ss1UMOLyaJyN1gyFJScqUSr32AU/4E6EKY5KfCTIqsehqXKW2bo0d8JtNALKD2
         OW44hNl201ykZo6R+4ZWHLsKoLzv3MJL3uePffD3O0YMERJ3Sa007FOOInE59VF6+ePI
         phPUHKdMooFtISZwjQCtbS5N+0NLJ//L8V/QeO49zLnXfMhXuercoVG9tAMh7uy3MZ+y
         jEhEDL1vf0z1EPErU5ZF4qCn5/UgF3JcxBRRt2tzzn0F+lvtYTn8CHQxsCHIvpYhCmVT
         qWVHPonOzjSQU5pDh5rBZCFTMUbT191NLNavmQ97hbkVnGqfR/Adt6ajj34hoMu6kUQf
         OvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736753444; x=1737358244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YqwN0q6pF8+vOtEosRTVgbClVpFGaMH4Eyenu50vCEc=;
        b=oK+xEd8BP6bigPhJIZKwmIpSrX2r3CgN42kY6S+3ApZHJGygaxjseiKAHq1SE46PxH
         4MiwuL/B3EkU0fdaiXen4aYVh04XCdTwY46rXMmERUHShONzpcCN581tgXQO9j9QQKYv
         IqYz5LIiWxH3aQ2Kookjh7edKgQsHWXA0NwUz/+mczTYqwgYKXLpGaaUGV28Cd3K2w6N
         iOZCZSAVVUn03n7+k9dObdITrniHSvbqna12vYnKTkuFFTaoqi58qVs3ztY6H2PFNooP
         zpiMSMVziA+PeiUpZicAqpgtylv61jeu2Xo5RcL6lp7n/WcO+1gmCPwsodL0/2Wp+aLq
         do/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWsg3k032TedoftURoLGrrhLVbDKfNSVoWo8i/FB6n3t/KjryAECmRBrtdmUsrW45roYsi9S1Od7w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGDyxiyMBvuZaIGK9crCzd34JLchtRVJGRaP1c0vPjFw3ec98K
	Yp4FcaRhGs4IRGSH8DltZyPQXmmewaMdHAR1dLFMfZUN2eYtryBAzPWQSahcjPc=
X-Gm-Gg: ASbGncuiOMJhia0fuaVbK0OzicsGZ3klap2dD3rGkwi76UoFOG6UUDUaVKB31YoVQ/H
	j/7fjcg+qPYxqCkuqoXLlxgbdhGstutQmVYFjDlrL/mmVaaaJDBFQkJSu06NihXe4ElVapg2WTW
	TrKZolk5sM/Vs22Kuz1Tco4WxN6IY4DMPMGYI3A4ubGMd8Gb/B5CBNb12szJARyB0CjjvLLAwk9
	yJrOmTsserNo3XQPN8cbnxTf4IVQnx9/IBk6hfl2CNS/+Bx+UQCSq67nyg=
X-Google-Smtp-Source: AGHT+IHRq6WBI3SjqdDjWZRB9bE03FS1elLLqTh8jLxGZm+rvrfMnZIAUuBKXdlGzkScUN/jm8i2Yw==
X-Received: by 2002:a05:6a00:35c3:b0:728:e52b:1cc9 with SMTP id d2e1a72fcca58-72d2204914amr28862790b3a.18.1736753443692;
        Sun, 12 Jan 2025 23:30:43 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4067e591sm5296294b3a.126.2025.01.12.23.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 23:30:43 -0800 (PST)
Date: Mon, 13 Jan 2025 13:00:40 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 02/15] cpufreq: Add cpufreq_table_len()
Message-ID: <20250113073040.rvtc27zcgpvcycrr@vireshk-i7>
References: <cover.1736248242.git.viresh.kumar@linaro.org>
 <867ba9728179ba21ff8f8aca97d416b72ccd63d9.1736248242.git.viresh.kumar@linaro.org>
 <2025010727-banner-monday-1941@gregkh>
 <20250108111253.tg6ixurijf2dvptx@vireshk-i7>
 <2025010855-cargo-quickness-a08f@gregkh>
 <20250109044117.s5s4dlmssamwicew@vireshk-i7>
 <2025010944-detective-borough-b158@gregkh>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025010944-detective-borough-b158@gregkh>

On 09-01-25, 08:35, Greg KH wrote:
> Then why not make the C code use this function as well, to keep all
> cpufreq drivers from having to manually walk the list and that way both
> C and Rust drivers all do the same thing?  That makes more sense to me,
> there's no reason you can't change C code today first to make things
> more unified, in fact, that's usually a better idea overall anyway.

I investigated a bit on this..

- The cpufreq core normally gets (from cpufreq governor's for example)
  a frequency value to be matched against in the freq-table, and the
  loop which run over the freq-table is already optimized enough (it
  checks for CPUFREQ_TABLE_END) for this. Using length in this loop
  won't improve it anymore.

- The cpufreq core then calls cpufreq driver's callbacks and passes an
  index to the freq-table, which the drivers don't need to verify
  against table length, since the index came from the core itself.

- The same happens on the Rust side, where the cpufreq core calls the
  target_index() callback of the driver. While writing the Rust code,
  I thought maybe I should validate that the index is within limits
  (before I do pointer manipulation in Rust code). And so required
  this extra function (which C code never uses).

- Now I can either keep doing this verification in the Rust code (and
  so keep the new API, only used by Rust code). Or I can just remove
  the verification and trust that the index passed by the
  cpufreq-drivers is correct (since they have received them from the
  cpufreq C code).

What should I do ?

-- 
viresh

