Return-Path: <linux-pm+bounces-28519-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D010DAD652B
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 03:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 737007A0576
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 01:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C688C54918;
	Thu, 12 Jun 2025 01:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oJAampAh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450AE27718
	for <linux-pm@vger.kernel.org>; Thu, 12 Jun 2025 01:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749692273; cv=none; b=XnShr531ebvPkAvtjWiL6FPu1MbMluGFdufTg7M+S8BoQ6wGGNdDUctl55UY1vgK8v0cDTHw8PuaiucpotVBxBHw2ibjjSpbw4TK+2GpnXwzUe4Dl+7stbgp2/orjTdXJY46vnwbdXNvdOQ8FakcYk/tcnSUrCUDQh43dyxW1Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749692273; c=relaxed/simple;
	bh=EmgxiCslSolMNCzBUoL4OQg87GsLep/G3Phn9Wkt9NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmAyJH5+Kkpx+ISqg4IIVph7FWN7q+Qn1BzTHSVFhIYh6j/aKsXmu9w0bTe8b8clp+/029JESfXvvUhuU781mU/jvmDSOmYQGmcCgmTY1kKRHChrgqjDt/5mV5qHQwyHe7rChK06kT4TAgaTU0K3Qg4bK+B2HcnRQcSOuR1jT18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oJAampAh; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so474191b3a.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Jun 2025 18:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749692271; x=1750297071; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=acl3HM/gy65MT7QW59o4rGkPJzPE8ycfLTpRSNc4cWU=;
        b=oJAampAhEhpA5cLdKflyLUxnNCqwBAg8wUsGafqBw8d+YGc1yhVYqM6FyrLl7bLTOJ
         VyEQEtnZaDYwsuGtYqegu9ln278lZUhJqeTE+jNhjouFSKht7RcxtaTEZo3v084MtRi9
         SNp/ujiepiAhJ1QFsCgtPUPJcSo+eZdKDDqp41b0UNkWAtB4Wt5zgVItMYWeSkbFlYH1
         aovtexlvaeiMQ8sz3XZYMWcOZyTdwtz/rJovSBEYIX5W19VeOcZgd1Z1/6wC3WAi7ZMt
         jDAaTRek7jOC+HVs84xyqHHHqdWFU01t9o8kIXvpMsqdrq2dHKlZm9sxtf9uxahvx5tn
         kxag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749692271; x=1750297071;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=acl3HM/gy65MT7QW59o4rGkPJzPE8ycfLTpRSNc4cWU=;
        b=p67cRAjhNG+NIDMfzAt6AvgQj+6Xj5JEHUW6H0pA9DXlD4UEqNSIlVzIEUl+mFhFa0
         NQ9ysWnaHGvqz+E10ASyjVHW2MNEs978MMp1IcMvP7tUS4/2wbz29rUSOZ6SqD4ANWue
         U+rpyB0KRfFKoNMFJbAkuEeILyySOuqg9BSBZxgXqncL5owd/VDNN5Zhp+jBGYWRthr+
         /HQq5/Ipbx0wt1khKJd36NaccceyHUCp9HqRTF/E4tf7MkqyvdQw5mK15cM4+A9GWMR3
         NNgX2HJR/h4xQJ6G6WU9/JCACYSza0GrltYBuefFUxZKiqdxtOeMsay4r6WxiKxWxIH9
         saUA==
X-Forwarded-Encrypted: i=1; AJvYcCXQkk2L5RkHhS7l0o+mQL3OPIDmkS8M6PzaaPGyLwfke0XqeO6EttDqPs9ggVf+V1wVQIUdIddNPA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTXWrBYE8DQPzZAo/76L9Y61qJVW7MZvVHIJOznd4NLS9SB6b/
	a7VUZi3kBv74fpG2KsJLkxqGPvMg8JOwrD93jorL5YFhe7lpz2t6jnO64bVi/e3ibNY=
X-Gm-Gg: ASbGncu02n48fqFbZnOUmyMtcIJtN7JJ38DeGHrjhFWJAS6cC+YuTbXVyViysLDM81k
	t4615lwbRRKPOpanqKEwNfN5y9ELEdW3RKQOPaKxgBtOmZNLDBrdAFaYrgIp/MR/Cic/pxrDQD4
	vgznFFzAG3KvnezZJIi9SD50Z2f/wlA7aF/V0JvOdkCFBu5HmIsWrBE5Fks/VVTW1WTs9UE3htd
	a4aRXOoxz/tKaQa+qMFqFoLeULYkhc04iKF3oJy0+X47MHKE1d98mI84cEYoYIZTYOYzEHSzbC6
	wmtXGf0/mBPo5ZdIf9lm8G/SAaI+TBEya3m9rMROD1Apf2VQK2K5t3tLmFrItUY=
X-Google-Smtp-Source: AGHT+IGQb69oSvUbCWxUQ9pS4E1eHVQjsTTq/cBES45AIlrmrVW+OEfUjBX2qBwDqZa2fbH9zp5fXA==
X-Received: by 2002:a05:6300:6b0d:b0:21f:97f3:d4c2 with SMTP id adf61e73a8af0-21f97f3d6f9mr1549747637.16.1749692271459;
        Wed, 11 Jun 2025 18:37:51 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fd611e4dbsm261228a12.12.2025.06.11.18.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 18:37:50 -0700 (PDT)
Date: Thu, 12 Jun 2025 07:07:46 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-pm@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Convert `/// SAFETY` lines to `# Safety`
 sections
Message-ID: <20250612013746.psicbrobklub6xvy@vireshk-i7>
References: <4823a58093c6dfa20df62b5c18da613621b9716e.1749554599.git.viresh.kumar@linaro.org>
 <CANiq72mP7tGzZM_f2gRSVcBw5a5Y7vMM3eOSvuAOK=yJeEmFBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72mP7tGzZM_f2gRSVcBw5a5Y7vMM3eOSvuAOK=yJeEmFBg@mail.gmail.com>

On 11-06-25, 13:46, Miguel Ojeda wrote:
> On Tue, Jun 10, 2025 at 1:23 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > Replace `/// SAFETY` comments in doc comments with proper `# Safety`
> > sections, as per rustdoc conventions.
> >
> > Also mark the C FFI callbacks as `unsafe` to correctly reflect their
> > safety requirements.
> 
> +1 I guess the Clippy lint triggered when writing the section, right?

Yes.

-- 
viresh

