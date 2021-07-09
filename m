Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF1B3C2AC3
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jul 2021 23:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbhGIV0M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Jul 2021 17:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhGIV0M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Jul 2021 17:26:12 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA756C0613DD;
        Fri,  9 Jul 2021 14:23:27 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id f13so25751501lfh.6;
        Fri, 09 Jul 2021 14:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PWHNe+wroGCz1bqp0ntY8AS6pyIwq0UPYVrtHIrr0Ew=;
        b=Emg0uj6Uun0WQAmNN78MQmeIzkJc8/AGgpM6FnHSxrXqFWpZjELiSLaOaw/IbDpkkF
         sITra89dp9y1X/k9CTX/hRp8WsKkNgF4J1pHELL7Av8jcxB1CzvUF9eKVYdUj+aIs4yD
         hoCd9ScANskmTh07mqRy5nDGbAZV5VeLGZpqiZvkpj+46zDzaZNajUdGIvS4f0iIC/d+
         ASuHCPpLE5VeNKaTXFAWbTX1u8R6RqoDeTW574Cxxu0aCT3OwSsa8AA1iorZpblxloJC
         zYpp1qFSt3jOTc6S8xqMAcQ3ABB9MX3C7vrQKZPshMBDbt09UFs3/bIzopAKTWLBJ/yV
         IKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PWHNe+wroGCz1bqp0ntY8AS6pyIwq0UPYVrtHIrr0Ew=;
        b=eX+TSs4BVW2jewiH+7ma4Zv8uD2RpqpqXdxAkVeWTEfh/LdUaPLpPOjcsN89wRe7kg
         2GJdgCZ0qGvJONqQD87lJhviSAtNt79wPXn2FLwWyHrjIuq2aCCS5kix5Anx1gC0xh/d
         D0pQ1O5IrzXyXz2LFAfaA2UQspqwSr5PURzRjBGOWWLv0yCkvn8eyMaCh/dk3EzmkUHX
         W6HskgVWw2FUyaM98PMXtKZnGZCg3paxCQexfbCNZoM6LTk1ueZBM+7B67GczwjfzhAh
         EJn43E8l9AXQaz33dwqSiIKYDdEUctvDCxHxGNMuaQ7XwRlP6tv4KmlLkwNsgq7MhNPa
         yyaA==
X-Gm-Message-State: AOAM531TW+daAnNvBNPOh4+mg4z0uAbxunjMkCUZ0R4d2H0TNGgmW5h+
        7VBtLUNKeA0vHVNU5ngrAU5XbH0FB8U=
X-Google-Smtp-Source: ABdhPJwmCPnwp7w/L/FBzdTVWhyxXo20bdcKFZi2jDaslJsE3sxiMxJjtIF6gitri1lOX2VTKL47xA==
X-Received: by 2002:a19:85c1:: with SMTP id h184mr30065718lfd.213.1625865805999;
        Fri, 09 Jul 2021 14:23:25 -0700 (PDT)
Received: from [192.168.2.145] (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.googlemail.com with ESMTPSA id 125sm550711lfm.173.2021.07.09.14.23.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jul 2021 14:23:25 -0700 (PDT)
Subject: Re: [PATCH v7 00/37] NVIDIA Tegra power management patches for 5.15
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
References: <20210701232728.23591-1-digetx@gmail.com>
 <CAPDyKFry00yzp9upsVy+yb7oX-k-bBgfrff+Q7qbK0cGh8ishQ@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <dfb1e52a-375b-ee13-e596-a1c3dc11e629@gmail.com>
Date:   Sat, 10 Jul 2021 00:23:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFry00yzp9upsVy+yb7oX-k-bBgfrff+Q7qbK0cGh8ishQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

09.07.2021 16:01, Ulf Hansson пишет:
...
> 
> Dmitry, I am happy to help to review this, but unfortunately(?) I am
> moving into holiday mode for a couple of weeks, very soon. I will do
> my best to move forward with the review, but please be patient.

Thank you for letting me know, have a good holidays!
