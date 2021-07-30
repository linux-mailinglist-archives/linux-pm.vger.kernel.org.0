Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E663DB52C
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jul 2021 10:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbhG3Is5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Jul 2021 04:48:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47683 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230335AbhG3Isy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Jul 2021 04:48:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627634929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KwlwMG0bIm6lkV3XMLR/jIZjkoPwYVtdep1zcr5OxlA=;
        b=bacqfAoA5UT4kyh/kyp51i/7p3c1TlbwH/g/IVnhtZjGRVP2FIZs8Vy0dAvaN0JvFuth+M
        vEzVcIXqFV00qBeGKgAO2ppQnaWPdCqIcf5bgsNzp2rXPQ3AZ37kkCXc4mrjPv6RrDkjuK
        bRYHinlytyQTUb8a5RiVRTR57LUDQxQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-m7E0TKYmPMqw4RcJodCRDQ-1; Fri, 30 Jul 2021 04:48:47 -0400
X-MC-Unique: m7E0TKYmPMqw4RcJodCRDQ-1
Received: by mail-ed1-f69.google.com with SMTP id cm18-20020a0564020c92b02903bc7f21d540so2846613edb.13
        for <linux-pm@vger.kernel.org>; Fri, 30 Jul 2021 01:48:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KwlwMG0bIm6lkV3XMLR/jIZjkoPwYVtdep1zcr5OxlA=;
        b=OTISvvuiIKOpNNsWp0CFOK/NqvvrlKGSBYECZvvrjTz74kE70ZJvjDjYF+Ecsp0QAN
         UYtE+tGPh1TNnuCCSI+H6jhsoj4Dij2UYULPxUeTJGmb99p+mkh/8uB8JTKEa4aLN6SO
         05NFxBGC6u9ZphzT67B4GPkpyhVC4O1VSBK1AZpQQaOHvPubhI3PCUEcMs66OXTlVyFd
         LheaUBIIHCt1LdcFHhTvNGfVEUIPA+q10Ie8tzU4QI3kuc5az/X5rSPdsF/mn4nCFo8I
         4LLa7006T7lJX/fVo2WLbKVce1tywBSG+va+YyskooNLWdrt8M4d+LwPPZQQpvj7D5W6
         D50g==
X-Gm-Message-State: AOAM531x3277OnwNciXgLcCcwFeq/Fc0XC+MgMFd3WswspTDPYkKZ80L
        3K9iXfkhz1CWZzL0kfq4rH70CvIYzvxm69oOiFXQLyJm9L2/lTmj3A3e35kIKyi8Iwe4R0YRnEN
        +EM1P7fmrnhUkqOeTKYSERo72Ib1B5fpiVmnAO2wuNpHqVu77hfORrJGOWzMYSNnTkjMcE7M=
X-Received: by 2002:a05:6402:34c8:: with SMTP id w8mr1710992edc.182.1627634926392;
        Fri, 30 Jul 2021 01:48:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdiPOBCKS5qQHpX+Yll4WKiScKdGhlitsMeJ5OPbfHANcdqwX+GIvjoiRoIDghhzrbEj1clg==
X-Received: by 2002:a05:6402:34c8:: with SMTP id w8mr1710977edc.182.1627634926243;
        Fri, 30 Jul 2021 01:48:46 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id o17sm328779ejb.84.2021.07.30.01.48.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 01:48:45 -0700 (PDT)
Subject: Re: [PATCH 08/10] power: supply: axp288_fuel_gauge: Refresh all
 registers in one go
To:     kernel test robot <lkp@intel.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        Andrejus Basovas <cpp@gcc.lt>, linux-pm@vger.kernel.org
References: <20210717164424.274283-9-hdegoede@redhat.com>
 <202107190341.gWNWWfOy-lkp@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <3c016b6e-4f3c-3b23-01b1-c314dc1cf758@redhat.com>
Date:   Fri, 30 Jul 2021 10:48:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <202107190341.gWNWWfOy-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 7/18/21 9:52 PM, kernel test robot wrote:
> Hi Hans,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on power-supply/for-next]
> [also build test ERROR on v5.14-rc1 next-20210716]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Hans-de-Goede/power-supply-axp288_fuel_gauge-Reduce-number-of-register-accesses-cleanups/20210718-092951
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
> config: s390-buildonly-randconfig-r005-20210718 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 5d5b08761f944d5b9822d582378333cc4b36a0a7)

<snip>

>>> drivers/power/supply/axp288_fuel_gauge.c:24:10: fatal error: 'asm/iosf_mbi.h' file not found
>    #include <asm/iosf_mbi.h>
>             ^~~~~~~~~~~~~~~~
>    12 warnings and 1 error generated.

Ah yes, asm.iosf_mbi.h is a X86 header file. The AXP288 is only used on X86 devices,
so we can easily fix this by adding a "depends on X86" to the Kconfig, I'll submit
a v2 which does this.

Regards,

Hans

