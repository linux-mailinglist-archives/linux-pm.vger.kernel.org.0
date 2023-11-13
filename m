Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BFD7E962D
	for <lists+linux-pm@lfdr.de>; Mon, 13 Nov 2023 05:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbjKMEZY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Nov 2023 23:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjKMEZX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Nov 2023 23:25:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684121735
        for <linux-pm@vger.kernel.org>; Sun, 12 Nov 2023 20:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699849478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+XpkXMncYpwBWWz5YM4lExGVyIZbJdd8k4LtapRIRSU=;
        b=CqiSUF2OOoz7FDL8zJB1fpVBOFcXzYHcqyThP9jZgY4tu7iXzvwbC8ZhMoGYldCriGk3uF
        aRzYE69HUo44bFM8lx7cmgMcaXmnaKS4dWO6j5qm9HYPwlZMzJpU3LQVpCboPJppZMQ9g5
        VWTmZTRlDhmu6IH28mpkhmgqsUuhzEw=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-ahcnUWz5Nai01obddT2DZA-1; Sun, 12 Nov 2023 23:24:36 -0500
X-MC-Unique: ahcnUWz5Nai01obddT2DZA-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3b2e2487c6bso4666287b6e.2
        for <linux-pm@vger.kernel.org>; Sun, 12 Nov 2023 20:24:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699849475; x=1700454275;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+XpkXMncYpwBWWz5YM4lExGVyIZbJdd8k4LtapRIRSU=;
        b=LFBcr36HmwjrOtyRpe2adkg+WQ4CAxlj8nw4YASXbpoOj8hMxH2DP1D311S9W5NLN8
         vvBSdy2hyhzKmIFW07MtW/oDkIhPHd+/lRdN+So5iVd/MRvqMCtqHh0nGg7hqLcCiq9w
         IeLA9cY+6CyGAEOMMrzKHSRjc63HgdgHJ64JeAT602krzgpD3sCdv4M4u+aANzxQqiWU
         F+s6JQFlM1Rb//yMlHdPqd3/6+VOG/5Qv9hvaZ1ndpuTpUB4FRkuDVYBjMAZRYmdzRRI
         CBSKp0T3fDEhtfrLMZTjSZlCrhMTkrQFMR4Lk9QzBQlCmlopRP5RGZyCwzAeNAYY+nla
         Pw0g==
X-Gm-Message-State: AOJu0YwEjPXPquF9gCSVH3VttTITj5QTuTeDO/KgIa6fvlm/WE3HkAf4
        ii2qmtdvczoBPsmPbModz3CSdbAuUpJZRHPWkb1pzykefNPhd8/qcmGJcVHfP5oc9tOAN+THKbI
        sTSRy1UAFlsKxd9dKnWs=
X-Received: by 2002:a05:6808:1907:b0:3b2:a9bd:c38f with SMTP id bf7-20020a056808190700b003b2a9bdc38fmr8909961oib.37.1699849475407;
        Sun, 12 Nov 2023 20:24:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGpLquY73YkMUU9Mlaw3xcZEgmE+1wMz9SoOzUS3eERBYDajACgA3kg4BM9OvwoIC+iQZINQ==
X-Received: by 2002:a05:6808:1907:b0:3b2:a9bd:c38f with SMTP id bf7-20020a056808190700b003b2a9bdc38fmr8909944oib.37.1699849475200;
        Sun, 12 Nov 2023 20:24:35 -0800 (PST)
Received: from ?IPV6:2001:8003:e5b0:9f00:b890:3e54:96bb:2a15? ([2001:8003:e5b0:9f00:b890:3e54:96bb:2a15])
        by smtp.gmail.com with ESMTPSA id fm6-20020a056a002f8600b006c4db182074sm3111661pfb.196.2023.11.12.20.24.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Nov 2023 20:24:34 -0800 (PST)
Message-ID: <d07a9e11-9752-4155-bbaf-b759ec4f99ac@redhat.com>
Date:   Mon, 13 Nov 2023 14:24:27 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 22/22] riscv: convert to use
 arch_cpu_is_hotpluggable()
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
 <E1r0JMV-00CTyh-It@rmk-PC.armlinux.org.uk>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <E1r0JMV-00CTyh-It@rmk-PC.armlinux.org.uk>
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
> Convert riscv to use the arch_cpu_is_hotpluggable() helper rather than
> arch_register_cpu().
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>   arch/riscv/kernel/setup.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

