Return-Path: <linux-pm+bounces-40996-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D23D31151
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 13:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E160A3069232
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 12:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6758A1A8F97;
	Fri, 16 Jan 2026 12:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="RvakPG1S"
X-Original-To: linux-pm@vger.kernel.org
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F067E1A704B;
	Fri, 16 Jan 2026 12:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768566483; cv=none; b=vCOXPeUfSztf0PLrC+7gfwKUEiiy+06JmPaPipzDrf6qZbDN3VS3YW1cKxIJYKfCvMuvnmunVIONC+fwYbhH5TBsbSiXJSdHi0SLR2veEk6MM19NRRbYTkWtluFYppFFwGY/91+52LO8CsuAE0w9jpCjTe52xsK5aANoTfx40M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768566483; c=relaxed/simple;
	bh=31Dg6exoE+spJrdeoYTv5xJGLaB7oDZ0LxPNxr4UNik=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=Uapo2vm3CR6PK9L3gbkBW30KLCCNsby7NGFV+jqxJIIpNhN7B4IYayLIxkoYJ5UVj2NqRizzrFL2DLo71kNQMLV0FJuhoUk5YhBiTNo+0Cf9mdJT8lEl8ePAbjvP4Bg7dT6E2zzde/Enq6trKN2yAAB99YPGjDV5kAYjjp14zZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=RvakPG1S; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1768566470; bh=9JqLdOMZ6NZDy2yQcDqX1Cghjb6LFxT47x3f2odxpE8=;
	h=From:Date:Subject:To:Cc;
	b=RvakPG1SjKnDHGfxyvLRJ7LrB0UgJ6zSZXgsrGgEkerf+flfDv3wzXqT6vEgYV23t
	 gj2IOn4M3hwWpx/VoMhQx2j/y5PoiX+PNYQZ8bg9L3sZUFYQy7g7NR1OpQftCzYB83
	 Teqfyq+2itWQ2m5dmTHnUsdzworoiMwYGdhZt9AE=
Received: from junjungu-PC.localdomain ([223.166.246.160])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 6F003E91; Fri, 16 Jan 2026 20:27:48 +0800
X-QQ-mid: xmsmtpt1768566468tccz403jx
Message-ID: <tencent_E20B88FB4461F8F299301AE67009CF1E8708@qq.com>
X-QQ-XMAILINFO: NAuAIaytDrXpCJJ5wMPpp00qsHUhboUXzyZi+3PHYECRgaowJjRC7dnOiQ2qFc
	 ut2jKA2kCI4Kw1LFGJQ7NFSpV9EjSKKUtmCHW/dGzTO8/8haG699rTnqSfpfRo0ulYmqrhp7V+uY
	 c6Lfy94Wqmw+/Ti1VqswSzv4Kmkjr9Zo+nOoFB1AiXI6gC3F+a2d1f/wENiZj85eygbfKB1GqXfd
	 14OWp9id//65l8GwEFaCVNSGY+XXkbxcZjOwXB0ErF/Y0T3F7mlCzoJu3eIIKJz0mTzpD2QFQep5
	 HGe/UOkc2XfYgCMk+wDLl5K9jxeAMrMO3r2T8C3F4y+F1BcNjG9ZqkWp4Sgyy/3NUbaen0/MvIig
	 9LFDiQmwbkJgLBsVFbSxodM6GcXgVwPVYVKiKGmbMh37UNgNXO1SWiXm1ttKkbNGDmuFydRUQT/5
	 iKPg3DrA02i9htRbrCI19PxLpb/zYq+1myTfpC8cDJKHTnwAwmJ7hLKksoZSGwCG+HvJfG3FkdSA
	 9pVICZq+low9ZN2d1tTEiQEbUi6meVYYIOkSB22j1HoV2QfPyr+NWWs8H91AD380pOp23DRI3N+F
	 Fqr+gpHzpBRQubKNSHSE297Vogzxhq69ttpOv0K/IObD47zpI+TJxdzPQi6NAvTywqjXEGgNCavb
	 fA68V6bJuevBYGa64BE1wX869jUdTZZBic5vs0kPvlup44eFJuq5l1+Y2/Ag8QZYD0g2xlycGqoB
	 PuWYA9BUdb6HJ89+HBG2cTqIRPYPbHvR6grxy6ztYSLgGRgYo+NMySAw7lT10jN/cHL8cn4ZiARj
	 VxNU4Dz3DKGxo44Y8gbFPfCJg4UE2cFL1fH7PlU42Kkvux7z5LzaOGT+Yv9kmY8On5vWSgFtPMc4
	 whES3ayBrdlxAfmHdjoEyzXI+3Js5kNloEWlafKusjucINK4W9XsTxuc20jO8NBp9BfEWN6UF7Ia
	 7IAWgjOuqwh+165X4Rdd+emr7jwlzsO19u6oI2Wut6M6EgM5bVzK1nCmqbbqmfSOXwC3SOFth+10
	 fs/xeLOpFKWBpB/x7IpBMfCr7KsRLUU1wrmmtscOi42xfJAfeTrNGAk40tMbD0Qlpl/Ig1h3a7nY
	 HsprrXs+L/foqHbSnjmzJ2dAaSDRGza4tpfK3aCHNa777c3YfF+WfxbpJRjumrscOryQ0GVHQ23v
	 jFMXY=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Felix Gu <gu_0233@qq.com>
Date: Fri, 16 Jan 2026 20:27:47 +0800
Subject: [PATCH] pmdomain: ti: omap_prm: Fix a reference leak on device
 node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OQ-MSGID: <20260116-omap_prm-v1-1-e87c02f296ff@qq.com>
X-B4-Tracking: v=1; b=H4sIAMIuamkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQ0Mz3fzcxIL4gqJc3WTzpJQUS3Mjs8SkZCWg8oKi1LTMCrBR0bG1tQC
 V57H4WgAAAA==
X-Change-ID: 20260116-omap_prm-c7bdd9726abc
To: Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-pm@vger.kernel.org, Felix Gu <gu_0233@qq.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768566468; l=1073;
 i=gu_0233@qq.com; h=from:subject:message-id;
 bh=31Dg6exoE+spJrdeoYTv5xJGLaB7oDZ0LxPNxr4UNik=;
 b=uSKrSDWvEB2en/PdP1yunwZ+vmz6v73/vtXrQZrbJkruhwSkJjosRhMmEUSUa9WSfcnMTMx8e
 TYAkCzDV6tbB38pBuTvGaK6Y7tG64seYZ9I8YrsPdygrjPX/IoLnt5n
X-Developer-Key: i=gu_0233@qq.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

When calling of_parse_phandle_with_args(), the caller is responsible
to call of_node_put() to release the reference of device node.
In omap_prm_domain_attach_dev, it does not release the reference.

Fixes: 58cbff023bfa ("soc: ti: omap-prm: Add basic power domain support")
Signed-off-by: Felix Gu <gu_0233@qq.com>
---
 drivers/pmdomain/ti/omap_prm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pmdomain/ti/omap_prm.c b/drivers/pmdomain/ti/omap_prm.c
index 5142f064bf5c..64a187f79a1a 100644
--- a/drivers/pmdomain/ti/omap_prm.c
+++ b/drivers/pmdomain/ti/omap_prm.c
@@ -655,6 +655,7 @@ static int omap_prm_domain_attach_dev(struct generic_pm_domain *domain,
 	if (pd_args.args_count != 0)
 		dev_warn(dev, "%s: unusupported #power-domain-cells: %i\n",
 			 prmd->pd.name, pd_args.args_count);
+	of_node_put(pd_args.np);
 
 	genpd_data = dev_gpd_data(dev);
 	genpd_data->data = NULL;

---
base-commit: 9b7977f9e39b7768c70c2aa497f04e7569fd3e00
change-id: 20260116-omap_prm-c7bdd9726abc

Best regards,
-- 
Felix Gu <gu_0233@qq.com>


