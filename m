Return-Path: <linux-pm+bounces-23250-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E22A4B6D6
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 04:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01BAF16C414
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 03:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7BC1D54CF;
	Mon,  3 Mar 2025 03:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UQfrwKzw"
X-Original-To: linux-pm@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB0C7DA6D;
	Mon,  3 Mar 2025 03:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740973444; cv=none; b=GH3r+2FO3HPMDOP/JGtrLyyXH4SU7mMmJGxReJV3PxQSxm/52VsaTq6oQl67W3s9xwtSqcaUB0l4QtvcocmzdoY0mE2NszZoKC8DGq4yg4mJo7IiHh6fOrq2JYnXtCdB1tJmSmKoLCKITLXkIpaBWCaE17XKs5MSmVbFam40GVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740973444; c=relaxed/simple;
	bh=FDczm35Zjmmbm3X17U5LkYtumttuXroOM3bL1lGECGc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n4YhZdAww0TK+zVben2H44P8A7kb0a8Yu7ABRhdwTpDl90JndjbkvrN9iih6uIrp6jh5C82uTZW/rPz+JGd3pI7BOmfCf/vgspi8knH/0PK9LNWi+IBRXgeVsctvWeSAZCShDa3OEVAMCBfJobcYAqQRj3G9a4dZolU2FAvpxQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UQfrwKzw; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=vgHDJ
	+8lJjUKHpr74AmWiy9dROiP1tus9eHykEPvSfc=; b=UQfrwKzwBRAqH9qINlw0C
	kIluMFS5oPfOZZp6CbmX/UebDJcnq6G/X2lNcFh4keVwkiv3eDByLJqaJvme067n
	eHhT2gYgL6rDV82A+qwnbNKQ5OBmVkFoR4MKHrrcKinUSJh9OSjDewfs7zO5qj8R
	hXZ6KZEGnQtyO5PaJ6NoF0=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDnt1lrJcVnIhzdPw--.41944S4;
	Mon, 03 Mar 2025 11:43:40 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: rafael@kernel.org,
	len.brown@intel.com,
	pavel@kernel.org,
	dietmar.eggemann@arm.com,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] PM: EM: fix an API misuse issue in em_create_pd()
Date: Mon,  3 Mar 2025 11:43:37 +0800
Message-Id: <20250303034337.3868497-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnt1lrJcVnIhzdPw--.41944S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw4rWFy7uF43CFy8Wry3Jwb_yoW3JFc_u3
	40qw1vgr9rZw4Y9an0yws5Zr13Kw1UXFWfur1xKFZ5t34kWr4FvrnIgFn5Zrsxur4FkrZr
	Ca1DCFs8Kw4xGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRN9a9UUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbBkB8FbmfFIcN3zgAAsd

Replace kfree() with em_table_free() to free
the memory allocated by em_table_alloc().

Fixes: 24e9fb635df2 ("PM: EM: Remove old table")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 kernel/power/energy_model.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 3874f0e97651..71b60aa20227 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -447,7 +447,7 @@ static int em_create_pd(struct device *dev, int nr_states,
 	return 0;
 
 free_pd_table:
-	kfree(em_table);
+	em_table_free(em_table);
 free_pd:
 	kfree(pd);
 	return -EINVAL;
-- 
2.25.1


