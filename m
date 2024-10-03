Return-Path: <linux-pm+bounces-15089-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B470598EBA1
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2024 10:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0544EB24397
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2024 08:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E803D85C5E;
	Thu,  3 Oct 2024 08:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="vzNps3oh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA85B13A888;
	Thu,  3 Oct 2024 08:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727944248; cv=none; b=lwQOr/y/u+mKXGIe+B0W7hr8mjcGXjaxufelP53F2SIc9qNH1IHubYH5CI1b34z+Z2iy3Mq3q8CIbG6PxVBZcB4nNmhUBUJtsv+GWRBbMI2GwUBhoG8IJLwgXnSHnXwIVrN/dz5IXtNkjM3TDNBftFQYjkS90snJculqV2tEhiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727944248; c=relaxed/simple;
	bh=EKnNjWpQQ4+XEaLYjekJzpE9qiQi5KvrrlhUuLaAloY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Yi1L8yA/2eok0p/QcLYI0R6m32o/Zk0eATmoFX+c7WM8v+Pt5TCAq59Z6Kle16bsAi57EZ1BffVOTbQO1LiNpsvGDFpwfaCIt4B5LqxqLaUhG5h1AWwHECuyYx6m5a3c2fcEMP9UGAh5LTH4wKZvyKBxeQEYlj7ytyxBNDMzKaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=vzNps3oh; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727944224; x=1728549024; i=markus.elfring@web.de;
	bh=ZX72Lmk43sBbEGkA1H10djPMZJfbXbYNCgT81G84xz8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=vzNps3ohhJYOJ+Msf7DEg8nRntDbiGV47RHn7toUXDacl0xdjUYP9PniI8nhXS4J
	 tVY5AkRoeO1/P84x/QLjsCPQhYVwwCyDRXncgwLAq/ZuW7e3FnCh/VesWniyEX22A
	 gAywsBBmoewCMAA8xXspsj9azLKnJEI4GahA2yy+YtnzNbmOTaCvHmUHaJvl8oFQg
	 mugvy35q+G+wvp9aD9EVxtuhMILjzxI0ev6NaJJwS1ziemwi+clBknFuHLlbMSH6A
	 BZZQD7dSZW9tjwTsUXunQxDi08N49j8/XEmiiqqPwPA7IWH//5MOb2oCH6gpHzMMi
	 qzhN1LBWQRbUqE3gRw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MiuOW-1sHhD13LxE-00eP0o; Thu, 03
 Oct 2024 10:30:23 +0200
Message-ID: <84e202eb-40f3-4132-b2d3-67069a2bba70@web.de>
Date: Thu, 3 Oct 2024 10:30:12 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Viresh Kumar <viresh.kumar@linaro.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] cpufreq: mvebu: Call of_node_put(np) only once in
 armada_xp_pmsu_cpufreq_init()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:l+YAhpusRDHD/2fn+ZfJHeq9qj5xFO4cNSCcfWkIMcO/apJrpO2
 88Oq4JuTk1VR68J105hFn1l/i3ZxQM471Ra+kw+vb92TTqRQmq/xre4d4VFipwXBEgK23CY
 ga27VBWHD0m+wI5uEBPLgc9tSDLwhJRhJ9DhKH/25hT4n1wYw7VUyhHj/BiIsQwjQCaz3Op
 9N66d6W63HJxcahnrSlbw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6HXuvQgU8Bc=;IZ5wj26uRkiTUXg7vzESX6OubE5
 0+pXKEfmMQ6E5gfU9C9VRCX29hq7Ape68GjT8dMmZM69DJEbjZBUySdLnqBnw0llJbbSFopmH
 bcG7gAJ8EjxGHDvYHkHRV8xQtx4cCp1DtO85dzM8TIWFU0Ox31TwdIljrxJes275cwpAwHsIk
 nOZhgSOevWCoS95j2YDpELre9YMAsevVHVBnl3aAVxGWFO+S0SxUKDD8dCMcblPUir9AHLfg2
 HRR3yhUazVlH5pPsOh9v49cKQrNiah2yZaFyWz9NGh0iU+X6yb/EO2yzrsJIQaxtJVgSTXI0X
 amfBbV1N6YRsbQrNit5D6yAvoPj0QILQ8eiJPPPkArQTf2bWxOZ5+bQ4pUCTKuaPQWqhNlRkG
 aBe9E1W9q4USVHNORPvBC8MEb6BwHa+ThYtq1/cglq02u9dWXJ6kFm2weUxJVdNUO+LGCAt/S
 IRpz+scAIAnxB7PqoXu6JK4MJnn2MQCuwOb8w1X3qonzg8d7Zb8e0RZ0mDsI1cqZBL+h+eS7N
 W5nLDdymbdki6wFpoMxifXeNVuzYJDfWdztB3fQidQd9HQAG6j+3W8ETTSu/WGV+beMajqBsa
 v81E0YYDqtUJjvuVQXXJ0nm+vCBM4qcSBuUfJ1CiWKcduQ0xw0qjUBRai7YSTPPgsZiSpScUp
 /HqnJVSAja23fUxqjOXJirLnA7SWZw+WmqWWNcwo49g7G3VjLa1Zp7tRGDr5lhfNBMrcxRMbU
 k3o9A8DZ02i5SO9h2YPcsbwBNR0Zc1rrccocYWNnlZzB/qN0Aa0Ndzg6SHPez+hGT/tFXBtqC
 tpvWUQHRLj7kYrAGDOEEK3Ew==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 3 Oct 2024 10:18:39 +0200

An of_node_put(np) call was immediately used after a return value check
for an of_address_to_resource() call in this function implementation.
Thus call such a function only once instead directly before the check.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/cpufreq/mvebu-cpufreq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/cpufreq/mvebu-cpufreq.c b/drivers/cpufreq/mvebu-cpufr=
eq.c
index 7f3cfe668f30..55ba7ad72c36 100644
=2D-- a/drivers/cpufreq/mvebu-cpufreq.c
+++ b/drivers/cpufreq/mvebu-cpufreq.c
@@ -42,14 +42,12 @@ static int __init armada_xp_pmsu_cpufreq_init(void)
 		return 0;

 	ret =3D of_address_to_resource(np, 1, &res);
+	of_node_put(np);
 	if (ret) {
 		pr_warn(FW_WARN "not enabling cpufreq, deprecated armada-xp-cpu-clock b=
inding\n");
-		of_node_put(np);
 		return 0;
 	}

-	of_node_put(np);
-
 	/*
 	 * For each CPU, this loop registers the operating points
 	 * supported (which are the nominal CPU frequency and half of
=2D-
2.46.1


