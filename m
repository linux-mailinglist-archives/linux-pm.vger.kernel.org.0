Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D143BED6A
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jul 2021 19:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhGGRw3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Jul 2021 13:52:29 -0400
Received: from mga14.intel.com ([192.55.52.115]:27096 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230495AbhGGRw2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Jul 2021 13:52:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10037"; a="209171953"
X-IronPort-AV: E=Sophos;i="5.84,221,1620716400"; 
   d="scan'208";a="209171953"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 10:49:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,221,1620716400"; 
   d="scan'208";a="628099852"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.79]) ([10.237.72.79])
  by orsmga005.jf.intel.com with ESMTP; 07 Jul 2021 10:49:44 -0700
Subject: Re: [PATCH RFC 2/2] scsi: ufshcd: Fix device links when BOOT WLUN
 fails to probe
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, Avri Altman <avri.altman@wdc.com>,
        Bean Huo <huobean@gmail.com>, Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210707172948.1025-1-adrian.hunter@intel.com>
 <20210707172948.1025-3-adrian.hunter@intel.com> <YOXm4FuL/CW4lYDZ@kroah.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <66130101-b0c5-a9a3-318a-468c6f3b380f@intel.com>
Date:   Wed, 7 Jul 2021 20:49:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YOXm4FuL/CW4lYDZ@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7/07/21 8:39 pm, Greg Kroah-Hartman wrote:
> On Wed, Jul 07, 2021 at 08:29:48PM +0300, Adrian Hunter wrote:
>> If a LUN fails to probe (e.g. absent BOOT WLUN), the device will not have
>> been registered but can still have a device link holding a reference to the
>> device. The unwanted device link will prevent runtime suspend indefinitely,
>> and cause some warnings if the supplier is ever deleted (e.g. by unbinding
>> the UFS host controller). Fix by explicitly deleting the device link when
>> SCSI destroys the SCSI device.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  drivers/scsi/ufs/ufshcd.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
>> index 708b3b62fc4d..483aa74fe2c8 100644
>> --- a/drivers/scsi/ufs/ufshcd.c
>> +++ b/drivers/scsi/ufs/ufshcd.c
>> @@ -5029,6 +5029,13 @@ static void ufshcd_slave_destroy(struct scsi_device *sdev)
>>  		spin_lock_irqsave(hba->host->host_lock, flags);
>>  		hba->sdev_ufs_device = NULL;
>>  		spin_unlock_irqrestore(hba->host->host_lock, flags);
>> +	} else {
>> +		/*
>> +		 * If a LUN fails to probe (e.g. absent BOOT WLUN), the device
>> +		 * will not have been registered but can still have a device
>> +		 * link holding a reference to the device.
>> +		 */
>> +		device_links_scrap(&sdev->sdev_gendev);
> 
> What created that link?  And why did it do that before probe happened
> successfully?

The same driver created the link.

The documentation seems to say it is allowed to, if it is the consumer.
From Documentation/driver-api/device_link.rst

  Usage
  =====

  The earliest point in time when device links can be added is after
  :c:func:`device_add()` has been called for the supplier and
  :c:func:`device_initialize()` has been called for the consumer.




