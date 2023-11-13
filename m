Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C4C7E9376
	for <lists+linux-pm@lfdr.de>; Mon, 13 Nov 2023 01:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbjKMAFG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Nov 2023 19:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjKMAFG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Nov 2023 19:05:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF861FE5
        for <linux-pm@vger.kernel.org>; Sun, 12 Nov 2023 16:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699833856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M1WVqrzwlUh2mFk7/OXOeRxfOSDsmH8Tq2hZjVjJnnk=;
        b=ULED0UdkevXxnpA529ii6wMpCVsfN8KO7P6nj/NfqSRyTgrRXPxf1+HFa8aVupeZHx/uG8
        /HG1+S69vheKq+lRm84cXzO1vrkc3/XHKZxib1McgCTLqMesKaBEIXAaHDru4j7tjaYiUB
        g2lIIjgzwY/J18hOz6z/GadyCIqFTYk=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-ur0zzIvnMQyTaLt_TceEZg-1; Sun, 12 Nov 2023 19:04:14 -0500
X-MC-Unique: ur0zzIvnMQyTaLt_TceEZg-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6b243dc6aeeso3919037b3a.3
        for <linux-pm@vger.kernel.org>; Sun, 12 Nov 2023 16:04:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699833854; x=1700438654;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M1WVqrzwlUh2mFk7/OXOeRxfOSDsmH8Tq2hZjVjJnnk=;
        b=FzLVHzrUP6JkJhPBaLxIXlBuyJpDF2mswhyKINL8NXj63ScWqefVubwtEtfvWweN6E
         TQRlYPFEMMR3d3gkuRRvqxvzak0GMZzFVVWNPsxMLSfBnSZx59eIv8DJfxunnDldcxFG
         E0BFUHutVqZBvcfJE0cwUid6NP2p9zsIr1AK7gwf+8PZmMEE/elqoijemjh5ubDxCwnW
         jh+yf9sFM34QQjVxgwbtQuT+iQJ9kPsstQv3c7KnABIFcVrjEuY78qya/C4sAVcOGD0s
         NS8YjljpsIu13vpvNntUjmllhR8tciAaHV/w153zPh4od29oSx2QQPOIOjnFUUe+S9qh
         KANQ==
X-Gm-Message-State: AOJu0YwF0LKoLb02bmKZ3vQUog0jj+IaVVgkPuv28UhlZWOH8k3SyV91
        6DwVF3s4k9qUvGL6FZbyJY8wEKsxFtWaWS2Thjq6ot1kjZZqUibZHlmtf6AB9+HhnlHTsVT6A3p
        5VxCQpBTGeD2TTxxWqBI=
X-Received: by 2002:a05:6a20:4b17:b0:180:eef7:b3bf with SMTP id fp23-20020a056a204b1700b00180eef7b3bfmr2894311pzb.52.1699833853850;
        Sun, 12 Nov 2023 16:04:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVhoHB7vfaN82g5SuEmn8wzwgzjtloVlrEIKNxLO/QhN9bWo7fbjYF4amHORPXU4K9sObvCw==
X-Received: by 2002:a05:6a20:4b17:b0:180:eef7:b3bf with SMTP id fp23-20020a056a204b1700b00180eef7b3bfmr2894294pzb.52.1699833853518;
        Sun, 12 Nov 2023 16:04:13 -0800 (PST)
Received: from ?IPV6:2001:8003:e5b0:9f00:b890:3e54:96bb:2a15? ([2001:8003:e5b0:9f00:b890:3e54:96bb:2a15])
        by smtp.gmail.com with ESMTPSA id jj3-20020a170903048300b001cc29ffcd96sm3038705plb.192.2023.11.12.16.04.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Nov 2023 16:04:13 -0800 (PST)
Message-ID: <cf5a08b3-c8f0-438e-a7ba-c34d684dac42@redhat.com>
Date:   Mon, 13 Nov 2023 10:04:06 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 01/22] arch_topology: Make
 register_cpu_capacity_sysctl() tolerant to late CPUs
Content-Language: en-US
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
        x86@kernel.org, linux-csky@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org
Cc:     Salil Mehta <salil.mehta@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com,
        James Morse <james.morse@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
 <E1r0JKl-00CTwT-Hx@rmk-PC.armlinux.org.uk>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <E1r0JKl-00CTwT-Hx@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/7/23 20:29, Russell King (Oracle) wrote:
> From: James Morse <james.morse@arm.com>
> 
> register_cpu_capacity_sysctl() adds a property to sysfs that describes
> the CPUs capacity. This is done from a subsys_initcall() that assumes
> all possible CPUs are registered.
> 
> With CPU hotplug, possible CPUs aren't registered until they become
> present, (or for arm64 enabled). This leads to messages during boot:
> | register_cpu_capacity_sysctl: too early to get CPU1 device!
> and once these CPUs are added to the system, the file is missing.
> 
> Move this to a cpuhp callback, so that the file is created once
> CPUs are brought online. This covers CPUs that are added late by
> mechanisms like hotplug.
> One observable difference is the file is now missing for offline CPUs.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> If the offline CPUs thing is a problem for the tools that consume
> this value, we'd need to move cpu_capacity to be part of cpu.c's
> common_cpu_attr_groups.
> ---
>   drivers/base/arch_topology.c | 38 ++++++++++++++++++++++++------------
>   1 file changed, 26 insertions(+), 12 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

