Return-Path: <linux-pm+bounces-30897-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC69DB07590
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 14:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D1017A221B
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 12:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB062F5080;
	Wed, 16 Jul 2025 12:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekgZ1jVw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200612F49FD;
	Wed, 16 Jul 2025 12:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752668759; cv=none; b=nhbUEDAOf/ltAT67VfdL5fIRc94nMiHJJDEv+/kbGBHjcvUCUlRvYE8mH4WfTfUfvrQLPEN4DbZXOI1QTbjWcAfL/wHPML99pEWCeNbZ91zKpLV7zNePnntVHIO4BHlLB0yBZHaZBFzlvauxAZT9MfqsjrSTGJZ7L8COdVbrM7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752668759; c=relaxed/simple;
	bh=T+uHPDkmrZ9hLoZD97UTMy+ereQPLJwBf8Q6hxuvHsE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cwN8kQubJ2h+/ZULFc7+Eyh+A/vVGNrbFMfNV6MCg1xL/Lbb/nopVcRvn0/9JAqH3Yxa1dtiDINlkvlwfnwIUEqMDOgmR5MngHPvkjBwn1Pw9Mv5AcsUQys2xqyk1zo21/vfIXqJXUgXgmgTW0tErXbqeRf3h3ekgMUiZlSk3ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekgZ1jVw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B921C4CEF0;
	Wed, 16 Jul 2025 12:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752668758;
	bh=T+uHPDkmrZ9hLoZD97UTMy+ereQPLJwBf8Q6hxuvHsE=;
	h=From:Subject:Date:To:Cc:From;
	b=ekgZ1jVwPLGdvU+8u9k8IwAmXbzL5HBTGTbwSebXRX/SiaZ8p0ijqKxGcsUUsPOaM
	 xo9y6WBxqvsrb0KR/jUVo7Xpk1xGlLhC1Ftf7NESdbs8vwbKpYRMBcX3qwkOfF8LWh
	 nwXW91zeBD3xEPiN7Kghhga9gcqR9Yt25V8Xb8FmGcMFkGM8i23NtS9l05BMv4Cmgp
	 YSt4PhNhDRj215s3ExPWGcp6nMoKML+8aDETWZNLQ0RIdEztCZzJc9ozBjelh7nCFF
	 N8kCbbe33vtAAHxnY/NgzVZF7ya/LhYzcEtPVDVRiB2slEZ+AGY1kuVh0b6NAQ+wk8
	 VNotX+yNa7GxQ==
From: Konrad Dybcio <konradybcio@kernel.org>
Subject: [PATCH v4 0/2] SM8750 CPU BWMONs
Date: Wed, 16 Jul 2025 14:25:45 +0200
Message-Id: <20250716-8750_cpubwmon-v4-0-12212098e90f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEmad2gC/0XMTQ6CMBBA4auQWTumUMqPK+9hDCllkFm0xRbQh
 HB3GzYu3+J9O0QKTBFu2Q6BNo7sXYrykoGZtHsR8pAaClEoUecVNrUSnZnX/mO9w1o2UlSNak0
 1QnrmQCN/T+/xTD0Gb3GZAum/IkWJ0Z7OiXRWx4UCbhJzFLlWppdSDEN7f69s2Jmr8RaO4wdBN
 jDJrAAAAA==
X-Change-ID: 20250716-8750_cpubwmon-738306859c6f
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Shivnandan Kumar <quic_kshivnan@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752668753; l=937;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=T+uHPDkmrZ9hLoZD97UTMy+ereQPLJwBf8Q6hxuvHsE=;
 b=vR+N6916NbcvXpiQzfkgjv5ypa6RNHX6yUciJ4EseUGTEvGqaE36UKlsjwTSrPwIvHdm/C36v
 QcJ6iZ9XqTFApOil4bYWyNhu8QK9XuRyK6Pu3JrrmIKyxdhcvd0+m2l
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Taking this series over from Melody, just adding some small changes
(see below):

Changes in v4:
- Extend the bindings as necessary
- Re-position the nodes to maintain order
- Add nonposted-mmio for the instance that needs it
Link to v3: https://lore.kernel.org/linux-arm-msm/20250304-sm8750_bwmon_master-v3-1-01a5cb330dd9@quicinc.com/

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
Konrad Dybcio (1):
      dt-bindings: interconnect: qcom,msm8998-bwmon: Allow 'nonposted-mmio'

Shivnandan Kumar (1):
      arm64: dts: qcom: sm8750: Add BWMONs

 .../bindings/interconnect/qcom,msm8998-bwmon.yaml  |  2 +
 arch/arm64/boot/dts/qcom/sm8750.dtsi               | 76 ++++++++++++++++++++++
 2 files changed, 78 insertions(+)
---
base-commit: 0be23810e32e6d0a17df7c0ebad895ba2c210fc4
change-id: 20250716-8750_cpubwmon-738306859c6f

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>


