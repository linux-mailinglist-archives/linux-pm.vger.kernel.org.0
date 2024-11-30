Return-Path: <linux-pm+bounces-18300-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8BC9DF206
	for <lists+linux-pm@lfdr.de>; Sat, 30 Nov 2024 17:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F2F32815CD
	for <lists+linux-pm@lfdr.de>; Sat, 30 Nov 2024 16:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0F71A727D;
	Sat, 30 Nov 2024 16:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGThtjdv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1861A262D;
	Sat, 30 Nov 2024 16:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732984793; cv=none; b=ZqyYfy+Z+5ktWd6sVXYz8Y8kbXevdB+a7gJRzuJje3BlzAKibukT9+Pxe4o5B9M6X3XqH6benu0lyJ+dsuFfY0Yi6TrRcJzytc9bEl2DGCjy+HbAPakE3ELnnf+Sqqa7ZPpUCoMjhIA8JW79SlK7UxXwt2pdEhA3bsfU7E8P8H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732984793; c=relaxed/simple;
	bh=P/Ora394aiAIsv2E40+bNDx45WNlD9B4Bex2g9v0SAU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nAPUAPBBfi1zvTY4GmLWhRpiRNk4/+U56nOcSt2fu3uPbkKvq5eNGMKuRcq3GVLePXcWYqPYtljWZFATobHwcXVuPrm19089+nSDm74LFwhd+vZBm+QiTEijZ63sTbe7BMVxDBDFz6+4+ilLDx030GhGH2u719ijKnIvxc2PbXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGThtjdv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7FB9C4CED3;
	Sat, 30 Nov 2024 16:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732984793;
	bh=P/Ora394aiAIsv2E40+bNDx45WNlD9B4Bex2g9v0SAU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KGThtjdvUKYypb4b8OVKCKjvU1uK3aTvE1x/X/57Xkk/QTjB6H2DKPir0KZ/vrHyr
	 hp7eTjk91zemieUWVFygz7cQ4DDt5l0IGJuNhc3iJpM15dMbS2ElkQyxUTyU8C6qX+
	 pWLeY3Ymi5I/8047ItiGFGnc0yZd58o/u5Of4GPCKB951TbwgZrvIl3DIPDepVwJW9
	 9TaufzhO1daP7PiW6Zvda9inBCPFKQ9Gmj6iGsE4YWPYKtR8aMOe4Nl8/s22KA4NAF
	 xKnkEalrXHPYDdX0J235vbpeJIZe/txZSfbShk3mvJPG3/tSqAHSCfB4+Arw1fqmcA
	 uEZoxNW9SsJDA==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Sat, 30 Nov 2024 17:39:37 +0100
Subject: [PATCH 2/2] pmdomain: core: Support naming idle states
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241130-topic-idle_state_name-v1-2-d0ff67b0c8e9@oss.qualcomm.com>
References: <20241130-topic-idle_state_name-v1-0-d0ff67b0c8e9@oss.qualcomm.com>
In-Reply-To: <20241130-topic-idle_state_name-v1-0-d0ff67b0c8e9@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732984781; l=2553;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=u/1xp80sxdJbOQMI7rGBW5elAYaMjhAKE1/mS4dnTnA=;
 b=LMvarwmd6uBjNHLDuSkBpgjXVhlwG/EfRBwLpXNOxW9vPgNSb4G6GtBDcMPbTXEzO+1aqKTSy
 XvvNh8qfmqdBEmIfSnMoagGWReHU4hFsQC6YwyOVblZNt+VYyfO0qO7
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Commit 422f2d418186 ("arm64: dts: qcom: Drop undocumented domain
"idle-state-name"") brought to light the common misbelief that
idle-state-names also applies to e.g. PSCI power domain idle states.

Make that a reality, mimicking the property name used by cpuidle
states.

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/pmdomain/core.c   | 15 ++++++++++++---
 include/linux/pm_domain.h |  1 +
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index a6c8b85dd02478e227ac74886225a3fbad330eac..6f41ebdbc24fdfdf02021d4db1b2f324736940ae 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -3171,6 +3171,8 @@ static int genpd_parse_state(struct genpd_power_state *genpd_state,
 	if (!err)
 		genpd_state->residency_ns = 1000LL * residency;
 
+	of_property_read_string(state_node, "idle-state-name", &genpd_state->name);
+
 	genpd_state->power_on_latency_ns = 1000LL * exit_latency;
 	genpd_state->power_off_latency_ns = 1000LL * entry_latency;
 	genpd_state->fwnode = &state_node->fwnode;
@@ -3449,7 +3451,10 @@ static int idle_states_show(struct seq_file *s, void *data)
 	seq_puts(s, "State          Time Spent(ms) Usage          Rejected\n");
 
 	for (i = 0; i < genpd->state_count; i++) {
-		idle_time += genpd->states[i].idle_time;
+		struct genpd_power_state *state = &genpd->states[i];
+		char state_name[15];
+
+		idle_time += state->idle_time;
 
 		if (genpd->status == GENPD_STATE_OFF && genpd->state_idx == i) {
 			now = ktime_get_mono_fast_ns();
@@ -3459,9 +3464,13 @@ static int idle_states_show(struct seq_file *s, void *data)
 			}
 		}
 
+		if (!state->name)
+			snprintf(state_name, ARRAY_SIZE(state_name), "S%-13d", i);
+
 		do_div(idle_time, NSEC_PER_MSEC);
-		seq_printf(s, "S%-13i %-14llu %-14llu %llu\n", i, idle_time,
-			   genpd->states[i].usage, genpd->states[i].rejected);
+		seq_printf(s, "%-14s %-14llu %-14llu %llu\n",
+			   state->name ?: state_name, idle_time,
+			   state->usage, state->rejected);
 	}
 
 	genpd_unlock(genpd);
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 45646bfcaf1a5eb7169e497677c3a2acd9263a9c..1aab31370065caad13bf951179f75ff3cf798a96 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -147,6 +147,7 @@ struct genpd_governor_data {
 };
 
 struct genpd_power_state {
+	const char *name;
 	s64 power_off_latency_ns;
 	s64 power_on_latency_ns;
 	s64 residency_ns;

-- 
2.47.1


