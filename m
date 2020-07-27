Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D2C22E784
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jul 2020 10:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgG0IQc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 04:16:32 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:44800 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgG0IQc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2020 04:16:32 -0400
Received: by mail-ej1-f68.google.com with SMTP id dk23so4254364ejb.11;
        Mon, 27 Jul 2020 01:16:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n3jdmOkHH0lbhCLzvawvL3InWL+XoWfff14e53Xl8tc=;
        b=qWrypVk18OTWvuD9Lb915wB+MvOb6xEuslZ8gYiQwGhDTzi1LFKL6/r1PnGrELjc9u
         41Vzm70dus8LwNnduSo1Th60cciZ1zt5wtXz48GM/t8ufkmakHG5FqMZF6Scvj7ImgAd
         62ijQGYkDanix259KBm0bvcerl/ri0NAsTvq2fx0sR+BGGc1PPJE8kU3gfQ8uaR4+PL4
         3D+I/Ye5xBfuVOh4s701Uzg9aykGzyzJU6fpuk0vjGrnNCPZpXbbTVIn0sZ3tpKpDl6U
         I0E4lC8NqhYNTa61jKubR8fYs5IO7OrK8p4iJqFeRZkV85aV8+ZrlbJbM88T5eq+a2i+
         2I8Q==
X-Gm-Message-State: AOAM530Ff/ZeK9ETKEmeX8kPh/W30M5cp6mJya5bqqcXuMVMGn2dv0au
        YwlBiL7cVIeBmdKy50M8TZ4=
X-Google-Smtp-Source: ABdhPJxl1bXXksJmlVSeWBENKyDL1pcQ8+YYyCSgGGJorZ8Fwu2aO3FJiSvFUYamCQ41zp1lTmDY0A==
X-Received: by 2002:a17:907:20e6:: with SMTP id rh6mr1554368ejb.301.1595837790175;
        Mon, 27 Jul 2020 01:16:30 -0700 (PDT)
Received: from kozik-lap ([194.230.155.213])
        by smtp.googlemail.com with ESMTPSA id q19sm5322558ejo.93.2020.07.27.01.16.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Jul 2020 01:16:29 -0700 (PDT)
Date:   Mon, 27 Jul 2020 10:16:26 +0200
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
Subject: Re: [PATCH 03/16] memory: mvebu-devbus: Align with open parenthesis
Message-ID: <20200727081626.GG17644@kozik-lap>
References: <20200724182328.3348-1-krzk@kernel.org>
 <20200724182328.3348-4-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200724182328.3348-4-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 24, 2020 at 08:23:15PM +0200, Krzysztof Kozlowski wrote:
> The line continuation contained spaces but still failed to properly
> align with open parenthesis.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/memory/mvebu-devbus.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Applied to drivers/memory tree.

Best regards,
Krzysztof
