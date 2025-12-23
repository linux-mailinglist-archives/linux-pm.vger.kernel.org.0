Return-Path: <linux-pm+bounces-39837-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A692CD9094
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 12:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 420E030424A0
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 11:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD602311589;
	Tue, 23 Dec 2025 11:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IeJGzE6j"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A252DE718
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 11:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766488128; cv=none; b=GzrrquFdAmVrn6Mbj5HjcpSVoBRFVT3EnYfRwYUKX1PfbMnNiBc0i6TYR+p0RWOD+6UwkMgB0R3dt+CgtdPmcCUcWEqM1qc5Y+XJqQaRFan98NePZsk50Ex45dkGxJnryR/zBR6+I5Eql/6jiLGAcwnJjAbr5puTSlu8cGekwCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766488128; c=relaxed/simple;
	bh=JvZVnG41bjEk7nGJo1WJkjBo3r5rVIgF3kvf7n7gRuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tDVz1Gm4hMR/bnbyTN4bMjJVw03Imfnh36m2tu5+u6yAOJg5ogmML1D0SKfGPsrKR1WNqEZYaAuukK9g/kCfL9/v1qcCpgVEYPkJN3nJjxNmunHEbc0ZRB6ohijLUnNgCIJjL3tdDi7zVeIpWFUY2eo1atV8X3Y7NFMjyBCNYoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IeJGzE6j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA1BC19422
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 11:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766488128;
	bh=JvZVnG41bjEk7nGJo1WJkjBo3r5rVIgF3kvf7n7gRuM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IeJGzE6j9ACH9tXtHp5kzep8E1hM+LZSsTA7kYuoc+9Oi5vtBypeAcIo5b0kYmxHF
	 OYk1UZg2AEWkm7CkUFggtFuGbdtTXAcNjU43wUKn8274Ts3z3RLn39qy0/KXV2axho
	 wBqLzuC1IQZt5pq0Dr9bhvHhR2PB1MNJ8DnIzfzdtoVQ0XHCeWTTGQnaHYyOO2+rTL
	 FunkJynfvqnXrV8dMx28I3ZTG54dLfgRLqiBK0ngpChwd3Z4DpNF7qW2CPnFuhv+Lb
	 rMTCUuNR64IBpUDq9oHXi50yjzQD7flsmZbkVh/+voM46KgacWxaMTApXXbwThENte
	 lGNvi6J5UIeKg==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-45085a4ab72so2770374b6e.1
        for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 03:08:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVu0s8oDNuck4YboxY3ckwSgfV5JAReR0ShQ74l8Nf8Ezijbg1EcCcQQoJW/zGjUAgmK2wsH0Pg8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3de4BdjmU3EgoTp7iWAfzPzAl9tvDL5wGBgJzby9H8cLn3tcE
	2Uale3NwOeHhJP+nUWfa1yNvtO4GHVOFDpcGuMpnYjM76DHYhe+kN0wI7J667M2ifVZKOsTJbjg
	GIHyjRO+aA4tb9UG903GiU21TzJZqFMo=
X-Google-Smtp-Source: AGHT+IH+5QdxPI0Dvw9ckxQx3ZVXGzj+GgXLgcGj71V6QLmvOsyRVpWnwYJ/hMru7fkmRxgaZsNU8TuMq9KwsRMmjKQ=
X-Received: by 2002:a05:6820:1c9f:b0:65d:1636:5432 with SMTP id
 006d021491bc7-65d16365b9amr5185755eaf.65.1766488127464; Tue, 23 Dec 2025
 03:08:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218195150.3872795-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20251218195150.3872795-1-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 23 Dec 2025 12:08:34 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gbZrbk5fWNF9iAvwfJo1aKBVF52++_s0HicRrKr4V2Zw@mail.gmail.com>
X-Gm-Features: AQt7F2qOLW4sI6zT2Gb_I4rBxHv0eaITYgypleMaTNcES7FJUmZ43B30r9bKHNM
Message-ID: <CAJZ5v0gbZrbk5fWNF9iAvwfJo1aKBVF52++_s0HicRrKr4V2Zw@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel: intel_tcc_cooling: Add CPU models in the
 support list
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rui.zhang@intel.com, rafael@kernel.org, daniel.lezcano@linaro.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 8:51=E2=80=AFPM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Add Panther Lake, Wildcat Lake and Nova Lake CPU models in the support
> list.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/thermal/intel/intel_tcc_cooling.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/thermal/intel/intel_tcc_cooling.c b/drivers/thermal/=
intel/intel_tcc_cooling.c
> index f352ecafbedf..92de161e359a 100644
> --- a/drivers/thermal/intel/intel_tcc_cooling.c
> +++ b/drivers/thermal/intel/intel_tcc_cooling.c
> @@ -65,6 +65,10 @@ static const struct x86_cpu_id tcc_ids[] __initconst =
=3D {
>         X86_MATCH_VFM(INTEL_RAPTORLAKE, NULL),
>         X86_MATCH_VFM(INTEL_RAPTORLAKE_P, NULL),
>         X86_MATCH_VFM(INTEL_RAPTORLAKE_S, NULL),
> +       X86_MATCH_VFM(INTEL_PANTHERLAKE_L, NULL),
> +       X86_MATCH_VFM(INTEL_WILDCATLAKE_L, NULL),
> +       X86_MATCH_VFM(INTEL_NOVALAKE, NULL),
> +       X86_MATCH_VFM(INTEL_NOVALAKE_L, NULL),
>         {}
>  };
>
> --

Applied, but I'm not planning to send pull requests this week and next
week, so it may become 6.20 material I'm afraid.

Thanks!

