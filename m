Return-Path: <linux-pm+bounces-28375-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C09FAD3796
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 14:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CF1F9E13C9
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 12:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BDC29A302;
	Tue, 10 Jun 2025 12:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMpfDpYS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92E128D8C6;
	Tue, 10 Jun 2025 12:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749559616; cv=none; b=ZCXpVdemHH37Tg2ewxK3nlaUFnmxobzeF3zJSPy1RyOiZFNDAqP3fEWSvHjhxy/IY8hiiZLjCOJKgSdD3PYWgSRSkyZjtoATMMTI2tfvlI2rgdK3uOBWicpapJEAar+4iHzgGstjmWtEqbCi+RMegGEBYgL/QJzx8oA0Jw9v6yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749559616; c=relaxed/simple;
	bh=Ya7o+Lr6b2111pfm+fOXNxAnjNXhwd42toZrtju/Tv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DiF7DuDVluxfmjGeJoKFFIDHX0gO+Z+kywQU3sOqrhMXGFSteUDFhYeaO8jvYIhcn35cxKUTzIgl83aXpip2VZnjW4FHnRExKZimL6o+Iyp3yNFVrJNA+WGtUErxEI0bGsQsE3qfGzFYRrwFmMemuSZXaafWJCMrgGVc5qxrP04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EMpfDpYS; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-312a806f002so581665a91.3;
        Tue, 10 Jun 2025 05:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749559614; x=1750164414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ya7o+Lr6b2111pfm+fOXNxAnjNXhwd42toZrtju/Tv4=;
        b=EMpfDpYStcblHhmyNAZ5RZcNMoZkRI52BZTtguCMJjqfs9dqRhLwXK4MWIA8Z0auHF
         TPikXvLs1ekiBhxpx9opho7gNdRbcnf8rKd7RMRgtsfzDILX9uGQm/USDCPetdTdEDUq
         rKGWywT97RS7WDuD2t0Y8enDWTgFzTWDZvcIdBiEZWQ1Png0Bshs5o2VR/2KmYXJ/bmc
         vf/P7kVJl/Ci9/2QER40yDPd/KCGvO8vPSYevsQQBzU3ouMURIkwLHWKABLsan1MVKdV
         pymBhfhRkm0O4Fxu2GFVTCuOSwowMbpi1XSEKpkeNEz+M9+3OUKDoDFAsd9rFxKk1x6C
         5+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749559614; x=1750164414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ya7o+Lr6b2111pfm+fOXNxAnjNXhwd42toZrtju/Tv4=;
        b=WCkRbkQOfPZ54qdSOSdZz8tGJXCeJOvGl7EbZFPU9LgEdr1KHdD3V+y2wl/HfufNSd
         nK/Kv15ynLfbCo8WKDQdNY2PvNoNBQ4Th+YRtMtEW9KtPqcdcBoHJd4Vy07Fhyv9p3uz
         HzOtye86tQ1MGuYcBcbIbjPEgS/to7tNy6d05/uiWC16Ktyu38U+nujq2kD1ruRx5/ee
         3XfckQEx+fjTc1ILWLfjqYOp74sDsSkkKP4b7lywijyfOvkmAPUmdRiwiVIcn736juei
         nEkAPbvpIrbOhlWkE5Ngvs67oQt7Vr+/CO4UXX6de2qpJ2h7b2RmFn9mtOIMCrbxDOX8
         6CWw==
X-Forwarded-Encrypted: i=1; AJvYcCV/LesQsd2aCs/4YLU4Okk7PdkJgx9ZUQhgBw2i2eNmUpDt7noio3bHNNJuNaEV9AbDiA3HwmKPqyoyEDBEbqk=@vger.kernel.org, AJvYcCWxup3cI7k34IxBBpc5si11E4GIzesgQqIjhh2DNY+tybZSzlcBD4gcI9vTwsrHmB5PDLjsV7sA4qQpiBg=@vger.kernel.org, AJvYcCXcb1d4LPIwYCobwParw/iteivtBiR/EW1CPfkRbJqN0cF7IAAjzyLmyeEU+mB5qFCu3W+Q61Xysoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF8SnPKDN3LVT0wKbhR0Gw7igfjom4K7E/fDsfGNxvASoXle/K
	vhTW3OjA2PVFtUITblZ4ZLxRRbaVxFIDFigahtZfLUqosIp6bEGkOvVav48E0PmICI7ts7rv4Wp
	ono28cpytM7tQn4pX3QdBnUDa0StWwlc=
X-Gm-Gg: ASbGncsuOpcc7FEyOVMh2pSs1nzCtsLlqPqwejeTd73LpuGNayuxGi15s06DDme2PZY
	V4TInDAvAWjJc3p5ncwFQds/YUsSf0ZuwveZ2Ju1T6/VZ93rIsgXf/rV6v+YhR7OOAAwdl2JiWw
	R3fSgbGXAgcfhHu4Zq5UKF2USPqXipgE7N6CiT/jQN77E=
X-Google-Smtp-Source: AGHT+IEak5d16e/5FrsMogvb1aEvjHnaJk7Qj3Vrs9GwfeQHFh/sg4iyrbpHnOUv6MegVuwuZCa6n+gnNmqXuYGQFIA=
X-Received: by 2002:a17:90a:d006:b0:311:e9a6:332e with SMTP id
 98e67ed59e1d1-3134ded1839mr9415395a91.0.1749559614021; Tue, 10 Jun 2025
 05:46:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72kORZjTe3tPEBueDi57TGF7KfxgTSw4Tn0DQeK_X5hi5A@mail.gmail.com>
 <20250610123731.194853-1-trintaeoitogc@gmail.com>
In-Reply-To: <20250610123731.194853-1-trintaeoitogc@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 10 Jun 2025 14:46:41 +0200
X-Gm-Features: AX0GCFtd5VuHi7D87lqv4TVaYUAR41PmcpqldSut2APhu3FYkvxSfE5YRo6MsDs
Message-ID: <CANiq72mtY6rQekToxOSWDMVs+0Sdg0NqvNBJn1zRLTKexSmsbA@mail.gmail.com>
Subject: Re: [PATCH] rust: module: remove deprecated author key
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
Cc: a.hindborg@kernel.org, airlied@gmail.com, alex.gaynor@gmail.com, 
	aliceryhl@google.com, anisse@astier.eu, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, dakr@kernel.org, david.m.ertman@intel.com, 
	dri-devel@lists.freedesktop.org, fujita.tomonori@gmail.com, gary@garyguo.net, 
	gregkh@linuxfoundation.org, igor.korotin.linux@gmail.com, ira.weiny@intel.com, 
	leitao@debian.org, leon@kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, lossin@kernel.org, 
	maarten.lankhorst@linux.intel.com, mcgrof@kernel.org, mripard@kernel.org, 
	nouveau@lists.freedesktop.org, ojeda@kernel.org, rafael@kernel.org, 
	russ.weight@linux.dev, rust-for-linux@vger.kernel.org, simona@ffwll.ch, 
	tamird@gmail.com, tmgross@umich.edu, tzimmermann@suse.de, 
	viresh.kumar@linaro.org, walmeida@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 2:37=E2=80=AFPM Guilherme Giacomo Simoes
<trintaeoitogc@gmail.com> wrote:
>
> Maybe, after this patch we can make a checkpatch change for check the `au=
thors`
> key (and MODULE_AUTHOR for C side), and throw a WARN if the author is a n=
ame
> (not a url, or "rust for linux") and don't have a email address.
>
> Unless you guys tell me otherwise, I guess this is not so priority.

It is not a priority, and even if it were, it would be an independent
change, i.e. not for this patch series, so no worries :)

Cheers,
Miguel

