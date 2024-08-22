Return-Path: <linux-pm+bounces-12696-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4ED95AC7F
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 06:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ABE4282570
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 04:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1DB38F9A;
	Thu, 22 Aug 2024 04:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="gweVEftJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E88381B8
	for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 04:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724300576; cv=none; b=ngzfS3N+s/RCcAKcSJ2KF3t45dssmJY9B7pzalq5+1QKkaeTEZ8jAAwhIT96fNlhvlha8vTrHUYQyUoUXRkpDFguQqNDCYj65YllwJdTo6PbsMl8rqdajEseV6GlRD+BCz9aQ/ciDmrGFdnbV6jCIhpU8Sp4kdmu3GYURtTDNSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724300576; c=relaxed/simple;
	bh=zEBM3hHwU1lhgPSNhjNvPXA9SB6je4wV2ZfhzZqx8DI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ZUu2IHEfZR33rjsVCx6+An9E3QJlIJw7hqmmXM8Nby76RLM1ySELmAn/RHgN3UkqBFsrSIMATdkUmJqd99A273VMKXkbJzjgOdgpynUh6vKnAbBHm+CAipHysrUEVtuQO9+6IGAVD2QXSnrSQgSkYi1mPCG1i5VV+JpgFMTpe9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=gweVEftJ; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5dcad98e8acso280981eaf.3
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 21:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1724300574; x=1724905374; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/P0vbfAjm6K3LNoQ5CD1IrJf0GFaknx79tF0mwTM7G8=;
        b=gweVEftJ/OKhyQ7qpaQwm1ZPB75C/kl5Fp3hJu6eYQIhiCJ1thaLiVPQs14l8VW9m1
         Xyq5M68AAjWdaofTFUQZwrjn9LxvIMaUnWO4qaD+QLFrCeHuhX1lk+2NujdqS3sLohAs
         vC2VHcjEXcn5YNCByc82K0fM5SsJ9u7mKA8ZEvzq4IZIYkQO9klSzJ7imDcjG+bQzaIM
         G6QeXF30qtQ32+htAQGYhAW72mXNBEXYWuMoVGN1T84ylmDRFV4DSYsxxkTVxmNd2tpt
         zv8SbFqdO2aNQEPLsml8zsIiGpwJf+uUVRtnkol5Y2q/NoQvZD7QhoTSMy82eroivAuA
         EmZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724300574; x=1724905374;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/P0vbfAjm6K3LNoQ5CD1IrJf0GFaknx79tF0mwTM7G8=;
        b=nvl3a9UePHAFbvg5D668J7rnivnp/SLqBQkb2clOcF6sx2N1WlOzmGiQBJ8kiuJZuw
         paP+evM7KY/Wv1kSLOw++qvyjoQRbdxcP2Ifl5fSfwxHVLhMgsLdQB39jjzI+VYVsoh5
         uoLbesp1InUqaDI8myAcEWvnDOZxnTxa/Oi8XCVUzPCgBPofAmU0zdg9iq6j4gneM8Sp
         7RlxaabgHMv7oOx58a1sLPMy6GA1wuE5bxrw/2j1T5EqpRPZAn8OzGWTtWbIZ1FKjkf8
         V3hsgjhoDHgy5tPifLs+8P31cjF4c67D65iFLp9ieY021X0druqX7Wg1Dd5ufofoc2EZ
         nE4A==
X-Forwarded-Encrypted: i=1; AJvYcCU7SPNRTRA+xHnNMzO3faiulk0e8rPeqmglzOOLIIds2KNSO/zdaPDdW2qUVIJDsxABaBc5zZRxFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNR7ymErjhOfinahuJNQEKSknn26rXByXxlSVYvFX7GAHVSqNP
	6ArZoDxdP+rCYrffu69hTGGxc9aO6/P20AqtJbBX2S3u3+93S1HR7gaGCFEvqDVc1AkG/7lNzaG
	a3pUSvVe6KdHGYmDoqixm4h8lQtZT9yENIIpqBQ==
X-Google-Smtp-Source: AGHT+IEpdBLiEt1QeV/r1ArAeTNomsIoxgldSKxTLruJ6FvISHi+9M+Oz1GauKpOvyUFIwwNZXL6T3m6b3lVwcyxDas=
X-Received: by 2002:a05:6870:9111:b0:261:1177:6a56 with SMTP id
 586e51a60fabf-273cfc54187mr874430fac.20.1724300574074; Wed, 21 Aug 2024
 21:22:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814054434.3563453-1-nick.hu@sifive.com>
In-Reply-To: <20240814054434.3563453-1-nick.hu@sifive.com>
From: Nick Hu <nick.hu@sifive.com>
Date: Thu, 22 Aug 2024 12:22:43 +0800
Message-ID: <CAKddAkCa1pZGZRtTLeB0PFK_sdsxDC44EwYmh4f=SFPzuSbG+g@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] cpuidle: riscv-sbi: Allow cpuidle pd used by other devices
To: anup@brainfault.org, rafael@kernel.org, daniel.lezcano@linaro.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, greentime.hu@sifive.com, zong.li@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Anup

Any suggestions on this one?

On Wed, Aug 14, 2024 at 1:44=E2=80=AFPM Nick Hu <nick.hu@sifive.com> wrote:
>
> Add this patchset so the devices that inside the cpu/cluster power domain
> can use the cpuidle pd to register the genpd notifier to handle the PM
> when cpu/cluster is going to enter a deeper sleep state.
>
> Nick Hu (2):
>   cpuidle: riscv-sbi: Move sbi_cpuidle_init to arch_initcall
>   cpuidle: riscv-sbi: Add cpuidle_disabled() check
>
>  drivers/cpuidle/cpuidle-riscv-sbi.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> --
> 2.34.1
>

Regards,
Nick

