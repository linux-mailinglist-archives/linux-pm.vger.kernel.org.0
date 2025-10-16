Return-Path: <linux-pm+bounces-36232-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DB508BE27C5
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 11:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A66994F2666
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 09:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7F22DE1FA;
	Thu, 16 Oct 2025 09:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EibSK2HB"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A662DC78B
	for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 09:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608042; cv=none; b=DvwXRrVVfFeH7WnnQyv+oZU0TNdLn124soLEB6iK4bQLEu2KOmsBCs2FQaJZ2fC1DkM+X2tSUk9SU+HcX/Fkci9v/C1fbSAV56wXDHNAPrL2X0eAhJMo0MHRsz+vPHzr7jK/5kDTfETRMEDdrP3OA+kZ3Wp0r9Re37lBaqhAtKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608042; c=relaxed/simple;
	bh=zwUsELB+Lg2vK2SBHg5w+9exptWG549/si/vw3mXHgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MOcBGpiQ8YAclVQoSQ+Kuv9ENbF++Df4EKagBGDzxVNKCC7n/dmYaHOndGPYOfYq3U2ZudJh/hzLUIjZgv4F6O05MGSiuwgofqxW+zX4GNaGXduRmvVBi4JY/2EzLaMMYFB1dEyo0pkQqOO2eZ0Y87UXiE+qz5yCoNSX4PwYdTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EibSK2HB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29702C4CEF1
	for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 09:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760608042;
	bh=zwUsELB+Lg2vK2SBHg5w+9exptWG549/si/vw3mXHgM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EibSK2HBQhWjxefDwcE/iAwM4DCBVh1K0vPbwdhPtbPnc79WY1Z/nvUpKnQQLwpw7
	 Z7TnMU3ILP0NrsASML8PGObtedWicIv4EG9Q68iqJzKAaSeDguB+5qryWd9+84+jvY
	 eAUBcYRHhSgf+eOocrUJvwHo7BuY5om3m9SAAr1CY0ZXJKTlxuQ2vOO7nobBqzna4m
	 iydmD5jc+G0a6Cwu+sl0xUADXQFXNPu6bXbYjjzniFK9/+ldSG/AKWzrPp1lc5abKI
	 yhYe4ex2cjNUrXj562fQNNUyywGLVpYNvKTQHY0rzVvc1ny6vTqgHKUx+R4F2pEgfw
	 2t3QnaQ/0jmxw==
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7b06f879d7bso1225703a34.0
        for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 02:47:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX/am0TGtZp9EN1DVHPspdON3pER+naQhNTDcuqsm5ZIPB3gNhUHIJU5am4+QKvbp/heglyhZ+3XA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUBgeOeEgdtKvTgOrLB3BGL6AiE2JL2Vjjh1BYen3FPZVCuUsj
	WhvSx7a6Y3aOxCy0jkswahdWx3e/v8gN1RTBlEfcUu9WQdC6ajz7Ygw+djZsyJTgUMbAo0RnsjN
	WrmfGzWU5rtMNdLX94q7OqeKybKkiLT8=
X-Google-Smtp-Source: AGHT+IGZxhmCLS8oGjw1bVMksbGQJRc8+MIBMOaMwF8vzghAQVz3g1hrXmIbNS04A+H14tMno+frWVQLqWnMuKPtVGo=
X-Received: by 2002:a05:6808:16a3:b0:438:3b69:ab94 with SMTP id
 5614622812f47-441fb710514mr1676547b6e.0.1760608041488; Thu, 16 Oct 2025
 02:47:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7>
 <08529809-5ca1-4495-8160-15d8e85ad640@arm.com> <2zreguw4djctgcmvgticnm4dctcuja7yfnp3r6bxaqon3i2pxf@thee3p3qduoq>
 <CAJZ5v0h-=MU2uwC0+TZy0WpyyMpFibW58=t68+NPqE0W9WxWtQ@mail.gmail.com>
 <ns2dglxkdqiidj445xal2w4onk56njkzllgoads377oaix7wuh@afvq7yinhpl7>
 <a9857ceb-bf3e-4229-9c2f-ecab6eb2e1b0@arm.com> <CAJZ5v0iF0NE07KcK4J2_Pko-1p2wuQXjLSD7iOTBr4QcDCX4vA@mail.gmail.com>
 <wd3rjb7lfwmi2cnx3up3wkfiv4tamoz66vgtv756rfaqmwaiwf@7wapktjpctsj>
 <CAJZ5v0g=HNDEbD=nTGNKtSex1E2m2PJmvz1V4HoEFDbdZ7mN3g@mail.gmail.com> <ry5gjxocyzo6waonjyc7hgvo7bc6riqpmy6l3f2au7dm4j5dtd@shma7ngcqjuk>
In-Reply-To: <ry5gjxocyzo6waonjyc7hgvo7bc6riqpmy6l3f2au7dm4j5dtd@shma7ngcqjuk>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 16 Oct 2025 11:47:10 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gqKcmXEObq6UmfTBXgueHw3eMk+CM74-FLjB3wk3WjGQ@mail.gmail.com>
X-Gm-Features: AS18NWBivoWKQ8bl6nqOscRSzPuSIsdjWErU9lzu02ziu_6o3oQgiJOT-owWFzk
Message-ID: <CAJZ5v0gqKcmXEObq6UmfTBXgueHw3eMk+CM74-FLjB3wk3WjGQ@mail.gmail.com>
Subject: Re: stable: commit "cpuidle: menu: Avoid discarding useful
 information" causes regressions
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Christian Loehle <christian.loehle@arm.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Sasha Levin <sashal@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 6:54=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (25/10/15 15:08), Rafael J. Wysocki wrote:
> > On Wed, Oct 15, 2025 at 3:56=E2=80=AFAM Sergey Senozhatsky
> > <senozhatsky@chromium.org> wrote:
> > >
> > > On (25/10/14 16:02), Rafael J. Wysocki wrote:
> > > > > >> Would it be possible to check if the mainline has this issue? =
 That
> > > > > >> is, compare the benchmark results on unmodified 6.17 (say) and=
 on 6.17
> > > > > >> with commit 85975daeaa4 reverted?
> > > > > >
> > > > > > I don't think mainline kernel can run on those devices (due to
> > > > > > a bunch of downstream patches).  Best bet is 6.12, I guess.
> > > > >
> > > > > Depending on what Rafael is expecting here you might just get
> > > > > away with copying menu.c from mainline, the interactions to other
> > > > > subsystems are limited fortunately.
> > > >
> > > > Yeah, that'd be sufficiently close.
> > >
> > > Test results for menu.c from linux-next are within regressed range: 7=
8.5
> >
> > So please check if the attached patch makes any difference.
>
> From what I can tell the patch fixes it!

Well, that's something.

As far as I'm concerned, this change can be made.

From a purely theoretical standpoint, arguments can be made for doing
it as well as for the current code and none of them is definitely
preferable.

The current approach was chosen because it led to lower latency which
should result in better performance, but after the patch the code is
closer to what was done before.

Let me submit it officially and we'll see what people will have to say.

