Return-Path: <linux-pm+bounces-21502-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B6BA2B288
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 20:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EB81188BA88
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 19:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB621AE875;
	Thu,  6 Feb 2025 19:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Qm/3l6I/"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A4C1AAE13;
	Thu,  6 Feb 2025 19:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738871158; cv=none; b=KBPB/7lr7WJ02yMS9YS0quHQKQUXIypBAGDvlTw2GMn+tAT9w6aTOTRthcXfqnyWYgWShax0RaWt67AtbwRQeGNk/Yvzw989K27wUC6UjN+iBIHp5wXYtqOOteO84byzIelMCxV6hesM3FPZe894T+GeC+YGGv1Jkay8pIJfIFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738871158; c=relaxed/simple;
	bh=95h1vd+AvUmYA16FIPHKR/Y6U/M6LE2XMdtVpQnoISg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Rt9BlcaLhich4vJtqVC35hI0r6fB3SVQNCO4QA21DTCXzCTI9iGXOdpcx2tr8HVDqWkyTCsmBRkKDl9fHWWSB9goZkoHgkIaxIFFTHJWzUzcEEjkWFtdT6+UldtwUN4tyG1By3gTvTyPEe1CTtVTYm75FaGX48r4/8BqlD7YpAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Qm/3l6I/; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 4eb088449ce6a310; Thu, 6 Feb 2025 20:45:53 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 789DA6BA9A4;
	Thu,  6 Feb 2025 20:45:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1738871153;
	bh=95h1vd+AvUmYA16FIPHKR/Y6U/M6LE2XMdtVpQnoISg=;
	h=From:Subject:Date;
	b=Qm/3l6I/wv8LDCDfiZ70GJWLPKNmWumpw7adLDrS4NlIr/WPjLa750ZRhBoBMBUHV
	 dbXs2n63XTSPIiIMyGrbrtqOXFmEPZFiuk2ZQZc9p0NyFBQXl46+id036WYntjDeos
	 SfOSsQtC+Bjybk5tt4ti0fRZDXUMXcMFUD2x5iLKAtVL6xUvH1AK3U7gIzBpYBIzb1
	 e0rZBU6PBqRrXsxuMqcVQHWy7JjkBw1jv+pJXGRXhPZNx1nSZr8Awx/eCFtpxJFAI7
	 Sa28RcH7k1CKVdXk900faaW17ZERjdX4Rvoe3aegSdZUO2rTec8rDGrJ2qki3wfMtR
	 /ZTlP2Cfbw64Q==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: [PATCH v1] cpuidle: intel_idle: Update MAINTAINERS
Date: Thu, 06 Feb 2025 20:45:52 +0100
Message-ID: <2774831.mvXUDI8C0e@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: spam:low
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedviecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegoufhprghmkfhpucdlfedttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvghnsgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghrthgvmhdrsgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Update the intel_idle record in MAINTAINERS to reflect the current
state of affairs.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 MAINTAINERS |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11675,8 +11675,9 @@
 F:	drivers/crypto/intel/iaa/*
 
 INTEL IDLE DRIVER
-M:	Jacob Pan <jacob.jun.pan@linux.intel.com>
-M:	Len Brown <lenb@kernel.org>
+M:	Rafael J. Wysocki <rafael@kernel.org>
+R:	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
+R:	Len Brown <lenb@kernel.org>
 L:	linux-pm@vger.kernel.org
 S:	Supported
 B:	https://bugzilla.kernel.org




