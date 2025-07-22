Return-Path: <linux-pm+bounces-31251-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20212B0D194
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 08:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 523703AE140
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 06:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB1C28C00B;
	Tue, 22 Jul 2025 06:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g/xsoaWh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FCE28B4F3
	for <linux-pm@vger.kernel.org>; Tue, 22 Jul 2025 06:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753164135; cv=none; b=g3RjblFx3t7x0RRCXsFluCa0EJGhL8O1H/ilYJXwDEF1eecnCt5ILcth9AaYC8SKAXaPEvBGThXUxasRkUlA/DCiE2uld1POWCx6NOGY7PQKO7FSkEV2WaoZXQRExLUi9hwnrXFPr2Uq9g/yxAmZgf8k4KC0Qtdkan1AKnnj6SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753164135; c=relaxed/simple;
	bh=Gmi615c2Mk45pQvT0Gq0YQYiGmnW3uk8v8avbHfmyjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UzWSzsUpvzarEVITq8xtLworp6r+Jq3rh44mqvMK0PdIM3g3gUp0cQu6jSLA8YtMBQuOhO0AM6Lsp25xJJvGcjmNHF7FHuhI8IfdMTObY8z5PUFD3JfDbjZpW5azKtrXhd01A8HF7AnNBIbB6RVUGmIh8c6Zw3jUXvZlCfVSA+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g/xsoaWh; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ab86a29c98so217561cf.0
        for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 23:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753164132; x=1753768932; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iEGjdg7HJToRLli3XYx/W9dwn4YsTbR+WFCHWgF6+f4=;
        b=g/xsoaWhk/BwdZbgBqtRgRydOSBmZrCbKScIF4as9dgZqOzu+Rm8rMH4G6b11VnGyN
         35fkB6S5h8wPZFW/F/xNyBDI65bZ8U5gRujR8eRmAZR9f7WmcWwSiozI0k8rd/VuYSvB
         oqpspGKIl1VajsHUzN2EXrPOHqNaKPYyOZgjfefbM79b07Ycle0kAQn+qsT3EPgeXDyi
         Iel6YWTBp5URkrs2sbOizQuhfg+lFkTDTtRNl4ISfc30dz7MkEAKlzh62oAYonvdxyRH
         8PX6OKwxF7G39Qq0NOimmN1dYBjd8pDAAtZfKOS/RQJoHGiBQf49BsAeMwkJZ9heaZ3T
         3Fuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753164132; x=1753768932;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iEGjdg7HJToRLli3XYx/W9dwn4YsTbR+WFCHWgF6+f4=;
        b=Q1NAokt28iwwSNvqMOwT0IYvjjpH5IPSQfEMgau1HFsNyE/qkq2Nd6LdRRFwne+Sly
         gkrqwjo2B4AJjp22vaSK9xaM2YPGhAPirPVphVrqL7bz0Owj7LMUReyoBSQAbYTfMJCp
         95Ain/UheD7SquvHCpy8nJl1Cwpk+xX8ARgTWQMjnwtU+Lg41bi1oGm1Cn0WahZefeL9
         aWz2ckT6q56+MEfojIWoGrVtS6rmWhN3vOOi5MAWGjJW2VkoVhtOE7Qv1Da1j75f0p5d
         xILX+XXW6r7SThJwXd7YSSscE4RIqSj9kKUwCnKNB7Pt9EBN6YUvdlRM0X6xFtYhDLfy
         7X9w==
X-Forwarded-Encrypted: i=1; AJvYcCVFu9VZsXvgGh+WimMvLberKM8broOown5XNLN9Me/DbgR70KrPheGkmN0PvYZPFyeLXROWCbFMJw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzkcyTMQIteqDCE1NjnUmnzDrx6UMTlkbmetih7s6njTLkmy2b4
	FQ0i3QB/BSZBWAVLg3PqCUUllmkcamWagLXgcs/T89+U4qIHF/V3ya7C2A6NI/D7aZ3frOfOLs2
	mWjrFcbrb35Yshp/i/RHBQ/0wogKpoSiib67/9Onb
X-Gm-Gg: ASbGncvOVtB5Ctt7e+qlbTWIcoG2YrTYVJiOOHcCodloGOGvrrhe0rcdex8x6KO4h4H
	Vatj9Js/y3S0fhWD63w7f/O+PVTnRLNl4M/yh/2lrRK6Klh86cm4QL7ekaXoEGtgwWmluSMiOvK
	UtinIOAFpQ/gYhNAod5uRA+NfWGJYPFLH27f6mKU9nOacPVa7lS9zp0cIfuSwj1OjZ44PZzQwj+
	Ul9RiR4zGVeTN+6
X-Google-Smtp-Source: AGHT+IF1ds2IGRRFxMjxvhf4WbCFuR3dcQBemZde69IbNC1CMkGkd1veI6ndQqgJOZIxiZ/aM3hOhlqIf2oSwFkNZYk=
X-Received: by 2002:a05:622a:a916:b0:4aa:cba2:2e67 with SMTP id
 d75a77b69052e-4ae5f1c81b8mr1519071cf.21.1753164132291; Mon, 21 Jul 2025
 23:02:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ef3f933a-742c-9e8e-9da4-762b33f2de94@hisilicon.com>
 <CAFivqmLCW2waDnJ0nGbjBd5gs+w+DeszPKe0be3VRLVu06-Ytg@mail.gmail.com>
 <CAFivqm+D9mbGku-nZKSUEMcQV5XK_ayarxL9gpV5JyfmhirsPw@mail.gmail.com>
 <aGuGLu2u7iKxR3ul@arm.com> <CAFivqmJL90xsELhz4tPtkYA9vMzS9C=V__nwo=kWJKjKS=mE_Q@mail.gmail.com>
 <CAFivqmKBgYVa6JUh82TS2pO915PUDYZMH+k-5=-0u1-K9-gMMw@mail.gmail.com>
 <aHTOSyhwIAaW_1m1@arm.com> <CAFivqmJ912sEdSih_DFkiWRm478XUJhNDe=s2M_UO2gVTu4e3w@mail.gmail.com>
 <CAJZ5v0irG16e2cM_tX_UeEJVmB_EdUvk-4Nv36dXoUS=Ud3U5A@mail.gmail.com>
 <CAFivqmLoDv_pWdmBG8ws-CMUBXcb9bS1TgMaxW9YZMqqHpRSyA@mail.gmail.com> <20250722032727.zmdwj6ztitkmr4pf@vireshk-i7>
In-Reply-To: <20250722032727.zmdwj6ztitkmr4pf@vireshk-i7>
From: Prashant Malani <pmalani@google.com>
Date: Mon, 21 Jul 2025 23:02:00 -0700
X-Gm-Features: Ac12FXw9x-XOA3MzVY_33fyjp1cuCwaiwH8fQqimf2-LTEovczW0oY6k1rMCrTA
Message-ID: <CAFivqmLG0LriipbmM8qXZMKRRpH3_D02dNipnzj2aWRf9mSdCA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cpufreq: CPPC: Dont read counters for idle CPUs
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Beata Michalska <beata.michalska@arm.com>, 
	Jie Zhan <zhanjie9@hisilicon.com>, Ionela Voinescu <ionela.voinescu@arm.com>, 
	Ben Segall <bsegall@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>, Mel Gorman <mgorman@suse.de>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Valentin Schneider <vschneid@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	z00813676 <zhenglifeng1@huawei.com>, sudeep.holla@arm.com
Content-Type: text/plain; charset="UTF-8"

Hi Viresh and Rafael,

Thank you for taking the time to look at this series.

On Mon, 21 Jul 2025 at 20:27, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 21-07-25, 12:40, Prashant Malani wrote:
> > On Mon, 21 Jul 2025 at 10:00, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > Why don't you flag the driver as CPUFREQ_NEED_UPDATE_LIMITS?
> > >
> > > That would kind of make sense given how the driver works overall, or
> > > am I missing anything?
>
> +1

Thanks, I posted [1] which implements what's suggested by Rafael. PTAL

Best regards,

[1] https://lore.kernel.org/linux-pm/20250722055611.130574-2-pmalani@google.com/

-- 
-Prashant

