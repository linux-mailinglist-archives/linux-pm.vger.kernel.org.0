Return-Path: <linux-pm+bounces-17458-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E09C9C6521
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 00:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89E48B35ECE
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 20:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F42021A4A0;
	Tue, 12 Nov 2024 20:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USeBs3QR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168641FC7F8;
	Tue, 12 Nov 2024 20:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731443877; cv=none; b=CfTQF+6GA2Txxbd1iXmy8BLwPdWCOtDykDClTTIll4XuCgXxre2RR+hNIIdrbHpD8dCZMpUktZXLXM60U0EVt710iWxpvDVh7x3au17BrS0761p31imTERiAwJ/Mx2GYsSqMuwcSHKfbce3AhMN0AZgJCM4Yv0R8P/SBenG4qYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731443877; c=relaxed/simple;
	bh=yXBDDpX5Nne0KSFPur1AW9EtsgTTkx8cGH0nAt0Vycs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nhvbFR+lNgFHzLF7xiSb1nyDCdfKILk8/V3CjW/rL8nLhdAFHREk5eOFED/ADNGeE+svO3Gk1712VoICXq83j+DqVLk7XL5IrLhfNw7eidlAtBK5G1nvM+iolGsxy8TibiTZHkK70DgktRtT+BkAekiAyFAR/RtyOO/FGGSgD1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USeBs3QR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9154AC4CED6;
	Tue, 12 Nov 2024 20:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731443876;
	bh=yXBDDpX5Nne0KSFPur1AW9EtsgTTkx8cGH0nAt0Vycs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=USeBs3QR23XbScpzlIffNzG4YsWtAyjxwrvL0yj8dpsNyQAnjz4OLZZaYAmVCGP4g
	 Li7UzwF1xDJLTWZYdfixfh6JllwlgoyfMltaOqYwxr9rE0Qa74Jvm/CjpREf2CY/js
	 v4NeqnNV2H+HXodpCbr2p2fk/CwExunUIzMXFJ9S4XzDOT28KuiaGvpgVA6qkjo8yJ
	 JGd81ZcExboPKV1UofT/tnjIuvvobQJ4EzFowaVguQnkYh+qYzdm+u1YQS5CgILOYA
	 9oyRVRr9s++46/WH7Tw08P7yyWyCh41lcHT32ZN7ECZzebdE5AXrJXJ40bkHtv7TxF
	 xQuurUvtXx0TA==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-288a90e4394so2742963fac.0;
        Tue, 12 Nov 2024 12:37:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWONwfCeq8+b8ggVM6dIrYoLMHZJdwD6ZzoMkDXgyMqVY0t+J5vtU/nhakr8UIqDCRVT/dQW76vonuE0ps=@vger.kernel.org, AJvYcCXyskEYRSLQTAZadogRjqKLeIuyo040Nia2bwVTuZOlD3wC5TpFT9UKU4u/Ev2+GOR3idZFEFvSfz4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3XOWuT8p1bACGyNq4sMoA7pYxwJHgYtcxsNY7zOLvQIuFebRv
	0zZw6J4B3lL0x4r7G0+24GjWosEfytaeKP/lBE9zQqBq+31YZYPOPqc1EF1BWCZiBNn8YVEhazi
	itALJdZdHE/23Pi0KJ6V8mWCZr3A=
X-Google-Smtp-Source: AGHT+IHL/xn7TOVpywsJHQV5/rwJ6UZraf60gBSPf4x7lNnuMczYaXhJ9AMeuIXwT8aF/VQUxmqsfEhzfuXIy7UYV38=
X-Received: by 2002:a05:6871:401:b0:277:f5d8:b77b with SMTP id
 586e51a60fabf-295cd224ff1mr4260117fac.32.1731443875870; Tue, 12 Nov 2024
 12:37:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <35e572d9-1152-406a-9e34-2525f7548af9@arm.com>
In-Reply-To: <35e572d9-1152-406a-9e34-2525f7548af9@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 Nov 2024 21:37:44 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hXG46ph5F4JE5M=VymVdNx=_4Uyvy4QZos-ydLYzODfQ@mail.gmail.com>
Message-ID: <CAJZ5v0hXG46ph5F4JE5M=VymVdNx=_4Uyvy4QZos-ydLYzODfQ@mail.gmail.com>
Subject: Re: [PATCH] sched/cpufreq: Ensure sd is rebuilt for EAS check
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pierre Gondois <pierre.gondois@arm.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@vger.kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 9, 2024 at 1:24=E2=80=AFAM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> Ensure sugov_eas_rebuild_sd() is always called when sugov_init()
> succeeds. The out goto initialized sugov without forcing the rebuild.
>
> Previously the missing call to sugov_eas_rebuild_sd() could lead to EAS
> not being enabled on boot when it should have been, because it requires
> all policies to be controlled by schedutil while they might not have
> been initialized yet.
>
> Fixes: e7a1b32e43b1 ("cpufreq: Rebuild sched-domains when removing cpufre=
q driver")
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>  kernel/sched/cpufreq_schedutil.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_sche=
dutil.c
> index c6ba15388ea7..28c77904ea74 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -783,9 +783,8 @@ static int sugov_init(struct cpufreq_policy *policy)
>         if (ret)
>                 goto fail;
>
> -       sugov_eas_rebuild_sd();
> -
>  out:
> +       sugov_eas_rebuild_sd();
>         mutex_unlock(&global_tunables_lock);
>         return 0;
>
> --

Applied as 6.13 material, thanks!

