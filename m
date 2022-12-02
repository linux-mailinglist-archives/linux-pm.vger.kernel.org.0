Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36AEB6405A3
	for <lists+linux-pm@lfdr.de>; Fri,  2 Dec 2022 12:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbiLBLSO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Dec 2022 06:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233094AbiLBLSI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Dec 2022 06:18:08 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8975F7F8A7
        for <linux-pm@vger.kernel.org>; Fri,  2 Dec 2022 03:18:06 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B29renV028801;
        Fri, 2 Dec 2022 11:17:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=w8QnfNkid6UTnNGXM21duE5bA1AQOmkNrsrwQVgCEB8=;
 b=Gc7FGUPtcHp6MCwzxNzKEg4ahmsnSgL1Jj6wPiF8aBuvepcbhvvS6sshOiVhHa15CY0P
 xe9stdnXPz2TxEFNkbWt4sBNTIZJCXWTTXsv5hVF66yT88NRRQVlNFOAtQ11abrw3bgF
 vFCwQw5o9KgiYouK8P3EMgJJaebBpvPScwuAwyzn1YsrKXW7VveXIikiHXDU+XaXqTlW
 NGz48QNP70o1DyuH/Sml41xa09sCMC1OhtVEP7hnHztqO6GmGk5jJ8nlTRZ/r9e8PQ9e
 ACPw87d05K7HTgF13zz3rcipYaRObLOQfJRVfylfJV2zew5is3xnIUVau0r/KnX5EIO7 sw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m77x1v9u3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Dec 2022 11:17:59 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2B2BEZJq011569;
        Fri, 2 Dec 2022 11:17:58 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m77x1v9tb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Dec 2022 11:17:58 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2B2B6Ao3010110;
        Fri, 2 Dec 2022 11:17:56 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 3m3ae8xk44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Dec 2022 11:17:55 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2B2BBJC94784708
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Dec 2022 11:11:19 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 912E3AE053;
        Fri,  2 Dec 2022 11:17:53 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4829AE051;
        Fri,  2 Dec 2022 11:17:51 +0000 (GMT)
Received: from drishya.in.ibm.com (unknown [9.109.202.50])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  2 Dec 2022 11:17:51 +0000 (GMT)
Date:   Fri, 2 Dec 2022 16:47:41 +0530
From:   Vaidyanathan Srinivasan <svaidy@linux.ibm.com>
To:     Vishal Chourasia <vishalc@linux.vnet.ibm.com>
Cc:     Aboorva Devarajan <aboorvad@linux.vnet.ibm.com>,
        srikar@linux.vnet.ibm.com, rafael@kernel.org,
        linux-pm@vger.kernel.org, daniel.lezcano@linaro.org,
        npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powerpc/cpuidle: Set CPUIDLE_FLAG_POLLING for snooze
 state
Message-ID: <Y4ne1Yzab02YHlxn@drishya.in.ibm.com>
Reply-To: svaidy@linux.ibm.com
References: <20221114073154.30407-1-aboorvad@linux.vnet.ibm.com>
 <20221114145611.37669-1-aboorvad@linux.vnet.ibm.com>
 <Y3iYsI8FFkwTFfPO@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Y3iYsI8FFkwTFfPO@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: e0a69plKNKMnOU-XrbgzHZRALQU0DOas
X-Proofpoint-GUID: kqUPPTppsA7ThScTuKWdZQldNE16p_yb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-02_04,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 adultscore=0 spamscore=0 priorityscore=1501 clxscore=1011 impostorscore=0
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212020086
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Vishal Chourasia <vishalc@linux.vnet.ibm.com> [2022-11-19 14:19:52]:

> On Mon, Nov 14, 2022 at 08:26:11PM +0530, Aboorva Devarajan wrote:
> > During the comparative study of cpuidle governors, it is noticed that the
> > menu governor does not select CEDE state in some scenarios even though when
> > the sleep duration of the CPU exceeds the target residency of the CEDE idle
> > state this is because the CPU exits the snooze "polling" state when snooze
> > time limit is reached in the snooze_loop(), which is not a real wake up
> > and it just means that the polling state selection was not adequate.
> > 
> > cpuidle governors rely on CPUIDLE_FLAG_POLLING flag to be set for the
> > polling states to handle the condition mentioned above.
> > 
> > Hence, set the CPUIDLE_FLAG_POLLING flag for snooze state (polling state)
> > in powerpc arch to make the cpuidle governor work as expected.
> > 
> > Reference Commits:
> > 
> > - Timeout enabled for snooze state:
> >   commit 78eaa10f027c
> >   ("cpuidle: powernv/pseries: Auto-promotion of snooze to deeper idle state")
> > 
> > - commit dc2251bf98c6
> >   ("cpuidle: Eliminate the CPUIDLE_DRIVER_STATE_START symbol")
> > 
> > - Fix wakeup stats in governor for polling states
> >   commit 5f26bdceb9c0
> >   ("cpuidle: menu: Fix wakeup statistics updates for polling state")
> > 
> > Signed-off-by: Aboorva Devarajan <aboorvad@linux.vnet.ibm.com>
> > ---
> > 
> > Changelog: (v1 -> v2)
> > 
> > Added CPUIDLE_POLLING_FLAG to the correct cpuidle_state struct.
> > 
> > Previous version of the patch is stale which was sent by mistake, this 
> > is the correct version which is tested on powernv, pseries (shared and 
> > dedicated partitions)
> > 
> >  drivers/cpuidle/cpuidle-powernv.c | 5 ++++-
> >  drivers/cpuidle/cpuidle-pseries.c | 8 ++++++--
> >  2 files changed, 10 insertions(+), 3 deletions(-)

Hi Aboorva,

Thanks for the patch. This fixes the unpredictable idle state
selection issue under differ idle interval patterns.

Reviewed-by: Vaidyanathan Srinivasan <svaidy@linux.ibm.com>

--Vaidy

