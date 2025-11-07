Return-Path: <linux-pm+bounces-37650-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0B0C4191E
	for <lists+linux-pm@lfdr.de>; Fri, 07 Nov 2025 21:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A56C13AC19F
	for <lists+linux-pm@lfdr.de>; Fri,  7 Nov 2025 20:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925CE2FCC01;
	Fri,  7 Nov 2025 20:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awGnFpZr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D98F2D9EE0
	for <linux-pm@vger.kernel.org>; Fri,  7 Nov 2025 20:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762546755; cv=none; b=kJN6GK3m0Z6ntHAXLbFy5crw1BQgIq2v4vNuz2r5qgC7JgvmZ0gl26NDCrXu4H3RbD87hpRAd+ZVyyauvy8PV41tDPQenxHj1QerdVY1o4JhKrqymOapeFp2Mfw3ll5WLbXz/jRo8ajtDt4ftsFprvk15hnI7mvGg0pQ/TsOboc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762546755; c=relaxed/simple;
	bh=17TsjTD9vWN3vxnRR6ra2LaUXASrfs1y4D40Ies1qAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XCXE56ikKyshxRv6V5HXmpPzfSCeGQhCZbjQ9289hWb5HgCFF9qc+OYIE9MIV/q0J/lZ+YNIcDuLnHBl62ujuKL5xm4l++f6zgiH/bZB9XlUTCTlbmJpDLfGoK3op6+YQ7iTW1rEc4NUKlZfPRkb92HkoTliqN2uLtOSbjbiM0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awGnFpZr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8140C116C6
	for <linux-pm@vger.kernel.org>; Fri,  7 Nov 2025 20:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762546754;
	bh=17TsjTD9vWN3vxnRR6ra2LaUXASrfs1y4D40Ies1qAk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=awGnFpZrCcROEqMsUDRzchPQCiL3ASAyi34ZIJ8VSEkySW/83zMREveqRUs4wDhD0
	 hm8QSeKgD/QxU3Y6s62gPWrMvxHPhuKvcghVA2sMKXSXyhjgNn4AWNsg38TWD/J2BZ
	 x9/MKY+q/doANVFdMhngcwDqh9IClgD4eHWmRcosuz9kDATKbn937mZQ+0MKPGSpeD
	 XdxkgNdRXnddSUQJVMIIrZ5efd5voS4kzdWe4ock6IQ02pPzg3sf8vTSFmHlc6yDaQ
	 lD9dR8NZRp3fTMAxGPAymRoSCwvHjSR4MHWq2hlvCGsM6n008XwlFmtLKdeXY9QYmb
	 lDwzt6j8RlG/w==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7c531b9a45bso295467a34.0
        for <linux-pm@vger.kernel.org>; Fri, 07 Nov 2025 12:19:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW1ZmbLngkhhkEBWo+bHVouW1p1bb6GP9ToAwwqV6mHsd92qo2ddWojfV7r3h7RjKDTpHETq+8ZxQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVuR4t5J/FwDgHlzx8qz54x1zOAck01LThTVLDDwLeT4G3p+z8
	k2o7rGf0sgEbuCUug98vVrdJ6uDwuajPNI1YiOVlwvVgvjvyAlZbjJSGEo7Qca5NHmJp6LwYqUv
	jEIPJ5nnfHZZGIDMD3u0tzs9fHAr4LKg=
X-Google-Smtp-Source: AGHT+IG17jvOmL905CDn6ZhcH+amHb2vD+8gvkPXfGOKhCm0vT/i2vT+f6eQf338SgjblQyGQ6Xdcf5mmxanKX3VgKE=
X-Received: by 2002:a05:6808:30a9:b0:44d:a805:1218 with SMTP id
 5614622812f47-4502a3b6b11mr327221b6e.55.1762546754125; Fri, 07 Nov 2025
 12:19:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106113938.34693-1-adelodunolaoluwa@yahoo.com>
 <20251106113938.34693-2-adelodunolaoluwa@yahoo.com> <CAJZ5v0gG3C4r-d+v2xGPqcF1Hn927NR7yBA7kLx4t6TjEo0rGA@mail.gmail.com>
 <b6f467c5-4a70-46a2-8497-1c351b3bfea9@yahoo.com>
In-Reply-To: <b6f467c5-4a70-46a2-8497-1c351b3bfea9@yahoo.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 7 Nov 2025 21:19:02 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jga6AtyWnAgKhcKYFJagEf+ZQmnm5y92zaPXGAkXHQZg@mail.gmail.com>
X-Gm-Features: AWmQ_bknLYx82HZHH_AyTndZcLC4yRAXR2uLAm_FlX8-cm4oHIXwoNmPdd46gP4
Message-ID: <CAJZ5v0jga6AtyWnAgKhcKYFJagEf+ZQmnm5y92zaPXGAkXHQZg@mail.gmail.com>
Subject: Re: [PATCH 1/2] power/swap: add missing params and Return:
 descriptions to kernel-doc comments
To: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org, pavel@kernel.org, 
	anna-maria@linutronix.de, frederic@kernel.org, mingo@kernel.org, 
	tglx@linutronix.de, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 9:09=E2=80=AFPM Sunday Adelodun
<adelodunolaoluwa@yahoo.com> wrote:
>
> On 11/7/25 16:36, Rafael J. Wysocki wrote:
> > On Thu, Nov 6, 2025 at 12:40=E2=80=AFPM Sunday Adelodun
> > <adelodunolaoluwa@yahoo.com> wrote:
> >> Kernel-doc checks (scripts/kernel-doc) reported a number of warnings
> >> for missing parameters and `Return:` descriptions in kernel/power/swap=
.c.
> >> These missing return descriptions make the generated documentation
> >> noisy and break doc-build when -Werror is used.
> >>
> >> Update the kernel-doc comment blocks to add explicit
> >> Return: lines (and a few parameter tags where helpful) for the functio=
ns
> >> that were triggering warnings. No functional code changes are made.
> >>
> >> Example warnings that motivated this change:
> >>   - Warning: kernel/power/swap.c:535 No description found for return v=
alue
> >>     of 'save_image'
> >>   - Warning: kernel/power/swap.c:687 No description found for return v=
alue
> >>    of 'save_compressed_image'
> >>   - Warning: kernel/power/swap.c:941 No description found for return v=
alue
> >>     of 'swsusp_write'
> >>
> >> Signed-off-by: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
> > These comments need more changes to become proper kerneldocs and in
> > some cases it is not even necessary because the functions in question
> > are static.
> >
> > If the goal is to avoid warnings, why don't you change them all to
> > non-kerneldoc regular comments?
>
> Thank you very much for the feedback.
>
> For the functions that are not static, could you please suggest the
> appropriate changes needed to make their comments proper? I would like
> to improve them accordingly.

There are some white space changes to be made and general formatting
needs to be improved in some cases.

> My initial goal was to address the warnings, but if converting them to
> regular comments
>
> is the preferred approach, I will go ahead and update them that way in v2=
.

I would split this into 2 patches, one changing the comments on the
static functions to non-kerneldoc (and maybe dropping some of them
entirely) and the other changing the remaining comments into proper
kerneldoc ones.

Thanks!

