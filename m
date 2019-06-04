Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1449234975
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2019 15:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfFDNxW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jun 2019 09:53:22 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:32989 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbfFDNxV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jun 2019 09:53:21 -0400
Received: by mail-lf1-f65.google.com with SMTP id y17so16529193lfe.0;
        Tue, 04 Jun 2019 06:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g0c5U8ZJGzowzVjpPuh+TTxQXYZLeAWd3eLnBu8wlp0=;
        b=FW/ZVCa4F/VreNcXD+vRknNNUfwKryBDe2hohStLr9swLZo/c+UzNthU6e2v4e75fY
         78wSKmqd5+0yv4vjDNKSgSNWuzLc4R0BF3ACSDSAnLwsTeHoqtOpPDSMe7iUBfB6OBAI
         oA27Ht93aSOs+3mk78FYQpsDYtDUQng9HSmPr2CQ+1H8iIVr+wBk+URc08YMs0RQse7G
         8cEUnRb/uARJNoMsv58mmRWp8n0Q7qKrbyuqzPF4qnV0gGyrjB62e017UQHTSRsg1JGq
         h88AR17Sv/GjBLSHo47tSjFJRHhPvhEvZwKGZjKn4iBIRaMDh0PqttZ6IdwEhlOgXOwI
         SH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g0c5U8ZJGzowzVjpPuh+TTxQXYZLeAWd3eLnBu8wlp0=;
        b=hsiTOPNNZI9llgApvxB7+y7v7AmWEBTVpesIozzNAE3NFBmCZsETf+OMOL9twu8ZsD
         lpv6/0R+ZqoRb3i+apjj5yvsv3HKCXL3LwQTrHfeBM+kvLFi/n+vODutapgpL+BEktdE
         i6qqNBJXPjOJ5rGzJZT50R2kwlL7qkmwGPx/L8ugT6wsfcRI3JA+rlnWgEsTo1IgibAx
         PYb0Sul87qey3qF25jua5+2jb0ZpEjj8zwdHNyNts7SlQoGTJYzP7J3uayAe4lBcojEV
         wX/gU1Xl/QIR1ad5oqMhcS9LCbkZO0QInxH3DEsKHvyNNeUmiCouybDh0dgCM5SwBSSQ
         G0dw==
X-Gm-Message-State: APjAAAWCrfYKHsZD1LWyCPUH/QRxTuOBwCs5SLDM1qj48rZDlj0Qs4ut
        LfiqVX6zqwMUwNZZw6h8PBBYsK/O
X-Google-Smtp-Source: APXvYqy/ffUKUetGBGQNSy2Yeu9gMiDil61iuTwt1LZIAxMToBU2WneJeLI3inPFotDil9jfBdAcrw==
X-Received: by 2002:a19:ca02:: with SMTP id a2mr14518234lfg.88.1559656399186;
        Tue, 04 Jun 2019 06:53:19 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.35.141])
        by smtp.googlemail.com with ESMTPSA id b25sm3732074lff.42.2019.06.04.06.53.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 06:53:18 -0700 (PDT)
Subject: Re: [PATCH v4 14/16] PM / devfreq: tegra: Enable COMPILE_TEST for the
 driver
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190501233815.32643-1-digetx@gmail.com>
 <20190501233815.32643-15-digetx@gmail.com> <20190604112026.GN16519@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ed2c502f-8f49-d89b-32c6-4b5415e1fa47@gmail.com>
Date:   Tue, 4 Jun 2019 16:53:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190604112026.GN16519@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

04.06.2019 14:20, Thierry Reding пишет:
> On Thu, May 02, 2019 at 02:38:13AM +0300, Dmitry Osipenko wrote:
>> The driver's compilation doesn't have any specific dependencies, hence
>> the COMPILE_TEST option can be supported in Kconfig.
>>
>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/devfreq/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
>> index 56db9dc05edb..a6bba6e1e7d9 100644
>> --- a/drivers/devfreq/Kconfig
>> +++ b/drivers/devfreq/Kconfig
>> @@ -93,7 +93,7 @@ config ARM_EXYNOS_BUS_DEVFREQ
>>  
>>  config ARM_TEGRA_DEVFREQ
>>  	tristate "NVIDIA Tegra30/114/124/210 DEVFREQ Driver"
>> -	depends on ARCH_TEGRA
>> +	depends on ARCH_TEGRA || COMPILE_TEST
>>  	select PM_OPP
>>  	help
>>  	  This adds the DEVFREQ driver for the Tegra family of SoCs.
> 
> You need to be careful with these. You're using I/O register accessors,
> which are not supported on the UM architecture, for example.
> 
> This may end up getting flagged during build testing.

We have similar cases in other drivers and it doesn't cause any known
problems because (I think) build-bots are aware of this detail. Hence
there is no real need to be overreactive here and in this particular
case it's better to react to real problems once they show up (we already
did that by fixing build breakage caused by a CLK API problem found by
bot in v3). Does it sound like a good argument to you? ACK?
