Return-Path: <linux-pm+bounces-40949-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 357E3D285E9
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 21:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B173E3009772
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 20:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C2131ED83;
	Thu, 15 Jan 2026 20:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+dIDRPM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71461318EE4
	for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 20:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768508365; cv=none; b=iXIwJ+NR0UdhSjl6hl1aeoSa/8ChaXyfYteumWZnQsyg9XQ9hfBtm0YZk8vtxEukr+KYvg8cnOZjQLH0EV7ZLJuDEjKvgD+TbOz0C8etL9PlPyClQ6FOUd8pxy9y+5yIGhfP5wi2Qj3amzfO/NnKk395RBwwcizBXYpI8D80bFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768508365; c=relaxed/simple;
	bh=D+9Qly1Fgsq3losB67Sm4tT9opvyDpiVd2qHD27zmYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IG7Vtq/VtEmiY/WrNK6HroTsMyabirQt1GWLokQF8zVWYGEqB7NVkI9romrtYAtFR/b2R3b7cosvYAfwM3qH8SwT98mgEeEv/GU2FV3geV8aATuFEDZCRfEoSAJy7deQ627BYHOg6oqxtXI0vFXcP3dLbIj46qwtZUMu+zJnKUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+dIDRPM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D8AC4AF09
	for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 20:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768508365;
	bh=D+9Qly1Fgsq3losB67Sm4tT9opvyDpiVd2qHD27zmYY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=g+dIDRPMo6aWR44SSf1kvfsTn0jyIybV/6eT0pZ33/RqS/Kecfdm1JrQ4zu96NSYs
	 EfUMSTvOirs4CpH01stYOqDACR653/8ujs2pRSPyVf5z+wrFeC2/+hdWqXa04Kt0Wi
	 VKvTR2muwwcXLRNqWZDGs6WZMo+9gdNFwIs8KL42wqAkWXjhIRU8C340N0PBofbhEX
	 8ReoZS34cnMCjZc8UFeEmKT6biDWZPf4E76wBsx+Uxy36d0C7+43IinBWHt3xAwQjF
	 FL83GLqdiCQSM9+i0Ot++UTSusmbvQwb+Z2cgJc3/DLEEWJJU1oPH6teJJDKUSxCDm
	 GCECJCG/xSp8A==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-66106a2f8c0so367292eaf.1
        for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 12:19:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWIyIoPyyIKooyh39Ouyycs/PyXApgFA79VVhbvx28cSQcQwI88fdBCX/9bMQ8IRe+AP59nDHkivA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yza32Cmknl/0ZVKU+6iwMDtTN/Xd/E2zwmFnNImPEDdhT+XBJVd
	rTuYGYxiJGCkOvRO76VA6YfhNxoRikcZplRwv5FplWhBXxl9R3RDitcZ49KH/zs4zdWmU9NBcMD
	QoJFVi0FfCMTQ/cwBvq3wrkKLP0Wa9BE=
X-Received: by 2002:a05:6820:1507:b0:65b:32b4:840a with SMTP id
 006d021491bc7-661189814demr189418eaf.51.1768508364281; Thu, 15 Jan 2026
 12:19:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260111160739.15984-1-sumeet4linux@gmail.com>
In-Reply-To: <20260111160739.15984-1-sumeet4linux@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 15 Jan 2026 21:19:13 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gUBQgJHdhum4Q94XzeF+vMDbjdeeWUXMTE=UrJg3nT2w@mail.gmail.com>
X-Gm-Features: AZwV_QjBRzQ6YNyTvDh4N6Ex2vyAlHFw07zOUWAFBezyMT6LS8l3JB8WKz-vABQ
Message-ID: <CAJZ5v0gUBQgJHdhum4Q94XzeF+vMDbjdeeWUXMTE=UrJg3nT2w@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel: fix typo nagative in comment for cpu argument
To: Sumeet Pawnikar <sumeet4linux@gmail.com>
Cc: rafael@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 11, 2026 at 5:07=E2=80=AFPM Sumeet Pawnikar <sumeet4linux@gmail=
.com> wrote:
>
> Fix typo "nagative" -> "negative" for cpu argument value in
> comment section.
>
> Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
> ---
>  drivers/thermal/intel/intel_tcc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/thermal/intel/intel_tcc.c b/drivers/thermal/intel/in=
tel_tcc.c
> index b2a615aea7c1..ab61fb122937 100644
> --- a/drivers/thermal/intel/intel_tcc.c
> +++ b/drivers/thermal/intel/intel_tcc.c
> @@ -172,7 +172,7 @@ static u32 get_temp_mask(bool pkg)
>
>  /**
>   * intel_tcc_get_tjmax() - returns the default TCC activation Temperatur=
e
> - * @cpu: cpu that the MSR should be run on, nagative value means any cpu=
.
> + * @cpu: cpu that the MSR should be run on, negative value means any cpu=
.
>   *
>   * Get the TjMax value, which is the default thermal throttling or TCC
>   * activation temperature in degrees C.
> @@ -199,7 +199,7 @@ EXPORT_SYMBOL_NS_GPL(intel_tcc_get_tjmax, "INTEL_TCC"=
);
>
>  /**
>   * intel_tcc_get_offset() - returns the TCC Offset value to Tjmax
> - * @cpu: cpu that the MSR should be run on, nagative value means any cpu=
.
> + * @cpu: cpu that the MSR should be run on, negative value means any cpu=
.
>   *
>   * Get the TCC offset value to Tjmax. The effective thermal throttling o=
r TCC
>   * activation temperature equals "Tjmax" - "TCC Offset", in degrees C.
> @@ -224,7 +224,7 @@ EXPORT_SYMBOL_NS_GPL(intel_tcc_get_offset, "INTEL_TCC=
");
>
>  /**
>   * intel_tcc_set_offset() - set the TCC offset value to Tjmax
> - * @cpu: cpu that the MSR should be run on, nagative value means any cpu=
.
> + * @cpu: cpu that the MSR should be run on, negative value means any cpu=
.
>   * @offset: TCC offset value in degree C
>   *
>   * Set the TCC Offset value to Tjmax. The effective thermal throttling o=
r TCC
> @@ -267,7 +267,7 @@ EXPORT_SYMBOL_NS_GPL(intel_tcc_set_offset, "INTEL_TCC=
");
>
>  /**
>   * intel_tcc_get_temp() - returns the current temperature
> - * @cpu: cpu that the MSR should be run on, nagative value means any cpu=
.
> + * @cpu: cpu that the MSR should be run on, negative value means any cpu=
.
>   * @temp: pointer to the memory for saving cpu temperature.
>   * @pkg: true: Package Thermal Sensor. false: Core Thermal Sensor.
>   *
> --

Applied as 6.20 material, thanks!

