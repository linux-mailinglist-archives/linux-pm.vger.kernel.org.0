Return-Path: <linux-pm+bounces-42966-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CP2F/yVmWkKVQMAu9opvQ
	(envelope-from <linux-pm+bounces-42966-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 21 Feb 2026 12:24:44 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1B916CC1D
	for <lists+linux-pm@lfdr.de>; Sat, 21 Feb 2026 12:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EFA1E300250C
	for <lists+linux-pm@lfdr.de>; Sat, 21 Feb 2026 11:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634CB33DECF;
	Sat, 21 Feb 2026 11:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nz8BwCoO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBE1227BA4
	for <linux-pm@vger.kernel.org>; Sat, 21 Feb 2026 11:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771673078; cv=none; b=fnu/2NQJCpe/xCXYbNdAwv7YUxFU4wyC4lbsEhhlqIa7jnMFFDZjK/6R3HMN9o1NquZwWty5eFjOrFWzB5Tu6TNkT5YpnIK297RSrxZDhmS9T5zzwLiU1Odijd7Yh3oyUIDgrBr9emiLDdfsguYUayBgFT7AOclULaxSUhfI5yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771673078; c=relaxed/simple;
	bh=pQU+ZUtV6ra+IwYAZRcat8X58jf8DpORKXzeAWL1x0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tRdd/oeErqWCR+ik/P4fT7dDb4yyS9b1Ew6isC1zoC3ldB6nf8cQ2iC/JfM4+5vJIlC7HIp0/VCZjN+4v2HgYH12DHGSCObtxKY187X7f3qqTtfPlso7NisIKRw1g832bP5/uqJv4okoIojDt6bq+pX1y5Mlze1vKIKqSXOuGEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nz8BwCoO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E56A9C2BC86
	for <linux-pm@vger.kernel.org>; Sat, 21 Feb 2026 11:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771673077;
	bh=pQU+ZUtV6ra+IwYAZRcat8X58jf8DpORKXzeAWL1x0k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nz8BwCoOdZRoK1BU4lvoymeM40XMQmcviASxlUf35J2p/dhN/1WiuN16goh85qF90
	 GN+wmkS+gEry9qvWbDWHd7Mhb8v+H6U1fsTbm/voAkNZLC/ISDh+ZDhvKctKkYq6SC
	 iBdXMZN7hhEY+5YwDJFcKC5Z0tJTBbYkCf/zIfsiXti3uXt8PFCBIzZAGciJz2WJ3h
	 h5s5hBvX3ZPQAFSdAqyTqmgITMvcmoLvezp9FCwV8FJtrxWR6jbMMUkoS6Dxqe64H1
	 AuHH1H+cycc940bHBN3gj2Lpo78R5/Dj7/HaiwKYytWO65gr/bsv6zr5p2u2d74TjE
	 1rLFtCBKGq5nQ==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-4042fe53946so1247264fac.3
        for <linux-pm@vger.kernel.org>; Sat, 21 Feb 2026 03:24:37 -0800 (PST)
X-Gm-Message-State: AOJu0Yyn6Jxx28rI/pU0rv9oh6KdPJhcxNH9lafPEJtfsW6qF1bpAfqE
	bJb+JivB9w3QmLUMuChvT/YDOyD4yXy3fLdrO8VLt8rkoLKHgdDfu23lcadDphKokVNXsvwreKq
	hP6/UwCUYSTbwwElbcslIbEgJtLwrJE4=
X-Received: by 2002:a05:6820:f031:b0:663:74e:b642 with SMTP id
 006d021491bc7-679c450d7acmr1357450eaf.66.1771673076978; Sat, 21 Feb 2026
 03:24:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6245770.lOV4Wx5bFT@rafael.j.wysocki> <15658107.tv2OnDr8pf@rafael.j.wysocki>
 <CAPDyKFrgXG5X-y0teE-wVvqaeNepStMN3=0M4zkZs8Kb88U22A@mail.gmail.com>
 <CAJZ5v0iszxD9WV2Nfy9=usmP84Lf0aE9nCxKTBP-B2=zxqnoYw@mail.gmail.com>
 <CAPDyKFqP1pgyv3F+krKsViE96oyYF-O=Q7+bresDf5Okjeh6RA@mail.gmail.com>
 <CAJZ5v0gOAdST7KsTqR6EEK_AQZMf3Ls5mt-Xys2tHbmRoaLAZg@mail.gmail.com> <CAJZ5v0g6c=odyzEv9xitOOT5=QUKGhy_rhcUNe5Vk-Ziudjxtw@mail.gmail.com>
In-Reply-To: <CAJZ5v0g6c=odyzEv9xitOOT5=QUKGhy_rhcUNe5Vk-Ziudjxtw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 21 Feb 2026 12:24:25 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hZBcXH5kHro6KR90RKraManUBS8yCVQhouyiDAY6cc+w@mail.gmail.com>
X-Gm-Features: AaiRm52e95x5LikCcN3y81pIxh0Q6tklKVLTUyhPEiURzCb-bN2JOJgQNlaRVuY
Message-ID: <CAJZ5v0hZBcXH5kHro6KR90RKraManUBS8yCVQhouyiDAY6cc+w@mail.gmail.com>
Subject: Re: [PATCH v1 19/23] pmdomain: imx: gpcv2: Discard pm_runtime_put()
 return value
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Brian Norris <briannorris@chromium.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,chromium.org,kernel.org,pengutronix.de,gmail.com,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42966-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7A1B916CC1D
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 6:23=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Fri, Feb 20, 2026 at 5:58=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > On Fri, Feb 20, 2026 at 5:06=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro=
.org> wrote:
> > >
> > > On Thu, 19 Feb 2026 at 15:07, Rafael J. Wysocki <rafael@kernel.org> w=
rote:
> > > >
> > > > Hi Ulf,
> > > >
> > > > On Sun, Dec 28, 2025 at 4:52=E2=80=AFPM Ulf Hansson <ulf.hansson@li=
naro.org> wrote:
> > > > >
> > > > > On Mon, 22 Dec 2025 at 21:37, Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
> > > > > >
> > > > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > >
> > > > > > Passing pm_runtime_put() return value to the callers is not par=
ticularly
> > > > > > useful.
> > > > > >
> > > > > > Returning an error code from pm_runtime_put() merely means that=
 it has
> > > > > > not queued up a work item to check whether or not the device ca=
n be
> > > > > > suspended and there are many perfectly valid situations in whic=
h that
> > > > > > can happen, like after writing "on" to the devices' runtime PM =
"control"
> > > > > > attribute in sysfs for one example.
> > > > > >
> > > > > > Accordingly, update imx_pgc_domain_suspend() to simply discard =
the
> > > > > > return value of pm_runtime_put() and always return success to t=
he
> > > > > > caller.
> > > > > >
> > > > > > This will facilitate a planned change of the pm_runtime_put() r=
eturn
> > > > > > type to void in the future.
> > > > > >
> > > > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > >
> > > > > Applied for next, thanks!
> > > >
> > > > Since you applied this one, I'm assuming no objections, so I'm goin=
g
> > > > to queue it up separately along with the patch changing
> > > > pm_runtime_put() to void because I would prefer to make that change=
 in
> > > > 7.0 to dragging it for another cycle.
> > > >
> > > > An ACK would be helpful though, I think.
> > >
> > > I was still hoping that Linus was considering to pull my pull-request
> > > for pmdomain, but it seems like that may happen. Assuming that doesn'=
t
> > > change, I can re-base my next branch on Monday to drop $subject patch=
,
> > > but please wait until my confirmation so we don't end up having two
> > > commits in linux-next for the same change.
> >
> > Sure, no problem.
>
> That said, git can cope with merging two branches carrying exactly the
> same patch.  It just creates an empty commit for the second copy
> AFAICS.

A correction on the latter: That's what rebase would do, if I'm not
mistaken.  A merge simply doesn't update files that are already
identical in both parents.

