Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8303333B3
	for <lists+linux-pm@lfdr.de>; Wed, 10 Mar 2021 04:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbhCJDOn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 22:14:43 -0500
Received: from netrider.rowland.org ([192.131.102.5]:34951 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S231749AbhCJDOl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Mar 2021 22:14:41 -0500
Received: (qmail 203946 invoked by uid 1000); 9 Mar 2021 22:14:38 -0500
Date:   Tue, 9 Mar 2021 22:14:38 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Asutosh Das \(asd\)" <asutoshd@codeaurora.org>
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
Subject: Re: [PATCH v10 1/2] scsi: ufs: Enable power management for wlun
Message-ID: <20210310031438.GB203516@rowland.harvard.edu>
References: <cover.1614725302.git.asutoshd@codeaurora.org>
 <0576d6eae15486740c25767e2d8805f7e94eb79d.1614725302.git.asutoshd@codeaurora.org>
 <85086647-7292-b0a2-d842-290818bd2858@intel.com>
 <6e98724d-2e75-d1fe-188f-a7010f86c509@codeaurora.org>
 <20210306161616.GC74411@rowland.harvard.edu>
 <CAJZ5v0ihJe8rNjWRwNic_BQUvKbALNcjx8iiPAh5nxLhOV9duw@mail.gmail.com>
 <CAJZ5v0iJ4yqRTt=mTCC930HULNFNTgvO4f9ToVO6pNz53kxFkw@mail.gmail.com>
 <f1e9b21d-1722-d20b-4bae-df7e6ce50bbc@codeaurora.org>
 <2bd90336-18a9-9acd-5abb-5b52b27fc535@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bd90336-18a9-9acd-5abb-5b52b27fc535@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 09, 2021 at 07:04:34PM -0800, Asutosh Das (asd) wrote:
> Hello
> I & Can (thanks CanG) debugged this further:
> 
> Looks like this issue can occur if the sd probe is asynchronous.
> 
> Essentially, the sd_probe() is done asynchronously and driver_probe_device()
> invokes pm_runtime_get_suppliers() before invoking sd_probe().
> 
> But scsi_probe_and_add_lun() runs in a separate context.
> So the scsi_autopm_put_device() invoked from scsi_scan_host() context
> reduces the link->rpm_active to 1. And sd_probe() invokes
> scsi_autopm_put_device() and starts a timer. And then driver_probe_device()
> invoked from __device_attach_async_helper context reduces the
> link->rpm_active to 1 thus enabling the supplier to suspend before the
> consumer suspends.

> I don't see a way around this. Please let me know if you
> (@Alan/@Bart/@Adrian) have any thoughts on this.

How about changing the SCSI core so that it does a runtime_get before
starting an async probe, and the async probe routine does a
runtime_put when it is finished?  In other words, don't allow a device
to go into runtime suspend while it is waiting to be probed.

I don't think that would be too intrusive.

Alan Stern
