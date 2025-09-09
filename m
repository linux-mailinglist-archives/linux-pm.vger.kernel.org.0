Return-Path: <linux-pm+bounces-34258-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CE9B4FD79
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 15:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C46E1C20803
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 13:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868A434167C;
	Tue,  9 Sep 2025 13:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcTL97WP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DE733CEB3;
	Tue,  9 Sep 2025 13:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757424936; cv=none; b=a35kh62Xa3IqAyw78O7jbJNAaBL96a/SsNvXmRj4qo2A1XK0csrBgGnXLx6t1cUG/T4OQmt++/srq5Ps56vf4LmekJrjMT1VmljqVocmqBLnES6oC33va2vsagfmnaknGczFqrVbxhA6pKQmOwVDtWGBzvr0alhx1rsvn6ltBTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757424936; c=relaxed/simple;
	bh=q/TuvV+VDTC7OJJrPjtPHnQkCgkRMuerUtgEffTRbWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EysxYSI0wDsBiirCaEGxgqP3eKI1HC2CSW8/tkhjaU/csZVYttWiL3CLPF1vsHYYdeUEUhwsKVcJIuxqxi13ICpegyoK1xhAEhWKPPliQCzWC78MhS2NAPBtHdPAUJAiB9OWWAHqJTRrvKRySIY/5tTL8D9w6h/s9JXL4hZHgb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcTL97WP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3746C4CEF4;
	Tue,  9 Sep 2025 13:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757424935;
	bh=q/TuvV+VDTC7OJJrPjtPHnQkCgkRMuerUtgEffTRbWA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bcTL97WPR30sJwWuiSSqWApQD3S2RkrDhgHXI/NUtmB/Qbx79IoewRux7JBjHLXuE
	 qV1JPKzQyAg3VfeB5Iv5i5S97Wcw9PE8s0kVjFOUNcIlMzD98XcaFxHWClBOI4zEfm
	 JcKbnftr3tV4HzDSsyWHz/7R/7yBHHJp1OjlXduvp+RdPMperEUAQS7nDStvNFIqp4
	 I/KxkT5IsCvKHDZPdFYOko6p3SEK+Wu/AIb20FcnbWekybYaTO5PG4tgUs98oFAZfg
	 3KdyzeBhN6NcHcplOThx+NvgbzJX2unkWIYybQTbuIQRzsILCWhnj+Q9UMf49f+3zx
	 mhIXybEdmXhAw==
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-74526ca7a46so2202549a34.2;
        Tue, 09 Sep 2025 06:35:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVjoD+H3CYWVvlkx/8i1rMVDcmUOFbdMCvdmtQlIOA23NDSHexFS/p5eMFPOmYrQlH5ljyT6cd7F48=@vger.kernel.org, AJvYcCXLhj2s5Ce5sDj0/UIYtouMbkfNFhuThD2G/Ojj5AK0imZWt2ZfLKRADbLhGy9dB+cRP6J7kXtBpbJP9YY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFtDpITpCQot5rFYd1ykFlQsQ+Kc2u+r9oNvp60EzkVI5YYR/G
	TPc/afKQMbxl6oC5tG0sxNfpQ1tsckVf9JWzXf+Ms1dsPGxCL8hWk8s6oI3gVS9vidCGRh3GlBa
	2dTOJEqUrejt7wpFeXozp5OVbBXNu5TM=
X-Google-Smtp-Source: AGHT+IHoy2mCBTxWELrYMkWJAMOCdDAUsD/1GZxzrEjUjQiP0ZRkn3VaAyZ2ZxlO09WOGQdD0Fwn08QuYUjAg3qtdNs=
X-Received: by 2002:a05:6870:3509:b0:308:51fe:ea07 with SMTP id
 586e51a60fabf-32262631adbmr5057727fac.1.1757424935050; Tue, 09 Sep 2025
 06:35:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908075443.208570-1-aboorvad@linux.ibm.com> <0b59d09e-a508-4bca-a110-ab2b12c2284a@arm.com>
In-Reply-To: <0b59d09e-a508-4bca-a110-ab2b12c2284a@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 9 Sep 2025 15:35:24 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jP5pwev09wQSTq=HDrdW6Er0niSWWkPB5RLXdYhV0-dw@mail.gmail.com>
X-Gm-Features: Ac12FXwffpTVnydBkt37R3v4F8sg6i8IRB2SgIi3TxGqpa7FsuQr9tRNNpCkCZc
Message-ID: <CAJZ5v0jP5pwev09wQSTq=HDrdW6Er0niSWWkPB5RLXdYhV0-dw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] cpuidle: menu: Add residency threshold for
 non-polling state selection
To: Christian Loehle <christian.loehle@arm.com>
Cc: Aboorva Devarajan <aboorvad@linux.ibm.com>, rafael@kernel.org, daniel.lezcano@linaro.org, 
	gautam@linux.ibm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 3:32=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 9/8/25 08:54, Aboorva Devarajan wrote:
> > On virtualized PowerPC (pseries) systems, where only one polling state
> > (Snooze) and one deep state (CEDE) are available, selecting CEDE when
> > the predicted idle duration exceeds the target residency of the CEDE
> > state can hurt performance. In such cases, the entry/exit overhead of
> > CEDE outweighs the power savings, leading to unnecessary state transiti=
ons
> > and higher latency.
> >
> > Menu governor currently contains a special-case rule that prioritizes
> > the first non-polling state over polling, even when its target residenc=
y
> > is much longer than the predicted idle duration. On PowerPC/pseries,
> > where the gap between the polling state (Snooze) and the first non-poll=
ing
> > state (CEDE) is large, this behavior causes performance regressions.
> >
> > This patch refines the special case by adding an extra requirement:
> > the first non-polling state may only be chosen if its
> > target_residency_ns is below the defined RESIDENCY_THRESHOLD_NS. If thi=
s
> > condition is not met, the non-polling state is not selected, and pollin=
g
> > state is retained instead.
> >
> > This change is limited to the single special-case condition for the fir=
st
> > non-polling state. The general state selection logic in the menu govern=
or
> > remains unchanged.
> >
> > Performance improvement observed with pgbench on PowerPC (pseries)
> > system:
> > +---------------------------+------------+------------+------------+
> > | Metric                    | Baseline   | Patched    | Change (%) |
> > +---------------------------+------------+------------+------------+
> > | Transactions/sec (TPS)    | 495,210    | 536,982    | +8.45%     |
> > | Avg latency (ms)          | 0.163      | 0.150      | -7.98%     |
> > +---------------------------+------------+------------+------------+
> > CPUIdle state usage:
> > +--------------+--------------+-------------+
> > | Metric       | Baseline     | Patched     |
> > +--------------+--------------+-------------+
> > | Total usage  | 12,735,820   | 13,918,442  |
> > | Above usage  | 11,401,520   | 1,598,210   |
> > | Below usage  | 20,145       | 702,395     |
> > +--------------+--------------+-------------+
> >
> > Above/Total and Below/Total usage percentages which indicates
> > mispredictions:
> > +------------------------+-----------+---------+
> > | Metric                 | Baseline  | Patched |
> > +------------------------+-----------+---------+
> > | Above % (Above/Total)  | 89.56%    | 11.49%  |
> > | Below % (Below/Total)  | 0.16%     | 5.05%   |
> > | Total cpuidle miss (%) | 89.72%    | 16.54%  |
> > +------------------------+-----------+---------+
> >
> > The results show that restricting non-polling state selection to
> > cases where its residency is within the threshold reduces misprediction=
s,
> > lowers unnecessary state transitions, and improves overall throughput.
> >
> > Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> > ---
> >
> > v2: https://lore.kernel.org/all/20250317060357.29451-1-aboorvad@linux.i=
bm.com/
> >
> > Changes in v2 -> v3:
> >   - Modifed the patch following Rafael's feedback, incorporated a resid=
ency threshold check
> >     (s->target_residency_ns < RESIDENCY_THRESHOLD_NS) as suggested.
> >   - Updated commit message accordingly.
> > ---
> >  drivers/cpuidle/governors/menu.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governo=
rs/menu.c
> > index b2e3d0b0a116..d25b04539109 100644
> > --- a/drivers/cpuidle/governors/menu.c
> > +++ b/drivers/cpuidle/governors/menu.c
> > @@ -316,11 +316,13 @@ static int menu_select(struct cpuidle_driver *drv=
, struct cpuidle_device *dev,
> >
> >               if (s->target_residency_ns > predicted_ns) {
> >                       /*
> > -                      * Use a physical idle state, not busy polling, u=
nless
> > -                      * a timer is going to trigger soon enough.
> > +                      * Use a physical idle state instead of busy poll=
ing
> > +                      * if the next timer doesn't expire soon and its
> > +                      * target residency is below the residency thresh=
old.
> >                        */
> >                       if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLIN=
G) &&
> > -                         s->target_residency_ns <=3D data->next_timer_=
ns) {
> > +                         s->target_residency_ns <=3D data->next_timer_=
ns &&
> > +                         s->target_residency_ns < RESIDENCY_THRESHOLD_=
NS) {
> >                               predicted_ns =3D s->target_residency_ns;
> >                               idx =3D i;
> >                               break;
>
> To me that seems the least intrusive way the issue for your platform.
> Rafael, can you live with this?

Yes, it's fine.

> Reviewed-by: Christian Loehle <christian.loehle@arm.com>

