Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEEB294C24
	for <lists+linux-pm@lfdr.de>; Wed, 21 Oct 2020 14:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442155AbgJUMBh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Oct 2020 08:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411036AbgJUMBg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Oct 2020 08:01:36 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA97C0613CE
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2020 05:01:35 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v4so2133000ybp.3
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2020 05:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:mime-version:message-id:date:subject:from:to:cc;
        bh=NtX8N0ZwPWqt161nUJghfJ5S9WiPRYMaStD0fa9b8Ls=;
        b=Qrz/UTHr2eqVfhRfH2KPLorwzlHcbr0qKCdVsYnS7EnQ03y8QCwwUapjiqO24UTUXj
         pi3VchcUQubLIXagI+RejWFr/+kk6Zpx83iVgi7xKOuD12lDcW3X7Pm3u3GFCwieEruA
         ct4q8quNID6A1eubQmdbnnCVha+x9I+X//qh06tOzqOHxs7m5KwDIWOW8LFGhQjvYwO/
         bbQ1U2AfIPhN9LQVSd/XOkOGGi8/mR+7DmApZqWIHcTOGylaUyHkOZki3wt8vPWKCyNy
         MsEfkOwWcrz3M+pPdUI3ozZU/R02tmVJiDF+Dnb+HxbKOtWA1D6iWpeVqJwU8uJEwpEh
         Zs9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:mime-version:message-id:date:subject:from
         :to:cc;
        bh=NtX8N0ZwPWqt161nUJghfJ5S9WiPRYMaStD0fa9b8Ls=;
        b=ApqCVyCtEofMArSLsuOje+lU+Z3lHMM4hMe7mDTG2Eum9JACswfNxOcXJ+51FU5rIc
         sXZrXq9I6vpy7nSCRBr2+9QuejTuHxpiGmWAhwRV4BICbXZBZXpqtmUHeHpRyncrWn4V
         XC6XBdBMh/QaopdJVlW3+oBWTyykwrgY7LznKcXnNr1uJiNpIG9yBDio/z7aBo3egaeQ
         LY9ey/XBf8so9q1K45UrQm881qFIDcoI0tRMceXQt1aiAMfy8M9L9xyxjCTRTvyuLm5H
         hBB2+ox4Ap9lW4rfwNV5S/lJy/CzPsNg9VB6PHKx8ZCGoCEJtDBOp/KRiTDBNHDdRtvX
         2C4g==
X-Gm-Message-State: AOAM533kzu/o6jbod1ljtHLbvPVFhDUu1gjkRvyrmJ14/pSUvtzVSiTa
        lE5iVUN8ilv8BkQbWKBZrFcnsx97PRF9IWwb
X-Google-Smtp-Source: ABdhPJywhhG1/GpKfHVj3dBZHUog+H4MQCzTB5fIVSlGEud95Ro60tjNLFPwdzENLHk8x6JWSo6SOw5zs0ijrKYm
Sender: "josephjang via sendgmr" 
        <josephjang@josephjang-p920.ntc.corp.google.com>
MIME-Version: 1.0
X-Received: from josephjang-p920.ntc.corp.google.com ([2401:fa00:fc:1:7220:84ff:fe09:41e0])
 (user=josephjang job=sendgmr) by 2002:a25:cbc7:: with SMTP id
 b190mr4537165ybg.288.1603281694224; Wed, 21 Oct 2020 05:01:34 -0700 (PDT)
Message-ID: <000000000000dc600005b22d1bea@google.com>
Date:   Wed, 21 Oct 2020 12:01:34 +0000
Subject: [PATCH v2] power: suspend: Replace dpm_watchdog by sleep timer
From:   <josephjang@google.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, rjw@rjwysocki.net,
        pavel@ucw.cz, len.brown@intel.com, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        jonglin@google.com, woodylin@google.com, markcheng@google.com,
        josephjang@google.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> > On Wed, Oct 21, 2020 at 4:09 AM Joseph Jang <josephjang@google.com>  
> wrote:
> > >
> > > Since dpm_watchdog just cover device power management, we proposed  
> sleep
> > > timer to cover not only device power management hang issues, but also
> > > core power management hand issue.
> > >
> > > Add sleep timer and timeout handler to prevent device stuck during  
> suspend/
> > > resume process. The timeout handler will dump disk sleep task at first
> > > round timeout and trigger kernel panic at second round timeout.
> > > The default timer for each round is defined in
> > > CONFIG_PM_SLEEP_TIMER_TIMEOUT.
> >
> > Let me repeat the point that Greg has made already: Please don't
> > replace the existing watchdog with something else, but try to extend
> > it to cover your use case.
> >
> > As it stands, the patch is not applicable IMV.
> >
> > Thanks!

> Thank you Rafael's promptly response.
> Since dmp_watchdog was implement in drivers/base/power/main.c and it use  
> stack memory for timer struct.
> It is a little bit hard to use its API in kernel/power/suspend.c.
> And from the call flow, we prefer to start/stop watchog timer in  
> suspend.c only. It will also cover device
> power management as well.

> If you don't want to change Kconfig, I can keep original DPM_WATCHDOG.
> But it is not easy to extend driver base API into core power base. Am I  
> correct?

> If you have some suggestion, please feel free to let me know, I will  
> follow up.

> Thank you,
> Joseph.


Let me try to explain why cannot use current dpm_watchdog API, because it  
use stack memory and has limitation.

/**
  * dpm_watchdog_set - Enable pm watchdog for given device.
  * @wd: Watchdog. Must be allocated on the stack.
  * @dev: Device to handle.
  */
static void dpm_watchdog_set(struct dpm_watchdog *wd, struct device *dev)
{
	struct timer_list *timer = &wd->timer;

	wd->dev = dev;
	wd->tsk = current;

	timer_setup_on_stack(timer, dpm_watchdog_handler, 0);  <== setup timer on  
stack memory ....
	/* use same timeout value for both suspend and resume */
	timer->expires = jiffies + HZ * CONFIG_DPM_WATCHDOG_TIMEOUT;
	add_timer(timer);
}


If you could take a look at my patch again, you can see we need to start  
watchdog at end of function like s2idle_enter().
We cannot use stack memory for timer because it will be free when go back  
to caller.
That is why I am creating new API to start/stop watchdog timer which use  
global memory.

  /**
   * pm_suspend_default_s2idle - Check if suspend-to-idle is the default  
suspend.
   *
@@ -89,6 +92,8 @@ static void s2idle_enter(void)
  {
  	trace_suspend_resume(TPS("machine_suspend"), PM_SUSPEND_TO_IDLE, true);

+	stop_sleep_timer(&st);
+
  	raw_spin_lock_irq(&s2idle_lock);
  	if (pm_wakeup_pending())
  		goto out;
@@ -114,6 +119,8 @@ static void s2idle_enter(void)
  	s2idle_state = S2IDLE_STATE_NONE;
  	raw_spin_unlock_irq(&s2idle_lock);

+	start_sleep_timer(&st);
+
  	trace_suspend_resume(TPS("machine_suspend"), PM_SUSPEND_TO_IDLE, false);
  }


Base on that, could you help to review if we could create new API to  
start/stop watchdog timer for core power management?

Thank you,
Joseph.
