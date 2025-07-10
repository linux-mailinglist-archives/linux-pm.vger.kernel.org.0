Return-Path: <linux-pm+bounces-30630-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB09B00C58
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 21:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24F5A640E4C
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 19:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FE92FD86B;
	Thu, 10 Jul 2025 19:53:08 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A1C2367CB;
	Thu, 10 Jul 2025 19:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752177188; cv=none; b=aOmiXDYf8IeC7H3jO7n7Xv2D5uPefA1uylibsDdBdmMjY19YaIG10RWCPbWRGD7Tri9hrlRFYfQe6KeHIo7vPJICerD5asHe3FJJOND17vOUPRadLBKZBhxNpPrGQD/Jf5JYVLzdkhrjeqf3D+qsN7der+qEWuJ9a95R1WX5e2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752177188; c=relaxed/simple;
	bh=lmWhfEqKI2hQcwc3PkrLX3XptMWojeEklCPmU+OgZf8=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=YFbko8ZGRJwQ3SgEutBBYsuURGJYIb66Y1Ial1IC2oqJUhDS2kl4xeL5K8OeSR7RWhRYFvHjpZ9U3wO/xeBqTt+RWnx4kdrWSEhjJnCq1m9Uds4+Lp2EG76Cf4F2p2F2+u6/imbjXFCNhhIw5iCTud2UxzL8/ibfUSNdL49rYIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [89.234.162.240] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1uZxJv-004sfF-0I;
	Thu, 10 Jul 2025 19:52:39 +0000
Received: from ben by deadeye with local (Exim 4.98.2)
	(envelope-from <ben@decadent.org.uk>)
	id 1uZxJu-0000000D93M-09gH;
	Thu, 10 Jul 2025 21:52:38 +0200
Message-ID: <3cbd9533b091576a62f597691ced375850d7464a.camel@decadent.org.uk>
Subject: User-space watchdog timers vs suspend-to-idle
From: Ben Hutchings <ben@decadent.org.uk>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 "Rafael J. Wysocki"	 <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@ucw.cz>,  John Stultz <jstultz@google.com>, Thomas
 Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, 
	1107785@bugs.debian.org
Date: Thu, 10 Jul 2025 21:52:30 +0200
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-MyYK5Gp6ctxLfjUkNktP"
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 89.234.162.240
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false


--=-MyYK5Gp6ctxLfjUkNktP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

There seems to be a longstanding issue with the combination of user-
space watchdog timers (using CLOCK_MONOTONIC) and suspend-to-idle.  This
was reported at <https://bugzilla.kernel.org/show_bug.cgi?id=3D200595> and
more recently at <https://bugs.debian.org/1107785>.

During suspend-to-idle the system may be woken by interrupts and the
CLOCK_MONOTONIC clock may tick while that happens, but no user-space
tasks are allowed to run.  So when the system finally exits suspend, a
watchdog timer based on CLOCK_MONOTONIC may expire immediately without
the task being supervised ever having an opportunity to pet the
watchdog.

This seems like a hard problem to solve!

By definition we cannot allow CLOCK_MONOTONIC to run backward, and I
assume we do not want it to stop while interrupts are being handled.=20
But could CLOCK_MONOTONIC be split into a CLOCK_MONOTONIC_KERNEL (may
tick during suspend-to-idle) and CLOCK_MONOTONIC_USER (only ticks while
user tasks can run), with user-space CLOCK_MONOTONIC being the latter?=20
(I'm aware that adding yet another clock type would be a rather large
job even if this is possible.)

Until and unless that happens, is it possible to detect that
CLOCK_MONOTONIC advanced during suspend-to-idle by reading e.g.
/proc/schedtat?  If not, could the necessary information be exposed
through one of the pseudo-filesystems?

Ben.

--=20
Ben Hutchings
Never attribute to conspiracy what can adequately be explained
by stupidity.

--=-MyYK5Gp6ctxLfjUkNktP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmhwGf8ACgkQ57/I7JWG
EQnjZg/6AmnBmhkdS1JVPYSVhh4z6maqizuIHgdKYG9Yf3oCKCfPGpQsW4KkVidJ
ep8yu59Z8mkKnR6wl7KtBXgfSqboFH1kSqq+Wjt7xyAQSft4eAglZivahSwqeUF1
SqFzjJjGy7KakttI4d1dOk4KUcKOEv2qeU5LmbcYqKODqy3VWThnxllek+Tt59+j
iSGl7hCaFF88hsAqWj7cSQQN9k1x+LFF5EmyXx0l5w5NrGcvt+VKWSRbemjYCWns
0mKcJ/6panhiG26Anx1LQsENVuSyOe1yn9WuHo6/HW1ziDrmYq5Q3BgVNRN7ZIwA
n/DMKyIb6dHXV4x8xXEfuND9Qs9DUTXv85ZGbFOrAxtl8Rzr4iZ83vgCCb7GRj6z
Y5xcT8so4orULKDlr9kDRiwYuh1d+q0uqohLkFCGtUVKNegbdfUsiNoCkiz2TO4X
QIqPEo+MviT7E93EMYPUMO5KOuHQu1CXl+m0RABr3IQsSz5s/Bh2y7z+Y3+a4PJS
Fjg/2BUde77EDxMs4hoFWlasqeA8DJak6MOYEZwuNHar27Vb/vZjuv+zMmsYUBxl
dSICWHHdpR/v7bY+wZFJqVpmUddQCRE6x6LPKgXRvuXrbsuAzHQb82A3bEWw5S7G
UNp6wG8EN3q9RwedoopipS8HFRuhQjhg/wN9l2Kl8qHAzCT0XgA=
=xEYp
-----END PGP SIGNATURE-----

--=-MyYK5Gp6ctxLfjUkNktP--

