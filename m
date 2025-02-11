Return-Path: <linux-pm+bounces-21901-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4FCA3179D
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 22:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53C8E7A35A1
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 21:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C48F2641F3;
	Tue, 11 Feb 2025 21:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Qj7hL1Yt"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C088D2627EB;
	Tue, 11 Feb 2025 21:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739309156; cv=none; b=YePxszIC38zJ7y0FJU/wY75mP9Ju4Np91P/1ZLd2hWdi+QuU1ExSOzMD8K6GQ8fQD7tnPPDcGRfsoCHRq1HFcQfI195yEbPw7wKZm0F6BbFCm883Qx/y6bHKA/nnIhY3pgQotiD0A+BEsn2etVOq7P1Iw+5Ju+/ZJqGUt34b9XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739309156; c=relaxed/simple;
	bh=VuoTSEigWNJYu31OKoch+f2/NllpSnLp4IFoEBBOo+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KnM8R4sQ8pRicuW9XZNpH8WClMmhZn6hHsx31MBmKb2KCLfzbM0RT7IXWsGm1oyyT+UJGARdgRJ1x9K2+AhZ+TcNz8TbPUSyTrwEukZuQf5o+3o+VFUIiT3sgRGm1+pAyvXjcLqzvkZPMERD+MuQESv13aZMYWT9IPTqQgghbAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Qj7hL1Yt; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id cf83882a7dc398e9; Tue, 11 Feb 2025 22:25:44 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 371AD770175;
	Tue, 11 Feb 2025 22:25:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1739309144;
	bh=VuoTSEigWNJYu31OKoch+f2/NllpSnLp4IFoEBBOo+Y=;
	h=From:Subject:Date;
	b=Qj7hL1YtcpTwjSNbpGXCbnyb9gD7oW8SXlIH9yNV35gYEjLSZmUiG54x22N02VWoo
	 cYaw3rBdIDmYY0TNMw8VW9DHS4ss7r3DILJLoQWFJe3cmucOoiDlBdcID3VG1AqhrV
	 F6WPOdXXdBAHjQHkUWjWUCkd8YMRbpDoAvFSWncONqEtOorCFe5qF3M9bX1Tjc/irp
	 +beMIHRzLynd1B0In1mjuRyjTUtgwcXa8z8S2wvKQ7D5BUoPU6iCVIQ99/IItv1t4w
	 qB5qUEdn+02pqMbVuPAmz706uvmpu8LreJ/CCKuid1OKqd4mwoKYLqaSf9is/DzqV7
	 hjaqmPnKy67fA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>,
 Johan Hovold <johan@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jon Hunter <jonathanh@nvidia.com>
Subject:
 [PATCH v1 09/10] PM: sleep: Propagate power.set_active in dependency chains
Date: Tue, 11 Feb 2025 22:21:23 +0100
Message-ID: <47028492.fMDQidcC6G@rjwysocki.net>
In-Reply-To: <2314745.iZASKD2KPV@rjwysocki.net>
References: <2314745.iZASKD2KPV@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegvddtkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtvghrnhesrhhofihlrghnugdrhhgrrhhvrghrugdrvgguuhdprhgtphhtthhopehulhhfrdhhrghnshhsohhnsehlihhnrghrohdrohhrghdprhgtphhtthhopehjohhhrghnsehkvghrnhgvlhdrohhrghdprhgtphh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After preparing pm_runtime_force_resume() for dealing with devices
having power.set_active set, make the core propagate that flag in
dependency chains, so that subordinate device are resumed along with
the ones that they depend on, but take exceptions into account.

Namely, do not set power.set_active for devices that have never had
runtime PM enabled, for parents that have power.ignore_children set and
for suppliers coming from device links with DL_FLAG_PM_RUNTIME unset.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/main.c |   25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1189,18 +1189,31 @@
 	return PMSG_ON;
 }
 
+static void dpm_cond_set_active(struct device *dev, bool cond)
+{
+	if (cond && !pm_runtime_no_support(dev))
+		dev->power.set_active = true;
+}
+
 static void dpm_superior_set_must_resume(struct device *dev)
 {
+	bool set_active = dev->power.set_active;
 	struct device_link *link;
 	int idx;
 
-	if (dev->parent)
+	if (dev->parent) {
 		dev->parent->power.must_resume = true;
+		dpm_cond_set_active(dev->parent, set_active &&
+				    !dev->parent->power.ignore_children);
+	}
 
 	idx = device_links_read_lock();
 
-	list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node)
+	list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node) {
 		link->supplier->power.must_resume = true;
+		dpm_cond_set_active(link->supplier, set_active &&
+				    (link->flags & DL_FLAG_PM_RUNTIME));
+	}
 
 	device_links_read_unlock(idx);
 }
@@ -1277,13 +1290,7 @@
 		dev->power.must_resume = true;
 
 	if (dev->power.must_resume) {
-		if (dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) &&
-		    !pm_runtime_no_support(dev)) {
-			dev->power.set_active = true;
-			if (dev->parent && !dev->parent->power.ignore_children &&
-			    !pm_runtime_no_support(dev->parent))
-				dev->parent->power.set_active = true;
-		}
+		dpm_cond_set_active(dev, dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND));
 		dpm_superior_set_must_resume(dev);
 	}
 




