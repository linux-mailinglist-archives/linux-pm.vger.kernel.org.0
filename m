Return-Path: <linux-pm+bounces-20083-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBE2A05956
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 12:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E03AC3A5A2E
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 11:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDC61F8925;
	Wed,  8 Jan 2025 11:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OyfuFBxV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D50619D090
	for <linux-pm@vger.kernel.org>; Wed,  8 Jan 2025 11:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736334777; cv=none; b=QvS8z0xH0anVttUT95Ek4oOLPD/1Q//CZ1rAQeJbBTGgOuB7u0tODuFLKskmH+1NUs8byd7iEHqiRxoJ7S7geJzYSG9/tHNDfGD897APbPQzjfRpAgVKupvR+LbpiR9nkbbF7XyM4ofaoGn+JTx5euBZqOjyioWJwtak+ZLi5r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736334777; c=relaxed/simple;
	bh=3bioaWv8v5FNZwHxNMb0ze9/tSY4Zmaq9lrUnUG0huE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gCAxjesO3hfnandY1kHueDPzxDrHilvuSy1U2oJSEUYmeDQz5a09csdkh3EdR4K8mySPhJazdxwdCycD1bzgAJ8qkHRCFHsP9dGymWMPS8jTfRBTGhyZ8kNrOxmpEN5/GrY5GpOZHI3LZbWnTynGrITyhtXBU315NO/RnHD7LPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OyfuFBxV; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21644aca3a0so73395655ad.3
        for <linux-pm@vger.kernel.org>; Wed, 08 Jan 2025 03:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736334776; x=1736939576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cDgyEvBEmxG1XnaIjl3paZZecQB+0nmeLLFBi9Z8mjE=;
        b=OyfuFBxVPgS0pWqfp5oSOswC/ShefdsY3YWXR7bQ6rhXMypaMmcriFU6Ta4Vrhd5GF
         FUP6k3AO3xaPsiq9PiIM6AGneh9mDobLcjpv1EiA4o7DRhX7z/u4ai0RCwBItfZPRhxL
         O5NmysHitV+LJA+yiD5AqaEtvJZcuZQKiw9nCx419WP6vM4V5wtUVNo7sCThF+OuB4jc
         MqQNrn6MdwDHN7KXrzRNB6Yk/NF3NGcXbxpzi7thxR2fLkApvdKFJOfJMpsCaRL6Obad
         PaXWEm3enCU8Z9y1pm3ELFQQIpVcDwxPNxSDG9kZHQ+qFklEnmRKJwp64AxdK71G4u88
         eNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736334776; x=1736939576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDgyEvBEmxG1XnaIjl3paZZecQB+0nmeLLFBi9Z8mjE=;
        b=N2iM6x2MOJbkAExBOYMMtI0/SdkRS/PDoFQQpyoc0DRJdJxT/NkH7t0GyhKm1Zjv6T
         DS0bP2RCUC7URAaaYKw6k9ii+HuN2X4y1A7zV4T2hyRDNmQRxkqGVLeROJgUaVbwMoV7
         UmQ1ktJyaOYpZ6B3RcyfmlILvkVRuUdF3Rjbn8eIGwQFzQWs49okulvjV5E5hi8IwM5B
         LPksGsmlWWnFweHrNgiwuBWCeugvfAGEEMihGx9Jy9XuqHIBfoo1hQsha0OF3rGMHdts
         V43crlf/+z52VxhBBhdCALPehh+5ljgTBW58Wnty1smNKVOJGjcjr4pdNQlVp2V/tylX
         4P+w==
X-Forwarded-Encrypted: i=1; AJvYcCUkZms9buIm7GY7amy9ltJST7iYh+ARIhqaSoZQDkxxIzMgx66cTpz35iB1Ln9rBYtlpziz2sgWAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh1h5lcp1fXON2DIR3ap8upVy5NtkFpmv56a80LpBY0LolCMU+
	rCBW9vL98MfCIvW3ecpCSonmXJ165BivUzZ/7Hnbix9EsK3fWsIrQ2L3bPdBhpM=
X-Gm-Gg: ASbGncsSf7fHVb5Cut1Oq1kwQKWQ9dAYJIYpDp62Ggvjshf5tEqiQy6yY+STemgChOW
	bW00CZ+Cvvctkzny604uwXyBcY1kasj+fabqZgVXSPIshJ1JX1RHh0Qv/NxCAUMTn+7655A900O
	Z4x14mybysN87fHgf3ku7gZZiWTVczWKo5mPk4lQzD3puH6uTLJ/DasOmMrNQW+NVlercl1c3Fr
	wk+3/+fegwbrFuXf5N0elOWxgNdQGIUMdTx9qogqtqQUsxrP7aXbAq1Ocg=
X-Google-Smtp-Source: AGHT+IGkuDRQ9L5GVETElqt6F7vfVArGHAYfGV6VXlpMTCou0WlN7yiCsV6I2/yrt6fJ3C0WSHUx6Q==
X-Received: by 2002:a05:6a20:918d:b0:1e0:de01:4407 with SMTP id adf61e73a8af0-1e88d0eed77mr3975894637.37.1736334775681;
        Wed, 08 Jan 2025 03:12:55 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8370e2sm36303124b3a.64.2025.01.08.03.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 03:12:55 -0800 (PST)
Date: Wed, 8 Jan 2025 16:42:53 +0530
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
Message-ID: <20250108111253.tg6ixurijf2dvptx@vireshk-i7>
References: <cover.1736248242.git.viresh.kumar@linaro.org>
 <867ba9728179ba21ff8f8aca97d416b72ccd63d9.1736248242.git.viresh.kumar@linaro.org>
 <2025010727-banner-monday-1941@gregkh>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025010727-banner-monday-1941@gregkh>

On 07-01-25, 12:59, Greg KH wrote:
> On Tue, Jan 07, 2025 at 04:51:35PM +0530, Viresh Kumar wrote:
> > Add a function to calculate number of entries in the cpufreq table. This
> > will be used by the Rust implementation.
> 
> Again, why is Rust unique here?  Why wouldn't the C code also need this?

How about this:

    cpufreq: Add cpufreq_table_len()

    The last entry of a cpufreq table is marked by setting the frequency
    field to a special value: CPUFREQ_TABLE_END. The C code manages to
    traverse the table by checking the frequency field, until it reaches
    CPUFREQ_TABLE_END.

    The Rust cpufreq bindings though will need to know the length of the
    cpufreq table in advance, for example to check against an invalid index
    value.

    Provide a helper to calculate number of entries in the cpufreq table.
    will be used by the Rust implementation.

> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  include/linux/cpufreq.h | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> > index 7fe0981a7e46..6b882ff4dc24 100644
> > --- a/include/linux/cpufreq.h
> > +++ b/include/linux/cpufreq.h
> > @@ -783,6 +783,17 @@ bool cpufreq_boost_enabled(void);
> >  int cpufreq_enable_boost_support(void);
> >  bool policy_has_boost_freq(struct cpufreq_policy *policy);
> >  
> > +static inline unsigned int cpufreq_table_len(struct cpufreq_frequency_table *freq_table)
> > +{
> > +	struct cpufreq_frequency_table *pos;
> > +	unsigned int count = 0;
> > +
> > +	cpufreq_for_each_entry(pos, freq_table)
> > +		count++;
> 
> No locking is needed?

No, the cpufreq table is implemented as an array and is never altered once
created.

-- 
viresh

