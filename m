Return-Path: <linux-pm+bounces-39549-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1588CBDA9A
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 13:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9032230C1E7C
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 11:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EDA331A51;
	Mon, 15 Dec 2025 11:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OagItfxx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71524331A45
	for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2025 11:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765798923; cv=none; b=JDpUGliqGaXgeiQKg28qKGkrdVvNGbji/MYtghu5lAJi5J4j4YYsUAIwDkF2EbLyzyhffwyR+EJfKwXWIs1ziYDpzbtbH9kgx5w/nWHvCnMh874gqxM/SHrOmlhsqDCIuWNfIRRL7FXmVo8iH+n/RnKsh9zcKWgo9XYmpHepjcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765798923; c=relaxed/simple;
	bh=p9/MYyp2BEHSR/d5xPRRRim8RMr1Y3WO9jOHq9jH2jQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lSov6im/6fpqu9TGHh571vtvb381dmsOJSiAMtefQw1hUdaRmR6fFB3d1Krt9aoEQmZI8GImzSfUQHlJ80mnjA9czqG8W+uFbxAFWmNoNJogC54rXhlhtqX9EIwY1zi4HuvIAjZ2Yi1r8/AcAYumZ2pkpvWdhPLCX1kBAkyWuys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OagItfxx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22994C4AF09
	for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2025 11:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765798923;
	bh=p9/MYyp2BEHSR/d5xPRRRim8RMr1Y3WO9jOHq9jH2jQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OagItfxx8EVllZXhQX2k7MpYDkT0ccFzBLupdIaUg1P/99i0Ja0H0ZVhFbFdcvodK
	 J+IfI4g5IFCybmJO147u2hK2bqv0emq39jhySPhi57D7NDSpQbhDz4lLS/JZOh7fcN
	 d6GZ39HsLirxkZcQmINMu2c5vTWb7QrUdkdmoK3Fg53VElBUvJtbG7qyXMnMUYV2w3
	 v/Gi3WNBNIhwD7Wh9OKdmqCSQEPW35qjaQGKx6APWJFwP/BTyXtoAUhPyhkVJlnjFi
	 79ODyCnzdMjE0JuPGWcpG8xIbpK+tgcqM6RQ+m1ObOr+SY1m/pFcvhbv7EMkdXe9Si
	 J46+Hh+ymfsbA==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6597b877066so2097439eaf.2
        for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2025 03:42:03 -0800 (PST)
X-Gm-Message-State: AOJu0YwJn3N4KsUs/rkqllHGjyg8aVhSqxjtdOqnm9YaNhoMePGPB6E4
	g9yLBUu8Nw+lWErLl9zZRJnCwnIUkcqEBK4pxQQfPWCJSfye9NglIKO7aaQO/6uqY1CDGt68idf
	stcB4ci0BrQUb4OPp+Yfy4twdddRT9JI=
X-Google-Smtp-Source: AGHT+IEVnt41Mx8YYOPcN9sXTNlHM4xTuT9LejmKKbxFm8rqflC4Jopm99aSaZzJ5e5Tubb+440vYW1ZGeFSeNXcBpo=
X-Received: by 2002:a05:6820:990:b0:659:9a49:8f87 with SMTP id
 006d021491bc7-65b4576d9c1mr5368888eaf.76.1765798922390; Mon, 15 Dec 2025
 03:42:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251207190210.471764-1-sumeet4linux@gmail.com>
In-Reply-To: <20251207190210.471764-1-sumeet4linux@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 15 Dec 2025 12:41:50 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jvt6+Gzj==ht4y6O-Lx3Y9ZkiwFB18c48G-uVmyMs-YQ@mail.gmail.com>
X-Gm-Features: AQt7F2rxvUBE6YyImXu-1V9aDalhlsk_Gkn9MJIBeCXrPTxVfgkywBJij45xTpE
Message-ID: <CAJZ5v0jvt6+Gzj==ht4y6O-Lx3Y9ZkiwFB18c48G-uVmyMs-YQ@mail.gmail.com>
Subject: Re: [PATCH] powercap: fix memory leak in intel_rapl_common
To: Sumeet Pawnikar <sumeet4linux@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 7, 2025 at 8:02=E2=80=AFPM Sumeet Pawnikar <sumeet4linux@gmail.=
com> wrote:
>
> The err_cleanup path in rapl_package_register_powercap() function
> doesn't free rp->domains before returning when child domain
> registration fails. Also, there is a missing the cleanup for the
> parent package power zone which was successfully registered earlier.
>
> When registration of child domains fails, now the previously
> registered package domain (parent zone) is being unregistered.

I'm not sure if this is desirable.

The package domain may be still functional without children AFAICS.

> This makes both parent and child powercap zones are properly
> unregistered before returning the error.
> Also, fix the rp->power_zone dangling pointer issue by setting it
> to NULL.
>
> Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
> ---
>  drivers/powercap/intel_rapl_common.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/inte=
l_rapl_common.c
> index b9d87e56cbbc..5ea31433abf2 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -1406,6 +1406,13 @@ static int rapl_package_register_powercap(struct r=
apl_package *rp)
>                                          &rd->power_zone);
>         }
>
> +       /* Also unregister the package domain if it was registered */
> +       if (rp->power_zone) {
> +               powercap_unregister_zone(rp->priv->control_type,
> +                                        rp->power_zone);
> +               rp->power_zone =3D NULL;
> +       }
> +
>         return ret;
>  }
>
> --

