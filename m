Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27977E95E8
	for <lists+linux-pm@lfdr.de>; Mon, 13 Nov 2023 05:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbjKMEIc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Nov 2023 23:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbjKMEIb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Nov 2023 23:08:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB90BE
        for <linux-pm@vger.kernel.org>; Sun, 12 Nov 2023 20:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699848467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4vPpPFrFkMrzqnxNhFYjlLboUr7aR9ku5ew8hulbyck=;
        b=Tl0rzoI74P3uRhdZNOWfq9ghanjrVgBgRFf0yMpA6exJql/JFGnqPFqP36LHOhwBWEu5TP
        VpSX+G7yodqh/PGPrisxDN7OklAmfrUaQZsekZxMRbRVDFhx/SBKizBXv7b1lBqXGoO705
        xdOdXInOafXfa8jEoqAEDdHpe17wDjw=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-yax-XJPRMdeQSWbH6K9EfA-1; Sun, 12 Nov 2023 23:07:46 -0500
X-MC-Unique: yax-XJPRMdeQSWbH6K9EfA-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1cc1682607eso45360135ad.1
        for <linux-pm@vger.kernel.org>; Sun, 12 Nov 2023 20:07:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699848465; x=1700453265;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4vPpPFrFkMrzqnxNhFYjlLboUr7aR9ku5ew8hulbyck=;
        b=VrOEZu4nfnJ/7CxR/rrmDzLCA/Wh7SxEcry+0GQcE5EogCEcTbrtQFviwcCYFrjPa8
         WhoiQDGX1wQz7qFSIq29XUJKnj/k/POmLvo0zpw0b4LL+4nPht3pEcImtJcCLfTo2qe/
         qrwkVhONwSah0yqZOYK/aDFngM9mX2/YAVD3lyJ7zI7NlapmGle8/G4uAORNn/86pIfr
         cfIGeFRic5kmnZO9VtC470LxLjiv3fUHvD4BgVVF3eZZswkRCudEAfB0bokT+DG0xoJF
         9URsZlt6f/z+OjwXqR4frc6Lu2ySRhTlChPai9YqJgcuz4lnUlxCk2+H1gPxgwbc+fMy
         LMmA==
X-Gm-Message-State: AOJu0Yx+6t3LFu2/irhc/wLveCvHSum8hKFX6FGCweF5XDRNIFFZpptk
        fVO30/m+yhtK2Qdx3AvAQa6lehjCIqpReEVAER/mKHkVJU76ejs1+YWkZ9LaVlk8r/F3u3STBLc
        M6G6Fm9FNE6WPPd1rG1I=
X-Received: by 2002:a17:903:18f:b0:1c9:b2c1:139c with SMTP id z15-20020a170903018f00b001c9b2c1139cmr7261827plg.62.1699848465402;
        Sun, 12 Nov 2023 20:07:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWMylLMVWpWug6Cxx/NC9nXPjOFm1HEloPQE99Sn7p/Alc1N4hJ0inQY3toOaSbmTdKDWFaA==
X-Received: by 2002:a17:903:18f:b0:1c9:b2c1:139c with SMTP id z15-20020a170903018f00b001c9b2c1139cmr7261816plg.62.1699848465098;
        Sun, 12 Nov 2023 20:07:45 -0800 (PST)
Received: from ?IPV6:2001:8003:e5b0:9f00:b890:3e54:96bb:2a15? ([2001:8003:e5b0:9f00:b890:3e54:96bb:2a15])
        by smtp.gmail.com with ESMTPSA id b1-20020a170903228100b001cc3098c9f8sm3225162plh.275.2023.11.12.20.07.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Nov 2023 20:07:44 -0800 (PST)
Message-ID: <a6fe7a98-d215-4639-9949-b0044313681f@redhat.com>
Date:   Mon, 13 Nov 2023 14:07:36 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 13/22] arm64: setup: Switch over to
 GENERIC_CPU_DEVICES using arch_register_cpu()
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
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
 <E1r0JLl-00CTxk-7O@rmk-PC.armlinux.org.uk>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <E1r0JLl-00CTxk-7O@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/7/23 20:30, Russell King (Oracle) wrote:
> From: James Morse <james.morse@arm.com>
> 
> To allow ACPI's _STA value to hide CPUs that are present, but not
> available to online right now due to VMM or firmware policy, the
> register_cpu() call needs to be made by the ACPI machinery when ACPI
> is in use. This allows it to hide CPUs that are unavailable from sysfs.
> 
> Switching to GENERIC_CPU_DEVICES is an intermediate step to allow all
> five ACPI architectures to be modified at once.
> 
> Switch over to GENERIC_CPU_DEVICES, and provide an arch_register_cpu()
> that populates the hotpluggable flag. arch_register_cpu() is also the
> interface the ACPI machinery expects.
> 
> The struct cpu in struct cpuinfo_arm64 is never used directly, remove
> it to use the one GENERIC_CPU_DEVICES provides.
> 
> This changes the CPUs visible in sysfs from possible to present, but
> on arm64 smp_prepare_cpus() ensures these are the same.
> 
> This patch also has the effect of moving the registration of CPUs from
> subsys to driver core initialisation, prior to any initcalls running.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> Changes since RFC v2:
>   * Add note about initialisation order change.
> ---
>   arch/arm64/Kconfig           |  1 +
>   arch/arm64/include/asm/cpu.h |  1 -
>   arch/arm64/kernel/setup.c    | 13 ++++---------
>   3 files changed, 5 insertions(+), 10 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

