Return-Path: <linux-pm+bounces-42607-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEQJGrP3jmnbGAEAu9opvQ
	(envelope-from <linux-pm+bounces-42607-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 13 Feb 2026 11:06:43 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 80031134DAD
	for <lists+linux-pm@lfdr.de>; Fri, 13 Feb 2026 11:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C41C301DDBA
	for <lists+linux-pm@lfdr.de>; Fri, 13 Feb 2026 10:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123F934D38E;
	Fri, 13 Feb 2026 10:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="z7IkLTO6"
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB2E17A303;
	Fri, 13 Feb 2026 10:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770977200; cv=none; b=AMREKMs1T+e1zM38RDTZKYKSlsY5cNWc69idmOlhcrKhNIxUJ4J/PWWA5i3St2UAfI1z1DcLqGCD1OcJR2f7iJAugnpxG60e98FqhHKkPB/sn+/ozspxQh75UHMtop2JQwiD9ubUmYRtnVtx6HE52tvKtDCrRrmp/v8uX7ddxGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770977200; c=relaxed/simple;
	bh=KNQeQ/3Kak18NIpIR3mx1Tm0BiiF8xBv0N3k+NzzyRk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cjNASf1w7zijE9qRqWCAF2oKjdyFlR67o+0RN4Tzfl+/uVVZaRY/9za/3fguFhPt2fyrjw/MxidM585OVN/jZamM6uC4eWqTDxoDIXlUl4Z5+jz0GqUz+OlaH1sEeN9SKzl0/JuiY2m+uxfvwFz+zYgFYIHhxJm9MLx5BCpPx3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=z7IkLTO6; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=pv2g9R1zgeT8rwnP2tS9oIS2mUM3hEs9908/Xbksd0s=;
	b=z7IkLTO6yPnpg49OB0dxeqab1aqih5/28bXEIhE3TVzoBP9lwTaBFxwX9y6fjTYWZfZagiRpW
	hV6q28w8IrLNGfPwh+SxMWQBGXC+fBaPZbcynWAPUaSl4caWKcsMiKVlyTdrYqpFLTbp7PXzITz
	whHbhffHyZRbHkjZCQ+qhLE=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4fC74J35tZz1prM0;
	Fri, 13 Feb 2026 18:01:52 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 7658040569;
	Fri, 13 Feb 2026 18:06:34 +0800 (CST)
Received: from huawei.com (10.50.163.32) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 13 Feb
 2026 18:06:33 +0800
From: Pengjie Zhang <zhangpengjie2@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <lihuisong@huawei.com>,
	<yubowen8@huawei.com>, <linhongye@h-partners.com>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <zhangpengjie2@huawei.com>,
	<wangzhi12@huawei.com>
Subject: [PATCH v2] cpufreq: cppc: Clamp default minimum limit to lowest_nonlinear_perf
Date: Fri, 13 Feb 2026 18:06:33 +0800
Message-ID: <20260213100633.15413-1-zhangpengjie2@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr200004.china.huawei.com (7.202.195.241)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangpengjie2@huawei.com,linux-pm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-42607-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[huawei.com:+]
X-Rspamd-Queue-Id: 80031134DAD
X-Rspamd-Action: no action

The ACPI spec defines 'lowest_nonlinear_perf' as the threshold for
linear performance scaling. Performance levels below this threshold
are typically inefficient and should not be used by default.

Currently, the QoS minimum request is initialized to 0. This defaults
the performance floor to the absolute "Lowest Performance" state
instead of "lowest_nonlinear_perf", allowing the CPU to operate in
an inefficient range unnecessarily.

Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
---
Changes in v2:
  - Renamed the patch subject to better reflect the logic change.
  - Updated the commit log to clarify ACPI spec details.
Link to v1:https://lore.kernel.org/all/20260116094555.2978887-1-zhangpengjie2@huawei.com/
---
 drivers/cpufreq/cppc_cpufreq.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 7e8042efedd1..4a3031d9fcf4 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -333,9 +333,23 @@ static unsigned int cppc_cpufreq_fast_switch(struct cpufreq_policy *policy,
 	return target_freq;
 }
 
-static int cppc_verify_policy(struct cpufreq_policy_data *policy)
+static int cppc_verify_policy(struct cpufreq_policy_data *policy_data)
 {
-	cpufreq_verify_within_cpu_limits(policy);
+	if (policy_data->min == FREQ_QOS_MIN_DEFAULT_VALUE) {
+		struct cpufreq_policy *policy __free(put_cpufreq_policy) =
+					      cpufreq_cpu_get(policy_data->cpu);
+		struct cppc_cpudata *cpu_data;
+
+		if (!policy)
+			return -EINVAL;
+
+		cpu_data = policy->driver_data;
+		policy_data->min = cppc_perf_to_khz(&cpu_data->perf_caps,
+			cpu_data->perf_caps.lowest_nonlinear_perf);
+	}
+
+	cpufreq_verify_within_cpu_limits(policy_data);
+
 	return 0;
 }
 
-- 
2.33.0


