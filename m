Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2F81D3499
	for <lists+linux-pm@lfdr.de>; Thu, 14 May 2020 17:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgENPJs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 May 2020 11:09:48 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39338 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbgENPJr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 May 2020 11:09:47 -0400
Received: by mail-ot1-f65.google.com with SMTP id q11so2599415oti.6;
        Thu, 14 May 2020 08:09:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tW8nu2beqUg3pvUiUBRWDjCZLdKTcmhuNvYMdwLUoFY=;
        b=rkmOHYTk+FiJWlYHLBVmjVQb6bmrKJFb+0NrkwgIP8qwIF2/uEoLJy3FdXiCySLTj5
         OT9Sw28/PHIw8tmEzVX2PMVEti4UOseVZwEp2qcgbq0Jb4IQFiqKLlkB8YTSCG8TStN5
         N5vSth6UKQVAEy5SzcZGT+363AvGLTC2fN6KAzHOIW8lFKStTRwLDsePlXK69NP0ItaP
         ZWlcCwStAHOpaW3/+5et2iNRaJKMlASZIvAwr0aZIoJKcPufA+YEzOK9G1ieM9T+y7kh
         F4eEA2TX89FDyypwpiyHmehIXzc7z0vh5gFPsxsMXyvASbpURY8DdSQg6ykizlLeCGJ3
         cGrQ==
X-Gm-Message-State: AOAM533xfD/oTv7wu9XsqlnnMCq4rCrF03ZexOEVT1tuBWSUvPMo0+Gn
        fjc/GnGySx9WA6NCgRS5dQ==
X-Google-Smtp-Source: ABdhPJzKs1tRGGs9nxYUL4m/XfjeSnfvEnglU/L87PjQG0UjFyQlL15ESiGbaZqXIxCMWcPvEsleow==
X-Received: by 2002:a9d:7d8a:: with SMTP id j10mr4047966otn.266.1589468985186;
        Thu, 14 May 2020 08:09:45 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 61sm843911otp.13.2020.05.14.08.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 08:09:44 -0700 (PDT)
Received: (nullmailer pid 30485 invoked by uid 1000);
        Thu, 14 May 2020 15:09:43 -0000
Date:   Thu, 14 May 2020 10:09:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sergey.Semin@baikalelectronics.ru
Cc:     Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, devicetree@vger.kernel.org,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH v2 02/20] dt-bindings: bus: Add MIPS CDMM controller
Message-ID: <20200514150943.GA30404@bogus>
References: <20200306124807.3596F80307C2@mail.baikalelectronics.ru>
 <20200506174238.15385-1-Sergey.Semin@baikalelectronics.ru>
 <20200506174238.15385-3-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506174238.15385-3-Sergey.Semin@baikalelectronics.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 6 May 2020 20:42:20 +0300,  wrote:
> From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> It's a Common Device Memory Map controller embedded into the MIPS IP
> cores, which dts node is supposed to have compatible and reg properties.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-mips@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> 
> ---
> 
> Changelog v2:
> - Lowercase the example hex'es.
> ---
>  .../bindings/bus/mti,mips-cdmm.yaml           | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/mti,mips-cdmm.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
