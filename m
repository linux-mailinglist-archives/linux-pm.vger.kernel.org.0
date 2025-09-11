Return-Path: <linux-pm+bounces-34455-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3DAB52E9F
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 12:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE5AF7B48FA
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 10:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362EF3126BC;
	Thu, 11 Sep 2025 10:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sPbD/j+G"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F73E3126A6
	for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 10:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757586746; cv=none; b=Q//ulk31tBSd7mZ0/KwXbTeTqP6g4YLOirA5DecGGSGk3EoG3kjqd31bgF/kvVgRTzknr+cd6u+f9pqVEAON98k/ixEvVqvRuhGLL8wAGgP2KYYte2ApZSkAVzeTV9Fa6uBLomuRkyotKCq2ovZ3/2nRxxV94kxewmEewG+sxOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757586746; c=relaxed/simple;
	bh=AfzBOkfw/f+2HpXW9nRIV2Am+WTp1lRBGmzAonEDKng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=euPF2HfZqj5iaDSgv/vG7Wx65uXb+kZCbz9W/dq1mzpFLwzXwyYaCltNWeDKuGYUr8OX7PxRndUgqrDlZujvdzPisN8Ocu9sQCvKgASpPFyjXb1KBV+if+NVqzzDxQ0pcdFVEP59NmNWDl/Io7m+LGZYrlrqdlx6tylD+nHU+Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sPbD/j+G; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e96fbf400c0so683133276.0
        for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 03:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757586743; x=1758191543; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c4ZOsSgcttRMvxWFSgVRWx9LXQHTbGG8yJSj2/0idLs=;
        b=sPbD/j+GrXua7SyQ7s/2a1wNSlaLGwJNK+AI6A65uVSFOMOcy/wfCBh86QkKIRo4p+
         f4ONOMHKEVHSHl85WBJOkqmEegYJXNCkdaod5nkX0OxKQysCmO3HafpeUzZSLYrPDXDm
         NE4YZwpghcd4+/1Q60oLxfYne/xgGnfCvWup/+ivYvg7ZI45HBlbHHSYmWxyLY2ARGBw
         qZvnrCeEywXqGnCmG+EySkdSwhs0ZijdO3r/yQlAdHydtpq64/EKw0cnicAwLl04j/PC
         ygeKv3MTvTyyktGHnUl6YfsAB3zjt6DZ2sBCrMbhlY4emPGSSnRIzyUrs4wON9ali+4v
         LqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757586743; x=1758191543;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c4ZOsSgcttRMvxWFSgVRWx9LXQHTbGG8yJSj2/0idLs=;
        b=wN9XoZuCeACPNeqnWKxzscNy5ogN89b7ASWZIPYbs6wHP0sGgHCb9hL00YZ3ieo15a
         q2CBkDFLmolCEhYe5Oy+BKup0qtVMXPDqCQdNLt5tPYgnugiVthlUIcV/qdUquqbF990
         0Bw9j3J+FVSG/JNa0oxyJtyKDIUtaJb+LFsCU2fX+8lHZgKfa7+wr0zcCBeuFEawI23d
         GEgC+qxXOKOwFPAD+Qt0/KA1zCDB2vIa/HxHBURRoQmLvR+Ta4fYJ0ozzdlfkbYh67RD
         mozg/FqUkhgpZVfOQ+e8BxbMlhWfzlbuIP+LUvW/Wg5mR0yDBMWFH5cxO97GdhwmgjnL
         wiEQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3U1U5+DUSbabGjvJ7w8dnOeunWlX82xmwZOYsXLlcoS4VcZWzqvHOw5+pDEK24eDzU5qFiqId0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhoeDxeU6SIm8ggIQPqHajKW2W79dC2XdM6JOiPwOI08cpRzRZ
	kg2IsTNjH9ogWx7+Mm8F5nINZkf8yOg/J69l+PGi5YiP2rnHO87F/8BLjIGNKWvvNGNUcQendsh
	AjGr+dARK5yJw6dNdvVYeUGhMaenX8wmOzMqlYVOpNpd/0NXTgwnNAz0=
X-Gm-Gg: ASbGncvyS1um841a5o4NOJ/qIrDatGV0ziHjHXhOo6aQrQKlTjEZ+EJtzdJ2dFwXspg
	blrVZqpzoSmVRG+ATCj28/zDqxPLDDrFqHcEMNNZrrHmmyQXY+1tP3mSPvbddzO3+kCg1weRB1v
	XPNcfL7Hk5c/BzsqnQj1siVw5e0ROFQu8OwkvlU1KaLrmEP/9x+0/t+KFDFaVjpfxiQkTsIDvxu
	VAftsT9yeDg6A2riF0=
X-Google-Smtp-Source: AGHT+IF6/FMvfkM2t/XH6c5AXnqivQugM2HMLBN1/u9XexbnBojnOfBcCiOm0kb7ITvQxJ9JRgM1J9hGYF+YRqPfZm4=
X-Received: by 2002:a25:ab45:0:b0:e97:398:43a with SMTP id 3f1490d57ef6-ea3ca7088f6mr1978662276.19.1757586743140;
 Thu, 11 Sep 2025 03:32:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909111130.132976-1-ulf.hansson@linaro.org>
 <20250909111130.132976-4-ulf.hansson@linaro.org> <CAMuHMdWB05sQpv0nKgU2NNn4=KAmNCpHhAnz3s15Gopu8FKVkQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWB05sQpv0nKgU2NNn4=KAmNCpHhAnz3s15Gopu8FKVkQ@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 11 Sep 2025 12:31:47 +0200
X-Gm-Features: Ac12FXx4q_7O4EKT7jwetBM883Ai-tYxqwF2ULDV_qJob3VYY3KUktShD0zBpHM
Message-ID: <CAPDyKFrZ4hA0O3PRUJwwetQYsgAt50tPo_hL90epUx1T8kFDEQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] pmdomain: renesas: rcar-sysc: Don't keep unused PM
 domains powered-on
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
	Saravana Kannan <saravanak@google.com>, linux-pm@vger.kernel.org, 
	Stephen Boyd <sboyd@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Sebin Francis <sebin.francis@ti.com>, 
	Diederik de Haas <didi.debian@cknow.org>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@oss.nxp.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Johan Hovold <johan@kernel.org>, 
	Maulik Shah <maulik.shah@oss.qualcomm.com>, Michal Simek <michal.simek@amd.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Sept 2025 at 11:02, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Ulf,
>
> On Tue, 9 Sept 2025 at 13:11, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > The recent changes to genpd makes a genpd OF provider that is powered-on at
> > initialization to stay powered-on, until the ->sync_state() callback is
> > invoked for it.
> >
> > This may not happen at all, if we wait for a consumer device to be probed,
> > leading to wasting energy. There are ways to enforce the ->sync_state()
> > callback to be invoked, through sysfs or via the probe-defer-timeout, but
> > none of them in its current form are a good fit for rcar-sysc PM domains.
> >
> > Let's therefore opt-out from this behaviour of genpd for now, by using the
> > GENPD_FLAG_NO_STAY_ON.
> >
> > Link: https://lore.kernel.org/all/20250701114733.636510-1-ulf.hansson@linaro.org/
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Fixes: 0e789b491ba0 ("pmdomain: core: Leave powered-on genpds on until sync_state")
> > Fixes: 13a4b7fb6260 ("pmdomain: core: Leave powered-on genpds on until late_initcall_sync")
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> > --- a/drivers/pmdomain/renesas/rcar-sysc.c
> > +++ b/drivers/pmdomain/renesas/rcar-sysc.c
> > @@ -241,6 +241,7 @@ static int __init rcar_sysc_pd_setup(struct rcar_sysc_pd *pd)
> >                 }
> >         }
> >
> > +       genpd->flags |= GENPD_FLAG_NO_STAY_ON;
>
> So this applies to all PM Domains.  While this doesn't hurt, perhaps it
> should not be set for always-on domains, and thus moved up, to become
> an "else" branch in the "if/else if/..."-logic handling always-on
> domains at the top of the function?
>
> This applies to rar-gen4-sysc.c, too.

You have a point, but currently this doesn't really matter. Genpd will
not power-off always-on-domains no matter whether
GENPD_FLAG_NO_STAY_ON is set or not.

The whole purpose from my side was to restore the behaviour we had
before, for the Reneas PM domains. I tend to think that it's better to
apply the $subject patch as is - and leave improvements to be made on
top.

Thanks a lot for testing and reviewing!

[...]

Kind regards
Uffe

