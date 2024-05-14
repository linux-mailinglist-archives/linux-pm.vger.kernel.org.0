Return-Path: <linux-pm+bounces-7820-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 008518C4F66
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 12:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EAC81F22D85
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 10:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AC4127B50;
	Tue, 14 May 2024 10:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4kvqBNAt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uW/vvYX4"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561E686134
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 10:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681942; cv=none; b=P8Vgx3x/fZB2fK6e6t6p0YbfBHISGs77uRxZ8ZeBj6F+yYA+E0OMFbHjLZeMijiVRnt3SDywqaXzgpsB3YQTbFxTix3QBJ6ByABGmXmIHy741+70RKzpuvhpSwhdsIOIgCP2r+pR+p/r59z2VVnnoqhI4PaL7QIc+xVG9Jt3BGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681942; c=relaxed/simple;
	bh=LW304zCAAtQ6GsothVY94fAn3TA4umpzIc4XLoAbXHQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XnUt4RpYIlvJMkA7AQ3db4SjfAponKbkZGRDnKeoXgdwhkDhOX0MYXlPTYD/x+W2kCUUXGolkoLOQwhnA4WNDA5J61q+hJmFYGVezCBWE0JYSL11H95XtfgzuHC34qNGAduyGY4vZeJMs6Q4aaiSPIHkYcpW9ItnGO0zSUIRukQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4kvqBNAt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uW/vvYX4; arc=none smtp.client-ip=193.142.43.55
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
	bh=Kg47aVKCuVjybDSeZicgZ/q0i0vF9LwLlp8Xiw4f1e8=;
	b=4kvqBNAtVOpe8TuN8+KgfXCvPLD0mbNcUCvKyr7GrSIR4ffpVh/fusWD0XtkqLcYEgTlwS
	IB919FQInri8ccIT/SSMD5vaGFy+1VhqeEnsnO5ECAV+a25cdaE2zhgiO3Hrihy17BLYqs
	3GqZ7j0VJY2/mpO3SAg40GDiRykHIsqrK38U6k+NEzmIMOmJdwTDnw6LFBa4XEM861xecB
	hWjpDiQmd9Q7L2I2hEY9VH9RahmTNNYGNiIjAAmfCv89tSIqG6uqVvACCJmPGkI4WuQB8C
	zkxwS/diOHpr4SxidmuFr4mUYaATB1x9SqLdCI8/tJNmFgmxVC2wfKfKVNGmFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715681934;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kg47aVKCuVjybDSeZicgZ/q0i0vF9LwLlp8Xiw4f1e8=;
	b=uW/vvYX4wbXT/Rpa3L8FGruBoN+Vw4C8tNm0+Ez2pMxC6wfz34KX+q7gXtl8XWNjDa5EWw
	4kN/OdmTShD/LRCA==
From: "thermal-bot for Christophe JAILLET" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/fixes] thermal/drivers/qcom: Remove some unused
 fields in struct qpnp_tm_chip
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Bjorn Andersson <andersson@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
 amitk@kernel.org
In-Reply-To: =?utf-8?q?=3Cd1c3a3c455f485dae46290e3488daf1dcc1d355a=2E17126?=
 =?utf-8?q?87589=2Egit=2Echristophe=2Ejaillet=40wanadoo=2Efr=3E?=
References: =?utf-8?q?=3Cd1c3a3c455f485dae46290e3488daf1dcc1d355a=2E171268?=
 =?utf-8?q?7589=2Egit=2Echristophe=2Ejaillet=40wanadoo=2Efr=3E?=
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171568193465.10875.14001203984054116212.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the thermal/fixes branch of thermal:

Commit-ID:     0a0c8db8843c5d5e22e2ee275c35d6ecd0659414
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//0a0c8db8843c5d5e22e2ee275c35d6ecd0659414
Author:        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
AuthorDate:    Tue, 09 Apr 2024 21:56:34 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Apr 2024 12:40:29 +02:00

thermal/drivers/qcom: Remove some unused fields in struct qpnp_tm_chip

In "struct qpnp_tm_chip", the 'prev_stage' field is unused.
Remove it.

Found with cppcheck, unusedStructMember.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/d1c3a3c455f485dae46290e3488daf1dcc1d355a.1712687589.git.christophe.jaillet@wanadoo.fr
---
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index 78c5cfe..3cd74f6 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -74,7 +74,6 @@ struct qpnp_tm_chip {
 	long				temp;
 	unsigned int			thresh;
 	unsigned int			stage;
-	unsigned int			prev_stage;
 	unsigned int			base;
 	/* protects .thresh, .stage and chip registers */
 	struct mutex			lock;

