Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B5F433C1C
	for <lists+linux-pm@lfdr.de>; Tue, 19 Oct 2021 18:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbhJSQ2j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Oct 2021 12:28:39 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:38540 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhJSQ2i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Oct 2021 12:28:38 -0400
Received: by mail-ot1-f51.google.com with SMTP id l10-20020a056830154a00b00552b74d629aso3466255otp.5;
        Tue, 19 Oct 2021 09:26:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AF0k+KvBuDHM4TTRwXS1Ly1hsDYwoZ3hGM2c13+VvtA=;
        b=td75yQrU8lslxVKawgegokXDnOsuG5+kKn3E+6NdLZbhlWBOTuCT1cSdw4gOKseRy0
         k4X6XlBUUOXAeH1mqir8tFb1Nxn4YSKlKLwUk9ihbW18q4fhayfF3PfHcz7pXWpI6M2J
         INF6YsXxGynqvxBXozIRBTlex+86AfmNym55B4yNvXO4lp13YaQxXoEAf1ydQxL/QzFa
         T5n9TrE7smgPWUjKisKbEjxPZjl8TdXqTLHNwZBqGvMw/nMWP1uHhznQr2ekGUzCiJ+u
         QyU/GXHhtBo0cgNe2RmmgZl6XAEKItAPVkNL5roIjx5aWlA7iaoQO+Ng1vm5u72L2hmt
         K4Cg==
X-Gm-Message-State: AOAM533pYWukjjDcZ9s/Ezvu2h8iacZeirOzMkadP2vVsV4cf3UdTd3h
        vSyXg9WXCS0okD3pxmbbCXN+WefslV5sP40J4HjK4wbo
X-Google-Smtp-Source: ABdhPJyefLmTs74u57bEyIg6DYpU5/H3cIVrSpRFd39SdDv3gdf5a8rE9eUR9R9cHlJh3AT8fTjGt2OizTYyhAUuPiI=
X-Received: by 2002:a9d:65c1:: with SMTP id z1mr6063521oth.198.1634660785313;
 Tue, 19 Oct 2021 09:26:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211019150203.2805738-1-daniel.lezcano@linaro.org>
 <20211019150203.2805738-2-daniel.lezcano@linaro.org> <CAJZ5v0i1RCKs8nMCc0ROsM03beOPL941r+=NPbQpidiZJ2OA8A@mail.gmail.com>
 <CAJZ5v0hLVb=vbyxtraoBgPBWb8FkjzpPtH+10_AY4E8CDgc5sA@mail.gmail.com> <7a6ba739-a7f4-8553-187b-6c0f6dc9a208@linaro.org>
In-Reply-To: <7a6ba739-a7f4-8553-187b-6c0f6dc9a208@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 Oct 2021 18:26:14 +0200
Message-ID: <CAJZ5v0iD6Hy3KBW_zge7Xz5=L90ik2q2yr7UvE9Y30ARFgOLmA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] thermal/core: Make deprecated cooling device state
 change from userspace
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 19, 2021 at 5:59 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 19/10/2021 17:43, Rafael J. Wysocki wrote:
> > On Tue, Oct 19, 2021 at 5:40 PM Rafael J. Wysocki <rafael@kernel.org>
> > wrote:
> >>
> >> On Tue, Oct 19, 2021 at 5:02 PM Daniel Lezcano
> >> <daniel.lezcano@linaro.org> wrote:
> >>>
> >>> The cooling devices have their cooling device set_cur_state
> >>> read-writable all the time in the sysfs directory, thus allowing
> >>> the userspace to act on it.
> >>>
> >>> The thermal framework is wrongly used by userspace as a power
> >>> capping framework by acting on the cooling device opaque state.
> >>> This one then competes with the in-kernel governor decision.
> >>>
> >>> We have seen in out-of-tree kernels, a big number of devices
> >>> which are abusely declaring themselves as cooling device just to
> >>> act on their power.
> >>>
> >>> The role of the thermal framework is to protect the junction
> >>> temperature of the silicon. Letting the userspace to play with a
> >>> cooling device is invalid and potentially dangerous.
> >>>
> >>> The powercap framework is the right framework to do power capping
> >>> and moreover it deals with the aggregation via the dev pm qos.
> >>>
> >>> As the userspace governor is marked deprecated and about to be
> >>> removed, there is no point to keep this file writable also in
> >>> the future.
> >>>
> >>> Emit a warning and deprecate the interface.
> >>>
> >>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org> ---
> >>> drivers/thermal/thermal_sysfs.c | 2 ++ 1 file changed, 2
> >>> insertions(+)
> >>>
> >>> diff --git a/drivers/thermal/thermal_sysfs.c
> >>> b/drivers/thermal/thermal_sysfs.c index
> >>> 1c4aac8464a7..730f1361dbef 100644 ---
> >>> a/drivers/thermal/thermal_sysfs.c +++
> >>> b/drivers/thermal/thermal_sysfs.c @@ -610,6 +610,8 @@
> >>> cur_state_store(struct device *dev, struct device_attribute
> >>> *attr, unsigned long state; int result;
> >>>
> >>> +       pr_warn_once("Setting cooling device state is
> >>> deprecated\n");
> >>
> >> Maybe dev_warn_once() even?  I guess it won\t hurt to print it
> >> once per the affected device?
>
> Actually, there is no difference except it will be prefixed by the
> device name.
>
> As the static variable to write once the message is local to the
> function, not the dev, the warning will appear only once even if we use
> dev, or cdev->device.
>
> The other calls in the file are pr_warn. I suggest to stay consistent in
> this case. Is that fine ?

It is, except that it may not be straightforward to connect the
message to the specific device in question.
