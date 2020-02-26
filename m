Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7249B16FF30
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2020 13:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgBZMkI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Feb 2020 07:40:08 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44890 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgBZMkI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Feb 2020 07:40:08 -0500
Received: by mail-oi1-f194.google.com with SMTP id d62so2830369oia.11
        for <linux-pm@vger.kernel.org>; Wed, 26 Feb 2020 04:40:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7C5/suAZnk3lRj31es5ErcjGQ6Yeqbc/PFgNetWbEdI=;
        b=XYs5cCDeaOlt2hNoniJ7MNXGVzxohXaFvAoZx7xPLR/4nFy6BZbs/zFmVcB+ZNYvlj
         UxazsxhsuXJP7N95fkwwbDOSLYAy6W94BWwcIadtaPDs1QQ1fVIC95HmVnt8XlnM9/HJ
         NMT7imU2ALemXoxk5gO/h2zfXtKOA2iinqKFF0Xo0qJw3jSgUFgpkNNGC3WtocLv8i3+
         TKpi1wOgV+7zIgmOl0o87YKcz+TKguygD93kj4and+Q16htgA1QmDcFpBjOSLpp5hRvd
         hhCd/6zI4hoadNz1ALDHmp8+L0uMNQb55bEVRKsLxH3EcuKJUHfr1P40Yje72df9239l
         5A8g==
X-Gm-Message-State: APjAAAVdO+H3ZDnMBdAG8eW/qkS/tO8vY5896E2wV0B62pb1TCYA+8qc
        kCeXQJLqBcBqMJxvpzhoo/o9X2Zj5mlcRSmYU/0=
X-Google-Smtp-Source: APXvYqwX3GvT9g6Z1u2ugaBjDdPEnfAUN+Q4GOKF1TdkRn+iP90GbdtJgHFf2zW8MeGHLmkdCjtZ/FhKYhb+HiwVLSE=
X-Received: by 2002:aca:d6c8:: with SMTP id n191mr3083239oig.103.1582720807770;
 Wed, 26 Feb 2020 04:40:07 -0800 (PST)
MIME-Version: 1.0
References: <39fb762880c27da110086741315ca8b111d781cd.camel@gmail.com>
In-Reply-To: <39fb762880c27da110086741315ca8b111d781cd.camel@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 26 Feb 2020 13:39:56 +0100
Message-ID: <CAJZ5v0gfoGKUQ6Kn8uCZr5zzGz_eYd9LfgTnTJ3OTZM2DZGf1A@mail.gmail.com>
Subject: Re: Not readable 'scaling_governor'
To:     Artem Bityutskiy <dedekind1@gmail.com>
Cc:     Linux PM Mailing List <linux-pm@vger.kernel.org>,
        "Rafael J.Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Artem,

On Fri, Feb 21, 2020 at 6:29 PM Artem Bityutskiy <dedekind1@gmail.com> wrote:
>
> Hi,
>
> in the latest Linus's kernel this file is not readable:
>
> $ cat /sys/devices/system/cpu/cpu91/cpufreq/scaling_governor
> cat: /sys/devices/system/cpu/cpu91/cpufreq/scaling_governor: Invalid argument
>
> I did not try to bisect, and it must be bug. Known issue?

Thanks for the report!

Yes, it is a bug, but has not been reported yet.

I'll send a fix for it later today or tomorrow.

Cheers!
