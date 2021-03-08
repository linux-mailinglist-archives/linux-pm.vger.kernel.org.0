Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00B9331343
	for <lists+linux-pm@lfdr.de>; Mon,  8 Mar 2021 17:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbhCHQWA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Mar 2021 11:22:00 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:33733 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbhCHQVg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Mar 2021 11:21:36 -0500
Received: by mail-ot1-f41.google.com with SMTP id j8so9768715otc.0;
        Mon, 08 Mar 2021 08:21:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FdmlwqL/g+B/2VfTk8zhL1WU4aTeHYXEC8DaMHJdgnw=;
        b=FOFuKN17ZrlotkN14U99tcMNzpduEEV9BA6W0Q6lIqO4PaD75KQW5qrgiPzGVccZVq
         LULSR0nTwYalOxgone9uC0iDApB8x1VM+zdLFljgjOn9qey425y26Cbc3scdBhJyaUhj
         CtF6PRvWCxjGccf+fKKWD/KMaSqFRfiEgQXX0LakLB/Xo3Hwr0Do3/ia8x4xdEUjRjd8
         jaDzFzbRvBrT3VHiB3JbmwVJPOH+4o1rtrehosirey+nA4Vn2sYftiD4pUtKZjVjXmPL
         U5nBC0yaUgIDX7P4gZBN+f1jcwHH9s+yVSt0ku31NYpXsFAGvlq59uzCZ1auz7XhV1a+
         v3AA==
X-Gm-Message-State: AOAM533ox2XBrbi2GUMOB0ruX7Jtd3kLmFmwXun4vZOjXUV4XujHEglu
        vNnQaUcVB+KS6otrZf7AK5dcXPdPv1shqVlU2S0=
X-Google-Smtp-Source: ABdhPJxkSm+vRErvxnVdnlfZPOfTP2+5r1iKjR1uFjXEMFxVg4HrI2WE1NCBGCa4i0QyVz0W2ujpGdVl3YJcIP6/4GE=
X-Received: by 2002:a05:6830:1057:: with SMTP id b23mr21103814otp.206.1615220495655;
 Mon, 08 Mar 2021 08:21:35 -0800 (PST)
MIME-Version: 1.0
References: <cover.1614725302.git.asutoshd@codeaurora.org> <0576d6eae15486740c25767e2d8805f7e94eb79d.1614725302.git.asutoshd@codeaurora.org>
 <85086647-7292-b0a2-d842-290818bd2858@intel.com> <6e98724d-2e75-d1fe-188f-a7010f86c509@codeaurora.org>
 <20210306161616.GC74411@rowland.harvard.edu>
In-Reply-To: <20210306161616.GC74411@rowland.harvard.edu>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 8 Mar 2021 17:21:24 +0100
Message-ID: <CAJZ5v0ihJe8rNjWRwNic_BQUvKbALNcjx8iiPAh5nxLhOV9duw@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] scsi: ufs: Enable power management for wlun
To:     Alan Stern <stern@rowland.harvard.edu>,
        "Asutosh Das (asd)" <asutoshd@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Adrian Hunter <adrian.hunter@intel.com>, cang@codeaurora.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "open list:TARGET SUBSYSTEM" <linux-scsi@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Mar 6, 2021 at 5:17 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Fri, Mar 05, 2021 at 06:54:24PM -0800, Asutosh Das (asd) wrote:
>
> > Now during my testing I see a weird issue sometimes (1 in 7).
> > Scenario - bootups
> >
> > Issue:
> > The supplier 'ufs_device_wlun 0:0:0:49488' goes into runtime suspend even
> > when one/more of its consumers are in RPM_ACTIVE state.
> >
> > *Log:
> > [   10.056379][  T206] sd 0:0:0:1: [sdb] Synchronizing SCSI cache
> > [   10.062497][  T113] sd 0:0:0:5: [sdf] Synchronizing SCSI cache
> > [   10.356600][   T32] sd 0:0:0:7: [sdh] Synchronizing SCSI cache
> > [   10.362944][  T174] sd 0:0:0:3: [sdd] Synchronizing SCSI cache
> > [   10.696627][   T83] sd 0:0:0:2: [sdc] Synchronizing SCSI cache
> > [   10.704562][  T170] sd 0:0:0:6: [sdg] Synchronizing SCSI cache
> > [   10.980602][    T5] sd 0:0:0:0: [sda] Synchronizing SCSI cache
> >
> > /** Printing all the consumer nodes of supplier **/
> > [   10.987327][    T5] ufs_device_wlun 0:0:0:49488: usage-count @ suspend: 0
> > <-- this is the usage_count
> > [   10.994440][    T5] ufs_rpmb_wlun 0:0:0:49476: PM state - 2
> > [   11.000402][    T5] scsi 0:0:0:49456: PM state - 2
> > [   11.005453][    T5] sd 0:0:0:0: PM state - 2
> > [   11.009958][    T5] sd 0:0:0:1: PM state - 2
> > [   11.014469][    T5] sd 0:0:0:2: PM state - 2
> > [   11.019072][    T5] sd 0:0:0:3: PM state - 2
> > [   11.023595][    T5] sd 0:0:0:4: PM state - 0 << RPM_ACTIVE
> > [   11.353298][    T5] sd 0:0:0:5: PM state - 2
> > [   11.357726][    T5] sd 0:0:0:6: PM state - 2
> > [   11.362155][    T5] sd 0:0:0:7: PM state - 2
> > [   11.366584][    T5] ufshcd-qcom 1d84000.ufshc: __ufshcd_wl_suspend - 8709
> > [   11.374366][    T5] ufs_device_wlun 0:0:0:49488: __ufshcd_wl_suspend -
> > (0) has rpm_active flags

Do you mean that rpm_active of the link between the consumer and the
supplier is greater than 0 at this point and the consumer is
RPM_ACTIVE, but the supplier suspends successfully nevertheless?

> > [   11.383376][    T5] ufs_device_wlun 0:0:0:49488:
> > ufshcd_wl_runtime_suspend <-- Supplier suspends fine.
> > [   12.977318][  T174] sd 0:0:0:4: [sde] Synchronizing SCSI cache
> >
> > And the the suspend of sde is stuck now:
> > schedule+0x9c/0xe0
> > schedule_timeout+0x40/0x128
> > io_schedule_timeout+0x44/0x68
> > wait_for_common_io+0x7c/0x100
> > wait_for_completion_io+0x14/0x20
> > blk_execute_rq+0x90/0xcc
> > __scsi_execute+0x104/0x1c4
> > sd_sync_cache+0xf8/0x2a0
> > sd_suspend_common+0x74/0x11c
> > sd_suspend_runtime+0x14/0x20
> > scsi_runtime_suspend+0x64/0x94
> > __rpm_callback+0x80/0x2a4
> > rpm_suspend+0x308/0x614
> > pm_runtime_work+0x98/0xa8
> >
> > I added 'DL_FLAG_RPM_ACTIVE' while creating links.
> >       if (hba->sdev_ufs_device) {
> >               link = device_link_add(&sdev->sdev_gendev,
> >                                   &hba->sdev_ufs_device->sdev_gendev,
> >                                  DL_FLAG_PM_RUNTIME|DL_FLAG_RPM_ACTIVE);
> > I didn't expect this to resolve the issue anyway and it didn't.
> >
> > Another interesting point here is when I resume any of the above suspended
> > consumers, it all goes back to normal, which is kind of expected. I tried
> > resuming the consumer and the supplier is resumed and the supplier is
> > suspended when all the consumers are suspended.
> >
> > Any pointers on this issue please?
> >
> > @Bart/@Alan - Do you've any pointers please?
>
> It's very noticeable that although you seem to have isolated a bug in
> the power management subsystem (supplier goes into runtime suspend
> even when one of its consumers is still active), you did not CC the
> power management maintainer or mailing list.
>
> I have added the appropriate CC's.

Thanks Alan!
