Return-Path: <linux-pm+bounces-17410-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB869C5A3E
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 15:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A961DB29490
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 13:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9282513F435;
	Tue, 12 Nov 2024 13:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVv56g7X"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C35D139D1B;
	Tue, 12 Nov 2024 13:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731417293; cv=none; b=CfqRfzyjPDGsRWEtgu/Cyv1XaBxVzbdYtXu56ezK3gum9fslTojI8fOUH/XGcmqI4IA5t0vZI10wyF/ZPWhhr9fkwh7SsCtMPWNxnh5oFkPZKR4MOgsqMOfDlWMRhYCwdW3ouCUU+8hixAvzYAc/i+imzIzaMWJK2m2c2JNxijA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731417293; c=relaxed/simple;
	bh=nyu8BMpf26D3mqaRkVc1Sh9txs54CQBP5PZ1fXVVTls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X5frDCsgyqOHA53ByrfEnn1ylzt8Ir6igNoo4SH4sw6vCDPWlS6NC8Qjxvda4myJaEKKlkAhj7wrgI5NQgCKt28/BamSpOd9TAsO1T6q8P0ue8v/ez+uVVaqx9uoeiEQgk163wwakjmLD+1uz9hWyCSFgqhvO2T2G1fpWHfaI3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVv56g7X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC43FC4CED0;
	Tue, 12 Nov 2024 13:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731417292;
	bh=nyu8BMpf26D3mqaRkVc1Sh9txs54CQBP5PZ1fXVVTls=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aVv56g7XuUsOZ1+3NnQ+oexMrLHy7mt/van6tnoi+hbJAvoKNL+PMJgkFtYhFZ2A3
	 eJ/2e6pgMEZxcBlHbMsuZxa7A1rlLMi8QesSD7ItCgZKHfCtCUdgEMAC3qV7yFbpsh
	 nHyqeeThNteNiGgR5CAs+TGabZCnF1P/K0fW/q7tUG96sHLetvPL1E8Yrs9WLRwcIP
	 NR1zqN18vPetYYfFh/R8rW8JlQ4jfNdbZATZtm81QgOeAnGj51qyM6/3ka2RUiVwM5
	 tIVZCBFEmlvbGAC30qcQDj6PT3dwUU0bvFJ3YOxZAQ4OclBEbZuBkSH9/xNP1JLiKz
	 W4QGS+gHhc7Cg==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2958f5387d2so1413793fac.0;
        Tue, 12 Nov 2024 05:14:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU0xZnV/Y8kx/QBhk6kk1djRatsIEqa766a1t0EZ9LeR/S5F37LfTSqDiQvTb3lsh9oKHSLRmk5@vger.kernel.org, AJvYcCVSUohICfLj3uJR9iR9bEyvtuZ4/z7fvDmQvGSmEtFWTO5RMGKZ/ocy4IMkdfKp1ZvGTs4Q5s3U/Ew=@vger.kernel.org, AJvYcCW3+H4+5HOQ6AuSyc9Mu1Y7rdGnVM0QiZIBR0pME+9Ed/M3RiG7ovFZxYAKLsprSg9ZxschBM29w6OjJXc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb+5ipcSsk0a8enFh5/ai0F7dALbn/ZiWNHSTa8mvOvxMSi1iG
	THO4MMc1hvKlbrYCD47LDAZLzQAPUUDlgYKzzSX//whuq+6mHwkaQ0a6qepYowvaR4VIYpG78iE
	uSg4QkDKjHxqZCtmvlGZIqzmnqHM=
X-Google-Smtp-Source: AGHT+IEJlPzZiJFPnpnX8MDh8gPilRfMRuKZ/XOfHoP8jAgDN1Ww8K/tEYHPEQNo37em/hS7PQ5r0s5UlxBgpOg+GIs=
X-Received: by 2002:a05:6870:9114:b0:277:e6bc:330c with SMTP id
 586e51a60fabf-295602d2f90mr13603737fac.29.1731417292240; Tue, 12 Nov 2024
 05:14:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111162316.GH22801@noisy.programming.kicks-ass.net>
 <20241112053722.356303-1-lenb@kernel.org> <351549432f8d766842dec74ccab443077ea0af91.1731389117.git.len.brown@intel.com>
 <CAJZ5v0j1gvwoYS-YaOQWh0bQ3x5=54npiYj8erq68dM92+ad-g@mail.gmail.com> <CAJvTdKnRpDQKUVNJ4Gp7r+WaHo0y-Wume3ay7toHU+Xz0gv2Zw@mail.gmail.com>
In-Reply-To: <CAJvTdKnRpDQKUVNJ4Gp7r+WaHo0y-Wume3ay7toHU+Xz0gv2Zw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 Nov 2024 14:14:40 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g74GWomsfV9ko5pVrwx+x6smU7u7oHV=ZYDLTKYxMWsw@mail.gmail.com>
Message-ID: <CAJZ5v0g74GWomsfV9ko5pVrwx+x6smU7u7oHV=ZYDLTKYxMWsw@mail.gmail.com>
Subject: Re: [PATCH 1/1] x86/cpu: Add INTEL_LUNARLAKE_M to X86_BUG_MONITOR
To: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, peterz@infradead.org, tglx@linutronix.de, 
	x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Len Brown <len.brown@intel.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 2:12=E2=80=AFPM Len Brown <lenb@kernel.org> wrote:
>
> On Tue, Nov 12, 2024 at 6:44=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
>
> > > -       if (boot_cpu_has(X86_FEATURE_MWAIT) && c->x86_vfm =3D=3D INTE=
L_ATOM_GOLDMONT)
> > > +       if (boot_cpu_has(X86_FEATURE_MWAIT) &&
> > > +           (c->x86_vfm =3D=3D INTEL_ATOM_GOLDMONT
> > > +            || c->x86_vfm =3D=3D INTEL_LUNARLAKE_M))
> >
> > I would put the || at the end of the previous line, that is
>
>
> It isn't my personal preference for human readability either,
> but this is what scripts/Lindent does...

Well, it doesn't match the coding style of the first line ...

