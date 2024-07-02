Return-Path: <linux-pm+bounces-10341-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6095F923EBB
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 15:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CE0C286F36
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 13:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFB91AED3C;
	Tue,  2 Jul 2024 13:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ko93LZ0m"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75E919DF98;
	Tue,  2 Jul 2024 13:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719926418; cv=none; b=V92vT/Vmr/wa5WfrhqXZUFzNYsny0WY2vgF827Wz0Bs3XXdt0R5McKbHu66GdFqVvYpIzDnry1fiiqw4B65sL3U5P1hptn/KPdEvGL/W3T7eOFKg4VdyMH4evZXvPngk8emIux/bJVv6oxQh+5sJPHOCaZbsTJNC+nGENZ79l/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719926418; c=relaxed/simple;
	bh=FY5E+s7ajeSrJoQkD3VNLBziYbqFLsENWeXw+7GWm00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TjXj8I/CGJdZtxpXeAWfBfwWMMF29qolbwSBJJ1odIjVwiib+gjgxMV3GjE8K/3vErA+r82o9pPV7lpLmDcFg4On4B0dBIUMOftqrj94KFvrmkooCCG0vu5gij6OpTzHyck3ksnvFhUorFKiGcarU4poqhwKgoAS4mIftgGcVxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ko93LZ0m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80046C4AF0D;
	Tue,  2 Jul 2024 13:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719926418;
	bh=FY5E+s7ajeSrJoQkD3VNLBziYbqFLsENWeXw+7GWm00=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ko93LZ0mNm2hpshT5VpUFYXtutvgQo5qtRqxqfDDK/2LFoak6xfHtWrflQKSHBWly
	 zg6k0ggFAhdte68flIDbyr23LTAZjoMUCWhk43CMP4d7hLGNF77k/pwjbdWUlhGY8h
	 fOTgGT1hGxU54tgxgQ8/58mWE+LMniBepxRPJ9G82kCcXqbpMRWxpRxeKbUDURkFEx
	 Y6EIBSvRlqyilcVqJDV7Pe28NLZ/LjXhAb/ixPPY/15DveMSTM4UgTWjvaAKoTpy3Z
	 /lG/daw5HzB7Sp3EyFdgFp0TEmQIABBhwqMn091uzgDMUpNmUBhnG4e3yT8NVo6wSJ
	 VXUWHqjmUxjKw==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-254925e6472so598183fac.0;
        Tue, 02 Jul 2024 06:20:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWIafOti8yaSRWnN15OI/rmP/w9XN707LYv0J+8b0xaRqDWnJCMEWCQiuQRUxHnJwmkwJRQoiFUp3B5651E9JpDCL7B8ph6Kj7mAwTRg8VTG+gosnDzCVDeFFShkW85vaEPWMYe8PE=
X-Gm-Message-State: AOJu0Yy+JRCkUYhxOlwQNj9YWPlZl8EHHNFVVdRsu0X86JfIT7EWtL7R
	5UtF7N3jDIm5fs5GTZrFJHTLMerz5/nydnb5dMez3cuKMCMVN3/gqw+7Zl9O43ADOE4TsiBkEaT
	XSRN00LuuwvnWrYrxxr+99+JBA+k=
X-Google-Smtp-Source: AGHT+IHPgHVc7fGDbvuZrOB9oaw+RtiNMakf2Ol0RRd70VyBtw2rcmum6Gw45ylmMM0ZAtZIzJkzhzqOw6HGMBFn5ME=
X-Received: by 2002:a05:6870:eca2:b0:258:476d:a781 with SMTP id
 586e51a60fabf-25db361456amr9248547fac.3.1719926417683; Tue, 02 Jul 2024
 06:20:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618121327.2177-1-kaiyen.chang@intel.com> <20240618121327.2177-2-kaiyen.chang@intel.com>
 <CAJZ5v0gK=v0P7Fapn=5-YdZ9_NTGL0PfA__ogmP_3Hx0=5qAEg@mail.gmail.com> <PH7PR11MB6354DCC37B04CE407AD5B7F593C82@PH7PR11MB6354.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB6354DCC37B04CE407AD5B7F593C82@PH7PR11MB6354.namprd11.prod.outlook.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 2 Jul 2024 15:20:05 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jo=9od9YCA=-bK83VhY196O2P6jHGnya9Xy=xM+Y+j4w@mail.gmail.com>
Message-ID: <CAJZ5v0jo=9od9YCA=-bK83VhY196O2P6jHGnya9Xy=xM+Y+j4w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] PM: Start asynchronous suspend threads upfront
To: "Chang, Kaiyen" <kaiyen.chang@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "pavel@ucw.cz" <pavel@ucw.cz>, "Brown, Len" <len.brown@intel.com>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Todd Brandt <todd.e.brandt@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 11:21=E2=80=AFAM Chang, Kaiyen <kaiyen.chang@intel.=
com> wrote:
>
> On Tue, Jun 18, 2024 at 07:27:18PM +0200, Rafael J. Wysocki <rafael@kerne=
l.org> wrote:
> >
> > On Tue, Jun 18, 2024 at 2:13=E2=80=AFPM Kaiyen Chang <kaiyen.chang@inte=
l.com>
> > wrote:
> > >
> > > Currently, when performing a suspend operation, all devices on the
> > > dpm_list must wait for the "synchronous" devices that are listed afte=
r
> > > them to complete before the main suspend thread can start their
> > > suspend routines, even if they are "asynchronous". If the suspend
> > > routine of a synchronous device must enter a waiting state for some
> > > reason, it will cause the main suspend thread to go to sleep, thereby
> > > delaying the processing of all subsequent devices, including
> > > asynchronous ones, ultimately extending the overall suspend time.
> > >
> > > By starting the asynchronous suspend threads upfront, we can allow th=
e
> > > system to handle the suspend routines of these asynchronous devices i=
n
> > > parallel, without waiting for the suspend routines of the synchronous
> > > devices listed after them to complete, and without breaking their
> > > order with respect to their parents and children.
> > > This way, even if the main suspend thread is blocked, these
> > > asynchronous suspend threads can continue to run without being
> > > affected.
> > >
> > > Signed-off-by: Kaiyen Chang <kaiyen.chang@intel.com>
> >
> > How exactly has this been tested?
> >
> > In the past, changes going in this direction caused system suspend to h=
ang on
> > at least some platforms (including the ones in my office).
> >
>
> Hi Rafael, thanks for your reply.
>
> 1. We have currently verified this patch on the ADL-N Chromebook, running=
 the suspend stress test 1000 times consecutively without encountering any =
issues.

Just one machine?  That's hardly sufficient.

> 2. Could you tell us what was the reason for suspend to hang back then?

It was what is still the case I think: Some dependencies between
devices are implicitly taken into account when the async suspend
threads are not started upfront.

> The reason why I believe that we can start the async device's suspend thr=
eads
> upfront is that, during resume, a sync devices listed after certain async=
 devices
> on the list do not actually rely on the implicit dependency provided by t=
he order
> of the devices on the list.

This problem has nothing to do with resume, because the machines hang
during suspend.

> This is because if there is no consumer-supplier or parent-children relat=
ionship between
> these devices, the suspend routine of this sync device will be executed d=
irectly without
> waiting for the suspend routines of the async devices listed before it to=
 complete. In other
> words, this sync device does not depend on the async devices listed befor=
e them.

Well, not quite, IIUC.

Say there are two devices, A and B, the former is "sync" and the
latter is "async".  Say there is a dependency between them such that A
must suspend before B, but it is not expressed directly (no
parent-child relationship and no device link).

If A is before B in the list order and async suspend is not started
upfront, the dependency is met.  If async suspend is started upfront,
B may suspend before A.

> Therefore, during suspend, there is no need to ensure those async devices=
 listed
> before the sync devices are awake before these sync devices complete thei=
r suspend
> routines. In summary, as long as we manage the dependencies between
> consumers/suppliers and parents/children relationships properly, we shoul=
d be
> able to start the async devices' suspend routines upfront during suspend.

Well, if the dependencies are all represented either through
parent-child relationships or through device links, then yes, but are
they?  On all systems currently in the field?

So if you want to move this forward, please talk to Todd Brandt (CCed)
to arrange for testing your patch in the client power lab.  It must at
least not break suspend on any machines in there.

