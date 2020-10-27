Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE60E29C8AF
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 20:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1829858AbgJ0TW0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 15:22:26 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38023 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1829830AbgJ0TWY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 15:22:24 -0400
Received: by mail-lj1-f193.google.com with SMTP id m20so3088185ljj.5;
        Tue, 27 Oct 2020 12:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0LPNweG+gfW0E+7Iib5GUjlD2JP5EWxruAvLHtaU8XE=;
        b=aSkqnm7gx7xKIhmazlcPViUAMX7Tp2uHkbyBVUdCFkMxeMIdX2Xi9DW0855SI7bMdv
         tt3tR49WUXa/WWNOl4DlYA2JKR7vFmksRbGmg2jV+mgwfSwCbadlTlsOLBppruycITi+
         w/f3rCWA79Y1t0HlgyIgmO8rYYe3U4b7weHWVvqF4IGkLGVoHUJ6eWTPmeGG/2KRAbBH
         buCK0HYDr4Hks/1ccaSZLA28nFhWBDswpv7UohY7LK8b5pZ1eSSDBs31G6e+JpGJ9Snf
         m51ztOLcJsIfX8SexWXZxkrhoV0FehIPopeR7Jttn8qdjCi+XaVcvjBJR9Ht1d/7wscE
         0skQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0LPNweG+gfW0E+7Iib5GUjlD2JP5EWxruAvLHtaU8XE=;
        b=ET06IVWTLLt81Xf4eQov47e6jj6kHAO+gDYOnQLzniR3ZB3/tY0jgxNpo30QyPUCcg
         2urWJG+ObLCyTTj1+kszxmEgOMT/pjZ2ta3Zn2R5LBCibBWdEq/m0O1TGfPGmFJyBdvF
         Sx6QOxIthvBP2vwmsUmKpV922NQAec1j8f6mjJ7R6JD6EbsuIhLoU48Qv3VPrjYFhxsI
         UspJZEKcUpDZtSEioBtR9wqfMHCzX0JF+VIjFO/plDUPAd3slVRZzipQzOZIpdcoXuVv
         6LA7go6B5tuA2lw5gZkdUp70HPIz6kJYYTU9yt3zyxHz9sEfoFGSXdOPjvORfj/bHOq/
         S+2w==
X-Gm-Message-State: AOAM532FZpIqvtGc1FAkBC7XlaVI3ujHRLPgSl9kIJ9tl8+H9sJhMdzt
        3A0V27RIl9yCIp0GT4ZvVh4NEbprmC0=
X-Google-Smtp-Source: ABdhPJwzYHdGLKWirtJJS8W/Sx8MXsyFr0CXQVIbEPKIdICpwTjspH3wnE4roG7cjpHTIAuDhoBLnw==
X-Received: by 2002:a2e:87c6:: with SMTP id v6mr1808964ljj.233.1603826541677;
        Tue, 27 Oct 2020 12:22:21 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.googlemail.com with ESMTPSA id m14sm285483ljo.76.2020.10.27.12.22.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 12:22:21 -0700 (PDT)
Subject: Re: [PATCH v6 08/52] dt-bindings: memory: tegra20: emc: Document
 mfd-simple compatible and statistics sub-device
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
 <20201025221735.3062-9-digetx@gmail.com> <20201027090212.GG4244@kozik-lap>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <1cce314a-1eab-61c9-099d-54f987b03761@gmail.com>
Date:   Tue, 27 Oct 2020 22:22:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201027090212.GG4244@kozik-lap>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

27.10.2020 12:02, Krzysztof Kozlowski пишет:
>> @@ -31,17 +32,34 @@ Example:
>>  		...
>>  	};
>>  
>> +	emc_bw_dfs_opp_table: emc_opp_table1 {
> Hyphens for node name.

We already use underscores for the Tegra CPU OPP table.

https://elixir.bootlin.com/linux/v5.10-rc1/source/arch/arm/boot/dts/tegra20-cpu-opp.dtsi#L4

What makes you think that hyphens will be a better choice? Is it a
documented naming convention?
