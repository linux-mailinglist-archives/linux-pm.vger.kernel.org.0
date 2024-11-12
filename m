Return-Path: <linux-pm+bounces-17374-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D38849C4E24
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 06:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92F81286D6B
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 05:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB5120A5ED;
	Tue, 12 Nov 2024 05:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="SAzbASsQ";
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GMgjvh8i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n/ZqWwrM"
X-Original-To: linux-pm@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EF41A3BDE;
	Tue, 12 Nov 2024 05:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731388938; cv=none; b=uMn7v3nmuqxLQyNeK1Ke5G/E1S6leRlBr2vJMAeE2VG9xWKklaP5ao5E2ztaJXAzLGnBKbHtvwsvWDqdAQsvgn4gVk3oEXkrorwEkc1twP4HBFGRatZv3o+RkSRhcUCwQJ/I6KqU3+FAWKTOzjlABoLojQ7dfJzS8V70w8A5PTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731388938; c=relaxed/simple;
	bh=1e+Tc2DW78hIcS81YoDcnInvTNlfYkBlO6mo88FyfgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FWPTX2xyvcn4N+woF47Ummf57+BiiBhM/stpkR4oLT4CI41aM8eYv9mW2y4Ex3cih8mRS5s+FPFL0HneHG1Wd70Nqgw2TibfXwOiUzA70bHv6z2N5STKM8aX1CB9+4DV1rG83gA9HKbPgHDxDOrH6IoVYqUYvAtLXlzAhdVsrC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=SAzbASsQ; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GMgjvh8i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n/ZqWwrM; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EAD1111401C7;
	Tue, 12 Nov 2024 00:22:14 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 12 Nov 2024 00:22:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=2016-12.pbsmtp; t=1731388934;
	 x=1731475334; bh=qo85hZPOEbaIqOSv3+i46F4vrPDjYiXGCZHA8L//gAc=; b=
	SAzbASsQtvEGTn6mN69VvnE6mYNa2idz9BJ36JSbOGoY6pRs3YTbFvu/LIUym57+
	rLN5aCO1Lj7j6JO06Ev4cQjQHd46NnJmoJpuzqw1VdY1dtBaZk2bbus0z0bDzMhP
	FsxXL5p6r9NuVw3rkA2MoZLwJc+cZDhGEL2GkpExeWI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1731388934; x=
	1731475334; bh=qo85hZPOEbaIqOSv3+i46F4vrPDjYiXGCZHA8L//gAc=; b=G
	Mgjvh8i/dJiXt5TOxJxFqezqkuz+VuhJEwt69MiwaRkwVSn9P3MfD9N77m7zleIL
	QjiqCBVvxHITNIK1k3X7+bL+44xypePVF8uPGxb9fCOBC+Z+xbtPUSMoQnH8i8UL
	ss0SkaYJoM181p31tRPdb5ixGQ155bEFRgNiNylrHkrWQSnDngArmLeztfrVg5bx
	ZizoNV5sYv+cxw5+X3llWkWCD16cY3hCsYGrM9mm7ScJmb7e6hQON4rJl2ezK5gh
	lXLVLybksha/oGVzpBzI3A7vU5CCkzYo+YIasHhtHc57nyeaS0ShZfOoOBTzgWJX
	PZh4KHftSNZ3f2ciER+0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1731388934; x=1731475334; bh=q
	o85hZPOEbaIqOSv3+i46F4vrPDjYiXGCZHA8L//gAc=; b=n/ZqWwrMp0CBV09IW
	Knoyc+AVPw31MPaBCdbKNuTVXoP5h39eXs40uOplBGTw2HgwndLsviord0vBWmw7
	xGVOChqnropKn334GxbI7pB03jgpS2gs0kDoT3qcNEFAplj3XRsUOcxXLZ+mrsa8
	6Z7BgkOiza72nRWN9GxH+nxmeK9e5ki7QQg3SADDTKnOXdbEREH/iwJgkELZhwY0
	fBhIpnF8b2xGEAAdXx8ruyL0U6QjhjbFnJfTzmKUMVLZWlOQirtwlZpIE+JKA7+D
	tbxGQz7Bik90xb6Eda3CRENKuBum8WoYGeucXzgccYMwQE91MimWIMRXT77eZmPj
	kZBow==
X-ME-Sender: <xms:BuYyZ_ZT3EDDkgetNlrV8hCHrZKlUMgb1Ik27MHm-ox0MZqwUfVpIw>
    <xme:BuYyZ-bf_JM3WxgKSGGwejB8h1ll-4F9rW_gCnHx9jCIkLd2T1hgCJmuRhxo1-k01
    Ms8rhmBmpsJnavBPe0>
X-ME-Received: <xmr:BuYyZx9RPAexH7CwL7kbQJWavkk-MON5B8cPrtHm6lLlC4sdYIj2NI6I7lwj-Ux0ruE00NxqPQyFDxqUvmVhj8GIO0i6xqANyfIOYlf3X89fNu_JxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgdekvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecu
    hfhrohhmpefpihgtohhlrghsucfrihhtrhgvuceonhhitghosehflhhugihnihgtrdhnvg
    htqeenucggtffrrghtthgvrhhnpedtjeeuieeiheeiueffuddvffelheekleegkedukeef
    fffhudffudegvdetiefhteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehnihgtohesfhhluhignhhitgdrnhgvthdpnhgspghrtghpthhtohep
    kedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprggsrghilhhonhessggrhihlih
    gsrhgvrdgtohhmpdhrtghpthhtohepnhhpihhtrhgvsegsrgihlhhisghrvgdrtghomhdp
    rhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnh
    hivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhig
    qdhmvgguihgrthgvkheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtth
    hopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:BuYyZ1rQBzWwufkNanrhnfLO_jHFfm3Ib-98y838Z4Qp_8sSX3zLdA>
    <xmx:BuYyZ6pWwPR6UYVWpbg4MS-PciSIFWAXmiKdHI4JZTiK2t84FNCbXw>
    <xmx:BuYyZ7Q-YNUsiDc3bERo5ZYY7RNf5ZSx1xDp9X_0ltpJR74A7sHhoQ>
    <xmx:BuYyZyr83apf_ub3mZKl-v4udrdJgRZ_QZTymWIhhXhmUYg3vVbQIA>
    <xmx:BuYyZ527ecwBgpUEC2WrsD6YBOBdTa5SYsbJMn2cKuogUKTCXxbqKIuE>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 00:22:14 -0500 (EST)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id DA8FBECB7FE;
	Tue, 12 Nov 2024 00:22:13 -0500 (EST)
From: Nicolas Pitre <nico@fluxnic.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Nicolas Pitre <npitre@baylibre.com>,
	Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH 1/5] thermal: of: properly parse coefficients with multiple thermal-sensors entries
Date: Tue, 12 Nov 2024 00:19:38 -0500
Message-ID: <20241112052211.3087348-2-nico@fluxnic.net>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112052211.3087348-1-nico@fluxnic.net>
References: <20241112052211.3087348-1-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolas Pitre <npitre@baylibre.com>

The thermal zone DT binding description says:

      coefficients:
        $ref: /schemas/types.yaml#/definitions/uint32-array
        description:
          An array of integers containing the coefficients of a linear
          equation that binds all the sensors listed in this thermal zone.

          The linear equation used is as follows,
            z = c0 * x0 + c1 * x1 + ... + c(n-1) * x(n-1) + cn
          where c0, c1, .., cn are the coefficients.

          Coefficients default to 1 in case this property is not
          specified. The coefficients are ordered and are matched with
          sensors by means of the sensor ID. Additional coefficients are
          interpreted as constant offset.

And the code says:

        /*
         * For now, the thermal framework supports only one sensor per
         * thermal zone. Thus, we are considering only the first two
         * values as slope and offset.
         */

Furthermore, only bcm2711_thermal, bcm2835_thermal and ti-soc-thermal
use these values.

It is not clear how the equation in the bindings documentation should be
interpreted especially in the context of multiple sensors and sensor
aggregation. Assuming x0..xn are temperature values, coefficients have
to be fractional values otherwise the sum won't correspond to a
temperature anymore. So this patch interprets those coefficients as
per-sensor weight for determining the aggregated temperature value
instead. Also, in that context, constant offsets make no sense so they're
always set to 0. Because those weights are integer values, they must all be
provided otherwise they all default to 1.

To preserve backward compatibility, the current behavior is preserved
when "thermal-sensors" contains only one entry. The alternative
interpretation is applied only when "thermal-sensors" holds multiple
entries (which never happened so far).

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 drivers/thermal/thermal_of.c | 63 +++++++++++++++++++++++++++---------
 1 file changed, 47 insertions(+), 16 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 07e0989716..b8ddd41247 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -136,7 +136,8 @@ static struct thermal_trip *thermal_of_trips_init(struct device_node *np, int *n
 	return ERR_PTR(ret);
 }
 
-static struct device_node *of_thermal_zone_find(struct device_node *sensor, int id)
+static struct device_node *of_thermal_zone_find(struct device_node *sensor,
+						int id, int *index)
 {
 	struct device_node *np, *tz;
 	struct of_phandle_args sensor_specs;
@@ -179,6 +180,8 @@ static struct device_node *of_thermal_zone_find(struct device_node *sensor, int
 			if ((sensor == sensor_specs.np) && id == (sensor_specs.args_count ?
 								  sensor_specs.args[0] : 0)) {
 				pr_debug("sensor %pOFn id=%d belongs to %pOFn\n", sensor, id, child);
+				/* return index only if multiple entries exist */
+				*index = (count > 1) ? i : -1;
 				tz = no_free_ptr(child);
 				goto out;
 			}
@@ -213,11 +216,10 @@ static int thermal_of_monitor_init(struct device_node *np, int *delay, int *pdel
 	return 0;
 }
 
-static void thermal_of_parameters_init(struct device_node *np,
+static void thermal_of_parameters_init(struct device_node *np, int index,
 				       struct thermal_zone_params *tzp)
 {
-	int coef[2];
-	int ncoef = ARRAY_SIZE(coef);
+	int ncoef, count;
 	int prop, ret;
 
 	tzp->no_hwmon = true;
@@ -226,18 +228,46 @@ static void thermal_of_parameters_init(struct device_node *np,
 		tzp->sustainable_power = prop;
 
 	/*
-	 * For now, the thermal framework supports only one sensor per
-	 * thermal zone. Thus, we are considering only the first two
-	 * values as slope and offset.
+	 * If only one sensor is specified in "thermal-sensors" (index == -1)
+	 * then only the first two "coefficients" values are considered, and
+	 * used as slope and offset (legacy interpretation).
+	 *
+	 * If /thermal-sensors" contains more than one sensor then index
+	 * contains a positive value indicating the "coefficients" value of
+	 * interest. The listed sensors are meant to be aggregated and the
+	 * provided coefficients represent the relative weight among those
+	 * sensors. The slope field is used for that purpose while the offset
+	 * is always 0.
 	 */
-	ret = of_property_read_u32_array(np, "coefficients", coef, ncoef);
-	if (ret) {
-		coef[0] = 1;
-		coef[1] = 0;
+	tzp->slope = 1;
+	tzp->offset = 0;
+	if (index == -1) {
+		int coef[2];
+
+		ncoef = ARRAY_SIZE(coef);
+		ret = of_property_read_u32_array(np, "coefficients", coef, ncoef);
+		if (!ret) {
+			tzp->slope = coef[0];
+			tzp->offset = coef[1];
+		}
+	} else {
+		ncoef = of_property_count_u32_elems(np, "coefficients");
+		if (ncoef > 0) {
+			count = of_count_phandle_with_args(np, "thermal-sensors",
+							   "#thermal-sensor-cells");
+			if (ncoef != count) {
+				pr_err("%pOFn: sensors and coefficients mismatch\n", np);
+			} else {
+				int *coef = kmalloc(sizeof(*coef) * (index + 1),
+						    GFP_KERNEL);
+				if (coef &&
+				    of_property_read_u32_array(np, "coefficients",
+							       coef, (index + 1)) == 0)
+					tzp->slope = coef[index];
+				kfree(coef);
+			}
+		}
 	}
-
-	tzp->slope = coef[0];
-	tzp->offset = coef[1];
 }
 
 static struct device_node *thermal_of_zone_get_by_name(struct thermal_zone_device *tz)
@@ -386,9 +416,10 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 	const char *action;
 	int delay, pdelay;
 	int ntrips;
+	int index;
 	int ret;
 
-	np = of_thermal_zone_find(sensor, id);
+	np = of_thermal_zone_find(sensor, id, &index);
 	if (IS_ERR(np)) {
 		if (PTR_ERR(np) != -ENODEV)
 			pr_err("Failed to find thermal zone for %pOFn id=%d\n", sensor, id);
@@ -411,7 +442,7 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 		goto out_kfree_trips;
 	}
 
-	thermal_of_parameters_init(np, &tzp);
+	thermal_of_parameters_init(np, index, &tzp);
 
 	of_ops.should_bind = thermal_of_should_bind;
 
-- 
2.47.0


