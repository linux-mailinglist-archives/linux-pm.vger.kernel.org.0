Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84A5A2C0548
	for <lists+linux-pm@lfdr.de>; Mon, 23 Nov 2020 13:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbgKWMOC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Nov 2020 07:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbgKWMOB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Nov 2020 07:14:01 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3498AC0613CF;
        Mon, 23 Nov 2020 04:14:01 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id r24so7264042lfm.8;
        Mon, 23 Nov 2020 04:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DjiKfHQ2jA3vM7VGaFaknOPs7Hmg3cHuudIyVF1TtFs=;
        b=CMfi6MciH6bpfSGoN1TGnqSBqrbvk/WZCOthEzuu9kuAVb40YeAebEnZp99bo2UFmd
         WXhO1JkJr6Ntj7U6OlHe0/8Ra8ZfP3TULXSL2Nhg53rfU58FNNnQH9q5ZVxbl6n3mzVl
         YrwKpxuF+/QVYrG/s2ZyNaM7PK6sVLn6o7uFmy+LriMggqgsEUpfq3u6QTa2JtXNZfbI
         w7Y25cmZaCGAV0Ea1Ok2CrOd0mZOIychroyvv0aluwM1tQpSGFYto3uAtlV5GmE28b/G
         q6L8xgGglgvoBt3wYGu7DtpdxIO1tycjMwR7H8f5OK/FQAZ25F/MMzYffMBMDem0Ccc3
         ud/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DjiKfHQ2jA3vM7VGaFaknOPs7Hmg3cHuudIyVF1TtFs=;
        b=VcVf8tVrevgjVgju0YoLDi75YiY2EKe/BFQbeLhBc6tqVQ9g9qgP8rp51nb8vgVjl1
         HneKy2G7ku4bxrKuLOToGr1FBgYhk12tN2g30YrZCwZKmm/+b6hHxUS9OngxmIXK4JW6
         SRsIHanoWfqdV/PcHVsnyw4PGSTYAV5zom7HDIlJmvwbxGpn8cXfW0+YDmMESLqe6Gss
         M2UHWMe27PR/tqxq7y2mR2FC1ueSiRotqnV0UO5qdJnzj8Kjb/lpcMg3AkZcmbaLb24T
         LiNy6zEK1Lri7O8Y+LpVRf3uPhIAftZw4LHfdovrqUsHi9AbeiQzDZqTSgNOXal74Lum
         5D+Q==
X-Gm-Message-State: AOAM530fM7DjkDa0rWiB5xqSp0FiwmMpb2B46fB+PvIsUtDqMGODuXYN
        2f8R5pU/teuzKUrD7Q+Mfcg=
X-Google-Smtp-Source: ABdhPJz3EId7FG3SbCnHwZXerIiqFBWY6qT1WhZ9hmI2Ye3Y0OmzOJDJsnE3s7GTG/1UUT7pazvjjQ==
X-Received: by 2002:ac2:5503:: with SMTP id j3mr14199009lfk.94.1606133639740;
        Mon, 23 Nov 2020 04:13:59 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.googlemail.com with ESMTPSA id w15sm1366488lfn.297.2020.11.23.04.13.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2020 04:13:59 -0800 (PST)
Subject: Re: [PATCH v10 00/19] Introduce memory interconnect for NVIDIA Tegra
 SoCs
To:     Viresh Kumar <viresh.kumar@linaro.org>
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
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20201123002723.28463-1-digetx@gmail.com>
 <20201123061734.mpmkdxzullrh52o7@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <1bfbeb36-29b3-30c2-899f-faa5b0682bd7@gmail.com>
Date:   Mon, 23 Nov 2020 15:13:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201123061734.mpmkdxzullrh52o7@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

23.11.2020 09:17, Viresh Kumar пишет:
> On 23-11-20, 03:27, Dmitry Osipenko wrote:
>> This series brings initial support for memory interconnect to Tegra20,
>> Tegra30 and Tegra124 SoCs.
>>
>> For the starter only display controllers and devfreq devices are getting
>> interconnect API support, others could be supported later on. The display
>> controllers have the biggest demand for interconnect API right now because
>> dynamic memory frequency scaling can't be done safely without taking into
>> account bandwidth requirement from the displays. In particular this series
>> fixes distorted display output on T30 Ouya and T124 TK1 devices.
>>
>> Changelog:
>>
>> v10 - In a longer run it will be much nicer if we could support EMC
>>       hardware versioning on Tegra20 and it's not late to support it now.
>>       Hence I added these new patches:
>>
>>         dt-bindings: memory: tegra20: emc: Document opp-supported-hw property
>>         memory: tegra20: Support hardware versioning and clean up OPP table initialization
>>
>>     - Removed error message from tegra30-devfreq driver about missing OPP
>>       properties in a device-tree because EMC driver already prints that
>>       message and it uses OPP API error code instead of checking DT directly,
>>       which is a more correct way of doing that.
> 
> Looks good to me (from OPP APIs usage perspective). Thanks for
> continuing with this and fixing all the issues Dmitry.
> 

Hello Viresh,

Thank you for all the clarifications and for reviewing of the patches!
