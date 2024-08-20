Return-Path: <linux-pm+bounces-12541-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 991B39580BE
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 10:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5668F285C6F
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 08:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA08E17B4ED;
	Tue, 20 Aug 2024 08:19:47 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from spindle.queued.net (spindle.queued.net [45.33.49.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E58418E347;
	Tue, 20 Aug 2024 08:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.49.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724141987; cv=none; b=s0L4JSG79wOH47cSMMVV2/mzpQhxr71WDHvTr2vJ4aUzMxz35o7DttI2WNUd06crjL1/tPK8FzN0TQCgbFrDa/rVUb8Xpg14ESKmW91S7uN9neOT5eikhDWPwfS7IV89jbdS5dwM1fWq0NSH5JAmdaICq8fohDdpQaupHY3NoRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724141987; c=relaxed/simple;
	bh=s2EB4CCD8Xx3TNBh1leYmvFl65jleIjHR51ZXN+qRu0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=R1RotlaJdZx9NTyoLThlEjGNXGb/F9NIHIlaVAzX/4kZKY+0Ky1O5JC9h+8BgNhLbxt+BLz5pcYJzx9oCdEBLnuwEA18Q5xuLidbdis6miNKTlS2Wn21PNX7HgWc3ptXW5pm/xRrOCrijzzEJvQuKuIr9MJFXz3tQ1xpiUfrgDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net; spf=pass smtp.mailfrom=queued.net; arc=none smtp.client-ip=45.33.49.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queued.net
Received: by spindle.queued.net (Postfix, from userid 1001)
	id BC58C10AE50; Tue, 20 Aug 2024 04:19:45 -0400 (EDT)
Received: from 5400 (unknown [172.56.34.244])
	by spindle.queued.net (Postfix) with ESMTPSA id 6582810A7A2;
	Tue, 20 Aug 2024 04:19:44 -0400 (EDT)
Date: Tue, 20 Aug 2024 04:19:42 -0400
From: Andres Salomon <dilinger@queued.net>
To: linux-kernel@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Hans de
 Goede <hdegoede@redhat.com>, Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Subject: [PATCH] ABI: testing: sysfs-class-power: clarify charge_type
 documentation
Message-ID: <20240820041942.30ed42f3@5400>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.2.5

The existing docs here are a bit vague. This reformats and rewords it,
and is based upon the wording originally used by the dell-laptop driver
battery documentation and also sysfs-class-power-wilco.

The wording for "Long Life" and "Bypass" remain the same, because I'm
unfamiliar with hardware that use them.

Signed-off-by: Andres Salomon <dilinger@queued.net>
---
 Documentation/ABI/testing/sysfs-class-power | 38 +++++++++++++++------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 7c81f0a25a48..84973f66b42c 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -377,17 +377,33 @@ What:		/sys/class/power_supply/<supply_name>/charge_type
 Date:		July 2009
 Contact:	linux-pm@vger.kernel.org
 Description:
-		Represents the type of charging currently being applied to the
-		battery. "Trickle", "Fast", and "Standard" all mean different
-		charging speeds. "Adaptive" means that the charger uses some
-		algorithm to adjust the charge rate dynamically, without
-		any user configuration required. "Custom" means that the charger
-		uses the charge_control_* properties as configuration for some
-		different algorithm. "Long Life" means the charger reduces its
-		charging rate in order to prolong the battery health. "Bypass"
-		means the charger bypasses the charging path around the
-		integrated converter allowing for a "smart" wall adaptor to
-		perform the power conversion externally.
+		Select the charging algorithm to use for a battery.
+
+		Standard:
+			Fully charge the battery at a moderate rate.
+		Fast:
+			Quickly charge the battery using fast-charge
+			technology. This is typically harder on the battery
+			than standard charging and may lower its lifespan.
+		Trickle:
+			Users who primarily operate the system while
+			plugged into an external power source can extend
+			battery life with this mode. Vendor tooling may
+			call this "Primarily AC Use".
+		Adaptive:
+			Automatically optimize battery charge rate based
+			on typical usage pattern.
+		Custom:
+			Use the charge_control_* properties to determine
+			when to start and stop charging. Advanced users
+			can use this to drastically extend battery life.
+		Long Life:
+			The charger reduces its charging rate in order to
+			prolong the battery health.
+		Bypass:
+			The charger bypasses the charging path around the
+			integrated converter allowing for a "smart" wall
+			adaptor to perform the power conversion externally.
 
 		Access: Read, Write
 
-- 
2.39.2



-- 
I'm available for contract & employment work, please contact me if
interested.

