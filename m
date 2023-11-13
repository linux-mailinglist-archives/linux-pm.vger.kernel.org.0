Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D345C7E93AA
	for <lists+linux-pm@lfdr.de>; Mon, 13 Nov 2023 01:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbjKMAnr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Nov 2023 19:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjKMAnq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Nov 2023 19:43:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBDD19B4
        for <linux-pm@vger.kernel.org>; Sun, 12 Nov 2023 16:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699836179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iQsxdmKsC9+VQQMbyUjXPaZGEeJW41wCAFBZ7vfsBQE=;
        b=Dz9tAZKeZQLH5kwYITJxIMehuSh3eiJZPHUVm3e56fVkCUGYcUX4SMD96kzjjjfeEBvBWO
        ja2ErnaDNIL2aU4TkWJ2I7vVcDYIz6OZcoIV1GdbNW5oRWPS/shS68yqrFmshG+Jp8GVkD
        PlNBETdihDlfhBH+I/U0bQg4CablLds=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-8QtC7scpNc6WiSEd972CSg-1; Sun, 12 Nov 2023 19:42:57 -0500
X-MC-Unique: 8QtC7scpNc6WiSEd972CSg-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6baaa9c0b9fso3630647b3a.2
        for <linux-pm@vger.kernel.org>; Sun, 12 Nov 2023 16:42:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699836176; x=1700440976;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iQsxdmKsC9+VQQMbyUjXPaZGEeJW41wCAFBZ7vfsBQE=;
        b=DmeRHCztUBuxm++hD29EuMsWF6BXgt9ouzsZlA+por6do8ilA6zKQTggZtOSxob2jg
         VjTmryPnGC37J0lKxV3xZuDMGTTH5W8klQgIGsSZ/xWACOuls2o2iWndNOs+WzCpaW4p
         ysdKuXg2THxzx6fZyZgsfY7r9sYQ6114WyYA0rLVNknWk0PJ8SP7M2D73mxJGzGuSjcZ
         WjkZQVuaiDJygGc1KlNLs1nngqpgZkb/TAaskAT/yPjSDllQpB5TRSOY10wq4dTLfP/R
         rDRO+x5WaBBmCxTvVLfb5WHxkgUtp9ICgiKjGo9GnG+ZpOwmmq0nRBbjJ+E1xNmD2LlI
         nZ+A==
X-Gm-Message-State: AOJu0Yynr/D89VM5hE2azyCE3OF1pcHHooG4DJyAH0h5XFVJKKu9af88
        MGySzc1BZc76h4EGRcBWXGySCcX0HHYZsG9Bzss2bKOTheUVGLREpYTPq8o/6hStjYPjoNBkod3
        x51GjrL7J4M9RcANAuQw=
X-Received: by 2002:a05:6a20:7494:b0:174:373b:4381 with SMTP id p20-20020a056a20749400b00174373b4381mr3583329pzd.49.1699836176464;
        Sun, 12 Nov 2023 16:42:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+UqzLZrYxi+tnG161U/VKxrumNhVvJntX1X+LzLVicHXhCNQwDg9kYlUeFf4mFvRVo9YyxA==
X-Received: by 2002:a05:6a20:7494:b0:174:373b:4381 with SMTP id p20-20020a056a20749400b00174373b4381mr3583318pzd.49.1699836176231;
        Sun, 12 Nov 2023 16:42:56 -0800 (PST)
Received: from ?IPV6:2001:8003:e5b0:9f00:b890:3e54:96bb:2a15? ([2001:8003:e5b0:9f00:b890:3e54:96bb:2a15])
        by smtp.gmail.com with ESMTPSA id q23-20020a62e117000000b006c0328b2440sm2948031pfh.150.2023.11.12.16.42.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Nov 2023 16:42:55 -0800 (PST)
Message-ID: <a51eab2e-5d23-420a-a46e-aad79af1ad50@redhat.com>
Date:   Mon, 13 Nov 2023 10:42:46 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 07/22] drivers: base: Allow parts of
 GENERIC_CPU_DEVICES to be overridden
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
 <E1r0JLG-00CTx8-CG@rmk-PC.armlinux.org.uk>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <E1r0JLG-00CTx8-CG@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/7/23 20:29, Russell King (Oracle) wrote:
> From: James Morse <james.morse@arm.com>
> 
> Architectures often have extra per-cpu work that needs doing
> before a CPU is registered, often to determine if a CPU is
> hotpluggable.
> 
> To allow the ACPI architectures to use GENERIC_CPU_DEVICES, move
> the cpu_register() call into arch_register_cpu(), which is made __weak
> so architectures with extra work can override it.
> This aligns with the way x86, ia64 and loongarch register hotplug CPUs
> when they become present.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> Changes since RFC:
>   * Dropped __init from x86/ia64 arch_register_cpu()
> Changes since RFC v2:
>   * Dropped unnecessary Loongarch asm/cpu.h changes
> ---
>   drivers/base/cpu.c  | 14 ++++++++++----
>   include/linux/cpu.h |  4 ++++
>   2 files changed, 14 insertions(+), 4 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

