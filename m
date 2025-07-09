Return-Path: <linux-pm+bounces-30482-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E33AFE9C5
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 15:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1D9317BB89
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 13:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0413C2D9EC9;
	Wed,  9 Jul 2025 13:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULBaszFF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE560277804;
	Wed,  9 Jul 2025 13:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752066839; cv=none; b=n0i1tvPy8IL5Q7VmmK16H0OJGmis1kDNd503P1oIPV6tU+dSSi1ASBdc66gXMnIMn/TpSFGpr4gqvfeqqcbXfOIFzfyZdAKg662tggtxoT2P/RePPEp5Z/+0KX3Gt8quwK8phBDd03dAY9rgOvvSpWZP7eBpvfFCrYt9kZCKwr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752066839; c=relaxed/simple;
	bh=GCiyrhrAokCJ5FXJ1iBaRt52FT7bvdVtzALNWYPXmk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cFXLX5KtvuVgOQ3ChbQ5pBqqV8KMZTyltbtpo9djVBddo14dmO/SNn6/Vy/NpNHKdam+mTPlyvVWMl/z2xoE/4G1KFL/wndsNTQrDIbt+V0QijmXSBXvYp4XkDkkqVc/qWSUBRFyAJopeVuy7Y4nJkm1zX134u2NP3Kfl13WGwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULBaszFF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8752DC4CEEF;
	Wed,  9 Jul 2025 13:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752066839;
	bh=GCiyrhrAokCJ5FXJ1iBaRt52FT7bvdVtzALNWYPXmk0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ULBaszFFPpixglxO/OM51uGVxOMqJWeKljcaZIonTW5B+tS719NDXdoQeo0ZNbnRW
	 A4OltApsxS+jrThwC0VPO3hO8Qm9XcUmpFemvlJ2gEtF5DmmxnaFiXUjAX+Rn/3VON
	 wjOLQI1hY2D4lUIb4TpmyV2CrJVHsDtGDpBtyQ4/1sFi10fkoz00MJQh6bV6JHhCFk
	 JXRqqaUR45ULmHTCeSpIHD577JX2NzUmRLiD9UbazQ0mbvodFLi4aya1U3Sn6f/WvA
	 NjMNuBremKls3JXumsXz5CGRZEvs//rOObzg0Fjgo93X+13t45JDoHtM5yZe1q8G1H
	 PMnv6dczW5TJg==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-73ce08ff077so399246a34.1;
        Wed, 09 Jul 2025 06:13:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVuxJ8wXIphHOhWSQVMw8XorkzgCrTgkL5WdNcWuAhQFw//fClAYmNDx6y6xoTtgETpdo0vKQKVizRt+3Q=@vger.kernel.org, AJvYcCW04egyPyG8M9vIREXSy+eZenuh6WDE4jvDn2Ix+BxYi8rzRV+Dve+ygAntYALINP1CM0xO51rzWck=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdkYnejMARYDfDLzrIQdrt+1hQePbpwX0QTuy1ILAnxhk6lLSQ
	iGpNHEfXHwzcMhW9b8Gv6H8QTbveJJzhIFwT7plQOeWlbCLipWIS7s/ZqBh/fdn9oQdBrWm+gtL
	iuCwQiD73VILp/kWYvXV1pQp4uC0HB9g=
X-Google-Smtp-Source: AGHT+IGKEMaZZ7P0exiTz977FPMZ65hV+zH9kBxlmpI2QFAYYmEy09eL21sLRm/6rVFvvrySSBwhBliHPJOieC8O3z4=
X-Received: by 2002:a9d:5c89:0:b0:73a:70a9:d5aa with SMTP id
 46e09a7af769-73ce630de6dmr1762473a34.16.1752066838802; Wed, 09 Jul 2025
 06:13:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ebbb6534-5968-4530-b9c8-0f6b21a96992@linuxfoundation.org>
In-Reply-To: <ebbb6534-5968-4530-b9c8-0f6b21a96992@linuxfoundation.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Jul 2025 15:13:47 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g8qrCQijsLZ_WyppgHD2RRjkUna3GQZwEb=Fo1c_7kfQ@mail.gmail.com>
X-Gm-Features: Ac12FXz-hz1Xh_9_uqlLdUPChHkgnbcqF9mV1zSLc_PrCLbX-GsfgYE8QYE1Qxo
Message-ID: <CAJZ5v0g8qrCQijsLZ_WyppgHD2RRjkUna3GQZwEb=Fo1c_7kfQ@mail.gmail.com>
Subject: Re: [GIT PULL] cpupower update for Linux 6.17-rc1
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, shuah <shuah@kernel.org>, 
	Thomas Renninger <trenn@suse.com>, Thomas Renninger <trenn@suse.de>, "John B. Wyatt IV" <jwyatt@redhat.com>, 
	John Kacur <jkacur@redhat.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuah,

On Tue, Jul 8, 2025 at 9:40=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.or=
g> wrote:
>
> Hi Rafael,
>
> Please pull the following cpupower update for Linux 6.17-rc1.
>
> Fixes
>   - snapshot-order of tsc ,mperf, clock in mperf_stop()
>   - printing of CORE, CPU fields in cpupower-monitor
>
> Improves Python binding's Makefile
>
> diff is attached.
>
> thanks,
> -- Shuah
>
> ----------------------------------------------------------------
> The following changes since commit e044b8a9545cd8265c7110c179aeec2624c164=
55:
>
>    cpupower: split unitdir from libdir in Makefile (2025-06-09 10:17:46 -=
0600)
>
> are available in the Git repository at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-c=
pupower-6.17-rc1-fixed
>
> for you to fetch changes up to b74710eaff314d6afe4fb0bbe9bc7657bf226fd4:
>
>    cpupower: Improve Python binding's Makefile (2025-07-01 10:58:00 -0600=
)
>
> ----------------------------------------------------------------
> linux-cpupower-6.17-rc1-fixed
>
> Fixes
>   - snapshot-order of tsc,mperf, clock in mperf_stop()
>   - printing of CORE, CPU fields in cpupower-monitor
>
> Improves Python binding's Makefile
>
> ----------------------------------------------------------------
> Gautham R. Shenoy (2):
>        pm: cpupower: Fix the snapshot-order of tsc,mperf, clock in mperf_=
stop()
>        pm: cpupower: Fix printing of CORE, CPU fields in cpupower-monitor
>
> John B. Wyatt IV (1):
>        cpupower: Improve Python binding's Makefile
>
>   tools/power/cpupower/bindings/python/Makefile              | 12 +++++++=
-----
>   tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c |  4 ----
>   tools/power/cpupower/utils/idle_monitor/mperf_monitor.c    |  4 ++--
>   3 files changed, 9 insertions(+), 11 deletions(-)
> ----------------------------------------------------------------

Pulled and added to linux-pm.git/linux-next, thanks!

