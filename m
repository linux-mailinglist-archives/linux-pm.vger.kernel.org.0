Return-Path: <linux-pm+bounces-28541-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE65AD6F95
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 13:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE5D93A4415
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 11:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA86522A4DB;
	Thu, 12 Jun 2025 11:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMq06Whv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635AA223714;
	Thu, 12 Jun 2025 11:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749729347; cv=none; b=WtdxiPikveMbdTv6ZYXvn0SVIifx91ptKUq8GPj3FwSdfh21vhl7MrI5YWvxjirM0Ah+3/x6UOZCoMp36iGMe93sU7hSSh2BcWtwxBTC8aUx+6gGUqnIqzTqmsw6DltIHxrAtlnXRLhTOjVMmqPzX3naKQCwDi+3jnRo8MbtKRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749729347; c=relaxed/simple;
	bh=4jtY07w7CqFvyQ56olcIlj5IIKBtW9w+utsjhz0iD20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B3ORfa/8GqvTdukXQtDiujjKr1lFoFEMyi0pkqy2LAUMtgQaWRVijp1X2Cmv9juX3KUijlzOCkl5TxXm6DiughSN7VlQPSOxviv7eW7bw5ElPO2Lwd0XinURtl9miw4cR3KyMOXW8Ix4nBrI7wc7gwoZxHj1m4n9qknz1dWlDTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMq06Whv; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-313862d48e7so183975a91.1;
        Thu, 12 Jun 2025 04:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749729345; x=1750334145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4jtY07w7CqFvyQ56olcIlj5IIKBtW9w+utsjhz0iD20=;
        b=gMq06WhvqBmjUOVzeuG5Uch1oZbhY/lGNhQb2A55bim0lPQ/++niP3dMxxTD0laruL
         lIOVSdBjYC5AQFgIMlwl0P3/KJckdsOEYoAMDt61mOl3CGnrptI9SXnaWa5fxFce7ayQ
         vR9QYiwlkb3/E2mD9Nnh5x7pxAmPVs3gd4/r4qjbTTFCSPCCv25XouZZoUx4Gr06KoCt
         4VJ2CrorWzhwm2NjSFmxY5WIbFFwm6ZdGVR2gYD7t3MtCJrKBIjykg44jgQJ6CfXbkCv
         O2UJFj9bZvHAHTDKXczV506IYA4mzXM/PsVaBNotdVFzVYLVysiXM7O0+osJX2cpr+oY
         KxXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749729345; x=1750334145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4jtY07w7CqFvyQ56olcIlj5IIKBtW9w+utsjhz0iD20=;
        b=aaguHzHb+d8J4t0HmcUFsiokQPlGoGs9nWeJ6DKVvFa7uMQkMa1E45XaRNYbcvsgKC
         pOARbXx9YLbw2j32AR6K8aEjj2R52Ko1EDFLJTrSQTkfILYgcRkkj75biYRBsKZBl6Jr
         W7lzHWoWmyKUUwoUoZ3eJTQ+OlPTs+wAEKe5NifMlrxzsgaw92tsnQWnkJ0AOB4EHeMN
         /87ylzUd6qJZilm4ud0QX0jz4Bf99gDgGUosSl6Xo6L5X+dqpMoKnl9ccaP2L1yRUeMb
         NDz9aD/ZG7weY7jNR7S+tqmAcXms7M0HFl6fe7hdp7KSdS8l/bV3LS7sLb2tnjn/5XGG
         787A==
X-Forwarded-Encrypted: i=1; AJvYcCUQY37KHtJsWvscMz8aWD7yZiZ2uGOqGzdj4ZomctYEw0n6zfNNf/EtWize/YGVF2Sna3/8dvxTk+IaYCk=@vger.kernel.org, AJvYcCW06noeF9iSG12p1h0H7zMxOMZTf3o87kOOWrDkFc7Ykd/yeaMtS8i4iu7wjBfng4D1Ft0pdNJolIwludawXRI=@vger.kernel.org, AJvYcCWxLEr10fmmssCF1LC6H9qiLVlR5VuzOBmDCnbtrFRq17g0y0hCmkA+g6s9Xo2AeUDwO4rsmNNoyFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YznrlaG8baGNx0Go4xbJy1aZWJ6bSgOjzdlfym9L01lieL5HBFD
	d4TZt57DRrlYVYNCkyB6R6Pw0yjP7GUDzlMnPVeD5ylr9Ofn7pCW5eXD8eWcD84Fn4LLvwk84Az
	8DEnVXA6TcYufdQEOBQWh8EcvQZ/BhCg=
X-Gm-Gg: ASbGncvriy/odplBUJB7T2SKXbvzGiy0WhSBuZioM+unZWdqK3EuE2hp5WMtYW194zL
	mnXVgY4/FFis8zzwcWR1lvcS8pBzaMvaMsvI1qebsQU50AWqwTg3ra8qHFERTbeYKK5nn/UE8CE
	PcFh9GpCTvQAPh8WhynJb29wn3ImPd++y6JxIRSowSD2g=
X-Google-Smtp-Source: AGHT+IHEVUQMd5qwB7n+n3wg9nXXrJmm7nQXn3OMFP07d2fU6W8OIt3bUE1929Z0dsVTCWQaSa7HsRf0tlSUrkLwgeQ=
X-Received: by 2002:a17:90b:3dc8:b0:313:2bfc:94c with SMTP id
 98e67ed59e1d1-313af225ec2mr3693734a91.8.1749729345602; Thu, 12 Jun 2025
 04:55:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612104127.10299-1-abhinav.ogl@gmail.com>
In-Reply-To: <20250612104127.10299-1-abhinav.ogl@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 12 Jun 2025 13:55:32 +0200
X-Gm-Features: AX0GCFsJ9kBJogYuSgvtqrfjdhpbq3ylYegjcsDPR1Ya_6A-iLyk-dlUDxHTZLA
Message-ID: <CANiq72=8rHB0bU0yUf_tkVG4LzGMUmLVrZHHn6VU584_JJ_obQ@mail.gmail.com>
Subject: Re: [PATCH v2] rust : Update the bios_limit_callback to use the C FFI
 types #1170
To: Abhinav Ananthu <abhinav.ogl@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 12:42=E2=80=AFPM Abhinav Ananthu <abhinav.ogl@gmail=
.com> wrote:
>
> This change ensures the Rust function signature exactly matches its expec=
ted
> C counterpart, avoiding potential issues with type mismatches in the FFI
> boundary.

I think this is more of a cleanup, since the types will be the same
anyway, which is why I suggested using "Suggested-by" and "Link"
instead:

Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1170

The title is still not correct (misses "cpufreq: ") and it is very
rare to have issue IDs in the title ("#1170").

But there is no need to send a new version just for this -- the
maintainers may want to fix it on apply, so please wait to see what
they say.

Thanks!

Cheers,
Miguel

