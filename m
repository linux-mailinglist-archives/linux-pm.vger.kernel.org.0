Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6823D83CEF
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2019 23:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfHFVvZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Aug 2019 17:51:25 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:6224 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfHFVvZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Aug 2019 17:51:25 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d49f65d0002>; Tue, 06 Aug 2019 14:51:25 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 06 Aug 2019 14:51:24 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 06 Aug 2019 14:51:24 -0700
Received: from [10.110.102.151] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 6 Aug
 2019 21:51:23 +0000
Subject: Re: [PATCH v7 01/20] pinctrl: tegra: Add suspend and resume support
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Stefan Agner <stefan@agner.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        <jckuo@nvidia.com>, "Joseph Lo" <josephl@nvidia.com>,
        <talho@nvidia.com>, <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mikko Perttunen" <mperttunen@nvidia.com>, <spatra@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        viresh kumar <viresh.kumar@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>
References: <1564607463-28802-1-git-send-email-skomatineni@nvidia.com>
 <1564607463-28802-2-git-send-email-skomatineni@nvidia.com>
 <CACRpkdZVR-i1c5eATL2hSPbLXcX1sR8NgXwa4j259XXUi57xug@mail.gmail.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <a2fb3795-5ec1-1d03-f496-f151d1270e90@nvidia.com>
Date:   Tue, 6 Aug 2019 14:51:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CACRpkdZVR-i1c5eATL2hSPbLXcX1sR8NgXwa4j259XXUi57xug@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565128285; bh=gUV/nSFh9pyMbly/cxjMzIWO74RSun53rYYSNmmjoN4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=oMlhdEUVeAmLGkU//WqtrKAHRzWtFZLiP6j4JhfYiR20Wo6xa2/qMIG5sVEIyqvRP
         VNiYGpXrJvCrevAHJzkq8q/7QhZENK9zqamKqdYdefnNkULU4Iws4Ilg+XG9W2WqCZ
         3FoURqBqFmv9gntK41TQNuDMgdwA+7fsCwHoZYd7//RhHIFM73L/f51tow56+N6Kjy
         xwnIGz9auKNZneGQPaTt/u6N01Tel9NCTolybXgyWQGDupdaIZYDfuDi83EpeJ+58I
         X2j+aJ03o6TC/zSlBZrz48r6vTKEyBFm+jOd4iQ+K105mVHPGMQeGAlkjF09AXQe4d
         l3ugSzwppV/tg==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 8/5/19 2:20 AM, Linus Walleij wrote:
> On Wed, Jul 31, 2019 at 11:11 PM Sowjanya Komatineni
> <skomatineni@nvidia.com> wrote:
>
>> This patch adds support for Tegra pinctrl driver suspend and resume.
>>
>> During suspend, context of all pinctrl registers are stored and
>> on resume they are all restored to have all the pinmux and pad
>> configuration for normal operation.
>>
>> Acked-by: Thierry Reding <treding@nvidia.com>
>> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> Patch applied to the pinctrl tree.
>
> This patch seems finished.
>
> Also if the rest don't get merged for v5.4 then at least this is so
> your patch stack gets more shallow.
>
> I hope it's fine to merge this separately, else tell me and I'll
> pull it out.
>
> Yours,
> Linus Walleij

Yes, this patch can be merged separately. But, there's latest feedback 
from Dmitry to add barrier after writes to make sure pinmux register 
writes happen.

So will update this patch to add barrier in v8. So, need to wait for v8.

Thanks

Sowjanya

