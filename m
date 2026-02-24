Return-Path: <linux-pm+bounces-43088-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJEqBrognWniMwQAu9opvQ
	(envelope-from <linux-pm+bounces-43088-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 04:53:30 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 265DA1817B8
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 04:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 892F230185FD
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 03:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E1314AD0D;
	Tue, 24 Feb 2026 03:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="FmQBeW82"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m9344.xmail.ntesmail.com (mail-m9344.xmail.ntesmail.com [103.126.93.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DA3140E5F;
	Tue, 24 Feb 2026 03:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.126.93.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771905206; cv=none; b=f0duOWBCWLdRTdnxaJ5gJfnxMOcVqExDYuLvOIquWo5QwB8YKPv91fa6v8g5rNaNtHBiiAgm6eNp2/aVy6OGfQqsl9YQE5R8A2PY+xY7i7jf5FV44xL9k+I2zfaHwW0qnA08oXa3hPHDriF1v9exINH1a1ydpFjkFPmSiPoGNCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771905206; c=relaxed/simple;
	bh=X36NZaauDYnt1MCeJpQ06TWEotTQjccgepB5/LAvQtA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=oqB7uHkfhsZX7VXAB67rroVHfGdoGJRjHqxd6tD5gs9LMorlzjdvrYH20ZpQKZTwnm2Dwu2PtuCOK0h8CwmG1HwWhU+NfcB9lDAU4HhKhShd0jemqUOHTegfOm7gNYAQBVbLAi0EP7LYCyitU06G0Bdkk6qziAMYgdnVr/Jtdlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=FmQBeW82; arc=none smtp.client-ip=103.126.93.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 34c057cea;
	Tue, 24 Feb 2026 11:48:08 +0800 (GMT+08:00)
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
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2] pmdomain: rockchip: Fix rkvdec0/1 and venc0/1 for RK3588
Date: Tue, 24 Feb 2026 11:47:59 +0800
Message-Id: <1771904879-243163-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0a9c8dc2ec5209cckunm05b5111d9cfbff
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU1KGVYYHh8ZQ0NOQxkaTE5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=FmQBeW82xeh8MqWOTLRjqENqx7i5H25uof0Ve+n76GPCpdVWw8MWR2a+6OFUdbs9ZY8Mm/jhI6uhycJ1PDFqUXVybV2tb7Lp9fgTeLIIndAXhVN5krLMIsuW4lJajEwAJTB93BPexwE/51Z50nzxbV6R/Ce9qRQOeBCDJYLR0pc=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=sS+xFDuYUesA5UA/liW/BWvuL5uZXm/VAmpP3oGwhDk=;
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[rock-chips.com,gmail.com,vger.kernel.org,collabora.com,sntech.de,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43088-lists,linux-pm=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shawn.lin@rock-chips.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[rock-chips.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,collabora.com:email]
X-Rspamd-Queue-Id: 265DA1817B8
X-Rspamd-Action: no action

Per the RK3588 TRM Table 7-1 RK3588 Voltage Domain and Power Domain Summary,
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

[1] https://lore.kernel.org/linux-rockchip/20251020212009.8852-2-detlev.casanova@collabora.com/
Fixes: db6df2e3fc16 ("pmdomain: rockchip: add regulator support")
Cc: stable@vger.kernel.org
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2:
- collect tags
- correct TRM section(Sebastian)

 drivers/pmdomain/rockchip/pm-domains.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 997e93c..040aa5f 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -1315,10 +1315,10 @@ static const struct rockchip_domain_info rk3588_pm_domains[] = {
 	[RK3588_PD_NPUTOP]	= DOMAIN_RK3588("nputop",  0x0, BIT(3),  0,       0x0, BIT(11), BIT(2),  0x0, BIT(1),  BIT(1),  false, false),
 	[RK3588_PD_NPU1]	= DOMAIN_RK3588("npu1",    0x0, BIT(4),  0,       0x0, BIT(12), BIT(3),  0x0, BIT(2),  BIT(2),  false, false),
 	[RK3588_PD_NPU2]	= DOMAIN_RK3588("npu2",    0x0, BIT(5),  0,       0x0, BIT(13), BIT(4),  0x0, BIT(3),  BIT(3),  false, false),
-	[RK3588_PD_VENC0]	= DOMAIN_RK3588("venc0",   0x0, BIT(6),  0,       0x0, BIT(14), BIT(5),  0x0, BIT(4),  BIT(4),  false, false),
-	[RK3588_PD_VENC1]	= DOMAIN_RK3588("venc1",   0x0, BIT(7),  0,       0x0, BIT(15), BIT(6),  0x0, BIT(5),  BIT(5),  false, false),
-	[RK3588_PD_RKVDEC0]	= DOMAIN_RK3588("rkvdec0", 0x0, BIT(8),  0,       0x0, BIT(16), BIT(7),  0x0, BIT(6),  BIT(6),  false, false),
-	[RK3588_PD_RKVDEC1]	= DOMAIN_RK3588("rkvdec1", 0x0, BIT(9),  0,       0x0, BIT(17), BIT(8),  0x0, BIT(7),  BIT(7),  false, false),
+	[RK3588_PD_VENC0]	= DOMAIN_RK3588("venc0",   0x0, BIT(6),  0,       0x0, BIT(14), BIT(5),  0x0, BIT(4),  BIT(4),  false, true),
+	[RK3588_PD_VENC1]	= DOMAIN_RK3588("venc1",   0x0, BIT(7),  0,       0x0, BIT(15), BIT(6),  0x0, BIT(5),  BIT(5),  false, true),
+	[RK3588_PD_RKVDEC0]	= DOMAIN_RK3588("rkvdec0", 0x0, BIT(8),  0,       0x0, BIT(16), BIT(7),  0x0, BIT(6),  BIT(6),  false, true),
+	[RK3588_PD_RKVDEC1]	= DOMAIN_RK3588("rkvdec1", 0x0, BIT(9),  0,       0x0, BIT(17), BIT(8),  0x0, BIT(7),  BIT(7),  false, true),
 	[RK3588_PD_VDPU]	= DOMAIN_RK3588("vdpu",    0x0, BIT(10), 0,       0x0, BIT(18), BIT(9),  0x0, BIT(8),  BIT(8),  false, false),
 	[RK3588_PD_RGA30]	= DOMAIN_RK3588("rga30",   0x0, BIT(11), 0,       0x0, BIT(19), BIT(10), 0x0, 0,       0,       false, false),
 	[RK3588_PD_AV1]		= DOMAIN_RK3588("av1",     0x0, BIT(12), 0,       0x0, BIT(20), BIT(11), 0x0, BIT(9),  BIT(9),  false, false),
-- 
2.7.4


