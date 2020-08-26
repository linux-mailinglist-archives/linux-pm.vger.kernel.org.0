Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B472526EE
	for <lists+linux-pm@lfdr.de>; Wed, 26 Aug 2020 08:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgHZGeT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Aug 2020 02:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbgHZGeT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Aug 2020 02:34:19 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AD2C061574;
        Tue, 25 Aug 2020 23:34:18 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id m22so1023548ljj.5;
        Tue, 25 Aug 2020 23:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lgWQaoUOmck1zKDSkfP/KU2pBuaR71IA8RK6LfmWfiU=;
        b=BStScc7SEeJUXWtFIaOczGlfItuM9LUgot65Loa+CmcdSSPsyajCEedCUQudaWZm9z
         2TzbozcX2s/U8pizJdFJ+iQHlu/IhWgEvwKuCgyC/MTXQeXCEY9o8LLux0T3CdD3AtA7
         tn14pPv210JrLNqMSWzcgvPTGInmDCtX8eZLXqXRf084qdVH4xCMb2EOnB8WKBLC3VRG
         FRkDG01aQbahppWVUqjzkW/AhJzBAulb4Z/WFkm+l3/BZX4cpFEVGo6mwDXX/OOz+YAe
         ACwf6a462wehrJUZoFH9LB6jP6Fab5BbOOGEV3pyp5UTLFeayZmjFIssirme/7grvq3y
         Rxlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lgWQaoUOmck1zKDSkfP/KU2pBuaR71IA8RK6LfmWfiU=;
        b=Qfm57taGOyea3w6577o3CZYagCbbZPg7ZpnDklL5R5Qzlbm3vgQe+d3o2X8I1tyZLu
         VuwZrNrTW/YmJpSz4wgh865BCqs2KeUKcEyK3JMnHUAH7XUAbHb2H/TZFxgWBcUIr2Ud
         4nt+4bi9KC/WXeF86G0uvRtrva8I5rq/DuX9KtOa38i//Khmi3d8CFHccMZnPve0tcu0
         yq/ieTMW/G72sAvNBVbIbcrQbZUdU+GvjXUaUZXhYPmPoFs57FclcLN9PlJdj6eA+H36
         rcC8SdFmsD6oREuwbyLgPglDHf1bZfIw4utuux17/bvvUYFrE5c+/aGyuvg5HV8F5dHF
         0rNg==
X-Gm-Message-State: AOAM532Orx5Jx7Nj660Uso8BzBA3nvzMFHBmfuT1F0VvTeeV/7UZoTJ0
        gT0ZRD1SICELQvpbjmI3mKstGHgyTpE=
X-Google-Smtp-Source: ABdhPJzPxuktg7pPrBXmouq95t70LJMDgatsUj53Twb1MRVQoKDhxeCz9r165MKz6Y5g35tPP6YkBw==
X-Received: by 2002:a05:651c:88:: with SMTP id 8mr6808046ljq.277.1598423656911;
        Tue, 25 Aug 2020 23:34:16 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id q5sm315641lfn.92.2020.08.25.23.34.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2020 23:34:16 -0700 (PDT)
Subject: Re: [PATCH v1 2/6] power: supply: Add battery gauge driver for Acer
 Iconia Tab A500
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Lubomir Rintel <lkundrak@v3.sk>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200823140846.19299-1-digetx@gmail.com>
 <20200823140846.19299-3-digetx@gmail.com>
 <20200824140718.apoavlny6hlkm2ql@earth.universe>
 <31ec6865-4a33-bde8-73a6-20c188ec2ee7@gmail.com>
 <20200824213859.6o3q5i2kvtk44lqi@earth.universe>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <bc5e828c-67ce-0c9e-e8e7-19a532145cfa@gmail.com>
Date:   Wed, 26 Aug 2020 09:34:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200824213859.6o3q5i2kvtk44lqi@earth.universe>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

25.08.2020 00:38, Sebastian Reichel пишет:
> Hi,
...
>> Hello, Sebastian! The battery isn't hot-swappable on A500, but it also
>> should be okay to always re-read the serialno. I'll consider removing
>> the caching in the v2, thanks.
> 
> I assumed it would be hot-swappable because of a500_battery_get_presence().
> If it's not hot-swappable, the caching is fine.

The battery could be disconnected from the motherboard, but this
requires to have device disassembled.

Okay, I'll keep the caching.

Thanks!
