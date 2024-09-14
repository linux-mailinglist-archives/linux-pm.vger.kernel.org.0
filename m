Return-Path: <linux-pm+bounces-14255-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9D3978FEB
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 12:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 349B5283BEC
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 10:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FFA1CE70A;
	Sat, 14 Sep 2024 10:24:57 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FC845025;
	Sat, 14 Sep 2024 10:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726309497; cv=none; b=um+XjOllsJtatddTDHLs5Zm2tqkNdJVB+YAyMMio3nHHfyU0nKYKg+UX1BCvdoVhXJ4xFFQonxeDFbgpOEr1wONZ8k/OXK5wgCaRYceDXQkE3F2T9rRqtAfISYBXsmZdVTZKpBoFl86doFJO9cC33kpXuYhAyeZWBhoq9WefYaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726309497; c=relaxed/simple;
	bh=XuyHuYAWUQ10ZlvVD0fwzAnOqOrNReH4FiDAPvwYIFY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ibPqUM5lsxBz+wiN8acamhv+Tklys5wFR+SfmKtYU8oy8Zr08HGBquIt7VLEMQmfZ+QzEoAfyQGwwmCDINKXDcJOkULs3ZCGCcWCM2IgYKw05LxhMw/bxCngV4m6S/omLhrmy5R5IArMf2kEEDzr6UbyQHJcw1Jf1q00tgOicQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 48EAOQf2042546;
	Sat, 14 Sep 2024 18:24:26 +0800 (+08)
	(envelope-from Yibin.Ding@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4X5RtR6RDLz2Pvl0t;
	Sat, 14 Sep 2024 18:17:03 +0800 (CST)
Received: from tj10379pcu.spreadtrum.com (10.5.32.15) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Sat, 14 Sep 2024 18:24:22 +0800
From: Yibin Ding <Yibin.Ding@unisoc.com>
To: <djakov@kernel.org>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC: <yibin.ding01@gmail.com>, <niuzhiguo84@gmail.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Hao_hao.Wang@unisoc.com>, <Ke.Wang@unisoc.com>
Subject: [PATCH V2 0/2] Added debugfs node initialization and null pointer detection.
Date: Sat, 14 Sep 2024 18:24:18 +0800
Message-ID: <20240914102418.3879203-1-Yibin.Ding@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 48EAOQf2042546

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

 drivers/interconnect/debugfs-client.c | 9 +++++++--
 fs/debugfs/file.c                     | 4 ++++
 2 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.25.1


