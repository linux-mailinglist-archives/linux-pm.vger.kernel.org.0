Return-Path: <linux-pm+bounces-22580-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE14BA3E5A0
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 21:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7CBA1890D4B
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 20:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF0A214A8B;
	Thu, 20 Feb 2025 20:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="W2DgbMPC"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07DF1E5B6C;
	Thu, 20 Feb 2025 20:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740082302; cv=none; b=Bty2zUUYN8t/r2tMGWZJSdE+GbXT5Nea4XGW7MJKu2fBuv7zbILO0AYvNkTOvwYRHIek/dh8KGH30OF8FOgelbO/XH44Txuurlqusy9UrxjaSfE75BmCODPybVVnEKvqG+1dYm/a6M3BV5Oqp383K12z3cmYneiGu6V9+jpgdxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740082302; c=relaxed/simple;
	bh=efbwLAeU7pVZg794qcAYGIhwXwPPzrbf1WSInF8qRIY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LtrPbnLniZnbGFrqn59eYSY9oh9xviCUat6JNPtAQNr52X+tuBZBIKxiTbvU0DW8WTgTaIGu9K2yUXIHBYHK5btTTVR8T//v96RAdGuSl0sKIJSev9MOIpUpKUkYEZeCzVL2qQjBV5cLsVb+3313lop7Qny4HyNHfKRCDZy8tgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=W2DgbMPC; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id c310307223f8c58a; Thu, 20 Feb 2025 21:11:30 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 2090C7F624E;
	Thu, 20 Feb 2025 21:11:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1740082290;
	bh=efbwLAeU7pVZg794qcAYGIhwXwPPzrbf1WSInF8qRIY=;
	h=From:Subject:Date;
	b=W2DgbMPC2W1np9Cnnj30fOWaPZrMrXDAENPXcJAkW4+h1iNkLAzV4ewMD+0Bhtrdt
	 92YOMbrRpyG61znjDb0Sib1/iayk/w+6pueLdp0ASjIBGGeCEdytcxLkz+iwLm5HX2
	 nT4TNgeKTta22DNVYrIJUMRthjO4+Ex8vFUwJI0RPnwtnpIymyZCU8ElNORgZn/OSY
	 E5Qvd5J233AK7jHXq3grozjvq+v9r4xEtlZGgrwvTnX5Lef+Cjifmex6LjnHU6k7Y8
	 0dkFB3F+XaH3/lipP3hZ8F7beosPbmKRl1kMNyCgH+gPl8dzlWK7gbW+c+452Hj3jX
	 TH4Lhh3bnkJiA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: [PATCH v2] cpuidle: intel_idle: Update MAINTAINERS
Date: Thu, 20 Feb 2025 21:11:29 +0100
Message-ID: <12621866.O9o76ZdvQC@rjwysocki.net>
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
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeikedtgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvghnsgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghrthgvmhdrsghithihuhhtshhkihihsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Update the intel_idle record in MAINTAINERS to reflect the current
state of affairs.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Add an alternative address for Artem and change his role to M.
   * Change the development git tree link.

---
 MAINTAINERS |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11669,12 +11669,14 @@
 F:	drivers/crypto/intel/iaa/*
 
 INTEL IDLE DRIVER
-M:	Jacob Pan <jacob.jun.pan@linux.intel.com>
-M:	Len Brown <lenb@kernel.org>
+M:	Rafael J. Wysocki <rafael@kernel.org>
+M:	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
+M:	Artem Bityutskiy <dedekind1@gmail.com>
+R:	Len Brown <lenb@kernel.org>
 L:	linux-pm@vger.kernel.org
 S:	Supported
 B:	https://bugzilla.kernel.org
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 F:	drivers/idle/intel_idle.c
 
 INTEL IDXD DRIVER




