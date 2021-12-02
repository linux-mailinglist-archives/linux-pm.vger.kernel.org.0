Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B32E465E7B
	for <lists+linux-pm@lfdr.de>; Thu,  2 Dec 2021 07:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350286AbhLBHCU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Dec 2021 02:02:20 -0500
Received: from relay2.uni-heidelberg.de ([129.206.119.212]:53813 "EHLO
        relay2.uni-heidelberg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbhLBHCT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Dec 2021 02:02:19 -0500
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Dec 2021 02:02:19 EST
X-IPAS-Result: =?us-ascii?q?A2BHBQDDa6hh/1BqzoFagQmFUYUzkRaeRQEBAQEBAQEBA?=
 =?us-ascii?q?Qk+AQIEAQGFBYMHAiU4EwECBAEBAQEDAgMBAQEBAQEDAQEGAQEBAQEGBIEch?=
 =?us-ascii?q?XWGQgEBBAEjVgULCw4KAgImAgIUKCGFeyGzL3qBMYEBiCyBKiOBECqMCYJQg?=
 =?us-ascii?q?imBFYMqPoQCJREqgns3gi4EkHuCH4IdvxcHojAEFjKVfZE5LZMjgk6mO4F4T?=
 =?us-ascii?q?4EuMz6DOVAZD5xxQ2gCBgsBAQMJhUcBAY0IAQE?=
IronPort-Data: A9a23:j1Wncqvr3B7nAI+MVQH0Ix0CSefnVJVeMUV32f8akzHdYApBsoF/q
 tZmKW2EPamKZzHzf4h3aoW3pBsGuJ6BztZmT1c/qntnEikUgMeUXt7xwmXYZn7NdJ2dECqLz
 Cm8hv3odp1coqr0/0/1WlTZQP0VOZigHtIQMsacUsxKbVIiGHhJZS5LwbZj29cy2YLhWmthh
 PuryyHhEA79s9JLGj9Mg06zgEsHUCPa4W5wUvQWPJinjXeG/5UnJMt3yZKZdxMUdrJp8tuSH
 I4v+l0ZElTxpH/BAvv9+lryn9ZjrrT6ZWBigVIOM0Sub4QrSiEais4G2PQghUh/mSeJlNZc2
 eR2kbOUeDl2O/L9uNkxXEwNe81+FfUuFL7vJXW6tsrVzlLcNWbqwrBuAUA6MIkS9/x4R21Dn
 RAaAGlXP1bZ37zwmerlDLk07iggBJCD0Ic3unVp0DzDJfIrRJfFBaTV/5lF2jZ1hs1PEfvab
 ccDZnxjYXwsZjUWYQ1NU81jzLjAan/XK2FjjnnKrq0LySvz3QdX6rfQIuiEdYnfLSlSth3E+
 D6cpjyR7gshHNKY0iGtqnahh+uJmy7nMKoYE7K17NZ1gUeewGYUAQcaE1C8pJGRlUO4QPpUM
 E0ZvC00osAa8E2tU8m4RxiQvnGJpFgfVsBWHul87xuCooLP+QuxBWUeSDNFLts8u6cLqScC0
 lKMmNWvBCN19qCTSDed+7aYoDe4NDIaa2MPDcMZcecby8vxoIo1owP+dfJMNJ+L0diqKBHN7
 z/f+UDSmI4vpcIM0qy6+3XOjDStuoXFQ2YJCuP/AzrNAuRROd/NWmC41bTIxaoRcN/BETFtq
 FBUxZjGtYjiGLnXzESwrPMx8KaBy9vt3Nf0oVNuE5Ql/Tm39BZPlqgOsWgkfC+F3u4ucDPkZ
 grsEtdL+INeOXGnd6AfXm5QNyjI5fK/fTgGfqmKBjarXnSWXFbblByCnWbKgwjQfLEEyMnS+
 f6zKK5A90oyB6V91yaRTOwAy7ItzS1W7TqNHsCgn0/7ieDHOyb9pVI53L2mMLhRAESs/lq9z
 jqjH5vRo/mieLemM3SMr9Z7wa4idCNlWcGeRzNrmh6reVY4RDt4U5c9MJsrdoh6gqkdi+HJ4
 HynQU5E2RL5iGHYLh+JAk2Pm5uwNauSbBsTY0QRALpf8yR5PNv0sv5AL8BfkHtO3LUL8MOYh
 sItI62oasmjgByck9jBRfERdLBfSSk=
IronPort-HdrOrdr: A9a23:Ei6uQalQqRpzZOddlp1dJ61ZP2rpDfI33DAbv31ZSRFFG/Fwwf
 rBoB19726WtN9xYhEdcL+7UpVoLUmwyXcX2+gs1MmZLWvbUQKTRekI0WKI+VHd8kPFmdJg6Q
 ==
X-IronPort-Anti-Spam-Filtered: true
Received: from lemon.iwr.uni-heidelberg.de ([129.206.106.80])
  by relay2.uni-heidelberg.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Dec 2021 07:51:47 +0100
Received: from hlauer by lemon.iwr.uni-heidelberg.de with local (Exim 4.92)
        (envelope-from <hlauer@lemon.iwr.uni-heidelberg.de>)
        id 1msfwZ-0002mX-E5; Thu, 02 Dec 2021 07:51:47 +0100
Date:   Thu, 2 Dec 2021 07:51:47 +0100
From:   Hermann.Lauer@uni-heidelberg.de
To:     Quentin Schulz <foss@0leil.net>
Cc:     Evgeny Boger <boger@wirenboard.com>, Chen-Yu Tsai <wens@csie.org>,
        linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
Subject: Re: Re: [PATCH] power: supply: axp20x_battery: set charging voltage
 via DT
Message-ID: <20211202065147.GA10665@lemon.iwr.uni-heidelberg.de>
References: <20211119175740.405446-1-boger@wirenboard.com>
 <20211201175728.ja7a5iilm23vyblr@fiqs>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211201175728.ja7a5iilm23vyblr@fiqs>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Wed, Dec 01, 2021 at 06:57:28PM +0100, Quentin Schulz wrote:
> The issue here is that only specific values are possible. e.g. for
> axp20x: 4.1 4.15 4.2V, axp22x 4.1 4.2V, there's nothing in-between.
...
> Would it make sense to find the closest value to the one appropriate for
> the battery that is supported by the PMIC (lesser or equal to the one
> specified by the battery obviously)?
> 
> Otherwise, I would imagine this function would fail most of the time
> because it's not the exact voltage supported by the PMIC?

You have to add the values to all device trees for every board an it may
produce more devicetree entries when the same board have a different battery
attached. OTOH, this allows more flexibility with devicetree overlays.

> Completely off-topic, but I also see that batteries now support
> specifying which technology they use so it should be safe to raise the
> maximum for some technologies above what we currently support in the
> driver. e.g. axp22x supports 4.22 and 4.24V too but they aren't
> selectable at the moment.

At least axp209 additionaly allows 4.36V, although that may be used only
in hand crafted setups. At the moment I'm switching on that from u-boot. 

Greetings
  Hermann
