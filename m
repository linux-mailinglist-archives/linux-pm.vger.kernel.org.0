Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45B233110A
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2019 17:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfEaPPi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 May 2019 11:15:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34310 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726616AbfEaPPi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 May 2019 11:15:38 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4VFCw2N086840
        for <linux-pm@vger.kernel.org>; Fri, 31 May 2019 11:15:37 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2su57em1e6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Fri, 31 May 2019 11:15:37 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <jejb@linux.ibm.com>;
        Fri, 31 May 2019 16:15:36 +0100
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 31 May 2019 16:15:31 +0100
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4VFFUN811665728
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 May 2019 15:15:30 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A89616A047;
        Fri, 31 May 2019 15:15:30 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F36C56A051;
        Fri, 31 May 2019 15:15:25 +0000 (GMT)
Received: from jarvis.ext.hansenpartnership.com (unknown [9.85.204.144])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 31 May 2019 15:15:25 +0000 (GMT)
Subject: Re: clean some unneeded #ifdef MODULE
From:   James Bottomley <jejb@linux.ibm.com>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org, jdelvare@suse.com,
        linux@roeck-us.net, khalid@gonehiking.org,
        martin.petersen@oracle.com, aacraid@microsemi.com,
        linux-pm@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-scsi@vger.kernel.org
Date:   Fri, 31 May 2019 18:15:24 +0300
In-Reply-To: <1559315344-10384-1-git-send-email-info@metux.net>
References: <1559315344-10384-1-git-send-email-info@metux.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19053115-0036-0000-0000-00000AC5467E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011191; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01211268; UDB=6.00636449; IPR=6.00992305;
 MB=3.00027133; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-31 15:15:34
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19053115-0037-0000-0000-00004C032C0B
Message-Id: <1559315724.2878.7.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-31_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=938 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905310095
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 2019-05-31 at 17:09 +0200, Enrico Weigelt, metux IT consult
wrote:
> Hi folks,
> 
> here're some patches that clean up uncessary cases of #ifdef MODULE.
> These ifdef's just exlude MODULE_DEVICE_TABLE's when the kernel is
> built w/o module support. As MODULE_DEVICE_TABLE() macro already
> checks for that, these extra #ifdef's shouldn't be necessary.

Isn't the problem the #ifdefs are trying to solve a complaint about an
unused variable in the non-module case? if so, is that fixed some other
way?

James

