Return-Path: <linux-pm+bounces-25266-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F82A861A6
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 17:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D4F018937D8
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 15:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDE41F5833;
	Fri, 11 Apr 2025 15:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwqZEpEn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9D578F45;
	Fri, 11 Apr 2025 15:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744384833; cv=none; b=qw9PVmuPt/Nq6AB5SCmTf3gn0bdOLDATemUw8WUhXonJV1uv7IvJoi86d+yp15PagzRA1a1hdjVDSRYKBZxeRoG8zQRH320DnAIlJc2Z9yHZdkAsxOMYn8lzW2nqfGgPnGDzABlLxop8oUASz1ieCndiDHyTlmqz2PGki0h+RA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744384833; c=relaxed/simple;
	bh=LaqJr2LZX1gmKZMoGldQeuMsPwSCH3VwWbOMCb7vK5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+5IhiDEC/wRQwxD/6PByqoX7EsSUVFIIfA44B/rLocvLFsOdOatOnJjsHvBDt5yE8o1oKMPsUSak+Io4N62EYrKwj2foKTc8go9lDxMZqqz5XY/EV8QCNXCN2uQjTpTPGqkCyp99G4rpNrNlmtkAFUCCMqXdhmIzMYzA7QJNoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwqZEpEn; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22622ddcc35so28499335ad.2;
        Fri, 11 Apr 2025 08:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744384831; x=1744989631; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TozylxmD7FxlSrGmF1xw1E/SWXgnLpz0ZrqGEf5l6NY=;
        b=DwqZEpEnMWDBQ4Q2Inygm6bymCmuHEGhRBBgu0Edii9TiA7A43UPdHYOk6wzrc8sVx
         IVHIAVhFHIzgfY16EKaQM6szgRQuiE6a7SiJ4OcXuNyITguaPkUCmL6BuxmDGhd9k09g
         m+4CjDzAq3SSg7B3a64IJZd6nnlyckx3DFynPHS3UOzkX/o/X1uSpN2Y0gc5IStwy7XZ
         JFZMH7e+LYIwRcUmHOP1vfJK7sGbK87Uog+YvlM0RrdA2rQt/MkEqEB1gKzY6DMqEq3i
         bTlU/q5MqM0oU1PfvNEcautSrWqKPqVqYJa5B6DdUj5YE8YrCb9g8yEHYzvDm9a2ud9Y
         LADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744384831; x=1744989631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TozylxmD7FxlSrGmF1xw1E/SWXgnLpz0ZrqGEf5l6NY=;
        b=oZBlT2jkURJKVQOCnEiLBPsJX9ffFY5TXhYXZMzVOsjq/a+KtDNGyBb2P00wGt7NVl
         tr/rpjBo1pCPKX9HLi5GlhKf/zVXpp1kF4yVrpVg+7gSiCU85/8pIngo7HlAMSfk2JFu
         JZacdPJTWqjjZCOVU94AWcmOv9TpzCwgELlSW6NvJ48dCXZSA2+ipouywVE8sOoJzbov
         ULmhmKYPLUTyIu8x+1VGS1mBG8Izd4vD6fcnIiuoI5CCZ7yjIuaM18FtYxL4opHMWGSr
         ABARArmKgJIG/ePR2f8MjDKJuTHjZcQa/GOuzQNIQRoqVNisQl+JdTYdZEkkUo5HcwYm
         2S4w==
X-Forwarded-Encrypted: i=1; AJvYcCUmJ5hYABdwCrXDrDYiTg5U8jqlWD/zvcD299qTib3poTGZUOiCXVWH1jdZhQtnxCtMW/MU+EOz9Tw=@vger.kernel.org, AJvYcCW+FXwJzjOKfLP6TMZChbOyoVQQNCs6XejzUNbqT6530x7coRtD/UTqjlFMV9aDf5YYqWu0wxl4I+uGjmM3@vger.kernel.org, AJvYcCW6uMUzDII44DfwPAdRsQagMLbUWGYJLxpHQ2xkfHWc7LKQpOH8gQIv3DlSa6sAJc97L3+b649saIhKksuuyq8=@vger.kernel.org, AJvYcCXWQFS57BoydU3hVmJnG7wDAHmRaPm6JwnV8HjC2auMBdv1lk+YgB5/U4JcPmH7BA+J8Yr6/PFRqmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHI43EYZtYpk0N+s2DiUzY1X/TRXOjq6IMyuInevkVtfdOWuVD
	LegGcalqwnH5J5k66ABSh+MUKUbk0QzcWngJiFJE2CGm3/lx4Vxm
X-Gm-Gg: ASbGncsG0Uh9Nt4xh2Tl5vndY2NHUarKlDvb5EmagDjBt+VnI+FYaBtrpFze1eXfrud
	zhlf4ymMo1qKCGeIICXRT0tNyaXBFFHq4UusXkzFfbTxHc/FXuIf0aQUeRsLnZsfFrEgnrbaSvF
	Fwi01t6aiZqVdlveoKg8PZx2KiPbR1tzMn0KiubW8l+G6PcOBj4jnefDMg2yf4bDYJWyoB9QSa3
	RHs9u/L0BnHGPXlV/+WuoeLKhfEfkZcyB2o8x6aLz9DeUTJjmnkX108B4BSThrJNEC82UAbi9iH
	U5g2YBSYD3Yo1QBZkvlIWr3pHAwSnnQcXRmx+Ckq
X-Google-Smtp-Source: AGHT+IHMyC/UR/UB3BGcCMn9fQ6p0UWutNTt1pWz3fG+YVjGta2wmyB6MBlUVCnjdbo5w5A04dTEqw==
X-Received: by 2002:a17:903:1a05:b0:224:256e:5e3f with SMTP id d9443c01a7336-22bea4bd566mr51266385ad.25.1744384830680;
        Fri, 11 Apr 2025 08:20:30 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd21949e5sm1648408b3a.4.2025.04.11.08.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 08:20:29 -0700 (PDT)
Date: Fri, 11 Apr 2025 11:20:27 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	Burak Emir <bqe@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V9 01/17] rust: cpumask: Use non-atomic helpers
Message-ID: <Z_kzO0b43s4x162Y@yury>
References: <cover.1744366571.git.viresh.kumar@linaro.org>
 <b092bbcc23529663b1a8b381efb85566453185e1.1744366571.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b092bbcc23529663b1a8b381efb85566453185e1.1744366571.git.viresh.kumar@linaro.org>

On Fri, Apr 11, 2025 at 04:25:00PM +0530, Viresh Kumar wrote:
> The cpumask Rust abstractions don't need the atomic variants of helpers
> for now. Use the non-atomic helpers instead.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  rust/helpers/cpumask.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/rust/helpers/cpumask.c b/rust/helpers/cpumask.c
> index 2d380a86c34a..ae964cddbd41 100644
> --- a/rust/helpers/cpumask.c
> +++ b/rust/helpers/cpumask.c
> @@ -2,14 +2,14 @@
>  
>  #include <linux/cpumask.h>
>  
> -void rust_helper_cpumask_set_cpu(unsigned int cpu, struct cpumask *dstp)
> +void rust_helper___cpumask_set_cpu(unsigned int cpu, struct cpumask *dstp)
>  {
> -	cpumask_set_cpu(cpu, dstp);
> +	__cpumask_set_cpu(cpu, dstp);
>  }
>  
> -void rust_helper_cpumask_clear_cpu(int cpu, struct cpumask *dstp)
> +void rust_helper___cpumask_clear_cpu(int cpu, struct cpumask *dstp)
>  {
> -	cpumask_clear_cpu(cpu, dstp);
> +	__cpumask_clear_cpu(cpu, dstp);
>  }

Please just add non-atomic helpers after atomic ones.

