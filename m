Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455292DD687
	for <lists+linux-pm@lfdr.de>; Thu, 17 Dec 2020 18:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbgLQRre (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Dec 2020 12:47:34 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:26910 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729020AbgLQRre (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Dec 2020 12:47:34 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BHHdmFG017667;
        Thu, 17 Dec 2020 09:46:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=FpQpHuy6/ZfhIgtE+0sdi72cp97ZauLYMhufxIK2nIc=;
 b=h88ijFe7JmMPQLWBOPesuzlUCy8o1LNAJRmw3ZwmPYg4OYmS5mKxEMJ5yCOg6vR4TFEx
 csA+hHI7kNDxQvF5+y79Ch16yvtVdS8mLHP3QHI6kHlzqfeKcVwq7eNDO8jaVPPu1M0q
 8y74V041I5XDRVkgBTxoLhz1O/Kyqxj9wkNtoHHyY/tyepiRakvMGcGyM20PnZwRPVLW
 /aqG09IyjjOzMW5bvaPLiWvQ6DzQl2lN3ts6qAfOXKVieJZD7txqrcS7RDejOgvKH1yh
 nVNG5Ipi8OMNQBKq5EqkvH3XtYN/Iezg78ZrpbaMsrPScxGfH91+drJoVBQN1aEjQg5a +A== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 35g4rp1car-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 17 Dec 2020 09:46:48 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 17 Dec
 2020 09:46:47 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 17 Dec
 2020 09:46:46 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Dec 2020 09:46:46 -0800
Received: from vb-cavnet.porotchkin.lan (PT-LT0319.marvell.com [10.6.202.166])
        by maili.marvell.com (Postfix) with ESMTP id 64C6B3F703F;
        Thu, 17 Dec 2020 09:46:42 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-clk@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <miquel.raynal@bootlin.com>, <rui.zhang@intel.com>,
        <daniel.lezcano@linaro.org>, <amitk@kernel.org>, <mw@semihalf.com>,
        <jaz@semihalf.com>, <nadavh@marvell.com>, <bpeled@marvell.com>,
        <stefanc@marvell.com>, Konstantin Porotchkin <kostap@marvell.com>
Subject: [PATCH 0/2] Enable usage of Marvell FW SIP services
Date:   Thu, 17 Dec 2020 19:46:00 +0200
Message-ID: <20201217174602.22212-1-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-17_13:2020-12-15,2020-12-17 signatures=0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Konstantin Porotchkin <kostap@marvell.com>

These patches enable usage of Arm Trusted Firmware SIP services on Marvell
Armada plaforms for acessing system registers that are not normally accessible
from kernel or user space (EL1/EL0), like DFX registers group.

Grzegorz Jaszczyk (2):
  thermal: armada: ap806: use firmware SiP services for thermal
    operations
  clk: mvebu: use firmware SiP service for accessing dfx register set

 drivers/clk/mvebu/ap-cpu-clk.c    | 141 +++++++++++++++++---
 drivers/thermal/armada_thermal.c  | 125 ++++++++++++++++-
 include/soc/marvell/armada8k/fw.h |  22 +++
 3 files changed, 269 insertions(+), 19 deletions(-)
 create mode 100644 include/soc/marvell/armada8k/fw.h

-- 
2.17.1

