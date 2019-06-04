Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45184349A1
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2019 15:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfFDN5z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jun 2019 09:57:55 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43972 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbfFDN5z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jun 2019 09:57:55 -0400
Received: by mail-lj1-f195.google.com with SMTP id 16so6197006ljv.10;
        Tue, 04 Jun 2019 06:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uO7ACXZXkd2KsXzvU0+8u9VcZLTMopWk+AwbiaYSy3w=;
        b=brw7YOIllqDxC44Sb+iF+vklndo1xYrwejtr8CEPl2cmCVg+RNvKXy/hLQVGOXxjOP
         CxYD17dYn78eFZpCuuC1j4DC/eZcw6S8XhjRGKasNPidwAcfF6yNVU9i4nn5i8V00FVg
         rcUpcGKIJKkQmPCDLvzc4y/hiw5roCvsQG+RLP5MjlCXktirwk9zhikbChITmhfUiFq0
         KZcl0O89I3kVyiCcOih2gNttpgTg34lDhdv9KRzeFqWwGG4NastJAOmHOmPp8PEuXVWV
         IRgdJrS3le0Tb5sBxfdk7ErXdghXL5Z57G3cABekl5ylXumFsfeW0nB07mdNMLMZ8DO5
         dXTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uO7ACXZXkd2KsXzvU0+8u9VcZLTMopWk+AwbiaYSy3w=;
        b=oXLLF81g4H4mSUt/PLXTBpja/mkbf6ZjQepGKBT2ELWNeTTt6r4UeEhnVms0B3ePCS
         jFWiaSoTLaEaUxTWEVPE9t87rBtwXeEpr7VtHDYJZL7Z5/GDbYE5xmYyLOsK9DM841G2
         cd9/CobXhfjlKrSmJ+oDQ+/e0qucUbETESCYss8F9ADcXiVwH+qXpE6yqh44RbocijxP
         3Ot7iPx4F13i6WYQtfDWIl9vazVU3z65iZOpzyDzcV6x47epsWd8O+oJagDZ7Jyf8sFT
         j26+Rl6eO3J339eXiN/1UqJZCS0PWnPa/gxa4JO+lY2lmILqAJdYPqnIpo/fQf831Drl
         MvWQ==
X-Gm-Message-State: APjAAAVVMFhhKmItjjVpNlYR5m2xQfK+JQiqpqPYnBXacejZ9Bn0gvpH
        w+3INmdTHtFolGvcxGysRMWMIU/K
X-Google-Smtp-Source: APXvYqz7McG766r/nRCvSkKfbU6978oXMYiS0JDOH1aTn1x7cBmbB/HCXt/mEUWTBY04bME3INAqsQ==
X-Received: by 2002:a2e:9a9a:: with SMTP id p26mr3227596lji.64.1559656673189;
        Tue, 04 Jun 2019 06:57:53 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.35.141])
        by smtp.googlemail.com with ESMTPSA id a29sm1675517lfi.23.2019.06.04.06.57.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 06:57:52 -0700 (PDT)
Subject: Re: [PATCH v4 16/16] PM / devfreq: Introduce driver for NVIDIA
 Tegra20
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190501233815.32643-1-digetx@gmail.com>
 <20190501233815.32643-17-digetx@gmail.com> <20190604112524.GP16519@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ca0930ed-bf06-508b-31a4-82229bdb1e81@gmail.com>
Date:   Tue, 4 Jun 2019 16:57:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190604112524.GP16519@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

04.06.2019 14:25, Thierry Reding пишет:
> On Thu, May 02, 2019 at 02:38:15AM +0300, Dmitry Osipenko wrote:
>> Add devfreq driver for NVIDIA Tegra20 SoC's. The driver periodically
>> reads out Memory Controller counters and adjusts memory frequency based
>> on the memory clients activity.
>>
>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  MAINTAINERS                       |   8 ++
>>  drivers/devfreq/Kconfig           |  10 ++
>>  drivers/devfreq/Makefile          |   1 +
>>  drivers/devfreq/tegra20-devfreq.c | 212 ++++++++++++++++++++++++++++++
>>  4 files changed, 231 insertions(+)
>>  create mode 100644 drivers/devfreq/tegra20-devfreq.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 98edc38bfd7b..e7e434f74038 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -10098,6 +10098,14 @@ F:	include/linux/memblock.h
>>  F:	mm/memblock.c
>>  F:	Documentation/core-api/boot-time-mm.rst
>>  
>> +MEMORY FREQUENCY SCALING DRIVER FOR NVIDIA TEGRA20
>> +M:	Dmitry Osipenko <digetx@gmail.com>
>> +L:	linux-pm@vger.kernel.org
>> +L:	linux-tegra@vger.kernel.org
>> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git
>> +S:	Maintained
>> +F:	drivers/devfreq/tegra20-devfreq.c
>> +
>>  MEMORY MANAGEMENT
>>  L:	linux-mm@kvack.org
>>  W:	http://www.linux-mm.org
>> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
>> index a6bba6e1e7d9..1530dbefa31f 100644
>> --- a/drivers/devfreq/Kconfig
>> +++ b/drivers/devfreq/Kconfig
>> @@ -100,6 +100,16 @@ config ARM_TEGRA_DEVFREQ
>>  	  It reads ACTMON counters of memory controllers and adjusts the
>>  	  operating frequencies and voltages with OPP support.
>>  
>> +config ARM_TEGRA20_DEVFREQ
>> +	tristate "NVIDIA Tegra20 DEVFREQ Driver"
>> +	depends on (TEGRA_MC && TEGRA20_EMC) || COMPILE_TEST
>> +	select DEVFREQ_GOV_SIMPLE_ONDEMAND
>> +	select PM_OPP
> 
> Again, I'm not sure the COMPILE_TEST will work here unless you add a few
> more dependencies.

I have the same answer as I made in the comment to "Enable COMPILE_TEST
for the driver" patch. I think there is no real need to be overreactive
here as well, ACK?
