Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2874241EA
	for <lists+linux-pm@lfdr.de>; Wed,  6 Oct 2021 17:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbhJFP5x (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Oct 2021 11:57:53 -0400
Received: from marcansoft.com ([212.63.210.85]:34260 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231851AbhJFP5w (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 6 Oct 2021 11:57:52 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 4B9333FA5E;
        Wed,  6 Oct 2021 15:55:53 +0000 (UTC)
Subject: Re: [PATCH 2/7] dt-bindings: power: Add apple,pmgr-pwrstate binding
From:   Hector Martin <marcan@marcan.st>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
References: <20211005155923.173399-1-marcan@marcan.st>
 <20211005155923.173399-3-marcan@marcan.st>
 <CAL_JsqJenHAOw4gApzGpuj-8nZjkYhmBg0qBj-DV+CEJ7zXuVw@mail.gmail.com>
 <f95f6d61-8809-e668-0458-453a8dfbe641@marcan.st>
Message-ID: <b5b25e17-d98b-d447-f917-4d728f52a6ff@marcan.st>
Date:   Thu, 7 Oct 2021 00:55:51 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <f95f6d61-8809-e668-0458-453a8dfbe641@marcan.st>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07/10/2021 00.52, Hector Martin wrote:
> I realize this is all kind of "not the way things are usually done", but
> I don't want to pass up on the opportunity to have one driver last us
> multiple SoCs if we have the chance, and it's looking like it should :-)

Addendum: just found some prior art for this. See power/pd-samsung.yaml, 
which is another single-PD binding (though in that case they put them in 
the SoC node directly, not under a syscon).

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
