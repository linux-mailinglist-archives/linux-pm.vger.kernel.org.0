Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A49745EDE7
	for <lists+linux-pm@lfdr.de>; Fri, 26 Nov 2021 13:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239847AbhKZMef (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Nov 2021 07:34:35 -0500
Received: from mga09.intel.com ([134.134.136.24]:37544 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347215AbhKZMce (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 26 Nov 2021 07:32:34 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="235478921"
X-IronPort-AV: E=Sophos;i="5.87,265,1631602800"; 
   d="scan'208";a="235478921"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 04:29:21 -0800
X-IronPort-AV: E=Sophos;i="5.87,265,1631602800"; 
   d="scan'208";a="607851585"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 04:29:19 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 6306820165;
        Fri, 26 Nov 2021 14:28:47 +0200 (EET)
Date:   Fri, 26 Nov 2021 14:28:47 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     mchehab@kernel.org, broonie@kernel.org, kernel@puri.sm,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-pm@vger.kernel.org, Angus Ainslie <angus@akkea.ca>
Subject: Re: [PATCH v2] media: i2c: dw9714: add optional regulator support
Message-ID: <YaDS/+QbTWRl3cOS@paasikivi.fi.intel.com>
References: <20211126090107.1243558-1-martin.kepplinger@puri.sm>
 <YaC6nZIQOsrpBY8V@paasikivi.fi.intel.com>
 <8d72c895ece6dce7d8badb241eebcbe076a03f81.camel@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d72c895ece6dce7d8badb241eebcbe076a03f81.camel@puri.sm>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 26, 2021 at 12:06:03PM +0100, Martin Kepplinger wrote:
> Am Freitag, dem 26.11.2021 um 12:44 +0200 schrieb Sakari Ailus:
> > Hi Martin,
> > 
> > On Fri, Nov 26, 2021 at 10:01:07AM +0100, Martin Kepplinger wrote:
> > > From: Angus Ainslie <angus@akkea.ca>
> > > 
> > > Allow the dw9714 to control a regulator and adjust suspend() and
> > > resume()
> > > to support both runtime and system pm.
> > > 
> > > Signed-off-by: Angus Ainslie <angus@akkea.ca>
> > > Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> > > ---
> > > 
> > > revision history
> > > ----------------
> > > 
> > > v2: (thank you Mark)
> > >  * simplify the regulator_get_optional() error path
> > >  * fix regulator usage during probe()
> > > 
> > > v1:
> > > https://lore.kernel.org/linux-media/20211125080922.978583-1-martin.kepplinger@puri.sm/
> > > 
> > > 
> > > 
> > >  drivers/media/i2c/dw9714.c | 39
> > > ++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 39 insertions(+)
> > > 
> > > diff --git a/drivers/media/i2c/dw9714.c
> > > b/drivers/media/i2c/dw9714.c
> > > index 3863dfeb8293..e8cc19b89861 100644
> > > --- a/drivers/media/i2c/dw9714.c
> > > +++ b/drivers/media/i2c/dw9714.c
> > > @@ -5,6 +5,7 @@
> > >  #include <linux/i2c.h>
> > >  #include <linux/module.h>
> > >  #include <linux/pm_runtime.h>
> > > +#include <linux/regulator/consumer.h>
> > >  #include <media/v4l2-ctrls.h>
> > >  #include <media/v4l2-device.h>
> > >  #include <media/v4l2-event.h>
> > > @@ -36,6 +37,7 @@ struct dw9714_device {
> > >         struct v4l2_ctrl_handler ctrls_vcm;
> > >         struct v4l2_subdev sd;
> > >         u16 current_val;
> > > +       struct regulator *vcc;
> > >  };
> > >  
> > >  static inline struct dw9714_device *to_dw9714_vcm(struct v4l2_ctrl
> > > *ctrl)
> > > @@ -145,6 +147,21 @@ static int dw9714_probe(struct i2c_client
> > > *client)
> > >         if (dw9714_dev == NULL)
> > >                 return -ENOMEM;
> > >  
> > > +       dw9714_dev->vcc = devm_regulator_get_optional(&client->dev,
> > > "vcc");
> > 
> > You you used regular devm_regulator_get(), you could remove the error
> > handling below. If there's no regulator, you'll simply get a dummy
> > one.
> 
> ok thanks
> 
> 
> > 
> > > +       if (IS_ERR(dw9714_dev->vcc)) {
> > > +               dev_dbg(&client->dev, "No vcc regulator found:
> > > %ld\n",
> > > +                       PTR_ERR(dw9714_dev->vcc));
> > > +               dw9714_dev->vcc = NULL;
> > > +       }
> > > +
> > > +       if (dw9714_dev->vcc) {
> > 
> > With (dummy) regulators, these checks become unnecessary.
> > 
> > > +               rval = regulator_enable(dw9714_dev->vcc);
> > > +               if (rval < 0) {
> > > +                       dev_err(&client->dev, "failed to enable
> > > vcc: %d\n", rval);
> > > +                       return rval;
> > > +               }
> > > +       }
> > > +
> > >         v4l2_i2c_subdev_init(&dw9714_dev->sd, client, &dw9714_ops);
> > >         dw9714_dev->sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE |
> > >                                 V4L2_SUBDEV_FL_HAS_EVENTS;
> > > @@ -200,6 +217,9 @@ static int __maybe_unused
> > > dw9714_vcm_suspend(struct device *dev)
> > >         struct dw9714_device *dw9714_dev = sd_to_dw9714_vcm(sd);
> > >         int ret, val;
> > >  
> > > +       if (pm_runtime_suspended(&client->dev))
> > > +               return 0;
> > 
> > This can't take place in a runtime PM suspend callback. You'll need
> > to add
> > system suspend callback for this.
> 
> but this function is both the system and runtime suspend callback.
> doesn't splitting up the callbacks just add lines of code
> unnecessarily?

Hmm. After thinking about this a little, I think this could indeed work.

Yeah, please leave it as-is.

> 
> > 
> > > +
> > >         for (val = dw9714_dev->current_val & ~(DW9714_CTRL_STEPS -
> > > 1);
> > >              val >= 0; val -= DW9714_CTRL_STEPS) {
> > >                 ret = dw9714_i2c_write(client,
> > > @@ -208,6 +228,13 @@ static int __maybe_unused
> > > dw9714_vcm_suspend(struct device *dev)
> > >                         dev_err_once(dev, "%s I2C failure: %d",
> > > __func__, ret);
> > >                 usleep_range(DW9714_CTRL_DELAY_US,
> > > DW9714_CTRL_DELAY_US + 10);
> > >         }
> > > +
> > > +       if (dw9714_dev->vcc) {
> > > +               ret = regulator_disable(dw9714_dev->vcc);
> > > +               if (ret)
> > > +                       dev_err(dev, "Failed to disable vcc: %d\n",
> > > ret);
> > > +       }
> > > +
> > >         return 0;
> > >  }
> > >  
> > > @@ -224,6 +251,18 @@ static int  __maybe_unused
> > > dw9714_vcm_resume(struct device *dev)
> > >         struct dw9714_device *dw9714_dev = sd_to_dw9714_vcm(sd);
> > >         int ret, val;
> > >  
> > > +       if (pm_runtime_suspended(&client->dev))
> > 
> > Same for this one.
> > 
> > > +               return 0;
> > > +
> > > +       if (dw9714_dev->vcc) {
> > > +               ret = regulator_enable(dw9714_dev->vcc);
> > > +               if (ret) {
> > > +                       dev_err(dev, "Failed to enable vcc: %d\n",
> > > ret);
> > > +                       return ret;
> > > +               }
> > > +               usleep_range(1000, 2000);
> > > +       }
> > > +
> > >         for (val = dw9714_dev->current_val % DW9714_CTRL_STEPS;
> > >              val < dw9714_dev->current_val + DW9714_CTRL_STEPS - 1;
> > >              val += DW9714_CTRL_STEPS) {
> > 
> 
> 

-- 
Sakari Ailus
