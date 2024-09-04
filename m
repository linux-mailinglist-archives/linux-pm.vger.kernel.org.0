Return-Path: <linux-pm+bounces-13503-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB6296AD99
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 03:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B2081C2101D
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 01:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1E31FC8;
	Wed,  4 Sep 2024 01:06:27 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC68663D
	for <linux-pm@vger.kernel.org>; Wed,  4 Sep 2024 01:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725411986; cv=none; b=F5BrPQiCNt+d8mxW9GUzsWihnXw4Q5DMgW/mDDtY0NSRoQ/SY4jtt+WStxhwujpodRrFr866z066twIOPF2ClkY5Qub3UhfAYpHf5uB6nFBNm/flfBmaKhdNmqzYGbmxrm7TmO+BXluL27kortfK/46sTnQ7YT3lJ3ecLxL4BGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725411986; c=relaxed/simple;
	bh=dCzaI+VZE0wr3Mw6c7h41JriJizcQxuZuGWbEPaj7bk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hrznxrUV0BE8LZ3c1BBRBJc4UQiatBEFg+ShPacadnM/uX/ovhQS6g0IavsBLug4KxUCaDSx8ej+K2NVHjipKt8zS1fDF9qiDKE9aNR9SsizfpMt0W5Dfg8BhK6BMzmyMttmAOwcFMoZAYgR/FX8H0Sm9jcrIN3J/StsJRVJkWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Wz46X3JZwzyRVH;
	Wed,  4 Sep 2024 09:05:24 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 175CA1403D2;
	Wed,  4 Sep 2024 09:06:02 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 4 Sep
 2024 09:06:01 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <linus.walleij@linaro.org>, <sre@kernel.org>
CC: <linux-pm@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH -next] power: supply: Constify struct kobj_type
Date: Wed, 4 Sep 2024 09:14:34 +0800
Message-ID: <20240904011434.2010118-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500022.china.huawei.com (7.185.36.66)

This 'struct kobj_type' is not modified. It is only used in
kobject_init_and_add() which takes a 'const struct kobj_type *ktype'
parameter.

Constifying this structure and moving it to a read-only section,
and can increase over all security.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 drivers/power/supply/ab8500_fg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 270874eeb934..a71903b1bf78 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -2531,7 +2531,7 @@ static struct attribute *ab8500_fg_attrs[] = {
 };
 ATTRIBUTE_GROUPS(ab8500_fg);
 
-static struct kobj_type ab8500_fg_ktype = {
+static const struct kobj_type ab8500_fg_ktype = {
 	.sysfs_ops = &ab8500_fg_sysfs_ops,
 	.default_groups = ab8500_fg_groups,
 };
-- 
2.34.1


