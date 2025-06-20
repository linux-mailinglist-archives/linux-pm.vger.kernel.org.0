Return-Path: <linux-pm+bounces-29154-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC00AE18A1
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 12:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 730461BC5B8C
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 10:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637A228368A;
	Fri, 20 Jun 2025 10:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P44K86L3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16BA1FBEB9;
	Fri, 20 Jun 2025 10:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750414491; cv=none; b=uUaWSb06yTe4auTyqII/i7CcIAqA6G1M95v4UxvwtoTTErkE6dFELB7DPwCNaqp/dS3LRJYA7Qjyimh58nb/CVmr/NLM0Z6l5udSCqd9oXGZqTPrFvqixuD1akA2B08ewOcO06a5I4W0T1icmVT6A3/sYBoRV2Pt+BR8uUli++o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750414491; c=relaxed/simple;
	bh=0/NydzBglUSC3hLY6MPcT/TYFF4UUzGCsloUfeL5Veo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bqgnIhQfXy0RHjis8qdbWt4/CkHcndtlYVLnVI0UquCxG7S4SDnDfO8dPdaW9qWNJYD2QIrh6g48Lg8+M2M1SwuUiXCUzCf6GCM7oORPmPpb5vspfDYB1CLEGig2+uV7RBUnPxwL13p0o3iRwob301BvwCsMzFd58W/t/ynpwrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P44K86L3; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-313290ea247so294411a91.3;
        Fri, 20 Jun 2025 03:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750414489; x=1751019289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/NydzBglUSC3hLY6MPcT/TYFF4UUzGCsloUfeL5Veo=;
        b=P44K86L3YNKZ/8R1kajnRJrDslwxwCvTTaMKy+RQRQanzLqnJVCw9VUEAmtAF9BNfW
         AlntpnBxWBXjdNAO6ftNSBNHWx/dtgz1VBsuwM85wC6MZUjmmaYnCch1UyvCvgtqpNti
         sgWoKIDkJKLpFOJni4HeuBGkGCNb+u8P1DagcKY4twimGdbVt65rTwRA/rUqJo+xNwdR
         GuT/7QTRgSNojvVWPXJanUDLchgfbo2davAneWJWP2zYgjG4YJ5NoDtADMamvCYZcZjT
         5WGNqRxFhFZSq3oSuaNiISEuBy6TUjVP+fhDzhoaa8sCMyRVpHrAp7vaRpuKi8Uk0LK3
         HE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750414489; x=1751019289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/NydzBglUSC3hLY6MPcT/TYFF4UUzGCsloUfeL5Veo=;
        b=st6AGtiNYwoe6BxxPLjU1iemuYXVbF6CYsvHrd5/agASx7Pi/ApRQUh8VC4Id6oXJo
         Y+7J0GsHkDYJP6nzm5aai9iltEe495Kj5d+/YBY4RoBqwMJs/ToZ+5XLsVbv0qtzRmlY
         QBtBFT9GaVAciSP2WoF7xmnKczUMZucrPxLsE04BpShtL28cVQXgI0zl+3+tolHwkUfA
         zynVKihqGswPe/rrX+sKCkU1GESrPqwh2BUkwcImBZEUsCxGbQ/QAars/QDlKVtFENXf
         Nirjpfj+iqyALMUgmBB13PukyJZGSd6YRxaFOp1oKrYULBZQPxGA/wqSzncgS/jFGlJm
         Qq1w==
X-Forwarded-Encrypted: i=1; AJvYcCW9nnauwb18KF9qtKF6GIJgKKu4Fb5w6e/dI0IJnZmaJ8ZARA1uItmR7XrjX7enXZJjl/PuSbLqrP8=@vger.kernel.org, AJvYcCWFQlcd/xEXVynVkP1CGZe7OVJHv7Rw7EU9abrnqnA/upb2z048RmZ0NIw3jBklljmrZ/iE+5iKiKgqLkg=@vger.kernel.org, AJvYcCXLxEsh5zLsdwubPH1jyqIgYdavQnSfNsy/u4cBsfo2SAHfOdmCbu1FzimQXz2nd+AcNo6uS86mfDwCkEB+mFg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxugeo51A17+IhSqaBqmjBh68eyfz4nFLuL5k7JdEIDe4OkFhRG
	aIwD2esxyAmLc14LGpXovEZriVFgsv2wB7WtKQRp9u5BdFlTuTbcd8p8FQw9iMHlD0u1qMzZzd7
	48G36IMnBkejYsKDKpWNHWHcWo8hdPc0=
X-Gm-Gg: ASbGnctiEoULDrcp/f2zDzpa+TTVmvU0IHBEoN1FYSDeqEOmrI7FTFoYEm01Fud7oTj
	V2LZGwqpZnDUro2L9AQfdO7Y1nONOYQp93b3XfEM5APja0DrJ93WREVtOa+RTi5egiiuNhg+yMN
	97rK6TS+zQAc2mrHtjiWtMsbcZGEyH0VKI9Rkv3dxAOYRGfUOyX7t5
X-Google-Smtp-Source: AGHT+IGLbG03uIdIKjDmZb3/x7pPUaTgeFpfxlRzklJ39io1r9KXnw5eU12ARqN276HzeEn9SJ07vWuNIzIeJzcnrm8=
X-Received: by 2002:a17:90b:5105:b0:312:1d2d:18f8 with SMTP id
 98e67ed59e1d1-3159d8facf9mr1331919a91.7.1750414489032; Fri, 20 Jun 2025
 03:14:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620095920.20765-1-abhinav.ogl@gmail.com>
In-Reply-To: <20250620095920.20765-1-abhinav.ogl@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 20 Jun 2025 12:14:36 +0200
X-Gm-Features: Ac12FXw9NrQ7Z20VT84HWGtqBjMjNPitnvcngGJyK7jRgUS5odM-7SJJbs0OFNU
Message-ID: <CANiq72=OdGRRkxdvSd5bLPkQcfXXFUj4_8LLjVONzpWx5--shw@mail.gmail.com>
Subject: Re: [PATCH] rust: opp: use c_* types via kernel prelude
To: Abhinav Ananthu <abhinav.ogl@gmail.com>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org, 
	linux-pm@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025 at 12:00=E2=80=AFPM Abhinav Ananthu <abhinav.ogl@gmail=
.com> wrote:
>
> Although these types are defined in a crate named `ffi`, they are re-expo=
rted
> via the `kernel::prelude` and should be used from there. This aligns with=
 the
> Rust-for-Linux coding guidelines and ensures ABI correctness when interfa=
cing
> with C code.

By the way, thanks for sending these, and please feel free to clean up
the rest -- we have a bunch of instances of this in the tree :)

Happy to create an issue about it.

Cheers,
Miguel

