Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2F7233342B
	for <lists+linux-pm@lfdr.de>; Wed, 10 Mar 2021 05:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbhCJEFa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 23:05:30 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:62246 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231993AbhCJEE7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Mar 2021 23:04:59 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1615349098; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=ZHa7iIF6f1BAN5sS7dr1WZt2PGRaGrl4ziVtXJN3He8=; b=UN6xv/ilirJ3vV+K2S0tanY5vW+PBtmlwcYzBCzRhH0aXX2nPEeVBEP2bPGuz6GhdoDMKL4I
 IhmCr2Ttw1iiUKsb7033qBYw1kGQth70lg8gJaIDuFbHrVIdm+4rh1AXAb3HWcXuGiatviIZ
 gWBrb8t77bWDHeAaYCglyEFN/WU=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 6048456ad3a53bc38fedb79b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 10 Mar 2021 04:04:58
 GMT
Sender: asutoshd=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8C4B0C4346D; Wed, 10 Mar 2021 04:04:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.8.168] (cpe-70-95-149-85.san.res.rr.com [70.95.149.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: asutoshd)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 79864C433C6;
        Wed, 10 Mar 2021 04:04:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 79864C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=asutoshd@codeaurora.org
Subject: Re: [PATCH v10 1/2] scsi: ufs: Enable power management for wlun
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, cang@codeaurora.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "open list:TARGET SUBSYSTEM" <linux-scsi@vger.kernel.org>,
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
 <f1e9b21d-1722-d20b-4bae-df7e6ce50bbc@codeaurora.org>
 <2bd90336-18a9-9acd-5abb-5b52b27fc535@codeaurora.org>
 <20210310031438.GB203516@rowland.harvard.edu>
From:   "Asutosh Das (asd)" <asutoshd@codeaurora.org>
Message-ID: <6b985880-f23a-adb3-8b7a-7ee1b56e6fa7@codeaurora.org>
Date:   Tue, 9 Mar 2021 20:04:53 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210310031438.GB203516@rowland.harvard.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 3/9/2021 7:14 PM, Alan Stern wrote:
> On Tue, Mar 09, 2021 at 07:04:34PM -0800, Asutosh Das (asd) wrote:
>> Hello
>> I & Can (thanks CanG) debugged this further:
>>
>> Looks like this issue can occur if the sd probe is asynchronous.
>>
>> Essentially, the sd_probe() is done asynchronously and driver_probe_device()
>> invokes pm_runtime_get_suppliers() before invoking sd_probe().
>>
>> But scsi_probe_and_add_lun() runs in a separate context.
>> So the scsi_autopm_put_device() invoked from scsi_scan_host() context
>> reduces the link->rpm_active to 1. And sd_probe() invokes
>> scsi_autopm_put_device() and starts a timer. And then driver_probe_device()
>> invoked from __device_attach_async_helper context reduces the
>> link->rpm_active to 1 thus enabling the supplier to suspend before the
>> consumer suspends.
> 
>> I don't see a way around this. Please let me know if you
>> (@Alan/@Bart/@Adrian) have any thoughts on this.
> 
> How about changing the SCSI core so that it does a runtime_get before
> starting an async probe, and the async probe routine does a
> runtime_put when it is finished?  In other words, don't allow a device
> to go into runtime suspend while it is waiting to be probed.
> 
> I don't think that would be too intrusive.
> 
> Alan Stern
> 

Hi Alan
Thanks for the suggestion.

Am trying to understand:

Do you mean something like this:

int scsi_sysfs_add_sdev(struct scsi_device *sdev)
{
	
	scsi_autopm_get_device(sdev);
	pm_runtime_get_noresume(&sdev->sdev_gendev);
	[...]
	scsi_autopm_put_device(sdev);
	[...]
}

static int sd_probe(struct device *dev)
{
	[...]
	pm_runtime_put_noidle(dev);
	scsi_autopm_put_device(sdp);
	[...]
}

This may work (I'm limited by my imagination in scsi layer :) ).

But the pm_runtime_put_noidle() would have to be added to all registered 
scsi_driver{}, perhaps? Or may be I can check for sdp->type?

-asd

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
Linux Foundation Collaborative Project
