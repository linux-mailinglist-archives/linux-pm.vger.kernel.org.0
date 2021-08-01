Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 816CF3DCB5A
	for <lists+linux-pm@lfdr.de>; Sun,  1 Aug 2021 13:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbhHALXy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Aug 2021 07:23:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32645 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231803AbhHALXx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Aug 2021 07:23:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627817023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o8QNA7ce8DEEodq4/D8HbUWcpJrQnr1dbruWfk5MIkA=;
        b=SGLYV2mkEUWKVxqK7Z7DmqYPOyUoVgM3ExURR4RFrdE2b9JRsJu6q6l0+yd1m4U5x8awfx
        cJ25qvzy+hyKXNkn+98oH11wqVGJMaOVrzVlw+XaZg4M8MIoUj0gamSK91x71pHEQIO487
        rxydFsUZVkSrTt8nZZwb4jvLbXtXRZc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-XxeuLz0jOKe5OMTZYb9iWA-1; Sun, 01 Aug 2021 07:23:43 -0400
X-MC-Unique: XxeuLz0jOKe5OMTZYb9iWA-1
Received: by mail-ed1-f71.google.com with SMTP id l10-20020aa7caca0000b02903b874f26036so7115580edt.20
        for <linux-pm@vger.kernel.org>; Sun, 01 Aug 2021 04:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o8QNA7ce8DEEodq4/D8HbUWcpJrQnr1dbruWfk5MIkA=;
        b=o9nym61dB4z/LqEhtIx9ucMZH6XgtC55syyXdRpqYFvlP3VxGLdcijeh/RLW0vmhSk
         O3FDteby4y1yOIgx38yFkhxlhIccyySzfSoij4x5em1KnDbioTc8VexBoFpcRkHnX5Ay
         YyYb5raQ6jM401SBBcJfaUFUsDilA/1taf3yVRTfTuTYeuXFKv4zXGB43IuP7q5BwDD1
         9PFiskeT47QJ1iJprp44DjvZbkuYuNVrRUax3PsI529ESZva/fM9DOjHCK8KZ5JleeLm
         PnN4RoVMdBsH9iHPZTflgS56dtj2QcNFGvP1addd38vZud4EipVjrRGjP6NxTWPkgaS0
         m9sw==
X-Gm-Message-State: AOAM533uCJaWC+Uxc12nUtN3QT0kOZsnBPcfdR8wPQ8j6jQGgrV9OyAm
        LT235/MW5KeoE20VUY118MtklDSBzPIenl9N09rTbD7WPDJOsCWkFcjy+Ag5el+3HLHNIhhiQK+
        7LhKkShl1Cx0gPJ/nGsyh0JSLcY6rk4Y1RhHj0vvCUMlGmHZigSpXQOnlhI+IUAQSZ8Ve5pw=
X-Received: by 2002:a17:906:688e:: with SMTP id n14mr10849193ejr.67.1627817021702;
        Sun, 01 Aug 2021 04:23:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjRXU2hyGTRVQgdYjXzwFv0t9RMd12khGxkjEfOBeW964xVxJLjJkIFnb6aog1IiOp5XnhxQ==
X-Received: by 2002:a17:906:688e:: with SMTP id n14mr10849178ejr.67.1627817021474;
        Sun, 01 Aug 2021 04:23:41 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id gv7sm2968484ejc.5.2021.08.01.04.23.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Aug 2021 04:23:41 -0700 (PDT)
Subject: Re: [PATCH v2 08/10] power: supply: axp288_fuel_gauge: Refresh all
 registers in one go
To:     kernel test robot <lkp@intel.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        Andrejus Basovas <cpp@gcc.lt>, linux-pm@vger.kernel.org
References: <20210730095607.57541-9-hdegoede@redhat.com>
 <202107310035.iKiQEb6J-lkp@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ad94a3cd-9a57-35db-b989-7133b16e702a@redhat.com>
Date:   Sun, 1 Aug 2021 13:23:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <202107310035.iKiQEb6J-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 7/30/21 6:14 PM, kernel test robot wrote:
> Hi Hans,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on power-supply/for-next]
> [also build test ERROR on v5.14-rc3 next-20210729]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Hans-de-Goede/power-supply-axp288_fuel_gauge-Reduce-number-of-register-accesses-cleanups/20210730-175716
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
> config: x86_64-buildonly-randconfig-r001-20210730 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 4f71f59bf3d9914188a11d0c41bedbb339d36ff5)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/1ff192ccce54fdfce899447999a60a195537460c
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Hans-de-Goede/power-supply-axp288_fuel_gauge-Reduce-number-of-register-accesses-cleanups/20210730-175716
>         git checkout 1ff192ccce54fdfce899447999a60a195537460c
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> drivers/power/supply/axp288_fuel_gauge.c:219:8: error: implicit declaration of function 'iosf_mbi_block_punit_i2c_access' [-Werror,-Wimplicit-function-declaration]
>            ret = iosf_mbi_block_punit_i2c_access();
>                  ^
>>> drivers/power/supply/axp288_fuel_gauge.c:268:2: error: implicit declaration of function 'iosf_mbi_unblock_punit_i2c_access' [-Werror,-Wimplicit-function-declaration]
>            iosf_mbi_unblock_punit_i2c_access();
>            ^
>    drivers/power/supply/axp288_fuel_gauge.c:268:2: note: did you mean 'iosf_mbi_block_punit_i2c_access'?
>    drivers/power/supply/axp288_fuel_gauge.c:219:8: note: 'iosf_mbi_block_punit_i2c_access' declared here
>            ret = iosf_mbi_block_punit_i2c_access();
>                  ^
>    2 errors generated.

Ugh, so I guess that it is possible to build a x86 kernel without iosf_mbi support
enabled. Given how the I2C bus to PMIC is special on devices with an AXP288 PMIC
and special attention must be made to coordinate accesses with the SoC-s
P-Unit, allowing building of the AXP288 code without IOSF_MBi makes little sense
(this will lead to a very unreliable kernel build) so I'll do a v3 changing the new
depends on from X86 to IOSF_MBI.

Sorry about all the churn because of this Kconfig depends issue.

Regards,

Hans

