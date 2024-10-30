Return-Path: <linux-pm+bounces-16721-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1829B621A
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 12:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F33451C21048
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 11:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1121E492D;
	Wed, 30 Oct 2024 11:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qdDaOPNZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6564A4D8A7;
	Wed, 30 Oct 2024 11:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730288523; cv=none; b=dWDuliECC++zRmTX6FtSosGoq3c3Thy15wc058AwOrakP9JcclSHJQs3Tua22Lj1sJb8mZUwIt7v/4XdzxEmnhbLWgsJ+Lwp1Jx9ATqzk+e39C4TZ+wZwl4HeB3w2mataA1l+zmPyWNi6+1uZmfLd+VKCCylNLYTrqg8ZlG2oIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730288523; c=relaxed/simple;
	bh=xwsodNNyzccNHvyN4DfKOWmKciqvHSE71GVyI3SMnZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sX0/E2JFIbYKMzlFVQ3JIc5qQKgePq0mAs/GDDiFtv88jHRfbC7qggyPnF5ex9OB/Bax1PjIeVLZXyg3lZrsyC1+yuIupFqrk32c1HuQOi0xibExXjCT7S3WbphTzCJny3FSPeVW3uW8bNDgSxnaZUnbbnTMXYel3hWdruO0onM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qdDaOPNZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00AAAC4CEE7;
	Wed, 30 Oct 2024 11:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730288523;
	bh=xwsodNNyzccNHvyN4DfKOWmKciqvHSE71GVyI3SMnZ0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qdDaOPNZsfp0NAtoLLsoe5N3FvDDLg804p1buEdX3ski6+hSN0DL4eKR7gfaDBhG5
	 OKSrGwb+WlwQwap4ZD905nA1pHs6rGhZ4/cOI/qVhwM/rpfQ0QcitBeussC17d09Ql
	 0OBNaePrVWlFs4MxFUN4ItjEvpNQVrtIENtNAO2O/m6MKQovBT5KkS3hKZfjgX26th
	 caCrLvlDzkjdYUCN1zgdm52mKCU5NMNC9XLXSUirsIk6bOys6k7furPLtx0sZUpVSE
	 VMj4JHqqMkvZyZQvBBJ7txlBdtxm9EoXSedLz2V0RO4fZbwr6/7IUlLmA85lCx19Rn
	 NOVIpJ7Z94JFQ==
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3e612437c09so3666188b6e.2;
        Wed, 30 Oct 2024 04:42:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX3cWMd/XMO4T/i7re8K+wL1x/1mnrtq1hDWVsGLjM6MvmKWFqbt9GUilygKmyPL6E5P3qbgvgcgco=@vger.kernel.org, AJvYcCXYKB7FfZYcurclsLWRjtRm6WiCflJTqrEp7EZG5W387ezy8pF4grH7Ghtz6TfCgGZNVP8O1SG4ZspOWWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOYMfIZo2bZu86X5lbQauPBuP2A6ypMXBgB6DrpjGRdIjB6mvC
	Ze26MkKCm/rh6tzLD0vV3vhKUcyrWModdk/0B8ayYcApFsB6tGAH6MszirTjnI5pZIMU/yQW5E0
	nfrRbS0PrUIsH1w6CD7LGEanHSWY=
X-Google-Smtp-Source: AGHT+IEwIlIm0LrPgt5yUX6dwtpk99g/r5eoxCASrQq1SNV6REFOO2P4Qkz356D+1j1gKmY1M+PImmaeP5blMD3z5TU=
X-Received: by 2002:a05:6870:1491:b0:288:8cee:44dd with SMTP id
 586e51a60fabf-294647210abmr3263824fac.19.1730288522292; Wed, 30 Oct 2024
 04:42:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029094452.495439-1-lukasz.luba@arm.com> <20241029094452.495439-2-lukasz.luba@arm.com>
 <CAJZ5v0gzQhw3wkRVFTEx-y4pawknJqC2JPrN6_dqd77vTVuSOw@mail.gmail.com>
 <6cdb2f8b-62e0-455c-a3a5-ed5359a2e941@arm.com> <61afac10-b434-4e39-8c49-c220add4bd8e@arm.com>
 <CAJZ5v0jk+0vfn88+gaunezgtb6TLVagqav=9sM-D169Q69MF5w@mail.gmail.com> <6847bb0d-805f-4bf6-bb22-635d5f8e9d6b@arm.com>
In-Reply-To: <6847bb0d-805f-4bf6-bb22-635d5f8e9d6b@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 30 Oct 2024 12:41:49 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j4D2E+qWrhT7bn1PznW8vvjXDRPqpR+qjr2xDHvpHwbA@mail.gmail.com>
Message-ID: <CAJZ5v0j4D2E+qWrhT7bn1PznW8vvjXDRPqpR+qjr2xDHvpHwbA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] PM: EM: Add min/max available performance state limits
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, dietmar.eggemann@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 12:33=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> =
wrote:
>
>
>
> On 10/30/24 11:23, Rafael J. Wysocki wrote:
> > On Wed, Oct 30, 2024 at 11:00=E2=80=AFAM Lukasz Luba <lukasz.luba@arm.c=
om> wrote:
> >>
> >> On 10/30/24 08:48, Lukasz Luba wrote:
> >>> Hi Rafael,
> >>>
> >>> On 10/29/24 18:29, Rafael J. Wysocki wrote:
> >>>> On Tue, Oct 29, 2024 at 10:43=E2=80=AFAM Lukasz Luba <lukasz.luba@ar=
m.com> wrote:
> >>>>>
> >>
> >> [snip]
> >>
> >>>>> +EXPORT_SYMBOL_GPL(em_update_performance_limits);
> >>>>
> >>>> It would be good to have at least one caller of this function in the
> >>>> tree.
> >>>
> >>> Yes, I know, but we had delays with the SCMI cpufreq to get the
> >>> notifications support, which are sent from FW...
> >>>
> >>> The patch using this API was part of v1 but with assumption that
> >>> those SCMI notifications are merged.
> >>>
> >>> The patch v1 for the SCMI cpufreq driver [1].
> >>>
> >>> In that v1 cover letter I mentioned that the 2nd patch depends
> >>> on notifications [2].
> >>>
> >>> I will have to work with Cristian on that notification in SCMI
> >>> then this API will be used. I can see that it stuck for a while
> >>> in v5. Let me sort that out (probably not in this merge window
> >>> though).
> >>
> >> Just to link the effort which has been started into that direction:
> >>
> >> https://lore.kernel.org/lkml/ab36709d-a181-4621-a8e5-0ef38b80186b@arm.=
com/
> >
> > OK, then this can be queued up as a prerequisite for the upcoming chang=
es.
> >
> > I would, however, mention that in the patch changelog and add a Link:
> > tag pointing to the above.
> >
>
> Thank you Rafael!

Well, there are a few comments to address first.

Please see the reply to the patch I've just sent.

