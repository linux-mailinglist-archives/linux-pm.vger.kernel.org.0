Return-Path: <linux-pm+bounces-8-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2923F7F247C
	for <lists+linux-pm@lfdr.de>; Tue, 21 Nov 2023 04:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 323B9B21976
	for <lists+linux-pm@lfdr.de>; Tue, 21 Nov 2023 03:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63E613FF0;
	Tue, 21 Nov 2023 03:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kelvie.ca header.i=@kelvie.ca header.b="oDbnF1ZC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-108-mta118.mxroute.com (mail-108-mta118.mxroute.com [136.175.108.118])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD68BC
	for <linux-pm@vger.kernel.org>; Mon, 20 Nov 2023 19:07:17 -0800 (PST)
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta118.mxroute.com (ZoneMTA) with ESMTPSA id 18befd89f01000190b.003
 for <linux-pm@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Tue, 21 Nov 2023 03:07:13 +0000
X-Zone-Loop: ab646c5e58377167c9dc0b18ba066d1ffc4e193774e0
X-Originating-IP: [136.175.111.2]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kelvie.ca;
	s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:
	From:In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=yv3ur+VJgPZw5HSVfRVyxfBSzyF5tf8z7FkRU5st0L8=; b=oDbnF1ZC4la1YdwywqU+G9G6Qe
	88QaVloZ0eYUc3Q8326JwRDRR9L7KpUQDUeJHaBpl6vvrw9TPp9mLGogorfxAA8ocY3E2oYaW9fPM
	nqi6zTnljzLw/5sdUQRGM4YlPHb3sfFtlco5NTPNlx5uaXx5K+//rWwp2R2EXRRvdJey09ucj6AHv
	w7AJbKxjX+iQIzgqN2rqYHrSYku+Iuq/ONlfFCv1aQnZUqsfUM+KOlsNCQFN3X+OpRF8tbPgj6O9q
	n/1zy96mP0v3cVtBYBw62qqaRj2s9V7iOUz4fEjBLC66aeRJ2CoiS+hN3CAC8/yrxY+phHLYLTT81
	zhqqziwg==;
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2851b271e51so1416788a91.1;
        Mon, 20 Nov 2023 19:07:11 -0800 (PST)
X-Gm-Message-State: AOJu0Yx7tyGV0qyJbexqXA/sKLzQoyKaLi1uOh8nh69fys8AIvAxm1vc
	wIXG1Wj5hPZEIYwEm189QkFjwT3Lf9BYZuF36qQ=
X-Google-Smtp-Source: AGHT+IHon8FUuNWN6OAvDXiT56AU977GCXjbZnY29yNHWhPtGrU+rTKXg7n8CadQaTmdi00890/QXuJBCYzK0xTkkfk=
X-Received: by 2002:a17:90a:6881:b0:280:a4a1:5d03 with SMTP id
 a1-20020a17090a688100b00280a4a15d03mr2108500pjd.4.1700536030830; Mon, 20 Nov
 2023 19:07:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231114022503.6310-1-kelvie@kelvie.ca> <a66a805c-3e1f-4b9a-a38e-aca84b8678a6@infradead.org>
 <CAHC9VhR6mr0XRrq=Apy00HD3tdgpKi4RyMr8f5kdx2sjA0sfig@mail.gmail.com>
In-Reply-To: <CAHC9VhR6mr0XRrq=Apy00HD3tdgpKi4RyMr8f5kdx2sjA0sfig@mail.gmail.com>
From: Kelvie Wong <kelvie@kelvie.ca>
Date: Mon, 20 Nov 2023 19:06:59 -0800
X-Gmail-Original-Message-ID: <CAK2bC5rN_P7WP_E57wJjz+7icVjrwS0e6fqg_5uNaPhy3YR2dQ@mail.gmail.com>
Message-ID: <CAK2bC5rN_P7WP_E57wJjz+7icVjrwS0e6fqg_5uNaPhy3YR2dQ@mail.gmail.com>
Subject: Re: [PATCH RFC] Add a lockdown_hibernate parameter
To: Paul Moore <paul@paul-moore.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-security-module <linux-security-module@vger.kernel.org>, David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authenticated-Id: kelvie@kelvie.ca

On Mon, 20 Nov 2023 at 13:12, Paul Moore <paul@paul-moore.com> wrote:
> On Mon, Nov 13, 2023 at 11:01=E2=80=AFPM Randy Dunlap <rdunlap@infradead.=
org> wrote:
> >
> > [add security & dhowells]
> >
> > On 11/13/23 18:23, Kelvie Wong wrote:
> > > This allows the user to tell the kernel that they know better (namely=
,
> > > they secured their swap properly), and that it can enable hibernation=
.
> > >
> > > I've been using this for about a year now, as it doesn't seem like
> > > proper secure hibernation was going to be implemented back then, and
> > > it's now been a year since I've been building my own kernels with thi=
s
> > > patch, so getting this upstreamed would save some CO2 from me buildin=
g
> > > my own kernels every upgrade.
> > >
> > > Some other not-me users have also tested the patch:
> > >
> > > https://community.frame.work/t/guide-fedora-36-hibernation-with-enabl=
ed-secure-boot-and-full-disk-encryption-fde-decrypting-over-tpm2/25474/17
> > >
> > > Signed-off-by: Kelvie Wong <kelvie@kelvie.ca>
>
> I would feel a lot better about this if there was a way to verify that
> the swap was protected as opposed to leaving that as a note in a doc
> that the majority of users will never see, read, or understand.

I'd argue that this wouldn't even be necessary if we detect the swap was
protected -- hibernation should just be enabled in that case without settin=
g
any parameters.

My understanding is that it was disabled waiting for this
functionality, and it's been
at least a couple of years now [1], so it looks like it's not such an
easy problem.

Anyway, my argument is that the majority of users will never use this kerne=
l
parameter anyway, so I think it's a fair assumption that the power users th=
at
*do* use this will educate themselves on why this parameter even exists.

[1] https://lwn.net/Articles/847042/

--=20
Kelvie

