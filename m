Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E077E9627
	for <lists+linux-pm@lfdr.de>; Mon, 13 Nov 2023 05:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjKMEYo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Nov 2023 23:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjKMEYn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Nov 2023 23:24:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38743199E
        for <linux-pm@vger.kernel.org>; Sun, 12 Nov 2023 20:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699849432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MDzN//cB8A0tsFhYQj2uRkfSHm3F/Ien9J3CTjaN2xA=;
        b=VG+F68yKrS/JhmJCO4dCDhBlogYFX/SOJfnBjxPhXGnhTqMfoMP9spIGSoRDO1JVZID8IM
        lS/Lj2Uxnst0xlrihEDtx1sIFUY7sm3CotstcKXTwiLLSi5aHDhq1eZGmP2LrWce7CyoRq
        gVaHwPV77s+IZkhJc2vvHcSKM98LPYs=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-VU9iayIgN0SoJ2gs-IBfuA-1; Sun, 12 Nov 2023 23:23:50 -0500
X-MC-Unique: VU9iayIgN0SoJ2gs-IBfuA-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5abf640f19aso4665752a12.2
        for <linux-pm@vger.kernel.org>; Sun, 12 Nov 2023 20:23:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699849429; x=1700454229;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MDzN//cB8A0tsFhYQj2uRkfSHm3F/Ien9J3CTjaN2xA=;
        b=YYTVLckRCRB4X11aoa4jCAALlIhqPE68LjhlsvlQlkwOCocQZZiRVKgdiWxNTVCUhG
         3agk4Lae9RdsCxi3KTNtHEThWypAahYTIj8w0Y4TxhZT/bnqWW6cQLkX/u5HUDhk5jxj
         HVOk4FknGoePRa6E+Gk5jJMDX1C8v3aINd+//N9jE6wFt4WtGEv6QpgGC8W2ovaSN1c4
         ASZW8XL7Hi2Nyv57aYwJdc91mknBNqnmMJCWm7Yrhwu6T2ntqhUC3nYOTOas7mG0nkUu
         VjM8LscctTuU+VPkiVtpFCtNuPQTnbGna8pbNtJPZnQXzRbqsO687kPLAUaVKcaqD6vm
         osaw==
X-Gm-Message-State: AOJu0YxbeS+/Q6rZ5gpr0MhGD9hfAz68tXOqkDEs+30Yxt8Y2ZyoUNdC
        5v5f9TjnZGZfR276ayU04cShRNWzvMM82X20crbXb3PaR4VWo76JgraBliCBf/YRNb+LjyIsj8z
        +yTXazUI1vhvf8CaUMMc=
X-Received: by 2002:a05:6a20:7292:b0:177:690a:7978 with SMTP id o18-20020a056a20729200b00177690a7978mr7173305pzk.33.1699849429676;
        Sun, 12 Nov 2023 20:23:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFskzK66afv7E0dvEEzwtWe0LILd1YSCQ10I8JNRY4PU48BJW4/+U8P1g/k7SE3CEH/9dkMnA==
X-Received: by 2002:a05:6a20:7292:b0:177:690a:7978 with SMTP id o18-20020a056a20729200b00177690a7978mr7173300pzk.33.1699849429425;
        Sun, 12 Nov 2023 20:23:49 -0800 (PST)
Received: from ?IPV6:2001:8003:e5b0:9f00:b890:3e54:96bb:2a15? ([2001:8003:e5b0:9f00:b890:3e54:96bb:2a15])
        by smtp.gmail.com with ESMTPSA id fm6-20020a056a002f8600b006c4db182074sm3111661pfb.196.2023.11.12.20.23.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Nov 2023 20:23:48 -0800 (PST)
Message-ID: <9dc3a438-930f-4503-af91-12771bdb7738@redhat.com>
Date:   Mon, 13 Nov 2023 14:23:41 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 21/22] riscv: Switch over to GENERIC_CPU_DEVICES
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
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
 <E1r0JMQ-00CTyb-Ee@rmk-PC.armlinux.org.uk>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <E1r0JMQ-00CTyb-Ee@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/7/23 20:31, Russell King (Oracle) wrote:
> From: James Morse <james.morse@arm.com>
> 
> Now that GENERIC_CPU_DEVICES calls arch_register_cpu(), which can be
> overridden by the arch code, switch over to this to allow common code
> to choose when the register_cpu() call is made.
> 
> This allows topology_init() to be removed.
> 
> This is an intermediate step to the logic being moved to drivers/acpi,
> where GENERIC_CPU_DEVICES will do the work when booting with acpi=off.
> 
> This patch also has the effect of moving the registration of CPUs from
> subsys to driver core initialisation, prior to any initcalls running.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> Changes since RFC v2:
>   * Add note about initialisation order change.
> ---
>   arch/riscv/Kconfig        |  1 +
>   arch/riscv/kernel/setup.c | 19 ++++---------------
>   2 files changed, 5 insertions(+), 15 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

