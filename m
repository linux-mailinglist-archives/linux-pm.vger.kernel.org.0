Return-Path: <linux-pm+bounces-35988-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DB58EBD5A93
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 20:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C30224E1B64
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 18:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AF92D1936;
	Mon, 13 Oct 2025 18:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lFIt2a3r"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA1A2C15A2
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 18:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760379195; cv=none; b=jesO9yfiLpX6dVIiOKdcizVkP3OdVrLGrtjhZVN/xUdXLe+PvMd8xE50J5VOWYG7C7Vromg+vaof6REhf3b6Ikvv+FCYZXz2sPkJHpobr5sfS6gZUPFyVdWRz0iQzjmd4QZbeH+fUO8xd14x0h2Z0cP8QNhBw/JIryVq1+3R46k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760379195; c=relaxed/simple;
	bh=OTScJF87r9gVg+1Yo/OxYg1HFqlCLltq/YnKA/HBr3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MUfumPtcHJzVBuPe0plAe7qU1KsY5JB9zr3Dyyt8PmUKnfNhgpu7Zwv6QfapVWuKZ1bD7eJ3XQY6gRdD4MQmj/9lcVDnvV10eeLI1nMpFo3Urqo2qU+rJJ/sGf+0fXC27PB36rrxLTMAqPoGWlA5lW07zap76Unh4Ppyc+NZ/QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lFIt2a3r; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-8e1d6fd99c1so1044713241.2
        for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 11:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760379192; x=1760983992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBDGX6PRnwkKDbG2N1uag2K8s9MQDp6R5zmbaCCPIKg=;
        b=lFIt2a3rAPTLgwTWPP0IuTZa7Vh/Mevcn0ZhO0M478Q9VbAL2r1RbKxrsmHR5laKdU
         uAJY4NtKHPMCPqEZKAdKzhUha7qbeq5XQ5r0yzcdR3+/Cxt2J6okd1E/TUqa+JIEuN7y
         rMON/lyE+3Ws1ICAegk/jYGDvpSGUt6tkREowbydYcA/LZ3t9RgZVp1EOsT3xZaL6xNr
         QbWWCBtnVesoU08NPGEfWjNxfyLtg3n+cSF1qAD5Nzp7xU2yeEWxGZ6rfN3NLA02vMim
         vo14dYUqu5CNrEA3VQeisfEq8o2dN47pIKnz4S/g/P+cCbykdNL2A6YPNuRqXpUxBIgM
         ZP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760379192; x=1760983992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QBDGX6PRnwkKDbG2N1uag2K8s9MQDp6R5zmbaCCPIKg=;
        b=UhUMIz8fvi+XeC95RKXmiOgFOKjOi/YuzYXrVJX1N7pTId3IqieQgeuwNvciZtD9v3
         NZ2rIUxrxrwFNBCXt/HGWwctXRZ+A7lQIv9xeMBUTyS0p7Gk2GHD8vPxwMrNNYw6yf92
         F9189Q7ceyi47vAVZtOKuPnOISnUKljAcSOPTyKbeEmPzjNlUs4Dnh3pLIdBxT+k/v16
         1uD/eP5nspt7s62Tk8F0x9sJnwsMyAAHYBIDQ1JcliBtM/gNfU7uTMcMMOvPmeCVEzrm
         ixaZdRfYhOIPZSlIjpQF3ks4SiptXvBeB9ay4VJK95esVOXK4ZGbh+XZ6IvA9wD64Cu1
         0gsg==
X-Forwarded-Encrypted: i=1; AJvYcCWqEEk2iMZn8rxRyuKyrSEBYra9cEvBoGBE+Ls2Vg6GvV26U26aUqZTVzQ9dLgc9T5ooRdrg2G3tA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5xtkaM1INOwkbkz5SwhSgM22nALYOEkQDU4WV4pEJlkCqw8gP
	eWYMvy8RlnaMbURn6lfuXDQjmRcXpPlqTA+s6ofurCADXdG2xNCI1/rIY+pLikqbj7jWpaXoquf
	ATUn6uX9wF/VSU3OlmNQXxMXfALP7EqUfm2sKJIl5
X-Gm-Gg: ASbGncvi2eh4zuaotAD/NVRpWnAMlESeYANc/7BybH5fHqsM9GL50Alye9yv00CIGsS
	Bo6/J/vqmPDCHvZc0i/4yaorA2XVfjJUpGvw7AqVAzESurtc5xTle8A1lbVPfCdudF9RgOE5cLr
	+DR31CjZXKY9BOQ3HN/pjOQv57km89+YvBqbhpwdS1wMh1G5RVI7v7SqufX6ZfozBL5En4COJJm
	YEpKh/JZdUJ22XpTq/aIwI5mwUkBTLolSavfr0w8g==
X-Google-Smtp-Source: AGHT+IGKw1l0F5gWDhtAGsAbrwQ74p6Ay5ZWwKVORS1MVWNtBycDuWsd9eKy3nP4zO1syMlrDCis3sMsarbSEjEa01c=
X-Received: by 2002:a05:6102:a4e:b0:4f1:7946:ed52 with SMTP id
 ada2fe7eead31-5d5e22514cdmr6942540137.12.1760379191925; Mon, 13 Oct 2025
 11:13:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911185314.2377124-1-wusamuel@google.com> <CAG2Kctqf=Q+nuuDqzkrOpjp+tOttf079DS_R8Q0pHU-k8DmFvA@mail.gmail.com>
 <CAJZ5v0gtKmtiLQwi-2qaw2G4O4PF_iqz6UbUZuaknepcJ1ToZQ@mail.gmail.com>
 <CAG2KctrK0JrP7JNUyzF72JeDgR4-GSRmJDe+yEnav=gQCAf64Q@mail.gmail.com>
 <CAJZ5v0g_HXQjWfp=L0KetRCHMTD=QsP3wJKNZnadJic2yccCUQ@mail.gmail.com>
 <CAGETcx_Fn3AzZo7gNvJnPxy=CNHpqAviGdUrww++SGySuBcaZw@mail.gmail.com> <CAJZ5v0hbtHxFo_z2fp9DMRDi75k6QL-kcDHD+o8zabub1YdCKg@mail.gmail.com>
In-Reply-To: <CAJZ5v0hbtHxFo_z2fp9DMRDi75k6QL-kcDHD+o8zabub1YdCKg@mail.gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 13 Oct 2025 11:12:35 -0700
X-Gm-Features: AS18NWCB-Biz5jvCAgmtrZo36zLv97GN145bed2sSqifeKMQMjaNvzx-gALNA5I
Message-ID: <CAGETcx_XFUg7V5KEGF+eqDtmhbUoufs8xARhaB0KJeh7Lzaj0w@mail.gmail.com>
Subject: Re: [PATCH v4] PM: Support aborting sleep during filesystem sync
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Samuel Wu <wusamuel@google.com>, Len Brown <lenb@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 11:02=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>
> On Thu, Oct 2, 2025 at 12:13=E2=80=AFAM Saravana Kannan <saravanak@google=
.com> wrote:
> >
> > On Wed, Oct 1, 2025 at 11:22=E2=80=AFAM Rafael J. Wysocki <rafael@kerne=
l.org> wrote:
> > >
> > > On Wed, Oct 1, 2025 at 12:37=E2=80=AFAM Samuel Wu <wusamuel@google.co=
m> wrote:
> > > >
> > > > On Tue, Sep 30, 2025 at 11:51=E2=80=AFAM Rafael J. Wysocki <rafael@=
kernel.org> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > On Tue, Sep 30, 2025 at 8:30=E2=80=AFPM Samuel Wu <wusamuel@googl=
e.com> wrote:
> > > > > >
> > > > > > Hi Rafael,
> > > > > >
> > > > > > Just a friendly ping on this patch. Please let me know if there=
's any
> > > > > > feedback or if you'd like me to make any changes.
> > > > >
> > > > > Have you seen https://lore.kernel.org/all/20250909065836.32534-1-=
tuhaowen@uniontech.com/
> > > > > ?
> > > > >
> > > > > If so, what do you think about it?
> > > >
> > > > I was following this chain
> > > > (https://lore.kernel.org/all/20250908024655.14636-1-tuhaowen@uniont=
ech.com/),
> > > > where there is some ongoing discussion on converging the solution.
> > > >
> > > > Our changes aren't mutually exclusive, and tuhaowen can build chang=
es
> > > > on top of ours, even indicating:
> > > > > I'm happy to work on this as a follow-up patch series after your =
changes land, or we could explore a unified solution that handles both scen=
arios.
> > >
> > > That's fair.
> > >
> > > > These patchsets don't negate each other, so could we decouple these
> > > > two patchsets since they address different issues?
> > >
> > > Well, I'm not sure if they are really different.  After all, this is
> > > all about avoiding having to wait on an excessively long filesystem
> > > sync during suspend.
> >
> > No, it's different. We don't mind a long filesystem sync if we don't
> > have a need to abort a suspend. If it takes 25 seconds to sync the
> > filesystem but there's no need to abort it, that's totally fine. So,
> > this patch is just about allowing abort to happen without waiting for
> > file system sync to finish.
>
> OK, thanks for clarification.
>
> > The other patch's requirement is to always abort if suspend takes 25
> > seconds (or whatever the timeout is). IIRC, in his case, it's because
> > of a bad disk or say a USB disk getting unplugged. I'm not convinced a
> > suspend timeout is the right thing to do, but I'm not going to nack
> > it. But to implement his requirement, he can put a patch on top of
> > ours where he sets a timer and then aborts suspends if it fires.
> >
> > > I'm also not sure why it is being pursued to be honest.  Is setting
> > > /sys/power/sync_on_suspend to 0 not regarded as a viable option?
> >
> > We do want to sync on every suspend. So, we don't want to turn it off
> > completely.
>
> I wonder why though.
>
> If suspend/resume works reliably, syncing filesystems on every attempt
> to suspend the system isn't particularly useful AFAICS.

A lot of people's entire digital life is on their phone. Even if
there's just 1% crash, when you look at that across billions of users
it adds up to serious impact.

Also, there are classes of devices where we do disable sync on suspend
(I can't share specifics). So, this is not an arbitrary stance. For
phones, we want to sync on suspend.

Also, your question could be posed equally to laptops too. If suspend
is reliable, then the laptop can always wake up at 3% battery, sync,
and then shutdown. But that's a leap of faith none of us want to make.
So, as long as we support sync on suspend, I think it makes sense to
allow suspend aborts to happen more gracefully.

Thanks,
Saravana

