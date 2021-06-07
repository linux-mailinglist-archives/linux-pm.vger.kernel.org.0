Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7535539DE42
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jun 2021 16:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhFGOEE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Jun 2021 10:04:04 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:33506 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbhFGOD4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Jun 2021 10:03:56 -0400
Received: by mail-lj1-f173.google.com with SMTP id o8so22415254ljp.0;
        Mon, 07 Jun 2021 07:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j/h58gR4t5OdekYQSFNWFSj/ytcD8nEYOcwTds5lTpM=;
        b=cZ7XwpDmaKUFyRGuU/gySPHGHuthR5dZLIB7M0erV4onywKe23DLtafLrWOETo7w7T
         hec5JQpo9owxIclFPifVIDu5njeS1SVs4jF/KMo8rQKYpmQLn+fZ/9aAZ8EKKtFPNW7H
         49F6BSpfSgBjMCBbl3KpmVCDfCM1TJKe4pC2Nk1/6WsjTHnKy7Gqzkv8XgHqnP5IBtZG
         GencLDReN0jxgqKJnkJB+cv/pT3NPJVv2orkahuGhqhga+9z/r5KBWuqA2P8n3VqXVTi
         MiwDtmfQdL4oAK20X0SqY/RmbPdbM9NkOAAjlxsXVM7dJjteoUxAo3fUGYWqUsUr3Pnb
         LN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j/h58gR4t5OdekYQSFNWFSj/ytcD8nEYOcwTds5lTpM=;
        b=EC4Oj2EPBsKKvvLuCE2kkpoconoDvp/CyjZnUxiTA5OslhSKQtgO1HdCcN6rlGq8Xw
         Jwr75EM3OR5w1/nB1hw5Tmghz5QQ963bhOZt9F2iUw1KszJvTGc360aN7ntPuWUDMDfY
         2Y3xhXcnkyzBqEkl6aAFnsMWw0fwOnZUDz1DZupwPf3nJydpUmwtPzMILG3/klCDQ5SA
         4e9FM7akhASUMT6ZmZOr/LJ5/SO8sGYWY4wc8s3X8R6CI85VX6QE4apkV3N4Gu26klPT
         DED/WeTv8Pb2u8tG2Z93nKSL7EGXTxXs0wEj2ta/fKj2prrAxsgeWPdUDO9VwaERO/66
         TfVw==
X-Gm-Message-State: AOAM530x/m9odo1NPGv0ZJHAk3wgTSJ2JRb8k3k8tBUVSdhHPtcabGZL
        4C2eQk2dhSnouuGEoHHMxg7Jwa1eA67Phg==
X-Google-Smtp-Source: ABdhPJwJPJlxEzcJy2V7HIsl9pZaKXUR1EHrfEc7wtr6r3yjIsl4WVm+fC5F1nStGJ5G324XD61png==
X-Received: by 2002:a2e:98b:: with SMTP id 133mr14370450ljj.88.1623074463327;
        Mon, 07 Jun 2021 07:01:03 -0700 (PDT)
Received: from [192.168.2.145] (94-29-21-60.dynamic.spd-mgts.ru. [94.29.21.60])
        by smtp.googlemail.com with ESMTPSA id u25sm1871572ljo.56.2021.06.07.07.01.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 07:01:02 -0700 (PDT)
Subject: Re: [PATCH v6 08/14] memory: tegra: Enable compile testing for all
 drivers
To:     Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        =?UTF-8?Q?Nikola_Milosavljevi=c4=87?= <mnidza@outlook.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Paul Fertser <fercerpav@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        linux-clk@vger.kernel.org
References: <20210601023119.22044-1-digetx@gmail.com>
 <20210601023119.22044-9-digetx@gmail.com>
 <41899ef4-bb16-6c3a-035c-1e840a993bec@canonical.com>
 <YL4gwxWopKT7LomG@orome.fritz.box>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a1f20257-f041-966e-c37e-5c81c4cf94d9@gmail.com>
Date:   Mon, 7 Jun 2021 17:01:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YL4gwxWopKT7LomG@orome.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

07.06.2021 16:36, Thierry Reding пишет:
>> /bin/ld: warning: orphan section `__reservedmem_of_table' from `drivers/memory/tegra/tegra210-emc-table.o' being placed in section `__reservedmem_of_table'
>> /bin/ld: drivers/memory/tegra/mc.o: in function `tegra_mc_probe':
>> mc.c:(.text+0x87a): undefined reference to `reset_controller_register'
>> make[1]: *** [/home/buildbot/worker/builddir/build/Makefile:1191: vmlinux] Error 1
...

> Not sure what to do about that orphaned __reservedmem_of_table section.
> Maybe all we need to do is to select OF_RESERVED_MEM from
> TEGRA210_EMC_TABLE?

Select won't work easily, but the dependency for TEGRA210_EMC should.
