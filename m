Return-Path: <linux-pm+bounces-40747-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB3ED19DFE
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 16:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 353EB3035CCD
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 15:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA785392B82;
	Tue, 13 Jan 2026 15:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4DnGmtp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BE4392811;
	Tue, 13 Jan 2026 15:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768317944; cv=none; b=YSgXkT2syb1nxR+zNNv68SmXMiMh5kbn9ovnAU7VqurdFTYjaX8/mACZZsWwe4oAx3hLsygNAn/VAo2KG+WxHLYSi3mn0jWk0WoEXPIhRg689sVc5oCpto85PprMRBQisJVpb+yhfeL2Evy7Ju22/PKGvRla4ksooftRNXEIp8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768317944; c=relaxed/simple;
	bh=raBJLWD5LA8It0YIudiPlrF4r9VUcqtIJhd+MYO7NB8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=R32Ngeki3U5DnM7u/M0uGrNJV2Lz1buepvPxm8lBXg6afp6m2rM9AQm89H8CvXQFEkUoxYpoWvEfIqZVde3adifPAHzos4f434WKzhtLHLCDvpWlbVn04RFni1vibukamok2xf6xZVK/yxLLG7qdlsLzAoXoAxppndMUyeOCgsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4DnGmtp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C00BC19424;
	Tue, 13 Jan 2026 15:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768317944;
	bh=raBJLWD5LA8It0YIudiPlrF4r9VUcqtIJhd+MYO7NB8=;
	h=From:Date:Subject:To:Cc:From;
	b=L4DnGmtp1TTAK3hdrDTnGba2fR5Bsnql20TghP9/nqB50mu87qN98jjdQHvZ7xhpu
	 cSIHs4rg115YYQ5Qp2kfqmVCTgbzfMQU8DYD8vlhWXzxSPPHGHjp1v8mBXBsebYDUO
	 ggbKwvv95uG9p4UMfm1f6A1Occu0EoDvHaDNu29fUN3risnNLwB0SE0s3PN6u4gP6g
	 Ert3iS/Kn5KlglKR2ELMv+ifB+vyh92ZYQrJxRKbQin+3gkt6M4UldJnJerenTo6PQ
	 DdpJcNdL3QINF/u/y91sbxU2dFTOA7wGX5phsR9CvEoZUaDTNoUHVNvbVRJFxUk/+P
	 KItXxKAJogczw==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Tue, 13 Jan 2026 16:25:35 +0100
Subject: [PATCH v2] cpufreq: dt-platdev: Block the driver from probing on
 more QC platforms
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260113-topic-cpufreq_block-v2-1-537cc7f06866@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NXQqDMBCEryL73Igbiz998h5Fiq5JXaomJiot4
 t2beoC+DHwD880OXjlWHm7RDk5t7NlMAeQlAuqb6akEd4FBJjJLEFOxGMskyK7aqfnRDoZegso
 2p6zI0uaKEJbWKc3v03qvA/fsF+M+58mGv/a/b0OBokQt805jmciiMt7H89oMZMYxDgH1cRxf+
 a+NS70AAAA=
X-Change-ID: 20260113-topic-cpufreq_block-c9b7c6863a41
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768317942; l=1365;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=cAzfbR6bvwKWdSEtfKVrqsUEXBq+KtS/nGIPykRkeXM=;
 b=ta9X/k888HHvlOBnZZuzuwUzqO+lHECYduiqnYw1V6KQkBVHouhIngy5PdnhmZ9JMf+KI2z4n
 AXaseQUChm1Cw1KvZRdNtEHFg3BoYS1dbfM3+jRtc9GOg+8S+HWG5/c
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Add a number of QC platforms to the blocklist, they all use either the
qcom-cpufreq-hw driver.

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
Changes in v2:
- Drop entries associated with scmi-cpufreq (no OPP table => wont probe anyway)
- Add SM7125
- Link to v1: https://lore.kernel.org/r/20260113-topic-cpufreq_block-v1-1-91f27df19028@oss.qualcomm.com
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 1708179b2610..471ec15ee27e 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -171,8 +171,11 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "qcom,sdm845", },
 	{ .compatible = "qcom,sdx75", },
 	{ .compatible = "qcom,sm6115", },
+	{ .compatible = "qcom,sm6125", },
+	{ .compatible = "qcom,sm6150", },
 	{ .compatible = "qcom,sm6350", },
 	{ .compatible = "qcom,sm6375", },
+	{ .compatible = "qcom,sm7125", },
 	{ .compatible = "qcom,sm7225", },
 	{ .compatible = "qcom,sm7325", },
 	{ .compatible = "qcom,sm8150", },

---
base-commit: 0f853ca2a798ead9d24d39cad99b0966815c582a
change-id: 20260113-topic-cpufreq_block-c9b7c6863a41

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>


