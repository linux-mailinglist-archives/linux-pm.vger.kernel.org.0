Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141FC7E960C
	for <lists+linux-pm@lfdr.de>; Mon, 13 Nov 2023 05:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbjKMERd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Nov 2023 23:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233111AbjKMERb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Nov 2023 23:17:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABFE1732
        for <linux-pm@vger.kernel.org>; Sun, 12 Nov 2023 20:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699849002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7aB5COy4QAe+eFccHV1YqyKzO84zBoVzPy0R2GMj01o=;
        b=hUvvdqtyCi5jfCJAKsSc3amNcmqs75DzyhnEXm2yR4dCpZbhn2M+esF3MxLinCeDvm2Phx
        NgVLtePNho+Yaj3S842B+tbcaqKxflS85S+am333fUu0TFTGLPMVNpkut5hfaHPsYQeHrb
        3QMH8fcLL7iTc0t15ClwyWDCW2Vykxw=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-CzP39j3eN7uV87tyaz2nwg-1; Sun, 12 Nov 2023 23:16:40 -0500
X-MC-Unique: CzP39j3eN7uV87tyaz2nwg-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-280997b23eeso3763483a91.3
        for <linux-pm@vger.kernel.org>; Sun, 12 Nov 2023 20:16:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699848999; x=1700453799;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7aB5COy4QAe+eFccHV1YqyKzO84zBoVzPy0R2GMj01o=;
        b=X7cAv39W5LofTgq4VOFtsVUbSTl33HWpYEv0aqOJCl5VK8gt6IVfLc0L83A+AAMObw
         DREIwrjf7bTiNmHSlptcCVxPKJZRbnxgVMXzChxbpMEuQig9CDvGHMF/HTJ+BJ19b771
         jMzucA8VXhLlsw6KfOoeNHOmQWFJJ/QvxA8ikoLoQ/1GegfLhpluBLjTdshjQvXLWHGB
         KfV6j87OzRCtOhYKRxYhqgyB/DN2n2HYyot5+2Dpb5nU2L1pfiDSUsp10INN1oIJ4WLy
         5Cro+pSFrSaGIS7K9dhYdIQYHI6hLRYhLPXxSLknh+z+ggJCNG6G5O/LHIcDTTDSVgMo
         YpyQ==
X-Gm-Message-State: AOJu0YzRspeGMxPiVYsidu8t/WWNmjQl2GpcYv0SUqSGqEG2QgBeI5OZ
        Dipj//8WBZPnpVM9rPMugOebOvQw/Xaa/7TYAPULz146H6/NCoobcE8lMcAWsPDhaoKj7TbA3ix
        mQuszXXBg8sFVUgGSfzI=
X-Received: by 2002:a17:90b:4b90:b0:27f:fc2f:4831 with SMTP id lr16-20020a17090b4b9000b0027ffc2f4831mr3808819pjb.13.1699848999525;
        Sun, 12 Nov 2023 20:16:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExSJF7Sr4fxZ4SaXBfj45m19uu6J8O0+tvnJdz59Xz+72h6hZwy5AtBFfiTF4Ru6jPNTRc+w==
X-Received: by 2002:a17:90b:4b90:b0:27f:fc2f:4831 with SMTP id lr16-20020a17090b4b9000b0027ffc2f4831mr3808799pjb.13.1699848999237;
        Sun, 12 Nov 2023 20:16:39 -0800 (PST)
Received: from ?IPV6:2001:8003:e5b0:9f00:b890:3e54:96bb:2a15? ([2001:8003:e5b0:9f00:b890:3e54:96bb:2a15])
        by smtp.gmail.com with ESMTPSA id mg5-20020a17090b370500b00282ec3582f1sm2976159pjb.34.2023.11.12.20.16.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Nov 2023 20:16:38 -0800 (PST)
Message-ID: <fa717944-2f92-48f6-ad70-1c58ffe61b86@redhat.com>
Date:   Mon, 13 Nov 2023 14:16:29 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 16/22] x86/topology: use weak version of
 arch_unregister_cpu()
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
 <E1r0JM0-00CTy7-NL@rmk-PC.armlinux.org.uk>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <E1r0JM0-00CTy7-NL@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/7/23 20:30, Russell King (Oracle) wrote:
> Since the x86 version of arch_unregister_cpu() is the same as the weak
> version, drop the x86 specific version.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> Changes since RFC v3:
>   * Adapt to removal of EXPORT_SYMBOL()s
> ---
>   arch/x86/kernel/topology.c | 5 -----
>   1 file changed, 5 deletions(-)
> 

PATCH[16/22] can be folded to PATCH[15/22] since arch_unregister_cpu() was just
added in PATCH[15/22]. Anyway, the changes make sense to me.

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/arch/x86/kernel/topology.c b/arch/x86/kernel/topology.c
> index c2ed3145a93b..211863cb5b81 100644
> --- a/arch/x86/kernel/topology.c
> +++ b/arch/x86/kernel/topology.c
> @@ -43,9 +43,4 @@ int arch_register_cpu(int cpu)
>   	c->hotpluggable = cpu > 0;
>   	return register_cpu(c, cpu);
>   }
> -
> -void arch_unregister_cpu(int num)
> -{
> -	unregister_cpu(&per_cpu(cpu_devices, num));
> -}
>   #endif /* CONFIG_HOTPLUG_CPU */

