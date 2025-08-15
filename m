Return-Path: <linux-pm+bounces-32453-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FD5B28773
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 22:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 840EBAC87EC
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 20:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519F52BE040;
	Fri, 15 Aug 2025 20:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Hbt694ZW"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE39243946;
	Fri, 15 Aug 2025 20:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755291448; cv=none; b=Yno4gy8ajM1VyPeqCQs8jPHnRu1ee9vfdHWcMJZBSNmZRAq+Kw5vqHUk0QHJUbWvoEZ1wLjDKUumAETErg2KxriOBz0MfpegMeReCMrvISZB1z6VQUpCeXrgokbXagqXbUdRUTb98j3y3Jr10Tvt1SD9l0j4Jtbk1iGXAb8fRS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755291448; c=relaxed/simple;
	bh=+YZ5RFTx1lTqWs6GzWQCeXFfnC94z2xcTi6xc13mGAY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f85EjmF9hGOAeH2rPJGiECRLFb+b1SZtfcdDsRnwr5LeUcQXYTS3s2uKGAnko1GbdDBbMHz7w+OwCo00xuUpUxCRk09P29Fsjb+CnzDW4UGgZe/9taFjNjA0l+7s4/rGh+tLk03yXCrB4Yp3eU2nY2X5xWvG13n/5cNNaYbBwYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Hbt694ZW; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id CC3FDC0081B4;
	Fri, 15 Aug 2025 13:57:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com CC3FDC0081B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1755291439;
	bh=+YZ5RFTx1lTqWs6GzWQCeXFfnC94z2xcTi6xc13mGAY=;
	h=From:To:Cc:Subject:Date:From;
	b=Hbt694ZWJuSS3wkNH5tQSogOI918YB4buaDoRAko5bOwWHJR630m/W+Uflynq2n6P
	 aUvAHSj9/11LKbvqAYh/CMXP+PAb4g+iqM7aW4n5eJg1/DglvGUvxiegj52WeOCq7s
	 kqAVRDJ6yOoUCuUg62tRpS5eb8wn02dhAHLUjsso=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id C46EA4002F44;
	Fri, 15 Aug 2025 16:57:18 -0400 (EDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: james.quinlan@broadcom.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Mike Tipton <quic_mdtipton@quicinc.com>,
	Peng Fan <peng.fan@nxp.com>,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2] cpufreq: scmi: Account for malformed DT in scmi_dev_used_by_cpus()
Date: Fri, 15 Aug 2025 13:57:14 -0700
Message-Id: <20250815205714.1545571-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Broadcom STB platforms were early adopters of the SCMI framework and as
a result, not all deployed systems have a Device Tree entry where SCMI
protocol 0x13 (PERFORMANCE) is declared as a clock provider, nor are the
CPU Device Tree node(s) referencing protocol 0x13 as their clock
provider.

For those platforms, we allow the checks done by scmi_dev_used_by_cpus()
to continue, and in the event of not having done an early return, we key
off the documented compatible string and give them a pass to continue to
use scmi-cpufreq.

Fixes: 6c9bb8692272 ("cpufreq: scmi: Skip SCMI devices that aren't used by the CPUs")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
Changes in v2:

- do not leverage the SCMI quirks framework which in spirit is for
  dealing with SCMI firmware implementations, this right here,
  specifically pertains to an older Device Tree. This also makes it
  easier to backport that change into stable trees where the commit in
  the Fixes tag is already present. There is no dependency upon the
  presence of the SCMI quirks framework

 drivers/cpufreq/scmi-cpufreq.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index ef078426bfd5..9df4d968fdac 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -15,6 +15,7 @@
 #include <linux/energy_model.h>
 #include <linux/export.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/pm_opp.h>
 #include <linux/pm_qos.h>
 #include <linux/slab.h>
@@ -424,6 +425,14 @@ static bool scmi_dev_used_by_cpus(struct device *scmi_dev)
 			return true;
 	}
 
+	/* Older Broadcom STB chips had a "clocks" property for CPU node(s)
+	 * that did not match the SCMI performance protocol node, if we got
+	 * there, it means we had such an older Device Tree, therefore return
+	 * true to preserve backwards compatibility.
+	 */
+	if (of_machine_is_compatible("brcm,brcmstb"))
+		return true;
+
 	return false;
 }
 
-- 
2.34.1


