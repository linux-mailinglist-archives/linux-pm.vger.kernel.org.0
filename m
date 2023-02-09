Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76FE69129E
	for <lists+linux-pm@lfdr.de>; Thu,  9 Feb 2023 22:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjBIV0k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Feb 2023 16:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjBIV0j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Feb 2023 16:26:39 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0C85AB0C
        for <linux-pm@vger.kernel.org>; Thu,  9 Feb 2023 13:26:38 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id f15-20020a17090ac28f00b00230a32f0c9eso3596668pjt.4
        for <linux-pm@vger.kernel.org>; Thu, 09 Feb 2023 13:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rONv+YHiAdWbDD6xyB9B8OqBX23TPIVefeJVPhY6AdM=;
        b=Dl7MbipTN9ayPz0KqQpZ603tArjAJHQEAehmvzuxyEslUk/q8mhe3YbpZvNiyxzshB
         /sodHTmmkaBhGqWg1PVV30yQ+oSNsPgS4kyivHvyaar/0GNVPUNMXvAJ8by+XzzdLSU0
         0iewtRtOvf4iey4yRRijR1DCSwpZxdZGpsi8esRHLNc5Yt9Eml3ODzhPWObJsZK8auiC
         ASe03IR/zyMZa4JOnZtON601wNMGQvh0Fd6LgunQe5uR4VWqoaMOr/znqKlwsBEOPPg8
         uwbfnnaMAJCpfJm8siz4ZodPgrLBIjr9XeM9pfftf0jwLTioSLMtw5rTGoTyqyruKLAC
         8Jfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rONv+YHiAdWbDD6xyB9B8OqBX23TPIVefeJVPhY6AdM=;
        b=M01qjHy385n0BWE5dLUyi2Wls3ppN3ZTPlOInp0bef3qvhRp193lPksKd5NhNGjTaB
         IbQ/wqdnxBA/rBYyoydvZz05HMp2kcQGVrLYK/mB7SNxIEeOjkzdGQZsxH6Q+1Juvxw/
         X9XC7H5WVBLYikN/pHMZMNNw4e2MnrQ+HI8ItTJFkw0O6QzEXw3GOXobS1u/+KCCdWJg
         EidfMb3LgJDkvFmQR+NZfKcn3mnWmLY8zCm1M0iURt58VoNojYMkgDAC20eHzoasA5Ge
         uKoqi5/5DZ88DFnshZsLlwnRZp+pXhbDB+g3o/lOYwjQq7hGO9LbdacbQ/UN3+WUfiOx
         a8iQ==
X-Gm-Message-State: AO0yUKWehZfVwPhpVtxJK8UUK7sRlr72NQ5sS2uQfH58sA7mxzRUUUyI
        IqReZid95UfDbuOiXNF2lCS5iQ==
X-Google-Smtp-Source: AK7set/vFjs8hoIjvmLAeK12fPac09n87goLeHN9K3UmLhO79lPXnHWKnQMhMuzn0gFMxPwOn4/2hA==
X-Received: by 2002:a17:902:da89:b0:198:af50:e4df with SMTP id j9-20020a170902da8900b00198af50e4dfmr37252plx.5.1675977997462;
        Thu, 09 Feb 2023 13:26:37 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id y15-20020a1709029b8f00b0019a70a42b0asm93844plp.169.2023.02.09.13.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 13:26:37 -0800 (PST)
Date:   Thu, 9 Feb 2023 21:26:33 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Grzegorz Jaszczyk <jaz@semihalf.com>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org, dmy@semihalf.com,
        tn@semihalf.com, dbehr@google.com,
        zide.chen@intel.corp-partner.google.com, upstream@semihalf.com,
        hdegoede@redhat.com, markgross@kernel.org, dtor@google.com,
        mario.limonciello@amd.com, linux-pm@vger.kernel.org,
        x86@kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [RESEND RFCv2 1/1] platform/x86: Add virtual PMC driver used for
 S2Idle
Message-ID: <Y+VlCWwn35ECE9iz@google.com>
References: <20230209152123.3186930-1-jaz@semihalf.com>
 <20230209152123.3186930-2-jaz@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209152123.3186930-2-jaz@semihalf.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 09, 2023, Grzegorz Jaszczyk wrote:
> Virtual PMC driver is meant for the guest VMs for the S2Idle
> notification. Its purpose is to register S2Idle dev ops check handler,
> which will evaluate ACPI _DSM just before the guest enters S2Idle power
> state.
> 
> This allows to trap on MMIO access done as a consequence of _DSM
> evaluation and therefore notify the VMM about the guest entering S2Idle
> state.
> 
> Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
> ---
> Changelog v1..v2:
> - Take advantage of acpi_s2idle_dev_ops's check() instead of notify()
> ---
>  drivers/platform/x86/Kconfig    |  7 ++++
>  drivers/platform/x86/Makefile   |  3 ++
>  drivers/platform/x86/virt_pmc.c | 73 +++++++++++++++++++++++++++++++++
>  3 files changed, 83 insertions(+)
>  create mode 100644 drivers/platform/x86/virt_pmc.c
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 5692385e2d26..b7c3f98031d7 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1099,6 +1099,13 @@ config WINMATE_FM07_KEYS
>  	  buttons below the display. This module adds an input device
>  	  that delivers key events when these buttons are pressed.
>  
> +config VIRT_PMC
> +	tristate "Virt PMC"

Maybe spell out "Virtual Power Management Controller"?  See below.

> +	depends on ACPI && SUSPEND

I think it makes sense to take a dependency on HYPERVISOR_GUEST.  It's not strictly
required, but taking that dependency helps clarify that this is a guest-side thing,
e.g. "virtual PMC" in KVM-land means "virtual performance monitoring counter".

And IMO, disabling HYPERVISOR_GUEST should disable these type of guest-specific
features.
