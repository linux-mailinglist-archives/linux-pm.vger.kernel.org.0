Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B70422F887
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jul 2020 20:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgG0Szh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 14:55:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24234 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726196AbgG0Szh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2020 14:55:37 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06RIVn37032648;
        Mon, 27 Jul 2020 14:55:30 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32hs0sdmy9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jul 2020 14:55:30 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06RIXUjX039027;
        Mon, 27 Jul 2020 14:55:30 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32hs0sdmxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jul 2020 14:55:29 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06RIsbAU029233;
        Mon, 27 Jul 2020 18:55:29 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma02dal.us.ibm.com with ESMTP id 32gcy40b6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jul 2020 18:55:29 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06RItQBu58262010
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jul 2020 18:55:26 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 089E9C605F;
        Mon, 27 Jul 2020 18:55:28 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7DCEFC6057;
        Mon, 27 Jul 2020 18:55:27 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.85.73.118])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 27 Jul 2020 18:55:27 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 46A5D2E33AC; Tue, 28 Jul 2020 00:25:21 +0530 (IST)
Date:   Tue, 28 Jul 2020 00:25:21 +0530
From:   Gautham R Shenoy <ego@linux.vnet.ibm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        linuxppc-dev@ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 0/5] cpuidle-pseries: Parse extended CEDE information for
 idle.
Message-ID: <20200727185521.GB26602@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <1594120299-31389-1-git-send-email-ego@linux.vnet.ibm.com>
 <20200707113235.GM14120@in.ibm.com>
 <CAJZ5v0jA20TJyxRwtBu31zF5otkqbTW9R03Na3LgJsWB3nDmoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jA20TJyxRwtBu31zF5otkqbTW9R03Na3LgJsWB3nDmoQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-27_13:2020-07-27,2020-07-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007270122
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Rafael,

On Mon, Jul 27, 2020 at 04:14:12PM +0200, Rafael J. Wysocki wrote:
> On Tue, Jul 7, 2020 at 1:32 PM Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:
> >
> > Hi,
> >
> > On Tue, Jul 07, 2020 at 04:41:34PM +0530, Gautham R. Shenoy wrote:
> > > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> > >
> > > Hi,
> > >
> > >
> > >
> > >
> > > Gautham R. Shenoy (5):
> > >   cpuidle-pseries: Set the latency-hint before entering CEDE
> > >   cpuidle-pseries: Add function to parse extended CEDE records
> > >   cpuidle-pseries : Fixup exit latency for CEDE(0)
> > >   cpuidle-pseries : Include extended CEDE states in cpuidle framework
> > >   cpuidle-pseries: Block Extended CEDE(1) which adds no additional
> > >     value.
> >
> > Forgot to mention that these patches are on top of Nathan's series to
> > remove extended CEDE offline and bogus topology update code :
> > https://lore.kernel.org/linuxppc-dev/20200612051238.1007764-1-nathanl@linux.ibm.com/
> 
> OK, so this is targeted at the powerpc maintainers, isn't it?

Yes, the code is powerpc specific.

Also, I noticed that Nathan's patches have been merged by Michael
Ellerman in the powerpc/merge tree. I will rebase and post a v2 of
this patch series.

--
Thanks and Regards
gautham.
