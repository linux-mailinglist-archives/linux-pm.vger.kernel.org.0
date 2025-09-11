Return-Path: <linux-pm+bounces-34459-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60391B530CD
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 13:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2EC3189BA44
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 11:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E884331AF3B;
	Thu, 11 Sep 2025 11:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpZBJPfx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB78131A067;
	Thu, 11 Sep 2025 11:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757590571; cv=none; b=sML8Z5yATc1KPsDixhYM9Mjvuft+p2BokA66CunDSnzfipWGngNF+1mVGLizxRi9AFne7vPPYC2pIbTkn+FfkrpU7hHtuDQH3ui3j2Hfv6gge07b5rG+D3GnbyJ3Da6ix3EQAu8NcIOqXL85tt/E9LumyluYiYtiGCGFshYTEbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757590571; c=relaxed/simple;
	bh=CNpV22T8AswRhrpiLRxkJUzKe8iNuebBhrTWXhnyZYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gsEDz0p9uE1PcWbzxFgtO9QUs5AGMXPSdZwDAGzLmtBcQEdQJdnEE5ppibaRrkWQmRUkCLVdw/TqsT5kdghNk+CPmBsqa3vrchxZ3TLGZSeLP2eTpF4nyBP4Ru0/vj44IjsiP2OUKSdooRXnhTnSVW7C0xj/7hNNYQAwsQ6ZVd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpZBJPfx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF5FC4CEF9;
	Thu, 11 Sep 2025 11:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757590571;
	bh=CNpV22T8AswRhrpiLRxkJUzKe8iNuebBhrTWXhnyZYk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LpZBJPfxwsrKIXWYj30aaWqO+d+TUSw6TfUWJdVzWgT/uhshobmE/XjzNqkkjx7gf
	 c+D31pPsvR4elLEJy4+Z+q5PDK1G2uATe2mUkai3kIFcdLMhVQboQ1EdODHjaGDNjh
	 KYGQ2qTCuFBNxnVKZlRtLbXDIut0uwvwwTtc623H77GawAjqxJ71cfNP11Gw/UblWU
	 QAd+YG7xog1oSJiqOaJaM1CubGxR0C5lXw8GoPWyTF0KWUU4V5rqSo21BXFOqdkM/w
	 pLGRWU2pB60iMTzhyuBgoQ+q+Mw0XMAoClusfM0RHEXh+0VEdmaA/nNZCB1XlLM8DE
	 YJERSEMYq/quw==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-745a415bf72so215270a34.2;
        Thu, 11 Sep 2025 04:36:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUeYMenxx2J9IrwOfKXLUMvP9Ru9IZzS3oa+FA0KwlXDhIsqSSBW6ogoJawfP7lxQJvJZ7qTQK2SnKFhHM=@vger.kernel.org, AJvYcCW9jNylzvtn7HOWp88HUwMu3KvzsxzxYJWDrIPgG4cLZaSwKA1nQwYjxmzohER8nFyCXe4w1H4f2ns=@vger.kernel.org, AJvYcCWLKLmvUhKGEgeLY0xlvrEMJ8/Z08qvRKFv3ti7UJL+ERRSFysBYtUuXfT+dWLhZWbe0+xHrp68dE8j@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2gk9BUiJryll8/Tf1kpWChEj8pMr0MeiPxc+Xoc771wY3peOH
	bSi8g9Z1EqO/jvx+efXQh/5Z40tYi1RXHJp49zF2g6Txq04O1NPbwilH9IMNUg5o2cyEx406ifJ
	IReS6Pd5AlQJsYVbRXJ4leIbH/uhNpLg=
X-Google-Smtp-Source: AGHT+IHqgnkh2OWQWfy0kZC+r/sWfXUgOMIve2iTBUboctBeQ8xCunXip+WdacLIRpUxIMq60eEynLI3cVNClcPNozs=
X-Received: by 2002:a05:6830:34a9:b0:745:606d:a515 with SMTP id
 46e09a7af769-74c6e47a84fmr7636308a34.1.1757590570810; Thu, 11 Sep 2025
 04:36:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <385dccf3-234a-4f83-9610-81ac30bf1466@rowland.harvard.edu>
 <20250909161901.10733-1-ryanzhou54@gmail.com> <20250911013242.oxm2kwfaqvmybbhk@synopsys.com>
 <xbfvykzfi26pyaycd7efbqvmraxcu6zzgqjfxtk33wcsjsnnal@5e3g4pq5qcj3>
In-Reply-To: <xbfvykzfi26pyaycd7efbqvmraxcu6zzgqjfxtk33wcsjsnnal@5e3g4pq5qcj3>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 11 Sep 2025 13:35:59 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gT26VK-sHmgK_S4RjjO3Uc-ZmoAYos43S5yWh0zWc9DA@mail.gmail.com>
X-Gm-Features: Ac12FXyYq6TGze2lEaGahV6ycs6T8Gj-NY9mhxuAe6ZfTmot6HAePuEoaNbA1Jc
Message-ID: <CAJZ5v0gT26VK-sHmgK_S4RjjO3Uc-ZmoAYos43S5yWh0zWc9DA@mail.gmail.com>
Subject: Re: [PATCH v2] drvier: usb: dwc3: Fix runtime PM trying to activate
 child device xxx.dwc3 but parent is not active
To: Xu Yang <xu.yang_2@nxp.com>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Ryan Zhou <ryanzhou54@gmail.com>, 
	"stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "rafael@kernel.org" <rafael@kernel.org>, 
	"royluo@google.com" <royluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 12:58=E2=80=AFPM Xu Yang <xu.yang_2@nxp.com> wrote:
>
> Hi Ryan,
>
> On Thu, Sep 11, 2025 at 01:32:47AM +0000, Thinh Nguyen wrote:
> > On Wed, Sep 10, 2025, Ryan Zhou wrote:
> > > Issue description:During the wake-up sequence, if the system invokes
> > >  dwc3->resume and detects that the parent device of dwc3 is in a
> > > runtime suspend state, the system will generate an error: runtime PM
> > > trying to activate child device xxx.dwc3 but parent is not active.
> > >
> > > Solution:At the dwc3->resume entry point, if the dwc3 controller
> > > is detected in a suspended state, the function shall return
> > > immediately without executing any further operations.
> > >
> > > Signed-off-by: Ryan Zhou <ryanzhou54@gmail.com>
> > > ---
> > >  drivers/usb/dwc3/core.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > > index 370fc524a468..06a6f8a67129 100644
> > > --- a/drivers/usb/dwc3/core.c
> > > +++ b/drivers/usb/dwc3/core.c
> > > @@ -2687,6 +2687,9 @@ int dwc3_pm_resume(struct dwc3 *dwc)
> > >     struct device *dev =3D dwc->dev;
> > >     int             ret =3D 0;
> > >
> > > +   if (pm_runtime_suspended(dev))
> > > +           return ret;
> > > +
> >
> > Is this a documented behavior where the device should remain runtime
> > suspend on system resume? I feel that that this should be configurable
> > by the user or defined the PM core. I don't think we should change
> > default behavior here just to workaround the issue that we're facing.
> >
> > What if the user wants to keep the old behavior and resume up the devic=
e
> > on system resume?
>
> What about resume the device firstly if it's already runtime suspended wh=
en
> call dwc3_pm_suspend(). Therefor, the old behavior can be kept and the is=
sue
> can be avoided.
>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 370fc524a468..1b8dbb260017 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -2672,6 +2672,9 @@ int dwc3_pm_suspend(struct dwc3 *dwc)
>         struct device *dev =3D dwc->dev;
>         int             ret;
>
> +       if (pm_runtime_suspended(dev))
> +               pm_runtime_resume(dev);

You can just call pm_runtime_resume() here without the preliminary check.

> +
>         ret =3D dwc3_suspend_common(dwc, PMSG_SUSPEND);
>         if (ret)
>                 return ret;
>
> Thanks,
> Xu Yang
>
> >
> > BR,
> > Thinh
> >
> > >     pinctrl_pm_select_default_state(dev);
> > >
> > >     pm_runtime_disable(dev);
> > > --

