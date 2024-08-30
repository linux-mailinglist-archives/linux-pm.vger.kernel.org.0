Return-Path: <linux-pm+bounces-13219-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 609C4965F0C
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 12:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D13B28B6CF
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 10:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9441118C91F;
	Fri, 30 Aug 2024 10:23:56 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B1318B46F;
	Fri, 30 Aug 2024 10:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725013436; cv=none; b=QhG9miMPpMr49cWtup2osydhgzYlmtUIaBBet8dhZd7BM3k0+PobRzd0hvNlArjRqDrMNdweUVrKo6M82rc7c2FORnu6TK/rUfrdK3mNgQ3Lib4757SsVTzhOuwYJO0y9zeg7Ya6h1NNJAya+OaG7H4cKXzpHNeyv15FHB91ulg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725013436; c=relaxed/simple;
	bh=uchYXotEvwfqAovoBQ9zvFpEchjkRtP07Y8RH7YhG2U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=anawm5T3CbBcUOUcNBbbZeEJMbp51fsB1WLYBk1s/gZo3N6Gkk6S1VRdhdIOXTNwTTrXjwbOtGKNAzVJoZJS2Tjw/uOyiNkDBH6EQn4+Y53U6gJ1t4SU7fbPUVaT67XQYXgRtHFsqte0BCMVCfqHDMtL2hzn6iF9OPQ4Jjf5hSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 47UALvSY029187;
	Fri, 30 Aug 2024 18:21:57 +0800 (+08)
	(envelope-from Yibin.Ding@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4WwDY52PfCz2N5cJ3;
	Fri, 30 Aug 2024 18:15:05 +0800 (CST)
Received: from tj10379pcu.spreadtrum.com (10.5.32.15) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 30 Aug 2024 18:21:55 +0800
From: Yibin Ding <Yibin.Ding@unisoc.com>
To: <djakov@kernel.org>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC: <yibin.ding01@gmail.com>, <niuzhiguo84@gmail.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Hao_hao.Wang@unisoc.com>, <Ke.Wang@unisoc.com>
Subject: [PATCH 0/2] Added debugfs node initialization and null pointer detection.
Date: Fri, 30 Aug 2024 18:21:53 +0800
Message-ID: <20240830102153.408675-1-Yibin.Ding@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 47UALvSY029187

From: Yibin Ding <Yibin.ding@unisoc.com>

The two debugfs nodes (/sys/kernel/debug/interconnect/test_client/dst_node,
src_node) do not initialize the character pointers before creation. For
such uninitialized nodes, direct access will cause a crash due to accessing
a null pointer.
For example, directly execute the following command after booting:
    cat /sys/kernel/debug/interconnect/test_client/dst_node.

Therefore, for the problem nodes, it is necessary to add initialization
operations and null pointer detection when accessing.

Yibin Ding (2):
  interconnect: Add character pointer initialization
  debugfs: Fix crash problem caused by accessing uninitialized nodes

 drivers/interconnect/debugfs-client.c | 10 ++++++++--
 fs/debugfs/file.c                     |  4 ++++
 2 files changed, 12 insertions(+), 2 deletions(-)

-- 
2.25.1


