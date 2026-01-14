Return-Path: <linux-pm+bounces-40885-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F09D21217
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 21:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDA1030471B4
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 20:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614A2352C24;
	Wed, 14 Jan 2026 20:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uvh76d/Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D971333427
	for <linux-pm@vger.kernel.org>; Wed, 14 Jan 2026 20:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768421234; cv=none; b=J+Y+PuxHhfD4I+sX5rVd9ZlDeYIgaGlTBB3O6UJ/fH3ERkKyI2nG8eMgKFqZm424Uni/FN7BWtLOS8SMbMkRRS6bGFLwUg6geola9ghkaPDrx4h4s1e7oq6qo1xrwZOYrwFgcz4sm3Hu+qa/aX0y9LNbXe7o8i/Gr7RZY74inrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768421234; c=relaxed/simple;
	bh=IqCBecvxUB8/lRdwxg97nHnCEKq4bKfcEdFr1ThHgjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BRB9uM2QFZ/2GYToXzuN3n3PGkHq9bhs1ktqaRX3UqVjcT3gZF4rSkXyKH4n6of9T1c+1Q9Ewh2jH+kit65iETVcJdlbDuVESBfXs7QAi5Hb8Ps1jBfj+NTzC9XzrM5t934bwP1phFzyb8en4O1BtJ23vEz6AtOKR5P6kH7Dv1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uvh76d/Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180D8C19424
	for <linux-pm@vger.kernel.org>; Wed, 14 Jan 2026 20:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768421234;
	bh=IqCBecvxUB8/lRdwxg97nHnCEKq4bKfcEdFr1ThHgjo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Uvh76d/YSAFkKUPZb9p02crjCYzg75Fjgk2/6u9JMro/fp7VS0+kYPYby3R0zRB5E
	 orwx/2rQCvkgNijH7oC1e7aQTb8hsfSFIiuD9Jm79LTZYfWxAvmlHbQ432QMlmiaP7
	 EJa07LN/H+j8c9D8p0GOejkWTwmSXRq4MuCijXv/BX4CZ/GjxHoy0ZPSFZi3nH47nw
	 dyGZDTR/JsG2conrkm+ot5LUhWDO0YnBtGLuzQ75pIKj7nIbV7KOHK1XqhzZTq+n6u
	 dPONMGrWkykMDZrIAgmjCvnd4ibhbmsVvVOseUkr6EqySxnWBIvwex7vRgvOprp9OB
	 Pneo/qO+ET21A==
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-45c715116dbso113910b6e.3
        for <linux-pm@vger.kernel.org>; Wed, 14 Jan 2026 12:07:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV8hHpQbp7JB5NMxkqh6m5ZDVcsaAZThipWSvuqTYd9srajxoUirEBBa60okd1r/MaqKWx4HaIgQA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc1NEgO8kwiXB8SzwY60YpBfVy9xciiKTzGM4WCqA7Onyfsy9c
	v4MY9knm0fSx6YCn+X0DFU8PVMVmWpXDwj/Y17DWM6trvWpOhee1urH6Te+E4reVlKEFblkiCXe
	Ao6lEFLM6hc1dUypLvWam7TrYuLqzYis=
X-Received: by 2002:a05:6808:318d:b0:450:420:64c7 with SMTP id
 5614622812f47-45c711be21emr2465908b6e.0.1768421233204; Wed, 14 Jan 2026
 12:07:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d4690be7-9b81-498e-868b-fb4f1d558e08@oracle.com>
 <39c7d882-6711-4178-bce6-c1e4fc909b84@arm.com> <005401dc64a4$75f1d770$61d58650$@telus.net>
 <b36a7037-ca96-49ec-9b39-6e9808d6718c@oracle.com> <6347bf83-545b-4e85-a5af-1d0c7ea24844@arm.com>
 <e1572bc2-08e7-4669-a943-005da4d59775@oracle.com> <CAJZ5v0ja21yONr-F8sfzzV-E4CQ=0NqLPmOeaSiepjS4mKEhog@mail.gmail.com>
 <CAJZ5v0hgFeeXw6UM67Ty9w9HHQYTydFxqEr-j+wHz4B7w-aB1Q@mail.gmail.com>
 <rsqh4kpcyodnmcxcdd3yvysdmnfj34fgjtr4pmfhlg2cqtvlhh@iakffruxcnac>
 <ndqg2mysdc4bsvokmrqubx6rw3oj3lrflxw3naqiohbg7yablf@ccm3rl36dnai> <CAAFQd5DBsd4tMcRuVwD3=csJ=4=DMcJhzah+-CTq31qOZHyJEg@mail.gmail.com>
In-Reply-To: <CAAFQd5DBsd4tMcRuVwD3=csJ=4=DMcJhzah+-CTq31qOZHyJEg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 14 Jan 2026 21:07:01 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h2CmeRGs-4viKrVu9OOFtepiDqXTAoY2bAia4JMRFcqQ@mail.gmail.com>
X-Gm-Features: AZwV_QiLJOGdfhC9pyS13guOp5oF2aCeqmeMEEezNjAingCCeanN6lt2lYMI5lM
Message-ID: <CAJZ5v0h2CmeRGs-4viKrVu9OOFtepiDqXTAoY2bAia4JMRFcqQ@mail.gmail.com>
Subject: Re: Performance regressions introduced via Revert "cpuidle: menu:
 Avoid discarding useful information" on 5.15 LTS
To: Tomasz Figa <tfiga@chromium.org>, Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Christian Loehle <christian.loehle@arm.com>, 
	Doug Smythies <dsmythies@telus.net>, Sasha Levin <sashal@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, 
	stable@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 6:16=E2=80=AFAM Tomasz Figa <tfiga@chromium.org> wr=
ote:
>
> Hi all,
>
> On Wed, Jan 14, 2026 at 1:49=E2=80=AFPM Sergey Senozhatsky
> <senozhatsky@chromium.org> wrote:
> >
> > Cc-ing Tomasz
> >
> > On (26/01/14 13:28), Sergey Senozhatsky wrote:
> > > Hi,
> > >
> > > On (26/01/13 15:18), Rafael J. Wysocki wrote:
> > > [..]
> > > > > > Bumping this as I discovered this issue on 6.12 stable branch a=
lso. The
> > > > > > reapplication seems inevitable. I shall get back to you with th=
ese
> > > > > > details also.
> > > > >
> > > > > Yes, please, because I have another reason to restore the reverte=
d commit.
>
> Is the performance difference the reporter observed an actual
> regression, or is it just a return to the level before the
> optimization was merged into stable branches?

Good question.

Harshvardhan, which one is the case?

> If the latter, shouldn't avoiding regressions be a priority over further =
optimizing for other
> users?
>
> If there is a really strong desire to reland this optimization, could
> it at least be applied selectively to the CPUs that it's known to
> help, or alternatively, made configurable?

That wouldn't be easy in practice, but I think that it may be
compensated by reducing the target residency values of the deepest
idle states on those systems.

