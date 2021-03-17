Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECEF33F73C
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 18:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbhCQRjb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 13:39:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60554 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232141AbhCQRjJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 13:39:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616002748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cmp3AOe6/8OTUuf+//7xGx20rFpuBW0gLXu6HX63aaI=;
        b=HTUri1WpkCizMiyIDH46qc2Or9bkJ3VrjYGs9VqQ/adnUqEs3nZtDZ2hj08F+fKTZkTkHz
        5tGGnjzEIA7kCRHi8Pm4SXbiEE5zTOT2nvxzLcdqUkJ699ljGsCcqeUcc58Dx7ywmPJ08r
        qjL7QfHITOORv9YDHTamqkNRsP4p44E=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-vK2cs64XP_u2oY-CF0qecA-1; Wed, 17 Mar 2021 13:39:06 -0400
X-MC-Unique: vK2cs64XP_u2oY-CF0qecA-1
Received: by mail-ej1-f72.google.com with SMTP id gn30so15451576ejc.3
        for <linux-pm@vger.kernel.org>; Wed, 17 Mar 2021 10:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Cmp3AOe6/8OTUuf+//7xGx20rFpuBW0gLXu6HX63aaI=;
        b=m3NgEJn9VefOgiLjrZgQf/EEcQjiMRSty9GU4JdyRObK5d0JmqWNxEvJjZ9iXyXwzm
         IkW3ozPVI2kjkpXJsF1Utsv8AfCUTrkJwvLarOjzYtLcPP6QO1TwUk0r3RtvHksNxSV7
         Bh+U9195xSStmRsF4IEDMdZ1JS+bHksmmGlhuUWERd1wHVPksinxCG3MrTGjpP53HcOd
         vAzbs/GetLDfCO3qQBusPdGP1JHfvCi0pF7tTA1zhhaTb7ihasZrE/TOYhektbSXJqL7
         Lvup9XUhbWut3P1kjchfy/SEzXYQBJudvfqK6O7CR2dDBrjC98/YTLR9LRIAIknmltL7
         /2bA==
X-Gm-Message-State: AOAM531IU2boI1xjLnbCbSvNrP0DZZCv2ReN+pnmX4ZjU25mUm78lx9h
        MSNyXm2nS+V403raQVxFKGcUPjIv17jntM7wpricfmtAJkGkcoW6Um/wlruuEd9baV5wZhHgZBK
        Z78YiZg91gJjPyRSyvfM=
X-Received: by 2002:aa7:d954:: with SMTP id l20mr43572183eds.1.1616002745359;
        Wed, 17 Mar 2021 10:39:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWI+Nz3oJ3aTMnmdebMc2YpP79z+h1kTt/FVhtFdhiJfuJf8XpXTs93ZM6FYn4/LO5RVWggg==
X-Received: by 2002:aa7:d954:: with SMTP id l20mr43572165eds.1.1616002745191;
        Wed, 17 Mar 2021 10:39:05 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id gx2sm6670203ejc.82.2021.03.17.10.39.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 10:39:04 -0700 (PDT)
Subject: Re: [PATCH 0/2] power: supply: Add battery and AC drivers for Surface
 devices
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210309000530.2165752-1-luzmaximilian@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <edcbe108-8cd7-4034-222f-c8ce56918dee@redhat.com>
Date:   Wed, 17 Mar 2021 18:39:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210309000530.2165752-1-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 3/9/21 1:05 AM, Maximilian Luz wrote:
> This series provides battery and AC drivers for Microsoft Surface
> devices, where this information is provided via an embedded controller
> (the Surface System Aggregator Module, SSAM) instead of the usual ACPI
> interface.
> 
> Specifically, 7th generation Surface devices, i.e. Surface Pro 7,
> Surface Book 3, Surface Laptop 3, as well as the Surface Laptop Go use
> this new interface.
> 
> Note: This series depends on the
> 
>     platform/surface: Add Surface Aggregator device registry
> 
> series. More specifically patch
> 
>     platform/surface: Set up Surface Aggregator device registry
> 
> The full series has been merged into the for-next branch of the
> platform-drivers-x86 tree [1]. The commit in question can be found at
> [2].
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=for-next
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?h=for-next&id=fc622b3d36e6d91330fb21506b9ad1e3206a4dde

Sebastian, I guess you want a pull-req from an immutable branch from me for
that dependend commit and then you will merge these 2 patches ?

Maximillian, this only needs that commit right, or would it be better if
I send Sebastian a pull-req for a branch with the entire series?

Regards,

Hans





> 
> Maximilian Luz (2):
>   power: supply: Add battery driver for Surface Aggregator Module
>   power: supply: Add AC driver for Surface Aggregator Module
> 
>  MAINTAINERS                            |   8 +
>  drivers/power/supply/Kconfig           |  32 +
>  drivers/power/supply/Makefile          |   2 +
>  drivers/power/supply/surface_battery.c | 901 +++++++++++++++++++++++++
>  drivers/power/supply/surface_charger.c | 296 ++++++++
>  5 files changed, 1239 insertions(+)
>  create mode 100644 drivers/power/supply/surface_battery.c
>  create mode 100644 drivers/power/supply/surface_charger.c
> 

