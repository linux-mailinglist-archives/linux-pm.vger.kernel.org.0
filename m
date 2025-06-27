Return-Path: <linux-pm+bounces-29706-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E529AEC076
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 21:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BD8F1C632C7
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 19:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBF82E5435;
	Fri, 27 Jun 2025 19:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zq90/u/J"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B3B19D8A8;
	Fri, 27 Jun 2025 19:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751054156; cv=none; b=iL8HGGFhjcfzfd68UV6JjMsZKdzqpD1lY0FUvZn8+oFon/7jSuwPpCsHvHlnTiFtYcLor80LjKXvg36jh3oZLrzVXNd+wgbS+b53JRaFRWE36y6mZDHxDb/7mkpvtSCQXyV2l/EflnjUe786Tn6WSEF6A6BWbVhQkta8FZ3Jqys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751054156; c=relaxed/simple;
	bh=XADjQZ+TEjgr83+mafE8zfYeP7vysAez4r8bxwUi3g0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R2oj58M9R/mmHKyB8kHyDhhVz5NUu21k4OIhARiObzqqWBnrmZoS53C8ZXpo5T5RPAHOqJgHBbfaOZKCUyPeBFQCm/A9vR6RubL7RfbjZAocexzGpHirDjvhbkOcXh0CFRBr26NxJpHEsLntltf5kn5+9wvX775u+jLsUDnTAl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zq90/u/J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0BFC4CEE3;
	Fri, 27 Jun 2025 19:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751054155;
	bh=XADjQZ+TEjgr83+mafE8zfYeP7vysAez4r8bxwUi3g0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Zq90/u/J+u8bBdOyYl93oy4wqQhio1FyhxZ7ZnWUicVFv0cI7vr8YMP515kvXHslb
	 1O5+eZE24GaXV+ZOxBwvJERMGhiY/I6yVMLmuQJ5R8KQTwQdU5nrkP96EiXnWVeT6E
	 61Bbdsl1JOMzwLT5BicTOMcWmDYLbOeGUhefIOcbu6MuEQwWPNpnet2hBtuWYfygPl
	 3vMJYcWsexgglxmXI/Se19ZkvQkNdzYT3BHBYP9zK5+nSrEXVehNksSEIiJ99y8xoo
	 ALxZCYbYlBLgi+g658ocfhiB1xX08XaAezLBINcF4CxmB1p0BenAU+PHbCr0tAXIU8
	 O1Q0HVOQhhx4w==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-40a55314d06so857782b6e.1;
        Fri, 27 Jun 2025 12:55:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUwHSP6hX0UebW/pNsBckOvqtyGA2pcL/wKKVpeAfxYTisYxUmjuoiJEIhcuGoyuxPPBYSoPd14RH0=@vger.kernel.org, AJvYcCVVlcx+zhHbXFCTC5B9sR5Iti6ylTB16YB01Cq75hFi7zpU81a8x0h/601Jzzod3kw/PClQaEwgscrAbuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGIOmgoALlOnvea/mCdmrdzsUBg/T/2mcMDTKVv9ahVNCEcyFh
	kL9vUGRmXfBDRhXNldQamS8bihUd7AbGajkoEZpQanzIKfT6d7Cfz4lzYIGQQnytYxGAZVLAUsX
	wcyWHz/AusGIGBf1kVAnon9V2LyY2Ugc=
X-Google-Smtp-Source: AGHT+IE0UMt7B5qGD4vFLERyqvD0G9OO0kmcGk69gMwZgWs5sQqQ8LROw46/tWkKjZ0d0Bq8bDfbKOOJtnuehLkKFIs=
X-Received: by 2002:a05:6870:92c1:b0:2c1:650b:fc86 with SMTP id
 586e51a60fabf-2efed430f37mr3119354fac.1.1751054154855; Fri, 27 Jun 2025
 12:55:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612044538.2970661-1-wei.qiao@intel.com> <20250612070613.2995756-1-wei.qiao@intel.com>
In-Reply-To: <20250612070613.2995756-1-wei.qiao@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 27 Jun 2025 21:55:43 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jPzrRc76qKMH6Uy=YuQg1GY1gyWwhcFxCqxuh-4jCcVA@mail.gmail.com>
X-Gm-Features: Ac12FXxMFojIMhvONWOReY8H5IeABv_Hwyr3wHiJZ7EiEFWLnDcT8kGqalElQko
Message-ID: <CAJZ5v0jPzrRc76qKMH6Uy=YuQg1GY1gyWwhcFxCqxuh-4jCcVA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] powercap: intel_rapl: Add support for Bartlett
 Lake platform
To: Qiao Wei <wei.qiao@intel.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rui.zhang@intel.com, xiange.pi@intel.com, lili.li@intel.com, 
	furong.zhou@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 9:32=E2=80=AFAM Qiao Wei <wei.qiao@intel.com> wrote=
:
>
> Add support for Bartlett Lake platform to the RAPL common driver.
>
> Acked-by: Zhang Rui <rui.zhang@intel.com>
> Signed-off-by: Qiao Wei <wei.qiao@intel.com>
> ---
> Changes since V1:
> - Remove "[linux-driver-review]" prefix in the subject
> - Add Acked-by tag from Zhang Rui
> ---
>  drivers/powercap/intel_rapl_common.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/inte=
l_rapl_common.c
> index e3be40adc0d7a..c0789df34b2f7 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -1261,6 +1261,7 @@ static const struct x86_cpu_id rapl_ids[] __initcon=
st =3D {
>         X86_MATCH_VFM(INTEL_RAPTORLAKE,         &rapl_defaults_core),
>         X86_MATCH_VFM(INTEL_RAPTORLAKE_P,        &rapl_defaults_core),
>         X86_MATCH_VFM(INTEL_RAPTORLAKE_S,       &rapl_defaults_core),
> +       X86_MATCH_VFM(INTEL_BARTLETTLAKE,       &rapl_defaults_core),
>         X86_MATCH_VFM(INTEL_METEORLAKE,         &rapl_defaults_core),
>         X86_MATCH_VFM(INTEL_METEORLAKE_L,       &rapl_defaults_core),
>         X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X,   &rapl_defaults_spr_server=
),
> --

Applied as 6.17 material, thanks!

