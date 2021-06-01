Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED941396C5D
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jun 2021 06:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbhFAEeF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Jun 2021 00:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhFAEeE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Jun 2021 00:34:04 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CDAC061574;
        Mon, 31 May 2021 21:32:22 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id i10so7649918lfj.2;
        Mon, 31 May 2021 21:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8fLKhrUqwIxQ2xXGCIpsy1nQkq4X8BC2dI8dF7Ysll4=;
        b=U9OHcCu4V/wDY1tsGXV2eshRLrjRfPice5eoIjlRPyQ1MCuMgW0y6imnF6TZ+1nvSr
         lkpoVD8uNcNSQfKLY9zPs+yuGoRuKax65LSSwF0dsHbk167AAj6H+9He+dcLSbZnPZ3u
         mGR0gTS7a8X9jSlJWbWmMtZJVGWLSUdkYegAmiGb1dzsBvqNXzyY3SquYuVBe35/Te42
         T/QxVpQPwLz6Iww+ko+SM1L+bBP1cJMy03ZWqBVAr7QCW9dmb2ooIbXGhhpprZYrqCqq
         85U5Dfw/uzeLxbQFwOeZs/8JPQSgpqG40aI817t9p3yZM7zQvxAObf4M7UX7XrKDXHZR
         9nBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8fLKhrUqwIxQ2xXGCIpsy1nQkq4X8BC2dI8dF7Ysll4=;
        b=QqK3d2pZKBd0XiyeRLl7QjQYbOwQPTNR/NggrXbgypXsEhWwBw83VB8rVNvQDPwjoc
         ZSapAjmX8tBvIyDO9ZQjkqbqRlzt6x/vhYNqcF6NHwiz1FLJ8RkJHgLdA7AnvIG7vqGp
         R1QxbsK98vnRt7eLxNvi5p2QFE21cmiZshV9hLcEkF0ztt0BuWDNzG2/oRXJDLJUybUM
         xYPu8BDUpOeBil3Wy1WMpJbnYbjdpSn1lmiszB3bjW5vcWQ4dil5sMX5XHU2aQz8QRvq
         Fih44GzTA4nl/9kdNlAL9hP/m7sl2C7YZt2YxbpU/rDpugX10i3ymPnR/YgPwWA3Vgda
         zZrw==
X-Gm-Message-State: AOAM532j0byPs3ksOXO/krrU/IFaTKBjWhDuVYa+Es55xddPZQ11sXcl
        1rqbAPIjgIBQvpAovHGgQZMJn5SqIvo=
X-Google-Smtp-Source: ABdhPJyZOoyMjsAEgJ5QqpWftZq0zpRUdysZh/BbpsknOcK9B1P0zg1rXr1TwghT/iHKyC0PpYI6ZA==
X-Received: by 2002:a05:6512:1194:: with SMTP id g20mr17786786lfr.407.1622521940654;
        Mon, 31 May 2021 21:32:20 -0700 (PDT)
Received: from [192.168.2.145] (79-139-170-222.dynamic.spd-mgts.ru. [79.139.170.222])
        by smtp.googlemail.com with ESMTPSA id x26sm1863322ljj.46.2021.05.31.21.32.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 21:32:20 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] dt-bindings: devfreq: tegra30-actmon: Add
 cooling-cells
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
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
 <20210601022319.17938-3-digetx@gmail.com>
Message-ID: <bda7233e-a9e0-7a3d-f6b5-084a49d705ed@gmail.com>
Date:   Tue, 1 Jun 2021 07:32:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210601022319.17938-3-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

01.06.2021 05:23, Dmitry Osipenko пишет:
> The ACTMON watches activity of memory clients. Decisions about a minimum
> required frequency are made based on the info from ACTMON. We can use
> ACTMON as a thermal cooling device by limiting the required frequency.
> Document new cooling-cells property of NVIDIA Tegra ACTMON hardware unit.
> 
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---

I missed to add Rob's r-b to this patch that he gave to v1:

Reviewed-by: Rob Herring <robh@kernel.org>
