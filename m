Return-Path: <linux-pm+bounces-21907-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E458CA317A7
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 22:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C67B53A03C7
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 21:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29E5269AEC;
	Tue, 11 Feb 2025 21:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="CHPt/RUh"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C52266589;
	Tue, 11 Feb 2025 21:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739309158; cv=none; b=Ok/lmXSOtAO0WkoG019PL9RRP93ME8/2k+zb/jJS6VeQMzCU2D2mwjK1F3bLr9UjJ6Shgu8MpRiHJDrRSX/ZurF0jUBMmGRKZmFTI+IyCKTAUNTXWwbUSOsAROzB2X/9bu3X33Za3DLbGejL3F7Ym0TJeyLZiRW8smiO44G5BaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739309158; c=relaxed/simple;
	bh=zVHK9tKkrrsUglkhVCFQZZeMj/6ZCvBq1S2weRFFqdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F/snKhzUDj7AWNrxUZL2lxtkhPc+XdH1r2EVUKju+rddeOFQ8wws/tuWtzSdswgRWkBxHc69JdNhm6GTeel8utYixQf8lKpSBTvxg3Nzs6QROB6cD2pA6C1wdl3urk1p7CrFuRXf/YVTLXaNamrjYoW4FczHvoWmEUf4kBt/OQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=CHPt/RUh; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id e027a457252b6505; Tue, 11 Feb 2025 22:25:49 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 100E6770175;
	Tue, 11 Feb 2025 22:25:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1739309149;
	bh=zVHK9tKkrrsUglkhVCFQZZeMj/6ZCvBq1S2weRFFqdk=;
	h=From:Subject:Date;
	b=CHPt/RUhm3cXLGMvxhiWdSgoVaBFqdO6LPDszthIOUdPfj8qeIHopckJZqaySZqpD
	 xqdg57J/xp/fjdJqc7bCR5z8kfjPUyo8VV1bwFrqQCaCvtmwPWQPRErx4KDyl3RUCQ
	 k6V1BTZ5Pxoy9mjSMMNFT4G8dTMs7/Mlv2bKKUF4l/yOXx5nsqD9fO6Cz30DHfmI1+
	 XcU8JpkGoBdtgy4K1vz2DzKxvDWs3udxxtxD655gZeturWF2v7gA4Xl0XlqiSlJTQf
	 rVKbZr+oiv8dZzOjynYjGdW2z0+eBhr8TpXLVrL5Q2LqeBQdyKY9h/VOAnspbBwWdT
	 JM4fkG0AZ/zOg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>,
 Johan Hovold <johan@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jon Hunter <jonathanh@nvidia.com>
Subject:
 [PATCH v1 04/10] PM: runtime: Drop status check from
 pm_runtime_force_resume()
Date: Tue, 11 Feb 2025 22:07:52 +0100
Message-ID: <6038511.MhkbZ0Pkbq@rjwysocki.net>
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

Since pm_runtime_force_resume() requires pm_runtime_force_suspend() to
be called before it on the same device, the runtime PM status of that
device is RPM_SUSPENDED when it is called unless the device's runtime
PM status is changed somewhere else in the meantime.

However, even if that happens, the power.needs_force_resume
check is still required to pass and that flag is only set by
pm_runtime_force_suspend() and it is cleared at the end of
pm_runtime_force_resume(), so it cannot be taken into account
twice in a row.

Accordingly, the pm_runtime_status_suspended(dev) check in
pm_runtime_force_resume() is redundant, so drop it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/runtime.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1963,7 +1963,7 @@
 	int (*callback)(struct device *);
 	int ret = 0;
 
-	if (!pm_runtime_status_suspended(dev) || !dev->power.needs_force_resume)
+	if (!dev->power.needs_force_resume)
 		goto out;
 
 	/*




