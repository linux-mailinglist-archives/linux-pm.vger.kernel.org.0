Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57CAC33124C
	for <lists+linux-pm@lfdr.de>; Mon,  8 Mar 2021 16:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhCHPeF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Mar 2021 10:34:05 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:36833 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbhCHPdr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Mar 2021 10:33:47 -0500
Received: by mail-wr1-f49.google.com with SMTP id u14so11927585wri.3;
        Mon, 08 Mar 2021 07:33:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i+KaqBArGrcmWeeQo+LRChoEEGt1m5jdSKpkz2jdjGk=;
        b=I0hD+CtKW2J8DH5Fvn/d72BMUpaQV4VAJK/rP58nQfZ04s2auC7ZOKVQV8Q1Z2nKnO
         QH/SnjMx6yNORoftr3cSi9/6ZqVF8blDaND83PZfCQzzOUj5lHBBxL0WBesXrbjOlWij
         29S2EuOrAHEXHMpFwj0KzJzTXtNmJB8jA3LMVq7nmgXEnMsGB0BOJVtv8dzRVjZ3RqQV
         Z+sGl4y99jD6IHCb+YIULXHbvanO1oZwTWsSBUFRtR9gsPmzo4xgKdS1SiPQq/QT5uQ0
         FysAWSSC/Wx9U8h66+KyeUJD0z91Fr5YOH/912c0lHWGPVysTMml3s0A63Uj67x0UXfZ
         lAfA==
X-Gm-Message-State: AOAM532kEt6hH7kojM8qOfg6jiK5AMUa4+e4tJbWBaqgsI3gqaeaELaM
        jiq0y2TVZs9/dsq/5N7ttTE=
X-Google-Smtp-Source: ABdhPJxBQRqa0w3cM4cekeuH3vmdFevqhQo4oTYO/W4p1i1qbyBfANAdzeGt3ihm6F+3WVlyh3q6cg==
X-Received: by 2002:adf:e481:: with SMTP id i1mr8092291wrm.63.1615217626282;
        Mon, 08 Mar 2021 07:33:46 -0800 (PST)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id c11sm19177739wrs.28.2021.03.08.07.33.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Mar 2021 07:33:44 -0800 (PST)
Subject: Re: [PATCH] power: supply: max8997_charger: make EXTCON dependency
 unconditional
To:     Arnd Bergmann <arnd@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Timon Baetz <timon.baetz@protonmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>
References: <20210308152935.2263935-1-arnd@kernel.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Message-ID: <12c5050f-feb3-e07f-45d2-5e89b678841a@kernel.org>
Date:   Mon, 8 Mar 2021 16:33:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210308152935.2263935-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08/03/2021 16:29, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Some of the extcon interfaces have a fallback implementation that can
> be used when EXTCON is disabled, but some others do not, causing a
> build failure:
> 
> drivers/power/supply/max8997_charger.c:261:9: error: implicit declaration of function 'devm_extcon_register_notifier_all' [-Werror,-Wimplicit-function-declaration]
>                 ret = devm_extcon_register_notifier_all(&pdev->dev, charger->edev,
>                       ^
> drivers/power/supply/max8997_charger.c:261:9: note: did you mean 'devm_extcon_register_notifier'?
> include/linux/extcon.h:263:19: note: 'devm_extcon_register_notifier' declared here
> static inline int devm_extcon_register_notifier(struct device *dev,
> 
> I assume there is no reason to actually build this driver without extcon
> support, so a hard dependency is the easiest fix. Alternatively the
> header file could be extended to provide additional inline stubs.

Hi Arnd,

Thanks for the patch but I think I got it covered with:
https://lore.kernel.org/lkml/20210215100610.19911-2-cw00.choi@samsung.com/
(sent via extcon tree).

Did you experience a new/different issue?

Best regards,
Krzysztof
