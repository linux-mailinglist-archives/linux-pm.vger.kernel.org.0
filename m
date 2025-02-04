Return-Path: <linux-pm+bounces-21333-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E46F9A275B7
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2025 16:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1B151885A5B
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2025 15:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1418213E8B;
	Tue,  4 Feb 2025 15:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pAgKqfmC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7173B207E1D;
	Tue,  4 Feb 2025 15:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738682525; cv=none; b=GlmhCijrxbYaepZ6uEopSEuuhqk0dGc4QUPwlT6Be0KOBzSEQ5LPRIJwOymWSkzpvTlRFuvPNTIb6m6Ecje23VvNEUn5/rA8rVYJrWuVkMUrj8DYuPmPRkXscdtmaKpNZp9n3Xeq+1BOLCNhBwDWAouLxajClziGw+//60vAfyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738682525; c=relaxed/simple;
	bh=AzbpRGdKbPf6wJzevutq+/uz630hnwh38GaabT8ZwFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gfPWtPt2Kxfl3IIaAr5s/2KdO8SGfAJH8G5iZkJovYVR/N2AAaj8Rss7LfYhYd8PwS9B91k5sKXhSpxBnW7hEZtGaFiVjEhkW/uu/n/LUeOQmS7RsV1UVWUHZo8najUfwPYHtoThVBwPQu7EoJHm78AiMk8xrlkW6WO5lpS1rNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pAgKqfmC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7BE1C4CEE2;
	Tue,  4 Feb 2025 15:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738682524;
	bh=AzbpRGdKbPf6wJzevutq+/uz630hnwh38GaabT8ZwFg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pAgKqfmC11E0AxPZiRtULbpMg3UK/l6Tl0uEu4StOag4W0qZxC5hesleWRFetKUIT
	 z4xln+UpB5YCKuNSne3PWjkZ6jdtIUYcQ/XmYiNZVhqxxoyJ2CYuNwx6RTtlJAst8X
	 7vHNASWgeN9IGRl1nJ1M3kM8dOomS3U6Tb5VAmrNTKhyfcwmxlbxLbzhcKU+Sv8Nbn
	 3f2o2s3uvTM2o6nDQ523+ryMMhiLfWso/ZYEFhsOJyisDQsu1Gm1yED7T9S0C9biit
	 z1dnBrfiSiNiTJrCsvneIarIIUtSVPb2TFZYwh0fCRohJmW6RskDyZhWxo7dB26dR3
	 dGeGs4m+qZEkA==
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-724a5d0427fso3332247a34.1;
        Tue, 04 Feb 2025 07:22:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUAHBLcWxPftUgFZ1hxuQA49aUo4/pBO8OqCNSWjKixkGxZHui0NmvU8M14gPpPA+rHS8M4dX9wx7U=@vger.kernel.org, AJvYcCX7DfoyIRV+6zp7+S0s8sWXT/+Wkl/2kEYXKmQv4TTmT1kkJFoKvWNG1/gfz4Kbur/r92yDkOlf5CQ=@vger.kernel.org, AJvYcCXswc2AjWM8gMs8yHtCHLaGroRNF5qEYF092znILRl58P86vPo1UxJQYawLuy8EWKGEtIVwnKPR+ciQYT6G@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0dCP+2kRJWi52wBH9KPDbg+9DyW+AHK4glpp+SPvMprIVtSML
	oSIEoUQCBrEutxQlm/7ll5GVbt247jsYbxPAuc73Uo4qMAPRcrdjJ7nwThvllEF8BPOtftsGrqQ
	fu10sxp/XUOOSJShwJb2NP85nmpw=
X-Google-Smtp-Source: AGHT+IHXNNH2iL3z3LfsL0gC/p6gCB6nfPHaNpH5W9Mu8Om11TlTX/ywnYwePR7tTmA/km95JzqdhbducF1vauBaBYY=
X-Received: by 2002:a05:6830:4101:b0:71d:63fc:2ea6 with SMTP id
 46e09a7af769-7265676102cmr20020883a34.8.1738682524078; Tue, 04 Feb 2025
 07:22:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128141139.2033088-1-darcari@redhat.com> <e9188365425d2a4c0dfa7cfa2b17ad3d9fcf2735.camel@gmail.com>
 <afbe2137-398b-4053-93e7-2a03aeb32220@redhat.com>
In-Reply-To: <afbe2137-398b-4053-93e7-2a03aeb32220@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 4 Feb 2025 16:21:53 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hp8f3Xjb7bkDR_+RYfTE1ck=qop_QMZ3+z4w7T0VS66g@mail.gmail.com>
X-Gm-Features: AWEUYZk2uqbzU7b8O05V0_65OsZ7SJvwTa4Ez8YXzh5OpN7iliAG-pbh_x-uwFY
Message-ID: <CAJZ5v0hp8f3Xjb7bkDR_+RYfTE1ck=qop_QMZ3+z4w7T0VS66g@mail.gmail.com>
Subject: Re: [PATCH] intel_idle: introduce 'use_acpi_cst' module parameter
To: David Arcari <darcari@redhat.com>
Cc: dedekind1@gmail.com, linux-pm@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, Jacob Pan <jacob.jun.pan@linux.intel.com>, 
	Len Brown <lenb@kernel.org>, Prarit Bhargava <prarit@redhat.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 2:07=E2=80=AFPM David Arcari <darcari@redhat.com> wr=
ote:
>
>
> Hi Artem,
>
> On 2/4/25 7:23 AM, Artem Bityutskiy wrote:
> > Hi David,
> >
> > On Tue, 2025-01-28 at 09:11 -0500, David Arcari wrote:
> >
> >> +The ``use_acpi_cst`` module parameter (recognized by ``intel_idle`` i=
f the
> >> +kernel has been configured with ACPI support) can be set to make the =
driver
> >> +ignore the per cpu idle states in lieu of ACPI idle states. ``use_acp=
i_cst``
> >> +has no effect if ``no_acpi`` is set).
> >
> > With this change, there will be three parameters:
> >
> > * no_acpi
> > * use_acpi
> > * use_acpi_cst
> >
> > I would like to make the naming as intuitive as possible. We do not ren=
ame the
> > first 2, but for the 3rd one, I think "force_acpi" would be a better na=
me. Or
> > perhaps "no_native"?
>
> The problem with force_acpi is it is very similar to force_use_acpi
> which is what intel_idle.c uses internally:
>
> drivers/idle/intel_idle.c:module_param_named(use_acpi, force_use_acpi,
> bool, 0444);
>
> That said, I am not attached to the 'use_acpi_cst' parameter name.

IMV this is rather about ignoring the built-in states table
altogether, IOW something like "pretend that you don't recognize the
processor".

But it could be something like "prefer_acpi" as far as I'm concerned.

