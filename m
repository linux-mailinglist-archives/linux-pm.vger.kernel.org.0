Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 196411F100D
	for <lists+linux-pm@lfdr.de>; Sun,  7 Jun 2020 23:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgFGVsC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jun 2020 17:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgFGVsC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jun 2020 17:48:02 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00485C08C5C3;
        Sun,  7 Jun 2020 14:48:01 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 202so9020321lfe.5;
        Sun, 07 Jun 2020 14:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ay8EHASwjhU1bjGhoJPlUWvuPWuHbO/3W1nJ49RR5ag=;
        b=VXUjmROcDERX9tK85WWAf5vfiKHroxFpPZt28aMBYRGZJrksc/ZUrpeM9TsQMSJYhE
         DCITogpNAOT9Fc+Gi+ICLkihzUbwLylqKb/dcK0HtK1cI+ZK0ifujYEBYE3Zm5T0bI7/
         ndXyIvGU5qnUYWG7cgegvpLWugs08MGmrb1n9B+z4fvgrsP1ufvxgTT4i+A52SSOcCFI
         UJcJC7/316SDrGbaTqwo+5Zb5uvFbANULzWL3G0apNvUCEde3IQKRFBLhyodvRGYgU2t
         6PIVdLaYwdOjQR3mMPlA/+QkUOYQbs2wLgcTNhwK37jZoFCfK29uk5xOHFMGZwPwb5QA
         iZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ay8EHASwjhU1bjGhoJPlUWvuPWuHbO/3W1nJ49RR5ag=;
        b=W5rz3G/l5OYYyFZydriQ8JL9p7Bxh0TUT3GxldvWjcl7/+VlUjBNRAaCef2K/PdnMj
         /p/QIfZmvF3f/jKTOYL1FkOqZMb3g+HLsCjkO/3I8p4le/Kr8i7nRpVKLPks4OtS14mt
         W6AgT3PRV8nVpshjP9vW9pJPlhvTQ1dnCynXwIanjHn88yJC5JXHU7QoANi9CFW0TgVK
         XggJMZ/r7UgDvVQu8/uh538KdPeKS3iZUs0Z1wBU5B04JhHZVbtDTdRDmCrbgf/dYoty
         fpb6A/2rVY1QDf4zfp0M3XptUMXqeMtdnQ+YamUd6lI4F/zgMq7YGXUAJq+oV98ZXuIo
         8nvw==
X-Gm-Message-State: AOAM530l71D3tvMr+lUMOePkVo5latDLWtTxxX/neRMzZH9bP3dPormY
        UZdRq65B4VHn6GU1w3kXgCtQx/uA
X-Google-Smtp-Source: ABdhPJz+DegAGZHDYRJIlKVV0XxJ0lW/Q/FEgvkvROG5VVEspAJPGPKSKwJCvEcs43RZ2CG7mC0kdQ==
X-Received: by 2002:a05:6512:3b6:: with SMTP id v22mr10767583lfp.97.1591566479992;
        Sun, 07 Jun 2020 14:47:59 -0700 (PDT)
Received: from [192.168.2.145] (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.googlemail.com with ESMTPSA id u30sm3325110ljd.94.2020.06.07.14.47.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jun 2020 14:47:59 -0700 (PDT)
Subject: Re: [PATCH v3 31/39] memory: tegra20-emc: Register as interconnect
 provider
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>
Cc:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
References: <20200607185530.18113-1-digetx@gmail.com>
 <20200607185530.18113-32-digetx@gmail.com>
Message-ID: <89b690be-d2fa-a679-5773-d5906a93ffcc@gmail.com>
Date:   Mon, 8 Jun 2020 00:47:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200607185530.18113-32-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

07.06.2020 21:55, Dmitry Osipenko пишет:
...
> +	if (IS_ENABLED(CONFIG_INTERCONNECT)) {
> +		err = tegra_emc_interconnect_init(emc);
> +		if (err)
> +			dev_err(&pdev->dev, "failed to initialize ICC: %d\n",
> +				err);
> +	}

It just occurred to me that I completely forgot to remove the
IS_ENABLED() and change Kconfig to properly set up the build dependency
on interconnect. Will correct it in v4.
