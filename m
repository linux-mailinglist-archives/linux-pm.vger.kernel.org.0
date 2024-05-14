Return-Path: <linux-pm+bounces-7829-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 828E28C4F6F
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 12:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B40691C20B11
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 10:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DED13FD6C;
	Tue, 14 May 2024 10:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iQGTo686";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ALaxiZ1R"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E03126F05
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 10:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681944; cv=none; b=TbDmDnZ6CYnSOXh/NAqHtov0524Q0kRIjiDQqCf/5RNwZ1cWvH9n55HaSBQUyT4HhX+ow0I/wYMGBFBD7hQej6j3alIY8LfB+97y/LCqmh/nx+49L3yy96aqlDImRoBFfSyY7HLSTd+WUq2xNwfm/L7a5/kMn4jogWtPZAYV8NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681944; c=relaxed/simple;
	bh=YBHifpNQ7T58pLrE8yLm3eU57vSoVYCTZarY8+U4Cf0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=U4QjxY5qTmQzi138MGGlRiJufnKbCVF5nqkqBIElEC7Gtzt0ntl66K8D+tUBHMry5s1hJJAfN+NlGGv/Nwv1hj0JRmNIQ3SSHfWNgRtS6w9dZgqr3wpWs5/ZRT+9a7vOAW+tIQkQTt6NVBFlvlMKggr/ohRR1zKZWZJy4vgHYX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iQGTo686; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ALaxiZ1R; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 14 May 2024 10:18:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715681935;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IntE5KeTFgq89TjIn5D3EeveSFFisdLTYgdW5Z4OpTo=;
	b=iQGTo686NOccxJNV3WR8L8mmoTa5utSINreWJMRd+VVPXtwLCuM0k6ZhIIaoIckh1a+hL2
	7+SJq6Tyo0tMS+Kr24FdZRq+B04JFlcl9O92ZN5ROBSBHw47HGpyKxX544fpesZeWXVW9/
	tvVX6B5Rj9/XjClEcrXPrSUeFQfF+I7LkiPIiyPpBmjFlG1bSzXyCy3DimfDpT+BgsGtkG
	xK3JoG3kx/6w+qh20oy5sEhIF/OP5PDtDB92+0SQHLhTEFlKv0E0hh2hXm0wfJDzhA7tTL
	M3RXQtpjA9DdqfqIlUKyMK75q4CjbmmQ5pkmAsxMRMEcNZzFcnAxKg6bWZ7fOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715681935;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IntE5KeTFgq89TjIn5D3EeveSFFisdLTYgdW5Z4OpTo=;
	b=ALaxiZ1R8NaYEoyBYyzkKk1arMif1sVPx2gDxpyuUe68Y96WuIrbV5l7LgLrg4SM6k5l85
	DvtHMFbSpYCesDCg==
From: "thermal-bot for Dmitry Rokosov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/fixes] dt-bindings: thermal: amlogic: add support
 for A1 thermal sensor
Cc: Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
 amitk@kernel.org
In-Reply-To: <20240328191322.17551-2-ddrokosov@salutedevices.com>
References: <20240328191322.17551-2-ddrokosov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171568193553.10875.492298160549864205.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the thermal/fixes branch of thermal:

Commit-ID:     63d96b1253169126a791d6b1b0ef2e708ffb0d75
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//63d96b1253169126a791d6b1b0ef2e708ffb0d75
Author:        Dmitry Rokosov <ddrokosov@salutedevices.com>
AuthorDate:    Thu, 28 Mar 2024 22:13:10 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Apr 2024 12:40:29 +02:00

dt-bindings: thermal: amlogic: add support for A1 thermal sensor

Provide right compatible properties for Amlogic A1 Thermal Sensor
controller. A1 family supports only one thermal node - CPU thermal
sensor.

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20240328191322.17551-2-ddrokosov@salutedevices.com
---
 Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml | 12 ++++---
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
index 20f8f9b..01fccdf 100644
--- a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
@@ -13,11 +13,13 @@ description: Binding for Amlogic Thermal
 
 properties:
   compatible:
-    items:
-      - enum:
-          - amlogic,g12a-cpu-thermal
-          - amlogic,g12a-ddr-thermal
-      - const: amlogic,g12a-thermal
+    oneOf:
+      - items:
+          - enum:
+              - amlogic,g12a-cpu-thermal
+              - amlogic,g12a-ddr-thermal
+          - const: amlogic,g12a-thermal
+      - const: amlogic,a1-cpu-thermal
 
   reg:
     maxItems: 1

