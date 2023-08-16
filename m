Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B65377EBAD
	for <lists+linux-pm@lfdr.de>; Wed, 16 Aug 2023 23:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346470AbjHPVYP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Aug 2023 17:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346516AbjHPVX7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Aug 2023 17:23:59 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1468A2715
        for <linux-pm@vger.kernel.org>; Wed, 16 Aug 2023 14:23:56 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d62ae3fc7f1so5495967276.2
        for <linux-pm@vger.kernel.org>; Wed, 16 Aug 2023 14:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692221035; x=1692825835;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kn/dW2gjADRkMAXWEOHlhcgyXacpbjUI5D7Piu6MKb8=;
        b=pqUQArodozLMBU3kibz8HlzXV2Vq14BX1+4zKl35oEO21xawr3ZLUum99rkFotGRvp
         fqgcnNksj/tX4lEHT3LCq1f+8K+FVhlMj4SIB1jKx+s40ALjrwC4n/nKsL5HvWH3/ufM
         VlyKi3Y8T6XGGN59RqL8nCXW90+7/OtVeB3XnyuhMgK6m6MUYHEXeyzUKnaPJhO9i6tp
         RmdGAoBKOcHokMoGFr5zjt7QhTdm+OkzJXkFJbdgC4Og2kGXlknLJ1615Lup3hgRrjb5
         Bak2//9W1Ecj2PZ2Xg2Jbl0nQbbceT0QJ6EuU4ojl1DxPB5aZTT6K1IZf1MrurBJLioG
         wtNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692221035; x=1692825835;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kn/dW2gjADRkMAXWEOHlhcgyXacpbjUI5D7Piu6MKb8=;
        b=luu4I1uPzg+WWID6nMm8IwG5GTl1EfZ6WfvCdUpgwNixRBzozgfej6V6JnY1Orve9T
         OSBn5t3vnbhr2QNlOzVC5Cwkdao/QKiowEGQoZIZISS9LFOupmBPW4DDg24jZHMLm8e3
         2HzlBNNXDrEA0hbbk90vY3LrbHZzrUEdnPE3bryMhSJ8DlZeOSvB/6zgv/3qS/5xaCZF
         7+yUWirVRoSCRVYELP+vHhcBaOe2jhT1nPR5eNerr+chVCjqHSASEzgIUn65S+OIsy50
         0KpxV71Y2sAK75s8lJk9cgWJG8EqBo6FUYS7ZH8e8AX6BP0BhK4uaUSEoQWIGKzuMG/U
         EZLg==
X-Gm-Message-State: AOJu0YwKnrBpxsQ0HR1syPtCqgid5YY8etvjal5zJZtglhk2r90MKg5+
        cHIOq2qNg9NIci6AI5/qVI1bxvMDpvMizHmXJ7lE4g==
X-Google-Smtp-Source: AGHT+IEs/O8+aVnBl6tUrBldR+WvjodOGYHAIeYGnweFVvwa4LLtkk+Yw67XTXiP3kSG7mlt6NbXT4Odl42kQaARy/E=
X-Received: by 2002:a25:2d1b:0:b0:d4b:64ac:a4e0 with SMTP id
 t27-20020a252d1b000000b00d4b64aca4e0mr3231751ybt.32.1692221035246; Wed, 16
 Aug 2023 14:23:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230712210505.1536416-1-Frank.Li@nxp.com> <f1d4ed62-8d01-173f-6e41-4671228782fd@linaro.org>
 <ZLGDhOffQwh7xW/n@lizhi-Precision-Tower-5810> <7eacc4da-ab14-3df5-2864-44a7262bac27@linaro.org>
 <ZNz5Drb+EVLjWxRV@lizhi-Precision-Tower-5810> <dd42952c-4dea-ea57-7ad2-73fa159d265d@linaro.org>
 <ZN0CVa9or/FltHJM@lizhi-Precision-Tower-5810> <80324fb7-3d2a-ecd3-f1ca-9745a366eb0a@linaro.org>
In-Reply-To: <80324fb7-3d2a-ecd3-f1ca-9745a366eb0a@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 16 Aug 2023 23:23:17 +0200
Message-ID: <CAPDyKFp8-XwwHEt9dKeTMj0ZmoS6nzXrUYAFmpzZm16-Uf6=xw@mail.gmail.com>
Subject: Re: [PATCH 1/1] thermal/drivers/imx_sc_thermal: return -EAGAIN when
 SCFW turn off resource
To:     Frank Li <frank.li@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 16 Aug 2023 at 22:46, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 16/08/2023 19:07, Frank Li wrote:
> > On Wed, Aug 16, 2023 at 06:47:17PM +0200, Daniel Lezcano wrote:
> >> On 16/08/2023 18:28, Frank Li wrote:
> >>> On Wed, Aug 16, 2023 at 10:44:32AM +0200, Daniel Lezcano wrote:
> >>>>
> >>>> Hi Frank,
> >>>>
> >>>> sorry for the delay
> >>>>
> >>>> On 14/07/2023 19:19, Frank Li wrote:
> >>>>> On Thu, Jul 13, 2023 at 02:49:54PM +0200, Daniel Lezcano wrote:
> >>>>>> On 12/07/2023 23:05, Frank Li wrote:
> >>>>>>> Avoid endless print following message when SCFW turns off resource.
> >>>>>>>      [ 1818.342337] thermal thermal_zone0: failed to read out thermal zone (-1)
> >>>>>>>
> >>>>>>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> >>>>>>> ---
> >>>>>>>      drivers/thermal/imx_sc_thermal.c | 4 +++-
> >>>>>>>      1 file changed, 3 insertions(+), 1 deletion(-)
> >>>>>>>
> >>>>>>> diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
> >>>>>>> index 8d6b4ef23746..0533d58f199f 100644
> >>>>>>> --- a/drivers/thermal/imx_sc_thermal.c
> >>>>>>> +++ b/drivers/thermal/imx_sc_thermal.c
> >>>>>>> @@ -58,7 +58,9 @@ static int imx_sc_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
> >>>>>>>         hdr->size = 2;
> >>>>>>>         ret = imx_scu_call_rpc(thermal_ipc_handle, &msg, true);
> >>>>>>> -       if (ret)
> >>>>>>> +       if (ret == -EPERM) /* NO POWER */
> >>>>>>> +               return -EAGAIN;
> >>>>>>
> >>>>>> Isn't there a chain call somewhere when the resource is turned off, so the
> >>>>>> thermal zone can be disabled?
> >>>>>
> >>>>> A possible place in drivers/firmware/imx/scu-pd.c. but I am not sure how to
> >>>>> get thermal devices. I just found a API thermal_zone_get_zone_by_name(). I
> >>>>> am not sure if it is good to depend on "name", which add coupling between
> >>>>> two drivers and if there are external thermal devices(such as) has the
> >>>>> same name, it will wrong turn off.
> >>>>
> >>>> Correct
> >>>>
> >>>>> If add power domain notification in thermal driver, I am not how to get
> >>>>> other devices's pd in thermal driver.
> >>>>>
> >>>>> Any example I can refer?
> >>>>>
> >>>>> Or this is simple enough solution.
> >>>>
> >>>> The solution works for removing the error message but it does not solve the
> >>>> root cause of the issue. The thermal zone keeps monitoring while the sensor
> >>>> is down.
> >>>>
> >>>> So the question is why the sensor is shut down if it is in use?
> >>>
> >>> Do you know if there are any code I reference? I supposed it is quite common.
> >>
> >> Sorry, I don't get your comment
> >>
> >> What I meant is why is the sensor turned off if it is in use ?
> >
> > One typical example is cpu hotplug. The sensor is located CPU power domain.
> > If CPU hotplug off,  CPU power domain will be turn off.
> >
> > It doesn't make sensor keep monitor such sensor when CPU already power off.
> > It doesn't make sensor to keep CPU power on just because want to get sensor
> > data.
> >
> > Anthor example is GPU, if there are GPU0 and GPU1. Most case just GPU0
> > work.  GPU1 may turn off when less loading.
> >
> > Ideally, thermal can get notification from power domain driver.
> > when such power domain turn off,  disable thermal zone.
> >
> > So far, I have not idea how to do that.
>
> Ulf,
>
> do you have a guidance to link the thermal zone and the power domain in
> order to get a poweron/off notification leading to enable/disable the
> thermal zone ?

I don't know the details here, so apologize for my ignorance to start
with. What platform is this?

A vague idea could be to hook up the thermal sensor to the
corresponding CPU power domain. Assuming the CPU power domain is
modelled as a genpd provider, then this allows the driver for the
thermal sensor to register for power-on/off notifications of the genpd
(see dev_pm_genpd_add_notifier()).

Can this work?

Kind regards
Uffe
