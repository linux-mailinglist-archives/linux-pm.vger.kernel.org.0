Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E177E70914D
	for <lists+linux-pm@lfdr.de>; Fri, 19 May 2023 10:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjESIEb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 May 2023 04:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjESIEa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 May 2023 04:04:30 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F9D1716;
        Fri, 19 May 2023 01:03:52 -0700 (PDT)
Received: from [192.168.1.141] ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N8GEY-1qDJBS1EiO-014Ene; Fri, 19 May 2023 10:03:06 +0200
Message-ID: <47df90f9-0348-6333-757e-ddfeb6b8fbad@i2se.com>
Date:   Fri, 19 May 2023 10:03:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V3 0/6] ARM: dts: imx6ull: Fix dtbs_check warnings
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>,
        linux-imx@nxp.com, "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
References: <20230414091947.7831-1-stefan.wahren@i2se.com>
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20230414091947.7831-1-stefan.wahren@i2se.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:o50LvgBs3SXoordAvhv+x1aO0U3G28hVUe8aqojg5w5tK7KhXtv
 mpB4Dy+8i1KKdQGAU6+aziMNlZV9e5ZXvm73FD/3yzmCiq4c9ZX8NXbRYKqsOYQbugoqAXd
 ols6QeeZ5lr6tlqVAeKtNF5v9kvCgsCtDQPT6FUt3IWw2jTBjwiaRgB0LeCJSHLSbYwqlum
 x9br5GUoK5g13+DDhXaeQ==
UI-OutboundReport: notjunk:1;M01:P0:9tNi0MwuB1k=;dPML9IMKGd20U4dSjP9SPuVIi3h
 9ScdMdp4KMiWhozhbzxUmG0PkdOdPlixH2yUKYLbKUbEM4jNFD8hqg+60GApmnr8w8POfOn9a
 YtpAZ13gha8PKCD4ZY0S7LgSdl+R4jyRySCKwhqF6B+TBw5hKh6CcIxLznyqQErNSxfDiBZZi
 ZHsJFVdRtjefVjLYEURXmOzQBkrvVqE3AtO/bAvugZOxs+QgPMNUFzuOwbLsSfDN7Uj2019dD
 Wk3fdvoWrxlqcV+MWQ1aYSxUzr60YkapFWlmFfnvZ5/2KK+KcHM5Wl/vvyJbenHTttGSnfmEi
 C7WhmJ17mEalJ6ci27arr2dKwUKpZRaRDaGt5I7ZeE4BC8/W+wkJdFZ23Bvjh2qNR8XAtSyzn
 Z9yaj2Ta9Qt4GgeHQ7wljUx8yYZW9IcvrNS9PCeBE7viVc9yxXY3Mi3/d8DQD9jUS5jFT1LRL
 zjGp04cemydApzFHWf1UUCjYKdnKaR6fkxRjOD1b5NB4mvpTW8ORUYiw9x8FY9D5xCEYWPjWO
 5yd1tyHZm42tZYa0IM8ZjcFnDb22UW3oTWpLd0RWaucrF/WwjAaWFUULkhcLrmfNP+SKAhQPM
 QKca0ZlhF8PQOsilbJR1MGFEYhIqKkvNe8ntlo0rb3YdCJeusKylauh9bxSHyOUTHWcXzoDdR
 DpCkvL+dzMJSKwG2VD4rpeiinQs4VVGaxElRfdxo9A==
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Am 14.04.23 um 11:19 schrieb Stefan Wahren:
> This series tries to address some dtbs_check warnings on i.MX6ULL.
> 
> Changes in V3:
> - add Krzysztof's Reviewed-Bys
> - fix indentation in Patch 6 found by Krzysztof Kozlowski
> 
> Changes in V2:
> - new patch to fix fsl-imx-uart warnings
> - fixed GPC typo found by Fabio Estevam
> - keep enum in bindings as suggested by Krzysztof Kozlowski
> - make imx6ul GPT compatible to imx6sx
> 
> Stefan Wahren (6):
>    dt-bindings: serial: fsl-imx-uart: add missing properties
>    dt-bindings: crypto: fsl-dcp: add imx6sl and imx6ull compatible
>    dt-bindings: imx-thermal: add imx6sll and imx6ul compatible
>    dt-bindings: imxgpt: add imx6ul compatible
>    ARM: dts: imx: Adjust dma-apbh node name
>    ARM: dts: imx6ul: Add clock and PGC node to GPC
> 

currently patch 3, 5 and 6 has been applied. Should i resend the rest of 
the series?
