Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69EC2332B3D
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 16:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbhCIP4z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 10:56:55 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:63955 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232031AbhCIP4l (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Mar 2021 10:56:41 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1615305401; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=/m2KFCZftUzumg8DPFWYqFDdMycSz9cl+cIGSvANNXM=; b=TM2mnzdGJYyv4KoJdjuJThtiYddeowFfMaoZw6Gp+2IZh88khbBPPSboA2htoYZOyq+1CJ2l
 9jiR6HNC1k/OGDso4tB5KvEBcQLwn2C/mAYEZEmiVQMXCqr5/8Tnk1I8Ao3ofqplDLt4k23+
 T3OOYfwcVY8UVSbUuWuF3gVihc4=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 60479ab3b2591bd568ff3b55 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 Mar 2021 15:56:35
 GMT
Sender: asutoshd=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1E885C43478; Tue,  9 Mar 2021 15:56:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.8.168] (cpe-70-95-149-85.san.res.rr.com [70.95.149.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: asutoshd)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0D314C433CA;
        Tue,  9 Mar 2021 15:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0D314C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=asutoshd@codeaurora.org
Subject: Re: [PATCH v10 1/2] scsi: ufs: Enable power management for wlun
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Adrian Hunter <adrian.hunter@intel.com>, cang@codeaurora.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "open list:TARGET SUBSYSTEM" <linux-scsi@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Bean Huo <beanhuo@micron.com>,
        Lee Jones <lee.jones@linaro.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Satya Tangirala <satyat@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        "moderated list:UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER..." 
        <linux-mediatek@lists.infradead.org>,
        Linux-PM mailing list <linux-pm@vger.kernel.org>
References: <cover.1614725302.git.asutoshd@codeaurora.org>
 <0576d6eae15486740c25767e2d8805f7e94eb79d.1614725302.git.asutoshd@codeaurora.org>
 <85086647-7292-b0a2-d842-290818bd2858@intel.com>
 <6e98724d-2e75-d1fe-188f-a7010f86c509@codeaurora.org>
 <20210306161616.GC74411@rowland.harvard.edu>
 <CAJZ5v0ihJe8rNjWRwNic_BQUvKbALNcjx8iiPAh5nxLhOV9duw@mail.gmail.com>
 <CAJZ5v0iJ4yqRTt=mTCC930HULNFNTgvO4f9ToVO6pNz53kxFkw@mail.gmail.com>
From:   "Asutosh Das (asd)" <asutoshd@codeaurora.org>
Message-ID: <f1e9b21d-1722-d20b-4bae-df7e6ce50bbc@codeaurora.org>
Date:   Tue, 9 Mar 2021 07:56:30 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0iJ4yqRTt=mTCC930HULNFNTgvO4f9ToVO6pNz53kxFkw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 3/8/2021 9:17 AM, Rafael J. Wysocki wrote:
> On Mon, Mar 8, 2021 at 5:21 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Sat, Mar 6, 2021 at 5:17 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>>>
>>> On Fri, Mar 05, 2021 at 06:54:24PM -0800, Asutosh Das (asd) wrote:
>>>
>>>> Now during my testing I see a weird issue sometimes (1 in 7).
>>>> Scenario - bootups
>>>>
>>>> Issue:
>>>> The supplier 'ufs_device_wlun 0:0:0:49488' goes into runtime suspend even
>>>> when one/more of its consumers are in RPM_ACTIVE state.
>>>>
>>>> *Log:
>>>> [   10.056379][  T206] sd 0:0:0:1: [sdb] Synchronizing SCSI cache
>>>> [   10.062497][  T113] sd 0:0:0:5: [sdf] Synchronizing SCSI cache
>>>> [   10.356600][   T32] sd 0:0:0:7: [sdh] Synchronizing SCSI cache
>>>> [   10.362944][  T174] sd 0:0:0:3: [sdd] Synchronizing SCSI cache
>>>> [   10.696627][   T83] sd 0:0:0:2: [sdc] Synchronizing SCSI cache
>>>> [   10.704562][  T170] sd 0:0:0:6: [sdg] Synchronizing SCSI cache
>>>> [   10.980602][    T5] sd 0:0:0:0: [sda] Synchronizing SCSI cache
>>>>
>>>> /** Printing all the consumer nodes of supplier **/
>>>> [   10.987327][    T5] ufs_device_wlun 0:0:0:49488: usage-count @ suspend: 0
>>>> <-- this is the usage_count
>>>> [   10.994440][    T5] ufs_rpmb_wlun 0:0:0:49476: PM state - 2
>>>> [   11.000402][    T5] scsi 0:0:0:49456: PM state - 2
>>>> [   11.005453][    T5] sd 0:0:0:0: PM state - 2
>>>> [   11.009958][    T5] sd 0:0:0:1: PM state - 2
>>>> [   11.014469][    T5] sd 0:0:0:2: PM state - 2
>>>> [   11.019072][    T5] sd 0:0:0:3: PM state - 2
>>>> [   11.023595][    T5] sd 0:0:0:4: PM state - 0 << RPM_ACTIVE
>>>> [   11.353298][    T5] sd 0:0:0:5: PM state - 2
>>>> [   11.357726][    T5] sd 0:0:0:6: PM state - 2
>>>> [   11.362155][    T5] sd 0:0:0:7: PM state - 2
>>>> [   11.366584][    T5] ufshcd-qcom 1d84000.ufshc: __ufshcd_wl_suspend - 8709
>>>> [   11.374366][    T5] ufs_device_wlun 0:0:0:49488: __ufshcd_wl_suspend -
>>>> (0) has rpm_active flags
>>
>> Do you mean that rpm_active of the link between the consumer and the
>> supplier is greater than 0 at this point and the consumer is
> 
> I mean is rpm_active of the link greater than 1 (because 1 means "no
> active references to the supplier")?
Hi Rafael:
No - it is not greater than 1.

I'm trying to understand what's going on in it; will update when I've 
something.

> 
>> RPM_ACTIVE, but the supplier suspends successfully nevertheless?
>>
>>>> [   11.383376][    T5] ufs_device_wlun 0:0:0:49488:
>>>> ufshcd_wl_runtime_suspend <-- Supplier suspends fine.
>>>> [   12.977318][  T174] sd 0:0:0:4: [sde] Synchronizing SCSI cache
>>>>
>>>> And the the suspend of sde is stuck now:
>>>> schedule+0x9c/0xe0
>>>> schedule_timeout+0x40/0x128
>>>> io_schedule_timeout+0x44/0x68
>>>> wait_for_common_io+0x7c/0x100
>>>> wait_for_completion_io+0x14/0x20
>>>> blk_execute_rq+0x90/0xcc
>>>> __scsi_execute+0x104/0x1c4
>>>> sd_sync_cache+0xf8/0x2a0
>>>> sd_suspend_common+0x74/0x11c
>>>> sd_suspend_runtime+0x14/0x20
>>>> scsi_runtime_suspend+0x64/0x94
>>>> __rpm_callback+0x80/0x2a4
>>>> rpm_suspend+0x308/0x614
>>>> pm_runtime_work+0x98/0xa8
>>>>
>>>> I added 'DL_FLAG_RPM_ACTIVE' while creating links.
>>>>        if (hba->sdev_ufs_device) {
>>>>                link = device_link_add(&sdev->sdev_gendev,
>>>>                                    &hba->sdev_ufs_device->sdev_gendev,
>>>>                                   DL_FLAG_PM_RUNTIME|DL_FLAG_RPM_ACTIVE);
>>>> I didn't expect this to resolve the issue anyway and it didn't.
>>>>
>>>> Another interesting point here is when I resume any of the above suspended
>>>> consumers, it all goes back to normal, which is kind of expected. I tried
>>>> resuming the consumer and the supplier is resumed and the supplier is
>>>> suspended when all the consumers are suspended.
>>>>
>>>> Any pointers on this issue please?
>>>>
>>>> @Bart/@Alan - Do you've any pointers please?
>>>
>>> It's very noticeable that although you seem to have isolated a bug in
>>> the power management subsystem (supplier goes into runtime suspend
>>> even when one of its consumers is still active), you did not CC the
>>> power management maintainer or mailing list.
>>>
>>> I have added the appropriate CC's.
>>
>> Thanks Alan!


-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
Linux Foundation Collaborative Project
