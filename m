Return-Path: <linux-pm+bounces-43080-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCVHAu8CnWkuMgQAu9opvQ
	(envelope-from <linux-pm+bounces-43080-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 02:46:23 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A61D0180AA4
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 02:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E59F30BC94E
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 01:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4399F257459;
	Tue, 24 Feb 2026 01:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKPLSjH/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CA9241C8C;
	Tue, 24 Feb 2026 01:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771897550; cv=none; b=lNbfmZvWhSUXtE3NrueNafhRFYXZjgwoNpb5b/Sej+cBU/SOziBY3ohbaUakvmTQC9/QmU5I68Mx7sEQ09pHNvYxppFoMjd1bYv7QXzQndNWWHSct/lr0hipBCQtCCUxK6gsFJToTe2FR7XWksgiWZYOOxxaxZrBlUECoWF5Q14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771897550; c=relaxed/simple;
	bh=5L1aAyrT1CnMHAdDXtMxEsg5bTIoOtEBzpy9bU5cmQo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SF/GtaD4DvmhgYspK49ojtsx5znNC+F7qwpSYbEsNFjydSUQDdF8WA7Vp4MGxTSyb3jtDYCfEhmw8RKTZ+vBzlIjhW3UMow167Nq6tRQhyKuAxkZwEhRNVWCkB9Z9wTlZLk84bj//zbfcKjddGPaYWBwLqLL7a5h2tSX7KQSyuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKPLSjH/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8CBCC2BCB1;
	Tue, 24 Feb 2026 01:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771897549;
	bh=5L1aAyrT1CnMHAdDXtMxEsg5bTIoOtEBzpy9bU5cmQo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TKPLSjH/c+PwuUsFIn68NW22pTVvXtjFANLnf57LrWKTefqRb7xNrgjtpZa6vKHaL
	 WB06NuukSE05liTUl3yY98iv3jxBQrITa2yP8e/opVUfOnj9EojDgwt/VAuosvXbV+
	 7Cld1Lk6963QkwhZyLV+7TmWSrvnLjIHeRYWbGLtuIBh8pbPSQUIIFiKGaJo7Z+yOP
	 W/2tRtkdXUcJBVWTuAKQX6mOWEHyrMCcuoqkHT0/q0gr9/tgceIB7c5f46jP/aljTE
	 UKYbRY7pLuJYKeQCwi1q6TTeQAQmzBgeEppbbONT4afemMPFmJqylEEajCJHGtuSkV
	 ARQqBA15/d6vw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC2EEEC2BD;
	Tue, 24 Feb 2026 01:45:49 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Date: Tue, 24 Feb 2026 01:45:34 +0000
Subject: [PATCH v8 4/6] lib/linear_ranges: Add
 linear_range_get_selector_high_array
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-max77759-charger-v8-4-eb86bd570e9c@google.com>
References: <20260224-max77759-charger-v8-0-eb86bd570e9c@google.com>
In-Reply-To: <20260224-max77759-charger-v8-0-eb86bd570e9c@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771897548; l=3072;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=66O0TCiwwg6+0syFe+iqI5+JzrTIE96SPH1q/Ujqi8Q=;
 b=4GTvO9+fSlJ7boox9mtma4Z4sebxG4g2OMV0N60dr+exeQ5F9ViEqWvrV9loY5IL2lUxUot6o
 52/BR5Di6UQD5bTP6b1LeKgs5kRnIXP9dloPRuZUo/ZsoQgQNgV978G
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43080-lists,linux-pm=lfdr.de,amitsd.google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,linaro.org,linuxfoundation.org,google.com,linux.intel.com,samsung.com,gmail.com,linux-foundation.org];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pm@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	HAS_REPLYTO(0.00)[amitsd@google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A61D0180AA4
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



