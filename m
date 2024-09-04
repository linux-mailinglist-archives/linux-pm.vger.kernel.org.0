Return-Path: <linux-pm+bounces-13590-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDFF96C08D
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 16:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7464A1F26F75
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 14:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF591DC1AD;
	Wed,  4 Sep 2024 14:31:02 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA161DC1A4
	for <linux-pm@vger.kernel.org>; Wed,  4 Sep 2024 14:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460262; cv=none; b=M5F/aBNfr2KvPTFnI0juQyATygWawDxoCd8Dr87jwf7snnWyZkcqPs7LFNIBnJp3rsrlp4+FX54nLml+Dj59TQtvL8lmnJ/Aomi32JqeT4CQnsmU64Rsfh/CxPTzbdLXb3zq3hbI822JY0ICl3YaQrXWBYxc1VCm7vjdhCq8pUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460262; c=relaxed/simple;
	bh=TLzi08QC8bjHucQYd9nHMqZdLQogig1Z9ZHUdaPJKOc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UwX3rR3Q6Oz3uBYM4N3iEUiNBojcfTIrXXkCDjycGsp8WMvT0vW+eE9dx7rybnIv8BjKLwiJCtQhwDAsjetNc51mDH/0IrxNHuu6KLx2dvtascgj4Rcneo3MdacJupkXRLSmmTF4En6W0jKJAtTNRZxGGqig/V23I31u6chnJsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:ef52:68c5:eac1:f6b5])
	by laurent.telenet-ops.be with cmsmtp
	id 8EWv2D0093m5in101EWv6D; Wed, 04 Sep 2024 16:30:57 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1slr24-0028JN-H5;
	Wed, 04 Sep 2024 16:30:55 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1slr27-004MyA-7r;
	Wed, 04 Sep 2024 16:30:55 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Dmitry Osipenko <digetx@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jagadeesh Kona <quic_jkona@quicinc.com>,
	Taniya Das <quic_tdas@quicinc.com>,
	Abel Vesa <abel.vesa@linaro.org>
Cc: linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/4] pmdomain: core: Harden inter-column space in debug summary
Date: Wed,  4 Sep 2024 16:30:45 +0200
Message-Id: <ae61eb363621b981edde878e1e74d701702a579f.1725459707.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1725459707.git.geert+renesas@glider.be>
References: <cover.1725459707.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The inter-column space in the debug summary is two spaces.  However, in
one case, the extra space is handled implicitly in a field width
specifier.  Make inter-column space explicit to ease future maintenance.

Fixes: 45fbc464b047b3fb ("PM: domains: Add "performance" column to debug summary")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pmdomain/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 6a8c814f967dda35..afa4e75863a40b49 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -3352,7 +3352,7 @@ static int genpd_summary_one(struct seq_file *s,
 	else
 		snprintf(state, sizeof(state), "%s",
 			 status_lookup[genpd->status]);
-	seq_printf(s, "%-30s  %-50s %u", genpd->name, state, genpd->performance_state);
+	seq_printf(s, "%-30s  %-49s  %u", genpd->name, state, genpd->performance_state);
 
 	/*
 	 * Modifications on the list require holding locks on both
-- 
2.34.1


