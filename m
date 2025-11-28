Return-Path: <linux-pm+bounces-38871-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EEBC9175E
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 10:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 247193A9FCC
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 09:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB3730217B;
	Fri, 28 Nov 2025 09:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ccE7HX3e"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D182E7658
	for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2025 09:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764322374; cv=none; b=qhTlGKr3UQQIrx4edtbtizhVIbdSgXS4jMTOO77dt0ohyo50BZ9JO+JIQZ7tWf9bzTewSYuURYrGCqEGfwfUyRAs2s9LePRwSwWcKDtVVvoi3CamlfbsBEzk3VefbbDYmL6qX40REgaSm1gt7YnOtrhtRIKSmXa8o23oEp6nFnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764322374; c=relaxed/simple;
	bh=bgZ3WYmLt9USwCbeIAxle387xMGQ0BbyXHLdtjgQl2M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XLP0kQPLMaRFgBbNT8FzTnxWfFSKgd8xVBZl52s/uR/d+5aXQuxeWZyRpY+OfJ6lrpgMyY13HuFVH9rvoreVio9mfRD2VBXtlUh+9vwvlYm884YVVFanEnwyFEQwUMVMg5BcYci7vu2TtThMiI9yNR2jGwxVb7MzjOt8wzf5m4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ccE7HX3e; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-477563a0c75so9524835e9.1
        for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2025 01:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764322371; x=1764927171; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8wnjYfuFv+6HxV3iMOKxCxf7adXLY3By339Z3YdD6BY=;
        b=ccE7HX3eiKA6dAlLVuGVlpmi6Ak1QmxllfT7OtWOUpSOupVEjCDmUYWd2DfPax5vt6
         sg2x96u9in5PFPHTqBLBNId1GD651lE4RvxinQMbbGUTZm5DUGxEoChZ7BYiHW4DkHNn
         dfjnaucBJAkGRJJUxiP6ZJizgptAiiKtigcCyGRVB5y6kBBOUOyA7W8e5nIzuBlBX+/M
         q9arc4oMKWXqJxEvzOAKqxBRJvxzC3jXEljdNwqahal4/3Jb0scUnawHfZVc5dPGngr0
         ievAoHdo36VNn6WSTqNaUKhHTRu26/Afkt0KusIp3kIiWs/aTpN3xS4tBxaDpeDQYSNh
         Bruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764322371; x=1764927171;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8wnjYfuFv+6HxV3iMOKxCxf7adXLY3By339Z3YdD6BY=;
        b=jzzhQ8ez38++t1Gm3vbRhsJgA5O6as3xmS82TPgIkji4mBGO1OL4mdPB3PYMDt20MG
         Mx1Mgcum3fNjoboqTLtxnLHO4CmaIdV9bT5nUCteN87dHfGhUUCXvgZlkKZKvj1uCJ1g
         f5ZnVVMl0tAJgYTuvtnKZhhWsg+V3sgwBC+BmnFI/fCl+20UmgM20tB6SJHZ6ozFlqMy
         TVqcm7cI2ntN3AsdWCoHaPDcBnPI4i5maKCp/lXVdSJ+4Lmu7KJp83YJlqrUFggG53SF
         0QSBSQ3qw5cipzhfrArcYNW0WGp5QjWl36a24aO1JwWb0LH1hGyg5EYlnUT/O0uInGyA
         qExA==
X-Forwarded-Encrypted: i=1; AJvYcCU0PsRIlmR1XgnsgdFN844kI4kNJvbkSx6f4crabEhRUj/MZlFC2JH7kcOuMfVGQxVFqXjgfiXIZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBKYjd6f28yGODqGSTgOMqZox3DEE5iP7etkQTOShjCg6c/qf5
	jCe5UFwewcaItIc2guEDwK6LLH/fUu4wfFgVxWwNSCGLuMGJMPdNDXaIeBmeW58xIjLpLY3aCCP
	PNR4S9UU9y83WY2AZLQ==
X-Google-Smtp-Source: AGHT+IFhwMEn3+05xv26tdB0wCa+JQEY/PCYnU+E/8TUE7g4HW0hG8CkVmY8LFitRDkG/ICQaGMRH2p3BmwWQoY=
X-Received: from wmbc11.prod.google.com ([2002:a7b:c00b:0:b0:477:c551:bdb9])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1c19:b0:477:7bca:8b3c with SMTP id 5b1f17b1804b1-47904b10379mr181587965e9.19.1764322371479;
 Fri, 28 Nov 2025 01:32:51 -0800 (PST)
Date: Fri, 28 Nov 2025 09:32:50 +0000
In-Reply-To: <zis5k4oo3kq6dykzm3kav7rlblqvvnk43mrcvlwyxxfgwbpmjt@6r3f5432vr45>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251128-io-build-assert-v2-0-a9ea9ce7d45d@nvidia.com>
 <20251128-io-build-assert-v2-3-a9ea9ce7d45d@nvidia.com> <zis5k4oo3kq6dykzm3kav7rlblqvvnk43mrcvlwyxxfgwbpmjt@6r3f5432vr45>
Message-ID: <aSlsQmiSCC2ZdfLr@google.com>
Subject: Re: [PATCH v2 3/7] rust: cpufreq: always inline functions using
 build_assert with arguments
From: Alice Ryhl <aliceryhl@google.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, Nov 28, 2025 at 11:42:55AM +0530, Viresh Kumar wrote:
> On 28-11-25, 11:11, Alexandre Courbot wrote:
> > `build_assert` relies on the compiler to optimize out its error path.
> > Functions using it with its arguments must thus always be inlined,
> > otherwise the error path of `build_assert` might not be optimized out,
> > triggering a build error.
> > 
> > Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> > ---
> >  rust/kernel/cpufreq.rs | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
> > index 1a555fcb120a..df5d9f6f43f3 100644
> > --- a/rust/kernel/cpufreq.rs
> > +++ b/rust/kernel/cpufreq.rs
> > @@ -1015,6 +1015,8 @@ impl<T: Driver> Registration<T> {
> >          ..pin_init::zeroed()
> >      };
> >  
> > +    // Always inline to optimize out error path of `build_assert`.
> > +    #[inline(always)]
> >      const fn copy_name(name: &'static CStr) -> [c_char; CPUFREQ_NAME_LEN] {
> >          let src = name.to_bytes_with_nul();
> >          let mut dst = [0; CPUFREQ_NAME_LEN];
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Lemme know if you want me to pick this instead.

There's no reason these can't be picked up independently, so it would be
fine if you pick up this one.

Alice

