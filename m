Return-Path: <linux-pm+bounces-35999-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED49BD5ECF
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 21:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B169034ACB7
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 19:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED662D73A8;
	Mon, 13 Oct 2025 19:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6gL6tPU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1899925F78F
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 19:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760383241; cv=none; b=DkVNEDjZmDuQfYpHtavyINjZk6dK5MJ9z4nNJLg7/Q5qGm0msMoMxkX+MSDuu2Xo0w81pJJHDtcpGbrJXIwHcG0Jrhkdzi2EngqZzjFKY16nZguhHYJBQ4IXZiUn50TAJYAbIUPwwCuw6qutuauFc2KsC97sDsfHYdrNIvTs0LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760383241; c=relaxed/simple;
	bh=6CX1eTaaqf27qybv4prLfdQtAGDq2rDEfkvRJBamxZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pYETSeitPPnyF+U3aGVdYFJ9SwFzBshwmfyVILARxTOAJZopkVSGgqP1CbAPAKXhyHzAO7cZt8aVSSLheQGORkqPJl6U6Z2VkMunlNnzdzkP0DQmM4ZuyDtYds4qbRh5GZidgZA28ngFUDut3o1Z9OrpZ7F0BwSNj6KOwgQwJSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6gL6tPU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4208C4CEFE
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 19:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760383240;
	bh=6CX1eTaaqf27qybv4prLfdQtAGDq2rDEfkvRJBamxZs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Z6gL6tPUm58l1OkS6uhp2zOv632pqYV+PuEOZZSPLHSsh5/LJqTuziL2B16/Ejy44
	 QShDPRHQ2e75EtBfcntcR8VjcAna2IehmLNz4Pxsl97khBhyFqBBR4zvOeHPp+3t7i
	 aVqCUZ6ljLu3yg6MNpdRuM95GKJqmujl9hvuWXd+kp49JqYHPShUm8bqsu/2zpgo3a
	 Ml1x1dSuuCXrdJmbkThCfrm86JcJfwOj9IDYdtM2a+ymlbxQ0kCbzBydARCvwftCO0
	 C/VTK/oFCmrOXoDOo0e5fEPc4zeM7VBQMTkSAczxBeEDSSGX04wIgJiANbnLwPpVsG
	 0oM9yjzOY3Reg==
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-43f8116a163so2049122b6e.1
        for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 12:20:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVjRiRncWDDl1xQOBblH8scLYLEGCO/3/VAavcixoBKBSyH1K+xSs4kSi+BDVR/pxSRsxCoo90hNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFp8sFEk1UR3jSVJ5EapeZsROYbXLMCsOZXDJ9hUuh6R3kU1Tp
	htJGpZv2rY6OL9JNA9h6RjQtsGDwxlI0T+vxZpOVzy/8Trh7+kOs8uZr0m4F2boaQJHHH5Ct8ZP
	Okd8jr4Kne6huo+//X1oTI78uxBTjN/0=
X-Google-Smtp-Source: AGHT+IHiWf7qBhlFTz7gTfhA+amd9SaimwxwcofrDrq/QtkQ730d0OVHAlANJ2BPqdLmE2nb2K9rXmX6xb5TNVpf3f8=
X-Received: by 2002:a05:6808:1817:b0:43d:23d2:719e with SMTP id
 5614622812f47-4417b400b7bmr9934440b6e.44.1760383239875; Mon, 13 Oct 2025
 12:20:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922055231.3523680-1-kaushlendra.kumar@intel.com>
In-Reply-To: <20250922055231.3523680-1-kaushlendra.kumar@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 13 Oct 2025 21:20:28 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gH8+yiAYdOnmTCXCcKCMezcuWKKFEc=yGsD30rtKBvUA@mail.gmail.com>
X-Gm-Features: AS18NWB2bBsJeEZn3rKL2iGQt-6519-OCuD-5aa5yhZETMyRUsHEdCoery7QFCw
Message-ID: <CAJZ5v0gH8+yiAYdOnmTCXCcKCMezcuWKKFEc=yGsD30rtKBvUA@mail.gmail.com>
Subject: Re: [PATCH] PM: Replace snprintf() with scnprintf() in show_trace_dev_match()
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Cc: rafael@kernel.org, pavel@kernel.org, gregkh@linuxfoundation.org, 
	dakr@kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 7:54=E2=80=AFAM Kaushlendra Kumar
<kaushlendra.kumar@intel.com> wrote:
>
> Replace snprintf() with scnprintf() in show_trace_dev_match() to simplify
> buffer length handling. The scnprintf() function returns the number of
> characters actually written (excluding the null terminator), which
> eliminates the need for manual length checking and clamping.
>
> This change removes the redundant size check since scnprintf() guarantees
> that the return value will never exceed the buffer size, making the code
> cleaner and less error-prone.
>
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---
>  drivers/base/power/trace.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/base/power/trace.c b/drivers/base/power/trace.c
> index cd6e559648b2..d8da7195bb00 100644
> --- a/drivers/base/power/trace.c
> +++ b/drivers/base/power/trace.c
> @@ -238,10 +238,8 @@ int show_trace_dev_match(char *buf, size_t size)
>                 unsigned int hash =3D hash_string(DEVSEED, dev_name(dev),
>                                                 DEVHASH);
>                 if (hash =3D=3D value) {
> -                       int len =3D snprintf(buf, size, "%s\n",
> +                       int len =3D scnprintf(buf, size, "%s\n",
>                                             dev_driver_string(dev));
> -                       if (len > size)
> -                               len =3D size;
>                         buf +=3D len;
>                         ret +=3D len;
>                         size -=3D len;
> --

Applied as 6.19 material, thanks!

