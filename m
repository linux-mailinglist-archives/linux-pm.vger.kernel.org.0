Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0CF6A02A0
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2019 15:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfH1NFp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Aug 2019 09:05:45 -0400
Received: from mga02.intel.com ([134.134.136.20]:60001 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfH1NFo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 28 Aug 2019 09:05:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 06:05:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,441,1559545200"; 
   d="scan'208";a="197552902"
Received: from deyangko-mobl.ccr.corp.intel.com ([10.249.168.35])
  by fmsmga001.fm.intel.com with ESMTP; 28 Aug 2019 06:05:41 -0700
Message-ID: <961b814b345ee765408b85861ec3c37d01857c0a.camel@intel.com>
Subject: Re: [PATCH] drivers: thermal: qcom: tsens: Fix memory leak from
 qfprom read
From:   Zhang Rui <rui.zhang@intel.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 28 Aug 2019 21:05:51 +0800
In-Reply-To: <CAP245DVf9fZNVEaYS39_NZ133LbwuZ77i=2fHUs-u_r-5EK-3Q@mail.gmail.com>
References: <20190823093835.32655-1-srinivas.kandagatla@linaro.org>
         <CAP245DVf9fZNVEaYS39_NZ133LbwuZ77i=2fHUs-u_r-5EK-3Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 2019-08-23 at 17:29 +0530, Amit Kucheria wrote:
> On Fri, Aug 23, 2019 at 3:08 PM Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
> > 
> > memory returned as part of nvmem_read via qfprom_read should be
> > freed by the consumer once done.
> > Existing code is not doing it so fix it.
> > 
> > Below memory leak detected by kmemleak
> >    [<ffffff80088b7658>] kmemleak_alloc+0x50/0x84
> >     [<ffffff80081df120>] __kmalloc+0xe8/0x168
> >     [<ffffff80086db350>] nvmem_cell_read+0x30/0x80
> >     [<ffffff8008632790>] qfprom_read+0x4c/0x7c
> >     [<ffffff80086335a4>] calibrate_v1+0x34/0x204
> >     [<ffffff8008632518>] tsens_probe+0x164/0x258
> >     [<ffffff80084e0a1c>] platform_drv_probe+0x80/0xa0
> >     [<ffffff80084de4f4>] really_probe+0x208/0x248
> >     [<ffffff80084de2c4>] driver_probe_device+0x98/0xc0
> >     [<ffffff80084dec54>] __device_attach_driver+0x9c/0xac
> >     [<ffffff80084dca74>] bus_for_each_drv+0x60/0x8c
> >     [<ffffff80084de634>] __device_attach+0x8c/0x100
> >     [<ffffff80084de6c8>] device_initial_probe+0x20/0x28
> >     [<ffffff80084dcbb8>] bus_probe_device+0x34/0x7c
> >     [<ffffff80084deb08>] deferred_probe_work_func+0x6c/0x98
> >     [<ffffff80080c3da8>] process_one_work+0x160/0x2f8
> > 
> > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> Acked-by: Amit Kucheria <amit.kucheria@linaro.org>

patch applied.

thanks,
rui
> 
> > ---
> >  drivers/thermal/qcom/tsens-8960.c |  2 ++
> >  drivers/thermal/qcom/tsens-v0_1.c | 12 ++++++++++--
> >  drivers/thermal/qcom/tsens-v1.c   |  1 +
> >  drivers/thermal/qcom/tsens.h      |  1 +
> >  4 files changed, 14 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/thermal/qcom/tsens-8960.c
> > b/drivers/thermal/qcom/tsens-8960.c
> > index 8d9b721dadb6..e46a4e3f25c4 100644
> > --- a/drivers/thermal/qcom/tsens-8960.c
> > +++ b/drivers/thermal/qcom/tsens-8960.c
> > @@ -229,6 +229,8 @@ static int calibrate_8960(struct tsens_priv
> > *priv)
> >         for (i = 0; i < num_read; i++, s++)
> >                 s->offset = data[i];
> > 
> > +       kfree(data);
> > +
> >         return 0;
> >  }
> > 
> > diff --git a/drivers/thermal/qcom/tsens-v0_1.c
> > b/drivers/thermal/qcom/tsens-v0_1.c
> > index 6f26fadf4c27..055647bcee67 100644
> > --- a/drivers/thermal/qcom/tsens-v0_1.c
> > +++ b/drivers/thermal/qcom/tsens-v0_1.c
> > @@ -145,8 +145,10 @@ static int calibrate_8916(struct tsens_priv
> > *priv)
> >                 return PTR_ERR(qfprom_cdata);
> > 
> >         qfprom_csel = (u32 *)qfprom_read(priv->dev, "calib_sel");
> > -       if (IS_ERR(qfprom_csel))
> > +       if (IS_ERR(qfprom_csel)) {
> > +               kfree(qfprom_cdata);
> >                 return PTR_ERR(qfprom_csel);
> > +       }
> > 
> >         mode = (qfprom_csel[0] & MSM8916_CAL_SEL_MASK) >>
> > MSM8916_CAL_SEL_SHIFT;
> >         dev_dbg(priv->dev, "calibration mode is %d\n", mode);
> > @@ -181,6 +183,8 @@ static int calibrate_8916(struct tsens_priv
> > *priv)
> >         }
> > 
> >         compute_intercept_slope(priv, p1, p2, mode);
> > +       kfree(qfprom_cdata);
> > +       kfree(qfprom_csel);
> > 
> >         return 0;
> >  }
> > @@ -198,8 +202,10 @@ static int calibrate_8974(struct tsens_priv
> > *priv)
> >                 return PTR_ERR(calib);
> > 
> >         bkp = (u32 *)qfprom_read(priv->dev, "calib_backup");
> > -       if (IS_ERR(bkp))
> > +       if (IS_ERR(bkp)) {
> > +               kfree(calib);
> >                 return PTR_ERR(bkp);
> > +       }
> > 
> >         calib_redun_sel =  bkp[1] & BKP_REDUN_SEL;
> >         calib_redun_sel >>= BKP_REDUN_SHIFT;
> > @@ -313,6 +319,8 @@ static int calibrate_8974(struct tsens_priv
> > *priv)
> >         }
> > 
> >         compute_intercept_slope(priv, p1, p2, mode);
> > +       kfree(calib);
> > +       kfree(bkp);
> > 
> >         return 0;
> >  }
> > diff --git a/drivers/thermal/qcom/tsens-v1.c
> > b/drivers/thermal/qcom/tsens-v1.c
> > index 10b595d4f619..870f502f2cb6 100644
> > --- a/drivers/thermal/qcom/tsens-v1.c
> > +++ b/drivers/thermal/qcom/tsens-v1.c
> > @@ -138,6 +138,7 @@ static int calibrate_v1(struct tsens_priv
> > *priv)
> >         }
> > 
> >         compute_intercept_slope(priv, p1, p2, mode);
> > +       kfree(qfprom_cdata);
> > 
> >         return 0;
> >  }
> > diff --git a/drivers/thermal/qcom/tsens.h
> > b/drivers/thermal/qcom/tsens.h
> > index 2fd94997245b..b89083b61c38 100644
> > --- a/drivers/thermal/qcom/tsens.h
> > +++ b/drivers/thermal/qcom/tsens.h
> > @@ -17,6 +17,7 @@
> > 
> >  #include <linux/thermal.h>
> >  #include <linux/regmap.h>
> > +#include <linux/slab.h>
> > 
> >  struct tsens_priv;
> > 
> > --
> > 2.21.0
> > 

