Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21175424154
	for <lists+linux-pm@lfdr.de>; Wed,  6 Oct 2021 17:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238832AbhJFP3c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Oct 2021 11:29:32 -0400
Received: from marcansoft.com ([212.63.210.85]:55408 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231671AbhJFP3c (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 6 Oct 2021 11:29:32 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id C1DAB3FA5E;
        Wed,  6 Oct 2021 15:27:33 +0000 (UTC)
Subject: Re: [PATCH 2/7] dt-bindings: power: Add apple,pmgr-pwrstate binding
To:     Mark Kettenis <mark.kettenis@xs4all.nl>
Cc:     linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        robh+dt@kernel.org, arnd@kernel.org, linus.walleij@linaro.org,
        alyssa@rosenzweig.io, krzk@kernel.org, gregkh@linuxfoundation.org,
        p.zabel@pengutronix.de, rafael@kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20211005155923.173399-1-marcan@marcan.st>
 <20211005155923.173399-3-marcan@marcan.st>
 <d3ca3bcc44156f32@bloch.sibelius.xs4all.nl>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <bb403fbe-2ac2-f9d2-ac86-35e63b4210a8@marcan.st>
Date:   Thu, 7 Oct 2021 00:27:31 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <d3ca3bcc44156f32@bloch.sibelius.xs4all.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06/10/2021 05.16, Mark Kettenis wrote:
> Or we drop the apple,mpgr-pwrstate and go with only SoC-specific
> compatibles from that point onwards.

I think if Apple has discrete compat breaks and several SoCs still share 
compatibility, it'd make sense to encode those as pmgr-pwrstate-v2, v3, 
etc. That way compatible SoCs can continue to benefit from 
forwards-compatible kernels, and we only end up with a hard dep on a new 
kernel for incompatible SoCs.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
