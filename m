Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E86653976CC
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jun 2021 17:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbhFAPgt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Jun 2021 11:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbhFAPgt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Jun 2021 11:36:49 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159B7C061574;
        Tue,  1 Jun 2021 08:35:07 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id t28so1779757pfg.10;
        Tue, 01 Jun 2021 08:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3HuiPCeuqXkl1SzHJvsVZWtr7PWvQn4WmEK8nHEzvA0=;
        b=QGP68DpXcY2bPApu690wyA3jX5gM55Ygds+YsofPUJJuxnkE1FIAxaMFKwt3LTIzrU
         FJ7TU30NRFWKipgHY+sN5fBCpJy3wJC7zTv2cs+v8Re54X1jarhO4m2pJk+4Wwv5D1PU
         T3UIPBhiOG/gXQ/vyoj9rBVboKJcsqdyIN/qmvmeOGmDtRmlE4hJ4C+b1TgvfoJ+7apJ
         ZicketUF9bK8prff0rAgySt48iLGmEcf9kjE6TJueLyQEW2hH9ntI1s2lnthq9TswKYw
         90xidTwMXtOXGrH3ydBgX8i9p9+9yTwHWurabKNpeJsKZ/7C4moZntLHBvfhTTlN9UkC
         p5BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3HuiPCeuqXkl1SzHJvsVZWtr7PWvQn4WmEK8nHEzvA0=;
        b=l0YJtv9J9rHZjWWyL6GFszb6filzoEkermWEWckFlJ/Vx6J6LwW+C3Py+0FjtJlxmV
         ztFFPRFMycv/vKVu7Ggl29cQNasR3Lh0r42CG5CnldR90UPoCTXzsb9Y3tuuvWmKzpVj
         sSbYsEfhu43Da0UfyEw9cIWXjGraFmUrt6D8tBZaW6WzOQW9EZl/kLCZlaw4YiPrPgyd
         Yltw6Hx+MNi21MPlBIBoZSi9vkDOg5oxS40kDFyQHvWiC4WI56nJGcZuMcH9lQMcXdsA
         u8JsbUfXwQLbcgNLj7TTtRwktlpRAmww8MjXM1jjRiXTeKbLqc78FxIIBlHrHvd1wMnN
         /b9w==
X-Gm-Message-State: AOAM533SGRISDUX/1CsRZ9baBbVA0ooRrsIToXTka93/eh4B2TwkL2zJ
        fSYhyqGy7JxIbl09KGR8VfXFNDCuT3E=
X-Google-Smtp-Source: ABdhPJwrgfdey7uyo9cG9PKONhkzO8q/DQPTj6pBkGo1ABJP8RpR5dojTQx/0QOwcopW1NsH3xgTNA==
X-Received: by 2002:a63:1e4f:: with SMTP id p15mr28615812pgm.40.1622561706051;
        Tue, 01 Jun 2021 08:35:06 -0700 (PDT)
Received: from [172.30.1.14] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id 136sm13363191pfu.195.2021.06.01.08.35.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 08:35:05 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Add thermal cooling support to NVIDIA Tegra
 devfreq
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20210601022319.17938-1-digetx@gmail.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <04670190-f50c-25fe-6b51-969d5cd42eeb@gmail.com>
Date:   Wed, 2 Jun 2021 00:35:01 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210601022319.17938-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21. 6. 1. 오전 11:23, Dmitry Osipenko wrote:
> This series adds two remaining patches of the ACTMON cooling support
> series, converting the DT binding to schema and adding cooling properties.
> The rest of the patches are already applied.
> 
> Changelog:
> 
> v2: - Added back the "MEMORY CONTROLLER" section to the description of the
>        interconnect-names property, which was suggested by Thierry Reding.
> 
>      - Added r-b from Rob Herring and acks from Chanwoo Choi and
>        Thierry Reding.
> 
> Dmitry Osipenko (2):
>    dt-bindings: devfreq: tegra30-actmon: Convert to schema
>    dt-bindings: devfreq: tegra30-actmon: Add cooling-cells
> 
>   .../arm/tegra/nvidia,tegra30-actmon.txt       |  57 --------
>   .../devfreq/nvidia,tegra30-actmon.yaml        | 126 ++++++++++++++++++
>   2 files changed, 126 insertions(+), 57 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra30-actmon.txt
>   create mode 100644 Documentation/devicetree/bindings/devfreq/nvidia,tegra30-actmon.yaml
> 

Applied them. Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
