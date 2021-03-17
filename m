Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52BC833F53E
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 17:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbhCQQQF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 12:16:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45559 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232374AbhCQQPi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 12:15:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615997737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iPq/z/5s93exettJBQ0E7OqZ74IyFIfYkYXttCd5A4I=;
        b=Vqrc/GJr/MsrJYwx3wJ+oDCe+e/choKIG8oBIShaZViSlO8hw+aLzpImn5h2GnhH9B71aN
        0lQgOm3ggmUWou0YX46H2tWv/WqkML/MIn05bVSVTTLhvgxE+ZOKcB/Lk5sUspXc8RXjRI
        GvwNux6MdUp0J1NOsQdLf/4TrykPUWY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-550-o9q1-4SvO6CgWHo7SN-ufg-1; Wed, 17 Mar 2021 11:02:14 -0400
X-MC-Unique: o9q1-4SvO6CgWHo7SN-ufg-1
Received: by mail-ed1-f69.google.com with SMTP id t27so19484584edi.2
        for <linux-pm@vger.kernel.org>; Wed, 17 Mar 2021 08:02:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iPq/z/5s93exettJBQ0E7OqZ74IyFIfYkYXttCd5A4I=;
        b=qXcRPn68LHTj99gOudde/DEWjMPWZrqRuR25IdKpGsr1gSwt/xhq7xA3r00zubELtE
         4bXqbERNEggpUJLlP9S5G9Ft6zw16owir1dfY1P2CeCUg7w2hiBSDIXAjfBELK3vt/ah
         KRoW+xSDTUg1YbQ6Rth8Qdt4ACr36oyxaPfeMRzVRr3Usu/y7w7wMqhgXEdRM1QUcdhl
         ln4t3miBnZhWjcRPq28mnq7YQ2h6VG3ccNtvjmKdA4bC26t2oi54ndfsFqZdLPaaqabZ
         UX3tC/SOhz9Tt6hWZ26nOWPVqd6bbvTFnpP1uaGHbwyivpO6fOaivNiG0AjG/mfesSG8
         ve+Q==
X-Gm-Message-State: AOAM531mwGyS6NImmSCkSlin/N1aCdxa8uyvH8jlPkAEXQZRyeXL8e6c
        uaf8/NmPrWD8uyK4vAswRfvHxvbC4xTNCcjJi0VKEbOmrVn4n6D1E4LxIgETlBR6yP5BjMtIGRv
        hWi8v5N1BWaYlwSM/s58=
X-Received: by 2002:a17:906:8614:: with SMTP id o20mr34755185ejx.386.1615993333423;
        Wed, 17 Mar 2021 08:02:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQOWxYb9DN6Byzwidr3K3+h7DNGVqQ1iESvq0wrLG4Q+s+bR01GCCD8HQlPCDgUoZNePvlQA==
X-Received: by 2002:a17:906:8614:: with SMTP id o20mr34754705ejx.386.1615993328232;
        Wed, 17 Mar 2021 08:02:08 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id lu26sm11531097ejb.33.2021.03.17.08.02.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 08:02:07 -0700 (PDT)
Subject: Re: AHCI SATA Runtime PM
To:     Alexander Monakov <amonakov@ispras.ru>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>, linux-ide@vger.kernel.org
References: <alpine.LNX.2.20.13.2103041814050.15170@monopod.intra.ispras.ru>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f74cdf09-c08f-5cff-e046-2729aeb703be@redhat.com>
Date:   Wed, 17 Mar 2021 16:02:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.20.13.2103041814050.15170@monopod.intra.ispras.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 3/4/21 4:34 PM, Alexander Monakov wrote:
> Hello, Hans, Linux PM folks,
> 
> I'm looking for clarification regarding this patch discussion:
> 
> https://patchwork.kernel.org/project/linux-pm/patch/20180420101834.15783-2-0v3rdr0n3@gmail.com/
> 
> Hans said,
> 
>> Ah, so the AHCI code has runtime pm enabled by default (so there
>> is another pm_runtime_allow() somewhere, but then disables it for
>> unused ports to make hotpluging something into those ports work.
> 
> I have a laptop where two unused AHCI SATA controllers are present (but
> obviously nothing can be hotplugged into them). Apparently due to the above,
> they do not enter runtime autosuspend.
> 
> The problem is, these "ATA port" nodes don't seem to participate in udev
> hierarchy, so it's unclear how I'm supposed to automatically re-enable
> runtime PM for them. For PCI device nodes, I have
> 
> ACTION=="add", SUBSYSTEM=="pci", TEST=="power/control", ATTR{power/control}="auto"
> 
> but ata1/uevent is empty, so there's no obvious way to write the corresponding
> UDev rule.

You can enable runtime-pm from udev using the following rule:

ACTION=="add", SUBSYSTEM=="ata_port", ATTR{../../power/control}="auto"

> Prior to discovering the above patch discussion, I have filed a bug:
> https://bugzilla.kernel.org/show_bug.cgi?id=211837
> 
> Does the above correctly reflect how AHCI PM is supposed to be?

This is a complicated question, I just checked and according to:
https://www.intel.com/content/www/us/en/io/serial-ata/serial-ata-ahci-spec-rev1-3-1.html

AHCI 1.3 compliant controllers should raise a PME signal on hotplug
changes even when in D3. So perhaps the solution is to catch this signal
and then wakeup the controller; and remove the pm_runtime_forbid(dev); call
from ata_tport_add().

I don't have much experience with dealing with the PME stuff, so you will
need to do some research there, or perhaps someone else can help?

This seems to be more of a sata/ahci question then a generic linux-pm question
though, so I have added Jebns and linux-ide to the To / Cc.

> If so, what is
> the proper way to enable runtime PM for unused ATA ports?

Regards,

Hans

