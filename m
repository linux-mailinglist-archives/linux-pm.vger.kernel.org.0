Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C4574A538
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jul 2023 22:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjGFUvc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Jul 2023 16:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjGFUvb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Jul 2023 16:51:31 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DF0211F;
        Thu,  6 Jul 2023 13:51:03 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 366JgDUO028412;
        Thu, 6 Jul 2023 20:50:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Ow86IPeS2P48SxpUsI4+hCZTJGz9uazlfacVKlfeEGk=;
 b=baIPh5BgPEMnWEGJzMisamz2PVc0sTQkzwC8MJBuldcdV4YdSZ6WM8Dc62ixHlf2fZTW
 IYuYEb5V+nF8Ca5Ip+wkHe4Cb6+CKjjyBE+ud2DJgbbGTgpgRkCFipjog5Hfv5s+YPnW
 avipwAL5wB6rXwJLrR+6JYWnm4HGI4SxkRcMgU/Fy8DgEOqMBnG3Vxq+Xcsf6vPnQa62
 BzORQ9ryiMuuMV/w4S0TQ55gnbEJtfMu3SQkjbEs/Q9M1XKBEdqDgx34UnJxAsoJWARi
 4vPrWwp5DZtngIWQH4qcsMWvcOHcy60PfCDn5pbWmp9ArXsO6YIuFNZ0J1uPcWEPir6G jQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rntctsdqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 20:50:52 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 366KopFB023628
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Jul 2023 20:50:51 GMT
Received: from [10.134.70.142] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 6 Jul
 2023 13:50:50 -0700
Message-ID: <4d676b7a-3200-2585-3421-393e899a4da6@quicinc.com>
Date:   Thu, 6 Jul 2023 13:50:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Question on platform_suspend_ops::suspend_again() callback
Content-Language: en-US
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>, <pavel@ucw.cz>
CC:     <len.brown@intel.com>, <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, <quic_travitej@quicinc.com>,
        <quic_pdhaval@quicinc.com>,
        Nagamalleswararao Ganji <nganji@quicinc.com>,
        <ulf.hansson@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>,
        "Bjorn Andersson" <quic_bjorande@quicinc.com>
References: <7197a514-5568-2089-f038-2625b88d7e2e@quicinc.com>
In-Reply-To: <7197a514-5568-2089-f038-2625b88d7e2e@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5CK0JW7J7GDTASGGeJUEyNDCzG544O4C
X-Proofpoint-ORIG-GUID: 5CK0JW7J7GDTASGGeJUEyNDCzG544O4C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_15,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=774 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060183
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael / Pavel

Gentle reminder on this  ....

Thanks

Abhinav

On 6/27/2023 3:19 PM, Abhinav Kumar wrote:
> Hi Rafael / Pavel
> 
> I work with the QC display team and help to co-maintain the MSM display 
> sub-system.
> 
> I had a question about the suspend_again() callback in the 
> platform_suspend_ops
> 
> Typical pm_suspend() callflow is like below:
> 
> pm_suspend()
> 
>      ->pm_suspend()
>          ->enter_state()
>              -> suspend_prepare()
>                  -> suspend_freeze_processes()
>                   (freeze all userspace processes)
>              -> suspend_devices_and_enter()
>                  -> dpm_suspend_start()
>                  -> suspend_enter()
>                      -> s2idle_loop
>                      -> dpm_resume_early()
>                      (after breaking out of loop)
> 
>              -> suspend_finish()
>                  -> suspend_thaw_processes()
>                    (unfreeze all userspace processes)
> 
> 
> Now, lets say while we are in s2idle() (typically in the display idle 
> screen use-cases) and then an interrupt fires. We will then break out of 
> the loop and also unfreeze() all usermode processes unless
> we have a suspend_again() callback 
> https://github.com/torvalds/linux/blob/master/kernel/power/suspend.c#L512 due to the suspend_thaw_processes().
> 
> (ignoring the error and wakeup conditions for this discussion)
> 
>  From our profiling it takes about 300ms to wakeup these usermode 
> processes on android (it can vary based on how many processes were 
> running, which OS etc).
> 
> But on an average we can can continue to remain idle for about 300ms 
> more if can skip the usermode process wakeup.
> 
>  From the documentation of the suspend_again() also, it seems that 
> defining this callback would ensure we can address the interrupt and go 
> back to the s2idle instead of waking up usermode processes and trying 
> again after that.
> 
>   * @suspend_again: Returns whether the system should suspend again 
> (true) or
>   *      not (false). If the platform wants to poll sensors or execute some
>   *      code during suspended without invoking userspace and most of 
> devices,
>   *      suspend_again callback is the place assuming that 
> periodic-wakeup or
>   *      alarm-wakeup is already setup. This allows to execute some 
> codes while
>   *      being kept suspended in the view of userland and devices.
>   *
> 
> Questions to you:
> 
> 1) We do not see anyone using this suspend_again() op currently. Has 
> there been any discussion about this before or are there any existing 
> patches in the list which demonstrate a usage? If so, can you pls point 
> us to those?
> 
> 2) If there are no such patches, if we go ahead and add a 
> suspend_again() callback and post it for review, can it be considered 
> for acceptance?
> 
> 3) If suspend_again() callback is not the way to go, can you please 
> suggest an alternative of how we can avoid wakeup of userspace process.
> 
> Just want to make sure that there are no reasons which we are not aware 
> of before attempting this.
> 
> Thanks
> 
> Abhinav
