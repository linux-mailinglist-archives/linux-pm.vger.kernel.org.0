Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECF97E9610
	for <lists+linux-pm@lfdr.de>; Mon, 13 Nov 2023 05:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbjKMETa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Nov 2023 23:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjKMET3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Nov 2023 23:19:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267711735
        for <linux-pm@vger.kernel.org>; Sun, 12 Nov 2023 20:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699849128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h62ZSBXNIpXAn1RjkyzytMnuk1I7FWNselF1cBuUf4A=;
        b=Q1K1WA2CDS+w0P67pzrdq2laEd8TALwxUOfYbuJ22jz7ZzbPMoqy3BVpL4nywomnLfPbN5
        eLa4WYvRcpRMffL+AADrMwEw8kvER0APq0x12eN3/h7NyI6WUFLGoRD9DJUmzsN55bG48Q
        dYvhbygfDPZoNapd+i43DbKpj8XWU5c=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-yejVSVyrPHiAHymmQO45kg-1; Sun, 12 Nov 2023 23:18:46 -0500
X-MC-Unique: yejVSVyrPHiAHymmQO45kg-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6c337ce11ceso5413679b3a.1
        for <linux-pm@vger.kernel.org>; Sun, 12 Nov 2023 20:18:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699849125; x=1700453925;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h62ZSBXNIpXAn1RjkyzytMnuk1I7FWNselF1cBuUf4A=;
        b=lkRTtlHobvy4CiuC48ewmzMuuqtTWI7xnAkGSD4v+3zPbJzJSV2PuN17lr+pJKtxYj
         +8gdcXryI2LlZ8bHLlYkBTRKMUd4woyhFu26IE4mkNAtBfHEeLC5H4+lyIyVUc+LpOP8
         +RRjO65qwOFFtkWijftIZsaiyLytRKRFodKMXXLXOeyg0YaNtGj07OudW3TaJRo0BqAz
         OJaZPw3pUgXJ85RSRcB0UqMuOECKMIddPbifNtBwK0bAVvwVKREfHTA409o8n0Q8sDch
         e7utSRTVFo7IpVzOEno5xbMFIj4ivqQUDt+b+kp+LPyVAalnBOv82ATsmAlJo2YhatC3
         3kAg==
X-Gm-Message-State: AOJu0YzWvQo+/NRnGOZmclM66v3Bu5hL/0WllZR+CxOohRMRtFcc0sA4
        nDAbNrJZP4VbCBcvxstcV+kZfFxWANDRTExJmYc9n+beRAKjscul1RJYc6YtjKuCl4b/rtjO3Ho
        2BGoAqmHPhvDsY9HxYQg=
X-Received: by 2002:a05:6a20:42a4:b0:186:4def:ccc9 with SMTP id o36-20020a056a2042a400b001864defccc9mr3622164pzj.10.1699849125606;
        Sun, 12 Nov 2023 20:18:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFobxPewEpgXbDDZKt4dnfeBouA3YHhqrzoLtSI/jkAmOjDXYCHvtcrl7wlb5s/tPAkxp4efQ==
X-Received: by 2002:a05:6a20:42a4:b0:186:4def:ccc9 with SMTP id o36-20020a056a2042a400b001864defccc9mr3622141pzj.10.1699849125345;
        Sun, 12 Nov 2023 20:18:45 -0800 (PST)
Received: from ?IPV6:2001:8003:e5b0:9f00:b890:3e54:96bb:2a15? ([2001:8003:e5b0:9f00:b890:3e54:96bb:2a15])
        by smtp.gmail.com with ESMTPSA id n24-20020a170902969800b001cc50146b43sm3198590plp.202.2023.11.12.20.18.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Nov 2023 20:18:45 -0800 (PST)
Message-ID: <b6f833a5-49be-4bd9-b31e-143e2fbec2ca@redhat.com>
Date:   Mon, 13 Nov 2023 14:18:35 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 17/22] x86/topology: convert to use
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
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
 <E1r0JM5-00CTyD-Ri@rmk-PC.armlinux.org.uk>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <E1r0JM5-00CTyD-Ri@rmk-PC.armlinux.org.uk>
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
> Convert x86 to use the arch_cpu_is_hotpluggable() helper rather than
> arch_register_cpu().
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>   arch/x86/kernel/topology.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
Reviewed-by: Gavin Shan <gshan@redhat.com>

