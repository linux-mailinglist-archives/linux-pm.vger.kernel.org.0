Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01592D8957
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2019 09:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfJPHYJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 03:24:09 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33153 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfJPHYJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 03:24:09 -0400
Received: by mail-qt1-f193.google.com with SMTP id r5so34732069qtd.0
        for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2019 00:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7/kqUGL2RuhU3S60UdPu4y8clUQwY+VPaSSrwpbmgO0=;
        b=E6CSpufjtD3JGknIx0r1OwKl8d/peQZ5ZUvYmVDjKJ85JqPi7S5P6RtcCs8+ciTzko
         x3C0s2N2v+HNM5R4jLGcQee/zx3JFZZTh9fV7UvnLMr9YGbzHkxaEScpEy32+Sq7uFE3
         A+15MosWrZHsrV0Tv/yqCDHhhyGBHG16BqIZd8tenP7CnwA+e9joGCSwVRskdX4FhIQr
         tuzmrcNUMAj6IfcY7D/Ph9V4Mp0l8Gz9jazC8W0h0av/efR/8QKvIVWUrftrJOkZknV7
         6LeAWuZQ0GTC/S4r1TTttOzZwWAarjfjsykv/LlNzZ2POlQgIEOrBDLevIYXEim73v9K
         kYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7/kqUGL2RuhU3S60UdPu4y8clUQwY+VPaSSrwpbmgO0=;
        b=RTfscFoGEfGxtU0F+1bMuv3oBEXRndOFUnKSae2pupptmZUq6dJChSyB57RujNZIaX
         3XrhPXjPMk3+uHFgn1LnU4KHYhKrXwuLghy95xYcitklvWZOcD/g1Q2VYuWt6U7KjPH3
         KCb3tKcN3kMl8ximSgo5tmJFN7ukr5jvv1cpcqtnFwPAmJshgADe9k5Ky7G28N8fDqUk
         +rDPOqJyBadSsjXk3GpY8B8KwhValJT8smkPx8npUgACvl+Y+Mw2K/eeQs+pFy0ryuNF
         hTvDv3zifSF+SuslEnVul4wynHP9LSckvHxHAhnhXRniotA/Pp8Wr2ZuwJocwRDeN8yl
         Co6g==
X-Gm-Message-State: APjAAAVlVqYKN+ZsdYHjJZ/xx15dL1aY1Q1rOP5QumkQhJQl+ZRz0Knx
        aTp8POzvbs2d2HIpVx1VwDGihX9Gadu7ENdBE+06rA==
X-Google-Smtp-Source: APXvYqy51zkLCTO2KlvsJEzJJFKY46jnl45N81gIEG3DdMwbZeqsL9d89eQ2HFc6D2ejCsrjEsx19pTUKBmd09i1qBo=
X-Received: by 2002:ac8:3021:: with SMTP id f30mr42357999qte.80.1571210648136;
 Wed, 16 Oct 2019 00:24:08 -0700 (PDT)
MIME-Version: 1.0
References: <20191015065002.18701-1-drake@endlessm.com> <CADnq5_M4Leu0raYS6M72MqTm1+PLg9BjHCHLAYuB2-dEVP56_A@mail.gmail.com>
In-Reply-To: <CADnq5_M4Leu0raYS6M72MqTm1+PLg9BjHCHLAYuB2-dEVP56_A@mail.gmail.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Wed, 16 Oct 2019 15:23:56 +0800
Message-ID: <CAD8Lp443ZhPEo0PJRxbTSB9DY9x92OvWBeH29m9Ehpyhg+2n5A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: always reset asic when going into suspend
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 16, 2019 at 2:43 AM Alex Deucher <alexdeucher@gmail.com> wrote:
> Is s2idle actually powering down the GPU?

My understanding is that s2idle (at a high level) just calls all
devices suspend routines and then puts the CPU into its deepest
running state.
So if there is something special to be done to power off the GPU, I
believe that amdgpu is responsible for making arrangements for that to
happen.
In this case the amdgpu code already does:

        pci_disable_device(dev->pdev);
        pci_set_power_state(dev->pdev, PCI_D3hot);

And the PCI layer will call through to any appropriate ACPI methods
related to that low power state.

> Do you see a difference in power usage?  I think you are just working around the fact that the
> GPU never actually gets powered down.

I ran a series of experiments.

Base setup: no UI running, ran "setterm -powersave 1; setterm -blank
1" and waited 1 minute for screen to turn off.
Base power usage in this state is 4.7W as reported by BAT0/power_now

1. Run amdgpu_device_suspend(ddev, true, true); before my change
--> Power usage increases to 6.1W

2. Run amdgpu_device_suspend(ddev, true, true); with my change applied
--> Power usage increases to 6.0W

3. Put amdgpu device in runtime suspend
--> Power usage increases to 6.2W

4. Try unmodified suspend path but d3cold instead of d3hot
--> Power usage increases to 6.1W

So, all of the suspend schemes actually increase the power usage by
roughly the same amount, reset or not, with and without my patch :/
Any ideas?

Thanks,
Daniel
