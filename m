Return-Path: <linux-pm+bounces-41643-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yE4RLa57emka7AEAu9opvQ
	(envelope-from <linux-pm+bounces-41643-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 22:12:14 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E56C7A8FD9
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 22:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 87C553007293
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 21:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A174D377555;
	Wed, 28 Jan 2026 21:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdjOOUEn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E79C376BFD
	for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 21:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769634729; cv=none; b=pKF+KybiXzuAYBE0w0me1wrHqcMoSCbMqzK51WyYbDcvhJJfpxhPjtcvYRDGHAYAU3vfKlLKQVpn8vrNfdy8WL0NslMZhnmhMK/WvmetyqZ4nBM/BSCLUaXh2EalFFp6EWjrne2wqpyGWlZRkLPcHomKetFMR91mNi+8ooMFLrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769634729; c=relaxed/simple;
	bh=sK9XeAB8Ftjpmea818m3ojNLs7KpCdUNvDabr3mangA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xmkx+tNtyaYRoX0ejrmXcbNzqkr4g4OJgJ7H1vJpCnTO+mvDZcyiwz4S6/Stnmgzl+fy93GYqyRkV0JvTkwjEYJaEPLooN3m55R/ApEnXNM9wK2agvLxyNONPVoVKHkcAjJ4JpcA0Z60wJkBfd/QD8XrufiCzPONc5CSBhyVO4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdjOOUEn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D5B8C2BC86
	for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 21:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769634729;
	bh=sK9XeAB8Ftjpmea818m3ojNLs7KpCdUNvDabr3mangA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fdjOOUEnTl6MWXD/AJBxQCzvd5nAJFknNqt6tNBN7P5fZ7k6g85qFQoYWjSjr6ejO
	 7bwCUL0dcbxMb+DiubnM2z0YAj9iBa7q0h+Ye7Bd1FgIXcOF26GzjOt0btrSMrstxV
	 gR0iGld2rIiqlZJdTYQ31AG499uonfGUCCIefMKlpwWMmYGwJE4+giYsNFdX7Yii9r
	 nYKQDxNJy8ahzBCS+gbPGeKeGRH5zCD0VXOBZRPqHx55hsW0oXhIOhpydj4AWzt4l1
	 ozXG9j0WgqyBluH0397Cmqqfdqo0fbeaXto0KO/rKnzM6/bahdzNb8DK82+QEuICmj
	 YzzVyFTGU9lhQ==
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7cfd53a8c31so778943a34.1
        for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 13:12:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU27FcqAoz2/lDK7j76rQ8Q/5U3NwxIMVADT5zAbD7kLMKhTIvnORLCs5umTCGnp2hfjACDEICtqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRdqbTYcab+cS/QVqg1ujetasZJczr71+sVwId2duPZQhbGHaT
	KQfJiSYwZWpuv+BVX1h1dZmyeMJIwDGAOViMRwnmiRo7MsinyyZgs006Q0C8wdIFuWAJlKihpF4
	nyjOjdv2hoQc/60PyrMqOHuL494FFwqk=
X-Received: by 2002:a4a:e914:0:b0:662:f763:c530 with SMTP id
 006d021491bc7-6630612a230mr333906eaf.3.1769634728183; Wed, 28 Jan 2026
 13:12:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260124-thermal_of-v1-1-54d3416948cf@gmail.com>
 <CAJZ5v0gL92f3g4oj47jaYQKG_V6vd_oBawbwQVWjUP7u9QKS7g@mail.gmail.com> <67d1584c-a474-4873-8cc2-9899296ea7ea@arm.com>
In-Reply-To: <67d1584c-a474-4873-8cc2-9899296ea7ea@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 28 Jan 2026 22:11:57 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g4d234zx9Ts9wAgAbokTtQWqkCFU7CtKwzPJ_T=xXv1Q@mail.gmail.com>
X-Gm-Features: AZwV_QjRc_13a20WUol9vrPxVg3fdmpVYosfC3dBJCB2ThlGg-tNnL8Vbpb6rq0
Message-ID: <CAJZ5v0g4d234zx9Ts9wAgAbokTtQWqkCFU7CtKwzPJ_T=xXv1Q@mail.gmail.com>
Subject: Re: [PATCH] thermal/of: Fix reference leak in thermal_of_cm_lookup()
To: Lukasz Luba <lukasz.luba@arm.com>, Felix Gu <ustc.gu@gmail.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Yu-Che Cheng <giver@chromium.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41643-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[arm.com,gmail.com,linaro.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E56C7A8FD9
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 11:42=E2=80=AFAM Lukasz Luba <lukasz.luba@arm.com> =
wrote:
>
>
>
> On 1/27/26 16:22, Rafael J. Wysocki wrote:
> > On Fri, Jan 23, 2026 at 8:06=E2=80=AFPM Felix Gu <ustc.gu@gmail.com> wr=
ote:
> >>
> >> In thermal_of_cm_lookup(), tr_np is obtained via of_parse_phandle(). B=
ut
> >> it never be released.
> >> Use the __free(device_node) cleanup attribute to automatically release
> >> the node and fix the leak.
> >>
> >> Fixes: 423de5b5bc5b ("thermal/of: Fix cdev lookup in thermal_of_should=
_bind()")
> >>
> >> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> >> ---
> >>   drivers/thermal/thermal_of.c | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of=
.c
> >> index 1a51a4d240ff..b6d0c92f5522 100644
> >> --- a/drivers/thermal/thermal_of.c
> >> +++ b/drivers/thermal/thermal_of.c
> >> @@ -280,10 +280,10 @@ static bool thermal_of_cm_lookup(struct device_n=
ode *cm_np,
> >>                                   struct cooling_spec *c)
> >>   {
> >>          for_each_child_of_node_scoped(cm_np, child) {
> >> -               struct device_node *tr_np;
> >>                  int count, i;
> >>
> >> -               tr_np =3D of_parse_phandle(child, "trip", 0);
> >> +               struct device_node *tr_np __free(device_node) =3D
> >> +                       of_parse_phandle(child, "trip", 0);
> >>                  if (tr_np !=3D trip->priv)
> >>                          continue;
> >>
> >>
> >> ---
> >
> > This looks good to me.
> >
> > Lukasz, Daniel?
>
>
> Good catch thanks! That looks good. This scoped device node
> handling approach simplifies a lot the error paths (and is less
> error-prone).
>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Applied as 6.20 material, thanks!

