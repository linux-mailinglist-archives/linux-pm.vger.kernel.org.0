Return-Path: <linux-pm+bounces-23373-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BC6A4E1AA
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 15:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A16EC19C1BB7
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 14:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0079124DFE1;
	Tue,  4 Mar 2025 14:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOgzba7r"
X-Original-To: linux-pm@vger.kernel.org
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A35C78F2B
	for <linux-pm@vger.kernel.org>; Tue,  4 Mar 2025 14:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099299; cv=pass; b=E5qpAxrYZvjkWTB1YnbuMEOgOVaQVPYnibUvKCa1waoXHD4fTbCoJD7Omp7fNTFF55EX74AMGB0F/uKpZk7kNrRJSCzHvrycp9IpuCnZ8PwaYNal0jBJDWAOMm/qnRgEf5Vz2nEm5HnRE/VoGJropq7AYai/68+qqI7Le9QF2vE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099299; c=relaxed/simple;
	bh=LGkSTeMJSL/cH0aAMd2yE3RYQtg8Y3v4p03/JAj8MYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nMpxis7ZqGEkC1Z3EfwATAq4KaLYy9XqygMuDXbYSdIWjdAj8IlX7OXqw4gEudj6w88nWtPwTMj7u+BfrscmlzRpb2ntp1wlPKwZa4G8b2rOV0BC+GiWwYfH3Dx/MiAxXD9MhblnhuWdlAq9xJFi18HTRTNf676M3BXvs3b4idk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOgzba7r; arc=none smtp.client-ip=10.30.226.201; arc=pass smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (unknown [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id EF65340D0471
	for <linux-pm@vger.kernel.org>; Tue,  4 Mar 2025 17:41:35 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JOgzba7r
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dcW3m3vzFx4p
	for <linux-pm@vger.kernel.org>; Tue,  4 Mar 2025 17:39:39 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 6CABB42740; Tue,  4 Mar 2025 17:39:22 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOgzba7r
X-Envelope-From: <linux-kernel+bounces-541673-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOgzba7r
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 26CF742549
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 15:12:18 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw2.itu.edu.tr (Postfix) with SMTP id ADFA72DCDE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 15:12:17 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8602F3B1439
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F34320E704;
	Mon,  3 Mar 2025 12:08:48 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC031FFC5D;
	Mon,  3 Mar 2025 12:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741003725; cv=none; b=i88IRjupga3xLFUMQZrrN6bL3P8maxJ73hwC5dP8uVQzr4rfcZkdLvg//wHprkBWicg02SSSivbftAK1tZMC1bp+Wd4F5CqsBCosKD21T/GS2vZPnhv9jndOlPUUNc0LPQ51w4gRZyk8oMNzM3kRsWZ4S7FRFDGsUNPkEhciwwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741003725; c=relaxed/simple;
	bh=LGkSTeMJSL/cH0aAMd2yE3RYQtg8Y3v4p03/JAj8MYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TtQqAUozqEZcyDm0hLoeRkht4ipFtGUFOHchKwXVNReYgTuWdkYXkpcNbYGyT0mAsxfCY59FyiSrVCMdEyEWaeEEFnftTS5u85hY1ufRV28NTO3MyzWppCC8Uii+slOwW/CvOW6TmWkpyo32GkLXeT3+womADNsjthLb+SJfRjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOgzba7r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C457C4CEE6;
	Mon,  3 Mar 2025 12:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741003725;
	bh=LGkSTeMJSL/cH0aAMd2yE3RYQtg8Y3v4p03/JAj8MYo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JOgzba7rumPUUt+3gteK8x9ZNSeO4vmIPUtBm/4n5NiPfAEtAv3KsduFjHVnRBvYP
	 nOKDVlscMErtbUIi+bBI0VzMzpkAQHIPXoOECKx8/WIUGqxZYjHwUaXGqwyRABKmtM
	 eAS3WHS5zm87hWMSDLJy8pBIbTsRIxCyZc4mNW/9375L8GqRPDA7O6X632u3avW3WR
	 mKY8t5FIvStnQXapBFA2toErN72CMdMS0VLnkzij/l/n6irK+NXPlezBgLOXVgxuZt
	 Uz0ZrSE9IHPnwUOuCiXFzgPgYABFL8qXwEG1xoNx3xytUjlp6eRzhIMVSUufLiP0Wz
	 /4VIdlGyXpwzA==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3f66bf7602eso261605b6e.3;
        Mon, 03 Mar 2025 04:08:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWQ1/NjUNCSenugMWx7zURmhseK6c1pnsQUTNwlAm7REI0/qRhz6Fyciz5IrDn0irjWkLfeq0dobDE=@vger.kernel.org, AJvYcCWSGvc2TSWxYA01ocw0xcXIvWbuwU++B7/7L2S+Cti9ZBiQhhLZidQZo+uqJzbDYxOgI/4Ymf5t/RnD6/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnf84Yp9MBfH1VShA0ttlt+MHSwH5VmWAsgyi6U6ugoVjljUPI
	A1vixVv52XlILr/GDnjutGayFnkW0meusftwDj5OTsyJn8EiNj1GvJK1sR1PyadjUKBY1fHtfSJ
	LnQGien/BhjmoY/uMk1KCPymaqdQ=
X-Google-Smtp-Source: AGHT+IHUr2H06n1lRN0NwMlgKxCbIFdOobcyUUosrvn5yqSQUt8nL0vKq4fIngd8cXxKK3Bb4uOrL2lghJ9judeG3LM=
X-Received: by 2002:a05:6808:1dd9:b0:3f6:6cbc:9326 with SMTP id
 5614622812f47-3f66cbc9559mr1342832b6e.29.1741003724512; Mon, 03 Mar 2025
 04:08:44 -0800 (PST)
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <13709135.uLZWGnKmhe@rjwysocki.net> <CAPDyKFoWeZNqODb5VdXfTEhxRJ0azSQPWhM3WCJ+iUeJ3rYQHw@mail.gmail.com>
In-Reply-To: <CAPDyKFoWeZNqODb5VdXfTEhxRJ0azSQPWhM3WCJ+iUeJ3rYQHw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 3 Mar 2025 13:08:32 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0htK3V2uPvqczirL9WW2Pgip00VP6xd8pqbOKvCUPhSbQ@mail.gmail.com>
X-Gm-Features: AQ5f1JoHfqGi4iiLMoX4pE-Ttl2wrDwMHPv6jml-d3qFwq9ON_ye9RzblquNiDo
Message-ID: <CAJZ5v0htK3V2uPvqczirL9WW2Pgip00VP6xd8pqbOKvCUPhSbQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] PM: sleep: Improvements of async suspend and
 resume of devices
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Johan Hovold <johan@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dcW3m3vzFx4p
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741704000.75712@aGlMxOn80Qh40euowU8sdA
X-ITU-MailScanner-SpamCheck: not spam

On Mon, Mar 3, 2025 at 1:07=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
>
> On Tue, 25 Feb 2025 at 17:46, Rafael J. Wysocki <rjw@rjwysocki.net> wrote=
:
> >
> > Hi Everyone,
> >
> > Initially, this was an attempt to address the problems described by
> > Saravana related to spawning async work for any async device upfront
> > in the resume path:
> >
> > https://lore.kernel.org/linux-pm/20241114220921.2529905-1-saravanak@goo=
gle.com/
> >
> > but then I realized that it could be extended to the suspend path and
> > used for speeding it up, which it really does.
> >
> > Overall, the idea is that instead of starting an async work item for ev=
ery
> > async device upfront, which is not very efficient because the majority =
of
> > those devices will not be able to make progress due to dependencies any=
way,
> > the async handling is only started upfront for the devices that are lik=
ely
> > to be able to make progress.  That is, devices without parents in the r=
esume
> > path and leaf devices (ie. devices without children or consumers) in th=
e
> > suspend path (the underlying observation here is that devices without p=
arents
> > are likely to have no suppliers too whereas devices without children th=
at
> > have consumers are not unheard of).  This allows to reduce the amount o=
f
> > processing that needs to be done to start with.
> >
> > Then, after processing every device ("async" or "sync"), "async" proces=
sing
> > is started for some devices that have been "unblocked" by it, which are=
 its
> > children in the resume path or its parent and its suppliers in the susp=
end
> > path.  This allows asynchronous handling to start as soon as it makes s=
ense
> > without delaying the "async" devices unnecessarily.
> >
> > Fortunately, the additional plumbing needed to implement this is not
> > particularly complicated.
>
> Thanks for the detailed description! Overall, the approach makes
> perfect sense to me too!
>
> I am certainly interested to hear Saravana's thoughts around this too.
>
> >
> > The first two patches in the series are preparatory.
>
> For these two, feel free to add:
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> >
> > Patch [3/5] deals with the resume path for all device resume phases.
> >
> > Patch [4/5] optimizes the "suspend" phase which has the most visible ef=
fect (on
> > the systems in my office the speedup is in the 100 ms range which is ar=
ound 20%
> > of the total device resume time).
> >
> > Patch [5/5] extend this to the "suspend late" and "suspend noirq" phase=
s.
>
> I will try to have a closer look at patch 3->5 later in the week.

Thank you and thanks for all of the other reviews!


