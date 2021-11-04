Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEF3445449
	for <lists+linux-pm@lfdr.de>; Thu,  4 Nov 2021 14:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhKDN4Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Nov 2021 09:56:16 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:50674 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231166AbhKDN4O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Nov 2021 09:56:14 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1A46fQYH015730;
        Thu, 4 Nov 2021 08:53:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=bkjdu8FbHZm0vbmQKykt1LoYhC2uVAAN6ZeNFVj8+aE=;
 b=IEMgi/9krmaCQFlZKTnZNgMpjbaYmZ0k/McFMULLgHQmxtxGfciTaAGuKAIGG0fClQP+
 7z3vu6nv0llI8slL6Wc/tJbmBOj4bZDDvQi16eberL2NDKjKgjnXbGPelR3VXdDi58tX
 bD2c20SJzrx2AhYr9+JCGJfcDn+NPgGQm01j528rtic8VDFWAQdZBZph95Y/md6uRtTc
 aSIOmkL5X7bRzKNh7uojd9TLTxwXfGy6x0Mh6PuFZVv111jEibMnxnKG8F2+I4/NgzD6
 WOzoGHYAfzbVii6SRZiAsXqW38ADy3v6RTBRYt5bp+Y35nWUTEi4B8SVU7Wrwz8Kvsr4 cw== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3c3e1432nk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 04 Nov 2021 08:53:32 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.12; Thu, 4 Nov
 2021 13:53:30 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.12 via Frontend
 Transport; Thu, 4 Nov 2021 13:53:30 +0000
Received: from ricardo-lws.crystal.cirrus.com (ricardo-lws.ad.cirrus.com [141.131.206.19])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B062011CB;
        Thu,  4 Nov 2021 13:53:29 +0000 (UTC)
From:   Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
To:     <patches@opensource.cirrus.com>, <sre@kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
Subject: [PATCH 0/1] Introduces bypass charge type property 
Date:   Thu, 4 Nov 2021 08:50:26 -0500
Message-ID: <20211104135027.2352874-1-rriveram@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: yv1b2DgcNTNnenIPBV766WwFj3z3u3MK
X-Proofpoint-GUID: yv1b2DgcNTNnenIPBV766WwFj3z3u3MK
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

This patch series introduces a new POWER_SUPPLY_CHARGE_TYPE for bypass charging
operation.

In fast charging ICs, the bypass operation is used to bypass the charging path
around the charging IC's integrated power converter to its load. This allows
for "smart" wall adaptors (such as USB PPS standard power adaptors) to handle
the power conversion and heat dissipation externally.

Best Regards,
Ricardo

Ricardo Rivera-Matos (1):
  power: supply: Introduces bypass charging property

 drivers/power/supply/power_supply_sysfs.c | 1 +
 include/linux/power_supply.h              | 1 +
 2 files changed, 2 insertions(+)

-- 
2.25.1

