Return-Path: <linux-pm+bounces-13313-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7FD967EED
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 07:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 197D81F225D0
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 05:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EC214AD2C;
	Mon,  2 Sep 2024 05:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dcdvGIrK"
X-Original-To: linux-pm@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAADE382;
	Mon,  2 Sep 2024 05:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725256243; cv=none; b=QMwCTfnDKGl0N8dbW7UFxJ6J7LkOO83k0s6ToLjeisrV3HrXd0PSOseHHR6WI5qhU6MAESB6XEYrcKJVjc86/v6tW3wPSj6zKu3w0HDWzEi+MSl4LlrPjGRLC2CSHxhyd0iF7EKgajbF2NJTv1kUavsAvTRcGjC9jeUxiRz51d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725256243; c=relaxed/simple;
	bh=LtyyknAItHycdQMa9FuDDiyr/xupbTKn+Hda+8wSxQI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tclvRS7fbQz97XgTNRyX4hZp0hDzLbEC6lcDhfiNxiietvr85htqKZs3RY2i86on5mwIweiPm2adI6yz6YASsf99EoesDC9jXxAZ0H+WBCkz8gJw4rA/4HYYsfoysD0xzfgqyLffN5jnTbBM2ig/X+SbdWeJBvfIv9LzIrVGd9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dcdvGIrK; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=kA196
	EWbpjw8KYWYM2zO8iP1yxz/k8Xt5pfPY1wpqzM=; b=dcdvGIrKO93EYhpjwl9SV
	uL1KrTGaEu7Zebm+YgHEkXI6BYQSiu58ze020idWSx2LPlym7a4q3en5teT0NIOG
	XLQ272q4xiqLwIk7fBjlg+cOQmw/bfLXKogOoxxsyO00lLnDToL+sjwARorw5xRz
	9WHqPdd91kuTZWOrfTNt88=
Received: from localhost.localdomain (unknown [111.35.190.113])
	by gzga-smtp-mta-g3-0 (Coremail) with SMTP id _____wCHZ6IIUtVmqASeBg--.52399S4;
	Mon, 02 Sep 2024 13:50:04 +0800 (CST)
From: David Wang <00107082@163.com>
To: rafael@kernel.org,
	len.brown@intel.com,
	pavel@ucw.cz,
	gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Wang <00107082@163.com>
Subject: [PATCH] PM: add: move warn message out of mutex lock.
Date: Mon,  2 Sep 2024 13:49:59 +0800
Message-Id: <20240902054959.28073-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHZ6IIUtVmqASeBg--.52399S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7JFWxZr1UZrW8ArWDtr4fXwb_yoW8JrWxp3
	ZxCF1fAr47WF40y3W3t3ZIkF15Ka13WFWUJryfCas7C3yDXrsFyr9xJayDXw15X34xA3yq
	qrW3t3y5CF47WF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pE8nYUUUUUU=
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiMw9OqmXAnkxztAAAso

dpm_list_mtx does not protect any data used by
dev_warn for checking parent's power, move
dev_warn out of mutex lock block make the
lock more efficient, especially when the warn
is triggered. This can happen on some HW when
resume from suspend with USB camera opened:
 >usb 3-1.1: reset high-speed USB device number 4 using xhci_hcd
 >..
 >ep_81: PM: parent 3-1.1:1.1 should not be sleeping

Signed-off-by: David Wang <00107082@163.com>
---
 drivers/base/power/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 4a67e83300e1..934e5bb61f13 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -134,10 +134,10 @@ void device_pm_add(struct device *dev)
 	pr_debug("Adding info for %s:%s\n",
 		 dev->bus ? dev->bus->name : "No Bus", dev_name(dev));
 	device_pm_check_callbacks(dev);
-	mutex_lock(&dpm_list_mtx);
 	if (dev->parent && dev->parent->power.is_prepared)
 		dev_warn(dev, "parent %s should not be sleeping\n",
 			dev_name(dev->parent));
+	mutex_lock(&dpm_list_mtx);
 	list_add_tail(&dev->power.entry, &dpm_list);
 	dev->power.in_dpm_list = true;
 	mutex_unlock(&dpm_list_mtx);
-- 
2.39.2


