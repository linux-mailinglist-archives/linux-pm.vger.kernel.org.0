Return-Path: <linux-pm+bounces-22578-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CF2A3E568
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 20:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C222702903
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 19:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C68026460A;
	Thu, 20 Feb 2025 19:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1Hwu154"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F9A264607;
	Thu, 20 Feb 2025 19:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740081471; cv=none; b=cMSyvy0CfCKToEfgB/bBMgKC1MR79KWvfS3hWE/HMPIeoJSlS99nQ+H+OBdVbZGzi2WKlLomgBvAYuckAnz7Qr+jBOd7YdS1LV55kK3NCNn2xE8ukKK6FlzPgvkAPAkhCc4xp872Bws0UTch0EkBZ8KX6Rtz48RbsOg11BeID+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740081471; c=relaxed/simple;
	bh=IEEv2phHuz5CP5vjO4iUAg1ONnL5OS9b9QnH5fZS3Zc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CO6j3FrxwmsRfmhU4TfyPVNacu6ZvtzTpPzo3P25VryPaRA6xab2dk561KZrGj0x2eFm4kzG8C2smy+YbxTMpLlb8KqUajTq1MjCrxBy6ArXza3L+3axVQrXsKDbJDwZTRuqzmKxEnb72buMApjfNcsLYFN6XvY+WmKqzKzyq+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1Hwu154; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1181C4CED1;
	Thu, 20 Feb 2025 19:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740081470;
	bh=IEEv2phHuz5CP5vjO4iUAg1ONnL5OS9b9QnH5fZS3Zc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=r1Hwu154ElCGh3lLX7S0WanN0fL2kklfEsINpoZbDgzT3fVon7oEfwaknFDiy09P5
	 2e0eTasKKVphi8MyMoXGzIZSud1seI/9kFwBDJjjsAjuhympzvgpuYSUSdb1wSyKXr
	 zizqvmbkHFcfp95dvD+XFxJvT2D7hKkKvuV+Th1UKncZzX+ZhEnydSUHNgfDWhdnpY
	 5I/0c54FBn+nf8h9GWDf6vXnX3H8Sp4UBSzED/HxklvsOWOPEvkPYNR70dU+Xu1qK8
	 QHY3fojOcpVNV2EKAR7rG+pPmp6o05+0z/PyMVbyN9MYMTQVESpkU02yXsu9LhDl0p
	 W+XrntsNRdS6A==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2bcbd92d5dbso484477fac.2;
        Thu, 20 Feb 2025 11:57:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXMN5mLGDSD5GvDoj8UB8MRVAEYa9IrJCJeVYaLsiB3SwL22Nw4uC6PdHFXoNhqMdYsfgyYKENZvw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb39AksdWr7+x4hxnzuh/aZ39eBqyiP2HArvlHV0nFq1W5E1of
	b4zBO7fl6nu+/cPImztbHfw2fe27jGIOAwilmRBOpi6EVZnXfhQrd5NT5PAQyHxXbdZ8jXeAJNs
	DuPq62MLgNNXlijEAwu/xG6LzGsw=
X-Google-Smtp-Source: AGHT+IF/vXVVQ8o+wGJLJfRygL1NI5IxEL6YwL/BIMqezQdhPfArHUPswm/f89VvOY9FAs5fezmKHaR5DkdhP/V+hwA=
X-Received: by 2002:a05:6871:620e:b0:29e:5bb8:fb35 with SMTP id
 586e51a60fabf-2bd5101952emr213838fac.37.1740081470178; Thu, 20 Feb 2025
 11:57:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220114103.515278-1-lukasz.luba@arm.com>
In-Reply-To: <20250220114103.515278-1-lukasz.luba@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 20 Feb 2025 20:57:39 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jRg8=3xgUK8j0+PdNYPpiD4PhpwwRjFmKDxrNj-gRk3g@mail.gmail.com>
X-Gm-Features: AWEUYZlIx0jrTFt6kR5MzpI2Cb7cSr7nnz3OBhYTJ4g-avArg_IZcvAkZbuFYFI
Message-ID: <CAJZ5v0jRg8=3xgUK8j0+PdNYPpiD4PhpwwRjFmKDxrNj-gRk3g@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Energy Model framework as properly maintained
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rafael@kernel.org, 
	dietmar.eggemann@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 12:41=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> =
wrote:
>
> The Energy Model framework had some recent grow and became a bit
> more complex. Add the proper contact points to maintainers so
> other developers can get the right support.
>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b9f7d2115b57d..2d0dd9100292c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8529,6 +8529,15 @@ M:       Maxim Levitsky <maximlevitsky@gmail.com>
>  S:     Maintained
>  F:     drivers/media/rc/ene_ir.*
>
> +ENERGY MODEL
> +M:     Lukasz Luba <lukasz.luba@arm.com>
> +M:     "Rafael J. Wysocki" <rafael@kernel.org>
> +L:     linux-pm@vger.kernel.org
> +S:     Maintained
> +F:     kernel/power/energy_model.c
> +F:     include/linux/energy_model.h
> +F:     Documentation/power/energy-model.rst
> +
>  EPAPR HYPERVISOR BYTE CHANNEL DEVICE DRIVER
>  M:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
>  L:     linuxppc-dev@lists.ozlabs.org
> --

Applied as 6.15 material, thanks!

