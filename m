Return-Path: <linux-pm+bounces-42849-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHicA0A2lmkkcQIAu9opvQ
	(envelope-from <linux-pm+bounces-42849-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 22:59:28 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E50BE15A7C0
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 22:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 47761300C0FB
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 21:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E510033509B;
	Wed, 18 Feb 2026 21:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TzAKuSU8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE84C3090E8;
	Wed, 18 Feb 2026 21:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771451963; cv=none; b=BWh3OE5zZm1U7M/Fm9qQNEz/xS5ynm54JGtnhINWQr3IYECun8VXPuIuTiMmflNdTYoyImHeuDTmwJCixuOjrjkzjHUDrFCzVl9gSwZmeKos/7ZuBMpykI6U+gAlIMytHXoQ6mU1ed9FSia8wkGkyX+0t56nP5IixygBkywqczs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771451963; c=relaxed/simple;
	bh=5L1aAyrT1CnMHAdDXtMxEsg5bTIoOtEBzpy9bU5cmQo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hW+kiypQdpZaEnz+WTLIvTlJtp9Wve0fOmYgqgAseZGdo6OLeem83rne5HGdIVUXlezuIVRwzQuJVdoxav59z0aQBqkJrQVIoUGHklYhvCIZ9h9jge9G6HQuMS07y75z4o6g4LJEo8lCD8PD5D6syBaNnUiLXYmiNyS1N+TLM+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TzAKuSU8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C71CC2BCAF;
	Wed, 18 Feb 2026 21:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771451963;
	bh=5L1aAyrT1CnMHAdDXtMxEsg5bTIoOtEBzpy9bU5cmQo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TzAKuSU8q4PWNIw9mzL6v7EV+n7kaa7Ci5s0xadpKwRQkPqK01q1Bu5JIhJW0OVaA
	 7lWjX3QrYE59vV7ZfB91Icjye2zsl+1+lsIqked9DMYucC8O4Edboawi7C0fJ/0C0/
	 btqoHQDqDqqb0PGNt+KHNQZ2RURca+z6DEGB7cYJlt5fdnYJWNL+1aShBIwYWubIan
	 Pd8cfahSXtB1Z8tcnU2UDpD7fcmuypkBfXvMG4cr63hyB0DxSsQq7Kd8xhOQxz5ghu
	 MN5w44PwJQPXp1cmAE6UBEeSQED6SRswfRlJ1xBHHsxAb+jJsCIoXb9rPb30UuxxGC
	 tRlAsOwzVqX/Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B66E9A04E;
	Wed, 18 Feb 2026 21:59:23 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Date: Wed, 18 Feb 2026 21:59:12 +0000
Subject: [PATCH v7 4/6] lib/linear_ranges: Add
 linear_range_get_selector_high_array
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-max77759-charger-v7-4-e8d907ce69c5@google.com>
References: <20260218-max77759-charger-v7-0-e8d907ce69c5@google.com>
In-Reply-To: <20260218-max77759-charger-v7-0-e8d907ce69c5@google.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Lee Jones <lee@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Mark Brown <broonie@kernel.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>, 
 Amit Sunil Dhamne <amitsd@google.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771451962; l=3072;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=66O0TCiwwg6+0syFe+iqI5+JzrTIE96SPH1q/Ujqi8Q=;
 b=sja03ZEgBZlGYODWccfflMLzPfC6D6W6Id9nob5EmPo4OYcMrMyHaZEpXbQQHSNnoP2jG+0MF
 GVjeGpeBEEaCap/7mVVyx1tecGEwtj9+XJD9/0ITWqG11gJseobTu+h
X-Developer-Key: i=amitsd@google.com; a=ed25519;
 pk=wD+XZSST4dmnNZf62/lqJpLm7fiyT8iv462zmQ3H6bI=
X-Endpoint-Received: by B4 Relay for amitsd@google.com/20241031 with
 auth_id=262
X-Original-From: Amit Sunil Dhamne <amitsd@google.com>
Reply-To: amitsd@google.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42849-lists,linux-pm=lfdr.de,amitsd.google.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linaro.org,linuxfoundation.org,google.com,linux.intel.com,samsung.com,gmail.com,linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[amitsd@google.com]
X-Rspamd-Queue-Id: E50BE15A7C0
X-Rspamd-Action: no action

From: Amit Sunil Dhamne <amitsd@google.com>

Add a helper function to find the selector for a given value in a linear
range array. The selector should be such that the value it represents
should be higher or equal to the given value.

Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 include/linux/linear_range.h |  3 +++
 lib/linear_ranges.c          | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/linux/linear_range.h b/include/linux/linear_range.h
index 2e4f4c3539c075a6caa69f6ae750a556f41fce5d..0f3037f1a94f58667ca7c5200dfda78afafe0cfd 100644
--- a/include/linux/linear_range.h
+++ b/include/linux/linear_range.h
@@ -57,5 +57,8 @@ void linear_range_get_selector_within(const struct linear_range *r,
 int linear_range_get_selector_low_array(const struct linear_range *r,
 					int ranges, unsigned int val,
 					unsigned int *selector, bool *found);
+int linear_range_get_selector_high_array(const struct linear_range *r,
+					 int ranges, unsigned int val,
+					 unsigned int *selector, bool *found);
 
 #endif
diff --git a/lib/linear_ranges.c b/lib/linear_ranges.c
index a1a7dfa881def894cc8cce8368cb6e9c21dcd6b1..c85583678f6b52a494f8c321ce2d307bdb6845ce 100644
--- a/lib/linear_ranges.c
+++ b/lib/linear_ranges.c
@@ -241,6 +241,42 @@ int linear_range_get_selector_high(const struct linear_range *r,
 }
 EXPORT_SYMBOL_GPL(linear_range_get_selector_high);
 
+/**
+ * linear_range_get_selector_high_array - return linear range selector for value
+ * @r:		pointer to array of linear ranges where selector is looked from
+ * @ranges:	amount of ranges to scan from array
+ * @val:	value for which the selector is searched
+ * @selector:	address where found selector value is updated
+ * @found:	flag to indicate that given value was in the range
+ *
+ * Scan array of ranges for selector for which range value matches given
+ * input value. Value is matching if it is equal or higher than given value
+ * If given value is found to be in a range scanning is stopped and @found is
+ * set true. If a range with values greater than given value is found
+ * but the range min is being greater than given value, then the range's
+ * lowest selector is updated to @selector and scanning is stopped.
+ *
+ * Return: 0 on success, -EINVAL if range array is invalid or does not contain
+ * range with a value greater or equal to given value
+ */
+int linear_range_get_selector_high_array(const struct linear_range *r,
+					 int ranges, unsigned int val,
+					 unsigned int *selector, bool *found)
+{
+	int i;
+	int ret;
+
+	for (i = 0; i < ranges; i++) {
+		ret = linear_range_get_selector_high(&r[i], val, selector,
+						     found);
+		if (!ret)
+			return 0;
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(linear_range_get_selector_high_array);
+
 /**
  * linear_range_get_selector_within - return linear range selector for value
  * @r:		pointer to linear range where selector is looked from

-- 
2.53.0.371.g1d285c8824-goog



