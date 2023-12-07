Return-Path: <linux-pm+bounces-809-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4791809589
	for <lists+linux-pm@lfdr.de>; Thu,  7 Dec 2023 23:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 899461F211B1
	for <lists+linux-pm@lfdr.de>; Thu,  7 Dec 2023 22:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0D057311;
	Thu,  7 Dec 2023 22:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FXrxwxAi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1AB170C
	for <linux-pm@vger.kernel.org>; Thu,  7 Dec 2023 14:45:17 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-42598c2b0b7so38291cf.1
        for <linux-pm@vger.kernel.org>; Thu, 07 Dec 2023 14:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701989116; x=1702593916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkuIzoN396jqYT+Pk75+VoEYaTQnHg5zkQllCC1Stfc=;
        b=FXrxwxAifDQYaC3srMRdQ/4dqB/2siC0IOSk7q6n4KnMbt13LhSkjVCZXhSnwlWmFy
         E3RM+tdfjp3TiEgMae+a36yuxNHll6DSgxTRg5VbbTm2QPE234OivE9/ariGhsmL6mpT
         F13FRGqrYOk7dVkXmzweaBFdAAh5H5tXAxExGOuzf1XhWGEO34DsJ5xVNIWq8fSK/rNO
         1e75YWz0u4+iVi7xrW1sAbV+0ZMs903cSBUsMy4TDoyTA93+6IxgkMSHpvZh59/DvG4Z
         e03CjW+jLZjJZrCp1cnl9glLH3NzPjr9U5Mf+QQP3L7XVzzR7qkmrSSHEmGwfwIbG4ej
         8nPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701989116; x=1702593916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HkuIzoN396jqYT+Pk75+VoEYaTQnHg5zkQllCC1Stfc=;
        b=Ckhkfs1svZk4W/sMfHPwSzd8si5hW3aPr1kSrkFxhHxcS1dni0XXenlsz9PU7stvFt
         gxNC258x86G/F66g2S+auNYjNBRbx6FT6OaBFzYfdXwriz8L0JfYfEwNKKxs+C7UH8fY
         w+1bgit835WWjYsqeSuwsHA0pERywN2WKr1dcAD6OYpQTwjtKgAm3ggLZcF60OxvE0uD
         Gh+tJgluPjo40TziSDMEQoEpAwK+vjGBFU+8OvEB1Zy9xc4h4kWv5RPUJiia6/NeTMIE
         ah6R22w66QrFeMrXz1whABJLjeMYTLcoYsIQg9auCh99md4C5Sl5C7xVPQffE38AsIus
         f9WQ==
X-Gm-Message-State: AOJu0Yz3w/zvuCvQ9WhRN5pLS8aQA04hgk/iUv2crJXBO47k1SAyvk6/
	5FMmryBHLTVlOiBaeo8CYhFKIIemxMqsGlqMbGFUdQ==
X-Google-Smtp-Source: AGHT+IH2Ee5fQ2BMKGV5V0CAb7d7P5bahZSNARWtZJJA7pnbKyLDlUQTzvbGMsPydmQi6PxASuAciYGntOuuhoIaNAo=
X-Received: by 2002:a05:622a:413:b0:423:98a3:422 with SMTP id
 n19-20020a05622a041300b0042398a30422mr39958qtx.11.1701989116154; Thu, 07 Dec
 2023 14:45:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231111014933.1934562-1-davidai@google.com> <20231111014933.1934562-2-davidai@google.com>
 <865y231jvj.wl-maz@kernel.org>
In-Reply-To: <865y231jvj.wl-maz@kernel.org>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 7 Dec 2023 14:44:36 -0800
Message-ID: <CAGETcx9-n0z5buWgtLZ+6VxW2jEko1GWzkGtGhFiZEq-x_G4nw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: cpufreq: add virtual cpufreq device
To: Marc Zyngier <maz@kernel.org>
Cc: David Dai <davidai@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, Quentin Perret <qperret@google.com>, 
	Masami Hiramatsu <mhiramat@google.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Pavan Kondeti <quic_pkondeti@quicinc.com>, Gupta Pankaj <pankaj.gupta@amd.com>, 
	Mel Gorman <mgorman@suse.de>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 12:49=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrot=
e:
>
> On Sat, 11 Nov 2023 01:49:29 +0000,
> David Dai <davidai@google.com> wrote:
> >
> > Adding bindings to represent a virtual cpufreq device.
> >
> > Virtual machines may expose MMIO regions for a virtual cpufreq device
> > for guests to read frequency information or to request frequency
> > selection. The virtual cpufreq device has an individual controller for
> > each frequency domain.
>
> I would really refrain form having absolute frequencies here. A
> virtual machine can be migrated, and there are *zero* guarantees that
> the target system has the same clock range as the source.
>
> This really should be a relative number, much like the capacity. That,
> at least, can be migrated across systems.

There's nothing in this patch that mandates absolute frequency.
In true KVM philosophy, we leave it to the VMM to decide.

-Saravana

