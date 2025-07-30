Return-Path: <linux-pm+bounces-31622-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC55B1631A
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 16:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31DB01AA3B2D
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 14:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFAC2D9EE4;
	Wed, 30 Jul 2025 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fYSJWg1z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849212D8DBB
	for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 14:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753886920; cv=none; b=utIPhq0lgCTEybaL6lOJC+xopxlMjcaIruFw9Nq7nDDAyry0zoE4kAKpf8/s1uuZ8R+Ttmc8y1TU4lC18Dk32+IgoolAyHiu5V95EASt0te94vydFrCdmc4Y1xyxjJEUdbiT2EXx7OT7lmMoTbH6x3t/xa1oC8ZAmwc9irJNxBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753886920; c=relaxed/simple;
	bh=4mghgj0xXZRMOa8OQQTs0VAQ/GrOCZpAVNjw5jYHVBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJb+ELfuKlLNzppTtcERt5S8VOjnpZ4NMhe8UtjyGT2AOD6NYuTKZOnIFriDwvyvlI82GEqpsjGxSA401GTtYue4JIt/bn4B3lf3aAZ/SKqD28m9c+s/+kglJEUWyiZJr3EN1sAiVIyEKaz9+feM+JUjty28edWLAq6Ax6P+P8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fYSJWg1z; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b3bdab4bf19so881775a12.2
        for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 07:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753886918; x=1754491718; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eK8YzK7uzNlS0kJpPPbP/f3p/NVOP3trKsIT7CAtwKM=;
        b=fYSJWg1z3upgR7mX58kGIWzE/MkbHsQvSCtqF3eCG7lyVcEp5t4yBujU+hiyvNqxqJ
         0yWSiR3h2/pcid4FTsNW3IwonfspKXoDkelAL8E9UV+GWjwxZTtCHdolKm3D9wkwSGoM
         nqn0Fg12Jwe1HieChZWaP5BhPL9WuWpkOfs6Va72C4DOoKNP8PJI9b00DM4jC3PyuYyg
         eYuLPXCj1e9jfHHnCJRQR8l7u3TVvRCQmhr5N4SyUFx+Tky194a0ihc9vuzWs8edyhhw
         FuNFPlpmCsQbIIcj4cfbonQbZv0XU0W60l5pWZTsKfieE7/NgN39HtQWvn4pJN5tIEbS
         e4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753886918; x=1754491718;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eK8YzK7uzNlS0kJpPPbP/f3p/NVOP3trKsIT7CAtwKM=;
        b=Hm+00d8SwgegsMH7yfOqJ1o3lhx4//frr0d+HYaY8pkh0C32Masch3h2VTtdgue7x9
         WdISv4C9q4UY3y7Pk63k4VtMyahVLpZz2r1eXL4y3urNtheu5EbkG4ruy+jHuyjMRF40
         Jg01gmYIieyBB8X0/XH3q39eHDAdTjskQbi52KXulGbMEj0ZT7NNlSZfulVvd0zO7zhl
         lAFz9fTg7bXOt4/ljfHYXxK3+H2WUlD5Gn1w1ig76S3BhBonjOhc87w27x9yOIqOdXUK
         u/Pth6QTJari+PcPXNq5iqItcS+Mh6DeJ3FaidciTGT4agT367WyPUb28Z1iEgh3pkmQ
         nsPg==
X-Forwarded-Encrypted: i=1; AJvYcCXi5hSB24k35cYYdhBCnD9M5cRKSMEzvCXDiRq9R+u5zzvw5/pHJtY1/GCnnCPhsLXxA+9XXNZSIA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6hY3kdwwXRyGWkomY78Xq2DVGQaMSU1l2E5+lCqmzbeXp8c5w
	jEQFkX6QgDV3MZ8LQkVhgL4wESj9ZEZlpEXM2ZrgP6x8JmZ0tUAUqb0rW6PaIjnYlKM=
X-Gm-Gg: ASbGncvoOUFuZHAvM7Fy78x3/pI67hVUcgrO7ZvVjk2CtIKN0L2vT38l+z5h7JCCior
	ijkmKqg3dUuGs4idVNWwACUlPSEoYA4I+9QqnL+wTecUgYA/uQCRYY+5CfgBa59XvUwWOsbXtSy
	g0sa5StoE3Q7u//iG56WEUyxkBoEGxlTmrpDRVZtiKPJG0E3sHjO60z4+9UUMbdzWvAjUQXeQK5
	DYB1VbVMdo6jet0/N3GNQOdBSecsu71SvU3WIFN7UduPGoMMdy90oGcJR3PL0r7Ljxuqd+z5ry2
	EwuAZwFWbFbrjdTfTENo4fsCZi/gIe7q2cQn33a4QyxlWTSVXkFBwVPGXfq59RKjz25OkGH3msn
	8CtwvII1i1XQ0EeVlKUrAE7o=
X-Google-Smtp-Source: AGHT+IHmCtoI/bWhXT2CXJZ8Yc/kzIn37kaOEzx4dcyEFnc73WRQhsLOgyrX+5HPgOGkzvXZtaUfVA==
X-Received: by 2002:a17:90b:35d1:b0:312:e6f1:c05d with SMTP id 98e67ed59e1d1-31f5dd891dcmr4980616a91.2.1753886917853;
        Wed, 30 Jul 2025 07:48:37 -0700 (PDT)
Received: from localhost ([122.172.85.40])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63f0cb39sm2209790a91.30.2025.07.30.07.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 07:48:37 -0700 (PDT)
Date: Wed, 30 Jul 2025 20:18:34 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>, linux-clk@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH] rust: clk: use the type-state pattern
Message-ID: <20250730144834.63pnrsoyrmrkjfrw@vireshk-i7>
References: <20250729-clk-type-state-v1-1-896b53816f7b@collabora.com>
 <20250730062355.bqifrzvxfmaaugnk@vireshk-i7>
 <9746F6D6-488C-4562-8FB1-BE268C69BA97@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9746F6D6-488C-4562-8FB1-BE268C69BA97@collabora.com>

On 30-07-25, 09:27, Daniel Almeida wrote:
> What’s the issue with clk_prepare? You mean that the parenthesis are missing?

Yes.

-- 
viresh

