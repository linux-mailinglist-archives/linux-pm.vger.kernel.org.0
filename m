Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0518F3CC4D0
	for <lists+linux-pm@lfdr.de>; Sat, 17 Jul 2021 19:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbhGQRcc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 17 Jul 2021 13:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbhGQRcc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 17 Jul 2021 13:32:32 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A41C061762;
        Sat, 17 Jul 2021 10:29:35 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id f30so21512081lfj.1;
        Sat, 17 Jul 2021 10:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N5z7xrInHmNrXI9aN34rhAl4c3ECcOCnUV9aOKCVrIg=;
        b=YWLHiL6JCxcbNMlOR6BFuGqIAblgPQHJosP23FUYarmDwJVc3NtsUY5qKPgzO8bKB8
         6SLc5MBTx3GcPB1B+0J1SzFDs7UMnvonHgQOfA1vygxaaUHp6pHb5Vhf0Hx1NObWPpAs
         KpkZ4sY/oJdP+yl3gyZ/Pa2iG9IhjXgQPKTzc19+h5T3FhgW92Ayphy8kk8JpkN0OSJU
         jTyyOFJQOyANGhxkFcclOy/27rD/89EVnFuSjYbcfhFZE2i6izbE8ReTDsdaT/G6773V
         Qf4F8IiNCumQM5V9/QiF5F6YmnNbd23fQmV8q8HY98HIr/hMTwq1SCvpuoVkPtIFPRxH
         pi4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N5z7xrInHmNrXI9aN34rhAl4c3ECcOCnUV9aOKCVrIg=;
        b=RNiy93nqjUOqnP0gLGsZQwiTeu+V42WmpLZCSACTsSdtubfj2BASEtocEPmdMPnU+e
         Nw1wp1AA0na1qF+MsE3uRqx4JqFfMAbCmSDkOxN07xvMb/xsK/Ny5u2uAetQQstWByTV
         nAuymiMZ6b+JY37YRSwJhg2tYZrhvELJOSNmMBh+iGBHqdpp/V5f22ipO+GkWtbUwA26
         TWG3zg9B7iLfOCOgA5Hog2+4zu06PgnDs4MeYQRIMNYHbFA87dWh00Hx0f6dltnjmt8/
         0VkcwyXphqdzWRcYGIUY4LHXl82V8037Q/4P/YCmIfZoPNr0JCnS2sFACXjMicxTzOFg
         51tA==
X-Gm-Message-State: AOAM530cb5i1LgJOeROkkqsXgPKAq16aaiw1TnadSZrmF0J1c60xjCuP
        Yi8tOChUQ6Tu5tHbkxUL8uezoUkzyc0=
X-Google-Smtp-Source: ABdhPJwBfAn5E2GJO9yPk4k/vB8xdiHsfYG9R/Bcgjxu8CLZu25n9DKLoYHljQE9Bz12qdbtFS/pAw==
X-Received: by 2002:ac2:52ac:: with SMTP id r12mr11713196lfm.364.1626542973425;
        Sat, 17 Jul 2021 10:29:33 -0700 (PDT)
Received: from [192.168.2.145] (46-138-17-250.dynamic.spd-mgts.ru. [46.138.17.250])
        by smtp.googlemail.com with ESMTPSA id o11sm1385871ljg.29.2021.07.17.10.29.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jul 2021 10:29:33 -0700 (PDT)
Subject: Re: [PATCH v4 08/12] power: supply: smb347-charger: Remove caching of
 charger state
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        David Heidelberg <david@ixit.cz>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20210717121112.3248-1-digetx@gmail.com>
 <20210717121112.3248-9-digetx@gmail.com>
 <20210717162006.66cqkbw2mertd6tr@earth.universe>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0df9fbf5-26fa-5d35-46d6-5c36567d6ed2@gmail.com>
Date:   Sat, 17 Jul 2021 20:29:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210717162006.66cqkbw2mertd6tr@earth.universe>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

17.07.2021 19:20, Sebastian Reichel пишет:
> Hi,
> 
> On Sat, Jul 17, 2021 at 03:11:08PM +0300, Dmitry Osipenko wrote:
>> Regmap already provides us with the caching, so remove caching of charger
>> state to make code cleaner.
> 
> cache_type is not initialized in smb347's regmap config and thus
> set to 0 = REGCACHE_NONE:
> 
> static const struct regmap_config smb347_regmap = {
> 	.reg_bits	= 8,
> 	.val_bits	= 8,
> 	.max_register	= SMB347_MAX_REGISTER,
> 	.volatile_reg	= smb347_volatile_reg,
> 	.readable_reg	= smb347_readable_reg,
> };

Good catch, thank you. I'll add patch to enable caching.
