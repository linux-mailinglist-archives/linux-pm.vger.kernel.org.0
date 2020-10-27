Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13AB29C8CE
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 20:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372114AbgJ0TZz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 15:25:55 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39616 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409860AbgJ0TYT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 15:24:19 -0400
Received: by mail-lj1-f193.google.com with SMTP id m16so3098349ljo.6;
        Tue, 27 Oct 2020 12:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=teL4BWb/Ty3//gGMcFWg0CBXJ+qn3TO36Ic9xGZcykU=;
        b=LXDwnZLSSzHdk+0NS518g92nqSNo92zjKQB6eO3qPuniQf2f7O3xLfJ3OkwiXb0xzI
         /TbIM/0Hp/SwGeByMcE5EXZJDL5EB8hG2tb/SY1WkahU0aJ52oMgfA1ObZZJ9dP8fB4D
         8v0QS3qMbQ/j6FmS//hcjBm5bbYokHuj4kl7w++OtQrKa9C0z/5P6jt9gjYmT8uufARH
         w30YEyWUOqP+1eMG4G1OZY2v/mJdwAToDE7z9OHzFd2OCY14YvP5peSAjskcluq8PDpo
         m+k5opVMl0bfiDDCnVhVW5Vz4IoBc/RPnio/7abM1vXHZ0wmut3M/DyIQgV310/dspSm
         xmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=teL4BWb/Ty3//gGMcFWg0CBXJ+qn3TO36Ic9xGZcykU=;
        b=amtwM5xBevXJAbpuTxL5GAG5TxtCjQfilfJ/tBkycKtfyfEZw7K4D618CHZgC80SvP
         uY4Dl1jMDAfRFZl7M4RV9Frjz28HoYSCck5Ohc8sOeYdLbnjGt62WwT+UCoLWNIF+N00
         PshB96z5Hmm1eR64X3RkfaIW3WYRj13OlEKD7X98mkLvm4EfUHLPZ+uuugehWGEukbW8
         eXukM31kr4Cei34J8ct3iHDw4sENrAerO8qDBgKblIKwDOEWUh+ghJY+7TSCzNkQh3K9
         BPNhj68ecx45DUc+XdCSLNy2Aq3OqzpaBk2SH4ozi4BcbzB6oE1KWuuuPobQQy7FRNAC
         H4ZA==
X-Gm-Message-State: AOAM532zmk4xFXar6OfTphXBrD4tl14idDz58DrlRFFBktBZ4aMDSFHR
        rnKsYqYFzuosYF8/baxe2KHubC5wEBc=
X-Google-Smtp-Source: ABdhPJzv2GoyZYU0TkuY3fjjB785+SF5G9Tj2p+DBHVKtHtdt6RjSyJ489SMNygpON3ydMV1RVDEXg==
X-Received: by 2002:a2e:3816:: with SMTP id f22mr1620510lja.214.1603826655898;
        Tue, 27 Oct 2020 12:24:15 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.googlemail.com with ESMTPSA id w139sm267282lff.163.2020.10.27.12.24.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 12:24:15 -0700 (PDT)
Subject: Re: [PATCH v6 28/52] memory: tegra: Add and use
 devm_tegra_get_memory_controller()
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-29-digetx@gmail.com> <20201027094210.GD10762@kozik-lap>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a9effe32-3272-7df9-08e5-da293b1854a9@gmail.com>
Date:   Tue, 27 Oct 2020 22:24:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201027094210.GD10762@kozik-lap>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

27.10.2020 12:42, Krzysztof Kozlowski пишет:
> On Mon, Oct 26, 2020 at 01:17:11AM +0300, Dmitry Osipenko wrote:
>> Multiple Tegra drivers need to retrieve Memory Controller and there is
>> duplication of the retrieval code among the drivers. This patch removes
>> the duplication and fixes put_device() which was missed in the duplicated
>> code.
>>
>> EMC drivers now use new common devm_tegra_get_memory_controller() helper
>> instead of opencoding the MC retrieval.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/memory/tegra/mc.c                | 48 ++++++++++++++++++++++++
>>  drivers/memory/tegra/tegra124-emc.c      | 18 ++-------
>>  drivers/memory/tegra/tegra210-emc-core.c | 39 +++++--------------
>>  drivers/memory/tegra/tegra30-emc.c       | 18 ++-------
>>  include/soc/tegra/mc.h                   | 10 +++++
>>  5 files changed, 74 insertions(+), 59 deletions(-)
>>
>> diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
>> index ec8403557ed4..12ea2c79205a 100644
>> --- a/drivers/memory/tegra/mc.c
>> +++ b/drivers/memory/tegra/mc.c
>> @@ -42,6 +42,54 @@ static const struct of_device_id tegra_mc_of_match[] = {
>>  };
>>  MODULE_DEVICE_TABLE(of, tegra_mc_of_match);
>>  
>> +static void tegra_mc_devm_action_put_device(void *data)
>> +{
>> +	struct tegra_mc *mc = data;
>> +
>> +	put_device(mc->dev);
>> +}
>> +
>> +/**
>> + * devm_tegra_get_memory_controller() - get Tegra Memory Controller handle
>> + * @dev: device pointer for the consumer device
>> + *
>> + * This function will search for the Memory Controller node in a device-tree
>> + * and retrieve the Memory Controller handle.
>> + *
>> + * Return: ERR_PTR() on error or a valid pointer to a struct tegra_mc.
>> + */
>> +struct tegra_mc *devm_tegra_get_memory_controller(struct device *dev)
> 
> Usually 'get' is a suffix (for example in clk, gpiod, iio, led), so:
> devm_tegra_memory_controller_get()

Alright, I'll rename it in v7.
