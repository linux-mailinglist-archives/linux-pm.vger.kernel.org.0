Return-Path: <linux-pm+bounces-42944-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHKaCsKSmGkfJwMAu9opvQ
	(envelope-from <linux-pm+bounces-42944-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 17:58:42 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9180C1698A3
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 17:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 619D5300A51F
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 16:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4F72FF66C;
	Fri, 20 Feb 2026 16:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lU/ak/rm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD891E2614
	for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 16:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771606716; cv=none; b=hjECtA7JYPnTEYCt6Gwsy+Ax52QhaGInqYVCm9wCE2FhGc8+WOdpoCO98XhUT9wEyXPOmFO5dqpzColRSdrwhliJ/LCsnPf+Oo8rwVDcDcczrNRVVzp1hHVLqqkauR3CayW7bSwi/PPPVNjjbf8eTrJ7NdRRiIFw2IBXnx6KusY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771606716; c=relaxed/simple;
	bh=dVbWq8B8TGGuuXVtyYoZ6roF/KgS/29MBmhtrrgjbMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gzOqj9NtFOAyWDxvrX2EWEe6W6ymatbN4LUT8271stAoAPqLNR8CbPh4qoGUKq+W57AS9jmTDaLt5pJ8syWPKdnULbAVq2z/YWSqIGjZdbQ2KT9CTXH7tlFpZtG8Zedk4gIFCbS7o5/fdCXpYTTFZfxeun4ftFBdjAcY+i/8IZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lU/ak/rm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DEBC2BCAF
	for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 16:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771606716;
	bh=dVbWq8B8TGGuuXVtyYoZ6roF/KgS/29MBmhtrrgjbMc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lU/ak/rmmahxCnybMDEJ6LYcAjtTnujn1OHQpelSFqvOmds1tgyWk1Bi5yR4hup/g
	 mHYu03tJjpfnx7X1+uUlVkFjFfNOqUyLCg7m0mCjRk57fnyHNeAztzW30iqcAnThLA
	 WHmVQXUGG3X9kI5WoA4yhv1H8KZRAueFNePCK2hFT/3SA0I/pxF2KZrJgzvSxK5vMi
	 VkwmU/4o1iZYojxra3JqLCn09/rIAICOyp2oa9pYQiTkGvBe4mI5iLNlLO9e7WWOaC
	 H4Tx6aXr0faxuFhDJpOYuJyhO2rKdpFxKaZrwOmvQArA/T1mSD3uj4FWZdo/mx7HJR
	 M5cSy0IFkhShQ==
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d4c9537f90so1498607a34.0
        for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 08:58:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVtdgG831kdxOq/mGsRSOLxWvP0une8fVBIFGLgvkezuWrn/8d6DA0nwYwT+JRGUnyqZ/moEC4E7A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1NwtUo2PCL/fgWWrGyYx76IiOOaD7LZjyMfiqmJzaeBZ+ZCf7
	yp4YhRO0cds4/pZvaEfWVh/ZDrxQc9EtzLlgr3VyrNo9rnxMaVcZy9zVIL27pZ4zkGTp5AutKHB
	FyNRuXFisot+ibFsl0x/91n1x5D7pZHs=
X-Received: by 2002:a05:6830:82a7:b0:7c6:9eac:2385 with SMTP id
 46e09a7af769-7d52be03ca7mr345265a34.5.1771606715463; Fri, 20 Feb 2026
 08:58:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6245770.lOV4Wx5bFT@rafael.j.wysocki> <15658107.tv2OnDr8pf@rafael.j.wysocki>
 <CAPDyKFrgXG5X-y0teE-wVvqaeNepStMN3=0M4zkZs8Kb88U22A@mail.gmail.com>
 <CAJZ5v0iszxD9WV2Nfy9=usmP84Lf0aE9nCxKTBP-B2=zxqnoYw@mail.gmail.com> <CAPDyKFqP1pgyv3F+krKsViE96oyYF-O=Q7+bresDf5Okjeh6RA@mail.gmail.com>
In-Reply-To: <CAPDyKFqP1pgyv3F+krKsViE96oyYF-O=Q7+bresDf5Okjeh6RA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 20 Feb 2026 17:58:23 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gOAdST7KsTqR6EEK_AQZMf3Ls5mt-Xys2tHbmRoaLAZg@mail.gmail.com>
X-Gm-Features: AaiRm533OzOAs4fcbLWCCAQgiua4cghRUlgt5OXDhd4hACmeIn_14e5BRvSEpWg
Message-ID: <CAJZ5v0gOAdST7KsTqR6EEK_AQZMf3Ls5mt-Xys2tHbmRoaLAZg@mail.gmail.com>
Subject: Re: [PATCH v1 19/23] pmdomain: imx: gpcv2: Discard pm_runtime_put()
 return value
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Brian Norris <briannorris@chromium.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,chromium.org,pengutronix.de,gmail.com,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42944-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,linaro.org:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9180C1698A3
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 5:06=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Thu, 19 Feb 2026 at 15:07, Rafael J. Wysocki <rafael@kernel.org> wrote=
:
> >
> > Hi Ulf,
> >
> > On Sun, Dec 28, 2025 at 4:52=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro=
.org> wrote:
> > >
> > > On Mon, 22 Dec 2025 at 21:37, Rafael J. Wysocki <rafael@kernel.org> w=
rote:
> > > >
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > Passing pm_runtime_put() return value to the callers is not particu=
larly
> > > > useful.
> > > >
> > > > Returning an error code from pm_runtime_put() merely means that it =
has
> > > > not queued up a work item to check whether or not the device can be
> > > > suspended and there are many perfectly valid situations in which th=
at
> > > > can happen, like after writing "on" to the devices' runtime PM "con=
trol"
> > > > attribute in sysfs for one example.
> > > >
> > > > Accordingly, update imx_pgc_domain_suspend() to simply discard the
> > > > return value of pm_runtime_put() and always return success to the
> > > > caller.
> > > >
> > > > This will facilitate a planned change of the pm_runtime_put() retur=
n
> > > > type to void in the future.
> > > >
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Applied for next, thanks!
> >
> > Since you applied this one, I'm assuming no objections, so I'm going
> > to queue it up separately along with the patch changing
> > pm_runtime_put() to void because I would prefer to make that change in
> > 7.0 to dragging it for another cycle.
> >
> > An ACK would be helpful though, I think.
>
> I was still hoping that Linus was considering to pull my pull-request
> for pmdomain, but it seems like that may happen. Assuming that doesn't
> change, I can re-base my next branch on Monday to drop $subject patch,
> but please wait until my confirmation so we don't end up having two
> commits in linux-next for the same change.

Sure, no problem.

