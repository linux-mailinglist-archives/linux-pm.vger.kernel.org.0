Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCCAC151371
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2020 00:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgBCXmm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Feb 2020 18:42:42 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:35215 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgBCXmm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Feb 2020 18:42:42 -0500
Received: by mail-io1-f67.google.com with SMTP id h8so18861480iob.2
        for <linux-pm@vger.kernel.org>; Mon, 03 Feb 2020 15:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YuZF5CtTMKfG8ytqJhJvZoJ0OxJpC1Lt9DsVnzfRLh8=;
        b=ovbsN2I5bRtPMdbRG4c00XOdp8yzrRTJdj2R41hYcnv4V/gg3rgKJYGE++Khe6Jk9Y
         04L6G8KPm4OMDYpx2wGE2jthe4aWiJrVfZBs8NhAb6SJtU1IfATTwIMf5ve0/Hh73gKN
         tG4sReYmRblFuQ9jKcG73MTL75EUQutaL8MLIGg2Gu0+HNLAN7YT+vaeOv2Nht69P6lT
         0cTd9h4TJKX2STsxRODdzJTd6R63ODpL2oGUvqz5X9NuC5ARbrOeIxYbM/keRtKGZRtG
         baQWrAJaiX+YufwAervOb6twBt/60/3p4qbq0CQf2rV5tI72FSkzbGheewPxIk5de57K
         LR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YuZF5CtTMKfG8ytqJhJvZoJ0OxJpC1Lt9DsVnzfRLh8=;
        b=NCrn6QscByDwylOlslVzUJnoEHdxpRsHkRIIsYUfpsUpcY4xlYfceNaoe/7VcxD3nG
         BddVxZEW/t9Y9IpIzU7Xmt3LlCJG8n5bhaAWGWZ1vq0FqYE+sfwvLMXyOEqE7eis2IMs
         4bSCHU67lvLSbnhi+7tahI1FJvojbXQ+xWKxrKjuxXG5PEfkvAVqCdM5cLnMsDlqN7E3
         fQcPC0Jv5WZFVEmhSradOBNFwEes6xT7NBazfnVqiFEtfAmy9JSpf8B8BXTOwAvmj1Y/
         Oj1/aV41MYkSvmY+/mFVMWSzmXh/MEiZJwy72iB8FleYcOdzBCxkLKCUItBpLOZ2RxO7
         kP2w==
X-Gm-Message-State: APjAAAW3K/yCoazbWkILRulvqY0iiEXJEeiSmA1DaWcFMM4wXJyCeBhh
        CvKkQG/QT5+nF3MNi92rUh5IwV32sdihjdDSmo5T1w==
X-Google-Smtp-Source: APXvYqxcqfrtzUcZQVY5IwBzmW30d0h9js9pM+wntB0jSOEvC02cdqUi6O6Igo6whqwjytyuc+sGzuCIQ3AFs/W6+AA=
X-Received: by 2002:a05:6638:34e:: with SMTP id x14mr22215510jap.38.1580773361469;
 Mon, 03 Feb 2020 15:42:41 -0800 (PST)
MIME-Version: 1.0
References: <20200124231834.63628-1-pmalani@chromium.org> <adcf2a99-d6d8-cd4e-e22d-9ce539d87b7f@collabora.com>
 <20200127184439.GA150048@google.com> <CACeCKafdroLXf62aHeP8CZPuiR02EEmKAGmhHczzoSyX0bFv5g@mail.gmail.com>
 <dc1fec43-1bb0-53de-af17-a91fea42a3f5@collabora.com>
In-Reply-To: <dc1fec43-1bb0-53de-af17-a91fea42a3f5@collabora.com>
From:   Benson Leung <bleung@google.com>
Date:   Mon, 3 Feb 2020 15:42:29 -0800
Message-ID: <CANLzEks0+J9qvAk_rw2_1r74twnonXmPGdCpY3w2nY8xYPAYLw@mail.gmail.com>
Subject: Re: [PATCH v8 1/4] platform: chrome: Add cros-usbpd-notify driver
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Prashant Malani <pmalani@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, Jon Flatley <jflat@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Enric, Hi Prashant,

On Wed, Jan 29, 2020 at 12:37 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
> >> I'm OK with creating a branch for this series and merging it into
> >> chrome-platform-5.7 once Linus releases v5.6-rc1 late next week.
> > Thanks; I'm guessing one of the maintainers will perform the creation
> > of chrome-platform-5.7 and merge this patch into that branch.
> > Also, kindly pick https://lkml.org/lkml/2020/1/24/2068 , i.e patch 4/4
> > of this series (I think an earlier version of this patch, i.e
> > https://lkml.org/lkml/2020/1/17/628 was marked "Reviewed-by: Sebastian
> > Reichel <sebastian.reichel@collabora.com>"
> >
>
> That patch should go through Sebastian's tree, we will create an immutable
> branch for him when rc1 is released.
>

Before rc1 is released, I've gone ahead and created a staging branch
on chrome-platform collaboration repo here:
https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git/log/?h=staging-cros-usbpd-notify

Here are the two commits I have right now:
e8573ca91ae4 power: supply: cros-ec-usbpd-charger: Fix host events
a49c1263a22b platform: chrome: Add cros-usbpd-notify driver

Enric, I went ahead and modified the Kconfig on the first patch to
depend on MFD_CROS_EC_DEV and default it as well.
Prashant, let me know how these look to you. We can convert the branch
to an immutable next week.

-- 
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org
