Return-Path: <linux-pm+bounces-36453-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFA3BF002A
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 10:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 567224ED958
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 08:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECE12E9EA4;
	Mon, 20 Oct 2025 08:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="mhHZGHlB"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01484191F91;
	Mon, 20 Oct 2025 08:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760949913; cv=none; b=Px5FllBdIglSvNslQBOEe/bh73sRXmWa0NzprClEZXDr1ibp6YCrhnmdRyA+ZtJbjUlnEZ8lElUQ5GGjlLLj0qjBtG1XUDm+uKmrMVYIPgH8szj7QDLYmg4aW09sWB1TuDzIvqrp1hx+vRyK3qSauzz0+nx0FebGwFrRiEXjYsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760949913; c=relaxed/simple;
	bh=1Q70ljXCutO5bm3tw5/SX//jY4uQ5Rv0LtchI9vv45o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IklmKyFNTqT134jU+KYzErMo0eBX5jhw782xgjaQ8/wVLSEovl7XKNRFCmqNK9Me0DVnkR3PKgKtrtSJ0kWA2WFJIjvT+jwA18jAE2kkGll2tuiOI4tZEvEfuoo/69vO4dpbd8UdCq3zzJZmGlODEM+duosGIDBRxR6K3sls+08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=mhHZGHlB; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=210hhVx9EtGxU6YFcbc2AW78c+sT7wXeITsbJMSRtTQ=; b=mhHZGHlBInS7qFyI5d7u3KFb9b
	jFmD3LivoC1Y6wPLSUpWnN99M/VVT2stjCF7UkqQ3Lw/5Kv1YC/kWFw9usDIKmEFhtKFuOUmjE3of
	0ORdQrBBxNEorctFcQytccPf7OThXhHMb+Qk9LNh5Rvp9WdLxlEBDNuyh7fy7sO6EhGL69zd+7e5c
	nvyxBxHNtqS51HboXDW7Y9vbq1mVHyUu+1saGLQUE5knlf5cv9A4ICysMOTrNHVvW7/uPOvz1EqI2
	tDkfuApxkTCCIsw+7IOCrqfN50j4xL1jAm7JgS9x/lLzUmXY0w0kosrno/uwjVY+BBjPpeyUzaPgX
	brARyT+w==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vAlVW-00C1nO-Uh; Mon, 20 Oct 2025 10:44:47 +0200
From: Changwoo Min <changwoo@igalia.com>
To: lukasz.luba@arm.com,
	rafael@kernel.org,
	len.brown@intel.com,
	pavel@kernel.org
Cc: christian.loehle@arm.com,
	tj@kernel.org,
	kernel-dev@igalia.com,
	linux-pm@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Changwoo Min <changwoo@igalia.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 1/2] PM: EM: Remove an unused variable in em_notify_pd_deleted()
Date: Mon, 20 Oct 2025 17:44:28 +0900
Message-ID: <20251020084429.230322-1-changwoo@igalia.com>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The variable `ret` in em_notify_pd_deleted() is set but not used, so
that it causes the following warning:

>> kernel/power/em_netlink.c:228:6: warning: variable 'ret' set but
   not used [-Wunused-but-set-variable]

So, let's remove the unused `ret` to avoid the warning.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202510151223.THlBK6QR-lkp@intel.com/
Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 kernel/power/em_netlink.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/power/em_netlink.c b/kernel/power/em_netlink.c
index 2c55c758de6b..48752189a07b 100644
--- a/kernel/power/em_netlink.c
+++ b/kernel/power/em_netlink.c
@@ -269,7 +269,6 @@ static int __em_notify_pd_deleted_size(const struct em_perf_domain *pd)
 void em_notify_pd_deleted(const struct em_perf_domain *pd)
 {
 	struct sk_buff *msg;
-	int ret = -EMSGSIZE;
 	void *hdr;
 	int msg_sz;
 
@@ -287,7 +286,6 @@ void em_notify_pd_deleted(const struct em_perf_domain *pd)
 		goto out_free_msg;
 
 	if (nla_put_u32(msg, EM_A_PD_TABLE_PD_ID, pd->id)) {
-		ret = -EMSGSIZE;
 		goto out_free_msg;
 	}
 
-- 
2.51.1.dirty


