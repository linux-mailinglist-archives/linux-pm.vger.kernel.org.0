Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D302147F04
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2019 12:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfFQKAc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Jun 2019 06:00:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37238 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727545AbfFQKAc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jun 2019 06:00:32 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5H9xdmF056996
        for <linux-pm@vger.kernel.org>; Mon, 17 Jun 2019 06:00:31 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t671tc5ty-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Mon, 17 Jun 2019 06:00:30 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <huntbag@linux.vnet.ibm.com>;
        Mon, 17 Jun 2019 11:00:28 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 17 Jun 2019 11:00:24 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5HA0Nq642401928
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jun 2019 10:00:23 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 963AEA405D;
        Mon, 17 Jun 2019 10:00:23 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 27194A404D;
        Mon, 17 Jun 2019 10:00:22 +0000 (GMT)
Received: from boston16h.aus.stglabs.ibm.com (unknown [9.3.23.78])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 17 Jun 2019 10:00:21 +0000 (GMT)
From:   Abhishek Goel <huntbag@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-pm@vger.kernel.org
Cc:     rjw@rjwysocki.net, daniel.lezcano@linaro.org, mpe@ellerman.id.au,
        dja@axtens.net, npiggin@gmail.com, ego@linux.vnet.ibm.com,
        Abhishek Goel <huntbag@linux.vnet.ibm.com>
Subject: [PATCH v2 0/1] Forced-wakeup for stop states on Powernv
Date:   Mon, 17 Jun 2019 04:56:47 -0500
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 19061710-0012-0000-0000-00000329CB13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061710-0013-0000-0000-00002162E1DC
Message-Id: <20190617095648.18847-1-huntbag@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-17_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=823 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906170093
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

v2 of auto-promotion : Removed timeout_needed and rebased to current
upstream kernel

Then, 
v1 of forced-wakeup : Moved the code to cpuidle powernv driver and started
as forced wakeup instead of auto-promotion

v2 of forced-wakeup : Extended the forced wakeup logic for all states.
Setting the decrementer instead of queuing up a hrtimer to implement the
logic.

Abhishek Goel (1):
  cpuidle-powernv : forced wakeup for stop states

 drivers/cpuidle/cpuidle-powernv.c | 38 +++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

-- 
2.17.1

