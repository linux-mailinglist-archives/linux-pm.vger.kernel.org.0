Return-Path: <linux-pm+bounces-20613-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D91A14E37
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 12:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F16C2168089
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 11:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FEB1FCFF0;
	Fri, 17 Jan 2025 11:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ONfiSCXV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9100D1FCCF5
	for <linux-pm@vger.kernel.org>; Fri, 17 Jan 2025 11:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737112318; cv=none; b=P8uXT3KRks2d7MvkRPlNLOcyKohhy9TGgxdUuW7xXEnYM8AnMzs6oT3v2EsYJUNaQ+7ONAI0JJFeXFGSfdbvt41YPHGw7D+v3zXiHHxR7pnRTUxqeNX9DTp5TwP4Or9oBLPlrQA59vwqUCo2MDvbys1sU7yxhQuw+tWvQRvsVqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737112318; c=relaxed/simple;
	bh=zevm7p92+PYP4xW+UuLYMkuGU5R3+hH8gMsxCikm76Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q6wkpO3EXLBJ7sQayYoAvjUNoeQWWc9lxYn3fh/CjN0QAGpYYHwZ1V7KLCLBRkRjlGt4RRlMAFnAdbtumgGJDBwbtituMM5CQSBZDVc/2t+jY53WtGEK5LpoEMiGXxOThG+RtcUSIy7GovMCrBDblwv0FYupMsYJFCh175THLXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ONfiSCXV; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e549be93d5eso3739839276.1
        for <linux-pm@vger.kernel.org>; Fri, 17 Jan 2025 03:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737112315; x=1737717115; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zevm7p92+PYP4xW+UuLYMkuGU5R3+hH8gMsxCikm76Q=;
        b=ONfiSCXVyLF1QJfN8SC8HLEFJ2MMxFrFb2km2iIlW9StpIyejqCthYexP4yZVf5yxD
         4CJ63Mi9ODtyqaKySyKnkXGTpmSzeRyFQ8kp3FICZ7rAWHI1jIrn0zyJqaM4SAkEr1rB
         GZbrtPOZkn+fKXpk2Swhjwb+oYr1rjMsd+zjJwB8lrczt1TDsM0+3lnX1UayEr20++vY
         TCIvzKDPY/Q1TMefZWCBPjEvTbRYz3WazlwvTzHodPG0sz7S0GI38zqHwzXFRQKvnNDF
         pXDvdphflmTt/7mHfxvNuqvPU8HbwB62kKRs9zk+BT1zjMYicHLHZ5NtJIgYGhKkOOjz
         tQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737112315; x=1737717115;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zevm7p92+PYP4xW+UuLYMkuGU5R3+hH8gMsxCikm76Q=;
        b=BlntugBlPLRS3uho4k16YmMnkYABZ1EmW+0XaW8+pdWfaEkcB0DjTwdIYPXY2gsPHS
         x6tcCy1fkEEvGXDAlpK7gfS6b/cCaOrha9dK1jM2zT0i32OYqyTicbRCqj9sMqcpwWGN
         7Qe973mlAKkfXHZuvgbNG5IRjzxpA4Tk1uql/WvzGudXLGFo4SxeMdpN14n+Qv4C5C4K
         EtrimTkQV2W7h1amaj+WXDf5/Fv8pHX+xWtcMZ8RtGkZS8E5CpzUTyNcjMmrdfBIdmjb
         MIqhkcLXn5GUepLRf0vG+dkspdrtmO+CJ0+Od4DmGv/FXzMoSXBSkwwUz+YUBNipKeXS
         p/Wg==
X-Forwarded-Encrypted: i=1; AJvYcCV33WnSysptF4Vcn2XRO4uzubWhESysYmCYZ5rdkCvCLprhCtwqCyuuvdVnN7QKXuVw1ZRBJL+rmw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJYmYO1VT3iVbGdLiFdmIbHWBZM34YICCSj61/HbRsQcRneRq+
	pGJdXVZYM/8JnjHjwx1FNzAIQ+1daWR/ZAbmNyN1dJxGg16JRUnqwtEULxH/ZFOSOce3nDv1wy5
	5UHoaLrixFl5RfKfNHAyQ8J9UbKxBJQGe7aHkj7oy05dMtUKx
X-Gm-Gg: ASbGnctC72qbq9wr5ox8LxgXorJBwxaf6t3hzPAD31nU+GIdsPZy0F55lXcA5rwFIOU
	vbz/iLO6czTCx1dh1HwwOHlWGE+9Js+qFEFU/29M=
X-Google-Smtp-Source: AGHT+IFmDnLX7knNpPRkwb4MMSQEX/jiOKeWH5IpM+7Da8s1eEqAMaHpNzNx0ibYxiZmdRml+pkpwWUwAndwGUe55LU=
X-Received: by 2002:a05:690c:4d02:b0:6ef:4a1f:36aa with SMTP id
 00721157ae682-6f6eb684195mr17400657b3.20.1737112315562; Fri, 17 Jan 2025
 03:11:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115113931.1181309-1-sudeep.holla@arm.com>
 <CAPDyKFrrdkBAPBw5JOv5HLnOj2L=6ZjE+O7h8N3MFC64ebcNEg@mail.gmail.com> <Z4kzeLB6p6e45bhk@pluto>
In-Reply-To: <Z4kzeLB6p6e45bhk@pluto>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 17 Jan 2025 12:11:19 +0100
X-Gm-Features: AbW1kvZ2eEtEciPTUgcumTMRDldQor00UGeUX30RlnvTHMSfzGlUG4ZxEewCYVg
Message-ID: <CAPDyKFoZG5UULRnhanpn3mYF5_37ouXY356M3tjf425MXSY+gg@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: arm: scmi_pm_domain: Send an explicit request
 to set the current state
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, arm-scmi@vger.kernel.org, 
	linux-pm@vger.kernel.org, Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, 
	Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Jan 2025 at 17:27, Cristian Marussi <cristian.marussi@arm.com> wrote:
>
> On Thu, Jan 16, 2025 at 04:54:44PM +0100, Ulf Hansson wrote:
> > On Wed, 15 Jan 2025 at 12:39, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > On a system with multiple active SCMI agents, one agent(other than OSPM/
> > > Linux or bootloader) would request to turn on a shared power domain
> > > before the Linux boots/initialise the genpds. So when the Linux boots
> > > and gets the power state as already ON, it just registers the genpd with
> > > a default ON state.
> > >
> > > However, when the driver that needs this shared power domain is probed
> > > genpd sees that the power domain status is ON and never makes any SCMI
> > > call to power it up which is correct. But, since Linux didn't make an
> > > explicit request to turn on the shared power domain, the SCMI platform
> > > firmware will not know if the OSPM agent is actively using it.
> > >
> > > Suppose the other agent that requested the shared power domain to be
> > > powered ON requests to power it OFF as it no longer needs it, the SCMI
> > > platform firmware needs to turn it off if there are no active users of
> > > it which in the above scenaro is the case.
> > >
> > > As a result of SCMI platform firmware turning off the resource, OSPM/
> > > Linux will crash the moment as it expects the shared power domain to be
> > > powered ON.
> > >
> > > Send an explicit request to set the current state when setting up the
> > > genpd power domains so that OSPM registers its vote in the power domain
> > > state with the SCMI platform firmware.
> > >
> > > The other option is to not read the state and set the genpds as default
> > > OFF, but it can't handle the scenario on certain platforms where SCMI
> > > platform keeps all the power domains turned ON by default for faster boot
> > > (or any other such variations) and expect the OSPM to turn off the unused
> > > domains if power saving is required.
> > >
> > > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > > Link: https://lore.kernel.org/all/Z4aBkezSWOPCXcUh@bogus
> > > Reported-by: Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
> > > Reported-by: Peng Fan <peng.fan@nxp.com>
> > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> >
> HI Ulf,
>
> > I read up on the discussion and it looks like there is not really a
> > simple solution here.
> >
> > In principle if a boot-loader wants to do a handover and leave the
> > power-domain powered-on for the kernel, the additional call to
> > ->state_set() *could* bump the usagecount in the SCMI FW, forever
> > leaving the power-domain on.
> >
>
> TWell, in theory, this should NOT be the case in the SCMI world since
> the resource accounting is supposed to happen per-agent...so multiple
> ONs from the same agent should be only accounted as ONE request from
> agent_A, because the assumption is that multiple requests from the same
> agent wouldl have already been filtered out from within the agent
> frameowrks itself, like genPD of CLock...so the platform really takes
> care tro harmonize access between shared resources from multiple
> different agents.
>
> Now, I fear also, though, that all of the above is IMPDEF and only a
> reccomendation, even though the (few) systems I aware of follow this
> per-agent-accounting approach.

Thanks for clarifying! I assume I can consider this as a reviewed-by
for $subject patch, if not please let me know.

>
> Thanks,
> Cristian

Kind regards
Uffe

