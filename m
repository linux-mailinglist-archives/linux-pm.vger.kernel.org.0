Return-Path: <linux-pm+bounces-43185-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EN97F61knmlCVAQAu9opvQ
	(envelope-from <linux-pm+bounces-43185-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 03:55:41 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C391910E1
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 03:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1C62306C470
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 02:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72274299924;
	Wed, 25 Feb 2026 02:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="TKiSaPy3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m3278.qiye.163.com (mail-m3278.qiye.163.com [220.197.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883AA298CC7;
	Wed, 25 Feb 2026 02:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771988124; cv=none; b=d0z+ryD1eYyQTh0JMbdSKRnXZlKxIs2vjXryJRE1sAZYmiNo66QGfrl47chnlHUO6fil66moxWXqZkVPDoePXFJVnR80h7PMhAZSikjR0c0W1w8kzA7xRYfUokon7LSVdCSx8ASkzM87NBw0ac9UN9XmP1S6G+NsA7T7+0UaYO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771988124; c=relaxed/simple;
	bh=mIcZYpc8AT4o8gqIfnbh6XNvCFCHkFv3yuerLteQZn8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=IeE6g8DxqL93ZfmnIGiJo5V7edlqle0MrXSDBmE4G/BOQw9qZ3ACCMHoNoNCQHyMAskFSHNSU/CzEqtMrvJ1UFcHCuGDlKPMX6gfJt8oboJrDprSkO2RePx+DN6+pwL3D1MMUPY7+AIwhg7vaBh5+kYyQLVKZykpsu1BNeqa5EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=TKiSaPy3; arc=none smtp.client-ip=220.197.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 34dd64091;
	Wed, 25 Feb 2026 10:55:10 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Finley Xiao <finley.xiao@rock-chips.com>,
	Frank Zhang <rmxpzlb@gmail.com>,
	linux-pm@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org,
	stable@vger.kernel.org,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3] pmdomain: rockchip: Fix PD_VCODEC for RK3588
Date: Wed, 25 Feb 2026 10:55:01 +0800
Message-Id: <1771988101-49877-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0a9c92b8cc6f09cckunmfc928bb9ab3f2f
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxgZTVZNGUsaGk1KGR9NTxpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=TKiSaPy3NhGAYO2355MbeFtq5S/6Ra41Ad4uQsAdiMqL4m7io/5+I0fKG4R1j1VxTNszAQAMQz1N7MeExgk2qWnFB67tAS8TuJHLqyg/keJTq86ri1ucgYOoVpSJUH++UlAKn8ga/TIc+VtUZbwMi0DKU40Na7iKDOD7gQBS9nQ=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=w0DCebXqm5N2UL9SR5NHgl6Sni59xFPG3ie+LKXKsvw=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[rock-chips.com,none];
	R_DKIM_ALLOW(-0.20)[rock-chips.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[rock-chips.com,gmail.com,vger.kernel.org,collabora.com,sntech.de,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43185-lists,linux-pm=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shawn.lin@rock-chips.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[rock-chips.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rock-chips.com:mid,rock-chips.com:dkim,rock-chips.com:email]
X-Rspamd-Queue-Id: C1C391910E1
X-Rspamd-Action: no action

From the RK3588 TRM Table 7-1 RK3588 Voltage Domain and Power Domain Summary,
PD_RKVDEC0/1 and PD_VENC0/1 rely on VD_VCODEC which require extra voltages to
be applied, otherwise it breaks RK3588-evb1-v10 board after vdec support landed[1].
The panic looks like below:

  rockchip-pm-domain fd8d8000.power-management:power-controller: failed to set domain 'rkvdec0' on, val=0
  rockchip-pm-domain fd8d8000.power-management:power-controller: failed to set domain 'rkvdec1' on, val=0
  ...
  Hardware name: Rockchip RK3588S EVB1 V10 Board (DT)
  Workqueue: pm genpd_power_off_work_fn
  Call trace:
  show_stack+0x18/0x24 (C)
  dump_stack_lvl+0x40/0x84
  dump_stack+0x18/0x24
  vpanic+0x1ec/0x4fc
  vpanic+0x0/0x4fc
  check_panic_on_warn+0x0/0x94
  arm64_serror_panic+0x6c/0x78
  do_serror+0xc4/0xcc
  el1h_64_error_handler+0x3c/0x5c
  el1h_64_error+0x6c/0x70
  regmap_mmio_read32le+0x18/0x24 (P)
  regmap_bus_reg_read+0xfc/0x130
  regmap_read+0x188/0x1ac
  regmap_read+0x54/0x78
  rockchip_pd_power+0xcc/0x5f0
  rockchip_pd_power_off+0x1c/0x4c
  genpd_power_off+0x84/0x120
  genpd_power_off+0x1b4/0x260
  genpd_power_off_work_fn+0x38/0x58
  process_scheduled_works+0x194/0x2c4
  worker_thread+0x2ac/0x3d8
  kthread+0x104/0x124
  ret_from_fork+0x10/0x20
  SMP: stopping secondary CPUs
  Kernel Offset: disabled
  CPU features: 0x3000000,000e0005,40230521,0400720b
  Memory Limit: none
  ---[ end Kernel panic - not syncing: Asynchronous SError Interrupt ]---

Chaoyi pointed out the PD_VCODEC is the parent of PD_RKVDEC0/1 and PD_VENC0/1, so checking
the PD_VCODEC is enough.

[1] https://lore.kernel.org/linux-rockchip/20251020212009.8852-2-detlev.casanova@collabora.com/
Fixes: db6df2e3fc16 ("pmdomain: rockchip: add regulator support")
Cc: stable@vger.kernel.org
Suggested-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v3:
- drop tags
- rework it for just changing PD_VCODEC(chaoyi)

Changes in v2:
- collect tags
- correct TRM section(Sebastian)

 drivers/pmdomain/rockchip/pm-domains.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 997e93c..44d3484 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -1311,7 +1311,7 @@ static const struct rockchip_domain_info rk3576_pm_domains[] = {
 static const struct rockchip_domain_info rk3588_pm_domains[] = {
 	[RK3588_PD_GPU]		= DOMAIN_RK3588("gpu",     0x0, BIT(0),  0,       0x0, 0,       BIT(1),  0x0, BIT(0),  BIT(0),  false, true),
 	[RK3588_PD_NPU]		= DOMAIN_RK3588("npu",     0x0, BIT(1),  BIT(1),  0x0, 0,       0,       0x0, 0,       0,       false, true),
-	[RK3588_PD_VCODEC]	= DOMAIN_RK3588("vcodec",  0x0, BIT(2),  BIT(2),  0x0, 0,       0,       0x0, 0,       0,       false, false),
+	[RK3588_PD_VCODEC]	= DOMAIN_RK3588("vcodec",  0x0, BIT(2),  BIT(2),  0x0, 0,       0,       0x0, 0,       0,       false, true),
 	[RK3588_PD_NPUTOP]	= DOMAIN_RK3588("nputop",  0x0, BIT(3),  0,       0x0, BIT(11), BIT(2),  0x0, BIT(1),  BIT(1),  false, false),
 	[RK3588_PD_NPU1]	= DOMAIN_RK3588("npu1",    0x0, BIT(4),  0,       0x0, BIT(12), BIT(3),  0x0, BIT(2),  BIT(2),  false, false),
 	[RK3588_PD_NPU2]	= DOMAIN_RK3588("npu2",    0x0, BIT(5),  0,       0x0, BIT(13), BIT(4),  0x0, BIT(3),  BIT(3),  false, false),
-- 
2.7.4


