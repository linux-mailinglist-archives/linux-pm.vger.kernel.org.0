Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8172B7684
	for <lists+linux-pm@lfdr.de>; Wed, 18 Nov 2020 07:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgKRGx4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Nov 2020 01:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgKRGxz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Nov 2020 01:53:55 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861B7C061A4D
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2020 22:53:55 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id w8so974475ybq.4
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2020 22:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:mime-version:message-id:date:subject:from:to:cc;
        bh=lYxi6V4AwXuK11wzjloSmKc5wDxn+VtI80uFADH0oBo=;
        b=EZwMWMWBJ3RTKa1dGgqNG8Dn2tO+WJT6QVngf28ljyZWoVZTL8PyZ8AM9X7b0Y9rH1
         l/hCkjS8oRFrunmw5MMza+9AVVhvUm6XwCzxj4aHVRqf1Rr0fsUPNuI8B8stErZKeyew
         7aGaKAbdx+jyGPsN4kL4a3Rs5h1vZ0+eHjOMocv6+KV3AD2dNixFvKc1FapeFu6X/5JU
         0Z+bxvuK/dq18CvSl6MO+mZBEJMBJj135nDRT/Q676Xs95zpDqb6uXyjR7EGRJh+ONLX
         Mc3+Qlp8/LxjkH9fk6u2wQfx9MWVDN4tvD/gsiLyG5loyRg8It51wa6yEQDCbTVCaVPA
         waKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:mime-version:message-id:date:subject:from
         :to:cc;
        bh=lYxi6V4AwXuK11wzjloSmKc5wDxn+VtI80uFADH0oBo=;
        b=qutPAmxClUT78KFYp2eiiQU+H1I5iggNn7voerMDA6cjl23wfOxPeybxv925ovWbtx
         gonNS460cRCRsUbef/xhKs8l2uFSJk/0xKcd+ikxCltdOXXfPIcrr3mIvnVbNunQUogC
         lc8vWJUh5lpqLXzQTYz8pTY3eSs/Brw21qKw/BueSS1gbR2Ki/MsylSdkD9h4LzlljMC
         qYtII8pQyj13WSbSmLbaQGVZApZHh9W8U+QMjhc2M8IcRvFXcnBybLsEFhJlgTflcpLr
         d1pzsZlnB+uD+yiDnujHqDi1jk6AmKVF7xeQ9eKKbbotwX8d37VTSWtu6a8d7UeSoGoc
         JDEg==
X-Gm-Message-State: AOAM530K3wv92Mr+43uSXECbBZvhsancxvEOYOiKtUfOwp9M2++3rudp
        EC2XO8em8D1Ntcdyad7uNnuj5Az8xr9ffXq5
X-Google-Smtp-Source: ABdhPJzIo2uFUNiLHns1Yfv+CT1C8FDvVwC6eqy1M8lGa1euZ9++HPWS8I/TWJ7qYaykqJndfBJmAySvAMABFASY
Sender: "josephjang via sendgmr" 
        <josephjang@josephjang-p920.ntc.corp.google.com>
MIME-Version: 1.0
X-Received: from josephjang-p920.ntc.corp.google.com ([2401:fa00:fc:1:7220:84ff:fe09:41e0])
 (user=josephjang job=sendgmr) by 2002:a25:6804:: with SMTP id
 d4mr5290078ybc.379.1605682434707; Tue, 17 Nov 2020 22:53:54 -0800 (PST)
Message-ID: <00000000000025043f05b45c1367@google.com>
Date:   Wed, 18 Nov 2020 06:53:54 +0000
Subject: [PATCH v3] power: suspend: Move dpm_watchdog to suspend.c and enhance it
From:   <josephjang@google.com>
To:     rafael@kernel.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net,
        pavel@ucw.cz, len.brown@intel.com, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        jonglin@google.com, woodylin@google.com, markcheng@google.com,
        josephjang@google.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> On Fri, Nov 13, 2020 at 2:26 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Oct 23, 2020 at 02:04:17PM +0800, Joseph Jang wrote:
> > > Since dpm_watchdog just cover device power management, we proposed to
> > > move it to core power suspend.c to cover not only device power  
> management
> > > hang issues, but also core power management hand issues.
> > >
> > > Since dpm_watchdog stands for device pm, we propose to use new name  
> sleep
> > > timer and new timeout handler to cover more sleep hang issues. The new
> > > timeout handler will dump disk sleep task at first round timeout and
> > > trigger kernel panic at second round timeout.
> > > The default timer for each round is defined in
> > > CONFIG_PM_SLEEP_TIMER_TIMEOUT.
> > >
> > > Signed-off-by: Joseph Jang <josephjang@google.com>
> >
> > It still seems odd you can't use a watchdog for this, as you really have
> > just implemented the same thing here, but "open coded" the logic.
> >
> > I'll let Rafael chime in here too, as he knows this area much better
> > than I as to if this is viable or not.

> It is viable AFAICS.

> Just make the existing thing work with dev == NULL and use it as needed.

Thank you Greg and Rafael code review and good suggestions.

Since dpm_watchdog just covers two functions __device_suspend() and  
device_resume().
We still don't know how to use current dpm_watchdog to capture other  
suspend hang cases
outside these two functions. So we are trying to enhance it by moving  
dpm_watchdog from
"drivers/base/power/main.c" to "kernel/power/suspend.c" and enable/disable  
the watchdog
in more core pm functions.
Could you help to review if we can do that or not? If not, could you help  
to give us
other better suggestions?

If you agree to do that, I will provide a new PATCH version 4 to fix all  
coding problems
later.


Thank you,
Joseph.
