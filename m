Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C8F34037C
	for <lists+linux-pm@lfdr.de>; Thu, 18 Mar 2021 11:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhCRKiV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Mar 2021 06:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhCRKhy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Mar 2021 06:37:54 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAC3C06174A;
        Thu, 18 Mar 2021 03:37:54 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id j11so3755843lfg.12;
        Thu, 18 Mar 2021 03:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=50NaW/+D7EIVdyftiDyHEsf4hFjsIKckzIbl9gr8M+k=;
        b=V0NnkydHiXFN4oB7vdGZy8qqdciU4VoyfnJSQuh1zmigW2n3yljcmaqOlthwdsJQbx
         vM8e9QKjsEOXgAu+s3wTeZUwvHFyOb6RDUyWiHFXTaqmFGZXihabvgScJqhwcyqxKygl
         7d2G8zrcO6PoqQGbufHJnw93PrHe3h+7w4HuuaQCO82IAylMVp4cxqOjgJXuXn/tdTBj
         htC8IrZPDR3Mdh3sixma3RUPPWGyT2FKLkiP6NC8s17Om3hTjwSOKHu+3Yg94HmSv4ma
         EjgfZilAiI/MTBWzORBbPXPMuJbxxwr8x/CgbyMl+PTnpuHKJz9VtrIbVYLz4PpUUwQV
         8CzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=50NaW/+D7EIVdyftiDyHEsf4hFjsIKckzIbl9gr8M+k=;
        b=qjgm6PmFCKPwL0IO+QG/NhGfaw6C27SUv9JRCLnzG8FuWPMGGYog7RnFRUuXS5HRdB
         7O87K+VXyhd0YtE+edUwzMaZTu6nt+LH9iFIKqP3ZRqtQtJr75yoNMwwVnTtyVpFEYGR
         v7zX3fSfc3nA0Q6nJegIp9RXDL7z0ptSV2epyUxu+cx6hGjc/7jSG3dyxfssmy6PZRRK
         eFP046stvtm/TjPw4/bvrT8rn5XDe0FKcnEpHmXVm45MxJb8ez28SjXjO4o6m/dGvPc1
         SnPX3kix8FiQblWGS/a8zeHSg5crqQIqNGW910R5zqc+hEgrpEuPaTYZx5Ci5s3MKmoK
         AkQQ==
X-Gm-Message-State: AOAM531bg82UsYuAj86fN2mYpCr3vGpQUTf4tGClYbxWtmsOklBwdVrr
        RmQKJQGbQfFSE+FCJUPAC2E9nTXzj/0=
X-Google-Smtp-Source: ABdhPJxkWzwNBP1QSOiaYqtUVC+tHdy/6DqYYlDNlu/SLwACu0/5l9tUZ71OFZLaBbljzGOBD8nxCg==
X-Received: by 2002:a19:e0d:: with SMTP id 13mr4957976lfo.549.1616063872520;
        Thu, 18 Mar 2021 03:37:52 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.googlemail.com with ESMTPSA id h24sm189257ljg.77.2021.03.18.03.37.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 03:37:52 -0700 (PDT)
Subject: Re: [PATCH v4 1/6] soc/tegra: Add
 devm_tegra_core_dev_init_opp_table()
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Paul Fertser <fercerpav@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210314164810.26317-1-digetx@gmail.com>
 <20210314164810.26317-2-digetx@gmail.com>
 <8f78a014-eeab-d788-7d3b-b52b8109cb2c@gmail.com>
 <20210318103250.shjyd66pxw2g2nsd@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <2498dd11-1d71-b245-2651-e43ab3f70e17@gmail.com>
Date:   Thu, 18 Mar 2021 13:37:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210318103250.shjyd66pxw2g2nsd@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

18.03.2021 13:32, Viresh Kumar пишет:
> On 18-03-21, 13:27, Dmitry Osipenko wrote:
>> 14.03.2021 19:48, Dmitry Osipenko пишет:
>>> Add common helper which initializes OPP table for Tegra SoC core devices.
>>>
>>> Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
>>> Tested-by: Paul Fertser <fercerpav@gmail.com> # PAZ00 T20
>>> Tested-by: Nicolas Chauvet <kwizart@gmail.com> # PAZ00 T20 and TK1 T124
>>> Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  drivers/soc/tegra/common.c | 137 +++++++++++++++++++++++++++++++++++++
>>>  include/soc/tegra/common.h |  30 ++++++++
>>>  2 files changed, 167 insertions(+)
>>
>> Viresh, do you think it will be possible to take this patch via the OPP
>> tree along with the devres patches if Thierry will give an ack? This
>> will allow us to start adding power management support to Tegra drivers
>> once 5.13 will be released.
> 
> I can do that.. OR
> 
> I can give an immutable to Thierry over which he can base these patches..
> 

Thank you!

Thierry, please let us know if you're okay with this patch and what
variant you prefer more.
