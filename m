Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8395D7E93D0
	for <lists+linux-pm@lfdr.de>; Mon, 13 Nov 2023 01:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjKMA57 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Nov 2023 19:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbjKMA56 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Nov 2023 19:57:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2751FF5
        for <linux-pm@vger.kernel.org>; Sun, 12 Nov 2023 16:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699837028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JSnhv2PPOYa4ZnCU0cai1bmRuczHu96zHiRWZODUn4U=;
        b=JIEKbx0iSQdpX0FzLBFeca4pVo9PpRzKrNE5sISMEF1tFi1eCuP+8sR/YBVpTFFnHRdvt6
        ya7HB9jqGdgH/BPKJTcYFSgyUFhDH5Y2G3hWygrkQyftU+3MLhhIxc+z70qQYeHmnL+QYu
        WDdJ26M6r3kSDk0YUbQUk0/YbjG/aDI=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-igr5_kvINxeHJfmnoNTelA-1; Sun, 12 Nov 2023 19:57:07 -0500
X-MC-Unique: igr5_kvINxeHJfmnoNTelA-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1cc42d3f61eso43815165ad.3
        for <linux-pm@vger.kernel.org>; Sun, 12 Nov 2023 16:57:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699837026; x=1700441826;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JSnhv2PPOYa4ZnCU0cai1bmRuczHu96zHiRWZODUn4U=;
        b=Bba8YArgFfV9TIgCOiXX19Qr35XSUjmbcPK/cJ+QG4BTIlvmS2484fQTV8zT4YfI2W
         NgUgp9UXyq88ul6NPV3PyPBwXuL90KuSeW1/7jZB7h/M+2Cm/uktrJbWpxkXsafPWCto
         AdvfRW0cd9YhghjHbCo4E7Lvnqp0taUqXFnGAsuz8dHHt8mjyVv3CxlV0CvrFs/0pkbh
         x8CReyt0wTHr2+hMTrmh1jaYl/NcD61A/mxaUkW5d3mF88hyQyWFQjzK7pJrDsHYAv6e
         ivrO5DHRr95ig1qHgAkUlbvN4pE54ZAMWx/gX7QpjJiMh9GEj+ZeKSgQ6n7/4STFQYWF
         v+4Q==
X-Gm-Message-State: AOJu0YxAr0EOHKAMwW10TmaaD8wHrjVeOeBsGSNO99P0GO09WdoWc0qA
        Qh7JBDBrMUUUAAmqSz+M4SLZIDAe3KJt3Dh0srGzmApu4+2WsoENBf4QdPWIU5TJGPAqXPe1Mbc
        arWSHe61ZSolWa814wYg=
X-Received: by 2002:a17:903:41c1:b0:1cc:5ed4:7b4c with SMTP id u1-20020a17090341c100b001cc5ed47b4cmr8056811ple.35.1699837026078;
        Sun, 12 Nov 2023 16:57:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYB8Gjvjb9rpzJlKa/gGoy1/kAMp5o6DcRuutNzYMQOmMyg/HSI8WRyf/v5bwebYCVyW6+ig==
X-Received: by 2002:a17:903:41c1:b0:1cc:5ed4:7b4c with SMTP id u1-20020a17090341c100b001cc5ed47b4cmr8056788ple.35.1699837025799;
        Sun, 12 Nov 2023 16:57:05 -0800 (PST)
Received: from ?IPV6:2001:8003:e5b0:9f00:b890:3e54:96bb:2a15? ([2001:8003:e5b0:9f00:b890:3e54:96bb:2a15])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902eec400b001b03f208323sm3058989plb.64.2023.11.12.16.56.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Nov 2023 16:57:05 -0800 (PST)
Message-ID: <2c597d46-9e15-4059-9386-a811fa7b65dd@redhat.com>
Date:   Mon, 13 Nov 2023 10:56:56 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 09/22] drivers: base: add arch_cpu_is_hotpluggable()
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
 <E1r0JLQ-00CTxK-Ln@rmk-PC.armlinux.org.uk>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <E1r0JLQ-00CTxK-Ln@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/7/23 20:30, Russell King (Oracle) wrote:
> The differences between architecture specific implementations of
> arch_register_cpu() are down to whether the CPU is hotpluggable or not.
> Rather than overriding the weak version of arch_register_cpu(), provide
> a function that can be used to provide this detail instead.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>   drivers/base/cpu.c  | 11 ++++++++++-
>   include/linux/cpu.h |  1 +
>   2 files changed, 11 insertions(+), 1 deletion(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

