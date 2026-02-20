Return-Path: <linux-pm+bounces-42945-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJG2ObKYmGlaJwMAu9opvQ
	(envelope-from <linux-pm+bounces-42945-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 18:24:02 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 469C1169AF9
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 18:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F4B1302BE01
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 17:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7AA32ABC3;
	Fri, 20 Feb 2026 17:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rck8pKVB"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF022E7BB4
	for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 17:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771608238; cv=none; b=sm9Cuf68XJzypflQG4JoCRirei7LAzFQ+aOcb+I/0A6rHo3vI4YPcA6EpE3YnqTyuJ45cvIRcTJ7/iukfS1sQg75tsUNXT/7srZpgcpbO+okQ43KC9S2o9NlQIMB0vLWMu/D41Kb31L2BEP8D8xOlvaqmgwMCF9M0S3pwjZyDI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771608238; c=relaxed/simple;
	bh=Mg0he7rTdYAnNUNIKLOI2u8YdkNCJER4UeQ52s56cm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iDdfeHv+eqGskzy9436xi7cdadR1JrSaQXJXyXwhVlmyEc/CYfRNVF6BjZFzHbQAPxsNVlfAOg04XlrQuHC7LFkr1+EpCLXvfNHCGhJrA1KXf4jJrj0O6RnUDLwUcM8bJ+iZTd8TPdgnjThtk/IZjxIwRFGrRZibEEC1xhlpuV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rck8pKVB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 942BEC116C6
	for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 17:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771608237;
	bh=Mg0he7rTdYAnNUNIKLOI2u8YdkNCJER4UeQ52s56cm4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rck8pKVB7cftJzsFqe9QBAb9PIE8XjbbeZ3d+VGGVBUWwslTzpA4FFpiLPxmRNiuu
	 QyFHmyaNQaEoTrplAgxTcfTV/cI0PKKfEK+SP/z+LKQVWaHq9RUYp/IF4GNQ3cIXGa
	 NXzminlGHlxXYjcmaXaei/UJlj+8yeSyLrUbYeX4DG+E/artH80SYVlj4jLjF6FMNT
	 9oiXEo2069rfgUVhS/N7CuSBu5z09XMPyQfy1fRofFErQu4Z+7fmJyQANba2RuT3Im
	 KW5LSAl9SiCCjYqeDNzUg4A9KRYCQRRgxny/H5nQQE3UPS5MLay2CI0jIqT8SwWpPs
	 hOnNmURhykSQA==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-40438e0cba6so1508446fac.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 09:23:57 -0800 (PST)
X-Gm-Message-State: AOJu0YwbGqkWI2VJ9wTrohpvGYwcmzOLOh5qJAag6mYXNjqCvUhyKqnc
	iBVmqW4uQ8BylCNt6Yu+mnQjA8S+yPaMy+Arh1N36nHyYOvBSIlSWEYMUIoIVTLTEaYRvIPWeug
	V6DRNa17WTEI8p3l+iCoN2AvHnMLeJqk=
X-Received: by 2002:a05:6820:189a:b0:676:da74:842e with SMTP id
 006d021491bc7-679c464eea7mr303005eaf.72.1771608236672; Fri, 20 Feb 2026
 09:23:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6245770.lOV4Wx5bFT@rafael.j.wysocki> <15658107.tv2OnDr8pf@rafael.j.wysocki>
 <CAPDyKFrgXG5X-y0teE-wVvqaeNepStMN3=0M4zkZs8Kb88U22A@mail.gmail.com>
 <CAJZ5v0iszxD9WV2Nfy9=usmP84Lf0aE9nCxKTBP-B2=zxqnoYw@mail.gmail.com>
 <CAPDyKFqP1pgyv3F+krKsViE96oyYF-O=Q7+bresDf5Okjeh6RA@mail.gmail.com> <CAJZ5v0gOAdST7KsTqR6EEK_AQZMf3Ls5mt-Xys2tHbmRoaLAZg@mail.gmail.com>
In-Reply-To: <CAJZ5v0gOAdST7KsTqR6EEK_AQZMf3Ls5mt-Xys2tHbmRoaLAZg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 20 Feb 2026 18:23:45 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g6c=odyzEv9xitOOT5=QUKGhy_rhcUNe5Vk-Ziudjxtw@mail.gmail.com>
X-Gm-Features: AaiRm50fS1AdfTHgvXxqsYty7wm2zENtxzrdNJVERBXECSwO0isV_Aq8CrZT89A
Message-ID: <CAJZ5v0g6c=odyzEv9xitOOT5=QUKGhy_rhcUNe5Vk-Ziudjxtw@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,chromium.org,kernel.org,pengutronix.de,gmail.com,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42945-lists,linux-pm=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,intel.com:email,linaro.org:email]
X-Rspamd-Queue-Id: 469C1169AF9
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 5:58=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Fri, Feb 20, 2026 at 5:06=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> >
> > On Thu, 19 Feb 2026 at 15:07, Rafael J. Wysocki <rafael@kernel.org> wro=
te:
> > >
> > > Hi Ulf,
> > >
> > > On Sun, Dec 28, 2025 at 4:52=E2=80=AFPM Ulf Hansson <ulf.hansson@lina=
ro.org> wrote:
> > > >
> > > > On Mon, 22 Dec 2025 at 21:37, Rafael J. Wysocki <rafael@kernel.org>=
 wrote:
> > > > >
> > > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > >
> > > > > Passing pm_runtime_put() return value to the callers is not parti=
cularly
> > > > > useful.
> > > > >
> > > > > Returning an error code from pm_runtime_put() merely means that i=
t has
> > > > > not queued up a work item to check whether or not the device can =
be
> > > > > suspended and there are many perfectly valid situations in which =
that
> > > > > can happen, like after writing "on" to the devices' runtime PM "c=
ontrol"
> > > > > attribute in sysfs for one example.
> > > > >
> > > > > Accordingly, update imx_pgc_domain_suspend() to simply discard th=
e
> > > > > return value of pm_runtime_put() and always return success to the
> > > > > caller.
> > > > >
> > > > > This will facilitate a planned change of the pm_runtime_put() ret=
urn
> > > > > type to void in the future.
> > > > >
> > > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > Applied for next, thanks!
> > >
> > > Since you applied this one, I'm assuming no objections, so I'm going
> > > to queue it up separately along with the patch changing
> > > pm_runtime_put() to void because I would prefer to make that change i=
n
> > > 7.0 to dragging it for another cycle.
> > >
> > > An ACK would be helpful though, I think.
> >
> > I was still hoping that Linus was considering to pull my pull-request
> > for pmdomain, but it seems like that may happen. Assuming that doesn't
> > change, I can re-base my next branch on Monday to drop $subject patch,
> > but please wait until my confirmation so we don't end up having two
> > commits in linux-next for the same change.
>
> Sure, no problem.

That said, git can cope with merging two branches carrying exactly the
same patch.  It just creates an empty commit for the second copy
AFAICS.

