Return-Path: <linux-pm+bounces-18507-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 190DA9E2F22
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 23:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2CAE2838AA
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 22:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412B61E00B6;
	Tue,  3 Dec 2024 22:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zg7S4AwO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DD31DE2B2;
	Tue,  3 Dec 2024 22:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733265243; cv=none; b=FXFz6uJQR3uzhtKOE/kq9USXk3fR0IcY7S4deVSm+OW60EA92VQIABy4y4L5XRl/og8DVAng1E5XiFu6gOmbipHYqDboKapPHdnBdlWQuNYU5dn9GhPXv5Ly0zHS00Vfo2MWvF2JFkzYIwMLOnMEY1fNmOLpTO/4t6tLIjCKF0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733265243; c=relaxed/simple;
	bh=Bu6qfnjK8GPts2qLQfI6EE7tJPItadtDfuPSPmc1H8E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jYy7CDB1Yb7s81hWVK1TwUm8hoqWEgCZC7iTMv06WaW0abvVwpZxrcfBmomKypweRhZJ1prn087jYbYiAS8DeNKUQ/I5KDfGdv4N3vxfrWaGDAvM6QkaWWQbpZgfiEOFCcisTeuk1o9daeujX8FzyaGA/FpjaEPgJBA9MeMAIE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zg7S4AwO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E975C4CEDC;
	Tue,  3 Dec 2024 22:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733265242;
	bh=Bu6qfnjK8GPts2qLQfI6EE7tJPItadtDfuPSPmc1H8E=;
	h=From:To:Cc:Subject:Date:From;
	b=Zg7S4AwOlmHRO7BOIR35HgH6UZ+zBE4LMKkr8Cmf4kGBQJPg1S7FitcbTjeabClmu
	 x/p13X62Tsc4Jxl/GqJW6UbrpVrktZW5HkN87lgg3xILVz8csgZMycIGZ7AHO6gNab
	 wqZRNwXh9BLRVXetsJGgBZL/j0lGnvxwVWtUP8omYolz2cNk5tr5GKTNJUjyuiIlo4
	 wGDchgPPH2DMfXvsQk6egHSTMRK+1x13RQgQX9OEbqCv7kWMksjmxycsReUviyCXS+
	 DJH76KlqP8L9ognj87E3SbVm2bIjx2D8d6Uui4ckKkzhq3N295FnbC8NQaO0hi8Dhf
	 vYZZ4fM49ZSpg==
From: djakov@kernel.org
To: naresh.kamboju@linaro.org,
	lkft@linaro.org,
	nathan@kernel.org,
	djakov@kernel.org
Cc: kees@kernel.org,
	konradybcio@kernel.org,
	quic_okukatla@quicinc.com,
	quic_rlaggysh@quicinc.com,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] interconnect: qcom: icc-rpm: Set the count member before accessing the flex array
Date: Wed,  4 Dec 2024 00:33:34 +0200
Message-Id: <20241203223334.233404-1-djakov@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Georgi Djakov <djakov@kernel.org>

The following UBSAN error is reported during boot on the db410c board on
a clang-19 build:

Internal error: UBSAN: array index out of bounds: 00000000f2005512 [#1] PREEMPT SMP
...
pc : qnoc_probe+0x5f8/0x5fc
...

The cause of the error is that the counter member was not set before
accessing the annotated flexible array member, but after that. Fix this
by initializing it earlier.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Closes: https://lore.kernel.org/r/CA+G9fYs+2mBz1y2dAzxkj9-oiBJ2Acm1Sf1h2YQ3VmBqj_VX2g@mail.gmail.com
Fixes: dd4904f3b924 ("interconnect: qcom: Annotate struct icc_onecell_data with __counted_by")
Signed-off-by: Georgi Djakov <djakov@kernel.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index a8ed435f696c..ea1042d38128 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -503,6 +503,7 @@ int qnoc_probe(struct platform_device *pdev)
 			    GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
+	data->num_nodes = num_nodes;
 
 	qp->num_intf_clks = cd_num;
 	for (i = 0; i < cd_num; i++)
@@ -597,7 +598,6 @@ int qnoc_probe(struct platform_device *pdev)
 
 		data->nodes[i] = node;
 	}
-	data->num_nodes = num_nodes;
 
 	clk_bulk_disable_unprepare(qp->num_intf_clks, qp->intf_clks);
 

