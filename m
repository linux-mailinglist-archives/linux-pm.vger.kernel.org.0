Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4486C0B69
	for <lists+linux-pm@lfdr.de>; Mon, 20 Mar 2023 08:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjCTHgW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Mar 2023 03:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCTHgV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Mar 2023 03:36:21 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E4DB477
        for <linux-pm@vger.kernel.org>; Mon, 20 Mar 2023 00:36:19 -0700 (PDT)
Received: from dggpeml500004.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Pg61Q33ZqzKsGS;
        Mon, 20 Mar 2023 15:34:02 +0800 (CST)
Received: from [10.174.178.207] (10.174.178.207) by
 dggpeml500004.china.huawei.com (7.185.36.140) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 15:36:17 +0800
Message-ID: <23e5ab97-02e7-b379-2522-7f1d9d7f86ee@huawei.com>
Date:   Mon, 20 Mar 2023 15:36:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] cpufreq: warn about invalid vals to scaling_max/min_freq
 interfaces
Content-Language: en-US
To:     Russell Haley <yumpusamongus@gmail.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <zhangxiaofeng46@huawei.com>,
        <hewenliang4@huawei.com>, <linfeilong@huawei.com>
References: <20230316031549.1343340-1-qinyu32@huawei.com>
 <42aa3ce0-b1a9-5c4c-173a-eb671ea00f71@gmail.com>
From:   qinyu <qinyu32@huawei.com>
In-Reply-To: <42aa3ce0-b1a9-5c4c-173a-eb671ea00f71@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.207]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500004.china.huawei.com (7.185.36.140)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 2023/3/17 19:47, Russell Haley wrote:
> On 3/15/23 22:15, qinyu wrote:
>> When echo an invalid val to scaling_min_freq:
>>> echo 123abc123 > scaling_min_freq
>> It looks weird to have a return val of 0:
>>> echo $?
>>> 0
>>
>> Sane people won't echo strings like that into these interfaces but fuzz
>> tests may do. Also, maybe it's better to inform people if input is invalid
>> or out of range.
> 
> AFAICT, the patch doesn't actually cause it to error if the input is out
> of range. So the commit message should not be worded to imply that it does.
> 
> It is good that it doesn't, I think, because someone might have a
> fail-on-unhandled-error program (ex: shell script) that writes this file
> deployed on hardware with different cpuinfo_max_freq. A new
> unanticipated error would cause such a program to crash where it hadn't
> before.
> 
By saying out of range what I mean is out of range of an unsigned long var, not the frequency range. Sorry for the ambiguous description, I will delete this part and resend the patch.
