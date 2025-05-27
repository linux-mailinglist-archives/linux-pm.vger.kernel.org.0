Return-Path: <linux-pm+bounces-27679-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE5DAC4A81
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 10:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7D197A69D0
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 08:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E47122A4E2;
	Tue, 27 May 2025 08:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZXiOZDjn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29AE24A066
	for <linux-pm@vger.kernel.org>; Tue, 27 May 2025 08:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748335516; cv=none; b=enYIt/j4k8wEmGEtOqSBa33BlI95v4EGrcZ5vtJkbDjt2hb0SYQgnu+g7VYWYMKXI1aRspW7InaRnvTTlRAT1wczutBQUCVEh3DO2Q4XbumxCFpMw+YLjYro6U4DiD6P6sN+SpPqFWLcxj0cWzIWV2RNLS5/9FXfjgZcHgOESPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748335516; c=relaxed/simple;
	bh=g/OHQjDpbJeO7aSJx6LO1dgocetnFYYYHquamLC5R3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k25/Jdb8QylKy/LA/OPUbEOAiXs1gRhjt+7cQpBaq/tmCk7/gRJoDFRWb2flx/bdEM+tgei9Ca9A6oEFACp2VEahFbFSdiJ+C0Y2FOFwonC+pqXmlNC2GLQy1QlIF8d7htLlP1AZHij+uCEQwbpDvy5+KqXv2ji4llaozP+9CzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZXiOZDjn; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-232059c0b50so24608925ad.2
        for <linux-pm@vger.kernel.org>; Tue, 27 May 2025 01:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748335514; x=1748940314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5plvP5KcTSQCNhrzz/CfYJsTCK3IA9hQqyTdjVPsPvo=;
        b=ZXiOZDjnAlgkV+dy6c98+T5fk5+GvekzhTUhaYblx/SyvseT5NbUCEGeOdj+6FuAKA
         eeen1X9buQbIZh4H+JHPzKz8vQOs4yW3gYmJEnm+C4sZjhXswmVZ6bxC5GcSYBgiBcQe
         mC3SORRhqI/cdaaSnMIEZT/3Wvvr/GQR2s/uo/aoEmJRfJ3v32k0iaSReRSSOd7YzjUA
         BX0P4VCJcZE8F1ai9ZUjSSgHSrgrUI+ynfzDDgEekF+V386R0lzrQnjvR1wA/ug7Fyn9
         J4ulV71P7cG+vnL2yxSBCiMrpX2bexP53clEBs5vmguD8+4qa+n95gtrRBDmAdpyC1d7
         r/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748335514; x=1748940314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5plvP5KcTSQCNhrzz/CfYJsTCK3IA9hQqyTdjVPsPvo=;
        b=Qik57xV3dnCLhoPthGk1OAsXc15lNWPYmFk3qHdOAF8gWH9qkKSHYN3AsoTNAI6Lp1
         ZBiM27IarehYdulSW7IHq3/YZhH+pMPrgHO17YywdDLiIG5Mvs/YO0poenmOUM55GZ/V
         kEqA05Q+ike8igrpFMxjHsNBivEDUiHNyMvrjczEEojqYXBh2LZ7Im8osHcDge9lYUWm
         vARHLNNIJrGChUhrXswj0hj9hABTIHf8esxRS/PE+abeGjyvcsxYCCO4fIo4/oufd5J+
         m80ISSEqWCABEKhSIaKzBGXaupJgukQCvHjcd0wn3JPHZs4v2v7bGbhaRfZW3JayTiaf
         aXEw==
X-Forwarded-Encrypted: i=1; AJvYcCVvk6/rvCzPWcDSMGlSKMPgZDaFAsXDQ4LyyUvnEJc6wblM34xtZdLKMhD9vUKgP5hrmuEY5Xp88w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRV4ECr2mWevC9JcbphJx7IM7ZvEIoZObJdOPN5pkSGtku3a1Y
	KypalPRT8S7YiV80PnEWSkz2upz40YpzpMmCWmQV2E+TE7lQTxKPFa+1TXybrUGgeEI=
X-Gm-Gg: ASbGncswSS+IuE7ZLFI6gjwhvcNNByh+o4HpBKob+mxSr6Jl5mFDzfEMCYcDiaDDnDm
	I/X8qaFMbXw363RU67PuO3uvIEfhFvobsSbrnqpmVPhUr/VQdl1jPanOXTwE6pGrfzK/CvK8hLb
	1kZU8l4c24HLv2HhO3YGFB1y+PSLnBc4P0BnlycF2OCNO7lRrojCNBZe2PRMVr+HzwZdZHaQ9C2
	Vm0txDaFQBFWga0+hjwHHf+pe7ziqeM9V5Wqs5YYIoPObPflC8tVQLIQFw5mS3edU0fl2XX+inT
	jYjyWBYGzPUL4cfm24nW07poddtsjQ6i3VjjIo1u512ItdOxIWfL
X-Google-Smtp-Source: AGHT+IH0PwmJJSWcUj1FVrKXJZ5zyjJgcJctx2JJXHccuUo6vWybu14HrnIvMyHRtH39ycBL6f9Gnw==
X-Received: by 2002:a17:903:2b0c:b0:22e:5e82:6701 with SMTP id d9443c01a7336-23414f535bdmr170018555ad.18.1748335514299;
        Tue, 27 May 2025 01:45:14 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2340c2df1fbsm59336735ad.139.2025.05.27.01.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 01:45:13 -0700 (PDT)
Date: Tue, 27 May 2025 14:15:11 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: opp: Move `cfg(CONFIG_OF)` attribute to the top of
 doc test
Message-ID: <20250527084511.gfwzuqhsaheifpe2@vireshk-i7>
References: <9d93c783cc4419f16dd8942a4359d74bc0149203.1748323971.git.viresh.kumar@linaro.org>
 <CANiq72m2jztPbqiH19560RTBW0PUghi8ajjyi6Pw6jmrHFdtSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72m2jztPbqiH19560RTBW0PUghi8ajjyi6Pw6jmrHFdtSA@mail.gmail.com>

On 27-05-25, 10:39, Miguel Ojeda wrote:
> Sorry, to be clear, I meant it as a discussion, i.e. no need to send a
> patch for this in a hurry!

Yeah, I know you started it as a discussion, but I did like it. And
honestly I didn't realize earlier that I can add this at the top of
the whole block (and hide it too), otherwise that would have been part
of my initial patch itself.

> It is just something we did for another example, but it is not a
> guideline or anything yet (it may not be a good idea, in fact -- I was
> hoping for others to chime in). Even if it were, there is no rush to
> "fix" it :)

That's why I didn't mark it as a fix, but just an improvement that I
agree with :)

Specially for this particular case, there is only function in this doc
test, and so marking the whole block with cfg looks better.

-- 
viresh

