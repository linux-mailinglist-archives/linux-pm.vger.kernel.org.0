Return-Path: <linux-pm+bounces-43019-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CyiNjU0nGkKAgQAu9opvQ
	(envelope-from <linux-pm+bounces-43019-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 12:04:21 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 085D0175453
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 12:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 898BD300515B
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 11:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090E33446AF;
	Mon, 23 Feb 2026 11:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xum54nN0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EC93502A4
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 11:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771844655; cv=pass; b=hikkP8Q3UkpK6RpPAjBwUDSUwU7rz9WeEWFZjzc+FXFJ9T98KTcacEq8SA8mqbJKX7mQ39MiqlMamTfDiKvUuoi/2XfQeQnsD9S34kMOfrb+ZoNrpmaULSHLQvqpiNhu2goE1wG0yPzKmEFdzGPPplPQ/KBMSqEq4xA6sZrDKH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771844655; c=relaxed/simple;
	bh=eHhGlHIE8dk1noerspRaa17UDGSM1U9oKZlnCB8Kea0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nO+6F9ItK+H7oVVoY4j7YNgLSdSeIk1nnYbU2/stnU6MTMb5sMd74Gp+3eyKgAqxYZDWGEt5H8y2Syj+0FUb+ntXgv9ptsteFvCoWLv7TNQ27uk6TGKHg71uPQrJJoVpp1s5NU/g3hUNL4T+0FV+y9zvtJK1TpIued2qUNOF2ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xum54nN0; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59e6c181402so5304267e87.3
        for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 03:04:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771844652; cv=none;
        d=google.com; s=arc-20240605;
        b=R+6S2l/VHb9IIUuv3cR9imMPvq+MhXvpksCfFWuXva/jbOLQA7FWTWBPe1qx8aj9vf
         eMZbNzXLDPRjNHKGqaZymWsmLYmzXvHpuHxcUQwrQQbvC5HYfP/6JKn+fgza3X0NNn+F
         AyxO026QG4r50vyZKXlrst4C9dBAF4yMAoklqjLxRcGNR1vSTDI7jTxfTuyq/WgUs39T
         U7cjmuCNYqYLQpwT/tIjoBgemWoFAWbJ7e7+YKsFQFyBO/Bl9bR2Zp+zxTHUg9NGVH8i
         bZvyE/pVircIVHoCXC4xqIOKxtrtKbO/ao0vsf22GHJ3e3/747qgq7c5inKLHAPJGxwS
         bm/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eHhGlHIE8dk1noerspRaa17UDGSM1U9oKZlnCB8Kea0=;
        fh=ijTSFwSpwWgALFo/XQ2O6lLS3KDwWhynNdfZ0N34kRY=;
        b=hSr2bmAsYo6zuyP/v9N2elhVk4f4f7CwpQgQxNzjBMArUZ23NIqMedPf2xNFPx4esh
         1uJ6skmODu6R9qESpijE1CG1jCiKHTwobsKli9zJnJTeB123DWKcc1YfXr4YxMP4MH8U
         uYu01FuOiAGzfFhxunlC/c4a1maB9zbjvUdoMsF+UPA2Nc70/HP79pJaGOVXEU2/Z7mo
         jdx3BwCS2KnDTTenJDVlLvi9N587+QHYx/lVF1diAGKP6koCAcDuQ/mrKhbvER/nsrPm
         qnpVDwoY1mEXJ8/i9FzR5RpjPhlCse1OsQBZZgLkSV7CdTrLgAGoFRTnMK5P1U9ST7WF
         UG1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771844652; x=1772449452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHhGlHIE8dk1noerspRaa17UDGSM1U9oKZlnCB8Kea0=;
        b=Xum54nN0icmaLMWztbFJdt5S4XPUzOzhm/SnawkAp9g0GpxVxcedEBtQDPspOz8M01
         K0/CFSpY75tM30JGKDbfPZRBUBfwLUIiaBUcqbktVi64y0nMf/AwHwrTnRYj6ORdeHMS
         sLViTJb2qstsFAj58wqCk/EnHvYxK5joRYFqnbjutviJO7668PY0jGtJT3IDMisGXLGs
         440BkzwJniyTBxjYLFe/KsGKkMxRbEW8CT/UtZi8afLCthMnv6vDf2hwJOshi2d+6PYA
         kxo7H0uHXn9xfUrDfofq17nGXtLYmFnbCs9Ue4484ZEgH0vv3Qo0s66x3Dv3vt62Xw34
         vPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771844652; x=1772449452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eHhGlHIE8dk1noerspRaa17UDGSM1U9oKZlnCB8Kea0=;
        b=piH44fwXYFWNVHbD8bAAkaq+gqM/gL3VYKCVjlJGn/3Q7Ktr4oBB4uqzBUIeAkAj/4
         T7cKuTIc4rqsMbnV8/ZwlZfan/A0O8950ZKp7h/92PQwQG0xmrB7rwx8fw9Mza0Sfse0
         Kamng2ajZ+MFrLWDy8MkU3P0LBbxECaC2vTLhCRHjIu1ghDfMJfU3pUGpL0Gf/c2Th8k
         n0Un/0fwgA5xkhoLJLsfVfFFOuamJzkvx9bNMr4e6Jt+8w6MwPTnzW7qdqAUSDDIse12
         74Odobh6Mc/+hPtrIa72hf9OSai0/uzFHIW7MFu7kk3X235auS2gdrxc0S1Jsh3zjFw8
         wfGg==
X-Gm-Message-State: AOJu0Yy6ZPewzan5uzgXW7mjjZc9ZCRwqhCDmp1LDHfLUzkpFKHJWjBq
	408rDBYWVj9NhAD37OY6GOz2l2EMY+DelJwVSkaImqYvIQln1OscWQbpeTGciG4yObTAsrbsOFT
	ICHK/GDFkbHlV1LGuTTPQU3HmONhQVYvvfI4XF0rDIA==
X-Gm-Gg: AZuq6aLbyccXdafYXmXxgapwy98jagWA6GifHKOSfPQGACGb9lzA2kSlCQZ4rQ1Zxjv
	589EeIyWKYuGNZO73NVgC+v6F6DYNVRrHOz61tmlFnOWevQK1t5vWNeEe5c90dqa7KllbyqWmgA
	9nngIlutAtGNzVNtsjx111WxREPN55SCe+BUfUGAL2dIn5esiW3gpkDwRX2HGUXhquJXiX0Q8jz
	7Ce5kkkXgSCaFLQE/YCdFzZADXV8ijifsYxNpjdn2JwHMiw0c+0cRbsm/qhrSzFy1zANnDzFuRB
	Gd0Pu5LO
X-Received: by 2002:a05:6512:b91:b0:59e:644a:a857 with SMTP id
 2adb3069b0e04-5a0ed87eafcmr2670972e87.19.1771844652052; Mon, 23 Feb 2026
 03:04:12 -0800 (PST)
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
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 23 Feb 2026 12:03:36 +0100
X-Gm-Features: AaiRm52R8LE_YX0oCaW_kTHlvd9-w1M2jGyQBTYrFVjg6DoIy_zAZaLZv4IWOKc
Message-ID: <CAPDyKFr6YdQ4nHD8RcGQpTdqKH7CszEd23YzF-o-TUVETBaG6w@mail.gmail.com>
Subject: Re: [PATCH v1 19/23] pmdomain: imx: gpcv2: Discard pm_runtime_put()
 return value
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Brian Norris <briannorris@chromium.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,chromium.org,kernel.org,pengutronix.de,gmail.com,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-43019-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linaro.org:email,linaro.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 085D0175453
X-Rspamd-Action: no action

On Fri, 20 Feb 2026 at 17:58, Rafael J. Wysocki <rafael@kernel.org> wrote:
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

I have updated my next branch and dropped the $subject patch from it.
Please add my ack when applying.

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

