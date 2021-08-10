Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D353E7BB0
	for <lists+linux-pm@lfdr.de>; Tue, 10 Aug 2021 17:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241519AbhHJPGa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Aug 2021 11:06:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:46640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231346AbhHJPGa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Aug 2021 11:06:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF5A960EE7;
        Tue, 10 Aug 2021 15:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628607968;
        bh=dqo+NJskWQkpj9z6N8xQUfDVCUEgPwqRUPQ6njYYZIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ioa/h9et+21lof64iWcP5IEezko5Fo8Nqs6H05OAupK1dLhs3GN9D51vWnWrbqE5n
         wT1Wy+cJFuzI5alZMPTwRpfA0mB9YMF/Od757RFP+NeKLfRVrWhgHSe0MNpC5BWscQ
         BqH5kEV/rpZYKkl8BIlTBkXMHmBLcbnkTqXnC1ck=
Date:   Tue, 10 Aug 2021 17:06:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Prasad Sodagudi <psodagud@codeaurora.org>
Cc:     rjw@rjwysocki.net, len.brown@intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        pavel@ucw.cz
Subject: Re: [PATCH v2] PM: sleep: core: Avoid setting power.must_resume to
 false
Message-ID: <YRKV3aYPvQhkL/9m@kroah.com>
References: <1628602932-246733-1-git-send-email-psodagud@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1628602932-246733-1-git-send-email-psodagud@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 10, 2021 at 06:42:11AM -0700, Prasad Sodagudi wrote:
> This is regarding suspend/resume(s2idle) scenario of devices and difference
> between the LTS kernels 5.4 and 5.10 with respect to devices suspend and
> resume. Observing that devices suspended in suspend_late stage are not
> getting resumed in resume_early stage.
> 1) LTS kernel 5.4 kernel do not have this problem but 5.10 kernel
> shows this problem.
> 2) 'commit 6e176bf8d461 ("PM: sleep: core: Do not skip callbacks in the resume phase")'
> is skipping the driver early_resume callbacks.
> 
> In device_resume_early function dev->power.must_resume is used to skip the
> resume call back. It looks this function is expecting that,
> __device_suspend_noirq() would set dev->power.must_resume = true for the
> devices which does not have DPM_FLAG_MAY_SKIP_RESUME flag set.
> 
> 3) Problematic scenario is as follows -  During the device suspend/resume
> scenario all the devices in  the suspend_late stage are successful and some
> device can fail to suspend in suspend_noirq(device_suspend_noirq->
> __device_suspend_noirq) phase.
> As a device failed in dpm_noirq_suspend_devices phase, dpm_resume_noirq is
> getting called to resume devices in dpm_late_early_list in the noirq phase.
> 
> 4) During the Devices_early_resume stage
> dpm_resume_early()-->device_resume_early() functions skipping the devices
> early resume callbacks.
> 799         if (dev_pm_skip_resume(dev))
> 800                  goto Skip;
> 
> 5) Devices suspended in suspend_late stage are not getting resumed in
> Devices_early_resume stage because of
> 'commit 6e176bf8d461 ("PM: sleep: core: Do not skip callbacks in the resume phase")'
> is skipping the driver early_resume callbacks when dev->power.must_resume is false.
> 
> 
> Changelog:
> v1 -> v2:
>  - Fixed indentation comments.
>  - Commit text updated to include scenario.
> 
> Prasad Sodagudi (1):
>   PM: sleep: core: Avoid setting power.must_resume to false
> 
>  drivers/base/power/main.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 

I do not see a patch here, what happened?

:(
