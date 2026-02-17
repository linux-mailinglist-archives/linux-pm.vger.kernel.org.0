Return-Path: <linux-pm+bounces-42758-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCAIAhCBlGniFAIAu9opvQ
	(envelope-from <linux-pm+bounces-42758-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 15:54:08 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 109C814D51D
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 15:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AA2F53004CAE
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 14:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6867636B07F;
	Tue, 17 Feb 2026 14:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYmxjIRi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459BF35502F
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 14:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771340042; cv=none; b=AGYAQIym1rDcULd0FxOMk+m6heUN1/eiudQTwcDVQeIrY7E/jms+ApURXq3Ir8nAN+7Geuk1XX/1MpcXq8JZfbcRi0ctqLd8Ag4C1s0YCDqsY6RiJCqtmk4AqBbEL340ZSL6Rg4RNAZuDkp7A+mIRqYGGm+lPnnbqjvH7tWxaO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771340042; c=relaxed/simple;
	bh=rVTcdXtGhlQQuPkN3nuK5cTVcDB6cpF5dip9SaKu9/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a9AGrZf2rdjImiM0FrR9K7XYL8eDbAx/SCcmbR4N6C3K2/SWo1Rrm07dfHOfaFtwOaNBC3yR6VAkyST/dMLSCnX68JrDv5sAz6FfDb5sZKcvvvfLbCtGa/mkNM1BLVLIuJ7E42JkzyiCii/LmdGs+L1YUZcTTjucxJUgKJCbSPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYmxjIRi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF135C2BC9E
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 14:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771340042;
	bh=rVTcdXtGhlQQuPkN3nuK5cTVcDB6cpF5dip9SaKu9/w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JYmxjIRiWQYoaOlSYudb6nz6UwS8rHe/s4UDvmzTbN8fnF1urkOsyNUIHODiHDS2y
	 pqaqa9zOpBSenftVv5OmFpr2LwHRwWjniHhPzidd8aiOKjI07iBS1kziBhran3qTJW
	 lnG5hIdxtHq1eDcYw3b0qX3hGHj/XnTGGc61Lunnzzwaypdbt0mR2lIMZy+oWoVZxl
	 0af3E30NyoWJ6DzKPMbXgzHbo2i8PcpRox+hfDV3unltLWa3iq9QH/yZP2XZQE5Qms
	 xATjtcvZd6is8kY3dwdSYbUqujuGt50HG/7ICL3xIRzFo5qdLuazsux27F7eq504o1
	 cT9yrua7WJDkA==
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-45f126d47b8so2737969b6e.2
        for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 06:54:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWmPf5h7VruW+t8jqQKLY/bP1ZbElkGzplPqUIEnid3+ONQRyYNZrrXAXVbKUpk0ePoz83FEcGe9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZg/Eiy5KS3AEh5PsXzxzWaRKi7M8UAvrieWkTLSJSO2VQkljH
	kIBS06j+fPWhimGmD1JdVF06z8fsaYW2Ky8k3rfoBWO33s8Q3edzh+y0/GGCTHrdE2RrojDHuLf
	BxBufTuLD2hIcVSbm/uxWzkZQOZUhH2E=
X-Received: by 2002:a05:6808:1a25:b0:450:ca65:ef60 with SMTP id
 5614622812f47-463b40dac1emr5369347b6e.39.1771340041080; Tue, 17 Feb 2026
 06:54:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216185005.1131593-1-aboorvad@linux.ibm.com>
 <20260216185005.1131593-2-aboorvad@linux.ibm.com> <042f57b8-b027-4dee-ac8c-6c6efc34d427@arm.com>
In-Reply-To: <042f57b8-b027-4dee-ac8c-6c6efc34d427@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 17 Feb 2026 15:53:50 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gVVzBx7fGf9rVS=NavvHL4ZCCvFSGnycn3U6jb+owOCw@mail.gmail.com>
X-Gm-Features: AaiRm52CtmkbPAgR248r1IYiXisrcdmPNCj569TpfiJE_bw0qU3GImE9p86jrtA
Message-ID: <CAJZ5v0gVVzBx7fGf9rVS=NavvHL4ZCCvFSGnycn3U6jb+owOCw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] cpuidle: Skip governor when only one idle state is available
To: Christian Loehle <christian.loehle@arm.com>, Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42758-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 109C814D51D
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 3:36=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 2/16/26 18:50, Aboorva Devarajan wrote:
> > On certain platforms (PowerNV systems without a power-mgt DT node),
> > cpuidle may register only a single idle state. In cases where that
> > single state is a polling state (state 0), the ladder governor may
> > incorrectly treat state 1 as the first usable state and pass an
> > out-of-bounds index. This can lead to a NULL enter callback being
> > invoked, ultimately resulting in a system crash.
> >
> > [   13.342636] cpuidle-powernv : Only Snooze is available
> > [   13.351854] Faulting instruction address: 0x00000000
> > [   13.376489] NIP [0000000000000000] 0x0
> > [   13.378351] LR  [c000000001e01974] cpuidle_enter_state+0x2c4/0x668
> >
> > Fix this by adding a bail-out in cpuidle_select() that returns state 0
> > directly when state_count <=3D 1, bypassing the governor and keeping th=
e
> > tick running.
> >
> > Fixes: dc2251bf98c6 ("cpuidle: Eliminate the CPUIDLE_DRIVER_STATE_START=
 symbol")
> > Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
>
> Reviewed-by: Christian Loehle <christian.loehle@arm.com>
>
> > ---
> >  drivers/cpuidle/cpuidle.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> > index c7876e9e024f..65fbb8e807b9 100644
> > --- a/drivers/cpuidle/cpuidle.c
> > +++ b/drivers/cpuidle/cpuidle.c
> > @@ -359,6 +359,16 @@ noinstr int cpuidle_enter_state(struct cpuidle_dev=
ice *dev,
> >  int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_device *=
dev,
> >                  bool *stop_tick)
> >  {
> > +     /*
> > +      * If there is only a single idle state (or none), there is nothi=
ng
> > +      * meaningful for the governor to choose. Skip the governor and
> > +      * always use state 0 with the tick running.
> > +      */
> > +     if (drv->state_count <=3D 1) {
> > +             *stop_tick =3D false;
> > +             return 0;
> > +     }
> > +
> >       return cpuidle_curr_governor->select(drv, dev, stop_tick);
> >  }
> >

I've queued up the series for 7.0-rc1 because it is mostly
straightforward, but I've modified the second patch to drop the
redundant latency_req variable and I had to rebase the last one.

Thanks!

