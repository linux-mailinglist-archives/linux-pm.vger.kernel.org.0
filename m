Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C687835A0FF
	for <lists+linux-pm@lfdr.de>; Fri,  9 Apr 2021 16:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbhDIO1A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Apr 2021 10:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbhDIO07 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Apr 2021 10:26:59 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19892C061761
        for <linux-pm@vger.kernel.org>; Fri,  9 Apr 2021 07:26:45 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id x16so6111619iob.1
        for <linux-pm@vger.kernel.org>; Fri, 09 Apr 2021 07:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ThxPDQhM4kEVDLwubZDAdURyhcYo7/BXJ9Qt3etGlA=;
        b=GQ2HjbBqbU54oGdh+pNfj9lLnSjk3I2zlzKyK2fhwKEhXWgb0UpY0jg9qujwPGWZuf
         EjSc4KSApOTWC0F9Xks4NITd1MCy2QEMFmso0aLUavxykJVoH8PrvnfRbpgn3OjTw2NT
         07u7Wum1sRvT+v+eSonaywAuwfb9aOtHqaGJxJI2hEzWNSSRqpdP2L6SORSiSbBBrrcu
         iONtHPHt+jwr9rRt5Udp/6RtKvA2igtxqtnZLCtN0nGXNEyMucH/CJNzlLsBpwPIqZLU
         tktxjOBN1pX0QwqUvRF2QjLv7UO7KaWzISR+lAi4iEeDKP4+9WT82FT4ux/yFqRgDMv2
         /tjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ThxPDQhM4kEVDLwubZDAdURyhcYo7/BXJ9Qt3etGlA=;
        b=H4zWaVpIu0hQnPp/S6DQR6CYIahn9bEM7byuQTkWymikI5eRovu/5ejvWaaJajYl+/
         UBuqbES9Wk23mFeSyhJVbJSLgPta3kZEBoWWiCOrK3pxlOwQVB2XzPKochX9lSvO6iFZ
         srFUECVgWCD+ZPpBTRaqbTxZWXDCSiC4R7gOwemymZryHbyQiu8G3nnIQjWvoZGijuCd
         flPPoiuopo0SOKPnRqbPnlwiqAF78l6LGx67lYQ7WI8ZkQIQMAby4Rc6q2mayccu1Pjh
         /e/np0AverH+bOHy5yVBkEAKhTjpBcCubvl4oNcwNZ+Sd+fSCjCVI/Duau7IaZSdtLq1
         mABg==
X-Gm-Message-State: AOAM5302lcyaQu+hw+xAcTx8+ZVV0fobvdE3arjrwMsm1qJUe3Ia34Zk
        gnj5ZHVqIMlmR9ar7+kCRqJ5aIkUm3U6AbAebAnnsw==
X-Google-Smtp-Source: ABdhPJx1yiAQTbQmfApjZVBT1ZKcxc0hOjVD/FrMOFRtbg2H9B7rCYKh67hBs4harU9XFVkYpm+aUoc1wsUryOBkcM8=
X-Received: by 2002:a05:6638:338a:: with SMTP id h10mr14570283jav.129.1617978404469;
 Fri, 09 Apr 2021 07:26:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210404083354.23060-1-psampat@linux.ibm.com> <CAAYoRsWaAmyuJU4FCb7gtK0y-ZprdDVvp0vMpy=ZohzoC7YX1Q@mail.gmail.com>
 <0a4b32e0-426e-4886-ae37-6d0bdafdea7f@linux.ibm.com>
In-Reply-To: <0a4b32e0-426e-4886-ae37-6d0bdafdea7f@linux.ibm.com>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Fri, 9 Apr 2021 07:26:38 -0700
Message-ID: <CAAYoRsXqUpkVxDuRUoapBJ__EUPbMBSWJ7QigVcKbr6ApRxzbg@mail.gmail.com>
Subject: Re: [RFC v3 0/2] CPU-Idle latency selftest framework
To:     Pratik Sampat <psampat@linux.ibm.com>
Cc:     rjw@rjwysocki.net, Daniel Lezcano <daniel.lezcano@linaro.org>,
        shuah@kernel.org, ego@linux.vnet.ibm.com, svaidy@linux.ibm.com,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, pratik.r.sampat@gmail.com,
        dsmythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Apr 9, 2021 at 12:43 AM Pratik Sampat <psampat@linux.ibm.com> wrote:
> On 09/04/21 10:53 am, Doug Smythies wrote:
> > I tried V3 on a Intel i5-10600K processor with 6 cores and 12 CPUs.
> > The core to cpu mappings are:
> > core 0 has cpus 0 and 6
> > core 1 has cpus 1 and 7
> > core 2 has cpus 2 and 8
> > core 3 has cpus 3 and 9
> > core 4 has cpus 4 and 10
> > core 5 has cpus 5 and 11
> >
> > By default, it will test CPUs 0,2,4,6,10 on cores 0,2,4,0,2,4.
> > wouldn't it make more sense to test each core once?
>
> Ideally it would be better to run on all the CPUs, however on larger systems
> that I'm testing on with hundreds of cores and a high a thread count, the
> execution time increases while not particularly bringing any additional
> information to the table.
>
> That is why it made sense only run on one of the threads of each core to make
> the experiment faster while preserving accuracy.
>
> To handle various thread topologies it maybe worthwhile if we parse
> /sys/devices/system/cpu/cpuX/topology/thread_siblings_list for each core and
> use this information to run only once per physical core, rather than
> assuming the topology.
>
> What are your thoughts on a mechanism like this?

Yes, seems like a good solution.

... Doug
