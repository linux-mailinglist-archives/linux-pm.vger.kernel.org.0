Return-Path: <linux-pm+bounces-36488-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4BBBF2ABB
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 19:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 053694F92E8
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 17:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4B928CF42;
	Mon, 20 Oct 2025 17:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAzDJDb4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E674A2882D7
	for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 17:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760980716; cv=none; b=Q39eH7Ar/9WmCxuKZby95ikZIKkx8RJN7/JPqL+CG1P3GgG9LxlLb/kbkhUyxCNvA0CkRFWOLFmnVdEHCSbO/C/zE/oQ1XZn+ISUw0NKIgyNkbVq6kVTrg2G/7fSMtMEg0WTUFW/G1RDOR+1JhCvajliVpQx0/iKrfJoc+AdkPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760980716; c=relaxed/simple;
	bh=4DeNbsFjA3GHAvuLpWPwdNkAditJGZMykUeSPTvXfPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LIq30ZtnyHNd/pOpdyRW9PAZavj7/1SPUMDRaKuvWb32RMNdw70M4ak6EBMqNUkABMsi+NEl/eGy5lnPNleQqaGxRdmFrvN9LlbfJ/lv/POvC/VqnEBThE7Bg6INtwqD2sPFgjui9Uh7JRlcp8gOeAcgq423AaICDeLTkBA6YMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAzDJDb4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6AB6C113D0
	for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 17:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760980715;
	bh=4DeNbsFjA3GHAvuLpWPwdNkAditJGZMykUeSPTvXfPI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IAzDJDb4ojXUi/sH9bE/JrBXDlxA86v5WcegcNYbiBVchvmT6yaL1Lijo1TvKEGDt
	 snY6qEqecS/PcWU5Xk8O+rNbRDbAoCI57Yg03K8QeM4T2WyojWFszIXIjptz0i3RqV
	 scLrP3XMFUNmuitiA9Ph5kdld2InsLktImukfTwFBWSXuE5mB/niaiCPyn5qxFMg9i
	 is51pg2srmTIeHZKDTWPW6XG7SIeksJ+OdkTz8SRP9L5tH7Yr2f65ZrcZQRB3egrKy
	 z0t18SCRrKnjIjluTDUc/EHeA03icbnUyer6J7eoic+M8eEqGaCkrWGD3RXFgJq/0N
	 lWU3QskxKQ04g==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-43fb60c5f75so895774b6e.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 10:18:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVkzqDCmrN8yxBhL3Up7ofpDFMTNFzgpDAEAoePpPXU2Fb5Knic50h1w3YDi6hXmVfwPR7NQIXN3w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCsKXDFU/VGWTAejylDwF8Rovj5Wh55LtimwlDavmz6DVQzkAT
	+KoXU4bqyag21kXQutb0Wf+RT5cQp8bguK78iIGHQZYZvusn1HpAJlvqQjCcczQRBu9kEbVtVyW
	HD1sdYjUJ4TxY4ySHuenqtUldTb/nA/A=
X-Google-Smtp-Source: AGHT+IEpBFVPe13rSyWoAQmkn/h4MheLuYhwx+bDHEMRoTzYJkC2HBrn+zWJIIX4GlHStnkZidJOsjnAs+i7vboU7aI=
X-Received: by 2002:a05:6808:1a03:b0:441:8f74:e85 with SMTP id
 5614622812f47-443a309d405mr6105705b6e.63.1760980715153; Mon, 20 Oct 2025
 10:18:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020165317.3992933-1-superm1@kernel.org> <20251020165317.3992933-3-superm1@kernel.org>
In-Reply-To: <20251020165317.3992933-3-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 20 Oct 2025 19:18:24 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g64Hu15k5sLVfxj-AADy2goyvseGGm_zTAqSPHXEaxOA@mail.gmail.com>
X-Gm-Features: AS18NWBumdOGpspcARVBeurDv1os9xsYPMYfkNgvhTlP7jAwUq2a1Wu4Nq9UyAw
Message-ID: <CAJZ5v0g64Hu15k5sLVfxj-AADy2goyvseGGm_zTAqSPHXEaxOA@mail.gmail.com>
Subject: Re: [RFC 2/3] PM: Don't pass up device_resume() -EBUSY errors
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: mario.limonciello@amd.com, airlied@gmail.com, alexander.deucher@amd.com, 
	christian.koenig@amd.com, dakr@kernel.org, gregkh@linuxfoundation.org, 
	lenb@kernel.org, pavel@kernel.org, rafael@kernel.org, simona@ffwll.ch, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 6:53=E2=80=AFPM Mario Limonciello (AMD)
<superm1@kernel.org> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> If a device resume returns -EBUSY the device resume sequence has
> been skipped.

Is this actually demonstrably true in all of the cases?

And what about -EAGAIN?

> Don't show errors for this or pass it up to async
> resume.  If resume is run again in another stage the device should
> try again.
>
> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>  drivers/base/power/main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index bf9c3d79c455f..f6bc7ef9a8371 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1112,7 +1112,9 @@ static void device_resume(struct device *dev, pm_me=
ssage_t state, bool async)
>
>         TRACE_RESUME(error);
>
> -       if (error) {
> +       if (error =3D=3D -EBUSY)
> +               pm_dev_dbg(dev, state, async ? " async" : "");
> +       else if (error) {
>                 WRITE_ONCE(async_error, error);
>                 dpm_save_failed_dev(dev_name(dev));
>                 pm_dev_err(dev, state, async ? " async" : "", error);
> --
> 2.43.0
>

