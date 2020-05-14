Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308EC1D3920
	for <lists+linux-pm@lfdr.de>; Thu, 14 May 2020 20:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgENSb4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 May 2020 14:31:56 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38556 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgENSb4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 May 2020 14:31:56 -0400
Received: by mail-oi1-f196.google.com with SMTP id j145so3583990oib.5;
        Thu, 14 May 2020 11:31:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/ZdOo8qTYydr7gpNlz9VEjrBle34EZ628Ie0y7qEL/0=;
        b=ranJhHybyWIi9UvAbpb0MyY6TkhPGXR9JnqhNpFy5UYpe/JfZhv/3cRnFOe4cwiiuq
         uyhIdQ1yPFzkOyInXsWU2/Zv0axUpMtGMbRiMYBuSddcYtLpwAbZ5mDkq4m6CU0gK16t
         PZTRwJGdlofBFYwRChqM6brx9Rt2b0G5lv0B5CmQSWZYIP3WyANIhAWgDS0+sGNvD3qa
         2tPBMr8LvkEjyRplMGWObSr6JS4AOE7uEy7T57dCSAua1Qn6rTLopW8sOFZVGoMJrCLq
         /ezN1k+ZHr9rrI/Zmol/qHkUJEoZ3i5EDbJG5FtuSchZ1QlAI4xTgICKikvSMMIwWt0V
         98eA==
X-Gm-Message-State: AGi0PuYSbvU7PUZRQwwZ10SSQhVNyGzkcbgh3EANXOgTLV6ETwZc1M9h
        SX08VAelHguj8+OGvfrXaw==
X-Google-Smtp-Source: APiQypJb/IrkasWWL0KzBECbQGQmU9ovfrPx2nw3JgBo31OcpHjNbpKZH/E7kal8pID5YeWdCQI4Hg==
X-Received: by 2002:aca:fd12:: with SMTP id b18mr32276044oii.158.1589481112173;
        Thu, 14 May 2020 11:31:52 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h24sm978584otj.25.2020.05.14.11.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 11:31:51 -0700 (PDT)
Received: (nullmailer pid 24946 invoked by uid 1000);
        Thu, 14 May 2020 18:31:50 -0000
Date:   Thu, 14 May 2020 13:31:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sergey.Semin@baikalelectronics.ru
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linux-pm@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Brown <broonie@kernel.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Rob Herring <robh+dt@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 03/20] dt-bindings: Add vendor prefix for Baikal
 Electronics, JSC
Message-ID: <20200514183150.GA24713@bogus>
References: <20200306124807.3596F80307C2@mail.baikalelectronics.ru>
 <20200506174238.15385-1-Sergey.Semin@baikalelectronics.ru>
 <20200506174238.15385-4-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506174238.15385-4-Sergey.Semin@baikalelectronics.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 6 May 2020 20:42:21 +0300,  wrote:
> From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> Add "BAIKAL ELECTRONICS, JSC" to the list of devicetree vendor prefixes
> as "baikal".
> 
> Website: http://www.baikalelectronics.com
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
> - Fix author and SoB emails mismatch.
> - Add 'baikal' vendor prefix instead of ambiguous 'be'.
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!
