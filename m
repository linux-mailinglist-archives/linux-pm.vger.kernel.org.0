Return-Path: <linux-pm+bounces-18530-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0759E3AC7
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 14:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF008281183
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 13:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5D51B3929;
	Wed,  4 Dec 2024 13:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="yNRIddB0"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E124A33;
	Wed,  4 Dec 2024 13:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733317337; cv=none; b=AyS5PN9YpzFz86MMjV0OsZUlbbfcI9S5VFstwxCt+6/dVd2adJwOZlKKFXPAeKX9INQr+g+mmmJ3ZSpc+MamFJ46tNBUIdIQa+Vm8DUwXscIypusMOpdfOYXNgt5CeqloBgKtJDroSnnTu159O549VO8JbO0EA8H1KpWdOTzjjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733317337; c=relaxed/simple;
	bh=2f6+ZfJ66V2yVm3Va9NQ9julH0I/H15wAzhHr6xBEso=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WECbhOPJ0wZAL4JS/K+DbwRj/BfcWWfn34/vvVJ+3M9v6nnkH9QiX84w0mJW7ow45Oqo9bHBbOUVSgGNKOBBbX42ODmFFGJNsLjkCIMTS4VZ/h3i8NA/iAHTJxV06CQPRTl2G0gRzg6pp4sgaoanSEi6aLY53xORGTbUl04gAnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=yNRIddB0; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 46ef63e342e61e00; Wed, 4 Dec 2024 14:02:05 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id E5E0215F0345;
	Wed,  4 Dec 2024 14:02:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1733317325;
	bh=2f6+ZfJ66V2yVm3Va9NQ9julH0I/H15wAzhHr6xBEso=;
	h=From:Subject:Date;
	b=yNRIddB0U4vKNidNAxnaD7VRGwdeUzW1K070Gd4O7T8kUm8k7dNDmMgIJtDfhGDbT
	 tF/hqc06ngMJVLSzPjArmJpBDDQA+3pyv7zclQGYmoTJ2EHhPTJKt50EkdRXm48Skr
	 AWRbqO+hWZcWDBYwEfnh6++xmdZSTt4jPZm2T9vaGe0/CkE3lgzUyjXUIG8iG5RLPL
	 y4yTXyV68FV/OoFXmcbYUfFWlZm8hWWjFZT0ax4iKVle/yk+p17W3vyiN5wYOeQwlS
	 wWJqCayEh1DrzIbpwfH/dmScNTcIdXrRBfazkQrAqxKST+X+ovXlBxzMAlOpv2Cm6p
	 0Y16mBuD3RaZg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Saravana Kannan <saravanak@google.com>
Subject: [PATCH v1] PM: sleep: Update stale comment in device_resume()
Date: Wed, 04 Dec 2024 14:02:04 +0100
Message-ID: <2787627.mvXUDI8C0e@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrieehgdeggecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegoufhprghmkfhpucdlfedttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeffffffkefgheehffelteeiveeffeevhfelteejvddvieejjeelvdeiheeuveeuffenucfkphepudelhedrudefiedrudelrdelgeenucfuphgrmhfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuhhlfhdrhhgrnhhsshhonheslhhinhgrrhh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There is no function called __device_suspend() any more and it is still
mentioned in a comment in device_resume(), so update that comment.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -914,7 +914,7 @@ static void device_resume(struct device
 		goto Complete;
 
 	if (dev->power.direct_complete) {
-		/* Match the pm_runtime_disable() in __device_suspend(). */
+		/* Match the pm_runtime_disable() in device_suspend(). */
 		pm_runtime_enable(dev);
 		goto Complete;
 	}




