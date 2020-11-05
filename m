Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF8A2A7FEF
	for <lists+linux-pm@lfdr.de>; Thu,  5 Nov 2020 14:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbgKENuN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Nov 2020 08:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgKENuN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Nov 2020 08:50:13 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3FEC0613D2;
        Thu,  5 Nov 2020 05:50:13 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id u18so2366442lfd.9;
        Thu, 05 Nov 2020 05:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BGf3d80TYyIHjeoe0Cx5j/BQSsVOIev2ck0Z+AT+MFA=;
        b=e/YUri2q0AwoOKKb1hssOsWev/ladQj20yWBAgFxnUNTYPuKAryxtqcYYrUISJJ2vJ
         a39gIjb9Q6RQodOmBYioJczfUGlxshFy0MIDvx8eciIyRnKwFCz9pYD5SZ5VsLVB0P2d
         Q7kV7TXr6dL2Din/S+YXymcmnfrKHOT7zNHnfoxy0dNlpav+Mzo404f+CVsqX1zbaJ/g
         onGRaUTFnfQBBKoENk8PA1NFM291/PawkHb59+q5reczpOTIyfrOlRcn7TgYflcAwMep
         ThY5zx+sEIT5sFbV4XmKRVPBcNOT3QEfQW5tx/aib/VeQPU8waOAyqnvBsTNdnl/gM+c
         v9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BGf3d80TYyIHjeoe0Cx5j/BQSsVOIev2ck0Z+AT+MFA=;
        b=VMBl1vA/0CZFkUuNLs/bkfUfGtMHCHn0LA5/F8z0F378n5KWTZFKFuRVFsMiYIfkps
         e1/y5+IyjLOKqf84SOtBZDCWwtrPXmYSiEw+gL9dGn00uSdWOUJ15RcViCi/NyzC8GQX
         K0cw7PfLIRcJG2BRoAPmN1TDbK0K/PmZNoDSpWJvG6twBVHe5nQ0U1z2fTTIQWLgZo2P
         vt9byNyTT7JFx1EP0+0CqotagiatkSHIRNh1+4vGOO5BnUiEcb12Uu4OH4niNy8g0L/T
         pAhqelCRGTMqhl2/lX+ZsuWkiYwOucO7E8px8xnEeyzJ3d0ajmc0g1arLlio0md/QIM/
         0JEQ==
X-Gm-Message-State: AOAM531raSJrjzZdtUzHhoyqkvQzNOdLwFHN8HdehFEo8kk5u4MBKt7N
        jJWjnO1QXv4P6FlAsSKJQXsXJgEv/Es=
X-Google-Smtp-Source: ABdhPJx4ilpDj4/kx22rJ8VjlNT5VilKN2NSj8RSq3TaJ+NHg1ZFId48j+Ws8coKg74/KdbqiehQTw==
X-Received: by 2002:a19:8755:: with SMTP id j82mr951404lfd.511.1604584211377;
        Thu, 05 Nov 2020 05:50:11 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.googlemail.com with ESMTPSA id f9sm155946ljg.53.2020.11.05.05.50.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 05:50:10 -0800 (PST)
Subject: Re: [PATCH v7 47/47] PM / devfreq: tegra20: Deprecate in a favor of
 emc-stat based driver
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
References: <20201104164923.21238-1-digetx@gmail.com>
 <CGME20201104165117epcas1p1fe44f76f99454bcbbbf8b26882422224@epcas1p1.samsung.com>
 <20201104164923.21238-48-digetx@gmail.com>
 <cdceb3f7-9c58-5d2c-70ab-7947b4cb173e@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <164ea4c7-f770-445a-fe1a-31ddc49068be@gmail.com>
Date:   Thu, 5 Nov 2020 16:50:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cdceb3f7-9c58-5d2c-70ab-7947b4cb173e@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

05.11.2020 05:25, Chanwoo Choi пишет:
> Hi Dmitry,
> 
> You need to update the MAINTAINERS file about tegra20-devfreq.c
> 
> 11343 MEMORY FREQUENCY SCALING DRIVERS FOR NVIDIA TEGRA                               
> 11344 M:      Dmitry Osipenko <digetx@gmail.com>                                      
> 11345 L:      linux-pm@vger.kernel.org                                                
> 11346 L:      linux-tegra@vger.kernel.org                                             
> 11347 T:      git git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git     
> 11348 S:      Maintained                                                              
> 11349 F:      drivers/devfreq/tegra20-devfreq.c                                       
> 11350 F:      drivers/devfreq/tegra30-devfreq.c 
> 
> Except of missing the updating of MAINTAINERS,
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

Hello Chanwoo,

Good catch! Thank you!
