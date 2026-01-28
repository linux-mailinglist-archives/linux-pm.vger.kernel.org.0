Return-Path: <linux-pm+bounces-41642-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCEVLwx7emka7AEAu9opvQ
	(envelope-from <linux-pm+bounces-41642-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 22:09:32 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 270C1A8F5A
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 22:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CFAE304C080
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 21:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA7C376BF6;
	Wed, 28 Jan 2026 21:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WM5dSGri"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F4737416C
	for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 21:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769634530; cv=none; b=bkdB2QtjbMZwYRpplh9GQP8ejNcqli9BvXl7zMAyfF2Bz42lfSmkNoIyVXwHkSwD+FJqZPZZp4WHNq326oFhFoQ72cJtZG+8ORf3tLw1efl7Gj0+8+ow0jlsxHRCW1eN1szYfLsWWVSw9Bre/+LP8GmDVda0psV12vN4btLuZOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769634530; c=relaxed/simple;
	bh=ifpvd9ldxrV+ZT+KQosqN93UxeenI32AoXk1VQuyToA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z8Kkvad2U2N7eJHMvRCTLBJi71aOT66lgcD6K3Ydpc68V4udwqJaaHUFMaOkDGYaT31I0DpyYj3vffT5bTgo+etuo/ma/CRiH7vTD4qIRZRbqWUj0jLSYEvmbU7U/J2/g9dkCucxftKItDTcjrLWytEyfcsbMrunPAMEY/vOKss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WM5dSGri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7811DC116C6
	for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 21:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769634530;
	bh=ifpvd9ldxrV+ZT+KQosqN93UxeenI32AoXk1VQuyToA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WM5dSGriKlGy7+R5gd48T5ijOlGF5zS4AnNWZkWngVKEi222Zz79lM+1XGv+Z/bp/
	 tTYp/hNd81Gct9SJs2OVS0chDwhVlBRDckSxxlxPnMWfnjajemm9Ywm6bT9e2zKMDV
	 yTX6WWHGk6g4dqMFmWvCTKS64FqL3dMGJKEB79pYbpZFovYPmx+9xUZmtPjGnJ4rhv
	 uvI6y0S7LU+zPeDj3ZW+qZC8mc0KITsz8FSSmJR9KsVxq0p1TVSav5Rpmw0Qtz4OTH
	 6P0YtJSmohtorzlMft2SeBfuedDIZlJzSlZ1RTzAQZYCABsDlw816L20vCPdzkFHhN
	 LCYiMHy/Ffk9Q==
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d15b8feca3so217897a34.3
        for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 13:08:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX+pJaJNgNdLlMGs7RV5UkYhRp2mkwnQCi5qbh2M/oBVB2mois/R5xgHREFWQy8169CRH9Mz6ZQOg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGWCALZwexBRP7cPphjmC4pzjtse2SsUrPntfRVUkc/wxa1ovj
	6I8UnjRZuZNi8b7pqo/fMr+kxIprQzNXws81hdtrrL+UNS8KcyG7MdmyTjddBvArYCjtOimK9sy
	3WrSnnLHcPcpdorlmNLSX1DnLhxHO6JU=
X-Received: by 2002:a05:6820:1987:b0:662:fe9f:2259 with SMTP id
 006d021491bc7-662fe9f244fmr1324052eaf.50.1769634529556; Wed, 28 Jan 2026
 13:08:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128062446.402175-1-rdunlap@infradead.org> <79619479-8d59-4894-90a5-b83cd24fc987@arm.com>
In-Reply-To: <79619479-8d59-4894-90a5-b83cd24fc987@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 28 Jan 2026 22:08:38 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hNByYiRzsVo1tVPW_Fha_PVbW-4aYVvHrPrQ0fz64e=w@mail.gmail.com>
X-Gm-Features: AZwV_QhiwabLjApDU8ZKfWSAV2YhOiSvl-mjE-Ovlp0hCw6p5x8kW8ONbE2FZaI
Message-ID: <CAJZ5v0hNByYiRzsVo1tVPW_Fha_PVbW-4aYVvHrPrQ0fz64e=w@mail.gmail.com>
Subject: Re: [PATCH] thermal: core: thermal_core.h: fix all kernel-doc warnings
To: Lukasz Luba <lukasz.luba@arm.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41642-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,intel.com:email,infradead.org:email,linaro.org:email]
X-Rspamd-Queue-Id: 270C1A8F5A
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 11:09=E2=80=AFAM Lukasz Luba <lukasz.luba@arm.com> =
wrote:
>
>
>
> On 1/28/26 06:24, Randy Dunlap wrote:
> > Resolve all kernel-doc warnings in thermal_core.h:
> >
> > Warning: drivers/thermal/thermal_core.h:99 bad line: trip point.
> > Warning: drivers/thermal/thermal_core.h:101 bad line: passive trip poin=
t.
> > Warning: drivers/thermal/thermal_core.h:152 struct member 'trips_attrib=
ute_group' not described in 'thermal_zone_device'
> > Warning: drivers/thermal/thermal_core.h:152 struct member 'debugfs' not=
 described in 'thermal_zone_device'
> > Warning: drivers/thermal/thermal_core.h:152 struct member 'user_thresho=
lds' not described in 'thermal_zone_device'
> >
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > ---
> > Cc: Rafael J. Wysocki <rafael@kernel.org>
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: Lukasz Luba <lukasz.luba@arm.com>
> > Cc: linux-pm@vger.kernel.org
> >
> >   drivers/thermal/thermal_core.h |    7 +++++--
> >   1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > --- linux-next-20260126.orig/drivers/thermal/thermal_core.h
> > +++ linux-next-20260126/drivers/thermal/thermal_core.h
> > @@ -77,6 +77,7 @@ struct thermal_governor {
> >    * @device: &struct device for this thermal zone
> >    * @removal:        removal completion
> >    * @resume: resume completion
> > + * @trips_attribute_group: trip point sysfs attributes
> >    * @trips_high:     trips above the current zone temperature
> >    * @trips_reached:  trips below or at the current zone temperature
> >    * @trips_invalid:  trips with invalid temperature
> > @@ -97,9 +98,9 @@ struct thermal_governor {
> >    * @emul_temperature:       emulated temperature when using CONFIG_TH=
ERMAL_EMULATION
> >    * @passive:                1 if you've crossed a passive trip point,=
 0 otherwise.
> >    * @prev_low_trip:  the low current temperature if you've crossed a p=
assive
> > -                     trip point.
> > + *                   trip point.
> >    * @prev_high_trip: the above current temperature if you've crossed a
> > -                     passive trip point.
> > + *                   passive trip point.
> >    * @ops:    operations this &thermal_zone_device supports
> >    * @tzp:    thermal zone parameters
> >    * @governor:       pointer to the governor for this thermal zone
> > @@ -111,6 +112,8 @@ struct thermal_governor {
> >    * @poll_queue:     delayed work for polling
> >    * @notify_event: Last notification event
> >    * @state:  current state of the thermal zone
> > + * @debugfs: this thermal zone device's thermal zone debug info
> > + * @user_thresholds: list of userspace thresholds for temp. limit noti=
fications
> >    * @trips:  array of struct thermal_trip objects
> >    */
> >   struct thermal_zone_device {
>
>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Applied as 6.20 material, thanks!

