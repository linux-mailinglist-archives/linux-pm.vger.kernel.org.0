Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1920E47E42C
	for <lists+linux-pm@lfdr.de>; Thu, 23 Dec 2021 14:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348675AbhLWNmW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Dec 2021 08:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243778AbhLWNmW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Dec 2021 08:42:22 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BF4C061756
        for <linux-pm@vger.kernel.org>; Thu, 23 Dec 2021 05:42:21 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id b73so3701463wmd.0
        for <linux-pm@vger.kernel.org>; Thu, 23 Dec 2021 05:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mtFY74FuJLFo4FQl9iW5vKeqSDQCBL+PjPmqsc1umR8=;
        b=aSp0jZiSy5+obfl9wnUIvjQrccs/hJjgljM8yI0q7MuDVKeuS/lw09ADoW0aZkGYkh
         VyfDMC7qBZT1arm5vEU3f6X0bgtWzVqkHrcdPhCvHLewcpHwcsIIevgw32R1UR1Ag1mB
         G+yEX4v5s3i9elDhE5WHYXoNkLULK69kDMAtHMyYPnb/Wblgvk+tLrS5BTGI6/XDn0Xl
         XEbR8jIRamikSGimVochi2RH4TFbrivPhJuH/Sja8uSjw/37bL/sXHpedLfrDVYPgq2Z
         kiYGHzdTXd8za+NsVx+1Vbv5puOh8TTlB9iftm6QaVeH/J7dXM3TD5/jMhqYujJvfbOD
         8EaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mtFY74FuJLFo4FQl9iW5vKeqSDQCBL+PjPmqsc1umR8=;
        b=c4fOLTRPCCHoov9Xq8rjQQ/XkgRnkZXqudU1mshrYBvsuDEH4Q1uhO5Rc8sxNkZp0D
         gPmxL84h/xg4ktDeNa0KZ0HrT/WDY3UDpCZ7b9Rtd1NQFMKAP9wCgZyzZ9yblhotP2JX
         aEaFvr/+ihAjrHzVXujsUpraLywiIwIz3tB+5uuH/fF31wfYp9kn8BIn2CuJwK86c7g+
         EQebLC9LXTTdVMmwMQzq23mBVEGPkOZI9pCblHb3E5cg5534mgtix9vQLZgAY64OFc4N
         wKNeCi8Yy7GBQBG8CZIf7kEI0tm/u81E52ZUarMPqNy8pI4nN9wYBSsntYdkWNh6MFfH
         iXBQ==
X-Gm-Message-State: AOAM533k96tjGXXY4mUOhyY8pIxYw/e8Qj+VnlxjmJ0Q979ZPTwhAZwU
        ZGI3GQV91pcDi1iEIW+9fCeapN5aHaElag==
X-Google-Smtp-Source: ABdhPJzEAYn25MiuO7F01pqPPK76UYCDKtOVkDPHuIZgyKIAeC0aCoN0DWEdFf7H8gnQHRhjYbUtAA==
X-Received: by 2002:a1c:8013:: with SMTP id b19mr1695724wmd.35.1640266940317;
        Thu, 23 Dec 2021 05:42:20 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:34ca:f67b:b782:1949? ([2a01:e34:ed2f:f020:34ca:f67b:b782:1949])
        by smtp.googlemail.com with ESMTPSA id p15sm4548370wmj.46.2021.12.23.05.42.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Dec 2021 05:42:19 -0800 (PST)
Subject: Re: [PATCH v5 0/6] powercap/drivers/dtpm: Create the dtpm hierarchy
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     rjw@rjwysocki.net, lukasz.luba@arm.com, robh@kernel.org,
        heiko@sntech.de, arnd@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20211218130014.4037640-1-daniel.lezcano@linaro.org>
 <3badc321-381d-a48c-8abd-7702639304bb@linaro.org>
 <CAPDyKFpSeD5qqUMrBojga=3ecK_z4ad8PL7u+ZpyWXRpqHf94A@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <8118bcd7-0b85-dab8-6761-9eb15890859c@linaro.org>
Date:   Thu, 23 Dec 2021 14:42:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpSeD5qqUMrBojga=3ecK_z4ad8PL7u+ZpyWXRpqHf94A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Ulf,

On 23/12/2021 14:32, Ulf Hansson wrote:
> On Thu, 23 Dec 2021 at 14:20, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> Hi all,
>>
>> any comments on this series. Is it fine if I merge it without patch 6/6?
>>
>> Heiko, is the description fine for you in the SoC specific code?
> 
> FYI, I intend to have a closer look at the series next week. Happy holidays!

Ah, ok. Thank you for letting me know.

I'll wait for your feedback then

Thanks

  -- Daniel


>>
>> On 18/12/2021 14:00, Daniel Lezcano wrote:
>>> The DTPM hierarchy is the base to build on top of it a power budget
>>> allocator. It reflects the power consumption of the group of devices
>>> and allows to cap their power.
>>>
>>> The core code is there but there is no way to describe the desired
>>> hierarchy yet.
>>>
>>> A first proposal introduced the description through configfs [1] but
>>> was rejected [2].
>>>
>>> A second proposal based on the device tree with a binding similar to
>>> the power domains [3] was proposed but finally rejected [4].
>>>
>>> This fifth version delegates the hierarchy creation to the SoC with a
>>> specific and self-encapsulated code using an array to describe the tree. The
>>> SoC DTPM driver defines an array of nodes pointing to their parents.  The
>>> hierarchy description can integrate a DT node and in the future a SCMI node,
>>> that means the description can mix different type of nodes.
>>>
>>> In addition to the hierarchy creation, the devfreq dtpm support is also
>>> integrated into this series.
>>>
>>> This series was tested on a rock960 (revision B - rk3399 based) and a
>>> db845c (Qualcomm sdm845 based).
>>>
>>> [1] https://lore.kernel.org/all/20210401183654.27214-1-daniel.lezcano@linaro.org/
>>> [2] https://lore.kernel.org/all/YGYg6ZeZ1181%2FpXk@kroah.com/
>>> [3] https://lore.kernel.org/all/20211205231558.779698-1-daniel.lezcano@linaro.org/
>>> [4] https://lore.kernel.org/all/YbfFapsmsjs4qnsg@robh.at.kernel.org/
>>>
>>> Changelog:
>>>    V5:
>>>    - Remove DT bindings
>>>    - Added description with an array
>>>    - Added simple description for rk3399 and sdm845
>>>    - Moved dtpm table to the data section
>>>
>>>    V4:
>>>    - Added missing powerzone-cells
>>>    - Changed powerzone name to comply with the pattern property
>>>
>>>    V3:
>>>    - Remove GPU section as no power is available (yet)
>>>    - Remove '#powerzone-cells' conforming to the bindings change
>>>    - Removed required property 'compatible'
>>>    - Removed powerzone-cells from the topmost node
>>>    - Removed powerzone-cells from cpus 'consumers' in example
>>>    - Set additionnal property to false
>>>
>>>    V2:
>>>    - Added pattern properties and stick to powerzone-*
>>>    - Added required property compatible and powerzone-cells
>>>    - Added additionnal property
>>>    - Added compatible
>>>    - Renamed to 'powerzones'
>>>    - Added missing powerzone-cells to the topmost node
>>>    - Fixed errors reported by 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>>>    - Move description in the SoC dtsi specific file
>>>    - Fixed missing prototype warning reported by lkp@
>>>
>>>    V1: Initial post
>>>
>>> Daniel Lezcano (6):
>>>   powercap/drivers/dtpm: Move dtpm table from init to data section
>>>   powercap/drivers/dtpm: Add hierarchy creation
>>>   powercap/drivers/dtpm: Add CPU DT initialization support
>>>   powercap/drivers/dtpm: Add dtpm devfreq with energy model support
>>>   rockchip/soc/drivers: Add DTPM description for rk3399
>>>   qcom/soc/drivers: Add DTPM description for sdm845
>>>
>>>  drivers/powercap/Kconfig          |   8 ++
>>>  drivers/powercap/Makefile         |   1 +
>>>  drivers/powercap/dtpm.c           | 155 ++++++++++++++++++++++-
>>>  drivers/powercap/dtpm_cpu.c       |  37 ++++--
>>>  drivers/powercap/dtpm_devfreq.c   | 201 ++++++++++++++++++++++++++++++
>>>  drivers/soc/qcom/Kconfig          |   9 ++
>>>  drivers/soc/qcom/Makefile         |   1 +
>>>  drivers/soc/qcom/dtpm.c           |  65 ++++++++++
>>>  drivers/soc/rockchip/Kconfig      |   8 ++
>>>  drivers/soc/rockchip/Makefile     |   1 +
>>>  drivers/soc/rockchip/dtpm.c       |  56 +++++++++
>>>  include/asm-generic/vmlinux.lds.h |   4 +-
>>>  include/linux/dtpm.h              |  21 +++-
>>>  13 files changed, 551 insertions(+), 16 deletions(-)
>>>  create mode 100644 drivers/powercap/dtpm_devfreq.c
>>>  create mode 100644 drivers/soc/qcom/dtpm.c
>>>  create mode 100644 drivers/soc/rockchip/dtpm.c
>>>
>>
>>
>> --
>> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter |
>> <http://www.linaro.org/linaro-blog/> Blog


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
