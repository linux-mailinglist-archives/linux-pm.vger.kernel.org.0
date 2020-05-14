Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 386AF1D38F2
	for <lists+linux-pm@lfdr.de>; Thu, 14 May 2020 20:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgENSNU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 May 2020 14:13:20 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:60590 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgENSNU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 May 2020 14:13:20 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 642128030791;
        Thu, 14 May 2020 18:13:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lEBMcDfl1RDh; Thu, 14 May 2020 21:13:12 +0300 (MSK)
Date:   Thu, 14 May 2020 21:13:11 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>, <linux-mips@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <mripard@kernel.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 03/20] dt-bindings: Add vendor prefix for Baikal
 Electronics, JSC
Message-ID: <20200514181311.anmxmujqg2wlqimp@mobilestation>
References: <20200306124807.3596F80307C2@mail.baikalelectronics.ru>
 <20200506174238.15385-1-Sergey.Semin@baikalelectronics.ru>
 <20200506174238.15385-4-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200506174238.15385-4-Sergey.Semin@baikalelectronics.ru>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Rob,

Could you also take a look at this patch? There are several patchsets I've sent
which depend on the vendor-prefix it defines. So when you get to check those
patchsets DT files, the dt_binding_check will fail without it. Is it possible
somehow to pick this patch up from here and apply it before checking those
Baikal-T1-specific binding files?

-Sergey

On Wed, May 06, 2020 at 08:42:21PM +0300, Sergey.Semin@baikalelectronics.ru wrote:
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
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index d3891386d671..674c0d07c0ad 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -139,6 +139,8 @@ patternProperties:
>      description: Azoteq (Pty) Ltd
>    "^azw,.*":
>      description: Shenzhen AZW Technology Co., Ltd.
> +  "^baikal,.*":
> +    description: BAIKAL ELECTRONICS, JSC
>    "^bananapi,.*":
>      description: BIPAI KEJI LIMITED
>    "^beacon,.*":
> -- 
> 2.25.1
> 
