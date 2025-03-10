Return-Path: <linux-pm+bounces-23747-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED6DA58ED9
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 10:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22F8A3AAF9B
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 09:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEBE2253EE;
	Mon, 10 Mar 2025 09:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bxznMqa9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05C12248AB
	for <linux-pm@vger.kernel.org>; Mon, 10 Mar 2025 09:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741597351; cv=none; b=Ld8lwa5QlRV+MqVT3mlILGZk2rm4HP+AAOrDUPPCE1FH/wejyQeq4JjVDN8KaGZUVOEFXDVtXpQ+rwbqcpJsxWp9UZknXkRPKrUFl+KIqeOH82lMsOyffLhf77ErCMB33eM4o7t4+orywkbviWxqUuB9S8mRs4uPFQDiiN4aLDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741597351; c=relaxed/simple;
	bh=LjNeeGPZTSfwAfwVgmY6/aONFof+BNi8pWf8VZUD+9U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=Tyw4lTOC7I9NJTERoESMITS48htgmf2QeGPiPJSyteNl2DcQAM/DYTILxQL/i13w9XXSzPBPxNBRomdgN6Dl37LPSbYBXZCQQshyc8iu5G3vMZEl0t8Lt7b2KVli/HdpW97WpmoGbHlQRyxUBk6iB7orW/qIv+VDh6fr5Y1DqJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=bxznMqa9; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250310090221euoutp01025310e44ce927695dd66b96a962ce2b~rZY4OQuau0780207802euoutp01-
	for <linux-pm@vger.kernel.org>; Mon, 10 Mar 2025 09:02:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250310090221euoutp01025310e44ce927695dd66b96a962ce2b~rZY4OQuau0780207802euoutp01-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741597341;
	bh=GvH+KGxOLMWPvCT3kvkzzW6sq/iRIHCpZUQmHgtdxxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bxznMqa9nXhUI8+SFusigApWXFGROHO2Annprj0ShgQ+lBhu4giEVznN92Kp1GHWV
	 zDrPjQueKr5mf5fPi8xWBjUxen/rs5AffFvUnEVcyrd//DgH/wtNXby8J0yRwDrqaU
	 j43MKqpsEsHm/RrFTql1ESjDKI+Cb0bFuoXmzhes=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250310090221eucas1p18c5a64e40afb46abab95016c08a70fa2~rZY36jzSy2333723337eucas1p10;
	Mon, 10 Mar 2025 09:02:21 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 19.86.20409.D9AAEC76; Mon, 10
	Mar 2025 09:02:21 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250310090220eucas1p1bcb94d4d6c7145fa12a85305cb73068c~rZY3g6_8w2339523395eucas1p1v;
	Mon, 10 Mar 2025 09:02:20 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250310090220eusmtrp1ad878aee0609448e3166f1fd98b0d986~rZY3gKuI41041010410eusmtrp1D;
	Mon, 10 Mar 2025 09:02:20 +0000 (GMT)
X-AuditID: cbfec7f4-c0df970000004fb9-d7-67ceaa9d9371
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id BE.0F.19654.C9AAEC76; Mon, 10
	Mar 2025 09:02:20 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250310090220eusmtip26340f4f58568cd1b70452f8d5f384cac~rZY2rD9Xf2911429114eusmtip2G;
	Mon, 10 Mar 2025 09:02:20 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com,
	guoren@kernel.org, wefu@redhat.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	jszhang@kernel.org, ulf.hansson@linaro.org, m.szyprowski@samsung.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Michal
	Wilczynski <m.wilczynski@samsung.com>
Subject: [PATCH v7 5/5] riscv: Enable PM_GENERIC_DOMAINS for T-Head SoCs
Date: Mon, 10 Mar 2025 10:02:11 +0100
Message-Id: <20250310090211.286549-6-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310090211.286549-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCKsWRmVeSWpSXmKPExsWy7djP87pzV51LN/hyWsji2Z2vrBZbf89i
	t1iz9xyTxfwj51gt7l3awmTxYm8ji0XzsfVsFi9n3WOzuLxrDpvF594jjBbbPrewWaw9cpfd
	Yv3X+UwWLy/3MFu0zeK3+L9nB7vF8bXhFi37p7A4CHm8efmSxeNwxxd2j3snprF6bFrVyeZx
	59oeNo/NS+o9WtYeY/J4v+8qm0ffllWMHpear7N7fN4kF8AdxWWTkpqTWZZapG+XwJUxe+0Z
	poIpnBU9uy+wNTCeZu9i5OSQEDCRuHH3N3MXIxeHkMAKRonns+YyQjhfGCUOX9kD5XxmlPjw
	bDEbTEvn1C1QLcsZJX6f+scK4bxhlLjV+JEJpIpNwEjiwfL5YAkRgX4mib4j/8EcZoGVjBL3
	L5xlBqkSFvCQeN3xFuwUFgFVid4ZT1lAbF4BO4meGddZIfbJS+w/CFHPKWAv8WLjJkaIGkGJ
	kzOfgNUzA9U0b53NDFG/mVNi6tsACNtFYnHPGqi4sMSr41ug3paROD25hwXCzpd4sPUTVE2N
	xM6e41C2tcSdc7+AfuYAmq8psX6XPkTYUeLMnq1gYQkBPokbbwUhLuCTmLRtOjNEmFeio00I
	olpNYmpPL9zScyu2MUHYHhKfj79hnsCoOAvJL7OQ/DILYe8CRuZVjOKppcW56anFRnmp5XrF
	ibnFpXnpesn5uZsYgQnx9L/jX3YwLn/1Ue8QIxMH4yFGCQ5mJRFete2n0oV4UxIrq1KL8uOL
	SnNSiw8xSnOwKInzLtrfmi4kkJ5YkpqdmlqQWgSTZeLglGpg2v5w561A60+cJZxhmRvXet+a
	Nq3E4smpMK5C1xeGdvOvclXJ6HwqNP9/N+aozpxfltde5F9ny+xlrewWkPvRHalQzZoXvMlK
	KY3hVM/KcI0NC56du8+g9Zz5UQ/nb/ufqQLai4Il10rqbjwrXPwls/fVumNqbE62J5O4Jk0p
	Md4t/PAgw8LoXWovXBf0TGhRjqjfrOCgPXVeMMOEJTt40nfmGE4oYL9T/M0qJfTXobPtjALL
	btp8FGg1UH+6K9k5QzZwj7fc9XVnXFLkpXVUIz/dkKltvrDyj6X0B62Q41PKOt0ffamZv9f0
	2eKn6owTbkr+fLvs8J1f2tU3lxn/bmvbvcd7tXqBMi+fddJ2JZbijERDLeai4kQA9VAKKPcD
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xe7pzVp1LN1hzwcTi2Z2vrBZbf89i
	t1iz9xyTxfwj51gt7l3awmTxYm8ji0XzsfVsFi9n3WOzuLxrDpvF594jjBbbPrewWaw9cpfd
	Yv3X+UwWLy/3MFu0zeK3+L9nB7vF8bXhFi37p7A4CHm8efmSxeNwxxd2j3snprF6bFrVyeZx
	59oeNo/NS+o9WtYeY/J4v+8qm0ffllWMHpear7N7fN4kF8AdpWdTlF9akqqQkV9cYqsUbWhh
	pGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJcxe+0ZpoIpnBU9uy+wNTCeZu9i5OSQ
	EDCR6Jy6hbmLkYtDSGApo8SFH81sEAkZiWvdL1kgbGGJP9e62CCKXjFKtD6dywySYBMwkniw
	fD4rSEJEYCGTxNUpG8BGMQusZZQ4fPUS2A5hAQ+J1x1vwWwWAVWJ3hlPwcbyCthJ9My4zgqx
	Ql5i/8GzYFM5BewlXmzcxAhiCwHV7Oh+xwpRLyhxcuYTsF5moPrmrbOZJzAKzEKSmoUktYCR
	aRWjSGppcW56brGRXnFibnFpXrpecn7uJkZg9G479nPLDsaVrz7qHWJk4mA8xCjBwawkwqu2
	/VS6EG9KYmVValF+fFFpTmrxIUZToLsnMkuJJucD00deSbyhmYGpoYmZpYGppZmxkjgv25Xz
	aUIC6YklqdmpqQWpRTB9TBycUg1Mc0MOZN47eZhTI9XTlX3WN0Hn6Lnd7ycL70u+FPf9LEdN
	EcsJLomPju+OJDt+mnaq7WN5gFBrbfDd5cHivAYSoRtcHLWb/jDJXmf/leJlPEeWY5dhse0U
	91zte0JRe0L913gIHLrnyrneTEexxHXjSc0KrWupP4MK524W/mGapOjv+dBWzN7KRN5+moQy
	t3LzNr7ELJaVbPeY9+2ZuqG54N0DmaWZ+78zHJp8uVlwNtf+j0IG388dvP35j5rylbyrjhzb
	H664/CXnt3NFs9Vf/uVzN3HOLW6bMjHq0dtzO6sjKnw4fbJ95DZO50z2v3n7y/adD+5aPJMR
	k4j4ZMqn9Lg/9GHNwelKL/zr3bmVWIozEg21mIuKEwF33gf7ZwMAAA==
X-CMS-MailID: 20250310090220eucas1p1bcb94d4d6c7145fa12a85305cb73068c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250310090220eucas1p1bcb94d4d6c7145fa12a85305cb73068c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250310090220eucas1p1bcb94d4d6c7145fa12a85305cb73068c
References: <20250310090211.286549-1-m.wilczynski@samsung.com>
	<CGME20250310090220eucas1p1bcb94d4d6c7145fa12a85305cb73068c@eucas1p1.samsung.com>

T-Head SoCs feature separate power domains (power islands) for major
components like the GPU, Audio, and NPU. To manage the power states of
these components effectively, the kernel requires generic power domain
support.

This commit enables `CONFIG_PM_GENERIC_DOMAINS` for T-Head SoCs,
allowing the power domain driver for these components to be compiled and
integrated. This ensures proper power management and energy efficiency
on T-Head platforms.

By selecting `PM_GENERIC_DOMAINS`, we provide the necessary framework
for the power domain drivers to function correctly on RISC-V
architecture with T-Head SoCs.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 arch/riscv/Kconfig.socs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 1916cf7ba450..83833ded8908 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -53,6 +53,7 @@ config ARCH_THEAD
 	bool "T-HEAD RISC-V SoCs"
 	depends on MMU && !XIP_KERNEL
 	select ERRATA_THEAD
+	select PM_GENERIC_DOMAINS if PM
 	help
 	  This enables support for the RISC-V based T-HEAD SoCs.
 
-- 
2.34.1


