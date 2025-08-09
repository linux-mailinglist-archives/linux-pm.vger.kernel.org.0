Return-Path: <linux-pm+bounces-32082-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DEFB1F4E9
	for <lists+linux-pm@lfdr.de>; Sat,  9 Aug 2025 16:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 097AC18C08E9
	for <lists+linux-pm@lfdr.de>; Sat,  9 Aug 2025 14:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C552BD5BD;
	Sat,  9 Aug 2025 14:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="rUjWjcxO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74CE274666
	for <linux-pm@vger.kernel.org>; Sat,  9 Aug 2025 14:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754749035; cv=none; b=I9pK065OlYQF0yoa169EbvgnaiQMOY1k+IbgI7ufRBfk2DsdgxMDYu3AcTd3+ov9p3bpAlRDWTK+xwi4cLaLoXTDh09XiB4xhQKm32V9nOJBj6bgsrktWkQwfzLKJZRosiMRRLceyN9VYkvnrCqUX1P+Vm4px9TVTnTkJGGhym8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754749035; c=relaxed/simple;
	bh=oOl1lfLluUGf8jjlHcaqlYu8boxJMibtiQHsH1EO70Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/3l9UgwWKoYAJL+13X2Bj5t7e7vYacESW/gLvLmeseFVd9EtLKqDgPKDxwHcD/4Zv7xsuXo+n00TIJtzwk2KUEzh9muw3ePAfDC0/dhx4QP8F4UnsCGZqVkJLZ1qYK7sXcVFL7CDvt+3BCortGaFRbzdLQoiFB/HijgsPKTqyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=rUjWjcxO; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns2.iitb.ac.in (ldns2.iitb.ac.in [10.200.12.2])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 41E22104D00B
	for <linux-pm@vger.kernel.org>; Sat,  9 Aug 2025 19:47:09 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in 41E22104D00B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1754749029; bh=oOl1lfLluUGf8jjlHcaqlYu8boxJMibtiQHsH1EO70Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rUjWjcxO0askdcgNxpSgwzEpoIhQr0xWrF7Ia/h0BmtUQQjmhYg1zrgSmhym9CIwV
	 mPEiYvCkQkVATS/E25lXdwz4QUyb+ovlfjeryByMlPiI8fDwJEhInLV/9aWytTfEij
	 dV72HIsc0oeyqXQhNcIFY2r+WasaiiFkpdhZCsnM=
Received: (qmail 13276 invoked by uid 510); 9 Aug 2025 19:47:09 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns2 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.100.0/26337} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 4.460336 secs; 09 Aug 2025 19:47:09 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns2.iitb.ac.in) (10.200.1.25)
  by ldns2.iitb.ac.in with SMTP; 9 Aug 2025 19:47:04 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns2.iitb.ac.in (Postfix) with ESMTP id 3A54F341554;
	Sat,  9 Aug 2025 19:47:04 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id 1B40B1E81308;
	Sat,  9 Aug 2025 19:47:04 +0530 (IST)
Date: Sat, 9 Aug 2025 19:46:58 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: andrew@lunn.ch, gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com, rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, akhileshpatilvnit@gmail.com,
	skhan@linuxfoundation.org
Subject: [PATCH 1/1] cpufreq: armada-37xx: use max() to calculate target_vm
Message-ID: <26e67441fd3e91beca47fb4b6fb2accbe1088c79.1754747831.git.akhilesh@ee.iitb.ac.in>
References: <cover.1754747830.git.akhilesh@ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1754747830.git.akhilesh@ee.iitb.ac.in>

Use max() macro while calculating target_vm to simplify and improve the
armada-37xx-cpufreq driver code.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202503251256.rrl65HgY-lkp@intel.com/
Reported-by: Yang Ruibin <11162571@vivo.com>
Closes: https://lore.kernel.org/lkml/2c55fb07-b29e-43e0-8697-f75d1f0df89a@vivo.com/
Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
---
 drivers/cpufreq/armada-37xx-cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
index f28a4435fba7..0efe403a5980 100644
--- a/drivers/cpufreq/armada-37xx-cpufreq.c
+++ b/drivers/cpufreq/armada-37xx-cpufreq.c
@@ -265,7 +265,7 @@ static void __init armada37xx_cpufreq_avs_configure(struct regmap *base,
 	 */
 
 	target_vm = avs_map[l0_vdd_min] - 100;
-	target_vm = target_vm > MIN_VOLT_MV ? target_vm : MIN_VOLT_MV;
+	target_vm = max(target_vm, MIN_VOLT_MV);
 	dvfs->avs[1] = armada_37xx_avs_val_match(target_vm);
 
 	/*
@@ -273,7 +273,7 @@ static void __init armada37xx_cpufreq_avs_configure(struct regmap *base,
 	 * be larger than 1000mv
 	 */
 	target_vm = avs_map[l0_vdd_min] - 150;
-	target_vm = target_vm > MIN_VOLT_MV ? target_vm : MIN_VOLT_MV;
+	target_vm = max(target_vm, MIN_VOLT_MV);
 	dvfs->avs[2] = dvfs->avs[3] = armada_37xx_avs_val_match(target_vm);
 
 	/*
-- 
2.34.1


