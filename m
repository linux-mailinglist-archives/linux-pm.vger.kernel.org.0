Return-Path: <linux-pm+bounces-28009-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF97ACC591
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 13:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F8E9171A37
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 11:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6A222B5B8;
	Tue,  3 Jun 2025 11:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yw6e1kL+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4172CC2F2;
	Tue,  3 Jun 2025 11:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748950753; cv=none; b=LONmeRZmWkEiL+np5lftiEyigtNpmUdtqnzaHA382NLKzG/JKOZN8G+iRGYYA3whPN7JdLVc8ZTib3YkK3aOZ9mjbNV3eGdN2ij4KpoN84GkCllANr+DaiYJ00vcRp+EV2lydezcidcvNTndQynAOXpce0q5+V3L4I6DMzzHzXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748950753; c=relaxed/simple;
	bh=Yb14ENIXi8lF1HTt0lNeGnwO8I39Yh0YDJvUJX5aNR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SXdyC705NH5ct5FSW8mCbU/XGCzQMlPRqrYShVHSJWZHFiSFNtk2g0RmJwoS7srr17noHja3SPnPskdLiLtTE5lwYOp+IG1EJsfxEpBwemMWBOx5+WcRaI/NTIiCBYZw6A9wI+ycqg6wWuqQZwSHM87C38noTq4ERIjZZB2cMM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yw6e1kL+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180FBC4AF09;
	Tue,  3 Jun 2025 11:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748950753;
	bh=Yb14ENIXi8lF1HTt0lNeGnwO8I39Yh0YDJvUJX5aNR0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Yw6e1kL+uIg9LmU7VUt27OWJKkCfJwx75VMKPUAvUvSHROnNsmeUKn+2h0YCmliC3
	 kpiLH3w+o3dEBnlwTvkDP2mOx0IZHwiyKGJ4oLNwiQoC10NLr/uZT5MutWcwxjUaj0
	 HnaKrBYYkKuIUIuIEpxlNpWGanF8kOFZvYJUJ0gnlpsuqXX6B7Swh5CHCv3Hp0i2vs
	 ueqk/betPLR34hiNKOVPDZ8WiqQ+NJhV0y5zGOxMPgCIel7L55z8qhqNl3PMcJSxmS
	 +0zREjdbJh9AhxDEMuUHAfgZbPtkvYs7qPVU4SJ5wNZ6sGc6YtOhdEUijI3sROX71r
	 fbuxtO0Ic114Q==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4067106dd56so3319578b6e.3;
        Tue, 03 Jun 2025 04:39:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUvfbAPvNwkhHLvEu0SDV4v8gXQlU40V65ffQhVy1Gef9c4AmPOhvoBK9dZPEign7db8MZ8loiiLGI=@vger.kernel.org, AJvYcCWHvYQ60oDW9fluLXBVS0Ogx4ZQf4h2EqGnTHtRwUv4L3j1wMF6AquJHynt+YaAnoaeK/I8f7MqBZZTTfM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/wJLnAMe8DhwOgF517Awq1/CyBcPGJcnXOxzLrnCOnqOxEYF7
	828gwr3M7Vt+sEWLqwGwJ1vEMxK7+x2yoXkFs0kdZ9y+qsLOb6ilrsucanC45glflsqzg26yY0K
	xsODjK27QzfGBnXpp5jiDPpEtizpgHww=
X-Google-Smtp-Source: AGHT+IFDu03qUeJMkdYUHWsBENIzrz1YxhUxEIulqlfwOmxS15tsO4GBjesBRAqyi6jffbVeh7ZrwG+s7lire+KJ2HU=
X-Received: by 2002:a05:6808:3992:b0:406:7af5:30f2 with SMTP id
 5614622812f47-4067e6e470bmr9798684b6e.34.1748950752440; Tue, 03 Jun 2025
 04:39:12 -0700 (PDT)
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
 <CAJZ5v0ggPHhYcdNos2o8savvq+-zpPTaQunjOkR36k3VwF3_CA@mail.gmail.com> <CAJZ5v0gF=ewooE0cUrNfe5_inhnzq6bqw8VTjkFwr56_wrptJQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gF=ewooE0cUrNfe5_inhnzq6bqw8VTjkFwr56_wrptJQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 3 Jun 2025 13:39:01 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hpJSVdiCN29=kbV8KfgU1y1d3hFfshtBoMpVFXf+LvBQ@mail.gmail.com>
X-Gm-Features: AX0GCFtS5glXNhKWvyz0xGKaOokKN9SbXfOGRMr96fRNjyvJTqf98g39wnvGnQQ
Message-ID: <CAJZ5v0hpJSVdiCN29=kbV8KfgU1y1d3hFfshtBoMpVFXf+LvBQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] PM: sleep: Suspend async parents after suspending children
To: Chris Bainbridge <chris.bainbridge@gmail.com>
Cc: Mario Limonciello <superm1@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Johan Hovold <johan@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Jon Hunter <jonathanh@nvidia.com>, Saravana Kannan <saravanak@google.com>, 
	amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="00000000000054578c0636a954fa"

--00000000000054578c0636a954fa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 1:37=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> On Tue, Jun 3, 2025 at 12:30=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > On Tue, Jun 3, 2025 at 12:29=E2=80=AFPM Rafael J. Wysocki <rafael@kerne=
l.org> wrote:
> > >
> > > On Tue, Jun 3, 2025 at 12:17=E2=80=AFPM Chris Bainbridge
> > > <chris.bainbridge@gmail.com> wrote:
> > > >
> > > > On Tue, Jun 03, 2025 at 11:38:37AM +0200, Rafael J. Wysocki wrote:
> > > > >
> > > > > Chris, please check if the attached patch helps.  I'm going to po=
st it
> > > > > as a fix anyway later today, but it would be good to verify that =
it is
> > > > > sufficient.
> > > >
> > > > This did not fix my test case, pstore crash log was:
> > >
> > > OK, so can you please enable PM debug messages:
> > >
> > > # echo 1 > /sys/power/pm_debug/messages
> >
> > This should be
> >
> > # echo 1 > /sys/power/pm_debug_messages
> >
> > sorry.
> >
> > > and enabled dynamic debug in drivers/base/power/main.c:
> > >
> > > # echo "file drivers/base/power/main.c +p" > /proc/dynamic_debug/cont=
rol
> > >
> > > repeat the test and capture the log?
>
> Actually, no need to do this, there is an obvious bug:
> list_splice_init() should be used instead of list_splice() when the
> emptied list is going to be used again.  Ugh.
>
> Please check if the attached patch along with the previous one makes
> the issue go away entirely.

Really attached this time, sorry.

--00000000000054578c0636a954fa
Content-Type: text/x-patch; charset="US-ASCII"; name="pm-sleep-fix-error-paths.patch"
Content-Disposition: attachment; filename="pm-sleep-fix-error-paths.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mbgg3g3c0>
X-Attachment-Id: f_mbgg3g3c0

LS0tCiBkcml2ZXJzL2Jhc2UvcG93ZXIvbWFpbi5jIHwgICAgNiArKystLS0KIDEgZmlsZSBjaGFu
Z2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgotLS0gYS9kcml2ZXJzL2Jhc2Uv
cG93ZXIvbWFpbi5jCisrKyBiL2RyaXZlcnMvYmFzZS9wb3dlci9tYWluLmMKQEAgLTE0NTgsNyAr
MTQ1OCw3IEBACiAJCQkgKiBNb3ZlIGFsbCBkZXZpY2VzIHRvIHRoZSB0YXJnZXQgbGlzdCB0byBy
ZXN1bWUgdGhlbQogCQkJICogcHJvcGVybHkuCiAJCQkgKi8KLQkJCWxpc3Rfc3BsaWNlKCZkcG1f
bGF0ZV9lYXJseV9saXN0LCAmZHBtX25vaXJxX2xpc3QpOworCQkJbGlzdF9zcGxpY2VfaW5pdCgm
ZHBtX2xhdGVfZWFybHlfbGlzdCwgJmRwbV9ub2lycV9saXN0KTsKIAkJCWJyZWFrOwogCQl9CiAJ
fQpAQCAtMTY2MCw3ICsxNjYwLDcgQEAKIAkJCSAqIE1vdmUgYWxsIGRldmljZXMgdG8gdGhlIHRh
cmdldCBsaXN0IHRvIHJlc3VtZSB0aGVtCiAJCQkgKiBwcm9wZXJseS4KIAkJCSAqLwotCQkJbGlz
dF9zcGxpY2UoJmRwbV9zdXNwZW5kZWRfbGlzdCwgJmRwbV9sYXRlX2Vhcmx5X2xpc3QpOworCQkJ
bGlzdF9zcGxpY2VfaW5pdCgmZHBtX3N1c3BlbmRlZF9saXN0LCAmZHBtX2xhdGVfZWFybHlfbGlz
dCk7CiAJCQlicmVhazsKIAkJfQogCX0KQEAgLTE5NTMsNyArMTk1Myw3IEBACiAJCQkgKiBNb3Zl
IGFsbCBkZXZpY2VzIHRvIHRoZSB0YXJnZXQgbGlzdCB0byByZXN1bWUgdGhlbQogCQkJICogcHJv
cGVybHkuCiAJCQkgKi8KLQkJCWxpc3Rfc3BsaWNlKCZkcG1fcHJlcGFyZWRfbGlzdCwgJmRwbV9z
dXNwZW5kZWRfbGlzdCk7CisJCQlsaXN0X3NwbGljZV9pbml0KCZkcG1fcHJlcGFyZWRfbGlzdCwg
JmRwbV9zdXNwZW5kZWRfbGlzdCk7CiAJCQlicmVhazsKIAkJfQogCX0K
--00000000000054578c0636a954fa--

