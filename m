Return-Path: <linux-pm+bounces-19433-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2C39F6992
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 16:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AFFD7A2633
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 15:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C651E9B04;
	Wed, 18 Dec 2024 15:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHndnjE6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379842AF06;
	Wed, 18 Dec 2024 15:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734534616; cv=none; b=jLz9kCkGQdtIxnpncAh/CPrAXhvL6GTFwcURmW+jVUYc62oTNidc6R2TmhBJse0ikLKl6YL34ow8XWTyuwZ9zN+SOUqGunZvVfWBESuB+tCRJQRXXueKaOL9xRdAX0TXNnEVJAkMlBD8UPtWXkMDU+U3wTAOcaFwpmWx7F2wz/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734534616; c=relaxed/simple;
	bh=G4pKV3afHZO3mq0GubTyL+3VV4jjQhyB7Yayygo9oWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PUu3XqI5lZ3uWBnyFQkxqXHLOKcIwbAhlf33AtRJ0xaGU73wducIES5ddu8aq7T+7zuSLMr+0AE3Ag6bD5geUje+5AY0dkOrEnOcfhWLEef+SKD78jRFR2rDSSBRo2D3SgFhYv6odn/QRuTTDrwtWoRhfWHoL+8FlceP+GV7K08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHndnjE6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C8AC4CED4;
	Wed, 18 Dec 2024 15:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734534615;
	bh=G4pKV3afHZO3mq0GubTyL+3VV4jjQhyB7Yayygo9oWs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WHndnjE6VfreDDNtn8bujdnVDKPTa3JGQIWrbLx5Sg5tGLGohumiTXBrJhycy4n7w
	 Pt7QBaj9aeSlBnBh7lCNNWUbkdSopzBINLhhJCyz/dhSUVKZ99RJk4n+JxbZvALUIm
	 mMhkrFYgNIYz9LCGL3k83kqZQfHrYpzxYREvJYapyLrOtZntIMBkUsfs5BX03dqRgs
	 2ZWrV0S6i5mlHC1l9pWnFnLDJ96cgMBQtHpgF7FsKVXXp6Z7tZ0HuLM9qZBqlqbWQ/
	 3C3JWcN6G0Qz1O0ywU0E56Nv4ykks8SaAnAdl74WBZOEx04mL4hI0lOwM29sgkQTw7
	 SRZf6htPDFYgg==
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2f441791e40so124636a91.3;
        Wed, 18 Dec 2024 07:10:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUjd5H0oOnxCamSAVSKggkxYnrcn46iLchNgq9tFP3d3OZBtBh97Mb9ddD50EkM2OzmexujOAqPfi9ZoTM=@vger.kernel.org, AJvYcCUo/N137POpjFiEQllHICZqAIp1DEPilSFDqzPo5dONH2ePxAtI+43WUI4hwB6a+kvnGKqFQyPugaI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7CZ/xp/lMJUTT9TPPkikgZ1+v4aIDn+Z1wjCHXW3lQhXHe4ms
	xNRfCuiX90RqMvoZKuleZpfDayFS4OmoaDn0hstuUtthl9ozYMKEvrRvnpfrqP3eO7NksWpklH4
	UtysmICyVm+oXE6e51xX0bjCgcG0=
X-Google-Smtp-Source: AGHT+IGBCOz+Zwe8RWtIRlvZdeGdXrnOG5ETkJCBE/Qkl+AHKMTnv3fLS96Jgc1WFx6DltPLajki9fW+jnTqayENWwk=
X-Received: by 2002:a17:90b:524d:b0:2ee:f076:20fb with SMTP id
 98e67ed59e1d1-2f2e91fa529mr5265508a91.17.1734534615333; Wed, 18 Dec 2024
 07:10:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212015734.41241-1-sultan@kerneltoast.com>
 <20241212015734.41241-2-sultan@kerneltoast.com> <79448239-86df-43ef-9a4f-717802d2c70a@arm.com>
In-Reply-To: <79448239-86df-43ef-9a4f-717802d2c70a@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 18 Dec 2024 16:10:03 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j3X8BC57bxktxSZN+0XqZSGmdtGZoL8QV-_Um9pSynaA@mail.gmail.com>
Message-ID: <CAJZ5v0j3X8BC57bxktxSZN+0XqZSGmdtGZoL8QV-_Um9pSynaA@mail.gmail.com>
Subject: Re: [PATCH 1/2] cpufreq: schedutil: Fix superfluous updates caused by need_freq_update
To: Christian Loehle <christian.loehle@arm.com>, Sultan Alsawaf <sultan@kerneltoast.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 2:24=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 12/12/24 01:57, Sultan Alsawaf wrote:
> > From: "Sultan Alsawaf (unemployed)" <sultan@kerneltoast.com>
> >
> > A redundant frequency update is only truly needed when there is a polic=
y
> > limits change with a driver that specifies CPUFREQ_NEED_UPDATE_LIMITS.
> >
> > In spite of that, drivers specifying CPUFREQ_NEED_UPDATE_LIMITS receive=
 a
> > frequency update _all the time_, not just for a policy limits change,
> > because need_freq_update is never cleared.
> >
> > Furthermore, ignore_dl_rate_limit()'s usage of need_freq_update also le=
ads
> > to a redundant frequency update, regardless of whether or not the drive=
r
> > specifies CPUFREQ_NEED_UPDATE_LIMITS, when the next chosen frequency is=
 the
> > same as the current one.
> >
> > Fix the superfluous updates by only honoring CPUFREQ_NEED_UPDATE_LIMITS
> > when there's a policy limits change, and clearing need_freq_update when=
 a
> > requisite redundant update occurs.
> >
> > This is neatly achieved by moving up the CPUFREQ_NEED_UPDATE_LIMITS tes=
t
> > and instead setting need_freq_update to false in sugov_update_next_freq=
().
> >
>
> Good catch!
> Fixes:
> 600f5badb78c ("cpufreq: schedutil: Don't skip freq update when limits cha=
nge")
>
>
> > Signed-off-by: Sultan Alsawaf (unemployed) <sultan@kerneltoast.com>
>
> Reviewed-by: Christian Loehle <christian.loehle@arm.com>

Applied with the above Fixes tag added as 6.14 material, thanks!

