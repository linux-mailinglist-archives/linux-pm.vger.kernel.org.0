Return-Path: <linux-pm+bounces-20898-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89715A1AB6F
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 21:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BC9C188E91C
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 20:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B571E491B;
	Thu, 23 Jan 2025 20:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9jfMnRJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC771E2309
	for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 20:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737664193; cv=none; b=DV0m1+mIxe8m46MRiS3JJTR1vwuvtheRjAaF98qlAyRqdPCIzW7+gnabF+/WeLW0vzk55kUgUrE6eVoiSWJw0OnnpAKd6G1bp4MxcLHsgOD4fv2ZIePCg7o0uQJLVdPNkmVi+z7bpLfLQ9Eg98+ITBevYBXJ1onRN+bbuOVNrmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737664193; c=relaxed/simple;
	bh=CRCcmpmgV2SBB1EZBlP2JwukoXszsF24QHnV4i3CVIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cKQXMhShH5I7dYE8OFzQSDxGB5fD1+7JkcDv1F8jth3fO7ERZ3zLDUorV470LKWl8AoI2bxBvv77OLLiRP9hFfzMCX+1CJUuGr2hIVWwBnM2S3gyySmOappVfN46lFn65lM/qpbN/Y32G+uThkhrGh5bXhRPCV3j0VSfej1AnxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9jfMnRJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACDE3C4CEE5
	for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 20:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737664192;
	bh=CRCcmpmgV2SBB1EZBlP2JwukoXszsF24QHnV4i3CVIk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Y9jfMnRJZP/IpKPRnHo7HnVAKhZ+ktiCcpo5fy/ULH3QJG77M6h+3m59Im+WaHUpq
	 TWO6MFRVXFXlc14ENlwq1FchO7OlquSpg8flpQXu/ZS2l1OiIZd3+OqCuX47qxlyTI
	 Bv2f9DYSK32DPD/4yF0EKesQaJ9pEQXUm1km/9bh1Ad89sUnSp84j3O14imLoRSrDr
	 dyYCdvJx7OB9hfki2CiXpRjFnL1vqjcrTlQldyNQi2FMXKJS8Csbg5NKDKrr2OWcwL
	 dCybg8baSWSCsFraxdnwMF+HTfBD9bwp1HWJSYmYmi+ab/pHECSS8GvU2qYfTbGfvt
	 JhE2ZbPsqWaBQ==
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3eba50d6da7so352185b6e.2
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 12:29:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXwSFvggynQZM3xXQD2MztBY0cHpbYJywyTqPwDhkQOtc7h6fHBHApkpzGL4NKV0MRFJ9ZIvYJ11g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDGqT+8nYOnnHIZ0XgJ/bETwYAgJLgOa5zHWWAL+CfeCZU8+vU
	HqVrjB0JMok8JRlVGfqohoBBjqDDPsacKfjBPm3V9lpyktqR3JaFOmwUBGkGhQ/DsHQr4SgfiA+
	hfWjRq4xT8sYaUY7/E+wUXW5/fcs=
X-Google-Smtp-Source: AGHT+IH9bKpFXGu8g+AWV6mds6xCblKD6yRW5PdCInzTrsDwYuc5mrW3ALB50irNdACxfG27ev+7oPTASLm0p4uHeRU=
X-Received: by 2002:a05:6808:1191:b0:3f1:cd30:d692 with SMTP id
 5614622812f47-3f1cd30d72bmr7832063b6e.26.1737664191978; Thu, 23 Jan 2025
 12:29:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110010554.1583411-1-joe@pf.is.s.u-tokyo.ac.jp>
In-Reply-To: <20250110010554.1583411-1-joe@pf.is.s.u-tokyo.ac.jp>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 23 Jan 2025 21:29:40 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jHC0rM9dGB0RwS71Sw1WyzxSdWRq+o3E9Gbwv7FmBFTA@mail.gmail.com>
X-Gm-Features: AWEUYZnZCL6AT9uI_Le0leqQCoiPr4vgtWND8ydQaKqTbHrqNCAovSDPreJny1I
Message-ID: <CAJZ5v0jHC0rM9dGB0RwS71Sw1WyzxSdWRq+o3E9Gbwv7FmBFTA@mail.gmail.com>
Subject: Re: [PATCH] powercap: call put_device() on an error path in powercap_register_control_type()
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Cc: rafael@kernel.org, srinivas.pandruvada@linux.intel.com, 
	dan.carpenter@linaro.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 2:06=E2=80=AFAM Joe Hattori <joe@pf.is.s.u-tokyo.ac=
.jp> wrote:
>
> powercap_register_control_type() calls device_register(), but does not
> release the refcount of the device when it fails. Call put_device()
> before returning an error to balance the refcount. Since the
> kfree(control_type) will be done by powercap_release(), remove the lines
> in powercap_register_control_type() before returning error.
>
> This bug was found by an experimental verifier that I am developing.
>
> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
> ---
>  drivers/powercap/powercap_sys.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_=
sys.c
> index 52c32dcbf7d8..4112a0097338 100644
> --- a/drivers/powercap/powercap_sys.c
> +++ b/drivers/powercap/powercap_sys.c
> @@ -627,8 +627,7 @@ struct powercap_control_type *powercap_register_contr=
ol_type(
>         dev_set_name(&control_type->dev, "%s", name);
>         result =3D device_register(&control_type->dev);
>         if (result) {
> -               if (control_type->allocated)
> -                       kfree(control_type);
> +               put_device(&control_type->dev);
>                 return ERR_PTR(result);
>         }
>         idr_init(&control_type->idr);
> --

Applied as 6.14-rc material, thanks!

