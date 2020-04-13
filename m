Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951DD1A6869
	for <lists+linux-pm@lfdr.de>; Mon, 13 Apr 2020 17:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbgDMPBN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Apr 2020 11:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728537AbgDMPBM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Apr 2020 11:01:12 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87E7C0A3BDC;
        Mon, 13 Apr 2020 08:01:10 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 131so6737128lfh.11;
        Mon, 13 Apr 2020 08:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ru0QSPI9P9UnB6fBmE8CYo+keKBVUlIYNIIDkobQ4LQ=;
        b=Y6rUG6M+j0aiSfmg6JaVatWMejLQsTEbkp+Py4z65rU+aUir3yH4IntWg02ep3JdhB
         Usx5lvplfJa0s5cxCQggtxc7W1wuy/8j1mK4AZtTraerenGI/fqV/T+OEco9I8hWTw3G
         H5eZJiTMnm9GprAVPGhUU7X7wHFEgQoqJDxH1gSMg4mpw4wjthr9obdVLEixRldPLNnf
         XW/AIcU3Kw0c7BABMeRaSSqzB//NmqUeCTH+hoMqFLxXYzFcNL0yf5+hERb3K+Zb1/T1
         oO1zLQ4iHnn+63mj5PtkZjuKKVjSrvSA7ffFDGrGQdVV2vvFVpai2yo/VXtWCSj+XtIx
         wcvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ru0QSPI9P9UnB6fBmE8CYo+keKBVUlIYNIIDkobQ4LQ=;
        b=lN9GcXayvEg4PNXmLwRpfz7PMMOlj9k/o9d7FZaSSKOQh2/0nX5u3CHAbt+BBeJd4H
         48CXHLJIO+JbzmffdCyLPxlajiDFgUDEFqnrBk5XGNRElNNVb3WKd5P0SKIEW7tknFcK
         XMIHnvM1XKq1bn7CU/q3EJH2HDakyqNOUh/ZhN7ZccI7KDKkwGJcDlj/AbeIFY3S+h5q
         0QKuqo7rN2BlQzCJut17hmoG0UiuVNc0UG52IfK23uEg7fvdN0M4AGvGaczPikOw8dpS
         NYfaY9AuG9UzYW6HxcQ2Tf8CjyzIXW45sDY+egt8VUIZp6uQrFOHNNXlD6UVoNAmyWoQ
         YJTQ==
X-Gm-Message-State: AGi0PuYGN9StUygYG2BWk0Mgtl7qwlKUA2sulFLnjJWLI7/QTeZseVbS
        JBxP2T3eSS7vRD4jBYFFthhbafIU
X-Google-Smtp-Source: APiQypJuMbGzqumA19vjCipPNUMuK6knNtWelRmhSmQ7RHP5iQyyKfnbir6+7o6qjvFvRW6ssE2yTw==
X-Received: by 2002:a19:ee06:: with SMTP id g6mr9366702lfb.90.1586790069000;
        Mon, 13 Apr 2020 08:01:09 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id b28sm8190875lfo.46.2020.04.13.08.01.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2020 08:01:08 -0700 (PDT)
Subject: Re: [PATCH v2 11/22] memory: tegra: Register as interconnect provider
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
References: <20200330010904.27643-1-digetx@gmail.com>
 <20200330010904.27643-12-digetx@gmail.com>
 <70f724d6-5cb2-0ebe-ffc1-5dbb77d9dc74@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <8d8dd1aa-71b3-e090-5637-578e23150bf1@gmail.com>
Date:   Mon, 13 Apr 2020 18:01:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <70f724d6-5cb2-0ebe-ffc1-5dbb77d9dc74@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Georgi,

13.04.2020 15:43, Georgi Djakov пишет:
...
>> +	if (IS_ENABLED(CONFIG_INTERCONNECT)) {
> 
> The interconnect framework can be also a module and the then the build will fail.

That's a good catch!

>> +		err = tegra_mc_interconnect_setup(mc);
> 
> Maybe register the interconnect provider as a platform sub-device instead?

The sub-device sound like a bit too much of hassle. I'm curious whether
we could try to make all the tegra-memory drivers modular, please let me
try..
