Return-Path: <linux-pm+bounces-37538-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D3BC3C907
	for <lists+linux-pm@lfdr.de>; Thu, 06 Nov 2025 17:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81F56188ABC5
	for <lists+linux-pm@lfdr.de>; Thu,  6 Nov 2025 16:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A882C158D;
	Thu,  6 Nov 2025 16:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UuFdifao"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177D62BEC4E
	for <linux-pm@vger.kernel.org>; Thu,  6 Nov 2025 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762447611; cv=none; b=jVYp3i8NXPZd3RCLsRtZv3l0emD37V0xsKpy3xePSez0DD60n1n2xvqNXVti92MacIExu8SR0dYJVMzjG3Is1npCIFIt8eNoPtjM9xj1fnCOEuwkLx5NgoBW3XPCBBiuIuMKZv6FQSqk/KQ6oMf3HG63XbQI3VbGCgYcyCcHe1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762447611; c=relaxed/simple;
	bh=VtfB1KUcFL0xMOsOi2+T3R/0Iq6++CHZOUryBlQUghc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nFEMQcynhtkLwhaNA79k7YoAk3oRPkQDeu8qY+gJQXy31CZrNtRsvfx0WRMgRL5ORvcNlX3W61SdLcoz3AXhMIir6GoTfbpIKslYtl/lIVmXI1QjQ2mJpalYq26dyanu6noRZRmFm493JHupFZMDbp97AEZi48IYqwOYYt/7SfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UuFdifao; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42421b1514fso664232f8f.2
        for <linux-pm@vger.kernel.org>; Thu, 06 Nov 2025 08:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762447607; x=1763052407; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F2CGjwOEf268xK6EpSqBlS6x+60lB39zWMEUAhOSh0M=;
        b=UuFdifaoEIXTXqvE9bfQebm470pxnj/ue8rAwFfWl9zN8wvkn95xP2EcRs0OImi0Q5
         q9fXUrCPhda1bwQD593uoNytMKJ0gyunJy7/BuFsLO7uwi7QC2588xFN0bASjWKxS6wZ
         NBtVZrzPKhp0Fu5cG7hUdvS9izyWadJ99LhBpg/0oVFeaUMjNYVzDc4pLHq4t6xf/RCn
         mtAVWXimGIyR9Dp0K+5uulT/Tjln84hix3DoK89Dihjj+5VqmTykMLS4l5iqaIf7fpgv
         MLUg5cvwwfHwmX9Ix2X4GQamM66M3DIy4NtpUgsxY9SRUT/Kg5K1CBfhx+dUO3vaykBR
         MjVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762447607; x=1763052407;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F2CGjwOEf268xK6EpSqBlS6x+60lB39zWMEUAhOSh0M=;
        b=a8hmNoKOkFpBPCqkfUKJS3rUgr8WCRi7ci/fP8hglEIvRwnsPTTQfG6fLx19j89kcC
         Xy4M47hUGfBE+Wbf9rJp6ImKTaqHuGZgeei2bz5kDXVXnxpnUFtW32KQhF+pd/rD3TbK
         omBW1IzlSyccoL29b6I/xXWvOcCJN1X0F94ARxKfHHGXUPVtf5kI1IuqCoPYXjocBssR
         3e7MoIDhnTqQ+vkSdPBSoSIJQmKwzd3lo1C+DY7D1CzSSVGV5bHeHF2sraeHsBg2GndP
         MtihssJahQGCycC6diyaXxZLn9UvvKLqP5b3dORm0AMvmNDOvVlx8LDcnwxpwd3MOZrU
         k6Eg==
X-Forwarded-Encrypted: i=1; AJvYcCWutEMpTF7Bl8yRPyvRCKgNyBkGezCRupwd8IMXaxJ/q1BL/6kcv3+WLVB9OxnxjVl9wV/+cX3Kkw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/H6fiMuYEBG0O9tpzuDyQxVQ9A0SSpax/QViCOJrGLS1lYPgW
	LDlDs9iTmrIyg58iYFNzyqf2KCm1vitCRuXZnpykGTSaU7Kril//aBPp/TxaVZ0hFkA=
X-Gm-Gg: ASbGnctsWbXptY8YzGh49rhyg7Zanivp0hlbo456qReENQRnC1UhUGIQHvQ3VzFjZ89
	N7U8ML6sN/QuWPZC8USzHCz5OD+hc+rbu5GXtsjoQWhLY94TtOMi9csL5xG//gg9isp+CFS5iqV
	dBzJSXpwYuuXW+mtMlJDyci6DxZEPnvU9faXa6ro0QlqnrDLgHODpMEyyTmnmyNLC35tG8+Y+ty
	APQjl0rnDbIVtivC1zp0/Y0AXmlPslw9srD0Mmd0dbXX/ld5rHyDBB06N8/ko3jBF/1nXPK4ahD
	p1SFoaWUpXZXteLkObmnwFOsPnakwSUXCKTUurWGUzUD3LHJZ5yxXHEZBZJxL/BEJ6M7AcPjtnE
	/xPj4JaiarRcU0BU7cOXKD7pTtVVzFIlptN6/GodvvYuAVqr5C9kF6amBCsPT4WfURHFtHRtsFm
	yjmQrQPPUiacFbH83rbCvPxfqfe/+1le4=
X-Google-Smtp-Source: AGHT+IEtwk06j8D/enrqc1dAKzkU0iQg4RByjCkBxEdT7ejlbyuD/EIdmlvPWrYAon2QhBk/29tStg==
X-Received: by 2002:a5d:5f87:0:b0:429:bc93:9d8a with SMTP id ffacd0b85a97d-429e3307958mr6910042f8f.37.1762447607101;
        Thu, 06 Nov 2025 08:46:47 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe63e131sm90856f8f.20.2025.11.06.08.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:46:46 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 06 Nov 2025 17:46:45 +0100
Subject: [PATCH RFC RFT] interconnect: qcom: implement get_bw with
 rpmh_read
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-topic-sm8x50-icc-read-rpmh-v1-1-d03a2e5ca5f7@linaro.org>
X-B4-Tracking: v=1; b=H4sIAPTQDGkC/x3MMQqEMBBA0avI1A4kwahsK3gA2U62iHFcp1DDZ
 BFBvPtGy/eLf0IkYYrwyk4Q2jnytiboPAM/u/VLyGMyGGWs1qrE3xbYY1zqwypk71HIjShhmZE
 GV5TaFdZQBWkQhCY+nnkPXdvcrWvf8LmuPzt5XXd4AAAA
X-Change-ID: 20251106-topic-sm8x50-icc-read-rpmh-eba461a452e7
To: Georgi Djakov <djakov@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5545;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=VtfB1KUcFL0xMOsOi2+T3R/0Iq6++CHZOUryBlQUghc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBpDND2tt6nZcw4CZUEUyupiX0UreTRwt5d96EDwFcD
 QDV+RbCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaQzQ9gAKCRB33NvayMhJ0axID/
 0Xgp1xS98+LLt5JkxiMa/1b0DsaA3DWKpVweXhtTmQruL3NMCPYIrW9nOVvJWbfB/KoP7E1/QHEbXJ
 B16LxSIGg8iUChhtFCQPuj+O0DIMZRlShnbcCrEev76M+cDfbCnJ9jUEI6wqgQR7mN0ZXELF6ukx6F
 Pn/ELrSEmHlAQTtx39p0+0BkEwJ7K0++JQOIeQuMNAE5bRXBW9gtUbtlh0NjWG07yQdiPqf+Wg6H7M
 6i755lXU5j8CgohGYLrPkxhk0DfyqQaOSXwKKN0bBQAaCkRp0r35TjDCzk9oc3WSzpuDHe0V6DJj9L
 Tr9HLUBpXQSfTfHC4wHQiGhBIHOWtiitES4p4J8aWyRVGqu9WHLdf8pMjfPxAx1AR6My6JIN6CQU5T
 t1ISB9txK4v2NH8m+t/xrWzQCQBI7hzLLPTmf94y5dflqK6fDMlmd3R8Qp1At7IEy4/VaGToRzBAki
 xteMol9KILSalswzJ/Ot4IW+R4JXdgj/BYstuUkpqE49HoSIqQIwOBIstqPWvy/NAr3Qo2F7y/8dTv
 3qbld4pOgDuW58vBMBASW7tfVZlONRXhML90gNAmZ+n0yyfPzM//yAq9W6Qe/QZaQSPcBKE8qp9IRl
 I42lFgVNbYMBso+Q7kUwbGrkM+7UZcfs7L2HNrIKgvdKq1UfW9pwO1KSotvA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Since we can actually read back the APPS rpmh interconnect
BCM votes we can actually implement the get_bw() callback
and provide a coherent average and peak bandwidth at probe time.

The benefits of that are:
- keep disabled BCMs disabled
- avoid voting unused BCMs to INT_MAX

If the interconnects are correctly described for a platform,
all the required BCMs would be voted to the maximum bandwidth
until sync_state is reached.

Since we only get the BCM vote, we need to redistribute
the vote values to the associated nodes. The initial BCM
votes are read back at probe time in order to be ready when
the get_bw() is called when a node is added.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Depends on:
https://lore.kernel.org/all/20251022-add-rpmh-read-support-v2-2-5c7a8e4df601@oss.qualcomm.com/
---
 drivers/interconnect/qcom/bcm-voter.c | 36 +++++++++++++++++++++
 drivers/interconnect/qcom/bcm-voter.h |  2 ++
 drivers/interconnect/qcom/icc-rpmh.c  | 60 ++++++++++++++++++++++++++++++++++-
 3 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
index a2d437a05a11..9014bf20adad 100644
--- a/drivers/interconnect/qcom/bcm-voter.c
+++ b/drivers/interconnect/qcom/bcm-voter.c
@@ -261,6 +261,42 @@ void qcom_icc_bcm_voter_add(struct bcm_voter *voter, struct qcom_icc_bcm *bcm)
 }
 EXPORT_SYMBOL_GPL(qcom_icc_bcm_voter_add);
 
+/**
+ * qcom_icc_bcm_get_bw - get current bcm vote
+ * @voter: voter used to query bcm
+ * @bcm: bcm to get current vote from
+ */
+void qcom_icc_bcm_get_bw(struct bcm_voter *voter,
+			 struct qcom_icc_bcm *bcm)
+{
+	struct tcs_cmd cmd = { .addr = bcm->addr };
+	int ret, i;
+	u64 x, y;
+
+	mutex_lock(&voter->lock);
+
+	rpmh_invalidate(voter->dev);
+
+	ret = rpmh_read(voter->dev, &cmd);
+	if (ret) {
+		pr_err("Error sending AMC RPMH requests (%d)\n", ret);
+		goto out;
+	}
+
+	x = FIELD_GET(BCM_TCS_CMD_VOTE_X_MASK, cmd.data);
+	y = FIELD_GET(BCM_TCS_CMD_VOTE_Y_MASK, cmd.data);
+
+	/* For boot-up, fill the AMC vote in all buckets */
+	for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
+		bcm->vote_x[i] = x;
+		bcm->vote_y[i] = y;
+	}
+
+out:
+	mutex_unlock(&voter->lock);
+}
+EXPORT_SYMBOL_GPL(qcom_icc_bcm_get_bw);
+
 /**
  * qcom_icc_bcm_voter_commit - generates and commits tcs cmds based on bcms
  * @voter: voter that needs flushing
diff --git a/drivers/interconnect/qcom/bcm-voter.h b/drivers/interconnect/qcom/bcm-voter.h
index b4d36e349f3c..338cdc16653d 100644
--- a/drivers/interconnect/qcom/bcm-voter.h
+++ b/drivers/interconnect/qcom/bcm-voter.h
@@ -13,6 +13,8 @@
 #include "icc-rpmh.h"
 
 struct bcm_voter *of_bcm_voter_get(struct device *dev, const char *name);
+void qcom_icc_bcm_get_bw(struct bcm_voter *voter,
+			 struct qcom_icc_bcm *bcm);
 void qcom_icc_bcm_voter_add(struct bcm_voter *voter, struct qcom_icc_bcm *bcm);
 int qcom_icc_bcm_voter_commit(struct bcm_voter *voter);
 
diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
index 001404e91041..202bbb565de0 100644
--- a/drivers/interconnect/qcom/icc-rpmh.c
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -136,6 +136,61 @@ int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 }
 EXPORT_SYMBOL_GPL(qcom_icc_set);
 
+static int qcom_icc_get_bw(struct icc_node *node, u32 *avg, u32 *peak)
+{
+	struct qcom_icc_node *qn = node->data;
+	u32 avg_max = 0;
+	u32 peak_max = 0;
+	u64 x, y;
+	int i;
+
+	if (!qn->num_bcms) {
+		*avg = INT_MAX;
+		*peak = INT_MAX;
+
+		return 0;
+	}
+
+	for (i = 0; i < qn->num_bcms; ++i) {
+		struct qcom_icc_bcm *bcm = qn->bcms[i];
+
+		/* Use AMC vote for boot-up */
+		x = bcm->vote_x[QCOM_ICC_BUCKET_AMC];
+		y = bcm->vote_y[QCOM_ICC_BUCKET_AMC];
+
+		/* Consider enable mask and convert to INT_MAX */
+		if (bcm->enable_mask) {
+			if (x & bcm->enable_mask)
+				avg_max = INT_MAX;
+			if (y & bcm->enable_mask)
+				peak_max = INT_MAX;
+		} else {
+			if (x) {
+				x *= bcm->aux_data.unit;
+				do_div(x, bcm->vote_scale);
+				x *= qn->buswidth * qn->channels;
+				do_div(x, bcm->aux_data.width);
+
+				avg_max = max(avg_max, x);
+			}
+
+			if (y) {
+				y *= bcm->aux_data.unit;
+				do_div(y, bcm->vote_scale);
+				y *= qn->buswidth;
+				do_div(y, bcm->aux_data.width);
+
+				peak_max = max(peak_max, y);
+			}
+		}
+	}
+
+	*avg = avg_max;
+	*peak = peak_max;
+
+	return 0;
+}
+
 /**
  * qcom_icc_bcm_init - populates bcm aux data and connect qnodes
  * @bcm: bcm to be initialized
@@ -255,6 +310,7 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
 	provider = &qp->provider;
 	provider->dev = dev;
 	provider->set = qcom_icc_set;
+	provider->get_bw = qcom_icc_get_bw;
 	provider->pre_aggregate = qcom_icc_pre_aggregate;
 	provider->aggregate = qcom_icc_aggregate;
 	provider->xlate_extended = qcom_icc_xlate_extended;
@@ -272,8 +328,10 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
 	if (IS_ERR(qp->voter))
 		return PTR_ERR(qp->voter);
 
-	for (i = 0; i < qp->num_bcms; i++)
+	for (i = 0; i < qp->num_bcms; i++) {
 		qcom_icc_bcm_init(qp->bcms[i], dev);
+		qcom_icc_bcm_get_bw(qp->voter, qp->bcms[i]);
+	}
 
 	for (i = 0; i < num_nodes; i++) {
 		qn = qnodes[i];

---
base-commit: c077667d2d33618e2053f79ec60300dae7a58e0c
change-id: 20251106-topic-sm8x50-icc-read-rpmh-eba461a452e7

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


