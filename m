Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 103C85F566
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2019 11:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfGDJUy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Jul 2019 05:20:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15636 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727169AbfGDJUv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Jul 2019 05:20:51 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x649HC6f011381
        for <linux-pm@vger.kernel.org>; Thu, 4 Jul 2019 05:20:50 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2thdk52rqa-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Thu, 04 Jul 2019 05:20:49 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <huntbag@linux.vnet.ibm.com>;
        Thu, 4 Jul 2019 10:20:47 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 4 Jul 2019 10:20:44 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x649KhYw55705634
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Jul 2019 09:20:43 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D6B14C044;
        Thu,  4 Jul 2019 09:20:43 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81BE44C04E;
        Thu,  4 Jul 2019 09:20:41 +0000 (GMT)
Received: from boston16h.aus.stglabs.ibm.com (unknown [9.3.23.78])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  4 Jul 2019 09:20:41 +0000 (GMT)
From:   Abhishek Goel <huntbag@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-pm@vger.kernel.org
Cc:     npiggin@gmail.com, rjw@rjwysocki.net, daniel.lezcano@linaro.org,
        mpe@ellerman.id.au, ego@linux.vnet.ibm.com, dja@axtens.net,
        Abhishek Goel <huntbag@linux.vnet.ibm.com>
Subject: [PATCH v3 0/3] Forced-wakeup for stop states on Powernv
Date:   Thu,  4 Jul 2019 04:18:24 -0500
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 19070409-0016-0000-0000-0000028F26FB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070409-0017-0000-0000-000032ECC4ED
Message-Id: <20190704091827.19555-1-huntbag@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-04_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=941 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907040122
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently, the cpuidle governors determine what idle state a idling CPU
should enter into based on heuristics that depend on the idle history on
that CPU. Given that no predictive heuristic is perfect, there are cases
where the governor predicts a shallow idle state, hoping that the CPU will
be busy soon. However, if no new workload is scheduled on that CPU in the
near future, the CPU will end up in the shallow state.

Motivation
----------
In case of POWER, this is problematic, when the predicted state in the
aforementioned scenario is a shallow stop state on a tickless system. As
we might get stuck into shallow states even for hours, in absence of ticks
or interrupts.

To address this, We forcefully wakeup the cpu by setting the decrementer.
The decrementer is set to a value that corresponds with the residency of
the next available state. Thus firing up a timer that will forcefully
wakeup the cpu. Few such iterations will essentially train the governor to
select a deeper state for that cpu, as the timer here corresponds to the
next available cpuidle state residency. Thus, cpu will eventually end up
in the deepest possible state and we won't get stuck in a shallow state
for long duration.

Experiment
----------
For earlier versions when this feature was meat to be only for shallow lite
states, I performed experiments for three scenarios to collect some data.

case 1 :
Without this patch and without tick retained, i.e. in a upstream kernel,
It would spend more than even a second to get out of stop0_lite.

case 2 : With tick retained in a upstream kernel -

Generally, we have a sched tick at 4ms(CONF_HZ = 250). Ideally I expected
it to take 8 sched tick to get out of stop0_lite. Experimentally,
observation was

=========================================================
sample          min            max           99percentile
20              4ms            12ms          4ms
=========================================================

It would take atleast one sched tick to get out of stop0_lite.

case 2 :  With this patch (not stopping tick, but explicitly queuing a
          timer)

============================================================
sample          min             max             99percentile
============================================================
20              144us           192us           144us
============================================================


Description of current implementation
-------------------------------------

We calculate timeout for the current idle state as the residency value
of the next available idle state. If the decrementer is set to be
greater than this timeout, we update the decrementer value with the
residency of next available idle state. Thus, essentially training the
governor to select the next available deeper state until we reach the
deepest state. Hence, we won't get stuck unnecessarily in shallow states
for longer duration.

--------------------------------
v1 of auto-promotion : https://lkml.org/lkml/2019/3/22/58 This patch was
implemented only for shallow lite state in generic cpuidle driver.

v2 : Removed timeout_needed and rebased to current
upstream kernel

Then,
v1 of forced-wakeup : Moved the code to cpuidle powernv driver and started
as forced wakeup instead of auto-promotion

v2 : Extended the forced wakeup logic for all states.
Setting the decrementer instead of queuing up a hrtimer to implement the
logic.

v3 : 1) Cleanly handle setting the decrementer after exiting out of stop
       states.
     2) Added a disable_callback feature to compute timeout whenever a
        state is enbaled or disabled instead of computing everytime in fast
        idle path.
     3) Use disable callback to recompute timeout whenever state usage
        is changed for a state. Also, cleaned up the get_snooze_timeout
        function.


Abhishek Goel (3):
  cpuidle-powernv : forced wakeup for stop states
  cpuidle : Add callback whenever a state usage is enabled/disabled
  cpuidle-powernv : Recompute the idle-state timeouts when state usage
    is enabled/disabled

 arch/powerpc/include/asm/time.h   |  2 ++
 arch/powerpc/kernel/time.c        | 40 ++++++++++++++++++++++++++
 drivers/cpuidle/cpuidle-powernv.c | 47 ++++++++++++++++++++++---------
 drivers/cpuidle/sysfs.c           | 15 +++++++++-
 include/linux/cpuidle.h           |  5 ++++
 5 files changed, 95 insertions(+), 14 deletions(-)

-- 
2.17.1

