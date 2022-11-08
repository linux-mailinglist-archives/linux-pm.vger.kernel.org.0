Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A1F621BAB
	for <lists+linux-pm@lfdr.de>; Tue,  8 Nov 2022 19:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbiKHSRB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Nov 2022 13:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiKHSRA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Nov 2022 13:17:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16C02AC0
        for <linux-pm@vger.kernel.org>; Tue,  8 Nov 2022 10:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667931365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZTIBa2EoHKouDchxz00pEnvssDa8XaOxrzzltTEMXIY=;
        b=hV7NEGejUybve0ujYIZjuRpndazQBHCr/SgyOcfoBGdDba8fow5ccprAwEgpSV8j2l7+9U
        LD8ITwOmsHax7R3VySDXaUH6sxFRm6UY1oGwawc/nE8BYOnYVpagQhc6w3TlT54d3SKebS
        5nDAjydJscffDslLtCpLQGz52Pg4Ggw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-212-W7T-gyGkP_ykAW5ee96F-w-1; Tue, 08 Nov 2022 13:16:04 -0500
X-MC-Unique: W7T-gyGkP_ykAW5ee96F-w-1
Received: by mail-ej1-f70.google.com with SMTP id dn14-20020a17090794ce00b007ae5d040ca8so4093401ejc.17
        for <linux-pm@vger.kernel.org>; Tue, 08 Nov 2022 10:16:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZTIBa2EoHKouDchxz00pEnvssDa8XaOxrzzltTEMXIY=;
        b=aKuDzQPQCIgzkhuWzPrWx/JaSys/xB5T4m3d3eNHy0r1Ryd+QGtvhdee/HmPGjfwR+
         37DSysYubAF+GAWrMv/piEC7LPBuyLhrf+B2DPP3IxZC86KDSe0DsTMtE6xK3lVE1LKg
         ymKd7RDzET+7022N/xTsb88a7z9F/4iCkvZSPzUOWLZ1FfzzN6KYTA7f3VAw/j/KrP+m
         74AJP1OyvEktaHsm3AaNJfDrmDO9yKeuLAF0pG4vvkF2Y1obYqIVq1dJeO6YcTRvaUsB
         rtT90TvXYvOo4T+XXvglBvZ6Cq4Of6f4bu0MrbIwKL4akeg+fnOavzF5GB5MyTBFBm3k
         koyA==
X-Gm-Message-State: ACrzQf04OppujaemRfHrTQTJLDuLTBHT0ZSjU5crQR6ztOdLmdve8NlT
        eX3wQ92tAkgs5WL6W49f3K9zbP4jNeHpqEBjTja+l87Yp7vu2iZUGM9SUZYFPbQ07J+2QB38CFZ
        bA7P3Xu4phACWhm35Jgw=
X-Received: by 2002:a17:907:3c81:b0:77a:327a:815f with SMTP id gl1-20020a1709073c8100b0077a327a815fmr54564484ejc.422.1667931363324;
        Tue, 08 Nov 2022 10:16:03 -0800 (PST)
X-Google-Smtp-Source: AMsMyM5pJ1gWaZO7zCl2dRv1Xd1OC947aJBNtyNjqc/4bKCF3+TjI71d6gYnGj9wDCBS4Dbcy63D7w==
X-Received: by 2002:a17:907:3c81:b0:77a:327a:815f with SMTP id gl1-20020a1709073c8100b0077a327a815fmr54564478ejc.422.1667931363176;
        Tue, 08 Nov 2022 10:16:03 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id t18-20020a1709063e5200b007a62215eb4esm4992460eji.16.2022.11.08.10.16.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 10:16:02 -0800 (PST)
Message-ID: <aa8f5b80-b94e-b685-ed65-8b9c8f453832@redhat.com>
Date:   Tue, 8 Nov 2022 19:16:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 0/3] Check enumeration before MSR save/restore
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>, degoede@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        antonio.gomez.iglesias@linux.intel.com
References: <cover.1663025154.git.pawan.kumar.gupta@linux.intel.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <cover.1663025154.git.pawan.kumar.gupta@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi All,

On 9/13/22 01:38, Pawan Gupta wrote:
> Hi,
> 
> This patchset is to fix the "unchecked MSR access error" [1] during S3
> resume. Patch 1/3 adds a feature bit for MSR_IA32_TSX_CTRL.
> 
> Patch 2/3 adds a feature bit for MSR_AMD64_LS_CFG.
> 
> Patch 3/3 adds check for feature bit before adding any speculation
> control MSR to the list of MSRs to save/restore.
> 
> [1] https://lore.kernel.org/lkml/20220906201743.436091-1-hdegoede@redhat.com/
> 
> Pawan Gupta (3):
>   x86/tsx: Add feature bit for TSX control MSR support
>   x86/cpu/amd: Add feature bit for MSR_AMD64_LS_CFG enumeration
>   x86/pm: Add enumeration check before spec MSRs save/restore setup

What is the status of this series ?

To me this seems like a sensible way to solve the problem which
I reported and other similar problems...

Regards,

Hans

