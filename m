Return-Path: <linux-pm+bounces-30335-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6652BAFC2EC
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 08:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66E751BC0395
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 06:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7811D2248BA;
	Tue,  8 Jul 2025 06:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RjCHYVrt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A05221282
	for <linux-pm@vger.kernel.org>; Tue,  8 Jul 2025 06:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751956869; cv=none; b=qecT4KstgCgUlfOk7OI6W+JB8/GEH5KDaWdPCvhUD6M/sk4GNhngiKBdy6sC9qdBpS/Sog13b9I8ABBjq4B/kUKyNWQIIMINyi33AN1P9UjjyxZ5Ow4efQPFdMW5xABm0Y1K9H0WjA07S5Bf2FE3pgtk44JHoHQEoUZJrUu3HwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751956869; c=relaxed/simple;
	bh=mn3PjSRF5aAURidYrwQ4vjrt55R7G/gDBmdhvDiU7Y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R50UzFp890PgHHWflmf5/Mb2pTyfDTZH89/RKz0+pmmjLypAh+mFxWbyt5ZF38pGI05zkH+Z+3YRDbgWD5e2cyr6cgdQfh1RVdvgzKRpD2ysPRjQ/O7FSZw8VdTHBgJp4HTjdBW/lbpYlg9iNU9lMp834EOT30l2F53SdNEQJAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RjCHYVrt; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae0de0c03e9so683642466b.2
        for <linux-pm@vger.kernel.org>; Mon, 07 Jul 2025 23:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1751956865; x=1752561665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TZMEfz5WIJRj2nZJ2aYAIWpyLrUKEdr0s0Vm/UGWig=;
        b=RjCHYVrtBXljry0Jh7rldGS7Dyfp9gK1x7a5nDu7i91G/ghkgISlqVCdWNFGO92cmq
         e4NSscp+L4AY1cpu7VsGt8ZsUrlbOq7q2zLYJ92CGoX0cJZIaAhXLgF+Jy7RYCSGubrX
         IXaD9526ogtXDKlIQg9F260rdrBAnmUFFKFOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751956865; x=1752561665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0TZMEfz5WIJRj2nZJ2aYAIWpyLrUKEdr0s0Vm/UGWig=;
        b=nKFuj+uTX6L2ylhyVbSu1ZkOAoC0mxZyZV4ayTjbZZwEVjg589VfpakxYDmQP8yiqn
         sH4K8dgJyvP3/67DSppLPf3gfDarvLrAlVAOWkVrQGQ65Sd1SM8M8DFXl5J/0Mk3p0yX
         Ue/4eSzYHChxppWn9UWVw7piy5FTebv/p245fB9JfgS+pAcuzipNqwUhsMGteQknxE+M
         DqvdseZ1Bg9rp6EnCZCjwM2gNAHvXhTk7Ph4o2NZTypMz8Ps9Wb0cW/WwYCtIPPztiN5
         kiqxMxxfw+nzezwSznn5ZDH9J6Bz1YjowzCpdRsqa0OrWysNHxWSh5npdcxDbqV6j6qQ
         oLZg==
X-Forwarded-Encrypted: i=1; AJvYcCUKZVfOLJvML6A1YQ5tcbhODAPhVsZ7FCtugpyyKbmxPywYjsTX290aChnO8lueBtSdLfYFp9LeQw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9z6VmxovfNsgZ0oyHuOUC7WIbqonL3+X3Ea/ZdsVFFaQi7zBA
	6yisGxvf+HTDcWY7B/sE8nTUAGPTUl3DfLneRT06SaN2TL5Y7b4wUmmytj8scR13zlHOCAIKUHQ
	dXVnG1g==
X-Gm-Gg: ASbGncvPBkNhNOVuHHzBJDD1AP7TjixsKwdu39sH4Roa8rZkKkZzX6djV8wpTwnfRZr
	T68VjhQCIo7POI7Z3ewB92SXXsi38RSD8pbYXXKGmIN7pF3XKB3xRR905IGspvnvCuGFA2F8pP4
	MGruUUQE3QjMHooXkYZmn+uYwSwojy8s6u0IBsgsSGERdcrQ0xgv2a3+CHXGktY1N3isjZwedoK
	+s6pJhTL+AVp8yAtFZO4DY0tudeVNofyZK8sGl5xawt/9OqgO6WItDCGevrLDa1mgOyXzthOOOE
	Wjk/Imfjp/8m3oHgfD0yBsh4jForX7nl1iKQY1HHl3AihfB8JxXkDBJ2xVmiXkvIweRWCq88xvL
	N+ztXf8oRPRa2wsHC9R9B4ORz2R/8
X-Google-Smtp-Source: AGHT+IFIicdo1X8wv9HTs3mBcsvPf8kC+YrcSsEYApGXj6JEW866ixs7WVo/VeA5tp4LMTyt69fTuQ==
X-Received: by 2002:a17:907:7b88:b0:ae3:bb4a:91fc with SMTP id a640c23a62f3a-ae6b05895bdmr187413866b.22.1751956865536;
        Mon, 07 Jul 2025 23:41:05 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f66e7dd8sm836309866b.31.2025.07.07.23.41.05
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 23:41:05 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-60b86fc4b47so4433a12.1
        for <linux-pm@vger.kernel.org>; Mon, 07 Jul 2025 23:41:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUNHyGLUjgZQJ33QwjxEUlKGa/aVeuMPGKwh/cXRXwaec+sy4DO0fg1X+sWdrvGW3y9FC+8eEsPig==@vger.kernel.org
X-Received: by 2002:a05:6402:10c8:b0:606:b6da:5028 with SMTP id
 4fb4d7f45d1cf-61051ba0baemr14560a12.0.1751956864575; Mon, 07 Jul 2025
 23:41:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707-trip-point-v1-1-8f89d158eda0@chromium.org> <CAJZ5v0gOm4-qmAGGswk9nuPb45UGabNK-DqkcZEGmTO71tRLkQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gOm4-qmAGGswk9nuPb45UGabNK-DqkcZEGmTO71tRLkQ@mail.gmail.com>
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Tue, 8 Jul 2025 14:40:28 +0800
X-Gmail-Original-Message-ID: <CAHc4DNK2_=81j-q4+1vsM9uyWJJ89dH4y2u_H5ie671umyNWxg@mail.gmail.com>
X-Gm-Features: Ac12FXzqSDrdQQK4kqjkvNzFjIs4Y1onDjlv36xI3xbZkB0uRyjH6h5P9pzUugQ
Message-ID: <CAHc4DNK2_=81j-q4+1vsM9uyWJJ89dH4y2u_H5ie671umyNWxg@mail.gmail.com>
Subject: Re: [PATCH 6.6] thermal/of: Fix mask mismatch when no trips subnode
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Hsin-Te Yuan <yuanhsinte@chromium.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 12:57=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Mon, Jul 7, 2025 at 12:27=E2=80=AFPM Hsin-Te Yuan <yuanhsinte@chromium=
.org> wrote:
> >
> > After commit 725f31f300e3 ("thermal/of: support thermal zones w/o trips
> > subnode") was backported on 6.6 stable branch as commit d3304dbc2d5f
> > ("thermal/of: support thermal zones w/o trips subnode"), thermal zones
> > w/o trips subnode still fail to register since `mask` argument is not
> > set correctly. When number of trips subnode is 0, `mask` must be 0 to
> > pass the check in `thermal_zone_device_register_with_trips()`.
> >
> > Set `mask` to 0 when there's no trips subnode.
> >
> > Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> > ---
> >  drivers/thermal/thermal_of.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.=
c
> > index 0f520cf923a1e684411a3077ad283551395eec11..97aeb869abf5179dfa512dd=
744725121ec7fd0d9 100644
> > --- a/drivers/thermal/thermal_of.c
> > +++ b/drivers/thermal/thermal_of.c
> > @@ -514,7 +514,7 @@ static struct thermal_zone_device *thermal_of_zone_=
register(struct device_node *
> >         of_ops->bind =3D thermal_of_bind;
> >         of_ops->unbind =3D thermal_of_unbind;
> >
> > -       mask =3D GENMASK_ULL((ntrips) - 1, 0);
> > +       mask =3D ntrips ? GENMASK_ULL((ntrips) - 1, 0) : 0;
> >
> >         tz =3D thermal_zone_device_register_with_trips(np->name, trips,=
 ntrips,
> >                                                      mask, data, of_ops=
, &tzp,
> >
> > ---
>
> If this issue is present in the mainline, it is not necessary to
> mention "stable" in the changelog.
>
> Just post a patch against the mainline with an appropriate Fixes: tag.
>
> Thanks!
`mask` has been removed from the mainline, so this patch is only
applicable on old branches.

