Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA4CA3699A9
	for <lists+linux-pm@lfdr.de>; Fri, 23 Apr 2021 20:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243750AbhDWSab (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Apr 2021 14:30:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23984 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S243642AbhDWSab (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Apr 2021 14:30:31 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13NIOe8R111699;
        Fri, 23 Apr 2021 14:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=isKQGIjpV+FM0q3izlzdUC4q76gFmfwIgquMYKf2CeA=;
 b=g0rZIXAqJdgQVrXDdNqnWPpMpuH+UBDjNeIUtLcMRN7QoLRrwsqkl1/ycUmMnHEO9ggU
 yIA8mURxyHi8te60NNUHYm3JOAiAm1vq24qStFdpk9iEDo//I6IYkL8yukENoS2kFBve
 wSUf/Bds9Kt/QUzTpzyJavzIZ6kuO5F9gH3B4ZqBc1LhMyuiMHXPL4N9BwkjxL5M4O3t
 EuGX0ZJxtelySU4RCRZ4C+xeRbmeJUvnTTwr67aW4zthJvT6FnR+eNe1Es8DkTpvjKqo
 aOBA7XfbDjdo08+q1+Ghy/r/vR6aDRrkCwwFnPBj8A4RGHoQFoOfb0zS1BZj/iqRvCPN Zg== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 383yec053j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Apr 2021 14:29:39 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13NITB7f021696;
        Fri, 23 Apr 2021 18:29:38 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 37yqa89xu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Apr 2021 18:29:38 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13NITZaw42926358
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Apr 2021 18:29:35 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E22AFA404D;
        Fri, 23 Apr 2021 18:29:34 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36DC4A4040;
        Fri, 23 Apr 2021 18:29:33 +0000 (GMT)
Received: from drishya.in.ibm.com (unknown [9.199.57.164])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 23 Apr 2021 18:29:33 +0000 (GMT)
Date:   Fri, 23 Apr 2021 23:59:30 +0530
From:   Vaidyanathan Srinivasan <svaidy@linux.ibm.com>
To:     Michal Such?nek <msuchanek@suse.de>
Cc:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, joedecke@de.ibm.com,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpuidle/pseries: Fixup CEDE0 latency only for POWER10
 onwards
Message-ID: <YIMSCjTzcSwjQtRi@drishya.in.ibm.com>
Reply-To: svaidy@linux.ibm.com
References: <1619104049-5118-1-git-send-email-ego@linux.vnet.ibm.com>
 <20210423073551.GZ6564@kitsune.suse.cz>
 <YILu6/GK+RwpskCc@drishya.in.ibm.com>
 <20210423174505.GE6564@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20210423174505.GE6564@kitsune.suse.cz>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HkuyGul7MuJT1Qd1D8rHRS74pw5x-JhD
X-Proofpoint-GUID: HkuyGul7MuJT1Qd1D8rHRS74pw5x-JhD
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-23_07:2021-04-23,2021-04-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 mlxscore=0 suspectscore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104230119
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Michal Such?nek <msuchanek@suse.de> [2021-04-23 19:45:05]:

> On Fri, Apr 23, 2021 at 09:29:39PM +0530, Vaidyanathan Srinivasan wrote:
> > * Michal Such?nek <msuchanek@suse.de> [2021-04-23 09:35:51]:
> > 
> > > On Thu, Apr 22, 2021 at 08:37:29PM +0530, Gautham R. Shenoy wrote:
> > > > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> > > > 
> > > > Commit d947fb4c965c ("cpuidle: pseries: Fixup exit latency for
> > > > CEDE(0)") sets the exit latency of CEDE(0) based on the latency values
> > > > of the Extended CEDE states advertised by the platform
> > > > 
> > > > On some of the POWER9 LPARs, the older firmwares advertise a very low
> > > > value of 2us for CEDE1 exit latency on a Dedicated LPAR. However the
> > > Can you be more specific about 'older firmwares'?
> > 
> > Hi Michal,
> > 
> > This is POWER9 vs POWER10 difference, not really an obsolete FW.  The
> > key idea behind the original patch was to make the H_CEDE latency and
> > hence target residency come from firmware instead of being decided by
> > the kernel.  The advantage is such that, different type of systems in
> > POWER10 generation can adjust this value and have an optimal H_CEDE
> > entry criteria which balances good single thread performance and
> > wakeup latency.  Further we can have additional H_CEDE state to feed
> > into the cpuidle.  
> 
> So all POWER9 machines are affected by the firmware bug where firmware
> reports CEDE1 exit latency of 2us and the real latency is 5us which
> causes the kernel to prefer CEDE1 too much when relying on the values
> supplied by the firmware. It is not about 'older firmware'.

Correct.  All POWER9 systems running Linux as guest LPARs will see
extra usage of CEDE idle state, but not baremetal (PowerNV).

The correct definition of the bug or miss-match in expectation is that
firmware reports wakeup latency from a core/thread wakeup timing, but
not end-to-end time from sending a wakeup event like an IPI using
H_calls and receiving the events on the target.  Practically there are
few extra micro-seconds needed after deciding to wakeup a target
core/thread to getting the target to start executing instructions
within the LPAR instance.

> I still think it would be preferrable to adjust the latency value
> reported by the firmware to match reality over a kernel workaround.

Right, practically we can fix for future releases and as such we
targeted this scheme from POWER10 but expected no harm on POWER9 which
proved to be wrong.

We can possibly change this FW value for POWER9, but it is too
expensive and not practical because many release streams exist for
different platforms and further customers are at different streams as
well.  We cannot force all of them to update because that blows up
co-dependency matrix.

From a user/customer's view current kernel worked fine, why is
a kernel update changing my performance :(

Looking back, we should have boxed any kernel-firmware dependent
feature like this one to a future releases only.  We have all options
open for a future release like POWER10, but on a released product
stream, we have to manage with kernel changes.  In this specific case
we should have been very conservative and not allow the kernel to
change behaviour on released products.

Thanks,
Vaidy

