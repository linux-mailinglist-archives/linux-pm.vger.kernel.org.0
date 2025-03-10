Return-Path: <linux-pm+bounces-23785-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF3CA5A63C
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 22:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D735E3AC9EB
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 21:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798881DF269;
	Mon, 10 Mar 2025 21:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TirXhkdp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C9F1CB9F0;
	Mon, 10 Mar 2025 21:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741642160; cv=none; b=ClFHzAALH1chtXFcVbJClRTIjQP36wTxninmAlJe+fYPfNmbUlGUYA6gHt6pz53VC1m2foVnBs+axXBu/4V7mk7HkCvv505Ii2KK6qUrEDsBq4RZ7AvOclnvh+MVRrb4a27hK3bK/VpwFl7DaSBnm/JqrvH19gkGy0pgdGv0OcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741642160; c=relaxed/simple;
	bh=OoeUDymeISbaQ0PaNahEAnVeRknU+25o4QGwfMko6ug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hYipoFbUzhjXIJzbzEVNluYCIuVxelCM8gPEeqiQtaezgZ0qZLr9Q1kfSAxiMIKjOqfTS8XZCS/V/HIw0CbWHXkYYJ1yTVeNlSDlR4wJg2YlmP1KpCWPvX0J/TO/S4xSdB9D1nmKex+MTExgpgiBbjlx19pjVlekIwer9emITrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TirXhkdp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F7AC4CEE5;
	Mon, 10 Mar 2025 21:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741642159;
	bh=OoeUDymeISbaQ0PaNahEAnVeRknU+25o4QGwfMko6ug=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TirXhkdpxads6GYAJqkreCa36p6CdNrG+YmakqXFgUMIuDMiq3woNRA66HxaM76Al
	 YVJq27q2eV5KAehd8WFiqvSaxR+Fs8bthaSXcn5tzE1lC5iDZBsAC4nQajdOyiLPi+
	 NlyrH1/zDmNpUvIniZLkonfkeCKMWTDW2BeeyzqYGAbYi7bcDbsptdlPgC1jtogwog
	 C4MrvA+KBfCqD9bo9AnXW8vYwN/2YJh+C8JgnXpXibzEISpCTuq4sID2wjAxKfuR6I
	 KLN1q1GFh2gtDrdZGviG24Qbpat/OQh2kzLurYvJk+xPYvS3HMWFEa/n6DBgT9SBRj
	 mfG7Le196I4ZA==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2c12b7af278so2803046fac.0;
        Mon, 10 Mar 2025 14:29:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVuzpo6lKSlBhRHdevTk/nyToLb/+5BM5DODkJ46EROKq+0YFBRTEp3TRGEZqZg+2Pa3Jl6vtFntg4=@vger.kernel.org, AJvYcCXRSk4Z6flUKukqy4kpvu3jdoZQEZ3IAK9hbzMwWsAQ5mZoyAjUMf2WpOkj5EbGBiRURSqukpSIsj/LqVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZP2ICeirKNbWQmCfCYBwENzDrN/G50+niDFFVarokVw2Gv2E/
	gQ4go7l9b9tPATeprYYwfmEGOZ9QM13/eF4e8cIB84qj7UGmUM4OoN2nBMhO+y6cDVFeKiML19p
	X+6iG6dKnSW8hAqT9Nx2BPRayqf8=
X-Google-Smtp-Source: AGHT+IFcs1F3WeWS/rw/rH8zZRmJCxnvb5NTIKWhxHbpZf3MggTanH3PRtzPyFZHmXDyAM20lNRz7MiCww56hnLw9vk=
X-Received: by 2002:a05:6870:b521:b0:2b8:92f0:ba5d with SMTP id
 586e51a60fabf-2c2e959794bmr658930fac.8.1741642159022; Mon, 10 Mar 2025
 14:29:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <13709135.uLZWGnKmhe@rjwysocki.net> <CAGETcx-ow3T_R_Lj1s3sjp6nQz6Wv7T3dQdP3HJHd+E8nkh6rw@mail.gmail.com>
 <CAJZ5v0g3qOvESqvqiCnwVz2BYGHzrG8=nRQ8j36Qd_LC0io_Tw@mail.gmail.com>
 <CAGETcx82sLvG19eUN1ATrL5RzEKJjOeWP+kdYJdQX9O=ck7q2Q@mail.gmail.com>
 <CAJZ5v0guoA-xp-yyr7Fb7ikmE9rjt8xwDPcxU52sd0UP_u=2jA@mail.gmail.com> <CAGETcx9WZWiUd+YCQfoZEGGbewv2nrx2TiQJs55KEWbOUg9TCg@mail.gmail.com>
In-Reply-To: <CAGETcx9WZWiUd+YCQfoZEGGbewv2nrx2TiQJs55KEWbOUg9TCg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 10 Mar 2025 22:29:07 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0haTW3L4Baez9Q1LWrRahijWgr0sd85kYOtr6ajZ3Vkgw@mail.gmail.com>
X-Gm-Features: AQ5f1JrHMx3CwpnVlHY_ucu_zEOmB_7ca_XctKtlXga0bL7icVffHW0BVQmzMlE
Message-ID: <CAJZ5v0haTW3L4Baez9Q1LWrRahijWgr0sd85kYOtr6ajZ3Vkgw@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] PM: sleep: Improvements of async suspend and
 resume of devices
To: Saravana Kannan <saravanak@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Johan Hovold <johan@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 9:31=E2=80=AFPM Saravana Kannan <saravanak@google.c=
om> wrote:
>
> On Mon, Mar 10, 2025 at 9:01=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > On Sun, Mar 9, 2025 at 11:38=E2=80=AFPM Saravana Kannan <saravanak@goog=
le.com> wrote:
> > >
> > > On Thu, Feb 27, 2025 at 8:23=E2=80=AFAM Rafael J. Wysocki <rafael@ker=
nel.org> wrote:
> > > >
> > > > On Thu, Feb 27, 2025 at 4:45=E2=80=AFPM Saravana Kannan <saravanak@=
google.com> wrote:
> > > > >
> > > > > On Tue, Feb 25, 2025 at 8:46=E2=80=AFAM Rafael J. Wysocki <rjw@rj=
wysocki.net> wrote:
> > > > > >
> > > > > > Hi Everyone,
> > > > > >
> > > > > > Initially, this was an attempt to address the problems describe=
d by
> > > > > > Saravana related to spawning async work for any async device up=
front
> > > > > > in the resume path:
> > > > > >
> > > > > > https://lore.kernel.org/linux-pm/20241114220921.2529905-1-sarav=
anak@google.com/
> > > > > >
> > > > > > but then I realized that it could be extended to the suspend pa=
th and
> > > > > > used for speeding it up, which it really does.
> > > > >
> > > > > Btw, maybe I didn't  word it correctly, but my patch series was m=
eant
> > > > > to speed up the non-async case too.
> > > >
> > > > If "the non-async case" means the case with "async" suspend/resume
> > > > disabled entirely, I don't think that the ordering in which devices
> > > > are processed can be changed just because there are no known
> > > > dependencies.
> > > >
> > > > > I was going to get around sending a v2 of my series, but was caug=
ht up
> > > > > with some other work. But I'm okay if you want to finish up my ef=
fort
> > > > > -- less work for me and I can focus on the other aspects of suspe=
nd :)
> > > > >
> > > > > Maybe add a Suggested-by: to the patches?
> > > >
> > > > Yeah, I can do that.
> > > >
> > > > > I definitely want to review the series, but very busy this week w=
ith
> > > > > some other work. I'll get to this next week for sure.
> > > >
> > > > That should be fine.
> > >
> > > Hi Rafael,
> > >
> > > I looked at the full series and it has at least one bug and a few gap=
s
> > > that I address in mine.
> >
> > What bug?
> >
> > You need to tell me specifically because I'm not aware of any bugs in
> > this series and unless you tell me what it is and I agree that it is a
> > bug, I have no reason to believe that there are any.
> >
> > As for the gaps, there are obvious differences between this patch
> > series and your work and it would be kind of nice to explain why they
> > matter in practice, in your view.
>
> Sure, I'll do this.

OK

> But it just felt like an inefficient way to get to close to where my seri=
es is.

I'm not sure where it is TBH.

> Instead of you just saying you don't like
> about my series and giving me some feedback on how to fix it.

You got feedback on it:

https://lore.kernel.org/linux-pm/CAJZ5v0grG7eSJ7_c73i9-bXaFhm5rfE2WmxtR6yLB=
-MGkd7sVg@mail.gmail.com/

And no response.

Also here:

https://lore.kernel.org/linux-pm/CAJZ5v0g9A1pZ5FjPAjdLY5ybNmefnBVVMJM7h3czW=
38p1fTfqQ@mail.gmail.com/

And there was a bunch of feedback from other people (and 0-day) on the
last patch.

> > > And those are what make my patches have a
> > > higher diff. Can we just continue with my series instead?
> >
> > Of course you are free to send a new version of it, but it is unlikely
> > to be a sufficient replacement for constructive feedback.
>
> Ok, I'll point out the issues I see in this series and hopefully you
> can point out the issues in my series and we can move forward with
> mine if you agree with the additional issues my series is working
> through.

Sure, but please address the feedback so far and send a new version.

