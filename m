Return-Path: <linux-pm+bounces-30058-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F5FAF78CC
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 16:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 267601CA16A3
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 14:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FE32EF656;
	Thu,  3 Jul 2025 14:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOBX3ma7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED37126BFF;
	Thu,  3 Jul 2025 14:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751554285; cv=none; b=AbQ1J4SfqNctmLuFM9wO3z2NSHO77B+3SDm0eaIRCDckqNZN3i1aD0/Jx6PERF6VUpHf2NX9SEExbsfi68ez4wya+uYIJY5+vTi0MQgxza2LwBYWDwvcAhuLURHCsYUey7BZOtEi+tavxFWTw2td3jft3zussRz8JfF6sR980ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751554285; c=relaxed/simple;
	bh=nmrggkRGP+YzUsxlEigAfo2TfRxLLgXQPq8gEiJ/iHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XW2vzDbZjid3zQyBMLYhISXzRtxvHwaPoXFGKyF+t+0QRXpeBNQOb2dZyO1GSOMQ1alcSFbPlTO9tupD4LvK3YjdDwpBhF6cGQkko0XJTFLTPQJ4zkL8l+UVApXX6bCfcUKU6PlVM73qFDW4hvaZzz6yhscYRFHUqwwNk7F7k8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOBX3ma7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0954C4CEF4;
	Thu,  3 Jul 2025 14:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751554284;
	bh=nmrggkRGP+YzUsxlEigAfo2TfRxLLgXQPq8gEiJ/iHc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HOBX3ma7G8qwLwoZcsWloD6igB3cH3kpEzNjWaAGzUFc05IU3aVeWNqbve14/x0In
	 /2JSBR5qANHLBkkpYeibTf3Lor8DF4+4iSfygeu6Ypb/6hd/QDhq0VRz0rXJQiqbmg
	 LS4gv7kOez7oDyQG1Qlqv3wXZgEpKXSpFY9EScTUMzVXngGDAy7Hf14Ru87Br7bPV4
	 Qrtwce85mq4zSPkAx3nIbWyTeO07+CqBmDtlwwoaC1jgO5VVeCSCcb0m8+DQaSvmkz
	 Sb59imsqJowc2a4WWLymMyR6bY3FXfKexUV2Q7Lt5Sw0i+QJQAENUeOV9s3EV5z9IQ
	 BQa/hXiDyRySg==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6116d9bb6ecso8751eaf.3;
        Thu, 03 Jul 2025 07:51:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVHeRTIDNKarCfP4sk06QJ5LH0rCXnTnpiL0pD3PTj8IxKKc6bEKSLWry8b2NJx06HZ2w+jeU77CVrlvzc=@vger.kernel.org, AJvYcCWp5J3qOexUhyvbssyegVwEu2TeD5jir4s20YJ/dYX4JpNcGdggEUaBIrcUx+ZSDsGYD1Ay3ZpYqeg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxcf4TQF3UTb+fv0ZqoPpg0M1d0Rb92bYFnw8pj78LYmcggTnF
	y15M53R9VBXRDHY41TeHJLonP5/RAq9hrTyv2Zfuo4b9O2gF+TNmDoNjrUm4lQEGcOPt1zcVhg4
	H8+pR3P04777+I6+Pv/9oOLkHI9r1AMw=
X-Google-Smtp-Source: AGHT+IFdp2UeYa9pYq8nFzdPrYMur2skNp/LDdRrtjF6WSPChxq2+gboSoQEyQCRE2tNMWJu6Wpz7HoQo6e3U35/k0E=
X-Received: by 2002:a05:6820:1f0f:b0:611:b24d:c27b with SMTP id
 006d021491bc7-6120122af91mr6144019eaf.7.1751554284255; Thu, 03 Jul 2025
 07:51:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5011988.GXAFRqVoOG@rjwysocki.net> <aGKNMySk6I0hJXSY@bogus>
In-Reply-To: <aGKNMySk6I0hJXSY@bogus>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 3 Jul 2025 16:51:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jvf_1JAbWRVi1=oYPqFk_qJ_p0zHJy-ZzugxLkTF4cWw@mail.gmail.com>
X-Gm-Features: Ac12FXxxSG95La_UNSEwXYZjHPL4UG0rEgYf5Fea3GqIJ8DYy5NAPdBEYUy-8E0
Message-ID: <CAJZ5v0jvf_1JAbWRVi1=oYPqFk_qJ_p0zHJy-ZzugxLkTF4cWw@mail.gmail.com>
Subject: Re: [RFT][PATCH v4 0/2] PM: sleep: Handle async suppliers like
 parents and async consumers like children
To: Sudeep Holla <sudeep.holla@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Mario Limonciello <mario.limonciello@amd.com>, Chris Bainbridge <chris.bainbridge@gmail.com>, 
	Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 3:13=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.com>=
 wrote:
>
> On Mon, Jun 23, 2025 at 02:44:09PM +0200, Rafael J. Wysocki wrote:
> > Hi Everyone,
> >
> > These two patches complement the recently made PM core changes related =
to
> > the async suspend and resume of devices.  They should apply on top of
> > 6.16-rc3.
> >
> > They were sent along with the other changes mentioned above:
> >
> > https://lore.kernel.org/linux-pm/2229735.Mh6RI2rZIc@rjwysocki.net/
> > https://lore.kernel.org/linux-pm/2651185.Lt9SDvczpP@rjwysocki.net/
> >
> > (and this is v4 because they have been rebased in the meantime), but th=
ey don't
> > make any difference on my test-bed x86 systems, so I'd appreciate a con=
firmation
> > that they are actually needed on ARM (or another architecture using DT)=
.
> >
>
> All the changes LGTM.
>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

Thank you!

> I don't have platform to exercise this patch much ATM, so sorry can't do
> much testing though.

No worries.

Everyone seems to be liking this series, so I'm going to queue it up
for 6.17 and we'll see how it goes.

Thanks!

