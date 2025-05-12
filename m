Return-Path: <linux-pm+bounces-27045-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0460AAB391A
	for <lists+linux-pm@lfdr.de>; Mon, 12 May 2025 15:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25C793BC828
	for <lists+linux-pm@lfdr.de>; Mon, 12 May 2025 13:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C470294A1E;
	Mon, 12 May 2025 13:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="MBXUqKSe"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4476F4C9F;
	Mon, 12 May 2025 13:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747056418; cv=none; b=DgwASnCQTzupq9aXyZaVECvmseoeEduaXcA+S02zKHja3UXbHjf8eL+YpEn1o+KL743ZKvAOm4UyqL3JshwCw1Ttez7Am2O4NJNDRDRe5flH851lG3l7LCcQM5VjebUWxk+k8NraSIp4fAiAGQR9GQs8atRTb4Pxl+pskdnpJhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747056418; c=relaxed/simple;
	bh=5SYSxtirN3S0+dRopywjB9WAaqvLRtBwRqG/ATTUwMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PRSHODpFoORKWalGiiHZzLHdFvdW5/55TvvxCZ/9xNAWT9JcnTWH22vaRv3Vbn/DHdqSL+QoD6gSCSdxjhZJZRbW6pv7EfctnsJToyhCKLsM44P3zpqrXYzU65wpm3Er0Vezp0tMxdFjVCPQVShGFKQAaz3IqaeumcCon6yjkog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=MBXUqKSe; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [217.114.34.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id AD92A666D36;
	Mon, 12 May 2025 15:26:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1747056414;
	bh=5SYSxtirN3S0+dRopywjB9WAaqvLRtBwRqG/ATTUwMM=;
	h=From:Subject:Date;
	b=MBXUqKSeBe68Qa6GWehjFXth20CtjVIVKN546eRr9nDz+sZoHyPAtHDgACUPqoG2Y
	 VmogAeGXvg3ymWjYmfa3NBfNg3nK7BKZuNvMCtRrnGSYsLQK6B7nTRZiQNfXEaqeq/
	 FNrHnzidEm+gqA8Ej8pRa/H2ibirjZJ3tVgbkscGFbvpUxTJ8KGnHD70MknQTovYPG
	 obx/AArd235ZvJrVBafSD7rK4/zB7eNxjpWfvlziBdwGvP5iqpkCgJyBvIF8ze6s7b
	 UFHU9LKvrMDV/2F5QIsv2WtclQ7QRR97CpVEDCnFOi7Ds1LfNjqISk1q1fjcECStSk
	 y+NhVxMAmf7jQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
 Saravana Kannan <saravanak@google.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org
Subject: [PATCH v1] ucsi_ccg: Disable async suspend in ucsi_ccg_probe()
Date: Mon, 12 May 2025 15:26:53 +0200
Message-ID: <6180608.lOV4Wx5bFT@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 217.114.34.19
X-CLIENT-HOSTNAME: 217.114.34.19
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddufeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgeffhfdujeelhfdtgeffkeetudfhtefhhfeiteethfekvefgvdfgfeeikeeigfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddujedruddugedrfeegrdduleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudejrdduudegrdefgedrudelpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhonhgrthhhrghnhhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepshgrrhgrvhgrnhgrkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohephhgvihhkkhhirdhkrhh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Jon Hunter <jonathanh@nvidia.com>

Commit aa7a9275ab81 ("PM: sleep: Suspend async parents after suspending
children") had triggered a suspend issue on Tegra boards because it had
reordered the syspend of devices with async suspend enabled with respect
to some other devices.  Specifically, the devices with async suspend
enabled that have no children are now suspended before any other devices
unless there are device links pointing to them as suppliers.

The investigation that followed the failure report uncovered that async
suspend was enabled for the cypd4226 device that was a Type-C controller
with a dependency on USB PHY and it turned out that disabling async
suspend for that device made the issue go away.  Since async suspend
takes dependencies between parents and children into account as well
as other dependencies between devices represented by device links, this
means that the cypd4226 has a dependency on another device that is
not represented in any form in the kernel (a "hidden" dependency), in
which case async suspend should not be enabled for it.

Accordingly, make ucsi_ccg_probe() disable async suspend for the
devices handled by, which covers the cypd4226 device on the Tegra
boards as well as other devices likely to have similar "hidden"
dependencies.

Fixes: aa7a9275ab81 ("PM: sleep: Suspend async parents after suspending children")
Closes: https://lore.kernel.org/linux-pm/c6cd714b-b0eb-42fc-b9b5-4f5f396fb4ec@nvidia.com/
Reported-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Commit aa7a9275ab81 is in linux-next and it has not reached the mainline yet.

Thanks!

---
 drivers/usb/typec/ucsi/ucsi_ccg.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -1483,6 +1483,8 @@
 
 	i2c_set_clientdata(client, uc);
 
+	device_disable_async_suspend(uc->dev);
+
 	pm_runtime_set_active(uc->dev);
 	pm_runtime_enable(uc->dev);
 	pm_runtime_use_autosuspend(uc->dev);




