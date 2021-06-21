Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6C83AF1EF
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jun 2021 19:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhFUR3X (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Jun 2021 13:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbhFUR3N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jun 2021 13:29:13 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBCCC061574;
        Mon, 21 Jun 2021 10:26:57 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id m21so31453432lfg.13;
        Mon, 21 Jun 2021 10:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qTJ8d7qLE7Gd/2AFDmVpTLBFC1/hqPXn3WccgyH694U=;
        b=AxrGHKT+jPS1YjETVrAnz/rOvl3bPkG73k+isXGuIVUPTEA5DcLy7CPLbO0l/K+nB5
         80NY3RHAYg9xc/5Qg0+FzqBxGSe6NYuY3oDB6eSTVuKxydox2Zgjry8McByJ97w4BMmf
         rMnWsg3bcd+FKbAyoN70VOd+GChVUNVW+kRf9H4TxREGL1tNUg8X3cXtbMzQ/L6oe60P
         w+CgoHRFjhDBxs4H5xQAS+09my7YuTnUwGngQLLBTNGdxc7syZOXnn0awA+iN+egGWn6
         wZGAKVSaMgdlWiACLIs6Kv7fONjFr8jBxVGb3Y8bdQ5YaM0oTVyL/HpBAZT/qdgkzGEJ
         kB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qTJ8d7qLE7Gd/2AFDmVpTLBFC1/hqPXn3WccgyH694U=;
        b=BjTFFURMHXLH15RPyTxt+IH7hzWrdzwjvmfnPBBry/cuAPBRk0Mx11QAs1Y1UjBRHi
         Ni09DtoK7jf1mtpVxm8wQ7WBcMhrqx09Oc5Lq56ww6BbWfsFLcC7G1ndCvUVPjEk5xIU
         r3T/Ix+zqKGIzTY55VG/RaVjbw/9x+R6PgUDYpP/FLaXbxdv/iFElyrXw6sEdEw/cTIn
         MwyJCKJVQgB4N6Q5xTM3R0FZJP33GU26BSR8GmV0VW+jKD8M0mZGP95PhhSmzrQ7qWYo
         QXN5h1sq8C7I1hZ73xh+Ododhg8kmimjhbNXdODCnsIyaKz0js0i6ZCqAsqs8I7a1He/
         FQMg==
X-Gm-Message-State: AOAM532UY3KuVHucSuI2FwIA/dfz2Jw8irzSfPnS+D6KGPDIeLSe8u3v
        bPFJqAEC81PFyEBwMY0wLuZ7MbH42OI=
X-Google-Smtp-Source: ABdhPJycHCdwyibfOMhKbl7EIjatmizAb1TSn7L2eyr8LlhuBZlslq+1aiqJPmTitjeCyLDm8ai+gA==
X-Received: by 2002:a19:3846:: with SMTP id d6mr2578677lfj.525.1624296415572;
        Mon, 21 Jun 2021 10:26:55 -0700 (PDT)
Received: from [192.168.2.145] (94-29-29-31.dynamic.spd-mgts.ru. [94.29.29.31])
        by smtp.googlemail.com with ESMTPSA id j5sm1931055lfe.124.2021.06.21.10.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 10:26:55 -0700 (PDT)
Subject: Re: [PATCH v4 0/6] Add driver for NVIDIA Tegra30 SoC Thermal sensor
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andreas Westman Dorcsak <hedmoo@yahoo.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Ihor Didenko <tailormoon@rambler.ru>,
        Ion Agorria <ion@agorria.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20210616190417.32214-1-digetx@gmail.com>
 <e1e3816a-ddf4-be13-0410-0b929f3be60b@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <cdc3d6fe-f2a8-d50c-af11-98ab4f72b713@gmail.com>
Date:   Mon, 21 Jun 2021 20:26:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <e1e3816a-ddf4-be13-0410-0b929f3be60b@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

21.06.2021 20:13, Daniel Lezcano пишет:
> 
> Hi Dmitry,
> 
> I compiled the your series and got these unresolved.
> 
> arm-linux-gnueabi-ld: drivers/thermal/tegra/soctherm-fuse.o: in function
> `tegra_calc_shared_calib':
> soctherm-fuse.c:(.text+0x60): undefined reference to `tegra_fuse_readl'
> arm-linux-gnueabi-ld: soctherm-fuse.c:(.text+0xf0): undefined reference
> to `tegra_fuse_readl'
> arm-linux-gnueabi-ld: drivers/thermal/tegra/soctherm-fuse.o: in function
> `tegra_calc_tsensor_calib':
> soctherm-fuse.c:(.text+0x144): undefined reference to `tegra_fuse_readl'
> arm-linux-gnueabi-ld: drivers/thermal/tegra/tegra30-tsensor.o: in
> function `tegra_tsensor_fuse_read_spare':
> tegra30-tsensor.c:(.text+0x364): undefined reference to `tegra_fuse_readl'
> arm-linux-gnueabi-ld: drivers/thermal/tegra/tegra30-tsensor.o: in
> function `tegra_tsensor_probe':
> tegra30-tsensor.c:(.text+0x874): undefined reference to `tegra_fuse_readl'
> arm-linux-gnueabi-ld:
> drivers/thermal/tegra/tegra30-tsensor.o:tegra30-tsensor.c:(.text+0x904):
> more undefined references to `tegra_fuse_readl' follow
> make[1]: *** [/home/dlezcano/Work/src/linux/Makefile:1196: vmlinux] Error 1
> make: *** [/home/dlezcano/Work/src/linux/Makefile:215: __sub-make] Error 2

The missing stub was added by [1]. I guess you could take [2] for the
base since Thierry already sent out PR for 5.14, or we could defer the
"thermal/drivers/tegra: Correct compile-testing of drivers" patch till
the next kernel version. Please choose whatever is easier for you.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=30b44e81772a5caa983000057ce1cd9cb4531647

[2]
https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git/log/?h=for-5.14/soc
