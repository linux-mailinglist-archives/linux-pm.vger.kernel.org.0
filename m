Return-Path: <linux-pm+bounces-42941-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MB0J4mGmGnKJQMAu9opvQ
	(envelope-from <linux-pm+bounces-42941-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 17:06:33 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07ACE1692D0
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 17:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 420033082053
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 16:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30672E0412;
	Fri, 20 Feb 2026 16:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m3CaboMo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3354A2DCC13
	for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 16:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771603582; cv=pass; b=c2X73JtMhMp/07zNEfiIMGfcPrdNAny44FxPvMpFXepaeF3DUhZVZKCvlMcssCFIeHAvwzFqpCZGoYW55yAzsUNnCeaWFSA4SDnvXtfX59Y5ozZsHjo77L5PwUju0Geck3RFEV4+LFTw/3j2pw4aFKw4l2oe7An2OCEt4/CL+4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771603582; c=relaxed/simple;
	bh=K3r/uuB9DjtFjtec5JH8int/QbivJw0k9sJjH2QyFnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ENfzRtTo5QDgK6SjRezTJt5EtGgdxoLdABMo45AgNHfZBJyFAS04Br9H8ooHX+w8NEsq2Ouy2Ev0ZV53ueCtuQFBzBueflBgM9vXfZZFLOnUwmj+3gYdb+nKGk5wT/NWseA1I32t3GHYZ5wdtIaJOo006paAbNHB/RmCeuOXU0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m3CaboMo; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-387114fdbedso18056021fa.2
        for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 08:06:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771603578; cv=none;
        d=google.com; s=arc-20240605;
        b=kwOc9HNcyIZ+OFTBLVzfINGNnMMRctYuSJiUvNNqNhvltO0v8rsrHsjBYQZeTyoYYh
         2Pc7Y1m7R+1GYPAmSUKGl3MA/7QZD6ik9C4k9fksEnO+59PW/V4hxFpotOD+XY6weUKW
         zbOti4HKfr2lfTHppRepSzfzX0XsYxJADizv/uSv9R2C1wdFh9sFdAjjyAIuPsYUehP6
         y+r9ePVuMKzVH6psSrOFbZdYapR/0eP0RxViHxgCneagnW/XA/8qjeVwbMWgUFdtoGeV
         YHy5MsZVhBeNTBC8AZ4S5mVuwNhwt7h9S47TzBnRLcvELbG2NP6gPQSfw8cBnGqCS4Ux
         eb2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ea/dIgf/BwX1ubesAWWjAQYYJ/yBsIN9H/BMqEq7CN8=;
        fh=ijTSFwSpwWgALFo/XQ2O6lLS3KDwWhynNdfZ0N34kRY=;
        b=Q5RCTdJYmDzrEbWxYf82cq4rNPXymGBBF170XDTAiFy8GQbx2OQHPTZeW7N6fnkAQt
         hXz7O+Vdg0YgTeoRSj8RmwBAHsmkcaJNN7hhdtQ1Xr8jTJyFbb3la9HB/spJbgc9LhWj
         IPFfs6cMe0rtsrUiOYSGvhsqBi4OBz8oS/PYlHlDrlkzG2mH6er9nns4kIdjA1EniV2s
         LpUsfn7NtRjYkgr+WdldP+rCB3F3HZZH9dTzILciGkWUysNJ2sqybcNKVEArHGL2v8yJ
         JOIfTA7w9A3dAMipqXFOEBgox5814E2N3UcBjuWR0F2suqtD2Kjkp06O4ORglxSPYK0L
         wzEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771603578; x=1772208378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ea/dIgf/BwX1ubesAWWjAQYYJ/yBsIN9H/BMqEq7CN8=;
        b=m3CaboMozmpOufbfLzyLyhiZRWBaM++g05xQ3OGUJ4/pIMYLTpLRRX/FqGZP+WcExe
         MM1Rx5B0v7q5BzNe1myku02ZITHkw9nf1RA8VpprCPj0jMWrSRUxnGJUGyKcDGd/XREs
         Qmlt7Y3XH88ci5Mkrrdw08cHTUPaZZ27R8y8eQ7yAK3+fNxxmkKEw0LF5JyTa8Elf7b7
         lbc8ksopOfzZxFVaGK+A84ZHXRhIJPfIjZZsxot+GsvlrxNGyvdq2heIJLKX3nGdfccn
         9BIIKDVC7TuEG4hJywQuMXjvZOee+h0jqLLLnppnCMRlqNwpKM42HhFfT8VbiaAyhxE4
         xxwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771603578; x=1772208378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ea/dIgf/BwX1ubesAWWjAQYYJ/yBsIN9H/BMqEq7CN8=;
        b=wdzpOqdVeJATsimSMwBsdr3A2I1RbqJ6MHdtMJp/Cg86Amc+DXwlZ2Qh/JPnYG40W8
         BrMOAUqyL0O8tEieC7WbpcYgibvzScupAt7Ng5zD8OMrJ8kU/G2YFPs3KhCi62LVj8rB
         Taq3O5LofQXIPl44VrI9R59hmBYfUaU65JyT+j844LmIRJOZebG0bIyvoJMWmxvLaIEW
         gmIvdBCDlxnxFGYV2QZLj7qJx2UVaZdxfXKuG/cWHeAT6jWX9U27Jx1tIEECsnwuxD/J
         oU6Xzc/Cz2plsczs8fiVRlXY9mL26Bsmcl0Wl+W6r2c7QwA9ROn6OF5ZLMMc8I+AH6U4
         j1Fg==
X-Gm-Message-State: AOJu0YyURwX4vs1Awyd75iBgayudDLWKALAgSFuOUqCTKuy7tL2d7vVM
	vmWpUMNSzY2OLoxpcb3Gjk26uBKqs2+xTUCkYzQ2LtnTItcsRdvokyRbd0gMKjQIG/TCXBkqIIK
	MixPlou9RxgHSJXgVE7CKXGjrrOO1YUjMLjPWowPijg==
X-Gm-Gg: AZuq6aJ0tA9+xID45qbMNyaZkFE+V443MB2LMIYVWr4gzZP1OXW9WoVmGy28jhGJO/R
	VS/ysw5bMVQcM4PeT6aadx7DjY5coSuPIe2iIiEG2UvN+DkaF76Ualhbn1ZjAEePPs1Ux9zehiD
	q5cyQ0+6NSGj4wFb/x9vNIsvE5AgCLtwq7DZx4hwk27wOCB2vZMPx7GP0Lgl9n1TM77U7v8JA0b
	4gjLm8emqRNNN9O3z5ftxhGGYgBox3Qjn70HJDo8I5NmFcUMNZTkLBZyyUYBJhnejv25QKgMSpw
	OEcqwEUO
X-Received: by 2002:ac2:5692:0:b0:59e:1750:ffd2 with SMTP id
 2adb3069b0e04-5a030c1b8cbmr858936e87.36.1771603578271; Fri, 20 Feb 2026
 08:06:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6245770.lOV4Wx5bFT@rafael.j.wysocki> <15658107.tv2OnDr8pf@rafael.j.wysocki>
 <CAPDyKFrgXG5X-y0teE-wVvqaeNepStMN3=0M4zkZs8Kb88U22A@mail.gmail.com> <CAJZ5v0iszxD9WV2Nfy9=usmP84Lf0aE9nCxKTBP-B2=zxqnoYw@mail.gmail.com>
In-Reply-To: <CAJZ5v0iszxD9WV2Nfy9=usmP84Lf0aE9nCxKTBP-B2=zxqnoYw@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 20 Feb 2026 17:05:41 +0100
X-Gm-Features: AaiRm53HxQF1tOkMo5VvypfLHpHjnHoc2QI0G7rk63N_f95cyKTBUJNKPV1R6uE
Message-ID: <CAPDyKFqP1pgyv3F+krKsViE96oyYF-O=Q7+bresDf5Okjeh6RA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,chromium.org,kernel.org,pengutronix.de,gmail.com,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-42941-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 07ACE1692D0
X-Rspamd-Action: no action

On Thu, 19 Feb 2026 at 15:07, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> Hi Ulf,
>
> On Sun, Dec 28, 2025 at 4:52=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> >
> > On Mon, 22 Dec 2025 at 21:37, Rafael J. Wysocki <rafael@kernel.org> wro=
te:
> > >
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Passing pm_runtime_put() return value to the callers is not particula=
rly
> > > useful.
> > >
> > > Returning an error code from pm_runtime_put() merely means that it ha=
s
> > > not queued up a work item to check whether or not the device can be
> > > suspended and there are many perfectly valid situations in which that
> > > can happen, like after writing "on" to the devices' runtime PM "contr=
ol"
> > > attribute in sysfs for one example.
> > >
> > > Accordingly, update imx_pgc_domain_suspend() to simply discard the
> > > return value of pm_runtime_put() and always return success to the
> > > caller.
> > >
> > > This will facilitate a planned change of the pm_runtime_put() return
> > > type to void in the future.
> > >
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Applied for next, thanks!
>
> Since you applied this one, I'm assuming no objections, so I'm going
> to queue it up separately along with the patch changing
> pm_runtime_put() to void because I would prefer to make that change in
> 7.0 to dragging it for another cycle.
>
> An ACK would be helpful though, I think.

I was still hoping that Linus was considering to pull my pull-request
for pmdomain, but it seems like that may happen. Assuming that doesn't
change, I can re-base my next branch on Monday to drop $subject patch,
but please wait until my confirmation so we don't end up having two
commits in linux-next for the same change.

Kind regards
Uffe

>
> > > ---
> > >
> > > This patch is part of a series, but it doesn't depend on anything els=
e
> > > in that series.  The last patch in the series depends on it.
> > >
> > > It can be applied by itself and if you decide to do so, please let me
> > > know.
> > >
> > > Otherwise, an ACK or equivalent will be appreciated, but also the lac=
k
> > > of specific criticism will be eventually regarded as consent.
> > >
> > > ---
> > >  drivers/pmdomain/imx/gpcv2.c |    4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > --- a/drivers/pmdomain/imx/gpcv2.c
> > > +++ b/drivers/pmdomain/imx/gpcv2.c
> > > @@ -1420,7 +1420,9 @@ static int imx_pgc_domain_suspend(struct
> > >
> > >  static int imx_pgc_domain_resume(struct device *dev)
> > >  {
> > > -       return pm_runtime_put(dev);
> > > +       pm_runtime_put(dev);
> > > +
> > > +       return 0;
> > >  }
> > >  #endif
> > >
> > >
> > >
> > >

