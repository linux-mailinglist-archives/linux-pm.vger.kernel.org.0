Return-Path: <linux-pm+bounces-25486-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52502A8A533
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 19:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E895A3B497B
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 17:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DD821CA12;
	Tue, 15 Apr 2025 17:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NoU3BWUr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAAC21C9E9;
	Tue, 15 Apr 2025 17:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744737591; cv=none; b=PvBvl8le7GDdyh8tm4zpeYxQBcaeJ61JIjktySiCRJdjQKMcaJ66J4tn75uPsHkLCNI+ZjnbaUbUxcFUPVc85WwjTkYOUwhKCSHS+NkPlaNTFml17gICH2lC168GSJdCJnNlxhrMgXXhgpLH3OFlcIw/5mPJ4wVjFyGiHJjyaWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744737591; c=relaxed/simple;
	bh=uv4W3IqKCIYFhIRS6Tcr37NLaU3zwS0rWhXFN6Gl6dI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VjYshwnOvSd3kyZdD+vEDPvRADXJt89F964iyFChY2AtEIAXLmiU1E2i3pVS/GQAdo59g1pEViuweUQe3tV+a6gSRId4XJoPsmoxFU/yh+48FHhnQx4T2jxxbxVtFyPhFrWW6KPnGkOC/PSuyVmJNeKJcaVJuhv6HhuYBKeTcg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NoU3BWUr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33759C4CEEE;
	Tue, 15 Apr 2025 17:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744737591;
	bh=uv4W3IqKCIYFhIRS6Tcr37NLaU3zwS0rWhXFN6Gl6dI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NoU3BWUrj7f8tS49OExJLBpgfcFkooIpEOGMZJSBCtZiGhwMgaHB3R632n5Mfu9dv
	 Xsk/0DYntgp+bMa/sYM4F8QTnXoY2K5QhxDgM5W/4t+uutRuHp5ExOm+WbSgJtc+oh
	 hLq8Ou9IFjKUGcO5T/GO3s3qUNZ5fHceKMb20LDTd0DVbXgjhDNfKhMi2RrwodUA1Z
	 96yTgnQF1Y4/Ngn9mbGkyH9NFebRZYRjZIch2d+4ny46R73RhRWVOdWw4i6TxAUrkO
	 50lV+0z9QuDFOoXUyzxZiN3f42POGtob2DlXXvaXQ82P7BCGj1jrC1mMcYh/++zVO1
	 uNqm5alrbtYSQ==
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-72e965ddd79so1667554a34.0;
        Tue, 15 Apr 2025 10:19:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWZRH6Y+bYtNkExKztGTqoYMpt0uSkp3/uOI2gF4d0ZezAkQCsW5KucVfeBs5y4YyXeHmYup8DdNWJzdLY=@vger.kernel.org, AJvYcCXUu+GAfXxx/ijFKlxzekswtqtxMlXy2PvknxBZfnTV5s2IDJr0vHRUttYIo+bQBratViplaDDnJfk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9HZRZPhxj6td8IC+dpzog5Bi3d46VWjaK6hJH4aknLl5D8OUX
	ArqpbyY/ZThKYePVS7Y9UpZNoD24FZ9u8/dgoEhhtEEvuTPLi1WHhrt/mnhcfMMetNszFq3dhW+
	EfD4U/Tf08qWHgWs634Iax+Vhs4o=
X-Google-Smtp-Source: AGHT+IHfadXt208Vc4RWZMjFXdA71akOqXcmngW9Brd10iN59d4xz1W7CVRGhjIKSY6HM2F7L42TVMNZDgaTEpj23zQ=
X-Received: by 2002:a05:6830:4709:b0:72b:9e5f:54a0 with SMTP id
 46e09a7af769-72ec1ccb5eamr82987a34.21.1744737590486; Tue, 15 Apr 2025
 10:19:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_EE27C7D1D6BDB3EE57A2C467CC59A866C405@qq.com>
 <143378b0-5740-4f2b-9a79-f04cf9ef1f77@arm.com> <tencent_AE7CE43CDAD6747AFF0E952C8D0908A98D0A@qq.com>
 <tencent_002D68A7E02F76C9D218B090D6085F0E8C06@qq.com>
In-Reply-To: <tencent_002D68A7E02F76C9D218B090D6085F0E8C06@qq.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 15 Apr 2025 19:19:39 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0he_mxfxmkrMLc73jCvJxDGAeW_JZDmNZa25PtH2qMK_g@mail.gmail.com>
X-Gm-Features: ATxdqUESNGKFdsr7aaNbqMDBrBBTtgUL3gnaiQhekaoP9vU1yoiAmbt0Ax3z7LE
Message-ID: <CAJZ5v0he_mxfxmkrMLc73jCvJxDGAeW_JZDmNZa25PtH2qMK_g@mail.gmail.com>
Subject: Re: [PATCH v2] PM: EM: Fix potential division-by-zero error in em_compute_costs()
To: Yaxiong Tian <iambestgod@qq.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yaxiong Tian <tianyaxiong@kylinos.cn>, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 4:03=E2=80=AFAM Yaxiong Tian <iambestgod@qq.com> wr=
ote:
>
>
>
> =E5=9C=A8 2025/4/15 09:12, Yaxiong Tian =E5=86=99=E9=81=93:
> >
> >
> > =E5=9C=A8 2025/4/14 16:08, Lukasz Luba =E5=86=99=E9=81=93:
> >> Hi Yaxiong,
> >>
> >> On 4/11/25 02:28, Yaxiong Tian wrote:
> >>> From: Yaxiong Tian <tianyaxiong@kylinos.cn>
> >>>
> >>> When the device is of a non-CPU type, table[i].performance won't be
> >>> initialized in the previous em_init_performance(), resulting in divis=
ion
> >>> by zero when calculating costs in em_compute_costs().
> >>>
> >>> Since the 'cost' algorithm is only used for EAS energy efficiency
> >>> calculations and is currently not utilized by other device drivers, w=
e
> >>> should add the _is_cpu_device(dev) check to prevent this
> >>> division-by-zero
> >>> issue.
> >>>
> >>> Fixes: <1b600da51073> ("PM: EM: Optimize em_cpu_energy() and remove
> >>> division")
> >>> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
> >>> ---
> >>>   kernel/power/energy_model.c | 2 +-
> >>>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.=
c
> >>> index d9b7e2b38c7a..d1fa7e8787b5 100644
> >>> --- a/kernel/power/energy_model.c
> >>> +++ b/kernel/power/energy_model.c
> >>> @@ -244,7 +244,7 @@ static int em_compute_costs(struct device *dev,
> >>> struct em_perf_state *table,
> >>>                       cost, ret);
> >>>                   return -EINVAL;
> >>>               }
> >>> -        } else {
> >>> +        } else if (_is_cpu_device(dev)) {
> >>>               /* increase resolution of 'cost' precision */
> >>>               power_res =3D table[i].power * 10;
> >>>               cost =3D power_res / table[i].performance;
> >>
> >>
> >> As the test robot pointed out, please set the 'cost' to 0
> >> where it's declared.
> >>
> >> The rest should be fine.
> >>
> >> Regards,
> >> Lukasz
> >
> > Sorry, the V3 version with cost=3D0 still has issues.
> >
> > I noticed that if the cost is set to 0, the condition "if (table[i].cos=
t
> >   >=3D prev_cost)" in the following code will always evaluate to true. =
This
> >   will incorrectly set the flags to EM_PERF_STATE_INEFFICIENT.
> >
> > Should we change ">=3D" to ">"?
> >
>
> Sorry Again=EF=BC=8C Setting EM_PERF_STATE_INEFFICIENT in this case is co=
rrect.
> Earlier, I misunderstood the definition/usage of EM_PERF_STATE_INEFFICIEN=
T.

Well, EM_PERF_STATE_INEFFICIENT is only looked at in CPU energy
models, so setting it in a non-CPU one is redundant.

