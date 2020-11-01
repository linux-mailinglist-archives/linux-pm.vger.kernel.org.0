Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 914E42A1EFF
	for <lists+linux-pm@lfdr.de>; Sun,  1 Nov 2020 16:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgKAPYO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Nov 2020 10:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbgKAPYO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Nov 2020 10:24:14 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C2CC0617A6;
        Sun,  1 Nov 2020 07:24:14 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id m16so12235544ljo.6;
        Sun, 01 Nov 2020 07:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TvSbmYTBbiH/6uQP+ocL/XJvZrWVgoLgTGEXcKMdRKw=;
        b=TZsCakYKTg1FrKZSl+qwJefjMXzq1vVG0ZESq6jgcr/4B0WepUkCLgNCIT825Cjwqn
         sN2TNLubmUwOOpeHaxS2Wxr5ISuxvb/BNkkbmzmdGNCCeLgHBEH5/v955E3Jzx5JPlx8
         JWM+MvTOeJ+NoAyeYCA/YQ39cN82ngBc1zcVZQpZIqlIhgilmgT9/4cAH1hq7bMU526Q
         gg9nt1msByT0vADvdhYYKgaL2i+2pYaPtCHC4AH0kcjt6Rcn0R6+hkOC57E4kZd+f1Zp
         0PD9+LHvLkidvjJDl2+0A+YPfA/b7sSvJYsRnLKvnqytrAyol9XBixf2WmxSIrzFsRws
         GqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TvSbmYTBbiH/6uQP+ocL/XJvZrWVgoLgTGEXcKMdRKw=;
        b=A5ftxPhkfabiH4/9K6gYjeUyOhIkEv20KxYtYtkGkoG4aWhvIswpV8b+mnb6jwmSBj
         0oqK4Kn57a3Ailuf2TXCgMM6J5johgWGNYJNXVNlURh6g5tWdBtpxXraGPlbJ9zk9jBA
         QTnD86QoR/0OL4MEOmXdbo0U2VEeaamn669TUdjN2iLGRyq6ocyAD9AiENLo2/FRKfq6
         Yl2dgh6rv2FTRCmKGhr32F3O/xyQFW+RhQw1gshjQ3Qzwd/k5ee+rMcW+2w5TKBo+jGV
         JkDNl5PIsuhx0L11kZW61yn4fZiLrP9kjp/vSm/5ayHULplQv54kZ8PafOdkDAutua7t
         KejA==
X-Gm-Message-State: AOAM5310b3x+FvBqQMqzsqlE57ZMlcKDwhvezjvQKSzNTJlVi/oJfVlz
        oNy30xngJG6H6ipyOwLpkxuEPVcM5TQ=
X-Google-Smtp-Source: ABdhPJxJqsa3z4OBcKgBN7B+2gEVgZQYaZlOk6XiYr6D8zFcMO+Rg/JZv768uPAmCkRM1XwgguwIZw==
X-Received: by 2002:a2e:681a:: with SMTP id c26mr5126010lja.56.1604244252401;
        Sun, 01 Nov 2020 07:24:12 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-177.dynamic.spd-mgts.ru. [109.252.193.177])
        by smtp.googlemail.com with ESMTPSA id l9sm1778384ljc.86.2020.11.01.07.24.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Nov 2020 07:24:11 -0800 (PST)
Subject: Re: [PATCH v6 51/52] PM / devfreq: tegra30: Support interconnect and
 OPPs from device-tree
To:     cwchoi00@gmail.com
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
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-tegra@vger.kernel.org,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-52-digetx@gmail.com>
 <CAGTfZH2rBaWKox9nKM=_Wz8k65FLt1R7D8xSOUxe7xAJ1A00hA@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <961863f7-933d-d455-cd5d-99bab898ee75@gmail.com>
Date:   Sun, 1 Nov 2020 18:24:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAGTfZH2rBaWKox9nKM=_Wz8k65FLt1R7D8xSOUxe7xAJ1A00hA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

01.11.2020 17:44, Chanwoo Choi пишет:
> Hi Dmitry,
> 
> On Mon, Oct 26, 2020 at 7:22 AM Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> This patch moves ACTMON driver away from generating OPP table by itself,
>> transitioning it to use the table which comes from device-tree. This
>> change breaks compatibility with older device-trees in order to bring
>> support for the interconnect framework to the driver. This is a mandatory
>> change which needs to be done in order to implement interconnect-based
>> memory DVFS. Users of legacy device-trees will get a message telling that
>> theirs DT needs to be upgraded. Now ACTMON issues memory bandwidth request
>> using dev_pm_opp_set_bw(), instead of driving EMC clock rate directly.
>>
>> Tested-by: Peter Geis <pgwipeout@gmail.com>
>> Tested-by: Nicolas Chauvet <kwizart@gmail.com>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/devfreq/tegra30-devfreq.c | 91 ++++++++++++++++---------------
>>  1 file changed, 48 insertions(+), 43 deletions(-)
>>
>> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
>> index 3f732ab53573..1b0b91a71886 100644
>> --- a/drivers/devfreq/tegra30-devfreq.c
>> +++ b/drivers/devfreq/tegra30-devfreq.c
>> @@ -19,6 +19,8 @@
>>  #include <linux/reset.h>
>>  #include <linux/workqueue.h>
>>
>> +#include <soc/tegra/fuse.h>
>> +
> 
> This patch touches the OPP. Is it related to this change?

Yes, this is needed for the dev_pm_opp_set_supported_hw().

>>  #include "governor.h"
>>
>>  #define ACTMON_GLB_STATUS                                      0x0
>> @@ -155,6 +157,7 @@ struct tegra_devfreq_device {
>>
>>  struct tegra_devfreq {
>>         struct devfreq          *devfreq;
>> +       struct opp_table        *opp_table;
>>
>>         struct reset_control    *reset;
>>         struct clk              *clock;
>> @@ -612,34 +615,19 @@ static void tegra_actmon_stop(struct tegra_devfreq *tegra)
>>  static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
>>                                 u32 flags)
>>  {
>> -       struct tegra_devfreq *tegra = dev_get_drvdata(dev);
>> -       struct devfreq *devfreq = tegra->devfreq;
>>         struct dev_pm_opp *opp;
>> -       unsigned long rate;
>> -       int err;
>> +       int ret;
>>
>>         opp = devfreq_recommended_opp(dev, freq, flags);
>>         if (IS_ERR(opp)) {
>> -               dev_err(dev, "Failed to find opp for %lu Hz\n", *freq);
>> +               dev_err(dev, "failed to find opp for %lu Hz\n", *freq);
> 
> You used the 'Failed to' format in almost every error case.
> Don't need to change it.
> (snip)

Good catch, thanks.
