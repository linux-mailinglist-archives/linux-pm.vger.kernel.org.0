Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D68A3509B4
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2019 13:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbfFXLYU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Jun 2019 07:24:20 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35196 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729477AbfFXLYU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jun 2019 07:24:20 -0400
Received: by mail-lj1-f196.google.com with SMTP id x25so12265343ljh.2;
        Mon, 24 Jun 2019 04:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8gvk5GASPNCFWbApHpT04KBTfKEWcp0twApXx08UPkI=;
        b=ACXES/EFhB7Ih+WhhqABVOb0QduIc2PoED54Mb7dYfi6+j+CrruI8UBaIhc7JLjOv9
         Wq9vT/sPfsFWvm1Pg+Exrq/cCEbCyB3SqyN4ivOvJ6oTtqbU9oZEXn4gB4rvFj3zc5dA
         S0OFuam3sMUk+pVbh0SaDc/ATZjoeZ/V5ILqYCYbRB7ckCtDcPOW3lES/tMuCQraf7UB
         DNdBt/xgW4O223gofyhmfHgjVaJvFWWIPuYR47pqVRvPpCjRW1z2J/oEcXY6v8abmcTP
         BNpb9Fn0vHSs0Y2xe5AJa6xYjy4DbxtcvwNioBhPpSKKWt+YtWUj+6qr6AFhwopoi9tr
         aPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8gvk5GASPNCFWbApHpT04KBTfKEWcp0twApXx08UPkI=;
        b=Cz+gn6lrUBlOsKI5dBC8MT3YPU/Ujy3UsTyYKtwl+RWniNInng8YqXKwZE6lHe4mJA
         BzEXhgbl/i9ZtwZB3wI50MXN+zPd3CZIHbuh5kP3F9csvKu4IHp3HVyqTHycpc++H8B0
         glVdkSOSG0NaObl84qXzPN/Kkjy6HNXSTxIiCYkjwVUPMjH4JllGWdvW9B2+ZjSI3yzI
         CFQ078MRQ6rBnrpEY8VyelyAmFt2T2zPLqBZgZoIIbrUiTZsY9Vaoy2ocHjDtRq5kRIA
         x48pB/qTnMKk7m1HZBgu2EDdkd9C1BQX/udgh39Pk4k1O2vyK8nv5UfWzw/gCc19/KNB
         zbEQ==
X-Gm-Message-State: APjAAAUi0ojxah1CoWTbkXzp0+IWVWenKzJ+QkAJ/rb/QW9A24Dg4rRt
        ibn/wqoA3OvRlKDn/WLNVy4=
X-Google-Smtp-Source: APXvYqy/7ZQc8jeydT38n1bqGoa/x+R4Uqit0gUF/G9MnVl5l4eo+qFmEQ+Hhix8WVAr09HpbTQktw==
X-Received: by 2002:a2e:9c43:: with SMTP id t3mr16672742ljj.157.1561375458294;
        Mon, 24 Jun 2019 04:24:18 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.googlemail.com with ESMTPSA id v139sm1530806lfa.69.2019.06.24.04.24.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 04:24:17 -0700 (PDT)
Subject: Re: [PATCH v4 13/16] PM / devfreq: tegra: Support Tegra30
To:     myungjoo.ham@samsung.com
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>
References: <37db00bc-3a22-d1c2-7bdc-e27af42cd5c7@gmail.com>
 <20190624065919epcms1p1a366de5f455f5138c438d1da8151c12f@epcms1p1>
 <20190624073414epcms1p87b6dc13758b6bd401d275cfba583314a@epcms1p8>
 <CGME20190624065919epcms1p1a366de5f455f5138c438d1da8151c12f@epcms1p3>
 <20190624111134epcms1p361aed3c72edd6eebc95408331c8d9739@epcms1p3>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <7561edbc-c17c-101a-b339-fc7f9968a470@gmail.com>
Date:   Mon, 24 Jun 2019 14:24:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190624111134epcms1p361aed3c72edd6eebc95408331c8d9739@epcms1p3>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

24.06.2019 14:11, MyungJoo Ham пишет:
>>
>> --------- Original Message ---------
>> Sender : Dmitry Osipenko <digetx@gmail.com>
>>
>> 24.06.2019 10:34, MyungJoo Ham пишет:
>>>>
>>>> A question:
>>>>
>>>> Does this driver support Tegra20 as well?
>>>> I'm asking this because ARCH_TEGRA includes ARCH_TEGRA_2x_SOC
>>>> according to /drivers/soc/tegra/Kconfig.
>>>>
>>>
>>> For this matter, how about updating your 13/16 patch as follows?
>>>
> []
>>
>> Good call! I'll update this patch following yours suggestion, thanks.
> 
> Or, you may approve the modified commits here:
> https://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git/log/?h=for-next

Looks almost good to me!

I just recalled that there is also a 64bit variant of Tegra124, the Tegra132. Hence
the Tegra30+ Kconfig entry should look like this (it's also worthy to break the lines
for readability):

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index ccb1a68c4b51..bd2efbc27725 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -94,7 +94,10 @@ config ARM_EXYNOS_BUS_DEVFREQ

 config ARM_TEGRA_DEVFREQ
        tristate "NVIDIA Tegra30/114/124/210 DEVFREQ Driver"
-       depends on ARCH_TEGRA || COMPILE_TEST
+       depends on ARCH_TEGRA_3x_SOC  || ARCH_TEGRA_114_SOC || \
+                  ARCH_TEGRA_132_SOC || ARCH_TEGRA_124_SOC || \
+                  ARCH_TEGRA_210_SOC || \
+                  COMPILE_TEST
        select PM_OPP
        help
          This adds the DEVFREQ driver for the Tegra family of SoCs.

Could you please adjust the patches like I'm suggesting? I'll approve yours change
then and won't re-spin the first batch of the patches.
