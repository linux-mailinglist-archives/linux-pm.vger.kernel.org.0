Return-Path: <linux-pm+bounces-26262-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81444A9D621
	for <lists+linux-pm@lfdr.de>; Sat, 26 Apr 2025 01:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B39817BD00
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 23:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1732980D9;
	Fri, 25 Apr 2025 23:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="jRUyLRPX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D831A2980C0;
	Fri, 25 Apr 2025 23:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745622940; cv=none; b=GQpAzCqDmBmJM+DhtSkCMB7+bknAMdeDq+3d6Y8k9BOCxYDxNMBd7XVJaVKE6CLts12U7Uy3F6pLxyYDnOLWjZLajzu3G1VD2thmws53tJ7sVaGJPeYwPNmGOvWQBor3T7HrviuCmeyjDmwnK6NexALvqi7XbSPWVtxG5uFFwD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745622940; c=relaxed/simple;
	bh=sJvI5DDnIiRQGnkFxKkn+Cxq4BV8tpxPwmogGrRJ2iU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FcVemyKzTHWSpQW9PU8JsquJhtijxhVMg8p+XE8ws4TlATPlQt9uzGvE9nTrGFo9C3+M4KqsSg+ZZR2wrFA88F9AQ6zFSXyB1fG1Ufutwl+FXIWJ05lvq+cvK3i1eTzKHbaDCNYfTmdX/9p1VcCPuv0V6kdZOOe7sZlkauPkqv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=jRUyLRPX; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1745622925; x=1746227725; i=w_armin@gmx.de;
	bh=0rUv43ETiMFe1enqLd91Ly5onlIfjRxpLnkIvgpn2VY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=jRUyLRPXfQKY9gFmlq+9qJKDGl2GwDXb2rdAhsSu8iKHiVsooKgva93hGfZk2D6r
	 1KGRAEgAhXMbt/CoKUBdQHv5WSelAz59pbyxO17a62ZpqSnaJlmB71uQZ01OvQsCz
	 2lWuQPDfJi9LUMJp9hZygDeDHPNHDaj7xrXGYVARChqCS75+adUWZeCk7cBwjM59n
	 602/W0A70vK4jvv12TC4CmCtRJMaEy+NxJcl68g3dqYQ8eJ+M3aszJfvOn8HEBzv9
	 hyWYKQ+WShiPLk82Zt5xAohie+1Mn5yAhrsWd3mHl15F8D6LZX3ofxiJKH7BgRnW1
	 6b10oxCAsxXZ7XjiXA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([87.177.78.219]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MFsUv-1uJCJW0nlP-002ARP; Sat, 26 Apr 2025 01:15:25 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: sre@kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] power: supply: core: Add additional health status values
Date: Sat, 26 Apr 2025 01:15:15 +0200
Message-Id: <20250425231518.16125-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6T8llgOJu3W46o/D8JtsZVrp5ZCggKDQ2iqZnGMoMjiYgHVW5UJ
 VCHP8NradG+Lcm0tcpGYmjM3jQP5cpymOUUZ6WGFebWyO4XSCKSwQVNmGmGZvg1emJC2wJz
 Z7fzKM6cksNMSuF8For7bYUP6AvR1RUfthfNAS3FiqCF2ruseHwYm8+wHXXQP/mT1R5Pi6Z
 IyhjaOeAg/7LX9D7B8teg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:k3znlxVlhyU=;hT8vuGbdE23+x1n6qDCFeTMXuk+
 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

Some batteries can signal when an internal fuse was blown. In such a
case POWER_SUPPLY_HEALTH_DEAD is too vague for userspace applications
to perform meaningful diagnostics.

Additionally some batteries can also signal when some of their
internal cells are imbalanced. In such a case returning
POWER_SUPPLY_HEALTH_UNSPEC_FAILURE is again too vague for userspace
applications to perform meaningful diagnostics.

Add new health status values for both cases.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 Documentation/ABI/testing/sysfs-class-power | 2 +-
 drivers/power/supply/power_supply_sysfs.c   | 2 ++
 include/linux/power_supply.h                | 2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/A=
BI/testing/sysfs-class-power
index 2a5c1a09a28f..e84a7349f55f 100644
=2D-- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -456,7 +456,7 @@ Description:
 			      "Over voltage", "Under voltage", "Unspecified failure", "Cold",
 			      "Watchdog timer expire", "Safety timer expire",
 			      "Over current", "Calibration required", "Warm",
-			      "Cool", "Hot", "No battery"
+			      "Cool", "Hot", "No battery", "Fuse blown", "Cell imbalanced"
=20
 What:		/sys/class/power_supply/<supply_name>/precharge_current
 Date:		June 2017
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/sup=
ply/power_supply_sysfs.c
index edb058c19c9c..3a9c9cf55b30 100644
=2D-- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -110,6 +110,8 @@ static const char * const POWER_SUPPLY_HEALTH_TEXT[] =
=3D {
 	[POWER_SUPPLY_HEALTH_COOL]		    =3D "Cool",
 	[POWER_SUPPLY_HEALTH_HOT]		    =3D "Hot",
 	[POWER_SUPPLY_HEALTH_NO_BATTERY]	    =3D "No battery",
+	[POWER_SUPPLY_HEALTH_FUSE_BLOWN]	    =3D "Fuse blown",
+	[POWER_SUPPLY_HEALTH_CELL_IMBALANCED]	    =3D "Cell imbalanced",
 };
=20
 static const char * const POWER_SUPPLY_TECHNOLOGY_TEXT[] =3D {
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 888824592953..36454df14bc4 100644
=2D-- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -71,6 +71,8 @@ enum {
 	POWER_SUPPLY_HEALTH_COOL,
 	POWER_SUPPLY_HEALTH_HOT,
 	POWER_SUPPLY_HEALTH_NO_BATTERY,
+	POWER_SUPPLY_HEALTH_FUSE_BLOWN,
+	POWER_SUPPLY_HEALTH_CELL_IMBALANCED,
 };
=20
 enum {
=2D-=20
2.39.5


