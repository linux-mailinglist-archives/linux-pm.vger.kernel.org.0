Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F7C424208
	for <lists+linux-pm@lfdr.de>; Wed,  6 Oct 2021 18:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239289AbhJFQCb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Oct 2021 12:02:31 -0400
Received: from marcansoft.com ([212.63.210.85]:35470 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232622AbhJFQCa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 6 Oct 2021 12:02:30 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 4109A41EA7;
        Wed,  6 Oct 2021 16:00:30 +0000 (UTC)
Subject: Re: [PATCH 3/7] soc: apple: Add driver for Apple PMGR power state
 controls
To:     Mark Kettenis <mark.kettenis@xs4all.nl>
Cc:     linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        robh+dt@kernel.org, arnd@kernel.org, linus.walleij@linaro.org,
        alyssa@rosenzweig.io, krzk@kernel.org, gregkh@linuxfoundation.org,
        p.zabel@pengutronix.de, rafael@kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20211005155923.173399-1-marcan@marcan.st>
 <20211005155923.173399-4-marcan@marcan.st>
 <d3ca3be91c2cfe99@bloch.sibelius.xs4all.nl>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <26c5ec93-f559-7dd6-5047-494b0f1e2e8c@marcan.st>
Date:   Thu, 7 Oct 2021 01:00:28 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <d3ca3be91c2cfe99@bloch.sibelius.xs4all.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06/10/2021 05.21, Mark Kettenis wrote:
>> +static const struct of_device_id apple_pmgr_ps_of_match[] = {
>> +	{ .compatible = "apple,t8103-pmgr-pwrstate" },
>> +	{ .compatible = "apple,pmgr-pwrstate" },
>> +	{}
>> +};
> 
> I think this only needs to list "apple,pmgr-pwrstate" as that is the
> one that will be present on all SoCs that is backward compatible with
> the t8103 (M1) SoC.

Ah, yeah, we don't need to bind to t8103 unless we run into a quirk 
problem. I'll remove it. Thanks!


-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
