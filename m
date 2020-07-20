Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2098226273
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jul 2020 16:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbgGTOqy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jul 2020 10:46:54 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52868 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgGTOqy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jul 2020 10:46:54 -0400
Received: by mail-wm1-f67.google.com with SMTP id q15so22548154wmj.2;
        Mon, 20 Jul 2020 07:46:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ubVyQHHqX9tsUnzOm6TherEnABXQb1+jkvMZGf23FqQ=;
        b=fbKLGkdJBN8xsSgQJ0rAPYLt1BfB3KcZLc/NmTePmAc2isBnZp8l8/YAZWJb+RzhnY
         zsgLn3pey9+7pX5AzbOI/l03D72AEybJ1ERbQn7lHbPmfJUnP0nOvfLT719SAybMU6G+
         jx7tGKyjOPQVH0zsznNRbmXSvzNk1fcAzC9S3h58tfTUqNQXZ33aOxaAVqLu5+k4gWCO
         c0yq5Der4VJPPj8Z2GXl+ONcMsWFYB2dnmm+ef3NSKLcFrIvTMyfOqzvd+fl/ksT93AL
         xK1ZkRF0C+xRMoK7oLonYdN8XxIJY4KOtuOlWVZs4WNbabmYjd2oaCOnm+CcHWlZswcg
         kr8g==
X-Gm-Message-State: AOAM5338LUhHNMjfokNkSCv6BHKxFCJd2lmJrR0oYdZYdsIVDiC0LgxS
        L3OgtmXMXs0KvOMIbzKVJaQ=
X-Google-Smtp-Source: ABdhPJxAXaavtFIv3qPHXSFItxh2VKDy2GsLwn30QnRX2MpjxZJmt4Nr+m2qFL5Y9Z28WTEfIvtYIQ==
X-Received: by 2002:a1c:7d85:: with SMTP id y127mr22660355wmc.181.1595256412049;
        Mon, 20 Jul 2020 07:46:52 -0700 (PDT)
Received: from kozik-lap ([194.230.155.200])
        by smtp.googlemail.com with ESMTPSA id f17sm35900335wme.14.2020.07.20.07.46.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Jul 2020 07:46:51 -0700 (PDT)
Date:   Mon, 20 Jul 2020 16:46:48 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, willy.mh.wolff.ml@gmail.com,
        k.konieczny@samsung.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        s.nawrocki@samsung.com, kgene@kernel.org
Subject: Re: [PATCH v2 2/2] memory: samsung: exynos5422-dmc: Add module param
 to control IRQ mode
Message-ID: <20200720144648.GC22791@kozik-lap>
References: <20200710191122.11029-1-lukasz.luba@arm.com>
 <20200710191122.11029-3-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200710191122.11029-3-lukasz.luba@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 10, 2020 at 08:11:22PM +0100, Lukasz Luba wrote:
> The driver can operate in two modes relaying on devfreq monitoring
> mechanism which periodically checks the device status or it can use
> interrupts when they are provided by loaded Device Tree. The newly
> introduced module parameter can be used to choose between devfreq
> monitoring and internal interrupts without modifying the Device Tree.
> It also sets devfreq monitoring as default when the parameter is not set
> (also the case for default when the driver is not built as a module).
> 
> Reported-by: Willy Wolff <willy.mh.wolff.ml@gmail.com>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/memory/samsung/exynos5422-dmc.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
