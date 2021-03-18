Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83402340DFF
	for <lists+linux-pm@lfdr.de>; Thu, 18 Mar 2021 20:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbhCRTRE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Mar 2021 15:17:04 -0400
Received: from mga06.intel.com ([134.134.136.31]:55918 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232304AbhCRTQv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 18 Mar 2021 15:16:51 -0400
IronPort-SDR: BQlVlVijTs3H3eRO9Vc/yN7zUeSU4roBBf8iKRYFT4/C2iOKKaztBeBgUrnR1uWAvxYER8km2O
 bAXjowdTy9pg==
X-IronPort-AV: E=McAfee;i="6000,8403,9927"; a="251108860"
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; 
   d="scan'208";a="251108860"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2021 12:16:49 -0700
IronPort-SDR: tlY017y2ZGiXSxLvosdq6u4Cu3KxuLj4noSdWMc3URuZDELv0iG+trTQo4xFGPUyo0qOnUrBFq
 76mPUd0jkReA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; 
   d="scan'208";a="606301653"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by fmsmga005.fm.intel.com with ESMTP; 18 Mar 2021 12:16:42 -0700
Subject: Re: [PATCH v10 1/2] scsi: ufs: Enable power management for wlun
To:     "Asutosh Das (asd)" <asutoshd@codeaurora.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Bart Van Assche <bvanassche@acm.org>, cang@codeaurora.org,
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
 <85086647-7292-b0a2-d842-290818bd2858@intel.com>
 <6e98724d-2e75-d1fe-188f-a7010f86c509@codeaurora.org>
 <20210306161616.GC74411@rowland.harvard.edu>
 <CAJZ5v0ihJe8rNjWRwNic_BQUvKbALNcjx8iiPAh5nxLhOV9duw@mail.gmail.com>
 <CAJZ5v0iJ4yqRTt=mTCC930HULNFNTgvO4f9ToVO6pNz53kxFkw@mail.gmail.com>
 <f1e9b21d-1722-d20b-4bae-df7e6ce50bbc@codeaurora.org>
 <2bd90336-18a9-9acd-5abb-5b52b27fc535@codeaurora.org>
 <b13086f3-eea1-51a7-2117-579d520f21fc@intel.com>
 <20cbd52d-7254-3e1c-06a3-712326c99f75@codeaurora.org>
 <c1b38327-fece-4e31-709b-84ec775c6e18@intel.com>
 <ae871d38-4865-5836-d370-e5f9b7be762c@codeaurora.org>
 <24dfb6fc-5d54-6ee2-9195-26428b7ecf8a@intel.com>
 <CAJZ5v0iOT4oi8Ez5xgN9LE0E7J=_Vb7G8a-9etmu+QTvQ1j9ew@mail.gmail.com>
 <d9ea43fd-b065-0e6e-07cb-d6ec6ef97bae@codeaurora.org>
 <CAJZ5v0iTymqf0yRrfvHoxejzKiZ7hnGH+xXYTZhbDait5ULzTQ@mail.gmail.com>
 <36864099-e9a0-83bf-8c9d-d821bb102a72@codeaurora.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <5a01ba2f-81d8-5b0f-6224-d47bd11c9f85@intel.com>
Date:   Thu, 18 Mar 2021 21:16:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <36864099-e9a0-83bf-8c9d-d821bb102a72@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18/03/21 7:58 pm, Asutosh Das (asd) wrote:
> On 3/18/2021 10:54 AM, Rafael J. Wysocki wrote:
>> On Thu, Mar 18, 2021 at 6:33 PM Asutosh Das (asd)
>> <asutoshd@codeaurora.org> wrote:
>>>
>>> On 3/18/2021 7:00 AM, Rafael J. Wysocki wrote:
>>>> On Wed, Mar 17, 2021 at 7:37 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>>
>>>>> On 16/03/21 10:35 pm, Asutosh Das (asd) wrote:
>>>>>> On 3/16/2021 12:48 AM, Adrian Hunter wrote:
>>>>>>> On 16/03/21 12:22 am, Asutosh Das (asd) wrote:
>>>>>>>> On 3/14/2021 1:11 AM, Adrian Hunter wrote:
>>>>>>>>> On 10/03/21 5:04 am, Asutosh Das (asd) wrote:
>>>>>>>>>> On 3/9/2021 7:56 AM, Asutosh Das (asd) wrote:
>>>>>>>>>>> On 3/8/2021 9:17 AM, Rafael J. Wysocki wrote:
>>>>>>>>>>>> On Mon, Mar 8, 2021 at 5:21 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>> On Sat, Mar 6, 2021 at 5:17 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> On Fri, Mar 05, 2021 at 06:54:24PM -0800, Asutosh Das (asd) wrote:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Now during my testing I see a weird issue sometimes (1 in 7).
>>>>>>>>>>>>>>> Scenario - bootups
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Issue:
>>>>>>>>>>>>>>> The supplier 'ufs_device_wlun 0:0:0:49488' goes into runtime suspend even
>>>>>>>>>>>>>>> when one/more of its consumers are in RPM_ACTIVE state.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> *Log:
>>>>>>>>>>>>>>> [   10.056379][  T206] sd 0:0:0:1: [sdb] Synchronizing SCSI cache
>>>>>>>>>>>>>>> [   10.062497][  T113] sd 0:0:0:5: [sdf] Synchronizing SCSI cache
>>>>>>>>>>>>>>> [   10.356600][   T32] sd 0:0:0:7: [sdh] Synchronizing SCSI cache
>>>>>>>>>>>>>>> [   10.362944][  T174] sd 0:0:0:3: [sdd] Synchronizing SCSI cache
>>>>>>>>>>>>>>> [   10.696627][   T83] sd 0:0:0:2: [sdc] Synchronizing SCSI cache
>>>>>>>>>>>>>>> [   10.704562][  T170] sd 0:0:0:6: [sdg] Synchronizing SCSI cache
>>>>>>>>>>>>>>> [   10.980602][    T5] sd 0:0:0:0: [sda] Synchronizing SCSI cache
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> /** Printing all the consumer nodes of supplier **/
>>>>>>>>>>>>>>> [   10.987327][    T5] ufs_device_wlun 0:0:0:49488: usage-count @ suspend: 0
>>>>>>>>>>>>>>> <-- this is the usage_count
>>>>>>>>>>>>>>> [   10.994440][    T5] ufs_rpmb_wlun 0:0:0:49476: PM state - 2
>>>>>>>>>>>>>>> [   11.000402][    T5] scsi 0:0:0:49456: PM state - 2
>>>>>>>>>>>>>>> [   11.005453][    T5] sd 0:0:0:0: PM state - 2
>>>>>>>>>>>>>>> [   11.009958][    T5] sd 0:0:0:1: PM state - 2
>>>>>>>>>>>>>>> [   11.014469][    T5] sd 0:0:0:2: PM state - 2
>>>>>>>>>>>>>>> [   11.019072][    T5] sd 0:0:0:3: PM state - 2
>>>>>>>>>>>>>>> [   11.023595][    T5] sd 0:0:0:4: PM state - 0 << RPM_ACTIVE
>>>>>>>>>>>>>>> [   11.353298][    T5] sd 0:0:0:5: PM state - 2
>>>>>>>>>>>>>>> [   11.357726][    T5] sd 0:0:0:6: PM state - 2
>>>>>>>>>>>>>>> [   11.362155][    T5] sd 0:0:0:7: PM state - 2
>>>>>>>>>>>>>>> [   11.366584][    T5] ufshcd-qcom 1d84000.ufshc: __ufshcd_wl_suspend - 8709
>>>>>>>>>>>>>>> [   11.374366][    T5] ufs_device_wlun 0:0:0:49488: __ufshcd_wl_suspend -
>>>>>>>>>>>>>>> (0) has rpm_active flags
>>>>>>>>>>>>>
>>>>>>>>>>>>> Do you mean that rpm_active of the link between the consumer and the
>>>>>>>>>>>>> supplier is greater than 0 at this point and the consumer is
>>>>>>>>>>>>
>>>>>>>>>>>> I mean is rpm_active of the link greater than 1 (because 1 means "no
>>>>>>>>>>>> active references to the supplier")?
>>>>>>>>>>> Hi Rafael:
>>>>>>>>>>> No - it is not greater than 1.
>>>>>>>>>>>
>>>>>>>>>>> I'm trying to understand what's going on in it; will update when I've something.
>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>> RPM_ACTIVE, but the supplier suspends successfully nevertheless?
>>>>>>>>>>>>>
>>>>>>>>>>>>>>> [   11.383376][    T5] ufs_device_wlun 0:0:0:49488:
>>>>>>>>>>>>>>> ufshcd_wl_runtime_suspend <-- Supplier suspends fine.
>>>>>>>>>>>>>>> [   12.977318][  T174] sd 0:0:0:4: [sde] Synchronizing SCSI cache
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> And the the suspend of sde is stuck now:
>>>>>>>>>>>>>>> schedule+0x9c/0xe0
>>>>>>>>>>>>>>> schedule_timeout+0x40/0x128
>>>>>>>>>>>>>>> io_schedule_timeout+0x44/0x68
>>>>>>>>>>>>>>> wait_for_common_io+0x7c/0x100
>>>>>>>>>>>>>>> wait_for_completion_io+0x14/0x20
>>>>>>>>>>>>>>> blk_execute_rq+0x90/0xcc
>>>>>>>>>>>>>>> __scsi_execute+0x104/0x1c4
>>>>>>>>>>>>>>> sd_sync_cache+0xf8/0x2a0
>>>>>>>>>>>>>>> sd_suspend_common+0x74/0x11c
>>>>>>>>>>>>>>> sd_suspend_runtime+0x14/0x20
>>>>>>>>>>>>>>> scsi_runtime_suspend+0x64/0x94
>>>>>>>>>>>>>>> __rpm_callback+0x80/0x2a4
>>>>>>>>>>>>>>> rpm_suspend+0x308/0x614
>>>>>>>>>>>>>>> pm_runtime_work+0x98/0xa8
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> I added 'DL_FLAG_RPM_ACTIVE' while creating links.
>>>>>>>>>>>>>>>            if (hba->sdev_ufs_device) {
>>>>>>>>>>>>>>>                    link = device_link_add(&sdev->sdev_gendev,
>>>>>>>>>>>>>>>                                        &hba->sdev_ufs_device->sdev_gendev,
>>>>>>>>>>>>>>>                                       DL_FLAG_PM_RUNTIME|DL_FLAG_RPM_ACTIVE);
>>>>>>>>>>>>>>> I didn't expect this to resolve the issue anyway and it didn't.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Another interesting point here is when I resume any of the above suspended
>>>>>>>>>>>>>>> consumers, it all goes back to normal, which is kind of expected. I tried
>>>>>>>>>>>>>>> resuming the consumer and the supplier is resumed and the supplier is
>>>>>>>>>>>>>>> suspended when all the consumers are suspended.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Any pointers on this issue please?
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> @Bart/@Alan - Do you've any pointers please?
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> It's very noticeable that although you seem to have isolated a bug in
>>>>>>>>>>>>>> the power management subsystem (supplier goes into runtime suspend
>>>>>>>>>>>>>> even when one of its consumers is still active), you did not CC the
>>>>>>>>>>>>>> power management maintainer or mailing list.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I have added the appropriate CC's.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Thanks Alan!
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Hello
>>>>>>>>>> I & Can (thanks CanG) debugged this further:
>>>>>>>>>>
>>>>>>>>>> Looks like this issue can occur if the sd probe is asynchronous.
>>>>>>>>>>
>>>>>>>>>> Essentially, the sd_probe() is done asynchronously and driver_probe_device() invokes pm_runtime_get_suppliers() before invoking sd_probe().
>>>>>>>>>>
>>>>>>>>>> But scsi_probe_and_add_lun() runs in a separate context.
>>>>>>>>>> So the scsi_autopm_put_device() invoked from scsi_scan_host() context reduces the link->rpm_active to 1. And sd_probe() invokes scsi_autopm_put_device() and starts a timer. And then driver_probe_device() invoked from __device_attach_async_helper context reduces the link->rpm_active to 1 thus enabling the supplier to suspend before the consumer suspends.
>>>>>>>>>>
>>>>>>>>>> So if:
>>>>>>>>>> Context T1:
>>>>>>>>>> [1] scsi_probe_and_add_lun()
>>>>>>>>>> [2]    |- scsi_autopm_put_device() - reduce the link->rpm_active to 1
>>>>>>>>>>
>>>>>>>>>> Context T2:
>>>>>>>>>> __device_attach_async_helper()
>>>>>>>>>>         |- driver_probe_device()
>>>>>>>>>>             |- sd_probe()
>>>>>>>>>> In between [1] and [2] say, driver_probe_device() -> sd_probe() is invoked in a separate context from __device_attach_async_helper().
>>>>>>>>>> The driver_probe_device() -> pm_runtime_get_suppliers() but [2] would reduce link->rpm_active to 1.
>>>>>>>>>> Then sd_probe() would invoke rpm_resume() and proceed as is.
>>>>>>>>>> When sd_probe() invokes scsi_autopm_put_device() it'd start a timer, dev->power.timer_autosuspends = 1.
>>>>>>>>>>
>>>>>>>>>> Now then, pm_runtime_put_suppliers() is invoked from driver_probe_device() and that makes the link->rpm_active = 1.
>>>>>>>>>> But by now, the corresponding 'sd dev' (consumer) usage_count = 0, state = RPM_ACTIVE and link->rpm_active = 1.
>>>>>>>>>> At this point of time, all other 'sd dev' (consumers) _may_ be suspended or active but would have the link->rpm_active = 1.
>>>>>>>>>
>>>>>>>>> Is this with DL_FLAG_RPM_ACTIVE?  In that case, wouldn't active
>>>>>>>>> consumers have link->rpm_active = 2 and also have incremented
>>>>>>>>> the supplier's usage_count?
>>>>>>
>>>>>> Yes this is with DL_FLAG_RPM_ACTIVE.
>>>>>>
>>>>>> Please let me share a log here:
>>>>>> BEF means - Before, AFT means After.
>>>>>>
>>>>>> [    6.843445][    T7] scsi 0:0:0:4: [UFSDBG]: ufshcd_setup_links:4779:  supp: usage_cnt: 3 Link - 0:0:0:49488 link-rpm_active: 2 avail_luns: 5
>>>>>> [    6.892545][    T7] scsi 0:0:0:4: pm_runtime_get_suppliers: (0:0:0:49488): supp: usage_count: 5 rpm_active: 4
>>>>>>
>>>>>> In the above log, T7 is the context in which this scsi device is being added - scsi_sysfs_add_sdev()
>>>>>>
>>>>>> [    6.931846][    T7] ufs_rpmb_wlun 0:0:0:4: [UFSDBG]: ufshcd_rpmb_probe:9692: invoked
>>>>>> [    6.941246][    T7] scsi 0:0:0:4: pm_runtime_put_suppliers: rpm_active: 4
>>>>>>
>>>>>> [    6.941246][    T7] scsi 0:0:0:4: pm_runtime_put_suppliers: (0:0:0:49488) [BEF] usage_count: 5
>>>>>> [    6.941247][    T7] scsi 0:0:0:4: pm_runtime_put_suppliers: (0:0:0:49488) [AFT] usage_count: 4 rpm_active: 3
>>>>>>
>>>>>> [    6.941267][    T7] scsi 0:0:0:4: rpm_put_suppliers: [BEF] Supp (0:0:0:49488) usage_count: 4 rpm_active: 3
>>>>>>
>>>>>> ------ T196 Context comes in while T7 is running ----------
>>>>>> [    6.941466][  T196] scsi 0:0:0:4: pm_runtime_get_suppliers: (0:0:0:49488): supp: usage_count: 5 rpm_active: 4
>>>>>> --------------------------------------------------------------
>>>>>>
>>>>>> [    7.788397][    T7] scsi 0:0:0:4: rpm_put_suppliers: [AFT] Supp (0:0:0:49488) usage_count: 2 rpm_active: 1
>>>>>
>>>>>
>>>>>
>>>>>>
>>>>>> -- 
>>>>>>
>>>>>> T196 is the context in which sd_probe() is invoked for this scsi device.
>>>>>>
>>>>>> [    7.974410][  T196] sd 0:0:0:4: [sde] Attached SCSI disk
>>>>>> [    7.984188][  T196] sd 0:0:0:4: pm_runtime_put_suppliers: rpm_active: 2
>>>>>> [    7.998424][  T196] sd 0:0:0:4: pm_runtime_put_suppliers: (0:0:0:49488) [BEF] usage_count: 4
>>>>>> [    8.017320][  T196] sd 0:0:0:4: pm_runtime_put_suppliers: (0:0:0:49488) [AFT] usage_count: 1 rpm_active: 1
>>>>>>
>>>>>> The reference to the link is released after sd_probe() is completed.
>>>>>> At this point, the rpm_active should be 2. And the rpm_active should become 1 when sd 0:0:0:4 actually suspends. But at the end of sd_probe() the suspend is only scheduled. However the supplier is now free to suspend.
>>>>>>
>>>>>> In this log, the usage_count of supplier becomes 0 here:
>>>>>> [   11.963885][  T117] sd 0:0:0:7: rpm_put_suppliers: [BEF] Supp (0:0:0:49488) usage_count: 1 rpm_active: 2
>>>>>> [   11.973821][  T117] sd 0:0:0:7: rpm_put_suppliers: [AFT] Supp (0:0:0:49488) usage_count: 0 rpm_active: 1
>>>>>>
>>>>>> However, the consumer sd 0:0:0:4 is still active but has released the reference to the supplier:
>>>>>
>>>>> If that is the case, then it is an error in PM not UFS.
>>>>>
>>>>> A second look at the code around rpm_put_suppliers() does look
>>>>> potentially racy, since there does not appear to be anything
>>>>> stopping the runtime_status changing between
>>>>> spin_unlock_irq(&dev->power.lock) and device_links_read_lock().
>>>>>
>>>>> Rafael, can you comment?
>>>>
>>>> Indeed, if the device is suspending, changing its PM-runtime status to
>>>> RPM_SUSPENDED and dropping its power.lock allows a concurrent
>>>> rpm_resume() to run and resume the device before the suppliers can be
>>>> suspended.
>>>>
>>>> That's incorrect and has been introduced by commit 44cc89f76464 ("PM:
>>>> runtime: Update device status before letting suppliers suspend").
>>>>
>>>> It is probably better to revert that commit and address the original
>>>> issue in a different way.
>>>>
>>> Hello,
>>> One approach to address the original issue could be to prevent the scsi
>>> devices from suspending until the probe is completed, perhaps?
>>
>> I was talking about the original issue that commit 44cc89f76464
>> attempted to address.
>>
>> I'm not sure if and how it is related to the issue you have been debugging.
>>
> Hi Rafael
> Thanks for clarifying that.
> Understood.
> I was referring to the issue that I've been discussing with Adrian.

For test purposes, you could try reverting 44cc89f76464, making the
other changes to the UFS driver, and see if the device_links issue
goes away.
