Return-Path: <linux-pm+bounces-15322-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1A8994770
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 13:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A3E8287A9E
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 11:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2571DC759;
	Tue,  8 Oct 2024 11:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="CUV9JQ6T"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m92248.xmail.ntesmail.com (mail-m92248.xmail.ntesmail.com [103.126.92.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3970D1D54D3;
	Tue,  8 Oct 2024 11:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.126.92.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728387716; cv=none; b=VQbUy4R8lySkjkhKpEtzJJHJxbL1kyAh1j0+v6HX5pytTMO5z7IVskH9sKwMmtuQfO/4+6tIl4MxTstn7ASr+FCsJMxlTjDN0CRnx+PjxNl3Ofj57UgwuGNYz1+GFwZaWIYR6BvtJLMO6/pU40QA7p0Ji/XkV7J+SlKWO3YwooQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728387716; c=relaxed/simple;
	bh=wFKvfRRQoBJZqY0ukQccdKGlX0xobNOL4S/eBEm4eb0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=bV+e6cnbdaO4eUGjaAA0KzvWG1HzbGoupBO7XVvXz2NGnx9iUQU222seNfsIFz7ZpAoDfRYTKqluAs8tvQ2VP8Vq2OY8LilsjhZEj6W1xg9tnnvyQ6i8CX+aFaI/fhCxVMVKANXOmFysRT3XTIwr8CzeHTRO2P/bcvkpaN6G64E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=CUV9JQ6T; arc=none smtp.client-ip=103.126.92.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=CUV9JQ6TT2aQrm0e8FD1ZsjGt5wb9K9sADQwmJlXb7ulBtlgwtlT3cghiWc4PhQ5mIHuB1TBC0zBEtj18UGFnduRctYHYxlSd2q9KnHggh/bAKvKW0bTzjm6/6KY9TTdz5PLjDz/I7IXTaGVQKYu13qnH+HqRJ5crGaLDkBgsSM=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=sDFPfh0ntBvyHdRIGFyGIID/VxPyFOd/6skrF31OfxY=;
	h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 2C382520783;
	Tue,  8 Oct 2024 14:16:40 +0800 (CST)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Rob Herring <robh+dt@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	YiFeng Zhao <zyf@rock-chips.com>,
	Liang Chen <cl@rock-chips.com>,
	linux-scsi@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 4/5] soc: rockchip: power-domain: Add GENPD_FLAG_RPM_ALWAYS_ON support
Date: Tue,  8 Oct 2024 14:15:29 +0800
Message-Id: <1728368130-37213-5-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1728368130-37213-1-git-send-email-shawn.lin@rock-chips.com>
References: <1728368130-37213-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh5MHVZKGEoeS0lPTE0ZShlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a926ac5cda303afkunm2c382520783
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PDI6Kzo5LTItDBYrGSMhN00u
	CxMaCwpVSlVKTElDSE1DSUtKQkNMVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUhLQ003Bg++
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

If low level driver claims to keep its own power domain always on,
let pd driver respect the flag of GENPD_FLAG_RPM_ALWAYS_ON.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v3: None
Changes in v2: None

 drivers/pmdomain/rockchip/pm-domains.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index cb0f938..b2bb458 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -621,6 +621,9 @@ static int rockchip_pd_power_off(struct generic_pm_domain *domain)
 {
 	struct rockchip_pm_domain *pd = to_rockchip_pd(domain);
 
+	if (pd->genpd.flags & GENPD_FLAG_RPM_ALWAYS_ON)
+		return 0;
+
 	return rockchip_pd_power(pd, false);
 }
 
-- 
2.7.4


