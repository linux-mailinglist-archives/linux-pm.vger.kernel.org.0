Return-Path: <linux-pm+bounces-43432-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uP60OSO7pWnNFQAAu9opvQ
	(envelope-from <linux-pm+bounces-43432-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 17:30:27 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D139A1DCD36
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 17:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DC7EC302CEB2
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2026 16:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C3C421885;
	Mon,  2 Mar 2026 16:29:22 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEFD407566;
	Mon,  2 Mar 2026 16:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772468962; cv=none; b=qXyXnflIDY3k+F78F/ygjYr54iRI/NrWC5YrGCRrvflGnyAB0gxeKacdQ6sAN7sZUmXEMgYojxjvMi1vf+GSaG6LECNHHOWoJz/W44V7JMRZsr46jqJ7d8BtO+zOBGgTwt8+757qPsxmCr7MEP/74uSCO+1djWCKLKGN8P/CvFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772468962; c=relaxed/simple;
	bh=sUEuLuxqaHTydElKH3+3XhMBxxOOI7n7jh2RJTRoQwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQLViinjlshJEJSwY/Jtq3yLAgORI6FYSiWOZuE8YFxy2i1eOdsP2xgeO7gku/Z2Z0n8+15FR0Pqs0oSmoN9F6MiMENzgS6cP1SuzXzUzSXFrvG3bQnjAgMpC8qG46fVsPr901Dtw8ArvnNn6hvCeUnbbW/x9D7oJIqFyT/B0ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0C2C19423;
	Mon,  2 Mar 2026 16:29:18 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ilia Lin <ilia.lin@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/7] of: Add of_machine_get_match() helper
Date: Mon,  2 Mar 2026 17:29:05 +0100
Message-ID: <14e1c03d443b1a5f210609ec3a1ebbaeab8fb3d9.1772468323.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1772468323.git.geert+renesas@glider.be>
References: <cover.1772468323.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D139A1DCD36
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43432-lists,linux-pm=lfdr.de,renesas];
	DMARC_NA(0.00)[glider.be];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,gmail.com,vger.kernel.org,glider.be];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[geert@glider.be,linux-pm@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.832];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,renesas];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[glider.be:mid,glider.be:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Currently, there are two helpers to match the root compatible value
against an of_device_id array:
  - of_machine_device_match() returns true if a match is found,
  - of_machine_get_match_data() returns the match data if a match is
    found.
However, there is no helper that returns the actual of_device_id
structure corresponding to the match, leading to code duplication in
various drivers.

Fix this by reworking of_machine_device_match() to return the actual
match structure, and renaming it to of_machine_get_match().
Retain the old of_machine_device_match() functionality using a cheap
static inline wrapper around the new of_machine_get_match() helper.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/of/base.c  | 11 +++++------
 include/linux/of.h | 11 ++++++++---
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 46ebd61655930857..3f061f10aff8fca9 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -435,13 +435,12 @@ bool of_machine_compatible_match(const char *const *compats)
 EXPORT_SYMBOL(of_machine_compatible_match);
 
 /**
- * of_machine_device_match - Test root of device tree against a of_device_id array
+ * of_machine_get_match - Test root of device tree against an of_device_id array
  * @matches:	NULL terminated array of of_device_id match structures to search in
  *
- * Returns true if the root node has any of the given compatible values in its
- * compatible property.
+ * Returns matched entry or NULL
  */
-bool of_machine_device_match(const struct of_device_id *matches)
+const struct of_device_id *of_machine_get_match(const struct of_device_id *matches)
 {
 	struct device_node *root;
 	const struct of_device_id *match = NULL;
@@ -452,9 +451,9 @@ bool of_machine_device_match(const struct of_device_id *matches)
 		of_node_put(root);
 	}
 
-	return match != NULL;
+	return match;
 }
-EXPORT_SYMBOL(of_machine_device_match);
+EXPORT_SYMBOL(of_machine_get_match);
 
 /**
  * of_machine_get_match_data - Tell if root of device tree has a matching of_match structure
diff --git a/include/linux/of.h b/include/linux/of.h
index 5dc394e626a48952..c70f7b05c59bceda 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -410,7 +410,7 @@ extern int of_alias_get_id(const struct device_node *np, const char *stem);
 extern int of_alias_get_highest_id(const char *stem);
 
 bool of_machine_compatible_match(const char *const *compats);
-bool of_machine_device_match(const struct of_device_id *matches);
+const struct of_device_id *of_machine_get_match(const struct of_device_id *matches);
 const void *of_machine_get_match_data(const struct of_device_id *matches);
 
 /**
@@ -866,9 +866,9 @@ static inline bool of_machine_compatible_match(const char *const *compats)
 	return false;
 }
 
-static inline bool of_machine_device_match(const struct of_device_id *matches)
+static inline const struct of_device_id *of_machine_get_match(const struct of_device_id *matches)
 {
-	return false;
+	return NULL;
 }
 
 static inline const void *
@@ -976,6 +976,11 @@ static inline int of_numa_init(void)
 }
 #endif
 
+static inline bool of_machine_device_match(const struct of_device_id *matches)
+{
+	return of_machine_get_match(matches) != NULL;
+}
+
 static inline struct device_node *of_find_matching_node(
 	struct device_node *from,
 	const struct of_device_id *matches)
-- 
2.43.0


