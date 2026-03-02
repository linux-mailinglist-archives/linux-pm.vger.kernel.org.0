Return-Path: <linux-pm+bounces-43436-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wA3uIAu9pWn8FQAAu9opvQ
	(envelope-from <linux-pm+bounces-43436-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 17:38:35 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6E01DD063
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 17:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ECF833091943
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2026 16:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51B441C2FA;
	Mon,  2 Mar 2026 16:29:36 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B8D41C319;
	Mon,  2 Mar 2026 16:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772468976; cv=none; b=SK5dVF6FxJeaylA81xFR16kjKkgjZbV+v9Nghhg9pQch2aF3KIc5d4ZjOuZ8o/fb3cEVOa+MIMIbMvaKvmvwIfF54EUKOsDDZuBOO4AfiUvhU23z2ghf30rmzzqKEtULJrJwZcDWUzL3HtoP4TSiii4dfbhgxufOf1cxCMB5OWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772468976; c=relaxed/simple;
	bh=HWj2r1flt4YHyfpgbLhCJo6W+JNQ6Ii3NFEV4LeMofE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sq84HB9dCENiuFxNKLVrjULbbTK43y/0XcW65U9SQsmE+6aGNX/AXufkV4PaIQPm2lWwqjeeTi+gHTM+GiWJmjlGON9Jzd0TPLGrfzrxBHZiHKxsoI+pRIIHYmmWn+yPGNmmWVD6Gf0nME2XkiJ2PQkML3otsgiFyvZztSnLkmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C0CDC2BCB5;
	Mon,  2 Mar 2026 16:29:32 +0000 (UTC)
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
Subject: [PATCH 5/7] cpufreq: ti-cpufreq: Convert to of_machine_get_match()
Date: Mon,  2 Mar 2026 17:29:09 +0100
Message-ID: <bba0631aea78b6db7d453a9f9e98ea16b7e2c269.1772468323.git.geert+renesas@glider.be>
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
X-Rspamd-Queue-Id: 0F6E01DD063
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[glider.be];
	TAGGED_FROM(0.00)[bounces-43436-lists,linux-pm=lfdr.de,renesas];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@glider.be,linux-pm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,gmail.com,vger.kernel.org,glider.be];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.855];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,renesas];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Use the of_machine_get_match() helper instead of open-coding the same
operation.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested only.
---
 drivers/cpufreq/ti-cpufreq.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index 3d1129aeed02b06f..a01abc1622eb712b 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -502,16 +502,6 @@ static const struct of_device_id ti_cpufreq_of_match[]  __maybe_unused = {
 	{},
 };
 
-static const struct of_device_id *ti_cpufreq_match_node(void)
-{
-	struct device_node *np __free(device_node) = of_find_node_by_path("/");
-	const struct of_device_id *match;
-
-	match = of_match_node(ti_cpufreq_of_match, np);
-
-	return match;
-}
-
 static int ti_cpufreq_probe(struct platform_device *pdev)
 {
 	u32 version[VERSION_COUNT];
@@ -596,7 +586,7 @@ static int __init ti_cpufreq_init(void)
 	const struct of_device_id *match;
 
 	/* Check to ensure we are on a compatible platform */
-	match = ti_cpufreq_match_node();
+	match = of_machine_get_match(ti_cpufreq_of_match);
 	if (match)
 		platform_device_register_data(NULL, "ti-cpufreq", -1, match,
 					      sizeof(*match));
-- 
2.43.0


