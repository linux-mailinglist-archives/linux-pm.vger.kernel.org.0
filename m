Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C1D7E937E
	for <lists+linux-pm@lfdr.de>; Mon, 13 Nov 2023 01:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjKMAJg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Nov 2023 19:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjKMAJf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Nov 2023 19:09:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93865211B
        for <linux-pm@vger.kernel.org>; Sun, 12 Nov 2023 16:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699834132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LZoVE59pXWGm0JQT+CMJNCgS+fu8REHYPUoz78JAFk8=;
        b=VOvWfk3frlAdT2f75dfTeT4ZpG5d7tOblk7SDU2Sr6+8PAbp8SrekcoN47qW7ptdVxKEbW
        1Vc2CiT+MVEgaHAyooP2iKbIddrnbfaESxs1miWd/kE0sKKIWvLT8p6oyk/kk88y9va9tf
        DBPtjbytJr5vcsd+njKmnYTzLMGf/vs=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-gv1-tZYxOIe30POaU5-I6Q-1; Sun, 12 Nov 2023 19:08:51 -0500
X-MC-Unique: gv1-tZYxOIe30POaU5-I6Q-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5b7bf1c206fso3792309a12.2
        for <linux-pm@vger.kernel.org>; Sun, 12 Nov 2023 16:08:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699834130; x=1700438930;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LZoVE59pXWGm0JQT+CMJNCgS+fu8REHYPUoz78JAFk8=;
        b=exT/yFHwLsFBfhgWjajxX6oWRpQA5dL5qtdvdNuRU0c+cq74MmOWfNqCWCDQzujvC7
         HMrSWXkplpqxNvXMzwCHpSaGuUtDfDzcOaR1Dk7WlHUziNf5nmY538I8XsgndQ+uFRdp
         8ozaiB4XRwJ7ktfIw/MMOSgQeGiBR0Ungij83Tz2l2V3cDYcBRRyqkjm2VHKeWjgM94F
         YHH3oc7wuAxaaXUprvIbUWW06w2LftI/mv1wdcsnAh5mT8m1y48vbkh+0Mksexr5wLk0
         6fQXEUqqONxzr22nFgYxXj9WU6jrZtfSDnu1g9pfVQCSzFHULWAkLIdEpUoNpkRJLq0y
         Xi+A==
X-Gm-Message-State: AOJu0Yw/0AfPUBsiYyphox5h7Zky+96cg0uAA6hoA7eXXFZNhAY5oSnt
        wKkc37FApioaqKbLlCPqyUB0J4N+SkCcDgYXB6EmguqlG4HytgUzpsyl5fnO/m2fptw96L8IG3i
        zmGMCb93y3x9U28kQJIw=
X-Received: by 2002:a05:6a20:748b:b0:186:603b:6b53 with SMTP id p11-20020a056a20748b00b00186603b6b53mr1091856pzd.0.1699834130296;
        Sun, 12 Nov 2023 16:08:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuXsyqcDEY3uU8V/1tkBaOM8ZFpVTqspPi9KzQF+bgKRFukH+13LuLcTE/aP13+7JgHA4Nsg==
X-Received: by 2002:a05:6a20:748b:b0:186:603b:6b53 with SMTP id p11-20020a056a20748b00b00186603b6b53mr1091836pzd.0.1699834129822;
        Sun, 12 Nov 2023 16:08:49 -0800 (PST)
Received: from ?IPV6:2001:8003:e5b0:9f00:b890:3e54:96bb:2a15? ([2001:8003:e5b0:9f00:b890:3e54:96bb:2a15])
        by smtp.gmail.com with ESMTPSA id y18-20020a1709027c9200b001b53c8659fesm2998333pll.30.2023.11.12.16.08.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Nov 2023 16:08:49 -0800 (PST)
Message-ID: <baa98649-1840-48aa-89ac-0c27a08559d5@redhat.com>
Date:   Mon, 13 Nov 2023 10:08:40 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 03/22] x86/topology: remove arch_*register_cpu()
 exports
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
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
 <E1r0JKv-00CTwf-R9@rmk-PC.armlinux.org.uk>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <E1r0JKv-00CTwf-R9@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/7/23 20:29, Russell King (Oracle) wrote:
> arch_register_cpu() and arch_unregister_cpu() are not used by anything
> that can be a module - they are used by drivers/base/cpu.c and
> drivers/acpi/acpi_processor.c, neither of which can be a module.
> 
> Remove the exports.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>   arch/x86/kernel/topology.c | 2 --
>   1 file changed, 2 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

