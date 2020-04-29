Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4E3B1BDA0A
	for <lists+linux-pm@lfdr.de>; Wed, 29 Apr 2020 12:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgD2Kqg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Apr 2020 06:46:36 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43463 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbgD2Kqg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2020 06:46:36 -0400
Received: by mail-oi1-f194.google.com with SMTP id j16so1352074oih.10
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2020 03:46:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xFy+5OoyrxMaNi3ASOSeuGwdPxvzINJ+5tjk9/70WZQ=;
        b=L64sAQyaDksl9beE67VkTQ3kfKkz0pHJu9wxi5mUktn1PKN/ZsUUT1CxTHkvv73svJ
         4/bk8djci/1GRrzT9mjkZD5OUZyZbDTq7x6BN9JkI07qsedcrZ0MCzw2O+/RopOdM7AC
         vs6kyTijZjwFeYil+VpJuiAAwB3zkJz2CXGr41Skp+U75UyrhUhK4ZfHOWn+LMv050S3
         px9C/BIP7G8TRpGgXQfeF6NXNZgfg3kE2GqHWEIMwc2OOn3li0gyMCLME3F3cUXTVpsu
         512j7ndnJsXmqujF4MneL1dNjetsD7hMDWDkXogKvgLDZHQ84KPA5PhpbzixUWqfv5Dh
         fLFw==
X-Gm-Message-State: AGi0Pub0KVE0x8QGK+Wa2Fcg13YjvoQyeEhhrlGocaXfgZ4soQvBlzT9
        Z9LgUQdkzHHHYqdQq2YXlieU8oRrNAkz7DxXGGc=
X-Google-Smtp-Source: APiQypLPT5iy07GIHTCHHRjr7Ol9fwslPNO+/9z4Wgqwd/Gp9Fzyk1y3MURI29+XCVJ20vSg48VeAQOmOi5D6VEHeuA=
X-Received: by 2002:aca:c441:: with SMTP id u62mr1243167oif.110.1588157193898;
 Wed, 29 Apr 2020 03:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <1587982637-33618-1-git-send-email-guohanjun@huawei.com>
 <06ff344e-7abf-9eb6-9664-0e9f9d8d6bc7@linaro.org> <000401d61ca1$f684f7b0$e38ee710$@net>
 <0fbf3fc3-fabf-c9cb-b582-8dc6e2d5b7de@huawei.com>
In-Reply-To: <0fbf3fc3-fabf-c9cb-b582-8dc6e2d5b7de@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Apr 2020 12:46:22 +0200
Message-ID: <CAJZ5v0hMr928Up83JXzYOkoc0=1q_ofdm_fH5cSmY0dV3uypEQ@mail.gmail.com>
Subject: Re: [RFC PATCH] cpuidle: Make cpuidle governor switchable to be the
 default behaviour
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     Doug Smythies <dsmythies@telus.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 28, 2020 at 4:48 AM Hanjun Guo <guohanjun@huawei.com> wrote:
>
> On 2020/4/27 22:41, Doug Smythies wrote:
> > I very much support this RFC.
> > I have been running only with "cpuidle_sysfs_switch" for about 2 years.
>
> Thanks, glad to hear that switch cpuidle governor at
> runtime works for years.
>
> >
> > Some changes would be required for the documentation files also.
>
> I will update them in next version.
>
> >
> > On 2020.04.27 06:37 Daniel Lezcano wrote:
> >> On 27/04/2020 12:17, Hanjun Guo wrote:
> >>> For now cpuidle governor can be switched via sysfs only when the
> >>> boot option "cpuidle_sysfs_switch" is passed, but it's important
> >>> to switch the governor to adapt to different workloads, especially
> >>> after TEO and haltpoll governor were introduced.
> >>>
> >>> Introduce a CONFIG option to make cpuidle governor switchable to be
> >>> the default behaviour, which will not break the boot option behaviour.
> >>>
> >>> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> >>> ---
> >>>   drivers/cpuidle/Kconfig | 9 +++++++++
> >>>   drivers/cpuidle/sysfs.c | 2 +-
> >>>   2 files changed, 10 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
> >>> index c0aeedd..c40cb40 100644
> >>> --- a/drivers/cpuidle/Kconfig
> >>> +++ b/drivers/cpuidle/Kconfig
> >>> @@ -47,6 +47,15 @@ config CPU_IDLE_GOV_HALTPOLL
> >>>   config DT_IDLE_STATES
> >>>     bool
> >>>
> >>> +config CPU_IDLE_SWITCH_GOV_IN_DEFAULT
> >>> +   bool "Switch the CPU idle governor via sysfs at runtime in default behaviour"
> >>> +   help
> >>> +     Make the CPU idle governor switchable at runtime, and make it as the
> >>> +     default behaviour even the boot option "cpuidle_sysfs_switch" is not
> >>> +     passed in cmdline.
> >>> +
> >>> +     Say N if you unsure about this.
> >>
> >> Well I wouldn't make this optional but just remove the sysfs_switch.
> >
> > Agree.
> >
> >> However, there is the '_ro' suffix when the option is not set. In order
> >> to not break the existing tools, may be let both files co-exist and add
> >> in the ABI/obselete the '_ro' file as candidate for removal ?
> >
> > I do not like this _ro thing, and got hit by it with turbostat one time.
> > Agree it should be made a candidate for removal.
>
> OK, I will prepare another RFC patch set to remove sysfs_switch.

I would just do it in one series, though, as suggested by Daniel.

Also, I wouldn't worry about the _ro thing too much, as the changes
effectively make "cpuidle_sysfs_switch" be the default (and the tools
should be able to cope with "cpuidle_sysfs_switch" anyway) without an
alternative (but who cares?).

Cheers!
