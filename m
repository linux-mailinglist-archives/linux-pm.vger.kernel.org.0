Return-Path: <linux-pm+bounces-36027-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A2EBD72BA
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 05:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8813C3515CB
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 03:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AF2257AD3;
	Tue, 14 Oct 2025 03:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="furKCoEl"
X-Original-To: linux-pm@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD21306494;
	Tue, 14 Oct 2025 03:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760411791; cv=none; b=X//iLaV9eyTxa7+peK3Jrzcjl6qZEuw6xgvk3KPCVpPeLvJvjw1I78qYns3DlugTvWGA8eHx/jmcw2/wQP7WIXf8rgEuIUNEBKj9fu1lOj6yKtOAJAfzOVuoLREnUh6epDJ5dNAJKGpioKt2Q5BSHc+kPyp+H+9udfg5Y0t82Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760411791; c=relaxed/simple;
	bh=Juc/Ajm/GlPGt5lxFcH4KCCulPGEMuMVo6qNVmRRKK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HxphiNHTqFApFzT1Y/SedoP4I1nkJiZguQN45cgauojvOcHmsk7vqWX1kRIK4P55AABsQy1LjWucbcggDIMXu8PxVXNOIPmvmPv4LP2OsVi7yy7L+kFN3hnIYSTm3hNqw0Pu5ioJVA5JI9IIZfABbSA9uN/9LwSt2GxG7vLWI7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=furKCoEl; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=qtet+JxpkGrJkedZ4q4cNXrn6sTB1GucoB6M5xSB0L0=; b=furKCoElTccKoxRbFVG3Gbxr/y
	qB0Y9PkN81mHx4/tAWeO6JSsuXydilGOU8sNobQyg+rF2t1f+BRunSpqI4PovuTUOZqYq7n1Mwake
	c2Yx9X09LQ05VILRUd0GxppJsOlhQr9a/OS+VSyWO1nOiEKwv5FZsniHxzKSxaBeDcCl7cW0bVS37
	A0CzHrKYPtJOKeGkvW64YN5KHQ7UJOqQJWQLDYNGTAUZFqmPlPf57oPVLQJFiNNV1c78DsUJBHhe8
	j6ZZJKsJLS2oUS4x9LrZMQc0jbvMv9jNZonmhBI8V7JvObkXyk9bSBt5+ubvr9F275JPhjFmBD3vs
	OaMxd9Dg==;
Received: from [50.53.43.113] (helo=smtpauth.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8VWP-00000004sx3-1385;
	Tue, 14 Oct 2025 03:16:26 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Sebastian Reichel <sre@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH] docs: power: clean up power_supply_class.rst
Date: Mon, 13 Oct 2025 20:16:15 -0700
Message-ID: <20251014031617.764429-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Clean up grammar, punctuation, etc., in the power supply class
documentation.

Add article adjectives where needed.
Hyphenate some adjectives.
Fix punctuation.
Fix some verb usage (singular/plural).
Fix run-on sentences.
Add "is" in a few places.
Change "QA" to "Q&A".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Sebastian Reichel <sre@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: linux-pm@vger.kernel.org
---
 Documentation/power/power_supply_class.rst |   84 +++++++++----------
 1 file changed, 42 insertions(+), 42 deletions(-)

--- linux-next-20251013.orig/Documentation/power/power_supply_class.rst
+++ linux-next-20251013/Documentation/power/power_supply_class.rst
@@ -7,35 +7,35 @@ Synopsis
 Power supply class used to represent battery, UPS, AC or DC power supply
 properties to user-space.
 
-It defines core set of attributes, which should be applicable to (almost)
+It defines a core set of attributes which should be applicable to (almost)
 every power supply out there. Attributes are available via sysfs and uevent
 interfaces.
 
-Each attribute has well defined meaning, up to unit of measure used. While
+Each attribute has a well-defined meaning, up to unit of measure used. While
 the attributes provided are believed to be universally applicable to any
 power supply, specific monitoring hardware may not be able to provide them
 all, so any of them may be skipped.
 
-Power supply class is extensible, and allows to define drivers own attributes.
-The core attribute set is subject to the standard Linux evolution (i.e.
-if it will be found that some attribute is applicable to many power supply
-types or their drivers, it can be added to the core set).
+The power supply class is extensible and allows drivers to define their own
+attributes.  The core attribute set is subject to the standard Linux evolution
+(i.e., if it will be found that some attribute is applicable to many power
+supply types or their drivers, it can be added to the core set).
 
-It also integrates with LED framework, for the purpose of providing
+It also integrates with the LED framework, for the purpose of providing
 typically expected feedback of battery charging/fully charged status and
 AC/USB power supply online status. (Note that specific details of the
 indication (including whether to use it at all) are fully controllable by
-user and/or specific machine defaults, per design principles of LED
-framework).
+user and/or specific machine defaults, per design principles of the LED
+framework.)
 
 
 Attributes/properties
 ~~~~~~~~~~~~~~~~~~~~~
-Power supply class has predefined set of attributes, this eliminates code
-duplication across drivers. Power supply class insist on reusing its
+The power supply class has a predefined set of attributes. This eliminates code
+duplication across drivers. The power supply class insists on reusing its
 predefined attributes *and* their units.
 
-So, userspace gets predictable set of attributes and their units for any
+So, userspace gets a predictable set of attributes and their units for any
 kind of power supply, and can process/present them to a user in consistent
 manner. Results for different power supplies and machines are also directly
 comparable.
@@ -61,7 +61,7 @@ Attributes/properties detailed
 |               **Charge/Energy/Capacity - how to not confuse**            |
 +--------------------------------------------------------------------------+
 | **Because both "charge" (µAh) and "energy" (µWh) represents "capacity"   |
-| of battery, this class distinguish these terms. Don't mix them!**        |
+| of battery, this class distinguishes these terms. Don't mix them!**      |
 |                                                                          |
 | - `CHARGE_*`                                                             |
 |	attributes represents capacity in µAh only.                        |
@@ -81,7 +81,7 @@ _NOW
 
 STATUS
   this attribute represents operating status (charging, full,
-  discharging (i.e. powering a load), etc.). This corresponds to
+  discharging (i.e., powering a load), etc.). This corresponds to
   `BATTERY_STATUS_*` values, as defined in battery.h.
 
 CHARGE_TYPE
@@ -92,10 +92,10 @@ CHARGE_TYPE
 
 AUTHENTIC
   indicates the power supply (battery or charger) connected
-  to the platform is authentic(1) or non authentic(0).
+  to the platform is authentic(1) or non-authentic(0).
 
 HEALTH
-  represents health of the battery, values corresponds to
+  represents health of the battery. Values corresponds to
   POWER_SUPPLY_HEALTH_*, defined in battery.h.
 
 VOLTAGE_OCV
@@ -103,11 +103,11 @@ VOLTAGE_OCV
 
 VOLTAGE_MAX_DESIGN, VOLTAGE_MIN_DESIGN
   design values for maximal and minimal power supply voltages.
-  Maximal/minimal means values of voltages when battery considered
+  Maximal/minimal means values of voltages when battery is considered
   "full"/"empty" at normal conditions. Yes, there is no direct relation
   between voltage and battery capacity, but some dumb
   batteries use voltage for very approximated calculation of capacity.
-  Battery driver also can use this attribute just to inform userspace
+  A battery driver also can use this attribute just to inform userspace
   about maximal and minimal voltage thresholds of a given battery.
 
 VOLTAGE_MAX, VOLTAGE_MIN
@@ -122,16 +122,16 @@ CURRENT_BOOT
   Reports the current measured during boot
 
 CHARGE_FULL_DESIGN, CHARGE_EMPTY_DESIGN
-  design charge values, when battery considered full/empty.
+  design charge values, when battery is considered full/empty.
 
 ENERGY_FULL_DESIGN, ENERGY_EMPTY_DESIGN
   same as above but for energy.
 
 CHARGE_FULL, CHARGE_EMPTY
-  These attributes means "last remembered value of charge when battery
-  became full/empty". It also could mean "value of charge when battery
+  These attributes mean "last remembered value of charge when battery
+  became full/empty". They also could mean "value of charge when battery is
   considered full/empty at given conditions (temperature, age)".
-  I.e. these attributes represents real thresholds, not design values.
+  I.e., these attributes represents real thresholds, not design values.
 
 ENERGY_FULL, ENERGY_EMPTY
   same as above but for energy.
@@ -153,12 +153,12 @@ CHARGE_TERM_CURRENT
 CONSTANT_CHARGE_CURRENT
   constant charge current programmed by charger.
 
-
 CONSTANT_CHARGE_CURRENT_MAX
   maximum charge current supported by the power supply object.
 
 CONSTANT_CHARGE_VOLTAGE
   constant charge voltage programmed by charger.
+
 CONSTANT_CHARGE_VOLTAGE_MAX
   maximum charge voltage supported by the power supply object.
 
@@ -208,10 +208,10 @@ TEMP_MAX
 
 TIME_TO_EMPTY
   seconds left for battery to be considered empty
-  (i.e. while battery powers a load)
+  (i.e., while battery powers a load)
 TIME_TO_FULL
   seconds left for battery to be considered full
-  (i.e. while battery is charging)
+  (i.e., while battery is charging)
 
 
 Battery <-> external power supply interaction
@@ -220,13 +220,13 @@ Often power supplies are acting as suppl
 time. Batteries are good example. So, batteries usually care if they're
 externally powered or not.
 
-For that case, power supply class implements notification mechanism for
+For that case, the power supply class implements a notification mechanism for
 batteries.
 
-External power supply (AC) lists supplicants (batteries) names in
+An external power supply (AC) lists supplicants (batteries) names in
 "supplied_to" struct member, and each power_supply_changed() call
-issued by external power supply will notify supplicants via
-external_power_changed callback.
+issued by an external power supply will notify supplicants via
+the external_power_changed callback.
 
 
 Devicetree battery characteristics
@@ -241,14 +241,14 @@ battery node have names corresponding to
 for naming consistency between sysfs attributes and battery node properties.
 
 
-QA
-~~
+Q&A
+~~~
 
 Q:
    Where is POWER_SUPPLY_PROP_XYZ attribute?
 A:
-   If you cannot find attribute suitable for your driver needs, feel free
-   to add it and send patch along with your driver.
+   If you cannot find an attribute suitable for your driver needs, feel free
+   to add it and send a patch along with your driver.
 
    The attributes available currently are the ones currently provided by the
    drivers written.
@@ -258,18 +258,18 @@ A:
 
 
 Q:
-   I have some very specific attribute (e.g. battery color), should I add
+   I have some very specific attribute (e.g., battery color). Should I add
    this attribute to standard ones?
 A:
    Most likely, no. Such attribute can be placed in the driver itself, if
-   it is useful. Of course, if the attribute in question applicable to
-   large set of batteries, provided by many drivers, and/or comes from
+   it is useful. Of course, if the attribute in question is applicable to
+   a large set of batteries, provided by many drivers, and/or comes from
    some general battery specification/standard, it may be a candidate to
    be added to the core attribute set.
 
 
 Q:
-   Suppose, my battery monitoring chip/firmware does not provides capacity
+   Suppose my battery monitoring chip/firmware does not provide capacity
    in percents, but provides charge_{now,full,empty}. Should I calculate
    percentage capacity manually, inside the driver, and register CAPACITY
    attribute? The same question about time_to_empty/time_to_full.
@@ -278,11 +278,11 @@ A:
    directly measurable by the specific hardware available.
 
    Inferring not available properties using some heuristics or mathematical
-   model is not subject of work for a battery driver. Such functionality
+   model is not a subject of work for a battery driver. Such functionality
    should be factored out, and in fact, apm_power, the driver to serve
-   legacy APM API on top of power supply class, uses a simple heuristic of
+   legacy APM API on top of the power supply class, uses a simple heuristic of
    approximating remaining battery capacity based on its charge, current,
-   voltage and so on. But full-fledged battery model is likely not subject
-   for kernel at all, as it would require floating point calculation to deal
-   with things like differential equations and Kalman filters. This is
+   voltage and so on. But a full-fledged battery model is likely not a subject
+   for the kernel at all, as it would require floating point calculations to
+   deal with things like differential equations and Kalman filters. This is
    better be handled by batteryd/libbattery, yet to be written.

