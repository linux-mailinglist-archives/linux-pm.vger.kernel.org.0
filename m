Return-Path: <linux-pm+bounces-21549-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CE1A2C7B4
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 16:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B476F3A6A02
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 15:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C83823FC70;
	Fri,  7 Feb 2025 15:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BU3Ck9QJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C3923ED7D;
	Fri,  7 Feb 2025 15:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738943170; cv=none; b=Oqc4OMlJ4PT8rod+TyYG1pA+0c3orwIzvqo6t/UORhgiOps5cMg8hkIZ0Cf3YNs2FjjqbsEuj36L00yuxCOSAbz4dx1qxWhiChTzEdOXH6XabZJvaHYvEj8UWak8TDP9fsMGU3RIxssLjO1LYzRiPx3Jd1lHDFEioYjGKNUIUqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738943170; c=relaxed/simple;
	bh=9axXkAUlqFza4DaVZ0GFZXMPQsYFrXfavM1CTA8TUs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JzQ2Pyl+Cpb2bBVUJT9AZoMJQ8JP27d2yKi8CAxjzllk50ZRzeNAgO8A7bJZ6+ybyZiMNqakucnkk0bNaOCj3JtZqN3ZDT+FU5tTLelKeb0Axh7Z16XY9YZXiIMDAOwRHz1D0VCGAj2x3H0iHEX6vZrP74zwZ2qV71NoaiuwOR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BU3Ck9QJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37ECDC4CEE8;
	Fri,  7 Feb 2025 15:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738943170;
	bh=9axXkAUlqFza4DaVZ0GFZXMPQsYFrXfavM1CTA8TUs0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BU3Ck9QJ7vOsjygK1+2xFx29AxyURJU3L8R/J2BfdY5Khgrsb/3SBk9dyfxapwuXj
	 oVdhNgqb2sbOOS4RG4r8aA0MtpvgIYKZH8e13yNBuims/uMPGqh/DU/zYIrZ6ss/Wf
	 D1A43ARPqR3nud8NrO2NLHkmsCRvQ2UddeSaSmNly+LA4sewoBciaogsz4gMjtKU3L
	 WkfrzcRsKGBhbPrtI6S+ql6ycJh2UcYuAbbvS++dHwW4WqmrPhj6pNEpaYRKlxvy56
	 6kMD9TEqrQ6b+QxT2HAJX7bLaDI6neeoY7j90iMk0zmcHFH8A8yRuNCNsfdfMAXNgy
	 v7UekX58696WQ==
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-71e565708beso1332239a34.1;
        Fri, 07 Feb 2025 07:46:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUXVEG1Nt5iUL8fOUNMpg1EZTGRKJ1YVS3ZAKeCriyH48th6kQFcxTaRG4rDBhnVOWj7YVbcLFUZ1OWlj4=@vger.kernel.org, AJvYcCVbBpfv5vjc4dVBXRXgQSsjgPeDQVjDQuxD5zHU8ho6J7syhmSsCEhBCmROaRNLatTMA+y+7FSWpCc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6UVh5/n9ImP3lcmgO5Fzz+I+wgk2s0WcHxuc78Ie699sux4U1
	iPYlCr/IVxbfG4POTw+wNBfHyX1xHkcDv7zZJ3PJrfoczu5hcA6LjPKMnVnDWmIKE0e0zzbA6sC
	fDiOiOgMkh0Vv/eBywD+KdSpKkH0=
X-Google-Smtp-Source: AGHT+IFwftW2hpSvI0/jco9/o383vJhWj1dqg/XtvjgZmygGI6vPRJZqt/4I+rFgyBwh2j8clYnBkY2Va5Uy/W9SoJI=
X-Received: by 2002:a05:6830:698f:b0:71d:5236:9295 with SMTP id
 46e09a7af769-726b88a3d2amr2711818a34.24.1738943169513; Fri, 07 Feb 2025
 07:46:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1916668.tdWV9SEqCh@rjwysocki.net> <4917ca35e5e0c7035f09c02d5080a69ed3e88c44.camel@linux.intel.com>
In-Reply-To: <4917ca35e5e0c7035f09c02d5080a69ed3e88c44.camel@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 7 Feb 2025 16:45:58 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0giy4ZhQdLXJXQqg+vMeP6TWZodWfwVVjbSuFz5_FEvMw@mail.gmail.com>
X-Gm-Features: AWEUYZnA5w9uoY8Rk1EW1LDawHEtcIforzag7f5A72GKMB0rR-PWmA6wyaJHj2w
Message-ID: <CAJZ5v0giy4ZhQdLXJXQqg+vMeP6TWZodWfwVVjbSuFz5_FEvMw@mail.gmail.com>
Subject: Re: [RFT][PATCH v1 0/5] cpuidle: menu: Avoid discarding useful
 information when processing recent idle intervals
To: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Christian Loehle <christian.loehle@arm.com>, Aboorva Devarajan <aboorvad@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 3:48=E2=80=AFPM Artem Bityutskiy
<artem.bityutskiy@linux.intel.com> wrote:
>
> Hi,
>
> thanks for the patches!
>
> On Thu, 2025-02-06 at 15:21 +0100, Rafael J. Wysocki wrote:
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
allen
> > by
> > almost 80%.
>
> I ran SPECjbb2015 with and it doubles critical-jOPS and basically makes i=
t
> "normal" again. Thanks!
>
> Reported-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> Tested-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Thank you!

