Return-Path: <linux-pm+bounces-20712-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD12A17175
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 18:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 041DD18877B3
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 17:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3102D1F130F;
	Mon, 20 Jan 2025 17:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XIFd2d8m"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784191F03F7
	for <linux-pm@vger.kernel.org>; Mon, 20 Jan 2025 17:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737393700; cv=none; b=K2ffY3w3vkoCuCq3c24PjqylXsr/a34XK1kDbPuv06IXglgalk6UjuFGqN1TrUQFUfHjwEEprAgiwlYqOE+wlgtsfVyPgqbjw9NYcyVxJs63Fiia5xopKwi6pBLHJBj/hEfTeIOXVIJrBAzQz6PduKR6DUka8rqBFdUJbpgBDXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737393700; c=relaxed/simple;
	bh=Mgw4bBJdAGa3v7STcx9GpX7OnRyJLehbKO88byiVqjw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=qUPUq3vORhAm1Lg9QAktYgQ/ir+KH6ELv/IMnIPusS+U9lFDpRQG8SbIzhHF4kG+MRKAjddKbIdEltnftGXV78uGF8gbIb5y99euqOCFeHowjWxDRA+gZGsTqE3y7H3BXmhQTE21og4KtJ8yLvT39vI5xccC0nV+R7WRIeOkywI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=XIFd2d8m; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250120172134euoutp015df805dcb2e396bc9b57226eb69e3591~cdlwx3-RF2441324413euoutp01V
	for <linux-pm@vger.kernel.org>; Mon, 20 Jan 2025 17:21:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250120172134euoutp015df805dcb2e396bc9b57226eb69e3591~cdlwx3-RF2441324413euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1737393694;
	bh=WG/uP8c0E/qBnaDsc94oWBf9bljfXxUEOs6YtwQ80qI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XIFd2d8m9DlZMk4283MH9/5rg/rbKrk0af55evcrViZfogwNAar5LQxXANabgqHy6
	 s8uUQuXtPIIcsGwizT76KTQ/ST+O9r5UpfggNzH45BLMUGIz0djx+JhCRuhdGTX80y
	 oBge1osQodT+jEBAnwmRQ3SVIxgtsqMROrCmTupM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250120172133eucas1p195e9c8f57598def3f90f7a85a3b24e64~cdlvxAEjV0503405034eucas1p1r;
	Mon, 20 Jan 2025 17:21:33 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 1F.7B.20821.D168E876; Mon, 20
	Jan 2025 17:21:33 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250120172133eucas1p232c85cb934148427e52dd939c974a82b~cdlvYEWns1091210912eucas1p2u;
	Mon, 20 Jan 2025 17:21:33 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250120172133eusmtrp26773f43858ad3e4e5c37e3b7e6735e3e~cdlvXVCDR0490804908eusmtrp21;
	Mon, 20 Jan 2025 17:21:33 +0000 (GMT)
X-AuditID: cbfec7f2-b11c470000005155-16-678e861dbac4
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 53.A5.19654.C168E876; Mon, 20
	Jan 2025 17:21:32 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250120172131eusmtip1415b15ebdca6610b67aa338c1947e3cc~cdluDy3Sl0708407084eusmtip1q;
	Mon, 20 Jan 2025 17:21:31 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com, guoren@kernel.org,
	wefu@redhat.com, jassisinghbrar@gmail.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, frank.binns@imgtec.com,
	matt.coster@imgtec.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	ulf.hansson@linaro.org, jszhang@kernel.org, p.zabel@pengutronix.de,
	m.szyprowski@samsung.com
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org, Michal Wilczynski
	<m.wilczynski@samsung.com>
Subject: [RFC v3 10/18] dt-bindings: gpu: Add 'resets' property for GPU
 initialization
Date: Mon, 20 Jan 2025 18:21:03 +0100
Message-Id: <20250120172111.3492708-11-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250120172111.3492708-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfVBUVRjGPffevffCtHhdZDghSe6MzFSGrEMzZ8QazBpvjWVWUww05ebe
	FhAW3AXSBk1avnQXE0chl0/N4kORYD9YcNcdgXaRtR2CYKmAGLQAhw8BtaJht2Uvlv897/M+
	z/zeM3NoXGQmw+hkRSanVEhTxWQgYbL/7Xr+qYJT8mhPcRjqdl/EkPEfHYWuWF0Yqu5yCdBo
	nwFDPz2YI9HV33spNGnNJdBgXSWF1PYmEk3pRkk0rx0VoP72ChItFncBZFrMI1Fj1wiFmh5U
	Y+jCvJFAl8ztABWc+FaAfux5FY2MdhNoql+LowLdWuS1mCnkGWwmUPmsjUKG6RIBcjS+j/Js
	Z4m4jezcUD7FTk9NEWxn0X2KtT6sIdg23QjFattuAbal4QTJDg9aSLbq5j72N40DY/WXPmfz
	Gu0Y++VyNDt3fYBkTxkaANundlNviRICd8i41ORsTrn1pf2BSVd67ViGnTrc5RyhjoNm8iQI
	oCETA/O8XuwkCKRFTB2AlZcLCX64D6B6qB7wwyKA183nBI8q7qLS1UUtgIUzRgE/TAP4sKKV
	WEmRzDY4VlvtX6xn8gmY/32uv4IzEwCa7lT48cFMPLxqKcZXNMFshubOen9byMTB+mUd4HkR
	0HbjB38mwOf/OWCl+Mw6ePP8HX8e92XUxnJ8BQCZxkB4euZXii+/Ase+cK3qYHjXYVjV4dDb
	Vo3xOh2OGRdwXufANq1jVcfCYdeS71DaB3gGNrVv5e2d8OsZL7FiQyYIDs2s408IgmdMZThv
	C2FRgYhPR8Jz2uL/oK460yqUhV1NzdhpsEn32GN0jz1G9z+3BuANIJTLUqXJOZVEwX0apZKm
	qbIU8qgD6WktwPe5nR7HghlU3p2P6gAYDToApHHxemHIPa1cJJRJj3zGKdM/UmalcqoOsIEm
	xKHCi7Z8uYiRSzO5gxyXwSkfbTE6IOw4dnSpzNms0KLgiLMSy/b0yS0ySrswN1D/XrQl1tN+
	LVtzO+XIweQ3O/WasBe8hef7EqremPaUq0ufk0fVieYUbueHGvGaPQdynowPqS4LMuk3bBxw
	HFoOSEpHf/R8d6tH/sG9CLHQmDxe1B9zbcn29IJgNrxR1uJpUe22RTyxwz1RtTA5HBL79mZ5
	sLqmW3eZ+3iLu/CYYTL0dmt8ogoCwvXOmXcjc38ZvOHQ9F5Imdn3cnikbufrJQn0X4cSNS2S
	XRPHvhnf5VybE3Y4prS7JzPjNc+sPsWq3PvJz60V+2u/6j6aZx6XZce9aJE5Y9foS5JD0iS7
	JZumyvduS9wepacjxYQqSSp5FleqpP8C9l3HPEsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xbZRjG851zes4p2ngsRc8IAdPMxSzS0q6lX7VcjFtyYuKiLkrUzK1h
	x0KAdvaCYjR2gh2lFcHg5ooDZBsbhEuKBctYYZamsBtstLRuo5V4XQnKYDBcELAUTfbfk+f5
	Pe/7/vGSKL+Nk0oWa42sXqsuFeJJ2JX10UhmmqVWk3W053k4Fm5FYN+qg4CdnnEENvvGOTA6
	6UJgcHkeh92/XSfgHc8RDIbOnSRgpb8HhzFHFIcL9igHBs5/g8N7n/sA7L9XhcMuX4SAPcvN
	CPx2oQ+Dp93nAbRY2zjwxuU9MBIdw2AsYEehxfEY3LjgJuB6yInBxr+GCeiaq+fA0a4CWDXc
	gOWnM/M/fkYwc7EYxoxULxGM534Lxgw4IgRjH7gKmN4OK85Mhy7gTNOlV5mfbKMI893pT5iq
	Lj/CfLGWxcwPTeFMrasDMJOVYeIV/lsilV5nMrJPFekMxhzh2xIoFUmUUCSVKUWSXYr9z0nl
	QnGu6hBbWlzO6sW5B0VFndf9yGE/8YHvSoQwAydeA7gkTcnocPUxUAOSSD51BtCj/VfBVpBG
	h2wxbEsn0/+EavAtaBbQ3UdaE22cktIzZ5s5m1pAncJoz1DFJoRSfwI6fMKZaCdTb9CeGX9i
	KkY9TbtH2hM+j8qn29cc/23LoId/uIZuam7cX5nyEJuaT+XR01M2sMU/Tl868Wuii8b5yr5G
	tA5Qjocix0NRC0A6gIA1Gco0ZQapyKAuM5i0GlGhrqwXxB+m3//A5QbtswsiL0BI4AU0iQoF
	vJS7dg2fd0hd8SGr1x3Qm0pZgxfI43fXo6kphbr4x2mNByTZWXKJLFuZJVdm7xI+ycODE+/y
	KY3ayJaw7GFW/38PIbmpZkT1UsTf2rbjmcUA9sC43LV7cLsnx/1IddD3tWB49aAqIFqV8cKZ
	g01L+d23S74UPzFjGi8Y/GXvDGnDonXHybsqbvltc8HFk38EbhznfKXY+6yifod3cV9pttSa
	0+EY+3RE1wDNd3Zj6+IRU/OjxH17WoaiPt0wbWfXlXLLzQLRmZJbMmshq7hIfl9jzuCs5Dal
	bkysreqOCi7n1fUsJon3CWiUF6nav2T5+VjJrfQV7QTMefPFzp0vDBhfY2++UxE9xw3uadCW
	C9VKbW/xto3ge5EWhX5b3mSfCX3/9yFvrell4Snrx87Gv5Mz566dlYe3O2e5r+s/4rmmbLwU
	IWYoUkt2onqD+l/B6xEuuQMAAA==
X-CMS-MailID: 20250120172133eucas1p232c85cb934148427e52dd939c974a82b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250120172133eucas1p232c85cb934148427e52dd939c974a82b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250120172133eucas1p232c85cb934148427e52dd939c974a82b
References: <20250120172111.3492708-1-m.wilczynski@samsung.com>
	<CGME20250120172133eucas1p232c85cb934148427e52dd939c974a82b@eucas1p2.samsung.com>

Many RISC-V boards featuring Imagination Technologies GPUs require a
reset line to be de-asserted as part of the GPU power-up sequence. To
support this, add a 'resets' property (and corresponding 'reset-names')
to the GPU device tree bindings. This ensures the GPU can be properly
initialized on these platforms.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
index 256e252f8087..bb607d4b1e07 100644
--- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
+++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
@@ -37,6 +37,9 @@ properties:
   power-domains:
     maxItems: 1
 
+  resets:
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.34.1


