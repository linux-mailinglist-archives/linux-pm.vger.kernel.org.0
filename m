Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56CCF369FFE
	for <lists+linux-pm@lfdr.de>; Sat, 24 Apr 2021 09:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbhDXHiU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 24 Apr 2021 03:38:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43672 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229626AbhDXHiT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 24 Apr 2021 03:38:19 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13O7WkcJ137981;
        Sat, 24 Apr 2021 03:37:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=HZfBDxNYPZZTrCULq28m2g3mF473WCMC4xgWEVJdYGU=;
 b=PbiiW1SZ1TlshKGsGTHAi+yt2ahpT8xkjhILYQGyhpygWle2ajQq/vVTHINX1TNH7X19
 2ILkdC7dAtJNKSaQ/pa1sKU5uZB0UddFUfbZ3FD2rmc+Y5tXmbUU1rw3jaKemEAH8szL
 lQ02nAAkujrPJ8xMsvePz06gofRnUqxD7ArMKOn9wIX/VWSV8KuJpVQNVvd/JhscmUHo
 gmbea+ctoRgxMYwczTfnj0+3UekIOLA3rcyDGGXSgHa7DIzHbolL7dZ79utlhLjm7mHC
 7jQF9W9rKhCvVrPPQy328n6ilqALK65f6oPjLaI43AzPd19/s2CqVnVND8hP+bkgPdTl sg== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 384dfnsmhb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 24 Apr 2021 03:37:25 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13O7XGke014003;
        Sat, 24 Apr 2021 07:37:24 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 384ay8r148-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 24 Apr 2021 07:37:23 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13O7avCh35652062
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 24 Apr 2021 07:36:57 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2E42AE053;
        Sat, 24 Apr 2021 07:37:20 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1169DAE045;
        Sat, 24 Apr 2021 07:37:19 +0000 (GMT)
Received: from drishya.in.ibm.com (unknown [9.85.72.251])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 24 Apr 2021 07:37:18 +0000 (GMT)
Date:   Sat, 24 Apr 2021 13:07:16 +0530
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
Message-ID: <YIPKrIb+tY39taZv@drishya.in.ibm.com>
Reply-To: svaidy@linux.ibm.com
References: <1619104049-5118-1-git-send-email-ego@linux.vnet.ibm.com>
 <20210423073551.GZ6564@kitsune.suse.cz>
 <YILu6/GK+RwpskCc@drishya.in.ibm.com>
 <20210423174505.GE6564@kitsune.suse.cz>
 <YIMSCjTzcSwjQtRi@drishya.in.ibm.com>
 <20210423184216.GG6564@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20210423184216.GG6564@kitsune.suse.cz>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5tPSYoHPaOYn-c7cyxVu3Co5IrTQRT-n
X-Proofpoint-ORIG-GUID: 5tPSYoHPaOYn-c7cyxVu3Co5IrTQRT-n
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-23_14:2021-04-23,2021-04-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104240050
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Michal Such?nek <msuchanek@suse.de> [2021-04-23 20:42:16]:

> On Fri, Apr 23, 2021 at 11:59:30PM +0530, Vaidyanathan Srinivasan wrote:
> > * Michal Such?nek <msuchanek@suse.de> [2021-04-23 19:45:05]:
> > 
> > > On Fri, Apr 23, 2021 at 09:29:39PM +0530, Vaidyanathan Srinivasan wrote:
> > > > * Michal Such?nek <msuchanek@suse.de> [2021-04-23 09:35:51]:
> > > > 
> > > > > On Thu, Apr 22, 2021 at 08:37:29PM +0530, Gautham R. Shenoy wrote:
> > > > > > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> > > > > > 
> > > > > > Commit d947fb4c965c ("cpuidle: pseries: Fixup exit latency for
> > > > > > CEDE(0)") sets the exit latency of CEDE(0) based on the latency values
> > > > > > of the Extended CEDE states advertised by the platform
> > > > > > 
> > > > > > On some of the POWER9 LPARs, the older firmwares advertise a very low
> > > > > > value of 2us for CEDE1 exit latency on a Dedicated LPAR. However the
> > > > > Can you be more specific about 'older firmwares'?
> > > > 
> > > > Hi Michal,
> > > > 
> > > > This is POWER9 vs POWER10 difference, not really an obsolete FW.  The
> > > > key idea behind the original patch was to make the H_CEDE latency and
> > > > hence target residency come from firmware instead of being decided by
> > > > the kernel.  The advantage is such that, different type of systems in
> > > > POWER10 generation can adjust this value and have an optimal H_CEDE
> > > > entry criteria which balances good single thread performance and
> > > > wakeup latency.  Further we can have additional H_CEDE state to feed
> > > > into the cpuidle.  
> > > 
> > > So all POWER9 machines are affected by the firmware bug where firmware
> > > reports CEDE1 exit latency of 2us and the real latency is 5us which
> > > causes the kernel to prefer CEDE1 too much when relying on the values
> > > supplied by the firmware. It is not about 'older firmware'.
> > 
> > Correct.  All POWER9 systems running Linux as guest LPARs will see
> > extra usage of CEDE idle state, but not baremetal (PowerNV).
> > 
> > The correct definition of the bug or miss-match in expectation is that
> > firmware reports wakeup latency from a core/thread wakeup timing, but
> > not end-to-end time from sending a wakeup event like an IPI using
> > H_calls and receiving the events on the target.  Practically there are
> > few extra micro-seconds needed after deciding to wakeup a target
> > core/thread to getting the target to start executing instructions
> > within the LPAR instance.
> 
> Thanks for the detailed explanation.
> 
> Maybe just adding a few microseconds to the reported time would be a
> more reasonable workaround than using a blanket fixed value then.

Yes, that is an option.  But that may only reduce the difference
between existing kernel and new kernel unless we make it the same
number.  Further we are fixing this in P10 and hence we will have to
add "if(P9) do the compensation" and otherwise take it as is.  That
would not be elegant.  Given that our goal for P9 platform is to not
introduce changes in H_CEDE entry behaviour, we arrived at this
approach (this small patch) and this also makes it easy to backport to
various distro products.

Thanks,
Vaidy

