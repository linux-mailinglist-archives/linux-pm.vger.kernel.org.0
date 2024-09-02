Return-Path: <linux-pm+bounces-13350-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C845968838
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 15:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FDE91C2231F
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 13:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79044201255;
	Mon,  2 Sep 2024 13:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BGW0Y5KR"
X-Original-To: linux-pm@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406EF19C54C;
	Mon,  2 Sep 2024 13:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725282014; cv=none; b=t7+ruEeUZ4e5grJnqyUxo0slAzYvfA19RK6ZV3pO8K5lhymKLStieGwCuOCS84H+l1m1dcf+MB/hVBBlB16q61agp//JS5AEXDXkAkd8vbgyZ/TqRpuyPDV77yH+7uqBgtDWewRdqZRFySonGm/idGnePGVbR5VydZJxL9h9eRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725282014; c=relaxed/simple;
	bh=IBlfFsJURzokRajo541Mn+CsYBgojFTmo/O0LP18RQs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fqAFVOxcZE2HxB37xVzg3yaOAyUBFNCiHCbxvHEBjh44bIi3qLHnZgjeWD0d0KRuk8gilJvFeK8PTjGGjcTQd8WYtoqdGkA+C+0i9OH9+e387+rEzGQXOA7uGS8boVdYMR9SUxT7TrgtoB6QrN/VqS/zImNgKdTVG54bDAC/blc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BGW0Y5KR; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=9AHiN
	MBJsCDtqog08yynx698uh5eWkaGrJBs/m0qbzY=; b=BGW0Y5KRuhBxl++Jq+83w
	eRLel8zqmN18o66qENz/imtVI5+bNU30+1xdybGTD5Y3jhoohC7Z+iSSccgJ1on/
	LAdYa4+Xt4OMXXZTJVrq3nyE7mb91HOQBN2nATlw1r3myBpfgWvrP2LAS2xZW2KV
	QcfTEVUkLTvpsJ03UcViw0=
Received: from localhost.localdomain (unknown [111.35.190.113])
	by gzga-smtp-mta-g2-5 (Coremail) with SMTP id _____wDHLyC3ttVmJGe0FA--.9585S4;
	Mon, 02 Sep 2024 20:59:40 +0800 (CST)
From: David Wang <00107082@163.com>
To: rafael@kernel.org,
	pavel@ucw.cz,
	gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Wang <00107082@163.com>
Subject: [PATCH] pm: sleep: do not set is_prepared when no_pm_callbacks is set
Date: Mon,  2 Sep 2024 20:59:33 +0800
Message-Id: <20240902125933.5742-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHLyC3ttVmJGe0FA--.9585S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF1UZF4kKrWUAF1rtFWxtFb_yoW8WF4fpF
	9Ik3y3Cw4kZr4jyan0vFnxGa45J397ZayavFySvasrCa1UurWDAayYqFWqvan8Gr9Yyr4v
	grW3t3yUXF12gFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pE8nYUUUUUU=
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiqRxOqmVOCmlzqgAAsA

When resume, a parent device with no pm callbacks
would have "is_prepared" and "direct_complete" bit
set, and skip the "fib" chance to unset "is_prepared"
in device_resume because of the direct_complete bit.
This will trigger a kernel warning when resume its child
For example, when suspend system with an USB webcam
opened, following warning would show up during resume:

 >usb 3-1.1: reset high-speed USB device number 4 using xhci_hcd
 >..
 >ep_81: PM: parent 3-1.1:1.1 should not be sleeping

The device parenting relationships are:
[usb 3-1.1] << [uvcvideo 3-1.1:1.1] << [ep_81].
When resume, since the virtual [uvcvideo 3-1.1:1.1] device
has no pm callbacks, it would not clear "is_prepared"
once set.  Then, when resume [ep_81], pm module would
yield a warn seeing [ep_81]'s parent [uvcvideo 3-1.1:1.1]
having "is_prepared".

Do not set "is_prepared" for virtual devices having
no pm callbacks can clear those kernel warnings.

Signed-off-by: David Wang <00107082@163.com>
---
 drivers/base/power/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 934e5bb61f13..e2149ccf2c3e 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1880,7 +1880,8 @@ int dpm_prepare(pm_message_t state)
 		mutex_lock(&dpm_list_mtx);
 
 		if (!error) {
-			dev->power.is_prepared = true;
+			if (!dev->power.no_pm_callbacks)
+				dev->power.is_prepared = true;
 			if (!list_empty(&dev->power.entry))
 				list_move_tail(&dev->power.entry, &dpm_prepared_list);
 		} else if (error == -EAGAIN) {
-- 
2.39.2


