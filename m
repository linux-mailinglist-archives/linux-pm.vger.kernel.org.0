Return-Path: <linux-pm+bounces-27145-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3993AB7192
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 18:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D18216F707
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 16:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564D7270ED7;
	Wed, 14 May 2025 16:36:25 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.lichtvoll.de (lichtvoll.de [37.120.160.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627DF1A841E
	for <linux-pm@vger.kernel.org>; Wed, 14 May 2025 16:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.120.160.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747240585; cv=none; b=YAbxTfFE6D/iEw4RlOAJpLW1MhLBPISb8xI/YCoJpJqqRcvl4Ya5brTRlPov1Kzu+3BRoT4T5J6jP8A3HB5DLvWVTqtRyH4mOpGX6GSQE+XonLOSsFe6mW3b0sFLu+74jLDNJzz73Lr839ubqdJBCqelPKezKDIDEW9JB8BrW1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747240585; c=relaxed/simple;
	bh=d0t6Rh+WEZJxIJLquKO+eM8u8UWTnmvwo3SL1TlC75k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SMYhlRhg9mncdoNSHZPMRHbn/A+JgAIvM/AGA5I7+jUg8UxVqf5ZCZUgnmDHUkogoyizgf6b+K7WAIk9Vx3USwFMR4HiX9/AyYoDBl/cTErbJZTAAl8TwpGiqKpvhUlDgmLgNlfO21XuN+RpAYFTPPqaavbsbGVcinLshhuX6F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de; spf=pass smtp.mailfrom=lichtvoll.de; arc=none smtp.client-ip=37.120.160.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail.lichtvoll.de (Postfix) with ESMTPSA id 10E47F9CD3;
	Wed, 14 May 2025 16:30:05 +0000 (UTC)
Authentication-Results: mail.lichtvoll.de;
	auth=pass smtp.auth=martin@lichtvoll.de smtp.mailfrom=martin@lichtvoll.de
From: Martin Steigerwald <martin@lichtvoll.de>
To: Denis Benato <benato.denis96@gmail.com>, mario.limonciello@amd.com,
 rafael@kernel.org, len.brown@intel.com, pavel@kernel.org,
 gregkh@linuxfoundation.org, dakr@kernel.org,
 Mario Limonciello <superm1@kernel.org>
Cc: AceLan Kao <acelan.kao@canonical.com>,
 Kai-Heng Feng <kaihengf@nvidia.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Merthan =?UTF-8?B?S2FyYWthxZ8=?= <m3rthn.k@gmail.com>,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH] PM: Use hibernate flows for system power off
Date: Wed, 14 May 2025 18:30:04 +0200
Message-ID: <2993537.e9J7NaK4W3@lichtvoll.de>
In-Reply-To: <e3aa4d7d-e854-4ee2-aa5d-6371e8aa4ed8@kernel.org>
References:
 <20250512212628.2539193-1-superm1@kernel.org>
 <6cc4caa4-ca75-4b32-83a9-1dea761046ef@gmail.com>
 <e3aa4d7d-e854-4ee2-aa5d-6371e8aa4ed8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi.

Mario Limonciello - 14.05.25, 18:15:00 CEST:
> > Hello,
> >=20
> > As for the previous version this patch makes my laptop shutdown
> > cleanly very quickly and I could not link to any regressions or
> > change in behavior while laptop is on.
> >=20
> > Tested-by: Denis Benato <benato.denis96@gmail.com>
>=20
> Thanks Denis, that's great news to hear.

Thanks!

> FTR I noticed that this needs some error handling in case the hibernate
> flows fail, so assuming Rafael is generally amenable to this direction
> the next spin I'll add something like this instead to fall back to the
> previous shutdown flow if that happens.

I do not know the context of this patch except this mailing list thread.

However=E2=80=A6 on various ThinkPads I had the issue of the device not pow=
ering=20
down with certain kernel versions. Not even during a normal shutdown=20
attempt. Also not with hibernation to disk. Still holding on to an older=20
kernel version for a X260 for example. But also a T14 AMD Gen 1 is=20
affected no longer in frequent use currently while a T14 AMD Gen 2 is=20
absolutely fine. Could this patch help with that?

I will eventually see I bet.

Currently I only compile my own kernel for my current ThinkPad which is=20
not affected by this issue.

Best,
=2D-=20
Martin



