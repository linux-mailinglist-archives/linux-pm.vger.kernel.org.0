Return-Path: <linux-pm+bounces-42871-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCqUKScZl2nKugIAu9opvQ
	(envelope-from <linux-pm+bounces-42871-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 15:07:35 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F06615F550
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 15:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BE2DE3012D20
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 14:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B6F33E37C;
	Thu, 19 Feb 2026 14:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgPhwmdp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7163133E36A
	for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2026 14:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771510045; cv=none; b=lHVQSN+WMKVT/G2SetUXX819d0SlW4CC2rnXYuR0GtsFoesP4SQxLQKEBSNNvBSyQeqwwz8DrsCi8A9khZwEmheT8LyefAeNO/U/lGlDV0dvt/KxeBcEQvU4WbEALiwD+2t/3YCMriCx1YsTow3+dpaR2qKCdu2oDg4FzY4ZMGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771510045; c=relaxed/simple;
	bh=BhKiqyJ6EJWSjh4jVat8ovRU5iPqFxU3OwH85XadMxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m7Z7eLIezYlTXZV8bR3fLQYpZRRqhVFugMuQ3KrqA773yqmjjt3jYHkouqRrCUAkb1UTGBT8MwFgdEyIS/gy7UxB3oFp7ol4kMk7Yq0F1C97qm2xSfTAvIlP2NVuImwAEwE88OAE4BRbNtsJmUvN0u/dVnpVoy/SLwwe9aIdLu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgPhwmdp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2567BC2BC86
	for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2026 14:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771510045;
	bh=BhKiqyJ6EJWSjh4jVat8ovRU5iPqFxU3OwH85XadMxQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OgPhwmdpVRrqLJiv4WzaNx0b8yD7y5aAaMxqbJ8yoDYZ7GF59pqff/shnyKaiWj8H
	 gMxmDGpcBnV7TvhTf9O8j/ogTNnT5TwXYg4X3y8bBMRzfOlDS3lE/vFzEicD3oHlmi
	 kGCndBFvBpY31JeNS3nk+89pM+ZUZLbpViigLC2dtVQ0Ac+Z1u0RMSKFPhjBkWnrZN
	 IwBfdCiXfa6/5p9shcmrqPn9H6ozJuQ5yFJkrFA5iFJDbptlm0njvexj9vWwpQXb+g
	 edZUrZlQMVjK6r2PMeRTyODJkUlYZl8wpb7ubpDaATjajgH00NaQo1z4akO58mMjU7
	 FU5c6AxAGDPGA==
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d18d0e6d71so666816a34.1
        for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2026 06:07:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVrKanW15z1tm+2Cwk6Mu6rHQKtn+hMxC6XKJdih4vXdrHclP4woAEXwdDvrC2IprFaSaatO6jIZw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwP3jZg4zssPiTo8CkOr4CX16uc2lsCrT+UD7eksZ0SPn2Duhkb
	JaGHgJPBisQneltL2BSa9+sWPW1c7rdCXOpdqzIxf2ORqQudqWhxsU3I5pqbRcGK/+1g2fD9sgR
	Eo8vd4x7owLscK/G0EwtN0FJlcB6sdjk=
X-Received: by 2002:a05:6830:6731:b0:7cf:dd63:3d37 with SMTP id
 46e09a7af769-7d4d0c157aamr10462955a34.25.1771510044245; Thu, 19 Feb 2026
 06:07:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6245770.lOV4Wx5bFT@rafael.j.wysocki> <15658107.tv2OnDr8pf@rafael.j.wysocki>
 <CAPDyKFrgXG5X-y0teE-wVvqaeNepStMN3=0M4zkZs8Kb88U22A@mail.gmail.com>
In-Reply-To: <CAPDyKFrgXG5X-y0teE-wVvqaeNepStMN3=0M4zkZs8Kb88U22A@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 19 Feb 2026 15:07:12 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iszxD9WV2Nfy9=usmP84Lf0aE9nCxKTBP-B2=zxqnoYw@mail.gmail.com>
X-Gm-Features: AaiRm53FoRyksoC3ttmMeeO-C_4cEWcICXgpEzx69kDkXZMWQSWAxIdRecIS3b0
Message-ID: <CAJZ5v0iszxD9WV2Nfy9=usmP84Lf0aE9nCxKTBP-B2=zxqnoYw@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,chromium.org,pengutronix.de,gmail.com,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42871-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,intel.com:email,linaro.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3F06615F550
X-Rspamd-Action: no action

Hi Ulf,

On Sun, Dec 28, 2025 at 4:52=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Mon, 22 Dec 2025 at 21:37, Rafael J. Wysocki <rafael@kernel.org> wrote=
:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Passing pm_runtime_put() return value to the callers is not particularl=
y
> > useful.
> >
> > Returning an error code from pm_runtime_put() merely means that it has
> > not queued up a work item to check whether or not the device can be
> > suspended and there are many perfectly valid situations in which that
> > can happen, like after writing "on" to the devices' runtime PM "control=
"
> > attribute in sysfs for one example.
> >
> > Accordingly, update imx_pgc_domain_suspend() to simply discard the
> > return value of pm_runtime_put() and always return success to the
> > caller.
> >
> > This will facilitate a planned change of the pm_runtime_put() return
> > type to void in the future.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Applied for next, thanks!

Since you applied this one, I'm assuming no objections, so I'm going
to queue it up separately along with the patch changing
pm_runtime_put() to void because I would prefer to make that change in
7.0 to dragging it for another cycle.

An ACK would be helpful though, I think.

> > ---
> >
> > This patch is part of a series, but it doesn't depend on anything else
> > in that series.  The last patch in the series depends on it.
> >
> > It can be applied by itself and if you decide to do so, please let me
> > know.
> >
> > Otherwise, an ACK or equivalent will be appreciated, but also the lack
> > of specific criticism will be eventually regarded as consent.
> >
> > ---
> >  drivers/pmdomain/imx/gpcv2.c |    4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > --- a/drivers/pmdomain/imx/gpcv2.c
> > +++ b/drivers/pmdomain/imx/gpcv2.c
> > @@ -1420,7 +1420,9 @@ static int imx_pgc_domain_suspend(struct
> >
> >  static int imx_pgc_domain_resume(struct device *dev)
> >  {
> > -       return pm_runtime_put(dev);
> > +       pm_runtime_put(dev);
> > +
> > +       return 0;
> >  }
> >  #endif
> >
> >
> >
> >

