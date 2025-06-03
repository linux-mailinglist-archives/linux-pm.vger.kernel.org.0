Return-Path: <linux-pm+bounces-28008-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08973ACC58C
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 13:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06117188F7C5
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 11:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7923B22A804;
	Tue,  3 Jun 2025 11:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUn6NGvM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2974F5E0;
	Tue,  3 Jun 2025 11:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748950701; cv=none; b=q0x6GhIMa1JRdUIrZoo3mtwuimn/KkpmRnSfC8gY/dlbLMJWvin2Zyqb7sz05d3bT4VviTFjbPuMC0BoTioGKhRddt6VR36/r8OQIlGfZgch2/hnD5VYF9iWM7YkdKI+bX1SMANYlZMNJU6yUyoNANCECnmokOYE7p5r5dqzazc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748950701; c=relaxed/simple;
	bh=4RRD/9bdJrUID2Ofi+LblmYzXf2AW9lr6cAlAj0OTyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tjKpbZ8zlETHMcX+qrLTYkSWvsEr7zHMhYR2zEI2YNbwaX6iguNJvX9X0ggglzBoytSsUP96EWDZAcvXIfwgObWk6Gjb9nziGQcpg8edRK04ytLGC6vF8xxr2WXinVEBcKGFvHJ++YMj+dZQFtLO5XHyzuTEZYBKyjxw3I2OGFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUn6NGvM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20FEC4CEEF;
	Tue,  3 Jun 2025 11:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748950700;
	bh=4RRD/9bdJrUID2Ofi+LblmYzXf2AW9lr6cAlAj0OTyQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gUn6NGvMNWToRty2HYobH513ycZDAGalqCxPiWwvojYTejj3lkCuefAbMXv5z1iZF
	 yQrzm8AqSiEwxcrYzGBK9t+cUlbk91eIZ0F7SI1fcKf0oeeyvxzxckNHxhpBzgGQ0d
	 Ikyf/mNnbpObKSaKnUOnP17ZZyLYpSck2PGn1/ZcccpUytj/jlte6AK/m5lGXzdfNY
	 My87jEfhhZK7EOEH7nh+1qbVwhH8/9UuX3gOgK/rJVNiTaa8s3ysmVfi3nHZFl4WzQ
	 7SsgtoOl+IatMXQWYUeeHIv+tFcbdrAaQeR0YPpe+bMIVHks91XC2GRwj5l3XbjEHj
	 nLAjwvZB96Bbg==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6063462098eso3798400eaf.0;
        Tue, 03 Jun 2025 04:38:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVMNbxciUxwtgtfqoXiqEYnXPZXmqxvhwwHtMeQyESvG0z9mvrCiv1KKmpkC6exCD6Nph9cMCfPWpg=@vger.kernel.org, AJvYcCX57yxyOKlUvIqW3x5osz0Sag49/u5C3q5yKjguJfchUx4RdWFw7kNt1HEfpklE6kakj4sQzCJkolddUKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaKlqY12PGWRQDMqfS4Ssm2pht70X71jPLRVuda/1Gc8rgCZc0
	Jf/vvCJGH5por1CHZ/0ABFHs4eoxwDj6YIJlBOK0J5GFTmTlLpTZNdwNORBA3C8ElQcsROfYqCZ
	3hx/qaaSysv/4CLemYQHvnKaL4Nq91MU=
X-Google-Smtp-Source: AGHT+IGnbL6Yg0jKhdCGF4THq7aGkIu2aR3cF60fOaQQhvw0n5LcvLT93Hb3IRqonIUkiGMArqewhjYTAxbzV3g47yU=
X-Received: by 2002:a05:6808:2011:b0:406:769e:e7a9 with SMTP id
 5614622812f47-407a66123aamr7405560b6e.35.1748950689878; Tue, 03 Jun 2025
 04:38:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <10629535.nUPlyArG6x@rjwysocki.net> <3541233.QJadu78ljV@rjwysocki.net>
 <aD2U3VIhf8vDkl09@debian.local> <CAJZ5v0h-nrVamqiAJ957aYjHqaeAZUUW7BRi0WxPgCFc40M5cQ@mail.gmail.com>
 <7f0e2865-d35e-4a13-8617-8679afb4b23f@kernel.org> <CAJZ5v0gL3rW8dOxXdPWYjZuq5kAaD8qTa4vZ5++k9+0WniNAdQ@mail.gmail.com>
 <CAJZ5v0jDZQaR8S6Kn_RoXHBU86+tpjp=qgyxm5h03YEe2S=nPg@mail.gmail.com>
 <aD7L0RD4HT-mEtBc@debian.local> <CAJZ5v0h65Gt1Fw35vp2k8kKu62+goCD8WF8u-tvhfWW6a7xHxQ@mail.gmail.com>
 <CAJZ5v0ggPHhYcdNos2o8savvq+-zpPTaQunjOkR36k3VwF3_CA@mail.gmail.com>
In-Reply-To: <CAJZ5v0ggPHhYcdNos2o8savvq+-zpPTaQunjOkR36k3VwF3_CA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 3 Jun 2025 13:37:58 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gF=ewooE0cUrNfe5_inhnzq6bqw8VTjkFwr56_wrptJQ@mail.gmail.com>
X-Gm-Features: AX0GCFtvJRJldgZgV_6J-TAl2xlbUFYP5ivr_jqfkdXJefgmF--kbl4IlROujGc
Message-ID: <CAJZ5v0gF=ewooE0cUrNfe5_inhnzq6bqw8VTjkFwr56_wrptJQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] PM: sleep: Suspend async parents after suspending children
To: Chris Bainbridge <chris.bainbridge@gmail.com>
Cc: Mario Limonciello <superm1@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Johan Hovold <johan@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Jon Hunter <jonathanh@nvidia.com>, Saravana Kannan <saravanak@google.com>, 
	amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 12:30=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Tue, Jun 3, 2025 at 12:29=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > On Tue, Jun 3, 2025 at 12:17=E2=80=AFPM Chris Bainbridge
> > <chris.bainbridge@gmail.com> wrote:
> > >
> > > On Tue, Jun 03, 2025 at 11:38:37AM +0200, Rafael J. Wysocki wrote:
> > > >
> > > > Chris, please check if the attached patch helps.  I'm going to post=
 it
> > > > as a fix anyway later today, but it would be good to verify that it=
 is
> > > > sufficient.
> > >
> > > This did not fix my test case, pstore crash log was:
> >
> > OK, so can you please enable PM debug messages:
> >
> > # echo 1 > /sys/power/pm_debug/messages
>
> This should be
>
> # echo 1 > /sys/power/pm_debug_messages
>
> sorry.
>
> > and enabled dynamic debug in drivers/base/power/main.c:
> >
> > # echo "file drivers/base/power/main.c +p" > /proc/dynamic_debug/contro=
l
> >
> > repeat the test and capture the log?

Actually, no need to do this, there is an obvious bug:
list_splice_init() should be used instead of list_splice() when the
emptied list is going to be used again.  Ugh.

Please check if the attached patch along with the previous one makes
the issue go away entirely.

