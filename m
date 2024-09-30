Return-Path: <linux-pm+bounces-14934-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B16A9989E85
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 11:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EDC31F23F11
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 09:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F9618BC26;
	Mon, 30 Sep 2024 09:34:29 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278331885B4;
	Mon, 30 Sep 2024 09:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727688869; cv=none; b=CuxmG/7xsYRiJ28vX2pP7BR2gTcZp3YX13UBRLX2MX8vn9i4h4Sr+DJ1eQYKr+bC0aLalhvBQY5B+2DE6nP8+UdtuNogQU1xphvZzMDh+uI+W6RgQM5Mv+EP63OIRmKxsbeFg1xnMwuMVBJG0/fTf74n4nzCopEriJ9xVERn+1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727688869; c=relaxed/simple;
	bh=EunYjZ8Za9/8jYNV0OlNkO07VBM6RVDCo3AylF92MS4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hr7wYLVPkCAHBEWfoxv5/8Wd8t/NcbOfiKMC82+X+VTZGZLb4Lgg3rikkCJQ7qtD+UFEf9MsgyXPn8YzcAckpuqX1gbJsPP4mLl055mskk1lKdiMCrFhVHdp1qbMDQIdUOJxT2MWtYoxbqbwWuJlpu0DFliCZi3hzef6bCeJ6pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XHG780Vl2zfcvC;
	Mon, 30 Sep 2024 17:32:04 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 8D6D114011D;
	Mon, 30 Sep 2024 17:34:23 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 30 Sep
 2024 17:34:23 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <andersson@kernel.org>, <konradybcio@kernel.org>,
	<ulf.hansson@linaro.org>, <zhangzekun11@huawei.com>,
	<linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] pmdomain: qcom: cpr: Fix possible uninitialized value
Date: Mon, 30 Sep 2024 17:44:56 +0800
Message-ID: <20240930094456.2593136-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh500013.china.huawei.com (7.202.181.146)

of_property_read_u64() can fail and left "rate" uninitialized,
and the zero check in cpr_corner_init() for cpr_get_opp_hz_for_req()
can not prevent it and it will assign cdata[level - 1].freq to random
value, so init it to fix it.

Cc: stable@vger.kernel.org # v6.12
Fixes: 181c8148556a ("pmdomain: qcom-cpr: Use scope based of_node_put() to simplify code.")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/pmdomain/qcom/cpr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/qcom/cpr.c b/drivers/pmdomain/qcom/cpr.c
index e1fca65b80be..26a60a101e42 100644
--- a/drivers/pmdomain/qcom/cpr.c
+++ b/drivers/pmdomain/qcom/cpr.c
@@ -1052,7 +1052,7 @@ static unsigned long cpr_get_opp_hz_for_req(struct dev_pm_opp *ref,
 			of_parse_phandle(child_np, "required-opps", 0);
 
 		if (child_req_np == ref_np) {
-			u64 rate;
+			u64 rate = 0;
 
 			of_property_read_u64(child_np, "opp-hz", &rate);
 			return (unsigned long) rate;
-- 
2.34.1


