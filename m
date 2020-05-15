Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE3F1D43EE
	for <lists+linux-pm@lfdr.de>; Fri, 15 May 2020 05:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgEODOx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 May 2020 23:14:53 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43085 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728026AbgEODOw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 May 2020 23:14:52 -0400
Received: by mail-ot1-f65.google.com with SMTP id a68so801164otb.10;
        Thu, 14 May 2020 20:14:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yqs+xgalcbPDKtO7SirxVH1GzYsqpYVsPCsYXuYSFg0=;
        b=owTAWSsDEjz4YhlNLD1Ny8JuodBv2FX+VARTSCklt64tarSIPpsXnP6L///nTrFRUH
         flf7nT3Vi8dDYHIQChAv47maSzcRCuudZC+dyuHA4l9ckjZnjuxAlWUyaGkp2OltrTsA
         tYfSbRGzVBjhze/MswPnN0Yfht0bCSiVhaSqS7oy3zFEg04hDjt10EFbFNzaccGOtfda
         Al7mP8D+Syn2B7YwICMQkjTxL0AZR2e60pD2rFvHqdhgyLuYl0vxIq3h+vbgANWz7nma
         UufoJ6w7KvULQq5Z8Pt/D9Ihr0yCU4n2INca1Dcqv8I0ve3BwE/XAbUBKzjnbplGeWVR
         5gKg==
X-Gm-Message-State: AOAM530DfC3Rp/xMDyoH/wyvOJtZizVitNDyFtad3OGZTvz0Gq1e/QgZ
        XwRtDixDJKdzrThxUmpJDg==
X-Google-Smtp-Source: ABdhPJwfXEmC9ltJAeX1EZtYduJdlosP1ejzhJQ0sxE6avvhSF7hIoTfhaRytn7FpFxvF04Z7YC4uw==
X-Received: by 2002:a9d:69c2:: with SMTP id v2mr747510oto.313.1589512491573;
        Thu, 14 May 2020 20:14:51 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t204sm301843oih.39.2020.05.14.20.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 20:14:50 -0700 (PDT)
Received: (nullmailer pid 32518 invoked by uid 1000);
        Fri, 15 May 2020 03:14:49 -0000
Date:   Thu, 14 May 2020 22:14:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@vger.kernel.org,
        Allison Randal <allison@lohutok.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Paul Burton <paulburton@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Subject: Re: [PATCH v2 2/3] dt-bindings: power: reset: Unrequire regmap
 property in syscon-reboot node
Message-ID: <20200515031449.GA32456@bogus>
References: <20200306130356.6ABDD8030703@mail.baikalelectronics.ru>
 <20200507233846.11548-1-Sergey.Semin@baikalelectronics.ru>
 <20200507233846.11548-3-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507233846.11548-3-Sergey.Semin@baikalelectronics.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 8 May 2020 02:38:45 +0300, Serge Semin wrote:
> Since normally syscon-reboot block is supposed to be a part of a system
> controller, lets mark the regmap property as deprecated and recommend the
> syscon-reboot node to be a sub-node of SYSCON.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Allison Randal <allison@lohutok.net>
> Cc: Richard Fontana <rfontana@redhat.com>
> Cc: Kate Stewart <kstewart@linuxfoundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-mips@vger.kernel.org
> 
> ---
> 
> Changelog v2:
> - This is a new patch created as a result of the discussion:
>   https://lore.kernel.org/linux-pm/20200306130402.1F4F0803079F@mail.baikalelectronics.ru/
> ---
>  .../bindings/power/reset/syscon-reboot.yaml       | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
