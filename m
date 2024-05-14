Return-Path: <linux-pm+bounces-7838-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 968488C4F78
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 12:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08006281472
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 10:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30586140364;
	Tue, 14 May 2024 10:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SWiZz3yc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2Eerg6hG"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC231272AA;
	Tue, 14 May 2024 10:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681946; cv=none; b=K88cGzFzUuccw3Ll0QMvGHJBftwkd1HdsSHwIDWCuFBAdtoeC8nZGAwUPaqJcBNFVoXQoBfI/AfujZ5tXkfE936oWOiTCOroCchOIPYvww/FVNQnJ89EsrF/tF7pV0wlSEkhA6QyZ7O3NKcTOXSyTeGCsIZjEc+aLF6Q1kpoamc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681946; c=relaxed/simple;
	bh=6BIr+iV2OhsRt4nCZzAuo/HXJcAx2NSApw1XJqqXXxI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qBs+aQEM9F5LfU521eBopf/TMl0KVwc+FS2q8Yu4l6bNk/TLyqBK14E0DJ1vaoq5Ft9gdOQKZDlRp90sa43OMC8mrIcEIhyo+l2Laj96k8qdBkAGF15OTK6xXRsRM7kft0fDLcK7Cr1Csuwj3fx5GKjRYuxrAaKMBG/uYe64+nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SWiZz3yc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2Eerg6hG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 14 May 2024 10:18:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715681936;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wyFpBcmzbKLMfZOZFpCfVmK9O+l3SWdXUM/gelxRceo=;
	b=SWiZz3ychb0xGRhtlUjjmbX/I0S+QprY9xGXro4X3v+5Y7UqiphFg85cr2r30gt80MECK9
	h67gegGd6pW8y4AKUBl6+E4FfnqYK91QpG76FK0ifNzVkmJ+UBKHpkwr340g1JBqG2hDFg
	mbdnUrRu8nlTJlsxjMmJC9v65FEv9NlJ2jTCkXQr4zJ4MEmLDuaS07bt6Uyjyu9kUgj4+o
	UsQ6Yp66442s1pStem5fcSGRmCkgD/kvmqdPBWEPVVhA+a/Kj4KGU0t6qwi8PXPi9sKhN2
	GzgUYaVmPI/TUG8JL/s9bdZFRu8pONoSg8gbXVaAWA5jQp672h+07VgI2wSkYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715681936;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wyFpBcmzbKLMfZOZFpCfVmK9O+l3SWdXUM/gelxRceo=;
	b=2Eerg6hGf4AjxfeojmEtzbrLf4nSA657IScPPtEUN4WGEA904M61guLda4RxOM4SVQmxWq
	M3fbU5b2qjYvCVDg==
From: "thermal-bot for Konrad Dybcio" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/fixes] thermal/drivers/qcom/lmh: Check for SCM
 availability at probe
Cc:  <stable@vger.kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
 amitk@kernel.org
In-Reply-To: <20240308-topic-rb1_lmh-v2-2-bac3914b0fe3@linaro.org>
References: <20240308-topic-rb1_lmh-v2-2-bac3914b0fe3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171568193607.10875.2373863921021975776.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the thermal/fixes branch of thermal:

Commit-ID:     d9d3490c48df572edefc0b64655259eefdcbb9be
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//d9d3490c48df572edefc0b64655259eefdcbb9be
Author:        Konrad Dybcio <konrad.dybcio@linaro.org>
AuthorDate:    Sat, 09 Mar 2024 14:15:03 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Apr 2024 12:40:29 +02:00

thermal/drivers/qcom/lmh: Check for SCM availability at probe

Up until now, the necessary scm availability check has not been
performed, leading to possible null pointer dereferences (which did
happen for me on RB1).

Fix that.

Fixes: 53bca371cdf7 ("thermal/drivers/qcom: Add support for LMh driver")
Cc: <stable@vger.kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20240308-topic-rb1_lmh-v2-2-bac3914b0fe3@linaro.org
---
 drivers/thermal/qcom/lmh.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
index f6edb12..5225b36 100644
--- a/drivers/thermal/qcom/lmh.c
+++ b/drivers/thermal/qcom/lmh.c
@@ -95,6 +95,9 @@ static int lmh_probe(struct platform_device *pdev)
 	unsigned int enable_alg;
 	u32 node_id;
 
+	if (!qcom_scm_is_available())
+		return -EPROBE_DEFER;
+
 	lmh_data = devm_kzalloc(dev, sizeof(*lmh_data), GFP_KERNEL);
 	if (!lmh_data)
 		return -ENOMEM;

