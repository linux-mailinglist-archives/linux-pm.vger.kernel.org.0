Return-Path: <linux-pm+bounces-39083-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0B1C9BE2B
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 16:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D03AB4E345F
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 15:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA43F221F1C;
	Tue,  2 Dec 2025 15:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2yk2TJD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55AA2AD00
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 15:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764687757; cv=none; b=pdwegNyOGqxlvS2kqQpU19o4Hl134xRlTV6KNS2WxpcBU5IkVymVj7y60tqiIGv0pXwmYfP/4+M1kRee4kJS4CcOqkwlK2QjP0d2+fHrofgxNb63FQZXhpIakalzzWGiWJxWImYccQ/dw09VfqP+LF4cK4QoU6nhAv4aYRqu4jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764687757; c=relaxed/simple;
	bh=F4/WFEqJbeHSCIdvSV3kGcSEht7QgsCP/NS4K/aXO10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cnGPKXiLjgGV5Fbq6lWY7IaQDN1q39T4386/jbCRHCyaYLqL2aceQudUTGhx8M/viAer56HepdTU4csiUu+sygBe7/jPsMIXlJoWrEoGKViWH0S7bmYc+G4WKs8TrdP0U9vsS3LPeMcwv+DR3e2Wl0gA447+5bXg0OnE+06fwXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g2yk2TJD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF94C116B1
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 15:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764687757;
	bh=F4/WFEqJbeHSCIdvSV3kGcSEht7QgsCP/NS4K/aXO10=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=g2yk2TJDeZPBslaGdgQPFSbDYeZM37VWWvKg9JxAkmUCXNylotb7qvnWhUS9Yf7DO
	 x3U8RIli3pSY9NmF55CY94fOpHog0DrQmbLdoegivGvKiMVxgL45x6hip6JFk6WPc+
	 b1f7fUxSufKCiZ6b7aI/PMHpVuXDw9y7qJ9zX+FIS/VLarqUE3HjdMMqT37mxEjJ7r
	 nHRzQqi1APDQk6zchoMFbXyHaVoGEZO6jAx0XR/LJtJIDAY4DjlAs0li/5OD7iShrH
	 LKv4u5Z7FxlV5iUklWBYRNaxHQwCk4XNoXhx7ugpbRBnAWp05XynVWVSvERXeGhHY3
	 z8DmYEGCyp+Qg==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-3ebd1b07919so1645101fac.0
        for <linux-pm@vger.kernel.org>; Tue, 02 Dec 2025 07:02:37 -0800 (PST)
X-Gm-Message-State: AOJu0YyojFDsP+iLPelcW28AcnJBhQDBwPJ0Lm485i9uX5Jje67SpLg6
	/voYMVCCKL6rjP+sEgWlEUOfWtyZA+UOchbFodebzsmfW9+G0c8y1NDTuIK+IBKAPy2k29p6V4V
	S182KqbamtkRBChg7i6Q1Tuh82zV9vK4=
X-Google-Smtp-Source: AGHT+IFGiaF1u2FSaqLekeUtJh7Oh+I/JqYLAixyyRWtC/KXdnNR74BQB+8qlKw3aDxffjt4/hTcyRykgrK0dm6hgV0=
X-Received: by 2002:a05:6808:4f09:b0:450:ad22:f9ee with SMTP id
 5614622812f47-4511572d47bmr17581529b6e.10.1764687756791; Tue, 02 Dec 2025
 07:02:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118155813.533424-1-darcari@redhat.com> <20251118155813.533424-4-darcari@redhat.com>
 <CAJvTdKmt+3i+TjbYSa--=uS22q1ZgEQuferNhCxKVK_G5Lx2jQ@mail.gmail.com>
 <b2ff2579-0d19-4648-9411-c02133c28c1d@redhat.com> <25d6584f-7763-4b6e-92da-e8f1e31ea3df@redhat.com>
 <CAJvTdK=g191mjf3uhXTemZCfoc2iQWSE0n8QtFewvMmCbEojgg@mail.gmail.com>
 <CAJvTdKnBKcXJV5az-2q1MF8b6PU6mxVS2YETgn+OWUKBfOSuZA@mail.gmail.com> <e41340a2-4474-4c36-9ed6-bb73232774b1@redhat.com>
In-Reply-To: <e41340a2-4474-4c36-9ed6-bb73232774b1@redhat.com>
From: Len Brown <lenb@kernel.org>
Date: Tue, 2 Dec 2025 10:02:25 -0500
X-Gmail-Original-Message-ID: <CAJvTdKmBTFOxo=HPDsi91bNVqb+b+D7YRSxDJHYM102D4Ospng@mail.gmail.com>
X-Gm-Features: AWmQ_bnKbqVOBA-3ezU6-H16uX7EDkNSn7kQlUCL-HpZysVDqqkwohavuwR9e0s
Message-ID: <CAJvTdKmBTFOxo=HPDsi91bNVqb+b+D7YRSxDJHYM102D4Ospng@mail.gmail.com>
Subject: Re: [PATCH 3/3] tools/power turbostat: allow turbostat to work when
 aperf is not available
To: David Arcari <darcari@redhat.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for testing.  I'll send a final patch today.

-L

On Tue, Dec 2, 2025 at 7:55=E2=80=AFAM David Arcari <darcari@redhat.com> wr=
ote:
>
>
>
> On 12/1/25 3:11 PM, Len Brown wrote:
> > Something like this?
>
> Yes - this works.  It's actually nice and clean and actually mitigates
> the need for patch 0001.  Clearly an improvement over my patch 3.
>
> How would you like to proceed?  I could resubmit a single v2 patch (with
> an appropriate explanation).
>
> I'd rather not attempt to solve the retry issue.  It's really a second
> order issue and I don't think I'm the appropriate person to do that work.
>
> -DA
>
> >
> > diff --git a/tools/power/x86/turbostat/turbostat.c
> > b/tools/power/x86/turbostat/turbostat.c
> > index 5bc47ad5da09..4a847e7e9c65 100644
> > --- a/tools/power/x86/turbostat/turbostat.c
> > +++ b/tools/power/x86/turbostat/turbostat.c
> > @@ -8530,7 +8530,7 @@ void rapl_perf_init(void)
> >   /* Assumes msr_counter_info is populated */
> >   static int has_amperf_access(void)
> >   {
> > -       return msr_counter_arch_infos[MSR_ARCH_INFO_APERF_INDEX].presen=
t &&
> > +       return has_aperf &&
> > msr_counter_arch_infos[MSR_ARCH_INFO_APERF_INDEX].present &&
> >              msr_counter_arch_infos[MSR_ARCH_INFO_MPERF_INDEX].present;
> >   }
> >
> >
> > On Mon, Dec 1, 2025 at 2:53=E2=80=AFPM Len Brown <lenb@kernel.org> wrot=
e:
> >>
> >>> ...add_msr_perf_counter() returns -1
> >>
> >> good.  and then add_msr_counter() succeeds because...
> >>
> >>> rdmsr returns zero for MSR_IA32_APERF and MSR_IA32_MPERF.
> >>
> >> Your patch is a good suggestion -- though it checks for APERF only and
> >> not for MPERF.
> >>
> >> We already ran CPUID and cleared has_aperf, so I'm thinking we should
> >> be heading this off earlier.  Let me send you a test patch later today=
.
> >>
> >> thanks,
> >> Len Brown, Intel Open Source Technology Center
> >
> >
> >
>
>


--=20
Len Brown, Intel Open Source Technology Center

