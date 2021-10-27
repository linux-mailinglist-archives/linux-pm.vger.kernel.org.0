Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12DEE43C0E0
	for <lists+linux-pm@lfdr.de>; Wed, 27 Oct 2021 05:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239135AbhJ0DlE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Oct 2021 23:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbhJ0DlE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Oct 2021 23:41:04 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989CDC061570;
        Tue, 26 Oct 2021 20:38:39 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 3469A421F5;
        Wed, 27 Oct 2021 03:38:30 +0000 (UTC)
To:     Rob Herring <robh@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        Mark Kettenis <kettenis@openbsd.org>
References: <20211025144718.157794-1-marcan@marcan.st>
 <20211025144718.157794-3-marcan@marcan.st>
 <YXhINE00HG6hbQI4@robh.at.kernel.org>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v2 2/8] dt-bindings: arm: apple: Add apple,pmgr binding
Message-ID: <c0f2587c-ab69-8194-e618-ce7919c1aeb1@marcan.st>
Date:   Wed, 27 Oct 2021 12:38:31 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YXhINE00HG6hbQI4@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27/10/2021 03.25, Rob Herring wrote:
> On Mon, Oct 25, 2021 at 11:47:12PM +0900, Hector Martin wrote:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - apple,t8103-pmgr
>> +          - apple,t8103-minipmgr
>> +      - const: apple,pmgr
>> +      - const: syscon
>> +      - const: simple-mfd
> 
> 
> 'simple-mfd' means 'there's nothing in this node that any of the child
> nodes depend on'. You should be somewhat certain as dropping it later
> creates compatibility issues.

Hmm, I see simple-mfd turns this into a bus which I guess allows child 
nodes to be probed without the parent node doing anything special (then 
we use syscon_node_to_regmap to get the syscon instantiated). Do you 
have a example use case for doing this without simple-mfd?

At this point I can't think of anything we'd need from the parent node, 
especially if we end up using this syscon strictly for pwrstate subnodes 
(which seems likely at this point). One thing that comes to mind is 
telling the PMP (a coprocessor in charge of power metrics/management) 
about some domains being turned on/off, which is apparently a thing, but 
that wouldn't even be in this node; that'd have to be a phandle property 
in the child nodes referencing a PMP/coprocessor node elsewhere (none of 
which is implemented right now, and which should be backwards compatible 
once it is).

If it turns out we do have a dep of some sort in the end, could we just 
have the child node driver return -EPROBE_DEFER until the parent is 
probed and has made whatever service available? That would allow us to 
keep simple-mfd, right?

If it works for you, I'll also just squash the two bindings into one 
commit for the next spin, since there is a direct dependency at this 
point and it should make things easier. Otherwise, I can just swap the 
order if you prefer it that way.

Ack on the other formatting changes; if the rest of the series looks 
good to the other folks I'll try to respin this into a v3 soon, to see 
if we can sneak it in by 5.16, since it'd be nice to have the power 
domain stuff in there :)

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
