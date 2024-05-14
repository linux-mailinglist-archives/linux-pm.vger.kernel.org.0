Return-Path: <linux-pm+bounces-7816-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8BD8C4F63
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 12:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 518B41C20CA9
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 10:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970218627A;
	Tue, 14 May 2024 10:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xooZr7mI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3TyAUxUP"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2D584D05
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 10:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681941; cv=none; b=MoPw0fY6Tf+kR6LAI/R9tti8f/HHA2y5CGK59NM89qsfj087Vy/ikHT6NMdWqlxusFbN0OrCMw400FQi3WCBghfBpq/YtG9DFtZAU4h5WE4vI44YhONJZdntA67+Gdtp/k8/Y3HYVtGW3Q/vK5ev6oR987tfo3rQNv4cCk5TCH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681941; c=relaxed/simple;
	bh=DpZljzhuOBk5X/i+REtvJr44O3NSDINdZRXZtbcwopY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XNHonRc5Q4PzHrA4Wala0mOS1aC60qvwp5LtZBMt0lCMuHmK9kVwJEddGLyM4hEqJJ0Wor5OF06fJIgSqGxbSNWB+jlAbWFzAIcIuKoudZREwmowz//a29kY6Z4WtYlxdDz2Zyvw0xd5gXfa2T8u1gh2JrlBe0C2LgxXCeHZqJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xooZr7mI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3TyAUxUP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 14 May 2024 10:18:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715681933;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=efEPKOJpLXKLipIaLMP1+kAF5qcHhn8/tP3OJ7drtCk=;
	b=xooZr7mIrCrVrfmrAJxzcfYst41F+TyFwBBXG02ofIjkV+3bbddm4yHopiQMIkHCLdkTKf
	cihPiu0JABthedXxN/rjBY3udb15dqRx/ZMOv01Lk71OFU7dpUjKJJaTpwmSr5zOSNR4m8
	+B6oFsvwg1tBhpd2xqCNbp2D2IcCVvS9d0+4mSACnEFFHGHLD14Zg46HjWpDY189d2uB70
	YCndu265v4AxZVQqq4l23bTVGPkpnJPeyx63H0kfDRZ7IO+dwsezuLqWIh2N5Mwbm1b1cO
	D0bz717vyf1EnaM+WRDk2ZS36r+SA3Bgpapc2+0Te8xs4fsVK3BCQnvJV6V0LA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715681933;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=efEPKOJpLXKLipIaLMP1+kAF5qcHhn8/tP3OJ7drtCk=;
	b=3TyAUxUPs8MTdToty4hqSTrtbChu0xQFX15jVwXieMbf+uXRJCKtMtkflm03kXShxDkkvg
	pYsYmL51bSaFiCAg==
From: "thermal-bot for Binbin Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/fixes] dt-bindings: thermal: loongson,ls2k-thermal:
 Add Loongson-2K0500 compatible
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Rob Herring <robh@kernel.org>,
 Huacai Chen <chenhuacai@loongson.cn>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
 amitk@kernel.org
In-Reply-To: =?utf-8?q?=3C26524a63abd2d032e4c45efe6ce3fedb46841768=2E17138?=
 =?utf-8?q?37379=2Egit=2Ezhoubinbin=40loongson=2Ecn=3E?=
References: =?utf-8?q?=3C26524a63abd2d032e4c45efe6ce3fedb46841768=2E171383?=
 =?utf-8?q?7379=2Egit=2Ezhoubinbin=40loongson=2Ecn=3E?=
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171568193305.10875.7058615371880638134.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the thermal/fixes branch of thermal:

Commit-ID:     25c7d8472f6e90390931e93f59135478af3e5d86
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//25c7d8472f6e90390931e93f59135478af3e5d86
Author:        Binbin Zhou <zhoubinbin@loongson.cn>
AuthorDate:    Tue, 23 Apr 2024 09:59:01 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Apr 2024 12:40:30 +02:00

dt-bindings: thermal: loongson,ls2k-thermal: Add Loongson-2K0500 compatible

The thermal on the Loongson-2K0500 shares the design with the
Loongson-2K1000. Define corresponding compatible string, having the
loongson,ls2k1000-thermal as a fallback.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/26524a63abd2d032e4c45efe6ce3fedb46841768.1713837379.git.zhoubinbin@loongson.cn
---
 Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml b/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
index b634f57..9748a47 100644
--- a/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
@@ -20,6 +20,7 @@ properties:
           - loongson,ls2k1000-thermal
       - items:
           - enum:
+              - loongson,ls2k0500-thermal
               - loongson,ls2k2000-thermal
           - const: loongson,ls2k1000-thermal
 

