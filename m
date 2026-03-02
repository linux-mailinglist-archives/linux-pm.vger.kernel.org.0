Return-Path: <linux-pm+bounces-43437-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHYSACa/pWknFgAAu9opvQ
	(envelope-from <linux-pm+bounces-43437-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 17:47:34 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E117F1DD2F9
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 17:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3E82030AC002
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2026 16:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EEF425CE6;
	Mon,  2 Mar 2026 16:29:40 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3946B41C30C;
	Mon,  2 Mar 2026 16:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772468980; cv=none; b=XVlP5GCsrTaE0YgSd3XtVdN8s5coBzofNSkO6M1EJ8RurQ22XFgtGllDd+vTg722VXIILJRN7fIyvEZPpaj04gQ4U3rJH93cAhK5lMw9C4yP19jPnF9MUGx+y42yK4mSI5k2c3zkh7KtWyePC9XioGGVBkmG9dLcV/5WhnGCG/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772468980; c=relaxed/simple;
	bh=Fryt+iLjvYlcGVDTyLcBys0mXgeoSXsfTLwhJH6ij8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ah5dL3oMkMj2XJN+vetL9yAMrHkT3w89DX4xVXKiUK7fe3HNANeYq16Psf7A26DPXXS4W5eDeefSFaSelGnpx98Fc1R4WLBK5t57cswtTXHTZsl2uWTjIW3yTXyB10Sn5drgVULKSV44ENg0EZy6m1VvWGu8ECIc+Re0LO05tqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F6BC2BC87;
	Mon,  2 Mar 2026 16:29:36 +0000 (UTC)
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
Subject: [PATCH 6/7] soc: qcom: pd-mapper: Convert to of_machine_get_match()
Date: Mon,  2 Mar 2026 17:29:10 +0100
Message-ID: <0d23a449e62ac85f04ff07bc2758efbaa709c9d1.1772468323.git.geert+renesas@glider.be>
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
X-Rspamd-Queue-Id: E117F1DD2F9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[glider.be];
	TAGGED_FROM(0.00)[bounces-43437-lists,linux-pm=lfdr.de,renesas];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@glider.be,linux-pm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,gmail.com,vger.kernel.org,glider.be];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.860];
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
 drivers/soc/qcom/qcom_pd_mapper.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/soc/qcom/qcom_pd_mapper.c b/drivers/soc/qcom/qcom_pd_mapper.c
index dc10bc859ff4170c..8a1a18f8c859496f 100644
--- a/drivers/soc/qcom/qcom_pd_mapper.c
+++ b/drivers/soc/qcom/qcom_pd_mapper.c
@@ -615,15 +615,9 @@ static struct qcom_pdm_data *qcom_pdm_start(void)
 	const struct qcom_pdm_domain_data * const *domains;
 	const struct of_device_id *match;
 	struct qcom_pdm_data *data;
-	struct device_node *root;
 	int ret, i;
 
-	root = of_find_node_by_path("/");
-	if (!root)
-		return ERR_PTR(-ENODEV);
-
-	match = of_match_node(qcom_pdm_domains, root);
-	of_node_put(root);
+	match = of_machine_get_match(qcom_pdm_domains);
 	if (!match) {
 		pr_notice("PDM: no support for the platform, userspace daemon might be required.\n");
 		return ERR_PTR(-ENODEV);
-- 
2.43.0


