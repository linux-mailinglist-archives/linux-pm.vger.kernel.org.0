Return-Path: <linux-pm+bounces-38569-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D308C84BFE
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 12:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D96F64E962F
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 11:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817D7314D1B;
	Tue, 25 Nov 2025 11:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xuRTr1EG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEEF269811
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 11:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764070329; cv=none; b=Q1KrDXobL08jNRAGDF28TaXD1MWST/xUZHdIrNGlUwpLNZ2Gnul6Ot4STG3t+SkkXYZ99c07ujxI6JZzRKUYAv03sF590VKKcKJj1TKAw3rC41ibTZbkJX1ac18Z7QuhDJzsojk8+VnxtxYSFL9SrxxdxmxecajIkS0p1Ri1c3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764070329; c=relaxed/simple;
	bh=7a7RnmmLTssTFTjSRIVppR2uwhEzvlnd9lff3gPcWRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RrfnLSdct/OuLIDJb+K0/yk222XEPEp/oUHgbFZN6yYztv4LS6+EGY22uLUspQtoVzfTMRRPc32PQWEagcDaHebl+XjeTK8iun7CqP6taTBTyAQ8O2ph1o9tQBAnUa2eyUnQPJ4u5Xte06e7daf8hKlTnYjULzXQv0sN48A3FiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xuRTr1EG; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-787ff3f462bso64055007b3.0
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 03:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764070325; x=1764675125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jdgq0bVbhrEi3bMMfsTvvs5YPnMcVFvL/k3uRvBRnHA=;
        b=xuRTr1EGhejtCAytUcOFcuVQQgEnbb1BtetW66aFmENlklm2Lo/rMInqa6TEhlZqzb
         /Oh12YItvFld5q6CXm1ZtgdnFAxwfA/Em0SBkw7EqZJYZ7KK5aM17AdBzZiPQztCZRkY
         FlKYJWp7IWLadyDvCf/Dv8CDqTiSzRJyAz6+cKqzW2ENlYSkfk37Br047mWFLKgChq1f
         MZDWEaz2gswVkcwkoCQTk+E1On+g/0U5e2LUZQ5u+aWciESluFKttZfZ58/thjRYINuT
         usZucRxdm4B+FkmUgVD3mRQ/k5OD7L60Q16vwdfRGPIqirhdEGrk4sXcyxYnId1cGp+O
         YKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764070325; x=1764675125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jdgq0bVbhrEi3bMMfsTvvs5YPnMcVFvL/k3uRvBRnHA=;
        b=UKUE7Yxjc365xMFIBIaZ6hMM7xqV5NOaC/7IKuKDKEsnclNjX3j9acA8CmczuGAwuR
         0N1e/QYvfEvLbZ78JTf4QPEPbBw/wYdtfNkGbgOq6PDRaJb0kshXJQ1pf9FZwRjGZlwA
         uWOd+zQC8WxWXjHKvY6XoRnq+BPigkz+NqLkTlD9hmVSrcNmzgd5fSSrnK2SKJ4yPk1u
         fM/dTyWGN1/6nMEqTuAWue5qlos2VihLVDib6fAAAsvLDoQZucTHaJFPGyafy0WrkTIk
         f7g9tUxS3rEWjBDlxOOVkoRbILroCdafsch2Mkcwznu+atHFC3ehPNvF7c9fU3Sl2c8+
         HDiw==
X-Gm-Message-State: AOJu0YyCF434VHH9E73ws0vDgB7f4wV2zXKuz+t6D/X8DmU2VPcM8GkL
	7epTDMwMYkTT0rnzIK0vA2KmWJHlIEGKY2oZ1dSAkDt1qmpIjTrs2c+QerAr89kEbZ0RZVsCHQz
	0nSXMQJ1jFZzHa07wgaeE/TEcnSABh+wDuZWP/yZ71g==
X-Gm-Gg: ASbGncv9M9mr9ynlRt1KrpYJAj0mKScRbuM8KJnOQCx2HiSu56cQQIYLOy7LNOzeDy7
	OfGNTz5r8uY6k1I2a/4CRdrpJQXJkp7Weuc6EkIKkrHP5o3rvUSTx5kJJrGy5MRV59fx8Pg6A+q
	73gwRoiMVph1PYGkAcbWPyCv5t9e271v6c/ragkPQvDLH7lkFZIfjpJcVL/3Js47QUMNoRzGVG/
	+OQwEGXYVdyAwP7JjMTD7rTc8DGt++edLyuksm5nWlMG2S4slPxqU71fQDrvt7XHhkCFaxk
X-Google-Smtp-Source: AGHT+IFhfLdKm6rAo23pfgabS179QXhAWbCIO/b9GB500wRoWpla0PTKFgV6h7hOjTlWrfO97zoZ3tRuzVhlUMMOnAM=
X-Received: by 2002:a05:690c:4b05:b0:788:1258:2042 with SMTP id
 00721157ae682-78a7bbb0ff0mr154133627b3.26.1764070325553; Tue, 25 Nov 2025
 03:32:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121100315.316300-1-ulf.hansson@linaro.org> <CAJZ5v0hz+gMnnPVX=uT3dh0tSoaATVOzwrhdBoupeYFgo6Rqkw@mail.gmail.com>
In-Reply-To: <CAJZ5v0hz+gMnnPVX=uT3dh0tSoaATVOzwrhdBoupeYFgo6Rqkw@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 25 Nov 2025 12:31:29 +0100
X-Gm-Features: AWmQ_bl0s_dbSdxgtxcjiMiFs5VJIPdsRIaFmMSHWm1Db4ppdfHpxz67ifOlogM
Message-ID: <CAPDyKFqAOdezBdBHu2WpQKJB2tpasWyHToMR4QJn+-pW3Ndx+w@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] PM: QoS: Introduce a CPU system wakeup QoS limit
 for s2idle
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, 
	Peter Zijlstra <peterz@infradead.org>, Kevin Hilman <khilman@baylibre.com>, 
	Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Maulik Shah <quic_mkshah@quicinc.com>, 
	Prasad Sodagudi <psodagud@quicinc.com>, Dhruva Gole <d-gole@ti.com>, 
	Deepti Jaggi <quic_djaggi@quicinc.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 24 Nov 2025 at 19:27, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Nov 21, 2025 at 11:03=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.=
org> wrote:
> >
> > Changes in v3:
> >         - Take new the new QoS limit into account for cpuidle too (Rafa=
el).
> >         - Add a new Kconfig for the new QoS interface (Rafael)
> >         - Improved the documentation (Dhruva)
> >         - Clarified commit messages and added acks.
> >
> > Changes in v2:
> >         - Limit the new QoS to CPUs  and make some corresponding renami=
ng of the
> >         functions along with name of the device node for user space.
> >         - Make sure we deal with the failure/error path correctly when =
there are
> >         no state available for s2idle.
> >         - Add documentation.
> >
> > Some platforms supports multiple low power states for CPUs that can be =
used
> > when entering system-wide suspend and s2idle in particular. Currently w=
e are
> > always selecting the deepest possible state for the CPUs, which can bre=
ak the
> > system wakeup latency constraint that may be required for a use case.
> >
> > Therefore, this series suggests to introduce a new interface for user s=
pace,
> > allowing us to specify the CPU system wakeup QoS limit. The QoS limit i=
s then
> > taken into account when selecting a suitable low power state for s2idle=
/cpuidle.
> >
> > Kind regards
> > Ulf Hansson
> >
> >
> > Ulf Hansson (6):
> >   PM: QoS: Introduce a CPU system wakeup QoS limit
> >   pmdomain: Respect the CPU system wakeup QoS limit for s2idle
> >   pmdomain: Respect the CPU system wakeup QoS limit for cpuidle
> >   sched: idle: Respect the CPU system wakeup QoS limit for s2idle
> >   cpuidle: Respect the CPU system wakeup QoS limit for cpuidle
> >   Documentation: power/cpuidle: Document the CPU system wakeup latency
> >     QoS
> >
> >  Documentation/admin-guide/pm/cpuidle.rst |   9 ++
> >  Documentation/power/pm_qos_interface.rst |   9 +-
> >  drivers/cpuidle/cpuidle.c                |  12 +--
> >  drivers/cpuidle/governor.c               |   4 +
> >  drivers/pmdomain/core.c                  |  10 ++-
> >  drivers/pmdomain/governor.c              |  33 ++++++-
> >  include/linux/cpuidle.h                  |   6 +-
> >  include/linux/pm_domain.h                |   1 +
> >  include/linux/pm_qos.h                   |   9 ++
> >  kernel/power/Kconfig                     |   4 +
> >  kernel/power/qos.c                       | 106 +++++++++++++++++++++++
> >  kernel/sched/idle.c                      |  12 +--
> >  12 files changed, 196 insertions(+), 19 deletions(-)
> >
> > --
>
> It looks good to me now.

Thanks!

>
> Do you want me to pick it up or do you want to route it differently?

I think you can pick this up via your tree. As I have some changes
queued via my pmdomain tree for the genpd governor, I asked git to
merge our branches (with this series applied to your tree) and it
seems to be working fine.

To address Dhruva's minor comments I just posted a new version, please
queue it via your tree.

Kind regards
Uffe

