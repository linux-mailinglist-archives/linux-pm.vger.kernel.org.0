Return-Path: <linux-pm+bounces-7819-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BFA8C4F64
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 12:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A23121C20B09
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 10:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90FA1272D6;
	Tue, 14 May 2024 10:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0lcbUX74";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s7f4ORR3"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5221D86130
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 10:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681942; cv=none; b=Wx+UR7EIUAjb6LKyg03Yq2bZDCexYg83hpsZAkjWfxbcRbj4PpKY7BZ2mKtKCn43qHX+fDl5lrqvX0aV6gYorA2DBDMlYaE7gGc2/SOZkMLWlcAd4zizGj+EHH1KDecMxUt4mlpCPXIt34bj3u5TSqLogJwpktrfcX+egN8lQ+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681942; c=relaxed/simple;
	bh=CUu2P4TRJsfe7yqEOYjw/OvNrb2ZVHDEb5fuuk7S0Is=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VisUPeu/UYKwRbfYSWqLDPYEbgarKS3866pGWaYyXeCPADTP95C2ZuIB3j/JBwtqy2mDNb314APdEkutoLZL40xvNrif/+qqjlbC0p/3yK9cMJT84hOikGrcYeEeXRTHG3yEWbVR8taJ4xNtDH0JpctuNF8ciDGdTWxpdEd+urs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0lcbUX74; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s7f4ORR3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 14 May 2024 10:18:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715681934;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kereudTyL1cfyJtdkR3CfdjNt7A2Vay01OnNRIIZiK0=;
	b=0lcbUX743oIVWfvFa7rrif6dzjntSLouIbNk4oux5VajNp1xTDx3B+x2uLdNz5abEd9aqU
	6jG6EklMMPEbxaPExfzmGyCpeMlz2/QjduP1czBiV3NkIkQVHqcGqMkH+rzUNrENm/YPGF
	jX+dOCss2HtT7NQSR9b79LupswFgBNDD9VBxT32ci9Bl9+R+dD6z0Sjl7vRXDwO9aKnbQa
	A+yFybAivnnBLr28BVOUyWjvycE7IgTl2xactmdtrd+gXUBofZWu/RLJ7p+IQi6zPMK8qK
	E+xqO0DDHNEIkUssqL3zGmMjejCoFdjWaOYVX/VlaboaRC4JgPtwcbsm/wwxow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715681934;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kereudTyL1cfyJtdkR3CfdjNt7A2Vay01OnNRIIZiK0=;
	b=s7f4ORR3v3NtocTp4tsRpO+4iCOsZC7IST9VIcj6z1ZRMHtzYs3wt50hT9aklINPelqeF1
	EiF3uqTSEe7eQfAg==
From: "thermal-bot for Christophe JAILLET" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/fixes] thermal/drivers/k3_bandgap: Remove some
 unused fields in struct k3_bandgap
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
 amitk@kernel.org
In-Reply-To: =?utf-8?q?=3C206d39bed9ec6df9b4d80b1fc064e499389fc7fc=2E17126?=
 =?utf-8?q?87420=2Egit=2Echristophe=2Ejaillet=40wanadoo=2Efr=3E?=
References: =?utf-8?q?=3C206d39bed9ec6df9b4d80b1fc064e499389fc7fc=2E171268?=
 =?utf-8?q?7420=2Egit=2Echristophe=2Ejaillet=40wanadoo=2Efr=3E?=
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171568193454.10875.14882299042134798669.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the thermal/fixes branch of thermal:

Commit-ID:     61fad0a90685d3aaafb05fb6abc1fe39fbb90320
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//61fad0a90685d3aaafb05fb6abc1fe39fbb90320
Author:        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
AuthorDate:    Tue, 09 Apr 2024 21:56:43 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Apr 2024 12:40:29 +02:00

thermal/drivers/k3_bandgap: Remove some unused fields in struct k3_bandgap

In "struct k3_bandgap", the 'conf' field is unused.
Remove it.

Found with cppcheck, unusedStructMember.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/206d39bed9ec6df9b4d80b1fc064e499389fc7fc.1712687420.git.christophe.jaillet@wanadoo.fr
---
 drivers/thermal/k3_bandgap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/k3_bandgap.c b/drivers/thermal/k3_bandgap.c
index e88192d..2a70377 100644
--- a/drivers/thermal/k3_bandgap.c
+++ b/drivers/thermal/k3_bandgap.c
@@ -78,7 +78,6 @@ static const int k3_adc_to_temp[] = {
 
 struct k3_bandgap {
 	void __iomem *base;
-	const struct k3_bandgap_data *conf;
 };
 
 /* common data structures */

