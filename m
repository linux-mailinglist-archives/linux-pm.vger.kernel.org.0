Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04963C16BB
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jul 2021 18:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbhGHQF0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Jul 2021 12:05:26 -0400
Received: from mga02.intel.com ([134.134.136.20]:39679 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229592AbhGHQF0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Jul 2021 12:05:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10039"; a="196707792"
X-IronPort-AV: E=Sophos;i="5.84,224,1620716400"; 
   d="scan'208";a="196707792"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2021 09:02:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,224,1620716400"; 
   d="scan'208";a="628562316"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.79]) ([10.237.72.79])
  by orsmga005.jf.intel.com with ESMTP; 08 Jul 2021 09:02:29 -0700
Subject: Re: [PATCH RFC 2/2] scsi: ufshcd: Fix device links when BOOT WLUN
 fails to probe
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "open list:TARGET SUBSYSTEM" <linux-scsi@vger.kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <huobean@gmail.com>, Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210707172948.1025-1-adrian.hunter@intel.com>
 <20210707172948.1025-3-adrian.hunter@intel.com> <YOXm4FuL/CW4lYDZ@kroah.com>
 <66130101-b0c5-a9a3-318a-468c6f3b380f@intel.com>
 <CAJZ5v0hfEE=ney1tH5MtQm0KWs4U2yzy_DqAAW7hTyxxx2-cNg@mail.gmail.com>
 <c3ec3ca2-220f-9e5a-e2ce-b1c2be86c97c@intel.com>
 <CAJZ5v0hXR+ZsjKP1BUrOEXDFfD3ha=w90bExrx5qhTrOG16Ksw@mail.gmail.com>
 <CAJZ5v0igHZ+cj7F-pMZEtNjG+UkRE-jUNC7m7e2vsZfasZLY5A@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <4bb516f8-d987-dc4a-5e32-8db827ac486b@intel.com>
Date:   Thu, 8 Jul 2021 19:02:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0igHZ+cj7F-pMZEtNjG+UkRE-jUNC7m7e2vsZfasZLY5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 8/07/21 6:12 pm, Rafael J. Wysocki wrote:
> On Thu, Jul 8, 2021 at 5:03 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Thu, Jul 8, 2021 at 4:17 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>
>>> On 8/07/21 3:31 pm, Rafael J. Wysocki wrote:
>>>> On Wed, Jul 7, 2021 at 7:49 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>>
>>>>> On 7/07/21 8:39 pm, Greg Kroah-Hartman wrote:
>>>>>> On Wed, Jul 07, 2021 at 08:29:48PM +0300, Adrian Hunter wrote:
>>>>>>> If a LUN fails to probe (e.g. absent BOOT WLUN), the device will not have
>>>>>>> been registered but can still have a device link holding a reference to the
>>>>>>> device. The unwanted device link will prevent runtime suspend indefinitely,
>>>>>>> and cause some warnings if the supplier is ever deleted (e.g. by unbinding
>>>>>>> the UFS host controller). Fix by explicitly deleting the device link when
>>>>>>> SCSI destroys the SCSI device.
>>>>>>>
>>>>>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>>>>>> ---
>>>>>>>  drivers/scsi/ufs/ufshcd.c | 7 +++++++
>>>>>>>  1 file changed, 7 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
>>>>>>> index 708b3b62fc4d..483aa74fe2c8 100644
>>>>>>> --- a/drivers/scsi/ufs/ufshcd.c
>>>>>>> +++ b/drivers/scsi/ufs/ufshcd.c
>>>>>>> @@ -5029,6 +5029,13 @@ static void ufshcd_slave_destroy(struct scsi_device *sdev)
>>>>>>>              spin_lock_irqsave(hba->host->host_lock, flags);
>>>>>>>              hba->sdev_ufs_device = NULL;
>>>>>>>              spin_unlock_irqrestore(hba->host->host_lock, flags);
>>>>>>> +    } else {
>>>>>>> +            /*
>>>>>>> +             * If a LUN fails to probe (e.g. absent BOOT WLUN), the device
>>>>>>> +             * will not have been registered but can still have a device
>>>>>>> +             * link holding a reference to the device.
>>>>>>> +             */
>>>>>>> +            device_links_scrap(&sdev->sdev_gendev);
>>>>>>
>>>>>> What created that link?  And why did it do that before probe happened
>>>>>> successfully?
>>>>>
>>>>> The same driver created the link.
>>>>>
>>>>> The documentation seems to say it is allowed to, if it is the consumer.
>>>>> From Documentation/driver-api/device_link.rst
>>>>>
>>>>>   Usage
>>>>>   =====
>>>>>
>>>>>   The earliest point in time when device links can be added is after
>>>>>   :c:func:`device_add()` has been called for the supplier and
>>>>>   :c:func:`device_initialize()` has been called for the consumer.
>>>>
>>>> Yes, this is allowed, but if you've added device links to a device
>>>> object that is not going to be registered after all, you are
>>>> responsible for doing the cleanup.
>>>>
>>>> Why can't you call device_link_del() directly on those links?
>>>>
>>>> Or device_link_remove() if you don't want to deal with link pointers?
>>>>
>>>
>>> Those only work for DL_FLAG_STATELESS device links, but we use only
>>> DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE flags.
>>
>> So I'd probably modify device_link_remove() to check if the consumer
>> device has been registered and run __device_link_del() directly
>> instead of device_link_put_kref() if it hasn't.
>>
>> Or add an argument to it to force the removal.
> 
> Or even modify device_link_put_kref() like this:
> 
>  static void device_link_put_kref(struct device_link *link)
>  {
>           if (link->flags & DL_FLAG_STATELESS)
>                   kref_put(&link->kref, __device_link_del);
> +        else if (!device_is_registered(link->consumer))
> +                __device_link_del(link);
>           else
>                  WARN(1, "Unable to drop a managed device link reference\n");
>  }
> 

Thanks! :-) I will do that.
