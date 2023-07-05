Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAB87481C6
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jul 2023 12:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjGEKNt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jul 2023 06:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjGEKNs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jul 2023 06:13:48 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B66D129
        for <linux-pm@vger.kernel.org>; Wed,  5 Jul 2023 03:13:47 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 365986p5003647;
        Wed, 5 Jul 2023 10:12:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=513dum0RspUpNU4Q/iRiQuy4wnuou9fCtU9m43yGGG4=;
 b=bamS4Ro4XrY03qe42Hqj72f1bzXwy7nc+fKnYb06mRNDDRuSYK5w7ZwLKPCRB7elQUbp
 Ir+CyV5adDY41cnnidnJcE38kH8pYZR1bl08ZUwFrNC/DoYYVejBE9o8DRBsfSUZYwom
 HswMYRF4FQvDMZdvvZIR6w/f9jO3vq6Vs0aCfH5SYxoYDutOsWb6iYeA+pv8ZdorPDxk
 /kXUts1VtixgccHtUWvX6YE3orZ2Q13jRNWNf/lLnh9uREYbiju8K6ex3z5GANkegGAJ
 9uToz0xZ06R18CpuyOi604j2fGGfiyc0POMZj1Zcu8sbaFupM2VhiWukrdfiGIpT8tdw Cg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rn2w58duk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 10:12:51 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 365ACnXt006243
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Jul 2023 10:12:49 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 5 Jul 2023 03:12:43 -0700
Date:   Wed, 5 Jul 2023 15:42:39 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Yan Yankovskyi <yyankovskyi@gmail.com>
CC:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Pavel Machek <pavel@ucw.cz>, <linux-pm@vger.kernel.org>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        Chen Yu <yu.c.chen@intel.com>, Yifan Li <yifan2.li@intel.com>,
        Xueqin Luo <luoxueqin@kylinos.cn>,
        xiongxin <xiongxin@kylinos.cn>,
        Wendy Wang <wendy.wang@intel.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Peter Zijlstra <peterz@infradead.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        kolAflash <kolAflash@kolahilft.de>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Dirk Behme <dirk.behme@de.bosch.com>,
        Aleksandar Momiroski 
        <fixed-term.aleksandar.momiroski@se.bosch.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: Delay on resume from hibernation in swsusp_free()
Message-ID: <3d5e5a63-8336-4902-bd0f-50a8590ca388@quicinc.com>
References: <CAMMwpw3XD+MrOVGkg2WRSVn5ziYfD052MXTZeme6igQA8LwLog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAMMwpw3XD+MrOVGkg2WRSVn5ziYfD052MXTZeme6igQA8LwLog@mail.gmail.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WSteL-PNbvAv7rhvEsvxqzm-TVtPuXmA
X-Proofpoint-GUID: WSteL-PNbvAv7rhvEsvxqzm-TVtPuXmA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_02,2023-07-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1011 spamscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307050088
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 05, 2023 at 11:57:20AM +0200, Yan Yankovskyi wrote:
> Dear Linux community experts,
> 
> I'd like to ask for advice in debugging a problem I'm facing while
> resuming from hibernation.
> Upon entering hibernate() -> hibernation_snapshot() -> swsusp_free(),
> I can see two scenarios:
> * Good case: swsusp_free() takes <100ms to complete;
> * Bad case: swsusp_free() takes ~1,6s to complete;
> 
> I believe the delay is introduced by the do-while loop,
> but it's not certain.
> 
> HW: Qualcomm Snapdragon SA8155P.
> The Kernel version is downstream v5.4.210.
> Unfortunately it's not possible to reproduce this test with a newer
> kernel version, as the use-case is highly tailored to downstream.
> 
> I'm struggling to understand what external factors could contribute
> to this delay, and would be grateful for any opinions.
> 

swsusp_free() is supposed to free all the pages used for creating the
snapshot. AFAICT, it is not doing anything apart from bitmask operations
and freeing pages. I have added some folks that have worked on
hibernation on this qualcomm chipset. Can you also answer the below
questions.

- can you give your .config for your kernel and dmesg logs after the
  restore.

- What are the kernel commandline parameters. In particular do you pass
  param like hibernate=protect_image ?

- What is your good case and bad case. Is it across hibernation/restore
  cycles? 

- would you be able to add printk/debug code around the loop to see if
  any particular page freeing took more time?

Thanks,
Pavan
