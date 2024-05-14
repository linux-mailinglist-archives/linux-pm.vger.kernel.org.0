Return-Path: <linux-pm+bounces-7826-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 355E78C4F6E
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 12:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAE6DB2098F
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 10:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FB113F45C;
	Tue, 14 May 2024 10:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Oer5PG/e";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vCnIQow3"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF961272A7
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 10:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681944; cv=none; b=D6maizozBlhXM+4B7MAPAsfOlGzrWyDkZ+3p2T2zpT8ezcB3LT+KMN8Xtam++TYAGBGn/B93pf62GvMRtCTpN+Mviz/+2STAnV+qcUbX6IDN4kOKgcTlugSPqbpy1JtjmCCDUHoIaa9EAKViZ6bWGfTs2VaofpuZWbNfkTjU5eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681944; c=relaxed/simple;
	bh=Ed5hAmwKQZdSsVZyZGzGizFoLLw9rLglh78CX5JSd94=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YzDeQ8Jn7zPmtsx7irQMgfHtCTZ+LN2yI8awGLs+e6U/RFPHrjQYBQM7FNUwEXQ3eXoxrZ2kxO2adCUruHhMgeWmkjwJ6069tjRgODkidS+0Ny1K4yfRJEVHRUNjApBmt00XkBUFSaSyzR0XRNd8nUg5moq0Hgh5BXBC5qN1XGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Oer5PG/e; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vCnIQow3; arc=none smtp.client-ip=193.142.43.55
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
	bh=RVE23KpxGk0TZbUb5gNTt9QANV1hfqjZgs73j7M72yE=;
	b=Oer5PG/eu1N6ag5fci1lQkyEH5Cpv9aJX8VRdUcQpRjInU4C8ZaG05VzIcUp0XrJvRMLpi
	I0s0rYyYhLuuVvEICs/wguOD8xjhdk1Rriycy5P/ZuiVX//jHtyiwt3Q76yaKLKiS0smIW
	avO0+KBYTT3NV7R29cKQjTW+qnkIkWAO5oRp7Ad3gF2Njx0eVmcTdlD8SlN2bplaLG377T
	NmG+gvoL6PJ9pstG+Ui337WM+kaQNap84qwubuT/AuMmJ9wGwOjkgqCmss/6YHC+q5NOoi
	wvc58oaPpeY501do2BAgWvXi4Vsk3CH2l+8BzBZTKegj0mGWnRfzk5z6tHA71g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715681936;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RVE23KpxGk0TZbUb5gNTt9QANV1hfqjZgs73j7M72yE=;
	b=vCnIQow3Ut2aCZEjfukeQySN7oljZT3JrcIXD+lU4+CsAw06IqTp8pE7dz0mN2pFHUbJFm
	DKLpyfPxqanlMSAg==
From: "thermal-bot for Konrad Dybcio" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject:
 [thermal: thermal/fixes] dt-bindings: thermal: lmh: Add QCM2290 compatible
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
 amitk@kernel.org
In-Reply-To: <20240308-topic-rb1_lmh-v2-1-bac3914b0fe3@linaro.org>
References: <20240308-topic-rb1_lmh-v2-1-bac3914b0fe3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171568193618.10875.17828287418776104922.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the thermal/fixes branch of thermal:

Commit-ID:     c0f14ec95262cdcf557016f84b87e45f54e0b881
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//c0f14ec95262cdcf557016f84b87e45f54e0b881
Author:        Konrad Dybcio <konrad.dybcio@linaro.org>
AuthorDate:    Sat, 09 Mar 2024 14:15:02 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Apr 2024 12:40:29 +02:00

dt-bindings: thermal: lmh: Add QCM2290 compatible

Document the QCM2290 LMH.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20240308-topic-rb1_lmh-v2-1-bac3914b0fe3@linaro.org
---
 Documentation/devicetree/bindings/thermal/qcom-lmh.yaml | 12 +++++---
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml b/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
index 5ff72ce..1175bb3 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
@@ -17,10 +17,14 @@ description:
 
 properties:
   compatible:
-    enum:
-      - qcom,sc8180x-lmh
-      - qcom,sdm845-lmh
-      - qcom,sm8150-lmh
+    oneOf:
+      - enum:
+          - qcom,sc8180x-lmh
+          - qcom,sdm845-lmh
+          - qcom,sm8150-lmh
+      - items:
+          - const: qcom,qcm2290-lmh
+          - const: qcom,sm8150-lmh
 
   reg:
     items:

