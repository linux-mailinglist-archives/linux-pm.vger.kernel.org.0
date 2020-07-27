Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61AB322E74D
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jul 2020 10:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgG0IJm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 04:09:42 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:37909 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgG0IJm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2020 04:09:42 -0400
Received: by mail-ej1-f68.google.com with SMTP id d6so2281879ejr.5;
        Mon, 27 Jul 2020 01:09:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hn+/3qdqwXFJhSql/Yt47neY41jShafA6ZLzg2P0F1w=;
        b=NeVB0SfEdTUrjvQxj9Tl8w78zbufon9YtRvYGwkw2BgP8XhsmO6mQcadcohYUcIoKa
         nKwzLgB6YubsAi6KKujnvv5QGf8GuqInszHfc9CfC7SP8vWCklBdJoCWiqwBXo9DSETK
         prwgQ9NX5Jf19MSNrhp5XPmjLn7yhkR6hcWPoBnB8TAVrBnU0cqpkT5X4+FbYPXrOhEv
         Z7ZDQRAQBmf6jaIVUYE+CR5wZXyX5pAfHO2EF7K/nm49L6XaYt1/v1CWOePZ8ATIAfkz
         64Ugm6Z64cJBtuVWJBgoS3AQfYRVjnZl/Jt/vcGBUaid71PCQcpmGvktt2mlXXg7NPce
         MDzQ==
X-Gm-Message-State: AOAM531fxzfJisIVzWWw6xvRQM5C9sHOl7/JaVY/Z1kLpyyiHTSrlOgd
        PFiW5XPI2DYHLaX+cA8CsU8=
X-Google-Smtp-Source: ABdhPJyIJTaESfvZcbaunFv2A/3JKtetH4TCERAIu2FizT5ezau/ojIfjKF00fuqg/TyDefwx69fJw==
X-Received: by 2002:a17:906:430a:: with SMTP id j10mr19118690ejm.163.1595837379911;
        Mon, 27 Jul 2020 01:09:39 -0700 (PDT)
Received: from kozik-lap ([194.230.155.213])
        by smtp.googlemail.com with ESMTPSA id s2sm207492ejh.95.2020.07.27.01.09.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Jul 2020 01:09:39 -0700 (PDT)
Date:   Mon, 27 Jul 2020 10:09:36 +0200
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
Subject: Re: [PATCH 13/16] memory: of: Correct kerneldoc
Message-ID: <20200727080936.GB29255@kozik-lap>
References: <20200724182328.3348-1-krzk@kernel.org>
 <20200724182328.3348-14-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200724182328.3348-14-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 24, 2020 at 08:23:25PM +0200, Krzysztof Kozlowski wrote:
> Use proper kerneldoc to fix GCC warnings like:
> 
>    drivers/memory/of_memory.c:30: warning: Function parameter or member 'dev' not described in 'of_get_min_tck'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/memory/of_memory.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to drivers/memory tree.

Best regards,
Krzysztof
