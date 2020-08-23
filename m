Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 901CB24EF3E
	for <lists+linux-pm@lfdr.de>; Sun, 23 Aug 2020 20:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgHWSUz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Aug 2020 14:20:55 -0400
Received: from mail.v3.sk ([167.172.186.51]:42628 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725867AbgHWSUz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 23 Aug 2020 14:20:55 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 3E642DF106;
        Sun, 23 Aug 2020 18:19:54 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id QOcGrmKfV6b9; Sun, 23 Aug 2020 18:19:53 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 954DCDFA6B;
        Sun, 23 Aug 2020 18:19:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ryvxz95CuVXD; Sun, 23 Aug 2020 18:19:53 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id ADC95DF106;
        Sun, 23 Aug 2020 18:19:52 +0000 (UTC)
Date:   Sun, 23 Aug 2020 20:20:50 +0200
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/6] dt-bindings: mfd: ene-kb3930: Add compatibles for
 KB930 and Acer A500
Message-ID: <20200823182050.GA210632@demiurge.local>
References: <20200823140846.19299-1-digetx@gmail.com>
 <20200823140846.19299-5-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200823140846.19299-5-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Aug 23, 2020 at 05:08:44PM +0300, Dmitry Osipenko wrote:
> The ENE KB930 hardware is compatible with KB3930.
> 
> Acer A500 Iconia Tab is Android tablet device, it has KB930 controller
> that is running firmware specifically customized for the needs of the
> Acer A500 hardware. This means that firmware interface isn't re-usable
> by other non-Acer devices. Some akin models of Acer tablets should be
> able to re-use the FW interface of A500 model, like A200 for example.
> 
> This patch adds the new compatibles to the binding.

I've responded to patch 5/6 with what should've been said here [1].
Sorry for the confusion.

In any case please consider adding a new binding file instead of
modifying the kb3930 binding doc. It would also remove a dependency on
my patch set which should have slipped out of maintainers' radar.

[1] https://lore.kernel.org/lkml/20200823180041.GB209852@demiurge.local/

Take care
Lubo

> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  Documentation/devicetree/bindings/mfd/ene-kb3930.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ene-kb3930.yaml b/Documentation/devicetree/bindings/mfd/ene-kb3930.yaml
> index 074243c40891..5a1c4a959d9c 100644
> --- a/Documentation/devicetree/bindings/mfd/ene-kb3930.yaml
> +++ b/Documentation/devicetree/bindings/mfd/ene-kb3930.yaml
> @@ -17,8 +17,11 @@ properties:
>    compatible:
>      items:
>        - enum:
> +        - acer,a500-iconia-ec # Acer A500 Iconia tablet device
>          - dell,wyse-ariel-ec  # Dell Wyse Ariel board (3020)
> -      - const: ene,kb3930
> +      - enum:
> +        - ene,kb3930
> +        - ene,kb930
>    reg:
>      maxItems: 1
>  
> -- 
> 2.27.0
> 
