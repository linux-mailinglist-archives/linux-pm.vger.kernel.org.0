Return-Path: <linux-pm+bounces-23784-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B39F8A5A4FF
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 21:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E471E1692A7
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 20:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3217B1DF258;
	Mon, 10 Mar 2025 20:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2H2jIIy4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0151DEFEC
	for <linux-pm@vger.kernel.org>; Mon, 10 Mar 2025 20:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741638712; cv=none; b=sUGnu2vqrIBgQdEc7bqk2Dy+qc7vKl4khQo4Zjspv6X9Qna4i1Zbz+Gg+fnfYg5EHK+mOhodfwq0Nog4s9pYgLDP7ZzszrZqzzCSteEXZqQWHp4vuvTvV2Ms87ORGpEb6xaQK9blIi0FqWqo1kSv5DmMsob/zD7o6zWdBAYGOZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741638712; c=relaxed/simple;
	bh=vPI2vdFz6faudexW5pLqxAk1let8kmq4hkQftQKYf+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IShFXcS3d6l4boyazgN+cu8Cm5lPY/7x8i/IXCafb4xwTUihnTWomghKruUCVJf3cpkA/WtYOGCjcTdmNtQKtJbCOuzqalQr2Pa2MnEFWgfGO+Mnubgt0zaK0uIvXRbt70qa/Mouhe5bYT6PNp93A9+iqTjqdj07cnhp/lC/DKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2H2jIIy4; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54957f0c657so5459227e87.0
        for <linux-pm@vger.kernel.org>; Mon, 10 Mar 2025 13:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741638708; x=1742243508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iU9Zr9AdDxObefou97uhuyBrBosAUFAYDvZeeNLaZkQ=;
        b=2H2jIIy4XVsuZ1NFVWtqZazFeEqZ1nnrO/wA7wGdmZOrRKqJWtQcTa4eieG6S54TJn
         GWifWRnQ9ortzxwlrHqJiF+fB1b7Xt8jM2tRk65JDfkM93km35gc9aNc6ouNgUT08ewz
         IiLcMlv8c9orFbn/0FlA/+YrgUgbpO6Mmq4Y/HYAXD3L/7mHvYqaehGZThC5435YmVOA
         jt1bJq/M7ogy/9GZmWCatZG+gsZX9Gz6w70P/TIXGPo6llXvA6k4bwDaS2GjILW4v5UD
         Z7wuETSzUYzamVWBV0bpeD8XhVApoyyqaE1sfXNJJx6nU2oCPaI4GHNGvYh+utyuovq7
         tFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741638708; x=1742243508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iU9Zr9AdDxObefou97uhuyBrBosAUFAYDvZeeNLaZkQ=;
        b=ZiI6GgF4OGYAbwvMLpMU32wR9LPgrCEVIeqJ5Rq6oEqDnmXzEkCsXf0CA6C+4ag/Ia
         FaEebT3hO+BJTx0vB6i2P78i5wdfxgpjpJR3AsIT/id0RSozGRH0bbxHxVs6swj8OiEu
         AIOY9Y+FXxpUeRpDnUVsLori8INE5zwf+DP3HVn3m3ryjDvmgr/PCpvcu1MiLtmyiwMm
         gMF9HZ5rXh3M2BcjvmRyxUzBLHNeVoUTeXoR+sGoCTA9gG8GoGYR38Ps+kLN8xgzxIP+
         fmd9vPsXW0netHgtLo8JUUNmmJ4WbVq4w0BgdNQCZulxa6orlC2EClXCDS+Oa2YX/XM8
         GTRg==
X-Forwarded-Encrypted: i=1; AJvYcCUrI/6zbW9h3b06XjuHgOXGUkq8OyZupI9fpMaXkZxsCKB9OJbrBwJ/+gOcE/u7JFln1s+0UZEsIw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLH6gKFjCUPRmFBJU1oquYQ+YIW4CSq+TeWR+K1sdx4mI0bzOg
	H3F1rHbznfKRMkkhNBwqDLDxUFaZM1j1P/1BEWGTjqTPnnNtp1ijuCE7HiAMiUwNOinI2Rbv+7i
	u+JJeBA8oxsxoyCMBTUw5lz+MykYTzMn7P3aQepKVt9gAOe1m6w==
X-Gm-Gg: ASbGncuxcgB/JNjZT8INibqJNcUjNNq9veoMbSQ4qfZAw69OHck0gCJfcdRLwOjXoX/
	77cKOBz5q3fYq+hmjYT814NEwrsMg+mGtiGnHBPp3Uoe3wZ1oQ5VzMX4/V3NRLqVmtuY9ugzKTs
	kqMR620a8aCTvUpslh4W73gdQVRbDl5EbHG50=
X-Google-Smtp-Source: AGHT+IHg1D8UEfw5egbWh6K7jcsDx3TSENUA4mkd2p1bukzpPwxKtDZI2o6raUSNsZ8L/BGV/bOHC1+0QLsES/QXpRQ=
X-Received: by 2002:a05:6512:2398:b0:545:3035:f0bb with SMTP id
 2adb3069b0e04-549abd648c5mr332985e87.22.1741638708118; Mon, 10 Mar 2025
 13:31:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <13709135.uLZWGnKmhe@rjwysocki.net> <CAGETcx-ow3T_R_Lj1s3sjp6nQz6Wv7T3dQdP3HJHd+E8nkh6rw@mail.gmail.com>
 <CAJZ5v0g3qOvESqvqiCnwVz2BYGHzrG8=nRQ8j36Qd_LC0io_Tw@mail.gmail.com>
 <CAGETcx82sLvG19eUN1ATrL5RzEKJjOeWP+kdYJdQX9O=ck7q2Q@mail.gmail.com> <CAJZ5v0guoA-xp-yyr7Fb7ikmE9rjt8xwDPcxU52sd0UP_u=2jA@mail.gmail.com>
In-Reply-To: <CAJZ5v0guoA-xp-yyr7Fb7ikmE9rjt8xwDPcxU52sd0UP_u=2jA@mail.gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 10 Mar 2025 13:31:09 -0700
X-Gm-Features: AQ5f1JqLC2c8Cn3c-TiaSuxoU5BT2DXhEgQgoiy3YZ_Nljp52pK0DcVf0QTG8m4
Message-ID: <CAGETcx9WZWiUd+YCQfoZEGGbewv2nrx2TiQJs55KEWbOUg9TCg@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] PM: sleep: Improvements of async suspend and
 resume of devices
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Johan Hovold <johan@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 9:01=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Sun, Mar 9, 2025 at 11:38=E2=80=AFPM Saravana Kannan <saravanak@google=
.com> wrote:
> >
> > On Thu, Feb 27, 2025 at 8:23=E2=80=AFAM Rafael J. Wysocki <rafael@kerne=
l.org> wrote:
> > >
> > > On Thu, Feb 27, 2025 at 4:45=E2=80=AFPM Saravana Kannan <saravanak@go=
ogle.com> wrote:
> > > >
> > > > On Tue, Feb 25, 2025 at 8:46=E2=80=AFAM Rafael J. Wysocki <rjw@rjwy=
socki.net> wrote:
> > > > >
> > > > > Hi Everyone,
> > > > >
> > > > > Initially, this was an attempt to address the problems described =
by
> > > > > Saravana related to spawning async work for any async device upfr=
ont
> > > > > in the resume path:
> > > > >
> > > > > https://lore.kernel.org/linux-pm/20241114220921.2529905-1-saravan=
ak@google.com/
> > > > >
> > > > > but then I realized that it could be extended to the suspend path=
 and
> > > > > used for speeding it up, which it really does.
> > > >
> > > > Btw, maybe I didn't  word it correctly, but my patch series was mea=
nt
> > > > to speed up the non-async case too.
> > >
> > > If "the non-async case" means the case with "async" suspend/resume
> > > disabled entirely, I don't think that the ordering in which devices
> > > are processed can be changed just because there are no known
> > > dependencies.
> > >
> > > > I was going to get around sending a v2 of my series, but was caught=
 up
> > > > with some other work. But I'm okay if you want to finish up my effo=
rt
> > > > -- less work for me and I can focus on the other aspects of suspend=
 :)
> > > >
> > > > Maybe add a Suggested-by: to the patches?
> > >
> > > Yeah, I can do that.
> > >
> > > > I definitely want to review the series, but very busy this week wit=
h
> > > > some other work. I'll get to this next week for sure.
> > >
> > > That should be fine.
> >
> > Hi Rafael,
> >
> > I looked at the full series and it has at least one bug and a few gaps
> > that I address in mine.
>
> What bug?
>
> You need to tell me specifically because I'm not aware of any bugs in
> this series and unless you tell me what it is and I agree that it is a
> bug, I have no reason to believe that there are any.
>
> As for the gaps, there are obvious differences between this patch
> series and your work and it would be kind of nice to explain why they
> matter in practice, in your view.

Sure, I'll do this. But it just felt like an inefficient way to get to
close to where my series is. Instead of you just saying you don't like
about my series and giving me some feedback on how to fix it.

> > And those are what make my patches have a
> > higher diff. Can we just continue with my series instead?
>
> Of course you are free to send a new version of it, but it is unlikely
> to be a sufficient replacement for constructive feedback.

Ok, I'll point out the issues I see in this series and hopefully you
can point out the issues in my series and we can move forward with
mine if you agree with the additional issues my series is working
through.

Thanks,
Saravana

