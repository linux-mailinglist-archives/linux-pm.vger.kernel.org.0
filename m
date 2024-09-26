Return-Path: <linux-pm+bounces-14827-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D88599874E6
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 15:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 151F91C251E6
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 13:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1438B5FEED;
	Thu, 26 Sep 2024 13:56:37 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE63312AAE2
	for <linux-pm@vger.kernel.org>; Thu, 26 Sep 2024 13:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727358997; cv=none; b=nNoxGRv/kYss4RHoA9w7M8fBIUmunvRrA81vS9ywALtsqsnEix5Mamh5IOGqAUOEVRMnspGCJUMOi9/M1coAsKr7GKG1PPiMFmmVKEeC9slXelS9ceFQe9C2v6jw0ZqcPgJrdKKEo56jCKZ9CZcmjU1wBObjtVvoUfpgsexbPZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727358997; c=relaxed/simple;
	bh=bY901IUEC/VGDtbIIg8MkoIJ6Eiy1Xc7yN5kFIK7X/Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Uq9Ao5/AjQGXWt7v56ikoSDhvlcOpCz60iS12UAxrSfSpC2wluwrufwU+SaD/lFSDhW0N7sTujVCDZ5Yk0QI17oVJsfJOZ3Sypx9Jr6FrSUaX/OXsUtFwaQCrLfzmFxYouysQ6kLP9CveJSoecW1qkGgHsavYyBvfBDV4jGADDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XDw7S58mTzfcZc;
	Thu, 26 Sep 2024 21:54:12 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 689C11800F2;
	Thu, 26 Sep 2024 21:56:30 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 26 Sep
 2024 21:56:29 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <andersson@kernel.org>, <konradybcio@kernel.org>,
	<ulf.hansson@linaro.org>, <linux-pm@vger.kernel.org>,
	<dan.carpenter@linaro.org>
CC: <chenjun102@huawei.com>, <zhangzekun11@huawei.com>
Subject: [PATCH] pmdomain: qcom-cpr: Fix the return of uninitialized variable
Date: Thu, 26 Sep 2024 21:42:11 +0800
Message-ID: <20240926134211.45394-1-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf500003.china.huawei.com (7.202.181.241)

The of_property_read_u64() can fail and remain the variable uninitialized,
which will then be returned. Initializing the variable "rate" to zero to
fix this problem.

Fixes: 181c8148556a ("pmdomain: qcom-cpr: Use scope based of_node_put() to simplify code.")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-pm/455a6a49-41d2-4a20-9a31-f57ee7a67920@huawei.com/T/#m0a62b501b453a6d6e94c52a428a66f65b5422c65
Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
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
2.17.1


