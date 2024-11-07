Return-Path: <linux-pm+bounces-17095-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 445039BFD02
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 04:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5598E283576
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 03:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C87D126C01;
	Thu,  7 Nov 2024 03:37:31 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6EE36D;
	Thu,  7 Nov 2024 03:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730950651; cv=none; b=khYK/pqzQrx7tB9llqT2zoHxFP6M7X/ENQWFig5jF5b8AZuMFVbHiXPbBJ9MUJAW8MKd6rsCLwVRlm152578aM8BzheQ1RbzgDQ/EaTxJaY0mfsWNxwcj9DMcR7P5oqiE0gqQaDqlCyz2j9CknG/Bzfi0r2XF+65wK7CXFjblDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730950651; c=relaxed/simple;
	bh=euRF9By+Bt9qNH9j2tqDuSY0w4Mau6NKtcMg/mHtcoI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CFycom1Lx7klAwTML5q10bsQzr1xbDo3e0fmlRFOAubsBrhutVnH92PpLR6RbqC3qZuQLbojElMoB3bZ5e2sMJTjAnduuk6GdwbszyWVFv8JXZwshop03lbTyuMqC1inf4GbEOMR8ke/VynVSq6aFq0nxLpg9q2bu7RR9yV9FfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XkSQD0bCNzpXvG;
	Thu,  7 Nov 2024 11:35:32 +0800 (CST)
Received: from dggemv703-chm.china.huawei.com (unknown [10.3.19.46])
	by mail.maildlp.com (Postfix) with ESMTPS id 1A33F180AEA;
	Thu,  7 Nov 2024 11:37:26 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 7 Nov 2024 11:37:25 +0800
Received: from localhost.localdomain (10.28.79.22) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 Nov 2024 11:37:25 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <linux-pm@vger.kernel.org>, <rafael@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <liuyonglong@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>
Subject: [PATCH v1 0/2] Add _TZD method for ACPI thermal
Date: Thu, 7 Nov 2024 11:26:24 +0800
Message-ID: <20241107032626.16682-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.22.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemn100009.china.huawei.com (7.202.194.112)

This series is mainly used to support _TZD method for ACPI thermal so as
to directly know the devices associated with the thermal zone.
And fix a little issue for acpi_power_meter by the way.

Huisong Li (2):
  ACPI: thermal: Support for linking devices associated with the thermal
    zone
  hwmon: (acpi_power_meter) Fix fail to load module on platform without
    _PMD method

 drivers/acpi/thermal.c           | 114 ++++++++++++++++++++++++++++++-
 drivers/hwmon/acpi_power_meter.c |   3 +-
 2 files changed, 115 insertions(+), 2 deletions(-)

-- 
2.22.0


