Return-Path: <linux-pm+bounces-32362-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D10B25A53
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 06:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 406955A4817
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 04:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A491E1C84B2;
	Thu, 14 Aug 2025 04:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="udFrMsi+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134962FF645
	for <linux-pm@vger.kernel.org>; Thu, 14 Aug 2025 04:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755144800; cv=none; b=nYmngQG0dnA8kzH2OCzOe2IKFwkxA5gwTmLEUORA1dX4n4j9dvEYvep7h49VUSSoswIiLv+DfvL3VSmXefu5cy+oW2Frs3fZ4P5y2/SixtOXwChjCJXLiWa8kQC2J1YAODQldZ1mthsdClRTDrQtZJK6bEQLBiMNlJJSQi7XBRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755144800; c=relaxed/simple;
	bh=VGzEBobUnqTenM6o2yCYtZykv7kCalxd6Xw2oMoXnPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZrkJNLUn6f+Qveeh70gStjyvvT/Z820RLI2XgNz6q1OGjfkLk8Rg/jnyysd55pMUBQm9X4YFcW6yof8mVa5D7HDdIeVhi4U51wh3gbC0vNAAL9EXo6HxvgUkBNMdlyghdYRHOjQNqilOJZ6e2nrIxlnoH5s3C3RUu/fYAfmE68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=udFrMsi+; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76e2e614b84so577259b3a.0
        for <linux-pm@vger.kernel.org>; Wed, 13 Aug 2025 21:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755144798; x=1755749598; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wzto4+R4SEpsXQvu35Am9g0bxExsmpRAPRKsrODRUCM=;
        b=udFrMsi+sWQWpPTCVJQnbUBDRJ7SgIrcbPOqxQTZwc31tnNq/0cYHIgzzPz/HjOMvK
         X6PE4Pj2ZdzANvP7pGRY+qxMaON5pgLsQJ6jo61lC8Ek4Z+68EAthLi+GCO8yCRRKJ/f
         W00JfWphXoqqp7xKPlUP6VWgjOYSb+ipTlgRRhx8rDh8Q5oLj6gtRK7qNc72yInOWrHo
         3ejEftkLGa/mcsilQpy3KpDyCseiPlwQmofsFm60sva6GIUvoPe1meTgmkfYsMz+0991
         kzkT3cuhtvhuziJD+sJb1DE9hGIsjv7YiF14xclSSSedkK5uZT5ZxG2ElmVdhepYWFL7
         wubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755144798; x=1755749598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzto4+R4SEpsXQvu35Am9g0bxExsmpRAPRKsrODRUCM=;
        b=MhYtogar4qDQcVSkqilENw+zXhRb4WjrDciyd7bOoa4pRJKJHaP3B0xkYUU71giH6r
         6wq2ECqxwbOUBzzToGJY7tyJYw6sBnLnxdCOOXQOYLiuqNpsZei3EV4iCDgULX6OBVza
         kd1hA9fn7z9muc9hv0oBR3TQU1uOyRKWByin9uCiL3xfsY/D78KQvSwDZKR+8J3kcGsS
         Uq9D1zM3c6glpsP4jzYcEow/RHdKgnPBy/ZXw4R6qZf6IMz6ofjKzgpS4zAwJfbJCRx1
         PfDK4FqwZUaoGzU+Ka6J0qJWp82kT8igGzthuKhvjArCG4XWjlJkcnEbhgOQLJ2HcC7n
         /vSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfe7mfsl+nxBVqbknaD/ugW5F9gICryhJNByM5U3uy0qIlCYAeMdRy8tAuiJooef8Tf2MWLlFsAw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHL4jRCXsyGouBvo8EBz9SWaPEGAN+zNdfogGWdUPbxIXk3IHc
	EUx6mOKB9WayQbsSLsGKwG5lHgEt7KL0Ch0ysKs5hS3xjeJSnQLSlJoH6F6yWPlP7Co=
X-Gm-Gg: ASbGnctQZyZTksD39R1FprODAPBpfGiLbmfeJdVYGoY8yO9BD7gcx2TlZ4GeBxqU5jS
	zAPRJD+pl5OSaVFthTV3v3HNn7sHCQxxYXkR6rAeeU4B1/Cn5iU9JGdKEneGwNRm5k2fDh3Ls2s
	T9R7phXHlfBh7P6ljMyJuWfMB5ScgbSTtmchHe+mswzvds/cSOxa0YIk2NeYSsb3G34LHzCqyCn
	578HxRCD6Wbm41BmKnHOfPpfY2lwhZN9qkmxNi4dIhtRpxcmnZEw/+ItLzE5UMDxfdNOuVxa7ul
	fCpF4Xg5W9HCfmALCjjTXVGzbkxlWig0CpsyE6WfAO1Dv0I7YX8xXbUMsHvdDouZ6zl2V2TRqrF
	XsX4FvT1J3BlLkzj++CAohy+Q
X-Google-Smtp-Source: AGHT+IHuZAqDG+bKwN4mmEbOegBcVFPvD6aKGH7LaHe89lphIokLJFFNQE++EiGJ4ANYP7KMAZ7a4Q==
X-Received: by 2002:a05:6a00:9a7:b0:76b:e936:607 with SMTP id d2e1a72fcca58-76e2f9310f7mr2697735b3a.0.1755144798295;
        Wed, 13 Aug 2025 21:13:18 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce6f474sm32881328b3a.4.2025.08.13.21.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 21:13:17 -0700 (PDT)
Date: Thu, 14 Aug 2025 09:43:15 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: cpumask: rename CpumaskVar::as[_mut]_ref to
 from_raw[_mut]
Message-ID: <20250814041315.ywuxwp627jiphiqf@vireshk-i7>
References: <20250813-cpumask-asref-v1-1-1242aa8e0cfc@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813-cpumask-asref-v1-1-1242aa8e0cfc@google.com>

On 13-08-25, 07:54, Alice Ryhl wrote:
> The prefix as_* shouldn't be used for constructors. For further
> motivation, see commit 2f5606afa4c2 ("device: rust: rename
> Device::as_ref() to Device::from_raw()").
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/cpufreq.rs | 2 +-
>  rust/kernel/cpumask.rs | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Applied. Thanks.

-- 
viresh

