Return-Path: <linux-pm+bounces-33929-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DD9B45192
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 10:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62F865A67A7
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 08:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B9E274B3D;
	Fri,  5 Sep 2025 08:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="eB1V8B2u"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-106103.protonmail.ch (mail-106103.protonmail.ch [79.135.106.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C458273D9A
	for <linux-pm@vger.kernel.org>; Fri,  5 Sep 2025 08:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757061018; cv=none; b=QwpbX7fjUmQ0OB0o27SmvYglcABM3r1qVPy5hZ0IrfO4GJ2KLJlbxWh24o5cbO7XApsF6WM6oRhP17Fi0P18AlmdduqioQvFn7XoIIX+RzrIweBudziArfDV2RyHzF169mozTpoCC9guhz1qvXyedHMLpf8NapK8TLddza7/bRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757061018; c=relaxed/simple;
	bh=tld5YRe1XOKy5ncbULbWgRE+y8pmaRY1ciOM/ru8AE8=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=AtePkSRCA3xt+5aSjLq3Hz4X9Wvl4ekU+BLRJwhL6lLt5HLxNRfjipkE6EbkKMs/K42euoYMusX82+G5uk1bZ9HFXbPKyJBewcGf2FRWKILfKtUxAnkKmY1p0+nr2LLS3EKj+2Ik9Qoac7k12sr9S0FmpwzIp/1lnZppCkw1cZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=eB1V8B2u; arc=none smtp.client-ip=79.135.106.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1757061012; x=1757320212;
	bh=tld5YRe1XOKy5ncbULbWgRE+y8pmaRY1ciOM/ru8AE8=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=eB1V8B2utgiAmyToqgg1dpjU9W/l7AXVPQYjslKV0uPyUQZ28jnsXq1eiZAvvfqPD
	 L9gLSRTb87VhLJF6IsRNxOA73wdTJYsxyhFsl4yfFXYhsl5rSncLiAIRLZkssGhR8f
	 oLjtuYCiBOntuUbjY7kTg98H/QFpqEq0CwTA+tcLxybGY1fHRhBJTvykWX4Vd2De+U
	 f9ofEq3Nd56iclmZYVI29MhdkYyZW4urbXmJaUqd9qNb4eFxmhKonmJfoHkp7lhwSA
	 8lZUzY1vJ0QgYPGAgZDXb+A2roo3YuXAfS5Vt7sSY8pP+/oboNL3QuH8oGf6DcUSXv
	 2RNcwKou6WDlQ==
Date: Fri, 05 Sep 2025 08:30:07 +0000
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
From: aprilgrimoire <aprilgrimoire@proton.me>
Cc: Mario Limonciello <superm1@kernel.org>
Subject: [PATCH] Subject: [PATCH 1/1] x86: Fix spurious 8042 for Mechrevo Yilong15Pro
Message-ID: <WO4-1V8LhkguyJ12_oK3K7dgEjZwM31XRoXJEbZa-sLbqL85Lmc7iqi_3dCpyyFKsuDSlMj5_Kg-r5iZX4rxeHqsF9T6jXkE7RaGZDrbDhE=@proton.me>
Feedback-ID: 151975985:user:proton
X-Pm-Message-ID: 0b696f21f0f1368cc0d28659052fbad076ecee76
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From d82abe97c5696e22eb24c7eabe641432446da8cf Mon Sep 17 00:00:00 2001From:=
 April Grimoire <AprilGrimoire@proton.me>
Date: Fri, 5 Sep 2025 16:24:33 +0800
Subject: [PATCH] Subject: [PATCH 1/1] x86: Fix spurious 8042 for Mechrevo
=C2=A0Yilong15Pro

The firmware of Mechrevo Yilong15Pro emits a spurious keyboard interrupt on
events including closing the lid. When a user closes the lid on an already
suspended system this causes the system to wake up.
Add Mechrevo Yilong15Pro Series (GM5HG7A) to the list of quirk
spurious_8042 to workaround this issue.

Link: https://lore.kernel.org/linux-pm/6ww4uu6Gl4F5n6VY5dl1ufASfKzs4DhMxAN8=
BuqUpCoqU3PQukVSVSBCl_lKIzkQ-S8kt1acPd58eyolhkWN32lMLFj4ViI0Tdu2jwhnYZ8=3D@=
proton.me/

Signed-off-by: April Grimoire <aprilgrimoire@proton.me>
---
=C2=A0drivers/platform/x86/amd/pmc/pmc-quirks.c | 8 ++++++++
=C2=A01 file changed, 8 insertions(+)

diff --git a/drivers/platform/x86/amd/pmc/pmc-quirks.c b/drivers/platform/x=
86/amd/pmc/pmc-quirks.c
index 18fb44139d..4d0a38e06f 100644
--- a/drivers/platform/x86/amd/pmc/pmc-quirks.c
+++ b/drivers/platform/x86/amd/pmc/pmc-quirks.c
@@ -239,6 +239,14 @@ static const struct dmi_system_id fwbug_list[] =3D {
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DMI_MATCH(DMI_BOARD_NAME, "WUJIE1=
4-GX4HRXL"),
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
=C2=A0 =C2=A0 },
+ =C2=A0 {
+ =C2=A0 =C2=A0 =C2=A0 .ident =3D "MECHREVO Yilong15Pro Series GM5HG7A",
+ =C2=A0 =C2=A0 =C2=A0 .driver_data =3D &quirk_spurious_8042,
+ =C2=A0 =C2=A0 =C2=A0 .matches =3D {
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DMI_MATCH(DMI_SYS_VENDOR, "MECHREVO"),
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DMI_MATCH(DMI_PRODUCT_NAME, "Yilong15P=
ro Series GM5HG7A"),
+ =C2=A0 =C2=A0 =C2=A0 }
+ =C2=A0 },
=C2=A0 =C2=A0 /* https://bugzilla.kernel.org/show_bug.cgi?id=3D220116 */
=C2=A0 =C2=A0 {
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .ident =3D "PCSpecialist Lafite Pro V 14M",
--
2.49.1

