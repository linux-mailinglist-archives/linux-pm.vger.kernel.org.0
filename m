Return-Path: <linux-pm+bounces-36183-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E183BDEA76
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 15:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A75A4E80F7
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 13:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2ED322C67;
	Wed, 15 Oct 2025 13:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0fB0jAi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7D0321421
	for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 13:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760533702; cv=none; b=aDjay4mQJ3tChVzCjDUnGuqgoqfqBZOP0+r7QT9c5xAdEYuH9lQKXP8qWFMPaNiaEw1NjVgAfbXv8JrXSLV7bIrw4h/lyk8DUcvddeUaQIMGQTH/dHuq/RPU65ToXNaJib/ygNJqLr3ne2Pa6e6lBBKZRd3zo6+giV+pP69MVRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760533702; c=relaxed/simple;
	bh=DPIqXuU+TUQPEPS3arpMl/xCOS9gzIiqANf0KKZ8CkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mhbb31OnZIuvYL/qQLu8WgFJyM6Drn8FntYNR06aMtUNkG1LJGJfiMe7b8A2qEV9hqKK4t87Tm3VDqFaBgcxeww8d0NT52Sn5j7mUsnbIR1B+4GgDco4LaWXzAZ0dX3btSQDBdN2b3YJs3i82i3w1NXsIi5VLFVKkwu5PGrk5xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0fB0jAi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB36C4CEFE
	for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 13:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760533702;
	bh=DPIqXuU+TUQPEPS3arpMl/xCOS9gzIiqANf0KKZ8CkE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=O0fB0jAiSbjDp5PnStAPJb1EbssBzgJeN/fBWj/ly3Momuz/KmOLP3DOBJYigMfff
	 3dFqzaUvfDNqaWk1EMH1ll2j/xBR1PP3MuHrZYvSqQLKUiNA848PZIKuUDkPs4tPQ/
	 EH5OQDT2makiE0eipiyZaMXxdJ3lFbUQU7GJHK/PjHG33EutldME2e16gHySjsbtBO
	 oXBFFvLwJHgWqgbwelg2lDYRXW1qaN2pLsu3BOjM7MYYB5GugzLez5sqMdYTgY6mCv
	 mrAMrUqx9AQOba9UgMjz6HzBqzA8hnAdgl9i4Md1kdOBUGMhHiQaqjGOjKjBqAKWs0
	 KvupFwwbtTo8w==
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-43f8116a163so2915275b6e.1
        for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 06:08:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVPwixCzr8BW7jsvHcsWsYphIhgFekgJ1X/Q5+IDX+hkOt/8YYrKb22AjdRet/yndBKbElywiM34Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyW8BwRDe7fo9/Un7GiAlfTEEInHScXqDGgUxNPOvuU4Z43MH0f
	yfRK4p2EoDg9KC4aZWUKbUtmH/C/0VuoAw1pFS5yYHNDQVOwSRRebtjQLPAlxI1vHkEOjhJ/6N5
	HVxGV04PUYKrzwqnM4c2lyKZnUdLaFY8=
X-Google-Smtp-Source: AGHT+IGKh4ax/Cdtp0vxgf0Hd9gzc+VZd8UKj7uPZkEqpjf/tHoDqSIY26AOihord/ywhWhe7EGbvrSqXsnUNUNF6To=
X-Received: by 2002:a05:6808:4f4f:b0:43f:7940:69bf with SMTP id
 5614622812f47-4417b3acf95mr13195428b6e.26.1760533701351; Wed, 15 Oct 2025
 06:08:21 -0700 (PDT)
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
In-Reply-To: <wd3rjb7lfwmi2cnx3up3wkfiv4tamoz66vgtv756rfaqmwaiwf@7wapktjpctsj>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 15 Oct 2025 15:08:09 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g=HNDEbD=nTGNKtSex1E2m2PJmvz1V4HoEFDbdZ7mN3g@mail.gmail.com>
X-Gm-Features: AS18NWCNLd4VfOtzdFRcAx-qFOpGR9ib07mNIONMyq7-qTOr4g6Yivy6LKB0oI0
Message-ID: <CAJZ5v0g=HNDEbD=nTGNKtSex1E2m2PJmvz1V4HoEFDbdZ7mN3g@mail.gmail.com>
Subject: Re: stable: commit "cpuidle: menu: Avoid discarding useful
 information" causes regressions
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Christian Loehle <christian.loehle@arm.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Sasha Levin <sashal@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000e292940641323190"

--000000000000e292940641323190
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 3:56=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (25/10/14 16:02), Rafael J. Wysocki wrote:
> > > >> Would it be possible to check if the mainline has this issue?  Tha=
t
> > > >> is, compare the benchmark results on unmodified 6.17 (say) and on =
6.17
> > > >> with commit 85975daeaa4 reverted?
> > > >
> > > > I don't think mainline kernel can run on those devices (due to
> > > > a bunch of downstream patches).  Best bet is 6.12, I guess.
> > >
> > > Depending on what Rafael is expecting here you might just get
> > > away with copying menu.c from mainline, the interactions to other
> > > subsystems are limited fortunately.
> >
> > Yeah, that'd be sufficiently close.
>
> Test results for menu.c from linux-next are within regressed range: 78.5

So please check if the attached patch makes any difference.

--000000000000e292940641323190
Content-Type: text/x-patch; charset="US-ASCII"; name="cpuidle-menu-max_overall.patch"
Content-Disposition: attachment; filename="cpuidle-menu-max_overall.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mgs0aeda0>
X-Attachment-Id: f_mgs0aeda0

LS0tCiBkcml2ZXJzL2NwdWlkbGUvZ292ZXJub3JzL21lbnUuYyB8ICAgIDYgKysrKystCiAxIGZp
bGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgotLS0gYS9kcml2ZXJz
L2NwdWlkbGUvZ292ZXJub3JzL21lbnUuYworKysgYi9kcml2ZXJzL2NwdWlkbGUvZ292ZXJub3Jz
L21lbnUuYwpAQCAtMTE2LDYgKzExNiw3IEBAIHN0YXRpYyB2b2lkIG1lbnVfdXBkYXRlKHN0cnVj
dCBjcHVpZGxlX2QKIHN0YXRpYyB1bnNpZ25lZCBpbnQgZ2V0X3R5cGljYWxfaW50ZXJ2YWwoc3Ry
dWN0IG1lbnVfZGV2aWNlICpkYXRhKQogewogCXM2NCB2YWx1ZSwgbWluX3RocmVzaCA9IC0xLCBt
YXhfdGhyZXNoID0gVUlOVF9NQVg7CisJdW5zaWduZWQgaW50IG1heF9vdmVyYWxsID0gMDsKIAl1
bnNpZ25lZCBpbnQgbWF4LCBtaW4sIGRpdmlzb3I7CiAJdTY0IGF2ZywgdmFyaWFuY2UsIGF2Z19z
cTsKIAlpbnQgaTsKQEAgLTE1MSw2ICsxNTIsOSBAQCBhZ2FpbjoKIAlpZiAoIW1heCkKIAkJcmV0
dXJuIFVJTlRfTUFYOwogCisJaWYgKG1heF9vdmVyYWxsIDwgbWF4KQorCQltYXhfb3ZlcmFsbCA9
IG1heDsKKwogCWlmIChkaXZpc29yID09IElOVEVSVkFMUykgewogCQlhdmcgPj49IElOVEVSVkFM
X1NISUZUOwogCQl2YXJpYW5jZSA+Pj0gSU5URVJWQUxfU0hJRlQ7CkBAIC0xOTgsNyArMjAyLDcg
QEAgYWdhaW46CiAJCSAqIG1heGltdW0sIHNvIHJldHVybiB0aGUgbGF0dGVyIGluIHRoYXQgY2Fz
ZS4KIAkJICovCiAJCWlmIChkaXZpc29yID49IElOVEVSVkFMUyAvIDIpCi0JCQlyZXR1cm4gbWF4
OworCQkJcmV0dXJuIG1heF9vdmVyYWxsOwogCiAJCXJldHVybiBVSU5UX01BWDsKIAl9Cg==
--000000000000e292940641323190--

