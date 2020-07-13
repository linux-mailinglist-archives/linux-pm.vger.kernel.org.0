Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49D721D863
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 16:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbgGMO0r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 10:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729659AbgGMO0r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 10:26:47 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C488C061755;
        Mon, 13 Jul 2020 07:26:47 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id d17so18099370ljl.3;
        Mon, 13 Jul 2020 07:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Fn4s2vAs0+Q1HokEV2gE1g/EmhM//ct3bpOXDHCUDTs=;
        b=DdxNVY0T1G1+mn2kAbIXTn1g/3BjiseG4dKs2sb1aVpjlNZ6aOV94yrCr5Zl6ADfAb
         tzSv0PB5RPR8K6qyOeDOxNH58BP1qu3Fh1xicP1f5HILnBT6JYyDkosBXDQkK4nB/tV7
         f94sLXwdnVmkWEbCKoBvnH90Y/KcfzMgbmSnzgAecwwoIiGbqsBPZzqJeNbpGz0K5ui5
         TwJsE99k9rPoyCwMtna8BuBysCMaRTRY2vKNa4Kjmtxk793BegqnJ/+pcvn0bxO3YYkP
         h/UMtswnZ+Vj0g8l2DXE5+YRwQ+RTkCgDX/5ulv2A8zEfjqaDx1TKbd6vozMO7+K0Kxk
         9UpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Fn4s2vAs0+Q1HokEV2gE1g/EmhM//ct3bpOXDHCUDTs=;
        b=QJ0DZc0df43xYYVDTHI4FMn2LmHGXgfbd4p3EODdEB8+6zSoSzz6r+gHROJHQcRvyC
         DDJEMqQIz0tpAwtHsajP5Fpn6RP3qj+bnPwzYM5A+CDbHb5IFGv8DQULyzESdcp6Ptb1
         HVadW6xF/2JB0VWUy4hkeKvfkaRdMU+mDDDq96Iz2k9sAJub4K5SvKOT+LH2tTYUUdM0
         MIpJjrOl3ZDXxUT+TyydpyMwBuVk/L+8JnRL+BZSXJGL1RJd4i2mZ4Rez5xvWZTeJVd+
         CxIeZxD6NO9Zx0pn9jryjHMhVpX5zWtC628T7WADiEt1ExP8X2BOYzjZdvjbWYbXLhah
         3XFQ==
X-Gm-Message-State: AOAM530AkLHKLtAZdooN63gixbw1qv90QAcx406JtF0Qy3h8vHU00ZXP
        rjZb/f4QY31Ttuh6n6J0iXlJdboL
X-Google-Smtp-Source: ABdhPJwr2PFXOt+b3R3iMyzM9LnuWUMT6Dk2EssiYoQRzB145JYWNtDHIg5SQZWiKAug25GXMtuL4Q==
X-Received: by 2002:a2e:910c:: with SMTP id m12mr25215ljg.274.1594650405357;
        Mon, 13 Jul 2020 07:26:45 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-79-162-105.pppoe.mtu-net.ru. [91.79.162.105])
        by smtp.googlemail.com with ESMTPSA id c6sm4678357lff.77.2020.07.13.07.26.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 07:26:44 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] PM / devfreq: Add governor flags to clarify the
 features
To:     Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     leonard.crestez@nxp.com, lukasz.luba@arm.com,
        enric.balletbo@collabora.com, hl@rock-chips.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, abel.vesa@nxp.com,
        chanwoo@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20200713083113.5595-1-cw00.choi@samsung.com>
 <CGME20200713081944epcas1p22871b6d8a9455226e6cccd08ac0baa73@epcas1p2.samsung.com>
 <20200713083113.5595-3-cw00.choi@samsung.com>
 <746837bc-6734-3e52-453f-2b59bbca0230@gmail.com>
 <69ae2524-22d0-2444-da13-fae199392029@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <3c327421-0533-c657-1887-9036e525960d@gmail.com>
Date:   Mon, 13 Jul 2020 17:26:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <69ae2524-22d0-2444-da13-fae199392029@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

13.07.2020 15:26, Chanwoo Choi пишет:
...
>> BTW, I'm curious what do you think about hiding the unsupported debugfs
> 
> Do you mean that sysfs?

Yes, sysfs :)

>> attributes per-device instead of returning the -EACCES?
> 
> I considered the hiding of sysfs node too instead of -EACCES.

If there is no real userspace (used by a non-developer crowd) that
relies on the attributes presence, then it could be fine to change the
behaviour, IMO.

I know that PowerTOP utility uses the 'trans_stat' attribute, but not
sure about the other attributes.

> But,
> For a long time, devfreq showed the sysfs interface of all devfreq devices
> regardless of the kind of devfreq governor. It means that devfreq keeps
> the ABI interface. If devfreq hides the unsupported sysfs node
> according to the type of governor, it will break the ABI.

I didn't notice that it's an ABI already [1]. Should be better not to
change the ABI if there is userspace already relying on the old
behaviour, otherwise it may be okay to make changes until it will be too
late, also given that this is still a "testing" ABI.

[1] https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-class-devfreq

Although, the doc doesn't say anything about -EACCES/-EINVAL, so isn't
it an ABI change already? Doesn't doc need to be updated in order to
reflect the ABI change?

For example, doc says that userspace shouldn't care about attribute
values which are irrelevant for a selected governor, like in the case of
the 'polling_interval' attribute. The doc doesn't say that userspace may
get a error.

> Although I knew that maybe performance/powersave/userspace didn't use
> the 'polling_interval' node, I just returned -EACCESS.

The 'polling_interval', 'min/max_freq' and the new 'timer' attributes
are all the governor attributes.

Would be nice to have a per-device `governor/` directory containing all
the governor-specific attributes (without the unrelated attributes), but
perhaps it's a bit too late to change it now?
