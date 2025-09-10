Return-Path: <linux-pm+bounces-34354-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE34B5145E
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 12:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E390F1C80B0F
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 10:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F113168E8;
	Wed, 10 Sep 2025 10:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikuwFCWc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1A330DEB0;
	Wed, 10 Sep 2025 10:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757501284; cv=none; b=IkmD6tvQhSljQwkuObzfsd8nt+xfyNOdddhFkUV2c6k3Vpwjj6H/TJDe9vCUUK73mejdNFGpRPDFz+IFj0VIExJXNajUvVP17a46BCSQZgS1Yk6WALM3OrbNJM9a9RWQzdmm85pQBR13sjodcWb9/VBPP7PfzI6r+nY2Vn0kuoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757501284; c=relaxed/simple;
	bh=qDpgc9lbGYlwfBYi10xPhVUs43JbbR7o2l7CiQw1yPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z+RreGabh30TZ7HTuJv0nbMoD78q8q25tiwOnBK4gm1/6ZPBn4xSOmb/AoeiO1V/NtPUdx8kWB5aJdZqDcMtgCi3N4ZwT20GFhs3X9Ob38FSdHnD8cFyIFFlOXHR5ntkYVRR22eQZPzAAIUsGIdjgqKms3pvMUQ9oomM3LphOJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikuwFCWc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F4EC4CEF5;
	Wed, 10 Sep 2025 10:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757501283;
	bh=qDpgc9lbGYlwfBYi10xPhVUs43JbbR7o2l7CiQw1yPE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ikuwFCWcJQMbXqT6ZfYU0s7v1wnqccpphYl74kAuoodBa3YQVNSPK8ILuKz8wcTxE
	 +zWH18fBpbZrhiLdGwT8ygna2yTT+zwBZSiezbGREhnjLk+tc5czoYnwDhUbeyh1q0
	 Rb7cD3ucwypUrs6NoKbQGoC8fi3QWLQ5N3x60ckawA9IG62BEJOWifg6bqq/8O+efA
	 NzueSrPZchkr7v7LjtR+VaxOnsDHQhYPqyOlwE9bBIGBhKws8UYgCDM6yBYM6zSN1p
	 INGEni4w/SMqZrvQvd1BBIoUSYE1nmKAPa7Pytio9oFS9lLDR6srh//tBVH8iRjmXA
	 3EJNZNRdeengg==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-61e783a1e00so4364560eaf.1;
        Wed, 10 Sep 2025 03:48:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU8hmPYyTfgsR9wDjcdY75E0R4b2N0l5j9V9s/Z+vm+qXs/q2hj7v28PMCaS0/suK/+Jj0DGDhbeB0=@vger.kernel.org, AJvYcCUSWUq00e2PWhWpHYgwUFmCki1S2rzI54xFQiOt42fi2+I4J+G9t67OQKJSPh+bg3huFdVfk7mlU4szYas=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK3tAU5Zb9/1kju1m4Xfnpskp546DmGQlxckbb2VVGhhgCZ53t
	61lO+RsFbrKwffahzOg3INwFg+stvrObdmNE0AZ0J1qhuXpPqhMecDynscQqO9PgwhrcmxioebY
	8h9t7QAL0p0BQsjmZYTFUBwFh1oExMxY=
X-Google-Smtp-Source: AGHT+IFC3+WBj79KyRnaqtx2xXM/liykO21L96RODQt39xRNhwTw4jpy+n/c1yaN69BCg98VErRnV2TPPxbV5z7r5wo=
X-Received: by 2002:a05:6820:1ad0:b0:621:aa5e:f502 with SMTP id
 006d021491bc7-621aa5ef7b3mr695472eaf.5.1757501277728; Wed, 10 Sep 2025
 03:47:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908075443.208570-1-aboorvad@linux.ibm.com>
In-Reply-To: <20250908075443.208570-1-aboorvad@linux.ibm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 10 Sep 2025 12:47:46 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hLYkeStuZqUsjSphXmBovAxCvvzx4JJJw=3AmDYjdCtQ@mail.gmail.com>
X-Gm-Features: Ac12FXzBD6IaoVn6PUKKFS-uKjzoe8FMWezXsDom8HFc21nQgUtJ6Hl_t8__7EE
Message-ID: <CAJZ5v0hLYkeStuZqUsjSphXmBovAxCvvzx4JJJw=3AmDYjdCtQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] cpuidle: menu: Add residency threshold for
 non-polling state selection
To: Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: rafael@kernel.org, christian.loehle@arm.com, daniel.lezcano@linaro.org, 
	gautam@linux.ibm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please change the subject of the patch to something like "cpuidle:
menu: Use residency threshold in polling state override decisions"
which more precisely reflects the patch purpose IMV.

On Mon, Sep 8, 2025 at 9:54=E2=80=AFAM Aboorva Devarajan <aboorvad@linux.ib=
m.com> wrote:
>
> On virtualized PowerPC (pseries) systems, where only one polling state
> (Snooze) and one deep state (CEDE) are available, selecting CEDE when
> the predicted idle duration exceeds the target residency of the CEDE

If the target residency is exceeded by the predicted idle duration, it
should be fine to select the given state.

Did you really mean "less than" here?  That would be consistent with
the code change.

> state can hurt performance. In such cases, the entry/exit overhead of
> CEDE outweighs the power savings, leading to unnecessary state transition=
s
> and higher latency.
>
> Menu governor currently contains a special-case rule that prioritizes
> the first non-polling state over polling, even when its target residency
> is much longer than the predicted idle duration. On PowerPC/pseries,
> where the gap between the polling state (Snooze) and the first non-pollin=
g
> state (CEDE) is large, this behavior causes performance regressions.
>
> This patch refines the special case by adding an extra requirement:
> the first non-polling state may only be chosen if its
> target_residency_ns is below the defined RESIDENCY_THRESHOLD_NS. If this
> condition is not met, the non-polling state is not selected, and polling
> state is retained instead.
>
> This change is limited to the single special-case condition for the first
> non-polling state. The general state selection logic in the menu governor
> remains unchanged.
>
> Performance improvement observed with pgbench on PowerPC (pseries)
> system:
> +---------------------------+------------+------------+------------+
> | Metric                    | Baseline   | Patched    | Change (%) |
> +---------------------------+------------+------------+------------+
> | Transactions/sec (TPS)    | 495,210    | 536,982    | +8.45%     |
> | Avg latency (ms)          | 0.163      | 0.150      | -7.98%     |
> +---------------------------+------------+------------+------------+
> CPUIdle state usage:
> +--------------+--------------+-------------+
> | Metric       | Baseline     | Patched     |
> +--------------+--------------+-------------+
> | Total usage  | 12,735,820   | 13,918,442  |
> | Above usage  | 11,401,520   | 1,598,210   |
> | Below usage  | 20,145       | 702,395     |
> +--------------+--------------+-------------+
>
> Above/Total and Below/Total usage percentages which indicates
> mispredictions:
> +------------------------+-----------+---------+
> | Metric                 | Baseline  | Patched |
> +------------------------+-----------+---------+
> | Above % (Above/Total)  | 89.56%    | 11.49%  |
> | Below % (Below/Total)  | 0.16%     | 5.05%   |
> | Total cpuidle miss (%) | 89.72%    | 16.54%  |
> +------------------------+-----------+---------+
>
> The results show that restricting non-polling state selection to
> cases where its residency is within the threshold reduces mispredictions,
> lowers unnecessary state transitions, and improves overall throughput.
>
> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> ---
>
> v2: https://lore.kernel.org/all/20250317060357.29451-1-aboorvad@linux.ibm=
.com/
>
> Changes in v2 -> v3:
>   - Modifed the patch following Rafael's feedback, incorporated a residen=
cy threshold check
>     (s->target_residency_ns < RESIDENCY_THRESHOLD_NS) as suggested.
>   - Updated commit message accordingly.
> ---
>  drivers/cpuidle/governors/menu.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors=
/menu.c
> index b2e3d0b0a116..d25b04539109 100644
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -316,11 +316,13 @@ static int menu_select(struct cpuidle_driver *drv, =
struct cpuidle_device *dev,
>
>                 if (s->target_residency_ns > predicted_ns) {
>                         /*
> -                        * Use a physical idle state, not busy polling, u=
nless
> -                        * a timer is going to trigger soon enough.
> +                        * Use a physical idle state instead of busy poll=
ing
> +                        * if the next timer doesn't expire soon and its
> +                        * target residency is below the residency thresh=
old.

I would rephrase this somewhat, like this:

* Use a physical idle state instead of busy polling so long as
* its target residency is below the residency threshold and the
* next timer doesn't expire soon.

>                          */
>                         if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLIN=
G) &&
> -                           s->target_residency_ns <=3D data->next_timer_=
ns) {
> +                           s->target_residency_ns <=3D data->next_timer_=
ns &&
> +                           s->target_residency_ns < RESIDENCY_THRESHOLD_=
NS) {

And maybe adjust the checks ordering here.

The point is that on the example platform in question
s->target_residency_ns is always above RESIDENCY_THRESHOLD_NS, so it
is never really necessary to check data->next_timer_ns in which case
the HW should be able to optimize this.

>                                 predicted_ns =3D s->target_residency_ns;
>                                 idx =3D i;
>                                 break;
> --

