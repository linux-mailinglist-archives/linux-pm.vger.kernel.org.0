Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1421F1E2534
	for <lists+linux-pm@lfdr.de>; Tue, 26 May 2020 17:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgEZPRR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 May 2020 11:17:17 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:24236 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728088AbgEZPRR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 May 2020 11:17:17 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04QFBuJc017743;
        Tue, 26 May 2020 17:16:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=799GJcMpL2LNU/Tm5lFInudYnzHhcFshxvnKZptqkbM=;
 b=oxdsZGrxKp0SO7XEMvJ8Yvlq8g0WKFQAg87HbE/QqERMb5eh488/eNTbrNOOUJLEXHYL
 sw1sp0a1SkfYe/2vG7UEfAZwPaOSFyhjaLCrJ/T2TqkEBt2g73TRIOK2N9Kiyf22HbaV
 rdLb35QPuV6UkPY/VkTxVMU1XuqBZxKObokv3xdNIS397Fr5O1KTaArl1Sjk2FF3Ps3D
 zYFGs7PvV58mjc9MePvXw8mgt3OOa09IZcFzTcUV+1HC37y2coTiqNppxUf+O9/lwQxg
 KGvlbBjS3ZaVbrTI+GIXwn3gJPR1G+AYDrdFUyGKxVsROhOKVMR6mPSJsjg5MRvsK3Qj Dw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 316rya8feu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 May 2020 17:16:26 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4E8E010002A;
        Tue, 26 May 2020 17:16:25 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 312E02C1D9F;
        Tue, 26 May 2020 17:16:25 +0200 (CEST)
Received: from localhost (10.75.127.49) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 26 May 2020 17:16:24
 +0200
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>,
        <hugues.fruchet@st.com>, <mchehab@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <pavel@ucw.cz>, <len.brown@intel.com>,
        <valentin.schneider@arm.com>, <vincent.guittot@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [RFC RESEND 0/3] Introduce cpufreq minimum load QoS
Date:   Tue, 26 May 2020 17:16:16 +0200
Message-ID: <20200526151619.8779-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-26_02:2020-05-26,2020-05-26 signatures=0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

A first round [1] of discussions and suggestions have already be done on 
this series but without found a solution to the problem. I resend it to
progress on this topic.

When start streaming from the sensor the CPU load could remain very low 
because almost all the capture pipeline is done in hardware (i.e. without 
using the CPU) and let believe to cpufreq governor that it could use lower 
frequencies. If the governor decides to use a too low frequency that 
becomes a problem when we need to acknowledge the interrupt during the 
blanking time.
The delay to ack the interrupt and perform all the other actions before
the next frame is very short and doesn't allow to the cpufreq governor to
provide the required burst of power. That led to drop the half of the frames.

To avoid this problem, DCMI driver informs the cpufreq governors by adding
a cpufreq minimum load QoS resquest.

Benjamin 

[1] https://lkml.org/lkml/2020/4/24/360

Benjamin Gaignard (3):
  PM: QoS: Introduce cpufreq minimum load QoS
  cpufreq: governor: Use minimum load QoS
  media: stm32-dcmi: Inform cpufreq governors about cpu load needs

 drivers/cpufreq/cpufreq_governor.c        |   5 +
 drivers/media/platform/stm32/stm32-dcmi.c |   8 ++
 include/linux/pm_qos.h                    |  12 ++
 kernel/power/qos.c                        | 213 ++++++++++++++++++++++++++++++
 4 files changed, 238 insertions(+)

-- 
2.15.0

