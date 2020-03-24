Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67E631919AC
	for <lists+linux-pm@lfdr.de>; Tue, 24 Mar 2020 20:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbgCXTLi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Mar 2020 15:11:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62936 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727715AbgCXTLh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Mar 2020 15:11:37 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02OJ2qmr072382
        for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2020 15:11:36 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yynky66yj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2020 15:11:36 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Tue, 24 Mar 2020 19:11:31 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 24 Mar 2020 19:11:28 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02OJBUHq52756532
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Mar 2020 19:11:30 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E5A0AE045;
        Tue, 24 Mar 2020 19:11:30 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C339AAE04D;
        Tue, 24 Mar 2020 19:11:29 +0000 (GMT)
Received: from osiris (unknown [9.145.15.117])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 24 Mar 2020 19:11:29 +0000 (GMT)
Date:   Tue, 24 Mar 2020 20:11:28 +0100
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>
Subject: Re: s390: removal of hibernate support
References: <20200323181245.GJ4288@osiris>
 <CAJZ5v0hzf=kQBcR=K2KL1kEVtA6oLPtLDaeeaVuWMPsXomhJHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hzf=kQBcR=K2KL1kEVtA6oLPtLDaeeaVuWMPsXomhJHw@mail.gmail.com>
X-TM-AS-GCONF: 00
x-cbid: 20032419-0020-0000-0000-000003BA52EA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032419-0021-0000-0000-00002212D547
Message-Id: <20200324191128.GA3822@osiris>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-24_07:2020-03-23,2020-03-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 mlxscore=0 bulkscore=0 phishscore=0 adultscore=0 mlxlogscore=801
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2003240092
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

> On Mon, Mar 23, 2020 at 7:12 PM Heiko Carstens
> <heiko.carstens@de.ibm.com> wrote:
> > we are going to remove hibernate support on s390, since it is
> > - broken since many years
> > - there is no real use case which justifies keeping and maintaining
> >   the code
> >
> > See also https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit/?h=features&id=394216275c7d503d966317da9a01ad6626a6091d
> >
> > This in turn allows also to remove s390 specific hooks in generic
> > power management code (see patch below). The patch below is currently
> > also on the same features branch.
> > I silently assume(d) that you don't mind to get rid of otherwise dead
> > code, or do you have any objections?
> >
> > From 086b2d78375cffe58f5341359bebec0650793811 Mon Sep 17 00:00:00 2001
> > From: Heiko Carstens <heiko.carstens@de.ibm.com>
> > Date: Wed, 18 Mar 2020 20:55:20 +0100
> > Subject: [PATCH] PM: remove s390 specific callbacks
> >
> > ARCH_SAVE_PAGE_KEYS has been introduced in order to be able to save
> > and restore s390 specific storage keys into a hibernation image.
> > With hibernation support removed from s390 there is no point in
> > keeping the callbacks.
> >
> > Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > Acked-by: Peter Oberparleiter <oberpar@linux.ibm.com>
> > Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> > Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> 
> Can I take this patch or would it be better to route it differently?

The patch is already on the s390 features branch and is supposed to be
part of the first pull request for the next merge window (actually the
patch is already in linux-next).
So I'd say the easiest thing would be to route it through the s390 tree.

