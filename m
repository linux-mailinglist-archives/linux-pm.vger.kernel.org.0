Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F321033F77D
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 18:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbhCQRtw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 13:49:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36558 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232288AbhCQRtU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 13:49:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616003360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/+ibb3Br4K61RTkghPv+0gtVahorbHjJekn7ZK14QjI=;
        b=hj+IJA7lvG0rzT3ti2zIYK0EipFdXmQNyT6x87lKq0QE/UruVXMmz/eVMNAhlFiqnkcS1x
        cKAHqihlWUYT1xLXmwhHtxyyqpH04FGzJiY07xFTt2dsu1QA0oEAsoumuiVt65Dx4q9VwG
        hY0JmojQ4DnjqG+ZwtvJ1eJ6n+GtcQg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-B_915-E1PNimVXqg3jNTNQ-1; Wed, 17 Mar 2021 13:49:18 -0400
X-MC-Unique: B_915-E1PNimVXqg3jNTNQ-1
Received: by mail-ed1-f72.google.com with SMTP id m8so14109311edv.11
        for <linux-pm@vger.kernel.org>; Wed, 17 Mar 2021 10:49:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/+ibb3Br4K61RTkghPv+0gtVahorbHjJekn7ZK14QjI=;
        b=H0ws7Vbo0vuJh4f9HLziSY77PaRTgTNz+/m4McwZak/oC+gn5LP2Lb1HnFu4eLL88a
         zPeVd7NPRma0za/Lku/Z970OQx1AiKp8Akhi9zLHCrLOXjOd2m1/CnJSUB++c8uMMqsb
         7UhcyNt61WDbGLWqj6/S0qxZNUBvMtMlTtAEa8/kkprmFd0e4vdyyzzstcbwcRgPPQr9
         zqu2/o6n7Oc59S7L+4jo+R9KUET+nch+2SU3SCTKtyDGG+OKnbt/AH106em/W20Nv0Mc
         XtJq7CP0igxWAfq4zHj2VATMgoqAfquO2McvSxj7iB2Be3/qaK+AbupFRvNN5cQoSDBs
         93ag==
X-Gm-Message-State: AOAM5300fDfb+o/RELXuKjwbd1io1BdZh+JfsmZuiBzRhSJ+xbFikc5f
        5bm1Bbgni7dLXXGP727Xd82zjYCXJ4OQpgYTVXW4s+ZTMxlT4jQNDfep265LBO8RaEtGh4FJtRR
        O/kHjZaWJuW9LBHB5MH8=
X-Received: by 2002:a05:6402:31a7:: with SMTP id dj7mr43645993edb.33.1616003356755;
        Wed, 17 Mar 2021 10:49:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwR8fampzxEqdpvBY7gKviiN76BsjpAVvBgItH/BesZSGl36lmeZngX9SfAjECSbSJlEG9Lzg==
X-Received: by 2002:a05:6402:31a7:: with SMTP id dj7mr43645978edb.33.1616003356623;
        Wed, 17 Mar 2021 10:49:16 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id r17sm13942325edx.1.2021.03.17.10.49.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 10:49:16 -0700 (PDT)
Subject: Re: [PATCH 0/2] power: supply: Add battery and AC drivers for Surface
 devices
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210309000530.2165752-1-luzmaximilian@gmail.com>
 <edcbe108-8cd7-4034-222f-c8ce56918dee@redhat.com>
 <f124e477-2786-d842-5694-13aa4146ba34@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <efdf4d60-64e7-2dd8-5349-29725ec5cbea@redhat.com>
Date:   Wed, 17 Mar 2021 18:49:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <f124e477-2786-d842-5694-13aa4146ba34@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 3/17/21 6:47 PM, Maximilian Luz wrote:
> On 3/17/21 6:39 PM, Hans de Goede wrote:
>> Hi,
>>
>> On 3/9/21 1:05 AM, Maximilian Luz wrote:
>>> This series provides battery and AC drivers for Microsoft Surface
>>> devices, where this information is provided via an embedded controller
>>> (the Surface System Aggregator Module, SSAM) instead of the usual ACPI
>>> interface.
>>>
>>> Specifically, 7th generation Surface devices, i.e. Surface Pro 7,
>>> Surface Book 3, Surface Laptop 3, as well as the Surface Laptop Go use
>>> this new interface.
>>>
>>> Note: This series depends on the
>>>
>>>      platform/surface: Add Surface Aggregator device registry
>>>
>>> series. More specifically patch
>>>
>>>      platform/surface: Set up Surface Aggregator device registry
>>>
>>> The full series has been merged into the for-next branch of the
>>> platform-drivers-x86 tree [1]. The commit in question can be found at
>>> [2].
>>>
>>> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=for-next
>>> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?h=for-next&id=fc622b3d36e6d91330fb21506b9ad1e3206a4dde
>>
>> Sebastian, I guess you want a pull-req from an immutable branch from me for
>> that dependend commit and then you will merge these 2 patches ?
>>
>> Maximillian, this only needs that commit right, or would it be better if
>> I send Sebastian a pull-req for a branch with the entire series?
> 
> The entire series would be better, I think.
> 
> Strictly speaking, it only requires the mentioned commit to compile
> successfully, but if anyone would want to test this they'd need the full
> series (or at least the battery/power subsystem commit) due to the
> device instantiation.

Ack, I think the whole series makes the most sense too, so I will
prepare a pull-req for that.

> Same reasoning applies to the HID series.

Ack.

Regards,

Hans

