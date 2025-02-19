Return-Path: <linux-pm+bounces-22444-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4785DA3C185
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 15:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCDFE189ED62
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 14:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C06920C032;
	Wed, 19 Feb 2025 14:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hA43bPnS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD041FFC48
	for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2025 14:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739973798; cv=none; b=aQ8HTfc0l/dpkO94BzGTvbemtv013D85wV9hzxqGOIJosdM+LKwO1wRXsglHiwSjImCr5nw5ssktufPZxTuG0YqjlbEtkK+TknFNDyoXqloJeTDilzDgt4uN/CNVLWkYWZZLW7kHt3mTnc5pxXJgdbTg0F94eYbG4TTkgSbA7pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739973798; c=relaxed/simple;
	bh=fb54nvaJtb/ZPGsqSbw/2oh4n8cpPZXTtW15PG7l6Gk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=KTCNY0LFMJvy82FYbL7BnCMThmeOhkgj6aEZ3to1bOb+EeNWEvdVQURo7JYgpTjazXo7UMUmhvdiurX3qKnSwTVrrxqVXXFh/pa8h5ahF6XLMo4+W7JhUvO3myM+m2nGBDDFBAhmFd5St9RiE3U6GjdILgqqbFR56MQXXmcc9Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=hA43bPnS; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250219140312euoutp0210c369ff20cd8a73a510f65778ceda47~loPIhw66M0168201682euoutp02M
	for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2025 14:03:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250219140312euoutp0210c369ff20cd8a73a510f65778ceda47~loPIhw66M0168201682euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739973792;
	bh=cK8knrHIi4/lY6BD8KZcVTKMN8gTk1ruHsI3tUZU9iI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hA43bPnSNbNzT14y4id55JwVqBEtFFQUKexcmA2LuBwbAQf5LNq2jRWdffviZPtux
	 YwqHGA6zc/d7QUCScs6OuIwLO9+45ellh74a4W+OpjKIfDw8tkeSDqxi0UcyuuCubC
	 MAozI6OA8OckG5EJ7FckOWlwNL1J1V2tYAfzzZss=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250219140312eucas1p17867cca41ab6e0b80e747aad5dc71e44~loPIE2ptw1247112471eucas1p1W;
	Wed, 19 Feb 2025 14:03:12 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id DF.83.20821.0A4E5B76; Wed, 19
	Feb 2025 14:03:12 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250219140311eucas1p24ef4a7a95abdb527c2bd305f3ed51674~loPHmt5pF2656126561eucas1p2_;
	Wed, 19 Feb 2025 14:03:11 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250219140311eusmtrp2d431462d3b4ef21ff91db998b2f784d2~loPHl0XEP2432224322eusmtrp2W;
	Wed, 19 Feb 2025 14:03:11 +0000 (GMT)
X-AuditID: cbfec7f2-b11c470000005155-72-67b5e4a0ac7b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 25.62.19654.F94E5B76; Wed, 19
	Feb 2025 14:03:11 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250219140310eusmtip250965c3cbba74aa97a083b540660e2c8~loPGWiOI00642206422eusmtip2Q;
	Wed, 19 Feb 2025 14:03:10 +0000 (GMT)
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
Subject: [PATCH v5 16/21] drm/imagination: Add support for IMG BXM-4-64 GPU
Date: Wed, 19 Feb 2025 15:02:34 +0100
Message-Id: <20250219140239.1378758-17-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219140239.1378758-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfVBUZRTG57337r2XHRcvqxPvkFMKYSHJRzHN28g4OJPNLYYZ+6PILGSF
	26LxNbssllkuwiIICCKbsysEAgqsEUHsxqKwIxALmhSsrF8sH4Z8bm4rkkGIsXux/O85z/md
	9zln5qVx8U+kD70/OY2TJUsSfUkhYehe+HVrxbheGvLo+lrUc6MSQ/p/tBT6rq0PQ+VdfQI0
	PNCMoevzDhJ9f+83Ck21ZRDIWltGoczuBhJNa4dJ5MwfFiBLaymJ5gq6ADLMZZGovstGoYb5
	cgyddeoJVN3SClB27nkB6r+yE9mGewg0bcnHUbZ2LXpyqYVCy9ZGAp25b6JQs/2kAJnro1GW
	qYSIeIF13FRRrH16mmA7cx5SbNtfFQRr1NooNt/4C2CbdLkkO2S9RLLf9r7HjuSZMfbH6iNs
	Vn03xhY+DmEd7YMke6JZB9iBzBvULvFHwvB4LnF/OicL3h4rTKhbGiVTTws/v3vVAJTARh8H
	HjRkwqDzgp04DoS0mKkF0Pp7nYAvHgJ4tn12tZgD8O5gGfl05JTSivONGgB7bxcBvrAD2Kmq
	Ay6KZF6DozXl7vH1jIqAqp8z3BTOTAJoGC91v7WOiYS36tS4SxOMP7RYLZRLi5gIWKoeI/i8
	F6Hp8rUVhqY9Vvz2fh8e8YK9mnE3gq8gmfoz7pUgUy+ExZUanJ99CyqvDQBer4Mz5maK1xvg
	E2M5xusUOKp/sMofhsZ886reBof6FklXLs4EwIbWYN7eAatGZoHLhownvPmHF7+CJyw2nMZ5
	WwRzssU8vRmq8wv+C+2rNayGsvAb9TlBEdikfeYY7TPHaP/PrQC4DnhzCnmSlJOHJnMHg+SS
	JLkiWRoUl5LUBFb+9tVl84MWUDbjDOoAGA06AKRx3/Wi7CPNUrEoXvLFIU6WslemSOTkHeB5
	mvD1FlWaVFIxI5WkcZ9xXCone9rFaA8fJcalhQw7unLo1JLI21OVprQ1Jf7WsLE3HmN34ufv
	TNzbHc8FTG4e2fmmRddf8/GG57LVHROzasfBzoWufZjl/L6M2DivPSPWT3t07+vxPe+E523R
	NH6ibfkbm8kdHNNKAtcUeXMHgk/8kLrRPn+gYO/FjTHvbr8SqfA5mmgd8Uy/T+nCD33wUvjb
	lvEw3I+tenTSHjKlVSvTF6N205OhF6PEHxp92saa1IvRC43UkvVyXuCtpcLYw2FR0V/7RXgU
	054xpk1fkhmFpZYmx7Tq9a+ocza1JmZiedsujkGvOhW2HYF/HotLqHEaA4aOTVV11m3112QU
	mY/O+IVFvZx84ZVqhS8hT5CEbsFlcsm/syouk0oEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsVy+t/xe7rzn2xNN9h/QdfixPVFTBZbf89i
	t1iz9xyTxfwj51gt7l3awmRx5et7Not1Ty+wW7zY28hicW3FXHaL5mPr2SxezrrHZvGx5x6r
	xeVdc9gsPvceYbTY9rmFzWLtkbvsFuu/zmeyWPhxK4vFkh27GC3aOpexWlw85Wpx994JFouX
	l3uYLdpm8Vv837OD3eLftY0sFrPf7We32PJmIqvF8bXhFi37p7A4yHm8v9HK7vHm5UsWj8Md
	X9g99n5bwOKxc9Zddo+enWcYPTat6mTzuHNtD5vHvJOBHve7jzN5bF5S79Gy9hiTR/9fA4/3
	+66yefRtWcXocan5OnuAUJSeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6d
	TUpqTmZZapG+XYJexso/D9gKpnNVPDq9jbGB8S5HFyMnh4SAicTkhmvMXYxcHEICSxkl/r9o
	YIJIyEhc637JAmELS/y51sUGUfSKUeLghZtsIAk2ASOJB8vns4LYIgKLWST27qsEKWIWeMso
	cX3mRrBuYQFviZsrpzKD2CwCqhKXr11mB7F5BRwk5kx9CLVBXmL/wbNANRwcnEDxfRelQMJC
	AvYS5/rus0KUC0qcnPkErJwZqLx562zmCYwCs5CkZiFJLWBkWsUoklpanJueW2ykV5yYW1ya
	l66XnJ+7iRGYXrYd+7llB+PKVx/1DjEycTAeYpTgYFYS4W2r35IuxJuSWFmVWpQfX1Sak1p8
	iNEU6OyJzFKiyfnABJdXEm9oZmBqaGJmaWBqaWasJM7LduV8mpBAemJJanZqakFqEUwfEwen
	VANTUufs24/Z/I3/fgiyT7bglj8t/cOJWyHAbrNEekpBQqpt7U/umlk/j0gcMN5idenO2VVl
	+VpTpZIKT1dkv8p1Mv1x7vMWk9D+0qSIBK0FPZvCz+nd2yHwhSPaVrBta0h3xY6MhMAXjbo6
	d+ZEMYTHeqa1H+zRMc1nrVNnirwuVpSeMGPPSc7IhekO/YnVrxPW3Hm+v0x566YVFw6Xb84I
	UyhVvZbFqCkkXJxhfiGjcLpsRSKL3KH5p1/Pjfk+zdhv/+WoKY6F2iFy/AknHBUe3uivzH3M
	pte48afTf28JA8d14tOTjIITZc/57bKYsMKx9P3X60J/tuzPzDbh8Tv8km3Rfelvm786Z74+
	pMRSnJFoqMVcVJwIAEdJFBy4AwAA
X-CMS-MailID: 20250219140311eucas1p24ef4a7a95abdb527c2bd305f3ed51674
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250219140311eucas1p24ef4a7a95abdb527c2bd305f3ed51674
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250219140311eucas1p24ef4a7a95abdb527c2bd305f3ed51674
References: <20250219140239.1378758-1-m.wilczynski@samsung.com>
	<CGME20250219140311eucas1p24ef4a7a95abdb527c2bd305f3ed51674@eucas1p2.samsung.com>

The IMG BXM-4-64 GPU is integrated into the T-Head TH1520 SoC. This
commit adds the compatible string "img,img-bxm" to the device tree match
table in the drm/imagination driver, enabling support for this GPU.

By including this GPU in the compatible devices list, the driver can
initialize and manage the BXM-4-64 GPU on the TH1520 SoC, providing
graphics acceleration capabilities upstream.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/gpu/drm/imagination/pvr_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/imagination/pvr_drv.c
index 0639502137b4..2776de095439 100644
--- a/drivers/gpu/drm/imagination/pvr_drv.c
+++ b/drivers/gpu/drm/imagination/pvr_drv.c
@@ -1474,6 +1474,7 @@ static void pvr_remove(struct platform_device *plat_dev)
 
 static const struct of_device_id dt_match[] = {
 	{ .compatible = "img,img-axe", .data = NULL },
+	{ .compatible = "img,img-bxm", .data = NULL },
 	{}
 };
 MODULE_DEVICE_TABLE(of, dt_match);
@@ -1498,3 +1499,4 @@ MODULE_DESCRIPTION(PVR_DRIVER_DESC);
 MODULE_LICENSE("Dual MIT/GPL");
 MODULE_IMPORT_NS("DMA_BUF");
 MODULE_FIRMWARE("powervr/rogue_33.15.11.3_v1.fw");
+MODULE_FIRMWARE("powervr/rogue_36.52.104.182_v1.fw");
-- 
2.34.1


