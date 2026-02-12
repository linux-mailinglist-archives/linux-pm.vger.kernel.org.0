Return-Path: <linux-pm+bounces-42547-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIPIHYypjWkK5wAAu9opvQ
	(envelope-from <linux-pm+bounces-42547-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 11:21:00 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E6512C6C9
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 11:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C39553057298
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 10:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D6D2D46B4;
	Thu, 12 Feb 2026 10:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="f7tr/E4L"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m1973194.qiye.163.com (mail-m1973194.qiye.163.com [220.197.31.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3C22EC569;
	Thu, 12 Feb 2026 10:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770891397; cv=none; b=DAdkFJkA1UstPyNA7+4GOGuowDbetP0bqepnpW5R7XiKVpVAmmOOyDbUECj2bjf0awicmt4KoueZ2HFwtINvZ7BMbNUhzKM5bNzssSnD+HZaUUZimib4GXmw08nQB5sp3Xz3jPCVPRNBcdc03MPmoTzKh4oSPpkWoDMdPWjtVHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770891397; c=relaxed/simple;
	bh=S0aN7p4YQN4RmlyDDCPare7qU/HGNXtlRHX0+vqggF0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ImYNGbfnpQb3FZo99ukb/iUEB/hvBH68IG6cujHgxtuBDU90+UUXmdSqpHezWHM0U6cqDyju+3dDAuQKe9jcJyHJwErYrewMN964DyozTHh6fdG+cnOga2U7dZxduCcu29DD+7ok+rFnrwt9rMBd9nn3ST19aWWehAZ2CRbAsRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=f7tr/E4L; arc=none smtp.client-ip=220.197.31.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 33fa08078;
	Thu, 12 Feb 2026 18:16:21 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Finley Xiao <finley.xiao@rock-chips.com>,
	Frank Zhang <rmxpzlb@gmail.com>,
	linux-pm@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	stable@vger.kernel.org
Subject: [PATCH] pmdomain: rockchip: Fix rkvdec0/1 and venc0/1 for RK3588
Date: Thu, 12 Feb 2026 18:16:04 +0800
Message-Id: <1770891364-52147-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0a9c515a082f09cckunm305a02041ef9af
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh9JSlYeTh1MSktPTE5PTRpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=f7tr/E4LX48FgGZFCGkczgOcuFAT9VbPhusium2zsAa0QDxmpmNN4PypuvtTVlIxkv843sPIAXHGkBF6cjXvQIRWyWdChEU7u8MMHroicK43UuzL5bbmIXcXYhoo25lhqqii1mMBpJkNSrj+4iR8i3pfIcyGHv6JJdTJOPONs/E=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=GFR9wRVn0Qke2uoGUoqI/yXbVDXXXiIpaex2yOx3ucY=;
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[rock-chips.com,gmail.com,vger.kernel.org,collabora.com,sntech.de,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42547-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shawn.lin@rock-chips.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[rock-chips.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F0E6512C6C9
X-Rspamd-Action: no action

From the RK3588 TRM Table 1-1 RK3588 Voltage Domain and Power Domain Summary,
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
  _regmap_bus_reg_read+0xfc/0x130
  _regmap_read+0x188/0x1ac
  regmap_read+0x54/0x78
  rockchip_pd_power+0xcc/0x5f0
  rockchip_pd_power_off+0x1c/0x4c
  _genpd_power_off+0x84/0x120
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
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

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


