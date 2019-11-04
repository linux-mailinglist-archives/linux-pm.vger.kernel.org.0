Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5233EE138
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2019 14:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbfKDNau (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Nov 2019 08:30:50 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:52636 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728783AbfKDNau (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Nov 2019 08:30:50 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA4DNH0l017943;
        Mon, 4 Nov 2019 14:30:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=I3NGuc3Rt+teCuWa84VgiyUccSUQsi2ao2vZWxXCPGY=;
 b=QNXyxE1yFylAYnPQmDlZtT6exOsIQPDCeA7Znu8TNAQhDGJcRJ1L2N6tKJ8OvV/DqFmb
 qdkcJWQDkvGStQ2i9mdI1lCMNaSIRsnAjeHan6LUMLv9MrwK72AVusRylcff0q/JAbNz
 UmxDmNW58GdFPHsnjkPu3mLQq15qMuhxGdEkfUc6AGPKF6JE1mzkl3rsNNtaSBAfR6g/
 hQgrkasIV0FrAS2OD4Jc88cC9sEDrcXmeBa74CF86D1cJ3SNwS3t2hJGSS091xxwlBpP
 JeM+TSmHRho/fanptl/sxPpIAYwRgmf4pSDu5IUASxgw0NoFM2pNk7AvxgE8gajd470H 7A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2w11jn1vxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Nov 2019 14:30:25 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 00B10100038;
        Mon,  4 Nov 2019 14:30:22 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DB3D22D379D;
        Mon,  4 Nov 2019 14:30:22 +0100 (CET)
Received: from localhost (10.75.127.48) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 4 Nov 2019 14:30:22
 +0100
From:   Pascal Paillet <p.paillet@st.com>
To:     <rui.zhang@intel.com>, <edubezval@gmail.com>,
        <daniel.lezcano@linaro.org>, <amit.kucheria@verdurent.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <p.paillet@st.com>, <david.hernandezsanchez@st.com>,
        <horms+renesas@verge.net.au>, <wsa+renesas@sang-engineering.com>,
        <linux-pm@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/5] thermal: stm32: driver improvements
Date:   Mon, 4 Nov 2019 14:30:15 +0100
Message-ID: <20191104133020.8820-1-p.paillet@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG4NODE3.st.com (10.75.127.12) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-04_08:2019-11-04,2019-11-04 signatures=0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The goal of this patchset is to improve and simplify the stm32 thermal
driver:
* remove hardware interrupt handler that is useless
* let the framewwork handle the trip points
* fix interrupt management to avoid receiving hundreds of
interrupts when the temperature is close to the low threshold.
* improve temperature reading resolution

Pascal Paillet (5):
  thermal: stm32: remove hardware irq handler
  thermal: stm32: fix icifr register name
  thermal: stm32: handle multiple trip points
  thermal: stm32: improve temperature resolution
  thermal: stm32: fix low threshold interrupt flood

 drivers/thermal/st/stm_thermal.c | 367 ++++++++++---------------------
 1 file changed, 111 insertions(+), 256 deletions(-)

-- 
2.17.1

