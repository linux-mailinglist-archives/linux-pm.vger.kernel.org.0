Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260B3634036
	for <lists+linux-pm@lfdr.de>; Tue, 22 Nov 2022 16:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbiKVPcG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Nov 2022 10:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233387AbiKVPcE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Nov 2022 10:32:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAB2331
        for <linux-pm@vger.kernel.org>; Tue, 22 Nov 2022 07:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669131064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M9Rq8NAw1T2YjzVTECZnA2JWS2PTg96PRA2tMjqGKL8=;
        b=Xboar2RhCdbNFdmP2C4+wlxtmm3rgCBwY7AFRfjHCRZaM1pDltSLfFuKkijMQxCj3BGBU/
        bZyRT86W9uZstRECnua8UR8tyfLKrlussO1AvkSC2JJzAGwsZp64kJSEPy9OjNbFRX00Tn
        hvyiT120TrnhbJ/AbOhWEezjfwmYYfI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-267-7t01k15uNiqosnffnWeCOg-1; Tue, 22 Nov 2022 10:31:02 -0500
X-MC-Unique: 7t01k15uNiqosnffnWeCOg-1
Received: by mail-ej1-f72.google.com with SMTP id nb1-20020a1709071c8100b007ae4083d6f5so8418639ejc.15
        for <linux-pm@vger.kernel.org>; Tue, 22 Nov 2022 07:31:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M9Rq8NAw1T2YjzVTECZnA2JWS2PTg96PRA2tMjqGKL8=;
        b=gFOKCrFO+W8OA9VV/8ayB5XQWD3f/eJVxLThvUNM+TmH2D+W/BiSD8xwZxz1ItAMvA
         PJGnUkDFy+j0nbVF9aclGezETtdT2ok08AUBI64E2hZ/eTV9SxRSIbvRnbtFJ8uzHZ3a
         jTBoLFyqe3P/lEQzHhxl+A32Jvop+MYJpCZ54q9/Y3Cv/O4MCH0Ln8mrVqmtjF1mRNKu
         9Jzo9o/7JX9Wpw60awrBCzjeKdHIJS3oQDu46aqSA5PKHuJy25uO2aWZvssZsmWcZ0xt
         Z4UhfSrd6eOuYsvLoCRieXdwsjQrMit+ajejV3eM45nE7c4PC9nODSBS+nfUQgAUCzgN
         sBuA==
X-Gm-Message-State: ANoB5pky3Um4z2AIBO3IC1h4ZLtz8Cmqmnanete5OExi94sBtu0300LO
        Ua1PYNVPDT6YZYoVvw9nrKikFD4C0zEV/0BP6fY2HgHqhkmAHosMLnvDbRyBrj3/0WtHBxEXnlN
        zi9nK5XXUyzSaZA6E39g=
X-Received: by 2002:a05:6402:1118:b0:467:a8cb:10c9 with SMTP id u24-20020a056402111800b00467a8cb10c9mr6837305edv.123.1669131061176;
        Tue, 22 Nov 2022 07:31:01 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4CH+Vx3pIPif4bvQ7VvOOVeImcHVPAHjQC8cn+lp8ryOJqSR/ruqW5OSSaZonQqQi7ybLLrw==
X-Received: by 2002:a05:6402:1118:b0:467:a8cb:10c9 with SMTP id u24-20020a056402111800b00467a8cb10c9mr6837287edv.123.1669131060931;
        Tue, 22 Nov 2022 07:31:00 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id u26-20020a170906409a00b0078ddb518a90sm6132853ejj.223.2022.11.22.07.31.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 07:31:00 -0800 (PST)
Message-ID: <0b867f52-5fe8-f0e8-3f05-746b1db0059e@redhat.com>
Date:   Tue, 22 Nov 2022 16:30:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH resend] platform/x86: intel-uncore-freq: add Emerald
 Rapids support
Content-Language: en-US, nl
To:     Artem Bityutskiy <dedekind1@gmail.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux PM Mailing List <linux-pm@vger.kernel.org>
References: <20221122070014.3639277-1-dedekind1@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221122070014.3639277-1-dedekind1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 11/22/22 08:00, Artem Bityutskiy wrote:
> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> 
> Make Intel uncore frequency driver support Emerald Rapids by adding its CPU
> model to the match table. Emerald Rapids uncore frequency control is the same
> as in Sapphire Rapids.
> 
> Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> 
> Re-sending the same patch, but added X86 platform maintainers.

There are 3 different issues with this patch, next time please
check your patch a bit more thorough before submitting it:

1. This is the first time I see this, or that the platform-driver-x86@vger.kernel.org
list sees this. Next time please make sure you address the patch to the right
people the first time you send it:

[hans@shalem platform-drivers-x86]$ scripts/get_maintainer.pl -f drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> (maintainer:INTEL UNCORE FREQUENCY CONTROL)
Hans de Goede <hdegoede@redhat.com> (maintainer:X86 PLATFORM DRIVERS)
Mark Gross <markgross@kernel.org> (maintainer:X86 PLATFORM DRIVERS)
platform-driver-x86@vger.kernel.org (open list:INTEL UNCORE FREQUENCY CONTROL)
linux-kernel@vger.kernel.org (open list)


2. This has checkpatch warnings which are easily fixable:

[hans@shalem platform-drivers-x86]$ scripts/checkpatch.pl 0001-platform-x86-intel-uncore-freq-add-Emerald-Rapids-su.patch 
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#7: 
model to the match table. Emerald Rapids uncore frequency control is the same

total: 0 errors, 1 warnings, 7 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

0001-platform-x86-intel-uncore-freq-add-Emerald-Rapids-su.patch has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


3. This fails to build on top of:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=for-next
which is the branch on which this needs to be applied to get upstream, so this is also
the branch on which you should base the patch (and build test it) before submitting it
upstream:

In file included from drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c:21:
./arch/x86/include/asm/cpu_device_id.h:161:46: error: ‘INTEL_FAM6_EMERALDRAPIDS_X’ undeclared here (not in a function); did you mean ‘INTEL_FAM6_SAPPHIRERAPIDS_X’?
  161 |         X86_MATCH_VENDOR_FAM_MODEL(INTEL, 6, INTEL_FAM6_##model, data)
      |                                              ^~~~~~~~~~~
./arch/x86/include/asm/cpu_device_id.h:46:27: note: in definition of macro ‘X86_MATCH_VENDOR_FAM_MODEL_STEPPINGS_FEATURE’
   46 |         .model          = _model,                                       \
      |                           ^~~~~~
./arch/x86/include/asm/cpu_device_id.h:129:9: note: in expansion of macro ‘X86_MATCH_VENDOR_FAM_MODEL_FEATURE’
  129 |         X86_MATCH_VENDOR_FAM_MODEL_FEATURE(vendor, family, model,       \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./arch/x86/include/asm/cpu_device_id.h:161:9: note: in expansion of macro ‘X86_MATCH_VENDOR_FAM_MODEL’
  161 |         X86_MATCH_VENDOR_FAM_MODEL(INTEL, 6, INTEL_FAM6_##model, data)
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c:206:9: note: in expansion of macro ‘X86_MATCH_INTEL_FAM6_MODEL’
  206 |         X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X, NULL),
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
make[6]: *** [scripts/Makefile.build:250: drivers/platform/x86/intel/uncore-frequency/uncore-frequency.o] Error 1


Regards,

Hans







> 
>  drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
> index 8f9c571d7257..00ac7e381441 100644
> --- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
> +++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
> @@ -203,6 +203,7 @@ static const struct x86_cpu_id intel_uncore_cpu_ids[] = {
>  	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,	NULL),
>  	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,	NULL),
>  	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X, NULL),
> +	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X, NULL),
>  	{}
>  };
>  MODULE_DEVICE_TABLE(x86cpu, intel_uncore_cpu_ids);

