Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB253DD01C
	for <lists+linux-pm@lfdr.de>; Mon,  2 Aug 2021 07:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbhHBFp2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Aug 2021 01:45:28 -0400
Received: from mga11.intel.com ([192.55.52.93]:50717 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230417AbhHBFp1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Aug 2021 01:45:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10063"; a="210282397"
X-IronPort-AV: E=Sophos;i="5.84,288,1620716400"; 
   d="scan'208";a="210282397"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2021 22:45:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,288,1620716400"; 
   d="scan'208";a="509840578"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.79]) ([10.237.72.79])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Aug 2021 22:44:59 -0700
Subject: Re: [PATCH V4 2/2] scsi: ufshcd: Fix device links when BOOT WLUN
 fails to probe
To:     Avri Altman <Avri.Altman@wdc.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Bean Huo <huobean@gmail.com>, Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Bart Van Assche <bvanassche@acm.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210716114408.17320-1-adrian.hunter@intel.com>
 <20210716114408.17320-3-adrian.hunter@intel.com>
 <DM6PR04MB65758A834069CC7B56669905FC109@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <2a19830e-47cb-4c2a-ddbc-f2370af01452@intel.com>
Date:   Mon, 2 Aug 2021 08:45:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <DM6PR04MB65758A834069CC7B56669905FC109@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17/07/21 9:02 pm, Avri Altman wrote:
>> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
>> index 708b3b62fc4d..9864a8ee0263 100644
>> --- a/drivers/scsi/ufs/ufshcd.c
>> +++ b/drivers/scsi/ufs/ufshcd.c
>> @@ -5020,15 +5020,34 @@ static int ufshcd_slave_configure(struct scsi_device
>> *sdev)
>>  static void ufshcd_slave_destroy(struct scsi_device *sdev)
>>  {
>>         struct ufs_hba *hba;
>> +       unsigned long flags;
>>
>>         hba = shost_priv(sdev->host);
>>         /* Drop the reference as it won't be needed anymore */
>>         if (ufshcd_scsi_to_upiu_lun(sdev->lun) == UFS_UPIU_UFS_DEVICE_WLUN) {
>> -               unsigned long flags;
>> -
>>                 spin_lock_irqsave(hba->host->host_lock, flags);
>>                 hba->sdev_ufs_device = NULL;
>>                 spin_unlock_irqrestore(hba->host->host_lock, flags);
>> +       } else if (hba->sdev_ufs_device) {
>> +               struct device *supplier = NULL;
>> +
>> +               /* Ensure UFS Device WLUN exists and does not disappear */
>> +               spin_lock_irqsave(hba->host->host_lock, flags);
>> +               if (hba->sdev_ufs_device) {
> Was just checked in the outer clause?

Yes, but need to re-check with the spinlock locked.

> 
> Thanks,
> Avri
> 
>> +                       supplier = &hba->sdev_ufs_device->sdev_gendev;
>> +                       get_device(supplier);
>> +               }
>> +               spin_unlock_irqrestore(hba->host->host_lock, flags);
>> +
>> +               if (supplier) {
>> +                       /*
>> +                        * If a LUN fails to probe (e.g. absent BOOT WLUN), the
>> +                        * device will not have been registered but can still
>> +                        * have a device link holding a reference to the device.
>> +                        */
>> +                       device_link_remove(&sdev->sdev_gendev, supplier);
>> +                       put_device(supplier);
>> +               }
>>         }
>>  }
>>
>> --
>> 2.17.1
> 

