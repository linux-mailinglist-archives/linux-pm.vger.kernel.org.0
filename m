Return-Path: <linux-pm+bounces-28313-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AFCAD2522
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 19:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA0B37A61CB
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 17:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952A021C19A;
	Mon,  9 Jun 2025 17:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwKvVOIM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CA1182BD;
	Mon,  9 Jun 2025 17:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749490811; cv=none; b=OEGlLvjEnUufYH3TVdC1cumHN/eefGbGjoDRaA9UUeojguJ5sV+Javfv/507mlzUEECfUImFFLVZJ7wE9qzDR9mrDOSPEOWIsnOYgxG9BQmvebzxr13TjydZpnmeoDILI8CMlwLCCbh5+jsYY4FHQ4t+dOj5ztNBvwLc/nPvqpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749490811; c=relaxed/simple;
	bh=RxlvcvUd9Kh+rPPMV9GEjRZKiwwXVXr3gSSrU32QWTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vb4q0r0saeuEySHFRIdW32+DaXDUcEYGpV/WC/sNnWn+ND24XSy75v4YuiB5Wni3ySpSGE1+q72U0Bz40J5nIzjnKtMNB7p4gZ20APOJYzXj4I50Rl9vJ/xtaoblIHJxXUR8wE6VhCn1T5qFmf58cGuJOGc6Ons9gvvWYvoteb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwKvVOIM; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-234a45e69c8so5694885ad.2;
        Mon, 09 Jun 2025 10:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749490809; x=1750095609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGeznkUaKCcPLr7t1/y1lEo9GbVM0sYWdQrm6riBKNU=;
        b=AwKvVOIMB+p58egfsR7URozn9MEzBQUp5giLg3CfppXxKAMIJDRfsiKcD36pGo1m6J
         XwGIiuM2SF8grzpNOX46umGuOyJ91gyWunOTMoQxOEEdZcX3tv6eEZnYccelqtr27ilp
         NWdo4m1/zH6USUTGZ+F/5J3PjRagnbgXGvgBHDhWgSLst8ZiTyhJU0pHv7PjJcd9kEKr
         wk/XdCMm0pQbRM1EJY9rsHSpERgFaUXA8VEZJw8egO1fW4z1AwQr6vG55NQzU1g+PqjD
         wE/dnybWAWEPRBewKZMMlOuKOONMZEcJCNWsb8Fk1VJSTZHsMLYcBqFAY9TejycT7/+3
         ezhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749490809; x=1750095609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xGeznkUaKCcPLr7t1/y1lEo9GbVM0sYWdQrm6riBKNU=;
        b=hzHAf4aItQnrkNYWJoSLXCcY+/yztz36NhQEpj9DaUhYKx30HXTFfCUel84pLO00LS
         fy3muaoQjeVuNc3U0CXq9HIMHxqhEq7Gi+ae6SqwQkku0ExjtEEWHGgodppZzMiC8GLF
         VG5GyVsDJYVijx82hnVXHd8YaPGErVEp6k9wE5WRoCBE6FJP5Ndk6L0xMtLdAn1gVveq
         6PI1lABMyt1JgsO3eGuzXhetMzK52w6AGVX5tSMhyLH3/O/mWbqFe/jVT3TC/p5oMjL1
         kmEh4+elfYQhBzG05qPOtrM3HBlhfqUeV7+/iAb4JsmG45sBSH97sTzLuWLTtLj8SsDw
         BR3A==
X-Forwarded-Encrypted: i=1; AJvYcCVDcsW2DiUfwE/lkVdgJ6LXNrarjOx7PQY8MjucV4GF64Nj5BvYUF8W8VILIBTU6hyeJgzTgUqGhGLqg4Q=@vger.kernel.org, AJvYcCVaAtQxjgP2hScO4RU8v6O/D6XwhOelhD7m45MAWgSUecwbei8tZgAcAFixHlmgIWFN6R1JRcSWnqOncGukxbA=@vger.kernel.org, AJvYcCXUnDqhxEC75lq8cZ2432CZJkszOLbE2wF98Ib67bsgpFMxZiG5LlID0TaVWXN9ENNdG0kKC608hHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhDGqLOOiqlocweev3DrvAHopilljmNwQBNaR1WNgMznhIkX+F
	lDaSznOY6o8J2GndJqjSrj2aBQ7sEa4D5EMKkJ3N9lgtV5fjwxzV6P/W6uijrZ7f+YcfcRXMdmt
	jh05aa53Yia8NbRVEUsUc8KKXmczMpR8=
X-Gm-Gg: ASbGncvUaIVzFsSq0Ez4nWKHxZPAFDPtkSPFxZeaWB47yvPU6CtrvmvARfSG9t1pf9Q
	O3mwZXXPNTA9zIEzL6CnZe0fRwijd+xh1/3aYZU2eksBGxYOYpe7AcYpbrPMSBM5XJyNluQcHXK
	srwjVWIzXXXTo+9RZaIuX3fbGUYbwHH7KMhHAPpjYTEWw=
X-Google-Smtp-Source: AGHT+IFThlC3n9covTxeLg3gK9Kv9OvvHHRuR1HhvfFCCaCGVX93rTuPcJWuuY6ebE2DHabcjVjjFluviWfrbtz9GnY=
X-Received: by 2002:a17:903:2348:b0:235:ed02:2866 with SMTP id
 d9443c01a7336-23601d2278emr67580725ad.4.1749490809234; Mon, 09 Jun 2025
 10:40:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609122200.179307-1-trintaeoitogc@gmail.com>
In-Reply-To: <20250609122200.179307-1-trintaeoitogc@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 9 Jun 2025 19:39:57 +0200
X-Gm-Features: AX0GCFt_1gEBX3323QkaeUgTuypBv0Rlai8JsNNbMvX6Wk8PlfCLW1weXoSbCmI
Message-ID: <CANiq72==Xybm956Ete95e3YH7MTresNd3szxLg7GdzvhW1O+jg@mail.gmail.com>
Subject: Re: [PATCH] rust: module: remove deprecated author key
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: rafael@kernel.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, mcgrof@kernel.org, 
	russ.weight@linux.dev, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, aliceryhl@google.com, tmgross@umich.edu, leitao@debian.org, 
	david.m.ertman@intel.com, ira.weiny@intel.com, leon@kernel.org, 
	fujita.tomonori@gmail.com, tamird@gmail.com, igor.korotin.linux@gmail.com, 
	anisse@astier.eu, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 2:22=E2=80=AFPM Guilherme Giacomo Simoes
<trintaeoitogc@gmail.com> wrote:
>
> Now that all in-tree modules have migrated to `authors`, remove:

Nit: I would have said "most modules", since we have new/remaining
ones (no need for a new version for this).

I think this patch is OK -- we could wait to do this more cycles, but
if we are doing it, then probably the sooner we do it, the simpler.

>  drivers/cpufreq/rcpufreq_dt.rs        | 2 +-
>  drivers/gpu/drm/nova/nova.rs          | 2 +-
>  drivers/gpu/nova-core/nova_core.rs    | 2 +-
>  rust/kernel/firmware.rs               | 2 +-
>  samples/rust/rust_configfs.rs         | 2 +-
>  samples/rust/rust_driver_auxiliary.rs | 2 +-

Andreas, Danilo, Greg, Viresh: if nobody is against it, I will apply
it this cycle. Acked-by's for your bits appreciated, of course.

Thanks!

Cheers,
Miguel

