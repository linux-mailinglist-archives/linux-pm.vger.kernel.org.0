Return-Path: <linux-pm+bounces-33029-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 039EAB34238
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 15:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FF12188677C
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 13:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708DE2EE296;
	Mon, 25 Aug 2025 13:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3MAQ/Bb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465C12ECE8D;
	Mon, 25 Aug 2025 13:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756129642; cv=none; b=FMl3MaN0C9sS9RfQ7YN42WcbEb9fMeOeojdkMlCG02d3jh/bnZw3TgTfvwtMlWbaBG9jIyVVHu4Ln2l0R5t5z1M2N1zZBF/gu81t6+vQ0PauxL5aKMr3HclyZgVy2rc20ODj16ISIUFPFiDZSaPlD9/1Yld2N3gwgIAnI9Qw2kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756129642; c=relaxed/simple;
	bh=hHSPfrmbmvv7OCp2khlK0xKFhHraFQvjruwGJ40eNTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GfIQbOntujEmdZzQj1BntOh1dzdgOkH8IyxyEuApzlF6ztXN8FKKIOOEoFAY2V+2OhaJnpSvAOYHHQYdPEL+zwHO594u0G44F9CE1XxW27XeHi9XXwZ087YjPv0s8SGeQ5HJGwqyT0YjPRukpXmFIaEryTXIdpU0GmexuK25rTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3MAQ/Bb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42F1C116D0;
	Mon, 25 Aug 2025 13:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756129641;
	bh=hHSPfrmbmvv7OCp2khlK0xKFhHraFQvjruwGJ40eNTI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=f3MAQ/BbBZGGw6bigPh1cdJG9ClLgDPYXSz/eD87KzMaH6H7LP8589NmqCX9Do5KN
	 F9XmrafdEIAlvjlKY99n25/cmdQzbWDodIOcEX6nt6cDW4B6tkoPGKqkxBZ6qXB9fl
	 SAH7Ajs40dNf81wLxds1kkrZF4No39NJtDiZcuF05G2mnOEcLPGgZ3WSKbpmDbDwjk
	 fX0rmyGCaj7lc/Lqzc5alrHQGbzvmOmyXpPM0BaVMCS8sok6dG7R8qWppgZayRhMqM
	 vONLTa8dQohzQOcIz/JR1L9+FryDE4ejWHjlXkYEs2mbtm2cTE+gSEtnLtxJ1RR7iB
	 eGaQci5rPWjTA==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-30ccec50c0aso3842130fac.3;
        Mon, 25 Aug 2025 06:47:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWPdVKoTFnlDi8UzezqFVW5zjq+LpcLegucc2g4xyLEqhyhfxfP/1L4pJRmRf0ziV0j7qJ6AZJ3vnTLsY0=@vger.kernel.org, AJvYcCXtUV3T5cmlUU+3Y5fmSeLcU0YefBW1oPNADKNEh6s1oOeG8SugvaOwPCsWwQOIjk2LiECKDF1ruwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIKKHcOvyWPxWwtFXkt0yrOGTvLMqYVgQuLqWwGFnDX3dOc7bg
	70rCjC7K/sSadLqeczIdBZlc9/dNhTXsX5QZHgonDVi7uDlwVw+JhGCkkM9JtEZlLKjWEXKBvvQ
	G5OKciouc6v3BX0qOAyC6Sie4gg0/W/o=
X-Google-Smtp-Source: AGHT+IENfArxDwcDRJo2lK2NvV64pY5qmnRTC1TBytjXGhXffl4QzdO6EyUnlukG8sh5XZBmiJTvjZoxs4yRL/krOUk=
X-Received: by 2002:a05:6871:460b:b0:30c:9b7e:16e9 with SMTP id
 586e51a60fabf-314dce84b34mr5336392fac.30.1756129641116; Mon, 25 Aug 2025
 06:47:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825132315.75521-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20250825132315.75521-1-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 25 Aug 2025 15:47:10 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hfECLZ-SvQYc-VvgEps-=YC3toNat1E9DEFD-dRC0S-g@mail.gmail.com>
X-Gm-Features: Ac12FXwTGq4qIaNgQEwex8Sg8P-vwwZSdUZQVf33s7gerDD6sYlle-N_1zr1Y_o
Message-ID: <CAJZ5v0hfECLZ-SvQYc-VvgEps-=YC3toNat1E9DEFD-dRC0S-g@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] thermal: intel: int340x: New power slider interface
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, lukasz.luba@arm.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 3:23=E2=80=AFPM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Using the Linux platform-profile API, add support for system-wide energy
> performance preferences. This feature is enabled for Panther Lake CPUs.
>
> v2:
> - Merge patch 5/5 to 1/5 (now 1/4)
> - Some minor code changes
>
> Srinivas Pandruvada (4):
>   thermal: intel: int340x: Add support for power slider
>   thermal: intel: int340x: Enable power slider interface for Panther
>     Lake
>   thermal: intel: int340x: Add module parameter for balanced Slider
>   thermal: intel: int340x: Add module parameter to change slider offset
>
>  drivers/thermal/intel/int340x_thermal/Kconfig |   1 +
>  .../thermal/intel/int340x_thermal/Makefile    |   1 +
>  .../processor_thermal_device.c                |  20 ++
>  .../processor_thermal_device.h                |   6 +
>  .../processor_thermal_device_pci.c            |   3 +-
>  .../processor_thermal_soc_slider.c            | 283 ++++++++++++++++++
>  6 files changed, 313 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/thermal/intel/int340x_thermal/processor_therm=
al_soc_slider.c
>
> --

All patches applied as 6.18 material with a few minor adjustments, thanks!

