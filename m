Return-Path: <linux-pm+bounces-29061-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F75AE000B
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 10:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F3193B8236
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 08:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A52264A9E;
	Thu, 19 Jun 2025 08:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WisCsWx/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F69F2475CB
	for <linux-pm@vger.kernel.org>; Thu, 19 Jun 2025 08:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750322425; cv=none; b=o+8YylKGu7Qpzj5H8R3RP/wAD8Be0DuzEpRlc/0hkkwxhHEoUMsKr0gtL6NTSjmWjDPZk3YFqKxSorhe6uu2yYoS7hT4Ate6xOyUgZk8QFdsGinoocf3elHLO5rW/1nU2UOOiWDF4HGX4heBWno4+pBIpEszdQCRJonJojgjW2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750322425; c=relaxed/simple;
	bh=Ufc/JLiYqVAipRJRii534cOUkZiwC/HjHDDVw3WxXZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYhkl528/5e7qNeRP8t6zD44NB5DVDLyhphZ5TA/RIB4dHcG15/gWGL2tDCaKcidebytQZ2NTjip/B1AjTKm+5GN9FVolMrAordTQXUHFuwqm3+sFB17S4xVXxQh9p5LKrFt6xCxeRk4r7xB03m0n5kaoYpAKLWsA8nFDK+019U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WisCsWx/; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-234d366e5f2so7412765ad.1
        for <linux-pm@vger.kernel.org>; Thu, 19 Jun 2025 01:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750322422; x=1750927222; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qe9QDHLeb2BcmtI9W7EcUmBr8ypmyD9JT4iW89KpGew=;
        b=WisCsWx/us/NC5iZtCmsBPN4wc3vwH4wanS0kgL0tGDb1iUexCriWxQIbCJI1GofbG
         ZjrdXkMMzNrI0N08V4Jt5U3S748+Nj0SEQkeysloib+kQexgiWYBwB0NN3raIR5VkcWm
         9lU1rIEaGdgIVtDVwK9d/lz+LNpplm6ntOeHPEd8LBtED3vWSVPX7Gb59FGsl/IIhBch
         11mkWZ9C+IN2+OquCISErXK0F67jwa/fz+WWaSxwO2unIRNhxC6hrOkNIaa6heA6tI8L
         6ARo3g6Vy+QAKaMH/7zPw60QbJAfWRyOjhsWJCLTSglqIkd/mdAiKqIfO7kwkvDOtcIO
         IQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750322422; x=1750927222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qe9QDHLeb2BcmtI9W7EcUmBr8ypmyD9JT4iW89KpGew=;
        b=PHk+vxa8zLhodPN4zrfqoRxAgRuzK+3pkn81R/eYSm699OR8m+dUH2D7I/Dqrfh2Qa
         4k1uOBxr4PftYRZfm3AcCe+wD56oht6p7h4LbfcGNVarcb91fYjg04665uyXF39oHPNq
         rxWJdrCKg4zzsWK5BcsyUh9STHoJNe67OTR+600ApVOeaozTD2oVlvt6F2R20b4QfL3r
         mqRbYPh+N6cT/my8a6X7SVTh/ri5JFhzFJMtIxvRR0VpItmsz+vuvzUL5VR1uK3Sce9m
         HPKdQ0Zi/JmAVVriRtyAdqzJTT6G9ppwRb4fFJW6yoEcJGf/Zwh1MReyypy+E6ZJT6Wm
         TMGA==
X-Forwarded-Encrypted: i=1; AJvYcCWsnO5iayxSMU7Ojp94zgDOJM40ct+xTmk385gwjIBCuXYLdU9DGg+e127QOiutC07GW7xB5gxVyg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOmFKoQS/bREkCXDYuLwEQm5d6EUgZ9fD9bYqyidpgERis1bqY
	5hty+zYr7zk5m/a97IF/2DnO5jSPJtiwe/MG/GTRHULOiwkiJy1BOXtJzOvOm7hR9jg=
X-Gm-Gg: ASbGncsJxJFcx+bDaxjGIm0Hw0rZt7Lzch5y+geORgWWRR2cVLuTq0JVJwYotOT5FWm
	BaFqx2pkm7jE2MMUqGF+TebnYEmdaPlEGb2Aib6VFInZJGulNFFfJXwOkdvQ0XUJ5i9d0N6RQjP
	l0eymgczTqoI9s9GAV0yQKub1m2v8tIEb44fGYYGC3XQIXvI8iOXdQwRT5JqDjgcIJWiBtSPP7h
	2+d49quseWT8n2ROcT/bEC1QabK1y2nu/HkC8HOg3vO2zavfoC3WcLVA9Mz800i7zjJvk8bvcU3
	cb9qyRSuuh+MTE3oyUkORR82wsCKf2J/yQ8Dj8x0cywAV3pObD9uBOnPoCxydb4=
X-Google-Smtp-Source: AGHT+IGW5qplfc0e8GoHi2nYbNAnZvB4wAxetjyjKY3xR/zkK6nuq7qJNQAohJ/ZLfN9waxkJMbFsg==
X-Received: by 2002:a17:903:41c9:b0:235:ea0d:ae10 with SMTP id d9443c01a7336-2366b329eb4mr344216805ad.12.1750322422268;
        Thu, 19 Jun 2025 01:40:22 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365dea7d82sm114351955ad.146.2025.06.19.01.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 01:40:21 -0700 (PDT)
Date: Thu, 19 Jun 2025 14:10:19 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Abhinav ananthu <abhinav.ogl@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] rust: cpufreq: Ensure C ABI compatibility in all
 unsafe
Message-ID: <20250619084019.b36nwacofdixktdj@vireshk-i7>
References: <20250613101815.18092-1-abhinav.ogl@gmail.com>
 <20250619081601.yeulh36lhrqxo4ep@vireshk-i7>
 <CAGR7w80V_Atc_DuF1RGOFHbvXd1V2j8mMbN3yg+Q6oytiJwNbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGR7w80V_Atc_DuF1RGOFHbvXd1V2j8mMbN3yg+Q6oytiJwNbw@mail.gmail.com>

On 19-06-25, 14:07, Abhinav ananthu wrote:
> sure , should I make two different patches for opp.rs and cpufreq.rs or
> make the changes in a single patch?

Two patches.

-- 
viresh

