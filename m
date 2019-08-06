Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 463888384F
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2019 20:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731664AbfHFSAH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Aug 2019 14:00:07 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45198 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfHFSAG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Aug 2019 14:00:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id n1so2481367wrw.12;
        Tue, 06 Aug 2019 11:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H5oxnh6AO2iA8nJMA3gm0i0KrEK2AnvYtvfzFwUa/VE=;
        b=IzSuLQwki0yPJVH+d2Lbq4S+g4ZX2atTnbAvcpq0wE42xwkMJXiMqPeaS+r8xL/eJR
         yYnjYN4vJkH3QaoGEegtr4CskAhmGEEJlNnan2gZeaJ/3x8JtuBMJNuNfrSBD+PS0WVE
         1DbHnAkhJcKPjfpoprfD9f9K469CSmuGORfCOxkyIbCXql6IgsdNXiwySWIQSfdJser5
         VjDTtVoAhWsxRu4uYcGxs9xZolHRtAkdOq2IXCzk2//Zv+7Oy8EzDl2EUB/iwXGh5PWK
         /7jCtQ56iS/RLwsu/+GtzMSMZ8vkSSukriVez8SsXpLnO+CZ4zq5Gr82na4GPtZGD89d
         5oXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H5oxnh6AO2iA8nJMA3gm0i0KrEK2AnvYtvfzFwUa/VE=;
        b=p+85ICzLfBQzknBS85lr/c50S5gA98FUcJyYeji6zmVSOhbyHKuQSiPcdoG4+hGt+L
         Jvlj6VQT/fj8BCHCgpFa/1lyqx6AiNbT3R2oS2e9tIdFNWu5yRMrUqHbvVihh00oQovB
         7yPFQDAiqqeRegiiu3eUD8pdNPSl6rN3KTQiVC5On2l8bf7UtnD6Z4p9sWzQHesiuhFd
         Bq8JyZVbUyuVrcu1M9VGFqEgQLU665hdXqX66SBvhkJ8MRzKCusL7MNK1DahUswDXD0g
         dzz63/GaX64fTjzbktQnQ6aZAIaCLAmI86nBYrhvI5Xojmf0vcbIdwSoc0lPo1DqPHC1
         9DDw==
X-Gm-Message-State: APjAAAVvhjB0LMgS4wUSYsebp96HT5DTJ9usjaAdd4yQb6DdmaeRYM8h
        l1Ik/950SbLzLJm5Qjf3yoJOSMUy
X-Google-Smtp-Source: APXvYqwjSklAKmvrxBm7vAtY5yV+LjCxCE5435J3gWbWBlaR4/GMOjfR3ZIimhrfsVDAPcavz8+urg==
X-Received: by 2002:adf:dd01:: with SMTP id a1mr5755415wrm.12.1565114403275;
        Tue, 06 Aug 2019 11:00:03 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.34.218])
        by smtp.googlemail.com with ESMTPSA id k9sm22855190wrd.46.2019.08.06.11.00.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 11:00:02 -0700 (PDT)
Subject: Re: [PATCH v7 01/20] pinctrl: tegra: Add suspend and resume support
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, tglx@linutronix.de,
        jason@lakedaemon.net, marc.zyngier@arm.com,
        linus.walleij@linaro.org, stefan@agner.ch, mark.rutland@arm.com
Cc:     pdeschrijver@nvidia.com, pgaikwad@nvidia.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        jckuo@nvidia.com, josephl@nvidia.com, talho@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        mperttunen@nvidia.com, spatra@nvidia.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org
References: <1564607463-28802-1-git-send-email-skomatineni@nvidia.com>
 <1564607463-28802-2-git-send-email-skomatineni@nvidia.com>
 <6b1482f6-0578-f602-d8d1-541d86303ce2@gmail.com>
 <b45ca99a-188a-c695-3f3d-48d273808f9c@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <36351140-afd4-38c4-3722-4ee0894287fa@gmail.com>
Date:   Tue, 6 Aug 2019 20:59:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <b45ca99a-188a-c695-3f3d-48d273808f9c@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

05.08.2019 21:06, Sowjanya Komatineni пишет:
> 
> On 8/5/19 3:50 AM, Dmitry Osipenko wrote:
>> 01.08.2019 0:10, Sowjanya Komatineni пишет:
>>> This patch adds support for Tegra pinctrl driver suspend and resume.
>>>
>>> During suspend, context of all pinctrl registers are stored and
>>> on resume they are all restored to have all the pinmux and pad
>>> configuration for normal operation.
>>>
>>> Acked-by: Thierry Reding <treding@nvidia.com>
>>> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>> ---
>>>   drivers/pinctrl/tegra/pinctrl-tegra.c | 59
>>> +++++++++++++++++++++++++++++++++++
>>>   drivers/pinctrl/tegra/pinctrl-tegra.h |  3 ++
>>>   2 files changed, 62 insertions(+)
>>>
>>> diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.c
>>> b/drivers/pinctrl/tegra/pinctrl-tegra.c
>>> index 186ef98e7b2b..e3a237534281 100644
>>> --- a/drivers/pinctrl/tegra/pinctrl-tegra.c
>>> +++ b/drivers/pinctrl/tegra/pinctrl-tegra.c
>>> @@ -631,6 +631,58 @@ static void
>>> tegra_pinctrl_clear_parked_bits(struct tegra_pmx *pmx)
>>>       }
>>>   }
>>>   +static size_t tegra_pinctrl_get_bank_size(struct device *dev,
>>> +                      unsigned int bank_id)
>>> +{
>>> +    struct platform_device *pdev = to_platform_device(dev);
>>> +    struct resource *res;
>>> +
>>> +    res = platform_get_resource(pdev, IORESOURCE_MEM, bank_id);
>>> +
>>> +    return resource_size(res) / 4;
>>> +}
>>> +
>>> +static int tegra_pinctrl_suspend(struct device *dev)
>>> +{
>>> +    struct tegra_pmx *pmx = dev_get_drvdata(dev);
>>> +    u32 *backup_regs = pmx->backup_regs;
>>> +    u32 *regs;
>>> +    size_t bank_size;
>>> +    unsigned int i, k;
>>> +
>>> +    for (i = 0; i < pmx->nbanks; i++) {
>>> +        bank_size = tegra_pinctrl_get_bank_size(dev, i);
>>> +        regs = pmx->regs[i];
>>> +        for (k = 0; k < bank_size; k++)
>>> +            *backup_regs++ = readl_relaxed(regs++);
>>> +    }
>>> +
>>> +    return pinctrl_force_sleep(pmx->pctl);
>>> +}
>>> +
>>> +static int tegra_pinctrl_resume(struct device *dev)
>>> +{
>>> +    struct tegra_pmx *pmx = dev_get_drvdata(dev);
>>> +    u32 *backup_regs = pmx->backup_regs;
>>> +    u32 *regs;
>>> +    size_t bank_size;
>>> +    unsigned int i, k;
>>> +
>>> +    for (i = 0; i < pmx->nbanks; i++) {
>>> +        bank_size = tegra_pinctrl_get_bank_size(dev, i);
>>> +        regs = pmx->regs[i];
>>> +        for (k = 0; k < bank_size; k++)
>>> +            writel_relaxed(*backup_regs++, regs++);
>>> +    }
>> I'm now curious whether any kind of barrier is needed after the
>> writings. The pmx_writel() doesn't insert a barrier after the write and
>> seems it just misuses writel, which actually should be writel_relaxed()
>> + barrier, IIUC.
> 
> pmx_writel uses writel and it has wmb before raw_write which complete
> all writes initiated prior to this.
> 
> By misusing writel, you mean to have barrier after register write?

Yes, at least to me it doesn't make much sense for this driver to stall
before the write. It's the pinctrl user which should be taking care
about everything to be ready before making a change to the pinctrl's
configuration.

>> It's also not obvious whether PINCTRL HW has any kind of write-FIFO and
>> thus maybe read-back + rmb() is needed in order ensure that writes are
>> actually completed.
> I believe adding write barrier wmb after writel_relaxed should be good
> rather than doing readback + rmb
>>
>> The last thing which is not obvious is when the new configuration
>> actually takes into effect, does it happen immediately or maybe some
>> delay is needed?
>>
>> [snip]
> 
> Based on internal design there is no internal delay and it all depends
> on APB rate that it takes to write to register.
> 
> Pinmux value change to reflect internally might take couple of clock
> cycles which is much faster than SW can read.

Still not quite obvious if it's possible to have a case where some
hardware is touched before necessary pinctrl change is fully completed
and then to get into trouble because of it.
