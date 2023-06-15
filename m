Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8288731D7B
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jun 2023 18:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjFOQLI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 15 Jun 2023 12:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjFOQLH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Jun 2023 12:11:07 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3F495;
        Thu, 15 Jun 2023 09:11:03 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-97ea801b0d0so133559966b.1;
        Thu, 15 Jun 2023 09:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686845462; x=1689437462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=17Q07DScDYSk0TnR+abR7QoN8/zFNIboEzOvILZpX9s=;
        b=FIpzFC8usm798uso1kgw031HTx0+oiXrpaYNGNbC1DkAsuDwn3+5qhJJOM229JYPMD
         Va/Txo6UXSW0hCD6z0jwssNiqfwHbyYU9GUpfq/5+hcNupxQOK8Lw32QZSIgM3Kl5Kx7
         DcRvNLUNIp/UpMXBAcxhJlb97Oqttiy+7nAMJ4yYFIfOGa029k2cwWH/K7p5KchaGKFS
         4mvFA9lsyL6yTGaI8SpL8BpycbDir1embqMSUihHOo5OtA22mfrQXwpV49xd2kImZ2bO
         UNy8pzmeOtCqEVCZBFslg3hZU+/4EwdKQZ8CGPLfBVyqNOoqKONYajQVDCelk6m++fBe
         QUiA==
X-Gm-Message-State: AC+VfDyVDNTtzjR6I8JjvrhRKGuyD3m7RMGulMy+Jw8DYAu3rxcDXg8D
        bVCTPzAK3ksJDXNuxQybzRDc5yu5UL4i2uCw2G0=
X-Google-Smtp-Source: ACHHUZ5Yq07be2+TJSAlRzg9pl/FyiUBFLw5Xp00LNQb5ZdSYUJ4iRXgTWeiUvZm9/5yHl+lUeeWjpRNuLt8PECHJn8=
X-Received: by 2002:a17:906:7a03:b0:977:cbc4:5d8 with SMTP id
 d3-20020a1709067a0300b00977cbc405d8mr15565590ejo.4.1686845461569; Thu, 15 Jun
 2023 09:11:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230614100756.437606-1-hdegoede@redhat.com> <5e2a0ed13daff9b73f0754ea947bd832b3503cdb.camel@intel.com>
In-Reply-To: <5e2a0ed13daff9b73f0754ea947bd832b3503cdb.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 15 Jun 2023 18:10:50 +0200
Message-ID: <CAJZ5v0i77U-a1fkOMf-N2zq9eG4HasP7BTc6ka-HqLeHkjkDpQ@mail.gmail.com>
Subject: Re: [PATCH] thermal/intel/intel_soc_dts_iosf: Fix reporting wrong temperatures
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "b.krug@elektronenpumpe.de" <b.krug@elektronenpumpe.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 15, 2023 at 4:35 AM Zhang, Rui <rui.zhang@intel.com> wrote:
>
> On Wed, 2023-06-14 at 12:07 +0200, Hans de Goede wrote:
> > Since commit 955fb8719efb ("thermal/intel/intel_soc_dts_iosf: Use
> > Intel
> > TCC library") intel_soc_dts_iosf is reporting the wrong temperature.
> >
> > The driver expects tj_max to be in milli-degrees-celcius but after
> > the switch to the TCC library this is now in degrees celcius so
> > instead of e.g. 90000 it is set to 90 causing a temperature 45
> > degrees below tj_max to be reported as -44910 milli-degrees
> > instead of as 45000 milli-degrees.
> >
> > Fix this by adding back the lost factor of 1000.
> >
> > Fixes: 955fb8719efb ("thermal/intel/intel_soc_dts_iosf: Use Intel TCC
> > library")
> > Reported-by: Bernhard Krug <b.krug@elektronenpumpe.de>
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>
> Acked-by: Zhang Rui <rui.zhang@intel.com>

Applied as 6.4-rc material, thanks!

> > ---
> > Note reported by private email, so no Closes: tag
> > ---
> >  drivers/thermal/intel/intel_soc_dts_iosf.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/thermal/intel/intel_soc_dts_iosf.c
> > b/drivers/thermal/intel/intel_soc_dts_iosf.c
> > index f99dc7e4ae89..db97499f4f0a 100644
> > --- a/drivers/thermal/intel/intel_soc_dts_iosf.c
> > +++ b/drivers/thermal/intel/intel_soc_dts_iosf.c
> > @@ -398,7 +398,7 @@ struct intel_soc_dts_sensors
> > *intel_soc_dts_iosf_init(
> >         spin_lock_init(&sensors->intr_notify_lock);
> >         mutex_init(&sensors->dts_update_lock);
> >         sensors->intr_type = intr_type;
> > -       sensors->tj_max = tj_max;
> > +       sensors->tj_max = tj_max * 1000;
> >         if (intr_type == INTEL_SOC_DTS_INTERRUPT_NONE)
> >                 notification = false;
> >         else
>
