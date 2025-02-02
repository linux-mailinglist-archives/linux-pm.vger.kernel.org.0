Return-Path: <linux-pm+bounces-21239-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80762A24F26
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 18:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42A461884BE1
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 17:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CC51FAC58;
	Sun,  2 Feb 2025 17:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ht1kzPvG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000551F9F73
	for <linux-pm@vger.kernel.org>; Sun,  2 Feb 2025 17:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738516401; cv=none; b=YvhNkm/PN/jnyO6bwpdaemB+if3IzFAKNyZ9b48BNzkB5uQoUp6uBq6/vm9bKlZH+Obkg2c0OHR8boBHd3jf+/h2yZOVPDxkgv5gtT3WPGNubLrHjOCIeyBIJEO9ggDdX3t+fLYC8+63hfRqzyIw7O7DgjXzGaVdLM3v73B2sLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738516401; c=relaxed/simple;
	bh=sw4z7M0SXbzFHvMTIMt51T5ve4gvbEIEcpcGeP/iTFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZSe8ZvfiqjoRHLkTig4rXzwst7/Ly4EStlUvmjAMyTytOSjqliDEwyMlglwscz8iF5mLw4fE+Keo+e3IpvETOHd6ToX3UIILlaa6ybjhTC/1o7K0oRIvjd9ZJ5aZumyHJDZQ+JisL24Nv3i3ejwBdyS2ZFk74c0OhkDbII6p3Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ht1kzPvG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E86CC4CEE1;
	Sun,  2 Feb 2025 17:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738516399;
	bh=sw4z7M0SXbzFHvMTIMt51T5ve4gvbEIEcpcGeP/iTFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=Ht1kzPvG7cfN5e6G2b2cxsrILeJ0tHfrhFeZoCP6QWC2862WCWvaxuFADrxHygB4h
	 hb2EZMNhGsj4DjU4n0WfspTxPLCjx/xdjjTQYnBt4HttzYLL30o8K1Gl4/DgOWnMwj
	 WQuBEHzRF4bgJLh/AARGjukGj0Y+CQRVL6l/bVCWq8ExRcvgW+Vby2/G3xdC74IxPv
	 EGwNhnlZZGy1jHbNke+rRvwJ8kE+ZRP8njDEdlmZJlpRIqO5YmfLB38IjxGg7h1atk
	 6e2n/jmrWtVUA0+vvhi7frCNheBSH+0njdXtiXbfhl1KHke0qLXdZMe0rSqBVI74v8
	 su+eUUZzs74og==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 16/25] tools/power turbostat: Extend PMT identification with a sequence number
Date: Sun,  2 Feb 2025 11:09:32 -0600
Message-ID: <089134cb0502ba962bce9402ce96e0875876d401.1738515889.git.len.brown@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <e8a99af68c068865dbac7f3330e97bf8e96edf33.1738515889.git.len.brown@intel.com>
References: <e8a99af68c068865dbac7f3330e97bf8e96edf33.1738515889.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>

When platforms expose multiple PMT aggregators with the same GUID, the
only way to identify them and map to specific domain is by reading them
in an order they were exposed via PCIe. Intel PMT kernel driver does
keep the same order and numbers the telemetry directories accordingly.

Use GUID and sequence number (order) to uniquely identify PMT
aggregators.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 60b1ade8659b..14c495886746 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1536,6 +1536,7 @@ static struct msr_counter_arch_info msr_counter_arch_infos[] = {
 #define PMT_COUNTER_MTL_DC6_LSB    0
 #define PMT_COUNTER_MTL_DC6_MSB    63
 #define PMT_MTL_DC6_GUID           0x1a067102
+#define PMT_MTL_DC6_SEQ            0
 
 #define PMT_COUNTER_NAME_SIZE_BYTES      16
 #define PMT_COUNTER_TYPE_NAME_SIZE_BYTES 32
@@ -9083,7 +9084,7 @@ void *pmt_get_counter_pointer(struct pmt_mmio *pmmio, unsigned long counter_offs
 	return ret;
 }
 
-struct pmt_mmio *pmt_add_guid(unsigned int guid)
+struct pmt_mmio *pmt_add_guid(unsigned int guid, unsigned int seq)
 {
 	struct pmt_mmio *ret;
 
@@ -9091,6 +9092,11 @@ struct pmt_mmio *pmt_add_guid(unsigned int guid)
 	if (!ret)
 		ret = pmt_mmio_open(guid);
 
+	while (ret && seq) {
+		ret = ret->next;
+		--seq;
+	}
+
 	return ret;
 }
 
@@ -9137,7 +9143,7 @@ void pmt_counter_add_domain(struct pmt_counter *pcounter, unsigned long *pmmio,
 	pcounter->domains[domain_id].pcounter = pmmio;
 }
 
-int pmt_add_counter(unsigned int guid, const char *name, enum pmt_datatype type,
+int pmt_add_counter(unsigned int guid, unsigned int seq, const char *name, enum pmt_datatype type,
 		    unsigned int lsb, unsigned int msb, unsigned int offset, enum counter_scope scope,
 		    enum counter_format format, unsigned int domain_id, enum pmt_open_mode mode)
 {
@@ -9157,10 +9163,10 @@ int pmt_add_counter(unsigned int guid, const char *name, enum pmt_datatype type,
 		exit(1);
 	}
 
-	mmio = pmt_add_guid(guid);
+	mmio = pmt_add_guid(guid, seq);
 	if (!mmio) {
 		if (mode != PMT_OPEN_TRY) {
-			fprintf(stderr, "%s: failed to map PMT MMIO for guid %x\n", __func__, guid);
+			fprintf(stderr, "%s: failed to map PMT MMIO for guid %x, seq %u\n", __func__, guid, seq);
 			exit(1);
 		}
 
@@ -9216,9 +9222,9 @@ int pmt_add_counter(unsigned int guid, const char *name, enum pmt_datatype type,
 void pmt_init(void)
 {
 	if (BIC_IS_ENABLED(BIC_Diec6)) {
-		pmt_add_counter(PMT_MTL_DC6_GUID, "Die%c6", PMT_TYPE_XTAL_TIME, PMT_COUNTER_MTL_DC6_LSB,
-				PMT_COUNTER_MTL_DC6_MSB, PMT_COUNTER_MTL_DC6_OFFSET, SCOPE_PACKAGE, FORMAT_DELTA,
-				0, PMT_OPEN_TRY);
+		pmt_add_counter(PMT_MTL_DC6_GUID, PMT_MTL_DC6_SEQ, "Die%c6", PMT_TYPE_XTAL_TIME,
+				PMT_COUNTER_MTL_DC6_LSB, PMT_COUNTER_MTL_DC6_MSB, PMT_COUNTER_MTL_DC6_OFFSET,
+				SCOPE_PACKAGE, FORMAT_DELTA, 0, PMT_OPEN_TRY);
 	}
 }
 
@@ -9699,6 +9705,7 @@ void parse_add_command_pmt(char *add_command)
 	unsigned int lsb;
 	unsigned int msb;
 	unsigned int guid;
+	unsigned int seq = 0; /* By default, pick first file in a sequence with a given GUID. */
 	unsigned int domain_id;
 	enum counter_scope scope = 0;
 	enum pmt_datatype type = PMT_TYPE_RAW;
@@ -9778,6 +9785,10 @@ void parse_add_command_pmt(char *add_command)
 			goto next;
 		}
 
+		if (sscanf(add_command, "seq=%x", &seq) == 1) {
+			goto next;
+		}
+
 next:
 		add_command = strchr(add_command, ',');
 		if (add_command) {
@@ -9864,7 +9875,7 @@ void parse_add_command_pmt(char *add_command)
 		exit(1);
 	}
 
-	pmt_add_counter(guid, name, type, lsb, msb, offset, scope, format, domain_id, PMT_OPEN_REQUIRED);
+	pmt_add_counter(guid, seq, name, type, lsb, msb, offset, scope, format, domain_id, PMT_OPEN_REQUIRED);
 }
 
 void parse_add_command(char *add_command)
-- 
2.43.0


