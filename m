Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6783022E787
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jul 2020 10:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgG0IQr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 04:16:47 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:37504 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgG0IQq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2020 04:16:46 -0400
Received: by mail-ej1-f68.google.com with SMTP id qc22so1332280ejb.4;
        Mon, 27 Jul 2020 01:16:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U8T1d9X+oqjbCBlTuQlLBot+OTye3Hv5uDuFmIyW0ik=;
        b=YkEzvR1+kpsZ9O+LzxukXaWAqKi1mJR/S6LQq3RkioKg2cGGLEY3AA+OamOnEelaV3
         f/f1ewzHTsAsPqc2Ypc/qXiLeLYRXOn6SatDUPnpyZ0VLy1P0FpIbwQTXpDe/KGfsnZb
         miyeZB6seStkDPtafUgqyEEDm4zgGnaVQbfYaxp0rVSaEazXhFNIBhPpCh20mTo4xDFb
         voBLPspNq2F5pLFbHlpNz1/2MW+Pr5N/cd8xa9BJDJgFyE8CTeGE3vIAb23MAlZIuw14
         8ct1qMQJpfa7Ol+lhLXFC3bkih0Qn41h1+80eO3wcVavxKosW8OfkGj6io8Gvo6dbGcp
         35nw==
X-Gm-Message-State: AOAM5318VT+ClBdIBC2E2iSy8DoNqeEmCt+K6/p/kNu+ALjD/QOctI5y
        9WumViKbcQEaSK7evWGjlv0=
X-Google-Smtp-Source: ABdhPJzv/Z1eKbNW1ILgP4IU+Q3CfajoxVNpn7krEps8RZkLiuqzoOlyV+yRb2ktrj6oabsBzLQ2/A==
X-Received: by 2002:a17:906:b6d0:: with SMTP id ec16mr471261ejb.94.1595837804677;
        Mon, 27 Jul 2020 01:16:44 -0700 (PDT)
Received: from kozik-lap ([194.230.155.213])
        by smtp.googlemail.com with ESMTPSA id w5sm2157241edi.74.2020.07.27.01.16.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Jul 2020 01:16:43 -0700 (PDT)
Date:   Mon, 27 Jul 2020 10:16:41 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Markus Mayer <mmayer@broadcom.com>,
        Roger Quadros <rogerq@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kukjin Kim <kgene@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 02/16] memory: mvebu-devbus: Add missing braces to all
 arms of if statement
Message-ID: <20200727081641.GH17644@kozik-lap>
References: <20200724182328.3348-1-krzk@kernel.org>
 <20200724182328.3348-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200724182328.3348-3-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 24, 2020 at 08:23:14PM +0200, Krzysztof Kozlowski wrote:
> Add missing braces to all arms of if statement to align with coding
> convention.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/memory/mvebu-devbus.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied to drivers/memory tree.

Best regards,
Krzysztof
