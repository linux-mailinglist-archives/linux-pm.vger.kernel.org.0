Return-Path: <linux-pm+bounces-22800-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CD4A41F49
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 13:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D0C33A6F5F
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 12:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2109423373A;
	Mon, 24 Feb 2025 12:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErWoCKG4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC34B221F2B;
	Mon, 24 Feb 2025 12:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740400542; cv=none; b=Z07flqe8bBN8QIaZTu3ah0QOATqofyFUbK7z0V0WUnJgj8VJGr+/qYr0TGaHMNhzpPeCQ0PXOtniyyP4vYp9L9JnHyHwf8kvRmcVqN8VlFXwjk0cjojzoLg7p4tE6cjhUarlFzsk1aWMCCY+Yo88ZBzgWK6iog+skQx9nEg5Fq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740400542; c=relaxed/simple;
	bh=dGXEcscAPrR7BvnpI0gfRKGiwfRcrgK1kEIPwVYhhI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kqKlSeZijXZ0ZFq0YIGOlSCWCZMoBGUxAddV6j+3jKfrizLykgTH1MF81kaOs3Qbz2QnD4c9N15yjSQsx7tkjqN2G81LmUSXOzrOFV/BdVLfVSsRNlGwH4Ko/eVnxngyBOYP9RF434Toywh45/33Tc015b/Oqd2FATs4dJcq1+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErWoCKG4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A11CC4CED6;
	Mon, 24 Feb 2025 12:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740400541;
	bh=dGXEcscAPrR7BvnpI0gfRKGiwfRcrgK1kEIPwVYhhI8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ErWoCKG4gagqE2jSO/0hqvv+SJpADqhVAuDniWYlpL0+RtOdTlFmG8pJvAP5UB8MT
	 srvz5/ApUc67px5uEbR4Ft2INeLYHs4EXMvAKU8AtWX9R1XzryPtAJR/3PH52Werwd
	 9MByFwj1XDMR1eAJhYXkLH86VMu0jdritJGNiL6t6Xm4UlvUlAn7gIbx8o6brBr1T0
	 edqBICp7rbEoJ2wtLIWYuoR+jkIOBmPZskrf8oRDAxjjcDkAv8CdxocmXPIwHrbKJ3
	 IC7myUOfDUJFlFR5I1V8219hXu59TNPvWt1PXz0QppEY2OUkOH/wC6B+CeEriSfoeN
	 obWWf585D6XuQ==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5fcd7d306f3so3616078eaf.3;
        Mon, 24 Feb 2025 04:35:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUmrI90cglXyb2nBrWfJi/keK4z9qzTx61zvklrq4e13TWGGaZxqREXVXYd3OXCY4YUwAHrA+ZFOc0=@vger.kernel.org, AJvYcCVogwDnH3uN5F00X9dfn8RJ03PWfRIjRdSPMHMpqq2c1AhchrWZ/jkNG2FF0nTyEjQ0+/waFUJCcx5tyXU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0IhcAkID+0sECodE0urSM66ecKZM0lGua0azr+24/pA/zf4WZ
	Fdf1ZSm33qa4TuFOHHz9TxcrLIkQIeiZKLfm9McRO0STdfjBvtJubOHJoSAAxeH1ddIU/ZDJ+1s
	b9lmR2lbxw/n3Rif4+0WZSh1ZYp4=
X-Google-Smtp-Source: AGHT+IHxC3pZxLeketjrfe6+sR6U1RgN5Kf81lSo2okF5Y2uE8SIMHHrBzzdu1s0ogv71HiXieKvmXapQPsGzFoBzuU=
X-Received: by 2002:a05:6808:14c4:b0:3f4:1eab:1dfc with SMTP id
 5614622812f47-3f424775b44mr6656961b6e.27.1740400540561; Mon, 24 Feb 2025
 04:35:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1916668.tdWV9SEqCh@rjwysocki.net> <d0c013d5d2a9251d5dc468446f2a08ae8a7a8953.camel@linux.ibm.com>
In-Reply-To: <d0c013d5d2a9251d5dc468446f2a08ae8a7a8953.camel@linux.ibm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 24 Feb 2025 13:35:25 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gFbbw18poYfv77d9L0H2N0Q9exW96MNQMVganFkydN3Q@mail.gmail.com>
X-Gm-Features: AWEUYZlXye1S39dxF05e0T9yIWNA09IP1DRnOp-6LArH8ViRwGLX3Y4Ya_jGzws
Message-ID: <CAJZ5v0gFbbw18poYfv77d9L0H2N0Q9exW96MNQMVganFkydN3Q@mail.gmail.com>
Subject: Re: [RFT][PATCH v1 0/5] cpuidle: menu: Avoid discarding useful
 information when processing recent idle intervals
To: Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Christian Loehle <christian.loehle@arm.com>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 7:27=E2=80=AFAM Aboorva Devarajan
<aboorvad@linux.ibm.com> wrote:
>
> On Thu, 2025-02-06 at 15:21 +0100, Rafael J. Wysocki wrote:
>
> > Hi Everyone,
> >
> > This work had been triggered by a report that commit 0611a640e60a ("eve=
ntpoll:
> > prefer kfree_rcu() in __ep_remove()") had caused the critical-jOPS metr=
ic of
> > the SPECjbb 2015 benchmark [1] to drop by around 50% even though it gen=
erally
> > reduced kernel overhead.  Indeed, it was found during further investiga=
tion
> > that the total interrupt rate while running the SPECjbb workload had fa=
llen as
> > a result of that commit by 55% and the local timer interrupt rate had f=
allen by
> > almost 80%.
> >
> > That turned out to cause the menu cpuidle governor to select the deepes=
t idle
> > state supplied by the cpuidle driver (intel_idle) much more often which=
 added
> > significantly more idle state latency to the workload and that led to t=
he
> > decrease of the critical-jOPS score.
> >
> > Interestingly enough, this problem was not visible when the teo cpuidle
> > governor was used instead of menu, so it appeared to be specific to the
> > latter.  CPU wakeup event statistics collected while running the worklo=
ad
> > indicated that the menu governor was effectively ignoring non-timer wak=
eup
> > information and all of its idle state selection decisions appeared to b=
e
> > based on timer wakeups only.  Thus, it appeared that the reduction of t=
he
> > local timer interrupt rate caused the governor to predict a idle durati=
on
> > much more often while running the workload and the deepest idle state w=
as
> > selected significantly more often as a result of that.
> >
> > A subsequent inspection of the get_typical_interval() function in the m=
enu
> > governor indicated that it might return UINT_MAX too often which then c=
aused
> > the governor's decisions to be based entirely on information related to=
 timers.
> >
> > Generally speaking, UINT_MAX is returned by get_typical_interval() if i=
t
> > cannot make a prediction based on the most recent idle intervals data w=
ith
> > sufficiently high confidence, but at least in some cases this means tha=
t
> > useful information is not taken into account at all which may lead to
> > significant idle state selection mistakes.  Moreover, this is not reall=
y
> > unlikely to happen.
> >
> > One issue with get_typical_interval() is that, when it eliminates outli=
ers from
> > the sample set in an attempt to reduce the standard deviation (and so i=
mprove
> > the prediction confidence), it does that by dropping high-end samples o=
nly,
> > while samples at the low end of the set are retained.  However, the sam=
ples
> > at the low end very well may be the outliers and they should be elimina=
ted
> > from the sample set instead of the high-end samples.  Accordingly, the
> > likelihood of making a meaningful idle duration prediction can be impro=
ved
> > by making it also eliminate low-end samples if they are farther from th=
e
> > average than high-end samples.  This is done in patch [4/5].
> >
> > Another issue is that get_typical_interval() gives up after eliminating=
 1/4
> > of the samples if the standard deviation is still not as low as desired=
 (within
> > 1/6 of the average or within 20 us if the average is close to 0), but t=
he
> > remaining samples in the set still represent useful information at that=
 point
> > and discarding them altogether may lead to suboptimal idle state select=
ion.
> >
> > For instance, the largest idle duration value in the get_typical_interv=
al()
> > data set is the maximum idle duration observed recently and it is likel=
y that
> > the upcoming idle duration will not exceed it.  Therefore, in the absen=
ce of
> > a better choice, this value can be used as an upper bound on the target
> > residency of the idle state to select.  Patch [5/5] works along these l=
ines,
> > but it takes the maximum data point remaining after the elimination of
> > outliers.
> >
> > The first two patches in the series are straightforward cleanups (in fa=
ct,
> > the first patch is kind of reversed by patch [4/5], but it is there bec=
ause
> > it can be applied without the latter) and patch [3/5] is a cosmetic cha=
nge
> > made in preparation for the subsequent ones.
> >
> > This series turns out to restore the SPECjbb critical-jOPS metric on af=
fected
> > systems to the level from before commit 0611a640e60a and it also happen=
s to
> > increase its max-jOPS metric by around 3%.
> >
> > For easier reference/testing it is present in the git branch at
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log=
/?h=3Dexperimental/menu
> >
> > based on the cpuidle material that went into 6.14-rc1.
> >
> > If possible, please let me know if it works for you.
> >
> > Thanks!
> >
> >
> > [1] Link: https://www.spec.org/jbb2015/
> >
> >
> >
>
> Hi Rafael,
>
> I ran some tests using a cpuidle microbenchmark that I have [1]:
>
> The test does a uniform distribution of idle durations, which means the p=
ast eight idle intervals approximately match
> the sleep duration. So as anticipated, this change-set does not impact th=
is case, and the behavior remains mostly
> consistent even after applying the patch.
>
>  Pipe based wakeup - Above %
>  ----------------------------------------------------------------------
> | Sleep time (s)  | Menu No Patch(%) | Menu Patch(%)| Teo No Patch (%) |
> |---------------- |------------------|--------------|------------------|
> | 5               | 0.00%            | 0.00%        | 0.00%            |
> | 10              | 0.00%            | 0.00%        | 0.00%            |
> ------------------------------------------------------------------------
> | 30              | 99.97%           | 99.96%       | 0.00%            |
> | 100             | 98.61%           | 98.67%       | 0.00%            |
> | 120             | 97.88%           | 98.42%       | 1.03%            | =
-> (*)
> ------------------------------------------------------------------------
> | 130             | 2.82%            | 1.26%        | 0.22%            |
> | 150             | 1.68%            | 1.43%        | 0.32%            |
> | 200             | 2.09%            | 1.91%        | 0.15%            |
> | 300             | 1.22%            | 1.22%        | 0.19%            |
> | 400             | 1.20%            | 1.21%        | 0.19%            |
> | 500             | 1.16%            | 1.12%        | 0.12%            |
> ------------------------------------------------------------------------
>
>  Pipe based wakeup - Below %
>  -----------------------------------------------------------------------
> | Sleep time (s)  | Menu No Patch(%) | Menu Patch(%)| Teo No Patch (%) |
> |---------------- |------------------|--------------|------------------|
> | 5               | 0.00%            | 0.00%        | 0.00%            |
> | 10              | 0.00%            | 0.00%        | 0.00%            |
> | 30              | 0.00%            | 0.00%        | 0.00%            |
> | 100             | 0.00%            | 0.00%        | 0.00%            |
> | 120             | 2.76%            | 1.14%        | 0.93%            |
> | 130             | 3.11%            | 1.13%        | 0.12%            |
> | 150             | 1.34%            | 1.16%        | 0.18%            |
> | 200             | 1.38%            | 1.15%        | 0.09%            |
> | 300             | 1.33%            | 1.21%        | 0.11%            |
> | 400             | 1.36%            | 1.25%        | 0.10%            |
> | 500             | 1.25%            | 1.22%        | 0.10%            |
> |---------------- |------------------|--------------|------------------|
>
>  Time based wakeup - Above %
>  -----------------------------------------------------------------------
> | Sleep time (s)  | Menu No Patch(%) | Menu Patch(%)| Teo No Patch (%) |
> |---------------- |------------------|--------------|------------------|
> | 5               | 0.00%            | 0.00%        | 0.00%            |
> | 10              | 0.00%            | 0.00%        | 0.00%            |
> | 30              | 0.00%            | 0.00%        | 0.00%            |
> | 100             | 0.01%            | 0.00%        | 0.00%            |
> | 120             | 0.00%            | 0.00%        | 0.15%            |
> | 130             | 15.84%           | 0.14%        | 0.23%            |
> | 150             | 0.39%            | 0.23%        | 0.48%            |
> | 200             | 0.95%            | 0.87%        | 0.10%            |
> | 300             | 0.20%            | 0.17%        | 0.15%            |
> | 400             | 0.14%            | 0.12%        | 0.17%            |
> | 500             | 0.10%            | 0.20%        | 0.11%            |
> |---------------- |------------------|--------------|------------------|
>
>  Time based wakeup - Below %
>  -----------------------------------------------------------------------
> | Sleep time (s)  | Menu No Patch(%) | Menu Patch(%)| Teo No Patch (%) |
> |---------------- |------------------|--------------|------------------|
> | 5               | 0.00%            | 0.00%        | 0.00%            |
> | 10              | 0.00%            | 0.00%        | 0.00%            |
> | 30              | 0.00%            | 0.00%        | 0.00%            |
> | 100             | 0.00%            | 0.00%        | 0.00%            |
> | 120             | 1.85%            | 1.66%        | 2.67%            |
> | 130             | 16.71%           | 1.13%        | 1.11%            |
> | 150             | 1.36%            | 1.16%        | 1.13%            |
> | 200             | 1.33%            | 1.14%        | 1.19%            |
> | 300             | 1.44%            | 1.20%        | 1.17%            |
> | 400             | 1.51%            | 1.21%        | 1.21%            |
> | 500             | 1.42%            | 1.24%        | 1.25%            |
> |---------------- |------------------|--------------|------------------|
>
>
> (*) - Above and below values are higher even without the patch with menu =
governor,
>       this issue still persists, as previously reported in [2]. I will in=
vestigate
>       further and submit a revision to get additional feedback.
>
> I also carried out some benchmarks using pgbench:
>
> pgbench Results
>
> Without Patch:
> -------------------------------------------------------------------------=
----
> | Run  | Transactions Processed | Latency Avg (ms) | TPS (without init ti=
me) |
> -------------------------------------------------------------------------=
----
> |  1   |  11,936,327            |  0.050           |  198,946.141025     =
    |
> |  2   |  11,899,540            |  0.050           |  198,333.097547     =
    |
> |  3   |  11,870,792            |  0.051           |  197,853.728614     =
    |
> |  4   |  11,901,670            |  0.050           |  198,368.526139     =
    |
> |  5   |  11,922,046            |  0.050           |  198,708.112243     =
    |
> -------------------------------------------------------------------------=
----
> | Avg  |  11,906,075            |  0.0502          |  198,441.921114     =
    |
> -------------------------------------------------------------------------=
----
>
> With Patch:
> -------------------------------------------------------------------------=
----
> | Run  | Transactions Processed | Latency Avg (ms) | TPS (without init ti=
me) |
> -------------------------------------------------------------------------=
----
> |  1   |  12,052,865            |  0.050           |  200,888.492771     =
    |
> |  2   |  12,058,359            |  0.050           |  200,979.895325     =
    |
> |  3   |  12,071,012            |  0.050           |  201,190.809734     =
    |
> |  4   |  12,054,646            |  0.050           |  200,918.076736     =
    |
> |  5   |  12,053,087            |  0.050           |  200,892.045581     =
    |
> -------------------------------------------------------------------------=
----
> | Avg  |  12,058,394            |  0.0500          |  200,973.464029     =
    |
> -------------------------------------------------------------------------=
-----
>
> Performance Improvement After Patch:
> -------------------------------------------------------------------------=
-------------
> | Metric                  | Without Patch (Avg.)| With Patch (Avg.)  | % =
Improvement |
> -------------------------------------------------------------------------=
-------------
> | Transactions Processed  |  11,906,075         |  12,058,394        |  +=
1.28%       |
> | Latency Avg (ms)        |  0.0502             |  0.0500            |  -=
0.40%       |
> | TPS (without init time) |  198,441.921114     |  200,973.464029    |  +=
1.28%       |
> -------------------------------------------------------------------------=
-------------
>
> So with the patch pgbench's "Transactions Processed" improves by ~1.28%, =
and I did not observe
> any major variations on other benchmarks with the patch.
>
> So for the entire series:
>
> Tested-by: Aboorva Devarajan <aboorvad@linux.ibm.com>

Thank you!

> I'm also trying a minimal unit fuzz-test with the pre- and post- patched =
version of the get_typical_interval
> function to understand this better, will post the results soon.
>
> [1] - https://github.com/AboorvaDevarajan/linux-utils/tree/main/cpuidle/c=
puidle_wakeup
> [2] - https://lore.kernel.org/all/20240809073120.250974-1-aboorvad@linux.=
ibm.com/

