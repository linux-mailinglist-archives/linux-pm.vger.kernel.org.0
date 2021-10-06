Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA2BD424132
	for <lists+linux-pm@lfdr.de>; Wed,  6 Oct 2021 17:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238636AbhJFPX1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Oct 2021 11:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238337AbhJFPX1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Oct 2021 11:23:27 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BCCC061746;
        Wed,  6 Oct 2021 08:21:34 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 78B7141F28;
        Wed,  6 Oct 2021 15:21:28 +0000 (UTC)
Subject: Re: [PATCH 1/7] dt-bindings: arm: apple: Add apple,pmgr binding
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20211005155923.173399-1-marcan@marcan.st>
 <20211005155923.173399-2-marcan@marcan.st>
 <18818eff-87d7-6a53-a4fd-7f3cbf625a0e@canonical.com>
 <1c36c3e6-c1aa-0779-5f6d-8980377c45a4@canonical.com>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <7a55d970-b333-6820-7fff-44a271718135@marcan.st>
Date:   Thu, 7 Oct 2021 00:21:25 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1c36c3e6-c1aa-0779-5f6d-8980377c45a4@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06/10/2021 16.30, Krzysztof Kozlowski wrote:
> After looking at the code, there is no device for
> apple,t8103-pmgr/apple,pmgr. What is this binding about? Is there really
> a central (central as in "one device for SoC") block managing power
> which you want to model here?

The pwrstate driver binds to individual power control registers within 
the syscon node. The parent node is bound by the generic syscon driver, 
so there is no specific SoC driver for it, but I still want to include 
SoC-specific compatibles so we can have something to use for quirks if 
we run into trouble in the future.

There are two PMGRs in the Apple M1, and thus there would be two syscon 
nodes, each containing one subnode per PM domain. The devicetree in this 
series currently only instantiates one of those, though.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
