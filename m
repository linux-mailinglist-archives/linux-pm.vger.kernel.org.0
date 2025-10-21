Return-Path: <linux-pm+bounces-36600-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 768B7BF83DF
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 21:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 19D274EC574
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 19:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C573351FB4;
	Tue, 21 Oct 2025 19:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9UkZCiT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC085351FB2
	for <linux-pm@vger.kernel.org>; Tue, 21 Oct 2025 19:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761074735; cv=none; b=iV+7j0uhUfOD25KVsg4KvXEmN41pncV3zGBnfoO2RlXHrdYpcX3WwgKvJDgJR0CaDbZqd5X+2nSdkTnLRetOZVm6f2BtjuaYHGG7WQQeRcRZxn0vfdPHgBZuhoaBnwd8mXl2Hv0SQi8ObcRZ9xFsoP+KdaEKt3nodqIJVsneyPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761074735; c=relaxed/simple;
	bh=ZBF6Sb+cThRkUXiAy5cx8gb0t4QYBOQD5Da7vH3eOV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TrLyHbdzfwUc60C2owEaUkE4RSf0mVmzjrEhGPcnwQVj4OVtsATFWq1aLE3wMHoJZS+vzqOC/zidL7w90qcH5io/InlDQMHsVzZiK/gpMXFdB9o2dBfUjj2oB5SAVZQu7npiwR+EZdIRQ7I/4cqDAQyAyMBLnE3N1fYbUFw4YkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9UkZCiT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73EAEC16AAE
	for <linux-pm@vger.kernel.org>; Tue, 21 Oct 2025 19:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761074734;
	bh=ZBF6Sb+cThRkUXiAy5cx8gb0t4QYBOQD5Da7vH3eOV8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=f9UkZCiTqkbQUkw9AqLwqf3fnZzTRZPnXo/w8T43slZmXYcj9OPM3blv8JCPHgM/T
	 3J1qFp/oqsZpj0lgIn/nJjSZHwxRp0NXXvDzBosM1ecvGcrAiKFopy2zsKhKBYWtcK
	 ZiTP0mtNW6hzjvkQV6RPQoCQ01xs2x/m7ZQ6Jc80pDWw6L73TD9RzMD6CEW3FyY0/r
	 SNXeUbvQMXfgR6+P2KH5rYlS0WO8cax3NQov+So5nrXnl18+3ZBhhpqeLkTx1F3wcp
	 LCNHtAhCtWns/vy1JcI0886vGmhi8/aTwhixKz5eSEIGC5KQHSQWim8AR8i1QktWjB
	 im8Z/eSJegiZg==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7bb79ad6857so3154891a34.0
        for <linux-pm@vger.kernel.org>; Tue, 21 Oct 2025 12:25:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV4eIqFinhekvSDKNAutEzWWm52WeVkICUGYiMvOXm98RQX9lcFf6AgbfZfvgCJ/fLFQhMe+Xj34A==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy3JIA0+jKir5prno73mm7Lt+EpztYyix/gsZdg0ACkJaT5VGi
	1vs3w03MhBqvP8t6ECtM/4s1DcRVtLkcDp2J/lgDr5HBNsxPVF1GRvn1N/JEqJQxKByL7JMWzE0
	QDuGCupCD2fe0XpJpFwcnmGKzpCDuIIE=
X-Google-Smtp-Source: AGHT+IE/08QSQyp9X0ccFhg4UFvUOgwCgdeciymPiqm4mIxF4c8LobqZKfy8Ajho/BYpHKCpe1Dso5SMqC5wRfFNnKo=
X-Received: by 2002:a05:6808:2211:b0:438:bdb0:89b6 with SMTP id
 5614622812f47-443a3095328mr7294620b6e.34.1761074733638; Tue, 21 Oct 2025
 12:25:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006013954.17972-1-aboorvad@linux.ibm.com>
In-Reply-To: <20251006013954.17972-1-aboorvad@linux.ibm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 21 Oct 2025 21:25:22 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hCvvMzPCy+8N34vCt_d4mdeuMVHR9dQbs4cHwQDOpYrw@mail.gmail.com>
X-Gm-Features: AS18NWBMycXoaeD05VXzOVH8lO1ntRK70bBfzIJ49OyblOMmInRKm-CI_7G6PUg
Message-ID: <CAJZ5v0hCvvMzPCy+8N34vCt_d4mdeuMVHR9dQbs4cHwQDOpYrw@mail.gmail.com>
Subject: Re: [PATCH v4] cpuidle: menu: Use residency threshold in polling
 state override decisions
To: Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: rafael@kernel.org, christian.loehle@arm.com, daniel.lezcano@linaro.org, 
	gautam@linux.ibm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 3:40=E2=80=AFAM Aboorva Devarajan <aboorvad@linux.ib=
m.com> wrote:
>
> On virtualized PowerPC (pseries) systems, where only one polling state
> (Snooze) and one deep state (CEDE) are available, selecting CEDE when
> the predicted idle duration is less than the target residency of CEDE
> state can hurt performance. In such cases, the entry/exit overhead of
> CEDE outweighs the power savings, leading to unnecessary state
> transitions and higher latency.
>
> Menu governor currently contains a special-case rule that prioritizes
> the first non-polling state over polling, even when its target residency
> is much longer than the predicted idle duration. On PowerPC/pseries,
> where the gap between the polling state (Snooze) and the first non-pollin=
g
> state (CEDE) is large, this behavior causes performance regressions.
>
> This patch refines the special case by adding an extra requirement:
> the first non-polling state can only be chosen if its
> target residency is below the defined RESIDENCY_THRESHOLD_NS. If
> this condition is not satisfied, polling is allowed instead, avoiding
> suboptimal non-polling state entries.
>
> This change is limited to the single special-case rule for the first
> non-polling state. The general non-polling state selection logic in the
> menu governor remains unchanged.
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
> Above/Total and Below/Total usage percentages:
> +------------------------+-----------+---------+
> | Metric                 | Baseline  | Patched |
> +------------------------+-----------+---------+
> | Above % (Above/Total)  | 89.56%    | 11.49%  |
> | Below % (Below/Total)  | 0.16%     | 5.05%   |
> | Total cpuidle miss (%) | 89.72%    | 16.54%  |
> +------------------------+-----------+---------+
>
> The results indicate that restricting CEDE selection to cases where
> its residency matches the predicted idle time reduces mispredictions,
> lowers unnecessary state transitions, and improves overall throughput.
>
> Reviewed-by: Christian Loehle <christian.loehle@arm.com>
> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> ---
>
> v3: https://lore.kernel.org/all/20250908075443.208570-1-aboorvad@linux.ib=
m.com/
>
> v3 -> v4
>
> - Rebased onto the linux-pm/pm branch.
> - Updated commit message and comments based on review feedback.
> - Reordered condition checks as recommended in review.
> - Added Reviewed-by tag from Christian.
>
> ---
>  drivers/cpuidle/governors/menu.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors=
/menu.c
> index 4d9aa5ce31f0..6a98a724442e 100644
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -320,10 +320,12 @@ static int menu_select(struct cpuidle_driver *drv, =
struct cpuidle_device *dev,
>                 }
>
>                 /*
> -                * Use a physical idle state, not busy polling, unless a =
timer
> -                * is going to trigger soon enough.
> +                * Use a physical idle state instead of busy polling as l=
ong as
> +                * its target residency is below the residency threshold =
and the
> +                * next timer doesn't expire soon.
>                  */
>                 if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) &&
> +                   s->target_residency_ns < RESIDENCY_THRESHOLD_NS &&
>                     s->target_residency_ns <=3D data->next_timer_ns) {
>                         predicted_ns =3D s->target_residency_ns;
>                         idx =3D i;
> --

Applied as 6.19 material, thanks!

