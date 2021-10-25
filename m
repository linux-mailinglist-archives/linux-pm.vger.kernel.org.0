Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD658439E63
	for <lists+linux-pm@lfdr.de>; Mon, 25 Oct 2021 20:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbhJYSYD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Oct 2021 14:24:03 -0400
Received: from marcansoft.com ([212.63.210.85]:33748 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231233AbhJYSYD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 25 Oct 2021 14:24:03 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id ED557419B4;
        Mon, 25 Oct 2021 18:21:33 +0000 (UTC)
Subject: Re: [PATCH v2 2/8] dt-bindings: arm: apple: Add apple,pmgr binding
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Mark Kettenis <kettenis@openbsd.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Arnd Bergmann <arnd@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Hovold <johan@kernel.org>
References: <20211025144718.157794-1-marcan@marcan.st>
 <20211025144718.157794-3-marcan@marcan.st>
 <1635185813.758208.824867.nullmailer@robh.at.kernel.org>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <767a424f-543c-3eda-4b7f-a6113c9cf250@marcan.st>
Date:   Tue, 26 Oct 2021 03:21:31 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1635185813.758208.824867.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26/10/2021 03.16, Rob Herring wrote:
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Unknown file referenced: [Errno 2] No such file or directory: '/usr/local/lib/python3.8/dist-packages/dtschema/power/apple,pmgr-pwrstate.yaml'
> xargs: dt-doc-validate: exited with status 255; aborting
> make[1]: *** Deleting file 'Documentation/devicetree/bindings/arm/apple/apple,pmgr.example.dt.yaml'
> Unknown file referenced: [Errno 2] No such file or directory: '/usr/local/lib/python3.8/dist-packages/dtschema/power/apple,pmgr-pwrstate.yaml'
> make[1]: *** [scripts/Makefile.lib:385: Documentation/devicetree/bindings/arm/apple/apple,pmgr.example.dt.yaml] Error 255
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1441: dt_binding_check] Error 2

Ah, I guess this is just an order issue. Patches 2/3 should've been 
swapped... sorry about that, I only ran the checker on the final state, 
not the intermediate ones.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
