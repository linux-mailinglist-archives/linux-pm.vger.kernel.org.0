Return-Path: <linux-pm+bounces-42521-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yugFLkHfjGn6uQAAu9opvQ
	(envelope-from <linux-pm+bounces-42521-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 20:57:53 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F861274A0
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 20:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 77C3730054D9
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 19:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF2F242D83;
	Wed, 11 Feb 2026 19:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7p8nLio"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAD3224F3
	for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2026 19:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770839871; cv=none; b=QcEz/1XB6S3v6HPgGETD7k/3ouGSFyGwyCZWvn+XnBqnijBqm1pxG0+nLlvMwB9UpRQ7V/7WdlYu5YpCwGOAIm6B75dTWIr5k77YwQ2wrwFCWM1Ez3fINKgkVNdHT9zwvGmMPkyAOEFIEd1ZIUw2FYa7vPOmjkTlnVmb1AZlZig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770839871; c=relaxed/simple;
	bh=4GKinBMsVgfi+XdDro9UIl9mWDA3ZS2WSlog2Hx5E0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nYJnFttAA9kJxR6+lSR5W908pwTSdSqtO5xnAhxZ+GZGa0jiBib+sj/sLzj/L8sqMN0QHWn5n2vHYCdzQCAlcxYOyFxFUZRTADcO8Fb1bM7HDuOCSvqZMyMZyMqCVGIkUWLmjKjSE8af8mWDs9B9lBwyCLy3i+5/WiQdKrji+mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7p8nLio; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9A8C2BC86
	for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2026 19:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770839870;
	bh=4GKinBMsVgfi+XdDro9UIl9mWDA3ZS2WSlog2Hx5E0w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=r7p8nLiol3yx4oivyb+h7BgkdNS8Ed8QF+npKF2LrEEQvlulPFID+aZ6bGIwiq1HJ
	 W4lvLH2Fpvn18qd45CkON+eJYqSKTHSwHLbBqZbX/baqf4QHNqKoQ9tdsZEipnl41R
	 3rMnANZTqah0yOkT1R3lqrzHNPoQ4KmSjVyno9u+RiiQF7dI89AaVWOcd4ZbRWFTE/
	 WDjHtkXWOZzodzdL41tdp0NTO42kyCSXCIgnaqAXvtXAk+zHOt0D7lV+aQ/hYMA0uc
	 wP28p9/hNTyGHen2z4dd0Ha2Qm1u69VvT5ylGUkKCdkVKuySMhzgL3vlPdi+YKLxiA
	 CwYxZX/ituySg==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-4042f55de3aso967368fac.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2026 11:57:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX3cjWNQV7QtfdKyuA8lpQvupp26Lnqjfv7QNrvIw9t693sontS7LENmuR3F03G71jPzhh9CD6PyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPTMKPio9St49xgQAvH7DcZvY7gku86+rTWEgOdXLle1WbesFT
	gvOeV1EgI7IzGf0GUtdMi+mGWw3Rd/ekh+I5NBUWMxBT29UTDD4p2bX1j3d/SbhI40DdBFJ3YnM
	sOR0QWANP0tPI/AHe0Knl/gBsgjzgTTM=
X-Received: by 2002:a05:6871:8402:b0:409:571c:6d90 with SMTP id
 586e51a60fabf-40ec84953ebmr130159fac.0.1770839869940; Wed, 11 Feb 2026
 11:57:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215054538.3483331-1-kaushlendra.kumar@intel.com>
 <LV3PR11MB876881B77D32A2854AD2908EF563A@LV3PR11MB8768.namprd11.prod.outlook.com>
 <2027fb09d9966e9877dc9fee3027ba77dd298bc3.camel@linux.intel.com>
In-Reply-To: <2027fb09d9966e9877dc9fee3027ba77dd298bc3.camel@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 11 Feb 2026 20:57:38 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gtaZVjPGRz6-_szbr5oR1vpqn9rGhAF3xO592MFuN38w@mail.gmail.com>
X-Gm-Features: AZwV_Qg_AXMNne1KbGHxSdf0GqRTdzQJt67Gmz6vDTR9GDq1Kh8XSNVhs5tP6gQ
Message-ID: <CAJZ5v0gtaZVjPGRz6-_szbr5oR1vpqn9rGhAF3xO592MFuN38w@mail.gmail.com>
Subject: Re: [RESEND, Cc only] RE: [PATCH] thermal: int340x: Fix sysfs group
 leak on DLVR registration failure
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>, 
	"Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
Cc: "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "Zhang, Rui" <rui.zhang@intel.com>, 
	"lukasz.luba@arm.com" <lukasz.luba@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42521-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,linaro.org:email,mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 51F861274A0
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 8:32=E2=80=AFPM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Wed, 2026-02-11 at 08:23 +0000, Kumar, Kaushlendra wrote:
> > Adding Cc: srinivas.pandruvada@linux.intel.com
> >
> > No code changes.
> >
> > Original patch:
> > https://patchwork.kernel.org/project/linux-pm/patch/20251215054538.3483=
331-1-kaushlendra.kumar@intel.com/
> >
> > -----Original Message-----
> > From: Kumar, Kaushlendra <kaushlendra.kumar@intel.com>
> > Sent: Monday, December 15, 2025 11:16 AM
> > To: rafael@kernel.org; daniel.lezcano@linaro.org; Zhang, Rui
> > <rui.zhang@intel.com>; lukasz.luba@arm.com
> > Cc: linux-pm@vger.kernel.org; Kumar, Kaushlendra
> > <kaushlendra.kumar@intel.com>
> > Subject: [PATCH] thermal: int340x: Fix sysfs group leak on DLVR
> > registration failure
> >
> > When DLVR sysfs group creation fails in proc_thermal_rfim_add(), the
> > function returns immediately without cleaning up the FIVR group that
> > may have been created earlier.
> >
> > Add proper error unwinding to remove the FIVR group before returning
> > failure.
> >
> > Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Applied as 7.0-rc material, thanks!

> > ---
> >  .../thermal/intel/int340x_thermal/processor_thermal_rfim.c   | 5
> > ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git
> > a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
> > b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
> > index 589a3a71f0c4..ba88d878c998 100644
> > --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
> > +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
> > @@ -466,8 +466,11 @@ int proc_thermal_rfim_add(struct pci_dev *pdev,
> > struct proc_thermal_device *proc
> >                       break;
> >               }
> >               ret =3D sysfs_create_group(&pdev->dev.kobj,
> > &dlvr_attribute_group);
> > -             if (ret)
> > +             if (ret) {
> > +                     if (proc_priv->mmio_feature_mask &
> > PROC_THERMAL_FEATURE_FIVR)
> > +                             sysfs_remove_group(&pdev->dev.kobj,
> > &fivr_attribute_group);
> >                       return ret;
> > +             }
> >       }
> >
> >       if (proc_priv->mmio_feature_mask &
> > PROC_THERMAL_FEATURE_DVFS) {
> > --
> > 2.34.1
>

