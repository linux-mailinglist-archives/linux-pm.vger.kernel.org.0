Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52D52A9F9F
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 22:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbgKFVyI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 16:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728464AbgKFVyI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 16:54:08 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C397C0613CF;
        Fri,  6 Nov 2020 13:54:06 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id h6so3956921lfj.3;
        Fri, 06 Nov 2020 13:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bc3gS/Kujcc3KoLYMBRT58xRZm15H9o/SpU6p0gc5Ts=;
        b=NdVx9Kt3J1pK7OYym/8csqF8WLvbOjo+q3Jwm/cbzgbEdQO/CnOpbE6bqWcN9Sl30G
         X/KORpC3mndxuzy8af6XGZ0UviqVAzyXdV1P9MJRXIHeVVlayXM9CmUsWK6BFn6nT9IC
         DTwQjTGJbBI27CdxUHHRVn2ve4k7lUvDwetVpr7vqs/I8C6cFRvP/3lHXzorCSxrSgOV
         ifJ1SinltE+9o5qAewOaZqRBwbWfGHPgM/Gn3NVu8e6tOrn7nifS9ooDwVtFEysGYKsA
         0If7Txn7z2fK6kz8ppA/y6rMnLCgVOJ74CZ9Oz2agpFCzd6SwuJYWz8abzfa0ahR/yGF
         8qhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bc3gS/Kujcc3KoLYMBRT58xRZm15H9o/SpU6p0gc5Ts=;
        b=FwscGJD4Yt0GcOzpGSxhObU5pcd3NPpdB/MuuiTvPGupC/eJ8wGP2hoTuOIHen417+
         FXsrBLg2w4gw8V1YzF8wCtVc2NdD11BibQj4LkhnUR/B8tSswNuy9EYX3CB9hjtdLKWw
         wlatEwfxtXeGwVZQwfCuaIFKLpZIcviMjZNR+Tp9Nx2js8z5p/XltACqjujjllDpjmJk
         fHDumMtSrEYmOMd6JzM4u3wE56Iqw527XK7irCFtGoZ9UbT8M4Z2vZQYSBW69viZ69Ta
         bH3UgZxKrkCnm09kaur+CwYak0iZqo2GLhsBSOclZW/rXLB6bodh7HrG4umVU2i2ecs6
         8FBg==
X-Gm-Message-State: AOAM530lRQpX6raXp1taPT5DN8p4Nzd6Gs1nXaN4h7h6LJfF6avtw4My
        AB6q0wxO0J7/2gNV2pnR9MHJGnA05XE=
X-Google-Smtp-Source: ABdhPJwG1hbHsS5ENGHedoieOLi+ql3T9aVvWy84+TrVYC9E7f2C9zXhhxQrASw3WDpN25tjkqd49A==
X-Received: by 2002:a05:6512:10cd:: with SMTP id k13mr1554068lfg.597.1604699644396;
        Fri, 06 Nov 2020 13:54:04 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.googlemail.com with ESMTPSA id t5sm268687ljc.124.2020.11.06.13.54.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2020 13:54:02 -0800 (PST)
Subject: Re: [PATCH v7 36/47] memory: tegra20-emc: Add devfreq support
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
References: <20201104164923.21238-1-digetx@gmail.com>
 <20201104164923.21238-37-digetx@gmail.com> <20201106191319.GB65086@kozik-lap>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <6d8f07ed-c844-4b6e-433c-aa1499ca9dba@gmail.com>
Date:   Sat, 7 Nov 2020 00:53:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201106191319.GB65086@kozik-lap>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

06.11.2020 22:13, Krzysztof Kozlowski пишет:
> On Wed, Nov 04, 2020 at 07:49:12PM +0300, Dmitry Osipenko wrote:
>> Add devfreq support to the Tegra20 EMC driver. Memory utilization
>> statistics will be periodically polled from the memory controller and
>> appropriate minimum clock rate will be selected by the devfreq governor.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/memory/tegra/Kconfig       |  2 +
>>  drivers/memory/tegra/tegra20-emc.c | 92 ++++++++++++++++++++++++++++++
>>  2 files changed, 94 insertions(+)
>>
> 
> I see this one still received comments. I skipped the DTS patches and
> applied everything till patch #35. I understand you will send v8, so in
> such case please skip the applied ones (you can rebase on my for-next or
> on Monday's linux-next).

Thank you! I'll also need to wait for a reply from Viresh Kumar in other
thread regarding dev_pm_opp_get_opp_table() usage and then will probably
need to correct patch #35+ as well now, since turned out it may be wrong
for drivers to use dev_pm_opp_get_opp_table().
