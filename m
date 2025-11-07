Return-Path: <linux-pm+bounces-37652-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F792C41942
	for <lists+linux-pm@lfdr.de>; Fri, 07 Nov 2025 21:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4C06188CE23
	for <lists+linux-pm@lfdr.de>; Fri,  7 Nov 2025 20:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A4030E0EB;
	Fri,  7 Nov 2025 20:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLU4aHJH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0BF3081D2
	for <linux-pm@vger.kernel.org>; Fri,  7 Nov 2025 20:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762547218; cv=none; b=YiHiO5o4gztjjrgC0jTqpZmBMvZb6tOqJ/oqfzPtBd3rmWY7loatA2pDilyMS2n1ZddknIJUW3xFnCZNVce0xEI0St8q0lGd6uQITNwwkGNw1rckc9VpQlgA9HqMyUapotimlKsb7HrWx6dz8rYCtK8Cm2MYLcqT+bL4alFjAug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762547218; c=relaxed/simple;
	bh=XkDMpUrMixyfkb+IsbCPyBKEDx6a/IGVfarU71YcB8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u5382+G1b5JsQlG94OxZqvFeNuUGk5qr8w/CK+Tm/9EQCYzfVBDtyWOz3R+XXgnSRQTX/BMlIYXlatfss0uAXciqu3pdrJ5DHgKbsZT+g/6GFkZTE2iJ1xO/3yhp4592I5NoiFwdNAnCmQacXWU9pmJn+5wLiji8iDTrl0zWZTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLU4aHJH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05DC3C16AAE
	for <linux-pm@vger.kernel.org>; Fri,  7 Nov 2025 20:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762547218;
	bh=XkDMpUrMixyfkb+IsbCPyBKEDx6a/IGVfarU71YcB8s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZLU4aHJHTQxPYCRNPODiiv/hJjhD+UD7IdYjp46+PswzrQ1+GcPAhaK48mgorhYqA
	 M5u3SQFNaPHEEy3FlDfANQ9AyP/FitLlULuQ7mRXgIXCAkR+JKX8ux+ydxZiN4uZfM
	 Cg83fCRtPq3GK6XS8iwXtp7Xf1Xz2S+mgNQpBQj9uN15KANFYMhuYU4T9RvumJgeR7
	 oU0q0WQIhTXVcUUwp5Ld27Dv56q/NLC7Fvd90Aiws1p1MGldOgYNOLA8F3DmiEFOVF
	 EiTPS2TqBNZUKKx/wTb56REOhsAsX5GnfsVs7QtAS7MkIFpEWoFnx90KoccBEFbm7/
	 VoPAbdhz7YnYg==
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7c6da42fbd4so546296a34.1
        for <linux-pm@vger.kernel.org>; Fri, 07 Nov 2025 12:26:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXq0kh8NV4b4ESy9ub/Ipq0OBrwSKLDf3CPJtl7hOPf57S3ZZ/FcBCSv37t0Tgs/eL+v6uJVZgTDg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0L2Q46SvWQQzpDx1lrjQbLH0teDAUU7X9ziI7wBATx7VAbbFk
	W9BwYAu/kIilzl4Srjgmp+D/L3X0+7tOcZfCEdk0vQIuXhD1xx5r9QbPmDyEWHGnEZ5q4xeoQ7L
	juZ1yIcbP/KGVDNGIBNe8jMws0v+Dx8M=
X-Google-Smtp-Source: AGHT+IGFqVduCpkaHCICS5gM4G1tTMyE6AcmhvygqzgaDIfjsySA1+sTu3CYw8jO6Ownqe//+oJW2Wy2QhRazELJXns=
X-Received: by 2002:a05:6808:d52:b0:450:1d1a:601f with SMTP id
 5614622812f47-4502a2dedfbmr340879b6e.38.1762547217275; Fri, 07 Nov 2025
 12:26:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028051554.2862049-1-kaushlendra.kumar@intel.com>
In-Reply-To: <20251028051554.2862049-1-kaushlendra.kumar@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 7 Nov 2025 21:26:45 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iY69pE_EtZao290nFefRDZ+a2wJHCV2UjEsD8vLpq-qw@mail.gmail.com>
X-Gm-Features: AWmQ_bmBTxIY5vGxf3B_zOdNFo7ZrsRxf0_PUaklEInG_eyKr0sDzWzf4Y1l7sc
Message-ID: <CAJZ5v0iY69pE_EtZao290nFefRDZ+a2wJHCV2UjEsD8vLpq-qw@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI / DPTF: Use ACPI_FREE() for ACPI buffer deallocation
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Cc: rafael@kernel.org, lenb@kernel.org, rui.zhang@intel.com, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 6:17=E2=80=AFAM Kaushlendra Kumar
<kaushlendra.kumar@intel.com> wrote:
>
> Replace kfree() with ACPI_FREE() in pch_fivr_read() to follow ACPI
> memory management conventions. While functionally equivalent in Linux
> (ACPI_FREE() is implemented as kfree()), using ACPI_FREE() maintains
> consistency with ACPI coding standards for deallocating ACPI buffer
> objects.
>
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---
> Changes in v2:
> - Clarified changelog: convention adherence, not functional fix
>
>  drivers/acpi/dptf/dptf_pch_fivr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/dptf/dptf_pch_fivr.c b/drivers/acpi/dptf/dptf_p=
ch_fivr.c
> index 952216c67d58..8d7e555929d3 100644
> --- a/drivers/acpi/dptf/dptf_pch_fivr.c
> +++ b/drivers/acpi/dptf/dptf_pch_fivr.c
> @@ -41,7 +41,7 @@ static int pch_fivr_read(acpi_handle handle, char *meth=
od, struct pch_fivr_resp
>         ret =3D 0;
>
>  release_buffer:
> -       kfree(buffer.pointer);
> +       ACPI_FREE(buffer.pointer);
>         return ret;
>  }
>
> --

Applied (with some edits in the subject and changelog) as 6.19 material, th=
anks!

