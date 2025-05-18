Return-Path: <linux-pm+bounces-27275-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0042ABAEC2
	for <lists+linux-pm@lfdr.de>; Sun, 18 May 2025 10:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B35CA189A8E0
	for <lists+linux-pm@lfdr.de>; Sun, 18 May 2025 08:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43FA20E716;
	Sun, 18 May 2025 08:24:10 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.lichtvoll.de (lichtvoll.de [37.120.160.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879FD13D52F
	for <linux-pm@vger.kernel.org>; Sun, 18 May 2025 08:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.120.160.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747556650; cv=none; b=imq1F8OQ2hY/++mWubA1Z9dGqxuWKidU663bphlPpKgaVFnrdddncuNsmLm5AO6TIr4yiqzMtKXMiV29yUCfz88ZGgSPlPOpWK/JCjkujidTffseihmOlrxIXER90N0Yi4x+bli72skiMqM35RZUnSgtwrYppX4zA8JK2VlAQTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747556650; c=relaxed/simple;
	bh=yC1I4NNT2qghc4qf+/LWirCbqI5f4ZmCwIK+U29wXdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oefs9enh98pbZnVXBdsheMRfTTmbgb6XhG6/coDsSzNNYUqtSQbTht/kACjmh+8YLcnd+siAxVq/YMNpss5yycV8CNUW9cDZlU5rS9FIuu3M2O74zwLhLkwDVrfoqKTSPsRLt8Y/7vDFOOCyDh0uCaJBrxTDcwXrabZGwG6Zl+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de; spf=pass smtp.mailfrom=lichtvoll.de; arc=none smtp.client-ip=37.120.160.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail.lichtvoll.de (Postfix) with ESMTPSA id 6BA30FBF31;
	Sun, 18 May 2025 08:24:02 +0000 (UTC)
Authentication-Results: mail.lichtvoll.de;
	auth=pass smtp.auth=martin@lichtvoll.de smtp.mailfrom=martin@lichtvoll.de
From: Martin Steigerwald <martin@lichtvoll.de>
To: Denis Benato <benato.denis96@gmail.com>, rafael@kernel.org,
 len.brown@intel.com, pavel@kernel.org, gregkh@linuxfoundation.org,
 dakr@kernel.org, Mario Limonciello <superm1@kernel.org>,
 Mario Limonciello <superm1@kernel.org>
Cc: AceLan Kao <acelan.kao@canonical.com>,
 Kai-Heng Feng <kaihengf@nvidia.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Merthan =?UTF-8?B?S2FyYWthxZ8=?= <m3rthn.k@gmail.com>,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH] PM: Use hibernate flows for system power off
Date: Sun, 18 May 2025 10:24:01 +0200
Message-ID: <5890366.DvuYhMxLoT@lichtvoll.de>
In-Reply-To: <7274e7a9-d645-48f6-b672-f5d8366fc813@kernel.org>
References:
 <20250512212628.2539193-1-superm1@kernel.org>
 <2993537.e9J7NaK4W3@lichtvoll.de>
 <7274e7a9-d645-48f6-b672-f5d8366fc813@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi.

Thanks for your reply, Mario.

Mario Limonciello - 14.05.25, 19:06:03 CEST:
> > I will eventually see I bet.
> >=20
> > Currently I only compile my own kernel for my current ThinkPad which
> > is not affected by this issue.

> As a debugging tactic for your problem you can try to save your shutdown
> log to the EFI pstore by adding this to your kernel command line for a
> boot.
>=20
> efi_pstore.pstore_disable=3DN printk.always_kmsg_dump=3DY
>=20
> Then the next boot if you have the systemd-pstore service enabled it
> will move the log into /var/lib/systemd/pstore.
>=20
> If you don't have it enabled you can run this to manually do it one
> time.
>=20
> sudo systemctl start systemd-pstore.service
>=20
> Hopefully that log will be helpful in identifying your problem.

Thanks for the hint on how to debug things like this without some serial=20
console or so.

As I use Devuan and thus do not have Systemd installed, I will need to=20
find a different way to obtain the log from the pstore. But according to=20
kernel documentation this seems to be easy enough=C2=B9:

mount -t pstore pstore /sys/fs/pstore

I can indeed mount it and there are a lot of "dmesg-efi_pstore-
[timestamp]" files where time stamp seems to be in seconds since beginning=
=20
of 1970.

[1] https://docs.kernel.org/admin-guide/pstore-blk.html

Thanks,
=2D-=20
Martin



