Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489F652E905
	for <lists+linux-pm@lfdr.de>; Fri, 20 May 2022 11:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347755AbiETJlo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 May 2022 05:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347786AbiETJln (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 May 2022 05:41:43 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E7313F91C;
        Fri, 20 May 2022 02:41:41 -0700 (PDT)
X-UUID: 54fe12198bfc4baf9eefe19a8be5f5fd-20220520
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:09c94849-9717-4d73-aae2-b3dd68d15d28,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:2a19b09,CLOUDID:cf90f0e2-edbf-4bd4-8a34-dfc5f7bb086d,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:0,BEC:nil
X-UUID: 54fe12198bfc4baf9eefe19a8be5f5fd-20220520
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 363951275; Fri, 20 May 2022 17:41:37 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 20 May 2022 17:41:36 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 20 May 2022 17:41:35 +0800
Message-ID: <47da3ed20b7f3c082a6bf38de2ba291b7dd67ecc.camel@mediatek.com>
Subject: Re: [RESEND v4 2/2] PM / devfreq: mediatek: Introduce MediaTek CCI
 devfreq driver
From:   Johnson Wang <johnson.wang@mediatek.com>
To:     Chen-Yu Tsai <wenst@chromium.org>
CC:     <cw00.choi@samsung.com>, <krzk+dt@kernel.org>,
        <robh+dt@kernel.org>, <kyungmin.park@samsung.com>,
        <djakov@kernel.org>, <khilman@kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <jia-wei.chang@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 20 May 2022 17:41:35 +0800
In-Reply-To: <CAGXv+5G-88zWSnic-AY2ANF9BYWCsZk29CeLxp+VuFKE_LH5Ug@mail.gmail.com>
References: <20220513032832.17645-1-johnson.wang@mediatek.com>
         <20220513032832.17645-3-johnson.wang@mediatek.com>
         <CAGXv+5Em2eq8g8phC7MVcEP-sCsSsKa9FQjOra2UN3pib_psLA@mail.gmail.com>
         <7eec74e32bb482ba6984c6789f598ee9965f49b3.camel@mediatek.com>
         <CAGXv+5G-88zWSnic-AY2ANF9BYWCsZk29CeLxp+VuFKE_LH5Ug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2022-05-19 at 11:24 +0800, Chen-Yu Tsai wrote:
> On Wed, May 18, 2022 at 8:19 PM Johnson Wang <
> johnson.wang@mediatek.com> wrote:
> > 
> > Hi Chen-Yu,
> > 
> > On Fri, 2022-05-13 at 11:54 +0800, Chen-Yu Tsai wrote:
> > > On Fri, May 13, 2022 at 11:31 AM Johnson Wang <
> > > johnson.wang@mediatek.com> wrote:
> > > > 
> > > > We introduce a devfreq driver for the MediaTek Cache Coherent
> > > > Interconnect
> > > > (CCI) used by some MediaTek SoCs.
> > > > 
> > > > In this driver, we use the passive devfreq driver to get target
> > > > frequencies
> > > > and adjust voltages accordingly. In MT8183 and MT8186, the
> > > > MediaTek
> > > > CCI
> > > > is supplied by the same regulators with the little core CPUs.
> > > > 
> > > > Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > > > Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> > > > Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> > > > ---
> > > > This patch depends on "devfreq-testing"[1].
> > > > [1]
> > > > 
https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-testing__;!!CTRNKA9wMg0ARbw!zzOSoso9udvDV3h6kYlmizFtbn3ACA5aS2jCAjKyvtu4z0fobv1mD5uF9YbPSme8l_NnR05unTxkZfDdzohu8asWZQ$
> > > > 
> > > > ---
> > > >  drivers/devfreq/Kconfig           |  10 +
> > > >  drivers/devfreq/Makefile          |   1 +
> > > >  drivers/devfreq/mtk-cci-devfreq.c | 474
> > > > ++++++++++++++++++++++++++++++
> > > >  3 files changed, 485 insertions(+)
> > > >  create mode 100644 drivers/devfreq/mtk-cci-devfreq.c
> > > > 
> > > > diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> > > > index 87eb2b837e68..9754d8b31621 100644
> > > > --- a/drivers/devfreq/Kconfig
> > > > +++ b/drivers/devfreq/Kconfig
> > > > @@ -120,6 +120,16 @@ config ARM_TEGRA_DEVFREQ
> > > >           It reads ACTMON counters of memory controllers and
> > > > adjusts the
> > > >           operating frequencies and voltages with OPP support.
> > > > 
> > > > +config ARM_MEDIATEK_CCI_DEVFREQ
> > > > +       tristate "MEDIATEK CCI DEVFREQ Driver"
> > > > +       depends on ARM_MEDIATEK_CPUFREQ || COMPILE_TEST
> > > > +       select DEVFREQ_GOV_PASSIVE
> > > > +       help
> > > > +         This adds a devfreq driver for MediaTek Cache
> > > > Coherent
> > > > Interconnect
> > > > +         which is shared the same regulators with the cpu
> > > > cluster.
> > > > It can track
> > > > +         buck voltages and update a proper CCI frequency. Use
> > > > the
> > > > notification
> > > > +         to get the regulator status.
> > > > +
> > > >  config ARM_RK3399_DMC_DEVFREQ
> > > >         tristate "ARM RK3399 DMC DEVFREQ Driver"
> > > >         depends on (ARCH_ROCKCHIP && HAVE_ARM_SMCCC) || \
> > > > diff --git a/drivers/devfreq/Makefile
> > > > b/drivers/devfreq/Makefile
> > > > index 0b6be92a25d9..bf40d04928d0 100644
> > > > --- a/drivers/devfreq/Makefile
> > > > +++ b/drivers/devfreq/Makefile
> > > > @@ -11,6 +11,7 @@ obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)     +=
> > > > governor_passive.o
> > > >  obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)   += exynos-bus.o
> > > >  obj-$(CONFIG_ARM_IMX_BUS_DEVFREQ)      += imx-bus.o
> > > >  obj-$(CONFIG_ARM_IMX8M_DDRC_DEVFREQ)   += imx8m-ddrc.o
> > > > +obj-$(CONFIG_ARM_MEDIATEK_CCI_DEVFREQ) += mtk-cci-devfreq.o
> > > >  obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)   += rk3399_dmc.o
> > > >  obj-$(CONFIG_ARM_SUN8I_A33_MBUS_DEVFREQ)       += sun8i-a33-
> > > > mbus.o
> > > >  obj-$(CONFIG_ARM_TEGRA_DEVFREQ)                += tegra30-
> > > > devfreq.o
> > > > diff --git a/drivers/devfreq/mtk-cci-devfreq.c
> > > > b/drivers/devfreq/mtk-cci-devfreq.c
> > > > new file mode 100644
> > > > index 000000000000..aa8c37eb4a06
> > > > --- /dev/null
> > > > +++ b/drivers/devfreq/mtk-cci-devfreq.c
> > > > @@ -0,0 +1,474 @@
> 
> [...]
> 
> > > > +       if (IS_ERR(drv->sram_reg))
> > > > +               drv->sram_reg = NULL;
> > > > +       else {
> > > > +               ret = regulator_enable(drv->sram_reg);
> > > > +               if (ret) {
> > > > +                       dev_err(dev, "failed to enable sram
> > > > regulator\n");
> > > > +                       goto out_free_resources;
> > > > +               }
> > > > +       }
> > > > +
> > > > +       /*
> > > > +        * We assume min voltage is 0 and tracking target
> > > > voltage
> > > > using
> > > > +        * min_volt_shift for each iteration.
> > > > +        * The retry_max is 3 times of expeted iteration count.
> > > 
> > > expected?
> > > 
> > 
> > Maybe "the maximum" will be more appropriate?
> 
> 
> I was merely pointing out a typo in "expeted".
> 
> Looking at it again, I'm not sure why retry attempts are tied to the
> voltage.
> 
> 
> ChenYu

Hi Chen-Yu,

Thanks for you reminder.

Whenever the voltages are scaled up/down one step,
meaning that there is another iteration in the while loop.

Thus, our thought is to use times of the voltages step up/down to set
iteration limit.

BRs,
Johnson Wang 

