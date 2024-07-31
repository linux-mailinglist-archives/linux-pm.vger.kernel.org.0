Return-Path: <linux-pm+bounces-11774-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAB794379A
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 23:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EE28284DF9
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 21:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D6B16C68D;
	Wed, 31 Jul 2024 21:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="P8FD6ldE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4484B16A949
	for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2024 21:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722460442; cv=none; b=MWELsvBI9EJN1IEXu8UxjPgOlwoRmAwqMWnEaCop9bxTNMeYtmFl31y1X7v8vAUzutUCxluauQqdA8X/9CxC8EPkON1he8UE1tBTKLHZYt+grvqXDjf8fQo9dBquIQqxFNeXIvSSwZLEriLAe15/sPLzlIh/7VyyoR5gODCLGiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722460442; c=relaxed/simple;
	bh=yJ9pA9hFNNSRT1aeBnb+lif2aTDAwA5wRBIoRVAls8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=ujx9AWeoTU9KWSed+Zl3+kaNs7sVso0K9l9cO4Ys7LOgCvlizdtH8/E5SjFqJiGxU5U7iTybRX5LbjsFwTvPUGPFfPBY80gIjvSporA0cYpuFfLVVAj6oeFmI21u35Z/+EdGmquCOQIj2R2XPvwaC1LWYol5w5A+fMM67rWmQ7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=P8FD6ldE; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240731211358euoutp012829c1ce5a8a20e6e70151c9f2e85fea~naKR1Lxiz2556325563euoutp01S
	for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2024 21:13:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240731211358euoutp012829c1ce5a8a20e6e70151c9f2e85fea~naKR1Lxiz2556325563euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1722460438;
	bh=2pwRuB6aR+COZ5GILDtR6QzBmt48YqnOKY+gbzEXN6A=;
	h=From:To:Cc:Subject:Date:References:From;
	b=P8FD6ldE2hnBqlZao9fk2Sl+dt/oQ0ZM9wOwE/j4QS04USl3f+cXu9sluoT5jtt69
	 /j353JO9zn4wQ9vHP0Lc31pneAlzHHT2YQlJ+SMW/0JCnTGEAc+D/2g1c0A3cLJxgr
	 s87zFulc3BpDI0kmaG8K6jC3b6bS1A2Si/s7zloU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240731211357eucas1p2b49293f13d737d50049f292b5f1ba25c~naKRXKinN1089810898eucas1p2U;
	Wed, 31 Jul 2024 21:13:57 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 6B.C4.09624.519AAA66; Wed, 31
	Jul 2024 22:13:57 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240731211356eucas1p287adaf8a55c7c3e37c9ac8b36069b788~naKQUQCjT0996309963eucas1p2I;
	Wed, 31 Jul 2024 21:13:56 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240731211356eusmtrp10d5b1aee0cf22252e5f10bf3f395a4a1~naKQTk9vo0610906109eusmtrp1Q;
	Wed, 31 Jul 2024 21:13:56 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-36-66aaa9158e8b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id B2.99.08810.419AAA66; Wed, 31
	Jul 2024 22:13:56 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
	[106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240731211355eusmtip2d184d063d29a529418a12f6d6760b6ed~naKPZUOaV1705617056eusmtip2L;
	Wed, 31 Jul 2024 21:13:55 +0000 (GMT)
From: Mateusz Majewski <m.majewski2@samsung.com>
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Cc: Mateusz Majewski <m.majewski2@samsung.com>, Krzysztof Kozlowski
	<krzk@kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob
	Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, ALIM AKHTAR
	<alim.akhtar@samsung.com>, Sam Protsenko <semen.protsenko@linaro.org>, Anand
	Moon <linux.amoon@gmail.com>
Subject: [PATCH v2] MAINTAINERS: thermal: samsung: add myself as maintainer
 of the driver
Date: Wed, 31 Jul 2024 23:13:45 +0200
Message-ID: <20240731211346.59027-1-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNKsWRmVeSWpSXmKPExsWy7djPc7qiK1elGWxskbF4MG8bm8X3LdeZ
	LNbsPcdkMe+zrMX8I+dYLc6f38BusenxNVaLy7vmsFl87j3CaDHj/D4mi3Ubb7FbLGxqYbeY
	eGwys8XcL1OZLf7v2cFu8eRhH5vF8759TA6CHmvmrWH02DnrLrvH4j0vmTw2repk87hzbQ+b
	x+Yl9R59W1YxenzeJBfAEcVlk5Kak1mWWqRvl8CVseX+ZsaCyxwVO95mNDDOZe9i5OCQEDCR
	uLrFs4uRi0NIYAWjxKcFjYxdjJxAzhdGifU77SASnxklrv7pYwVJgDSsf/OPCaJoOaPE1/nq
	EEWtTBJXnx4CS7AJGEg8eLOMHSQhInCVSeLZ009gDrPAE2aJzU+msYFUCQtES6x4+JIFxGYR
	UJXoX7gerJtXwEZi99zFLBDr5CV69/dBxQUlTs58AhZnBoo3b53NDDJUQuALh8TXaffYIRpc
	JJZO7GGCsIUlXh3fAhWXkTg9uQdqaL7EjM3vWSABUCFx96AXhGkt8fEMM4jJLKApsX6XPkTU
	UeLevkgIk0/ixltBiP18EpO2TWeGCPNKdLQJQUxWlTi+ZxIzhC0t8aTlNtQlHhJd76axQEIt
	VuLEj5VsExgVZiH5ahaSr2YhnLCAkXkVo3hqaXFuemqxYV5quV5xYm5xaV66XnJ+7iZGYHo7
	/e/4px2Mc1991DvEyMTBeIhRgoNZSYRX6OTKNCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8qiny
	qUIC6YklqdmpqQWpRTBZJg5OqQYmobV867Z6n1GcwmDU8NtWn+vP3IkKt+cJRlxbq3t0t4vO
	Ksa9D80cU87uPRbMp75U7vnWJmH5qw9SZSM2b5vWrirhqnb8zL3N33Nkny9TKvUziru+fEeE
	XiOr6na5hzzSYe2m3Mkucww7fO+lr3qexuohOXX18vtr5Hj6g9hNDl+4k3Q7OXDB1J9ba/sv
	NCXdk1qxZqnYZQ61SmWbWhOHwz5RW7NrPtt1CrBmLjzR0bNfKmL2X+vze99onBGoivHKv2V4
	2CGxpqMi0OpB+t/PhiwLg/9snCi+Ksas6NShpMfl59+IH1npKMZUUfOYUzz4/zzek8G/Fy6S
	YpqwUNrGQ7O0afdd5tVT56+uWSipxFKckWioxVxUnAgASoSbEN4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsVy+t/xe7oiK1elGSzbJ2LxYN42NovvW64z
	WazZe47JYt5nWYv5R86xWpw/v4HdYtPja6wWl3fNYbP43HuE0WLG+X1MFus23mK3WNjUwm4x
	8dhkZou5X6YyW/zfs4Pd4snDPjaL5337mBwEPdbMW8PosXPWXXaPxXteMnlsWtXJ5nHn2h42
	j81L6j36tqxi9Pi8SS6AI0rPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/O
	JiU1J7MstUjfLkEvY8v9zYwFlzkqdrzNaGCcy97FyMkhIWAisf7NP6YuRi4OIYGljBJHOqey
	QCSkJQ5/mQJVJCzx51oXG0RRM5PEt8b9YEVsAgYSD94sAysSEbjMJLFztgpIEbPAO2aJrp4G
	sISwQKTErqlXGEFsFgFVif6F65lAbF4BG4ndcxdDbZOX6N3fBxUXlDg58wlYnBko3rx1NvME
	Rr5ZSFKzkKQWMDKtYhRJLS3OTc8tNtQrTswtLs1L10vOz93ECIyxbcd+bt7BOO/VR71DjEwc
	jIcYJTiYlUR4hU6uTBPiTUmsrEotyo8vKs1JLT7EaAp030RmKdHkfGCU55XEG5oZmBqamFka
	mFqaGSuJ83oWdCQKCaQnlqRmp6YWpBbB9DFxcEo1ME17ut5ZjU1R9MrNCcsZ+TnWl+c6Vc5Z
	ynL8g+7C6Ryy06qO8wQ/mb+94y9X/rbHvAtLlPbdTPOsdNTTiT7w4OvxAz9L/8/2zq+87X9l
	wncVUWMJGZv9ooKrXVle27dVO7xslJuzRPT2cmkmv/dxzBq+N73OKwbYxzOKXRPmsIp6pO4z
	U3CCQqjHQRHni8vNPAUb5zj76PQ8y1jw9ZnZma9eQXdifLavMMt8I6UXfjx7a3r54Q4j9RbJ
	4q4Hb69UVewqEWQTtjthqW3gYLhO6i2rQs5v+yndr6LqVRsjN9xiFnFdEK0w8cqc1Yv14+1n
	HRR/d+iV/FMuNibb5XJWh762ci9TXJhrfeWBIeN2JZbijERDLeai4kQAnkwNwjoDAAA=
X-CMS-MailID: 20240731211356eucas1p287adaf8a55c7c3e37c9ac8b36069b788
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240731211356eucas1p287adaf8a55c7c3e37c9ac8b36069b788
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240731211356eucas1p287adaf8a55c7c3e37c9ac8b36069b788
References: <CGME20240731211356eucas1p287adaf8a55c7c3e37c9ac8b36069b788@eucas1p2.samsung.com>

I am familiar with the code of this driver, having contributed to it
before. I also have access to most of the supported SoCs for testing. I
am going to have more time to help with this code, so I would love to do
so slightly more formally.

This has been discussed previously in
https://lore.kernel.org/lkml/e73e1a14-dfa0-4a36-bc6e-5d6421553788@kernel.org
where Krzysztof Kozlowski (as one of the existing maintainers of this
driver) has reacted positively to the idea of this.

Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
v1 -> v2: slightly more detailed rationale.

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 12b870712da4..9133257a8509 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20247,6 +20247,7 @@ F:	drivers/net/ethernet/samsung/sxgbe/
 SAMSUNG THERMAL DRIVER
 M:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
 M:	Krzysztof Kozlowski <krzk@kernel.org>
+M:	Mateusz Majewski <m.majewski2@samsung.com>
 L:	linux-pm@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org
 S:	Maintained
-- 
2.45.1


