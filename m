Return-Path: <linux-pm+bounces-43035-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kP33H6pQnGktDwQAu9opvQ
	(envelope-from <linux-pm+bounces-43035-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 14:05:46 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D12751768A0
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 14:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B509300A627
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 13:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41E72BE03B;
	Mon, 23 Feb 2026 13:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUcIpGAq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811FB13DDAE
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 13:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771851821; cv=none; b=O4TRk2JcR9ofu2fT6hYWLuIUJn9VB764zQ7bGMlRWEK4cBkbMibrEuxnostpE9LazK+ypzsIzhscoWmNlpWmniNz4xI03o9livlg0IuFrUzBp4LEuAnFDAKLejmf5lPEyr6kHgNaM/87sglB+G7BBHU+Klmo6KUXX0EKWva/90I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771851821; c=relaxed/simple;
	bh=B2UErQOEwxaQ5IbCLr5XWExQGBw2GSEK9KtGqxc7fgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cKGXJtsuHcHu1SiIMwHyAqUpuSajHeuCw0KY5vxmA0sNi5a5wRyWGw3Xx1nFlF0lXR4OSinSTPQzdT5pDtW1ofN4P1llpKEW1i+7a/IkbA4So+nedsIJiueS09nTrTm2EinMlbMDtINjqZPsov2fIcTNTK4sMk7HQrBQM0oC3k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUcIpGAq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42EA1C116D0
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 13:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771851821;
	bh=B2UErQOEwxaQ5IbCLr5XWExQGBw2GSEK9KtGqxc7fgY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HUcIpGAq+sjNn/KX7PmSMRev7HMjqD3GK+1Oiy6e0pXqT8TzTk/4mn7AtRH6HxTug
	 cXHgjxrRlQKaWyeDcnx9lyuH3zqED8yLZsS5pY+iqOA4tvMUdUzgrpHZ+fdTJJLwer
	 92pbp/uJI7pMPW8qjh055AJ+057MQcQm+oOkpQfTpwIXv3wQh+L4S+IhIoQuQxVKGD
	 pk5SlJhgSuk6OUES7KU0mVnRpj5YBQm9jQAY60luJijWiXkv/30NGxbNsVABXoJxDf
	 YHTjXWaqpDCdtQWHFj6an0IUIY4JBZnrCK6jZ5KY2+d7U34+Qh5/zQLvk7diCwycEq
	 0tZDR7I00Y0Sw==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-45f053b7b90so2794388b6e.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 05:03:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXthHkcGX033QpEmXQhAfctCj3MhLtloW0uLVxcIjY85QMAXN02M6X064X2mupRw/9piocLrBXIGA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQv2JY2PUZa9gmWENV1IJZotwPQylX+D+lbbaS97jIFmRbRNic
	TXZaSK+g/MaZqkXsad4TD+Yp4BhfxMo5L2ex2TeAmEpA4qFzghoFgHh+89x3tJwO6d5EPAkaq80
	OIn93gmAFsqkXbS4Vrl6gNyTsL/oTj9M=
X-Received: by 2002:a05:6808:1187:b0:45f:16d1:8f52 with SMTP id
 5614622812f47-464461fd8fcmr4665069b6e.27.1771851820365; Mon, 23 Feb 2026
 05:03:40 -0800 (PST)
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
 <CAJZ5v0gOAdST7KsTqR6EEK_AQZMf3Ls5mt-Xys2tHbmRoaLAZg@mail.gmail.com> <CAPDyKFr6YdQ4nHD8RcGQpTdqKH7CszEd23YzF-o-TUVETBaG6w@mail.gmail.com>
In-Reply-To: <CAPDyKFr6YdQ4nHD8RcGQpTdqKH7CszEd23YzF-o-TUVETBaG6w@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 23 Feb 2026 14:03:28 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j920aybTFtuQypeorDY+13ZY6GoZVQyFc9xMNuM6iV9A@mail.gmail.com>
X-Gm-Features: AaiRm53u6VNQZ87lI43bhqydkI5FvW2LICTVi9snIAIeufiemlbFcIdcRN5_9g4
Message-ID: <CAJZ5v0j920aybTFtuQypeorDY+13ZY6GoZVQyFc9xMNuM6iV9A@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,chromium.org,pengutronix.de,gmail.com,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43035-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: D12751768A0
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 12:04=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
>
> On Fri, 20 Feb 2026 at 17:58, Rafael J. Wysocki <rafael@kernel.org> wrote=
:
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
> I have updated my next branch and dropped the $subject patch from it.
> Please add my ack when applying.
>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks!

