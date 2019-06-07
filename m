Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3453870F
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2019 11:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfFGJ1Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jun 2019 05:27:16 -0400
Received: from mout.gmx.net ([212.227.17.20]:56323 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727813AbfFGJ1P (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 7 Jun 2019 05:27:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559899609;
        bh=yn03fOF6r2SyvabnP4JYMrFm+Hg3kZ8i/XwXrvS283Q=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=le3QyRV5SCfUfnUTHDDx8KnwAJ1YcZZofGsaiENaa0S65QE9F4Df2PXJx195KBS1v
         KiLuApK3rCbGhgwoopsvnM49AmTGuemK/in+mjSTTdrzjcxxWW+JWquQhdeuWUCRRs
         QGUGSopxUBhdKOK9NdMaVD1vWXyVIuI2iwdARj4I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.162] ([37.4.249.160]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MNO33-1hSrTs2XyT-006yzg; Fri, 07
 Jun 2019 11:26:49 +0200
Subject: Re: [PATCH v2 2/7] clk: bcm283x: add driver interfacing with
 Raspberry Pi's firmware
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        stefan.wahren@i2se.com, linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, f.fainelli@gmail.com,
        ptesarik@suse.com, sboyd@kernel.org, viresh.kumar@linaro.org,
        mturquette@baylibre.com, linux-pm@vger.kernel.org,
        rjw@rjwysocki.net, eric@anholt.net,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        mbrugger@suse.de, ssuloev@orpaltech.com
References: <20190606142255.29454-1-nsaenzjulienne@suse.de>
 <20190606142255.29454-3-nsaenzjulienne@suse.de>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <3c4c8b56-eb02-be6f-9b3a-a94a895f10f0@gmx.net>
Date:   Fri, 7 Jun 2019 11:26:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606142255.29454-3-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:9Gtr4vKtOR7f9jmvwWwAkSPUnTUPjTLfX0dp1Pf8fuXmf0dEfTv
 sYX87a56nfWjPnZ65c8C38ChUF4YP3EIs6NMJWI1eSMMZh7XsYSH5Zrh9pkcoVgo/nSAKHv
 l5il35Lc1dsKXeqt+WHXl2dsi6d412sVIr5FLEjxsqPIVcb6MWqj/gShhumCCM1Qa50r6E6
 8ZUYczb/ER9H95lF0i7AQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kybE1EZUeqU=:GdnVIzfNDYmg2Nph1GGsya
 A+e0FnzQ5HvHAf63DUuFKS2/O38aDgT1nJjz5bvRGtTqzEonDUx9geW0848X1O0cc6y+aAYFg
 0yGxpn1O8UbYRdehn6OQ5Sw965936qxrIb5ryXOHXdYhI5kGpmirrVV5IFXV+jypZkhDuYkBM
 pGZ+REtEQqwgYk49QId+QcpwYjYa0wTAzyXXR4Xlv1idjRUwyXeYqqNHFsowqca3bQ5UbNBn7
 6TO/3qf9a+RygSvgzgDhjGBL+Mka/u7WTb5GPj0C2iG/hbp4YU+B3EG8GLAhlkk95WZMoWa0s
 tiigh17spRDR1VaI+CzXlktvY01wOv7tnDxGVZ4XlBYxaRlblkRyyVvOqKjSt/JzgVbwl2vbs
 aE1r2T2wwF5mI+QnwrGe7IHynFORIKHcuYhZb9UnYys6tV+cuXISBIUrLwWC4L4KAcTt19H1T
 TOB+L33bXnkDJ97F0k6gJijEBfVKyVg3VhHp0b1hc0/fd1g1P5blM+jBo3HdL2oSJkKzVED+T
 t3wwL9cmDnem9QA7l+V9U3A0Ins5S6u7l8iMIVzxotJBci3j1yNOYnaCVwt+A/UMC+cJzEgE2
 0HDv0lHZ2nsHvTDWV1lmg6mxSQKKqvBPSpNwUmrVpI1Ms8G2LxRlDCMoCAPmVTEKGLm/NRXgU
 Xrpk8zkySwcytH2lWBFh8bC8oOzdTpnuwbV8Dr5ouaBg5kk65cXuinXhUj8qC0O7uBI8+9N9S
 G2HVhS6r0G0O7qMa+ujVkQHYXWnW1GOFkDrawwUu+SBW8dr5lBlQ5oiLrN6G4Oanb6HzUZu7K
 Gf9SKaJlK1TJ3sBZHDCa79GaKS20P+iwWr3IF35Kx7fPnIPAI4bczSEu4sUeYeObDwC0YkGXz
 TH/CgQIjOA69ugkmlH91/gdjuanZ7/2HyQ+WxslWIvh+05brGKcvffCABftEWzyC/LNaT9g6S
 EEdkr3mWE+TxcmVtQQe/cxcbObDAET+4nssRHEwulsELvQxOSsRW5/Y5tFit+0QjG1D2xmMVd
 cQ==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Nicolas,

Am 06.06.19 um 16:22 schrieb Nicolas Saenz Julienne:
> Raspberry Pi's firmware offers an interface though which update it's
> clock's frequencies. This is specially useful in order to change the CPU
> clock (pllb_arm) which is 'owned' by the firmware and we're unable to
> scale using the register interface provided by clk-bcm2835.
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Acked-by: Eric Anholt <eric@anholt.net>
>
> ---
>
> Changes since v1:
>   - Use BIT()
>   - Add Kconfig entry, with compile test
>   - remove prepare/unprepare
>   - Fix uninitialized init.name in pllb registration
>   - Add MODULE_ALIAS()
>   - Use determine_rate() instead of round_rate()
>   - Add small introduction explaining need for driver
>
>  drivers/clk/bcm/Kconfig           |   7 +
>  drivers/clk/bcm/Makefile          |   1 +
>  drivers/clk/bcm/clk-raspberrypi.c | 302 ++++++++++++++++++++++++++++++
>  3 files changed, 310 insertions(+)
>  create mode 100644 drivers/clk/bcm/clk-raspberrypi.c
>
> diff --git a/drivers/clk/bcm/Kconfig b/drivers/clk/bcm/Kconfig
> index 29ee7b776cd4..a4a2775d65e1 100644
> --- a/drivers/clk/bcm/Kconfig
> +++ b/drivers/clk/bcm/Kconfig
> @@ -64,3 +64,10 @@ config CLK_BCM_SR
>  	default ARCH_BCM_IPROC
>  	help
>  	  Enable common clock framework support for the Broadcom Stingray SoC
> +
> +config CLK_RASPBERRYPI
> +	tristate "Raspberry Pi firmware based clock support"
> +	depends on RASPBERRYPI_FIRMWARE || (COMPILE_TEST && !RASPBERRYPI_FIRMW=
ARE)
> +	help
> +	  Enable common clock framework support for Raspberry Pi's firmware
> +	  dependent clocks
> diff --git a/drivers/clk/bcm/Makefile b/drivers/clk/bcm/Makefile
> index 002661d39128..eb7159099d82 100644
> --- a/drivers/clk/bcm/Makefile
> +++ b/drivers/clk/bcm/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_CLK_BCM_KONA)	+=3D clk-bcm21664.o
>  obj-$(CONFIG_COMMON_CLK_IPROC)	+=3D clk-iproc-armpll.o clk-iproc-pll.o =
clk-iproc-asiu.o
>  obj-$(CONFIG_ARCH_BCM2835)	+=3D clk-bcm2835.o
>  obj-$(CONFIG_ARCH_BCM2835)	+=3D clk-bcm2835-aux.o
> +obj-$(CONFIG_CLK_RASPBERRYPI)	+=3D clk-raspberrypi.o
>  obj-$(CONFIG_ARCH_BCM_53573)	+=3D clk-bcm53573-ilp.o
>  obj-$(CONFIG_CLK_BCM_CYGNUS)	+=3D clk-cygnus.o
>  obj-$(CONFIG_CLK_BCM_HR2)	+=3D clk-hr2.o

not your fault but you better rebase your next version on linux-next
because Florian's latest patches ("clk: bcm: Make BCM2835 clock drivers
selectable") collide with this patch.

Checkpatch gives the following output about this patch:

WARNING: 'harware' may be misspelled - perhaps 'hardware'?

#58: FILE: drivers/clk/bcm/clk-raspberrypi.c:5:
+ * Even though clk-bcm2835 provides an interface to the harware
registers for

ERROR: code indent should use tabs where possible
#197: FILE: drivers/clk/bcm/clk-raspberrypi.c:144:
+^I^I^I^I=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stru=
ct clk_rate_request *req)$


