Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F4622626D
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jul 2020 16:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgGTOq3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jul 2020 10:46:29 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33343 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgGTOq3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jul 2020 10:46:29 -0400
Received: by mail-wr1-f67.google.com with SMTP id f18so18185562wrs.0;
        Mon, 20 Jul 2020 07:46:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IGLhuE1I9i7Yo8OigpC7QhgxIbZi2g1cVwzzK6Rb1Yo=;
        b=r3vqvgCfGmgLE2LhnLObe/jisRv5yWev5NMGIiJtc9m9dWohoMKE+iX4p9ajt1lyym
         o9z5fR6PMaIcY19LIXw8rxtK6qfgC9AcpaEB27aJQOYaaDuibrPVe0lsPZWXJwqIyNph
         UR7aaTKlRDgj+DQ7BMqOguRbl03ne2CW8GeXsEyFRLfHz+0bmY9UPZSCO9aiUwaeLulY
         /y6qxR0xvoV2fX1/rfqIEnBa+kpbZKaAuEtg/pqMJVBvosh2Icv4uoy1oSaIrUZGniSk
         I3InKIUef8GO7wWqGSzRhAOXrOQNCxg/QIoYO8Omu8pYyuXdFuSPfjKMDBjWjXzW8mqO
         wbNg==
X-Gm-Message-State: AOAM530CqstJDz6+laaONi/c1hpJacmIyWj+M5/o31hYQR8C69dDkUus
        /VH0qOZkteTD7JE5Kfbi9RE=
X-Google-Smtp-Source: ABdhPJwg2gFFhtn5o/2zvN0TVwn3vMzSIOrfZPa3ncwCkT5UBcBh/GBWgc1FaHrJBnY5aH63XjWGNg==
X-Received: by 2002:a5d:484b:: with SMTP id n11mr21603310wrs.320.1595256386888;
        Mon, 20 Jul 2020 07:46:26 -0700 (PDT)
Received: from kozik-lap ([194.230.155.200])
        by smtp.googlemail.com with ESMTPSA id x18sm33410979wrq.13.2020.07.20.07.46.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Jul 2020 07:46:26 -0700 (PDT)
Date:   Mon, 20 Jul 2020 16:46:23 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, willy.mh.wolff.ml@gmail.com,
        k.konieczny@samsung.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        s.nawrocki@samsung.com, kgene@kernel.org
Subject: Re: [PATCH v2 1/2] memory: samsung: exynos5422-dmc: Adjust polling
 interval and uptreshold
Message-ID: <20200720144623.GB22791@kozik-lap>
References: <20200710191122.11029-1-lukasz.luba@arm.com>
 <20200710191122.11029-2-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200710191122.11029-2-lukasz.luba@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 10, 2020 at 08:11:21PM +0100, Lukasz Luba wrote:
> In order to react faster and make better decisions under some workloads,
> benchmarking the memory subsystem behavior, adjust the polling interval
> and upthreshold value used by the simple_ondemand governor.
> 
> Reported-by: Willy Wolff <willy.mh.wolff.ml@gmail.com>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/memory/samsung/exynos5422-dmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Feel free to take it via devfreq tree.

Best regards,
Krzysztof
