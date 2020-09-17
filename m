Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F1926D9F6
	for <lists+linux-pm@lfdr.de>; Thu, 17 Sep 2020 13:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgIQLSF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Sep 2020 07:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgIQLRA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Sep 2020 07:17:00 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64BCC06174A;
        Thu, 17 Sep 2020 04:15:39 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id s14so2712601pju.1;
        Thu, 17 Sep 2020 04:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding:content-language:thread-index;
        bh=4noCCvhHiWRpb6TjMZphz0uFHYVs2DO7cT34uO/rcGg=;
        b=cG57dsITXmzFEQQeTWICIuup8V6fCYrpMvJBITPzwEqQ538ZWyI7U4VO4+5z+CeldQ
         mWfRi+PxCuYvlNSGfzbH6k94n+NTHU46RXrmZXMtzYl190HPkf+DdDtPK6OWwta2Xpsk
         Xdvh4omCOgh5/KN/KFABIE1oQ1LPlxdF9/MkIWe7MZODEqEwrUHDCktv5iyUWm4929n2
         8qYO1ih466sfAqc5g6qmpopYQAG7KrFAk3bvQVxnMLeC/tRxDrxdIHuVyFggytydQXEa
         M2yKPimRUhoWOI2j6+aTtapxE45dxLRsc5vtJud13gDmLfBG7IQGoiwdP2i0wMgBE9t4
         Ivwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding:content-language:thread-index;
        bh=4noCCvhHiWRpb6TjMZphz0uFHYVs2DO7cT34uO/rcGg=;
        b=V9YzTlO/Gzl7oqqsOwoxGoVZBvIICAyGWDoyQm4Dr9PPp+syXFKc7Dh4tKzwfLK9qU
         qx2k9ccm5f0Zo2vZyHRqcSDbB6bWZFE2tE6xie2b008v0AHokCt5z2E9jshTJs3OIigP
         HOKJ7HRcp1xhNxanC89bUHtRxTSr4BwK+7mRBR5yL1XClGRF1F8A+qqVDYyqm6RLy3xS
         aATc0msyevHT3BnKl2/69wIGK6umuCiAL68pLN3NErRFLFilWiM74wfOg+YvB1hFkOyP
         MAiGjm/iDlI0r0pBD6btVdfKmEwfWrimFKUwoyd+jEenr6aRgPCk+6Y28Dov6cmQWX6i
         +YDg==
X-Gm-Message-State: AOAM5333JIhjXhHvri415j61+EMNa6rlPulrnoyY94uKXt8Yif8tPawQ
        bruL2Lj4i1qQLFlIodgVmfb/HUYA3Gp4ng==
X-Google-Smtp-Source: ABdhPJzFOPuP1BfrSr+OQ4t9dPFBEES+txnxCNpQ+4hbxUbrogVoY7U9il9c0uVVVcMZVsPkP+MBGQ==
X-Received: by 2002:a17:90a:5b04:: with SMTP id o4mr7804325pji.128.1600341339047;
        Thu, 17 Sep 2020 04:15:39 -0700 (PDT)
Received: from DESKTOPIUKEMQD ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id l123sm17296626pgl.24.2020.09.17.04.15.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Sep 2020 04:15:38 -0700 (PDT)
From:   "zhuguangqing83" <zhuguangqing83@gmail.com>
To:     "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
        <amit.kachhap@gmail.com>, <viresh.kumar@linaro.org>,
        <javi.merino@kernel.org>, <rui.zhang@intel.com>,
        <amitk@kernel.org>, <zhuguangqing@xiaomi.com>
Cc:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] thermal/drivers/cpuidle_cooling: Change the set_cur_state function
Date:   Thu, 17 Sep 2020 19:15:32 +0800
Message-ID: <19e301d68ce3$de5f9840$9b1ec8c0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AdaM49uODbRjhj1+TV+U8HtXWehl5A==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


> > From: zhuguangqing <zhuguangqing@xiaomi.com>
> >
> > In the function cpuidle_cooling_set_cur_state(), if current_state is
> > not equal to state and both current_state and state are greater than
> > 0(scene 4 as follows), then maybe it should stop->start or restart
> > idle_inject.
>=20
> Sorry, I don't get it.
>=20
> It is an update of the state, why do we need to restart the idle
> injection ? The state change will be automatically take into account =
by
> the idle injection code at the new injection cycle.
>=20

Thanks for your comments.

For example, we call cpuidle_cooling_set_cur_state() twice, first time
the input parameter state is 20, second time the input parameter state
is 30.

In current code, in the second call of cpuidle_cooling_set_cur_state(),
current_state =3D=3D 20, state =3D=3D 30, then "if (current_state =3D=3D =
0 &&
state > 0)" is not satisfied, "else if (current_state > 0 && !state)"
is not satisfied either, so we just update idle_cdev->state to 30 and
idle_inject_set_duration to new injection cycle=EF=BC=8Cbut we do not =
call
idle injection code.

In the example mentioned above, we should call idle injection code. If
idle_inject_start() takes into account by the idle injection code at
the new injection cycle, then just calling idle_inject_start() is ok.
Otherwise, we need a restart or stop->start process to execute idle
injection code at the new state 30.

> > The scenes changed is as follows,
> >
> > scene    current_state    state    action
> >  1              0          >0       start
> >  2              0          0        do nothing
> >  3              >0         0        stop
> >  4        >0 && !=3Dstate    >0       stop->start or restart
> >  5        >0 && =3D=3Dstate    >0       do nothing
> >
> > Signed-off-by: zhuguangqing <zhuguangqing@xiaomi.com>
> > ---
> >  drivers/thermal/cpuidle_cooling.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/thermal/cpuidle_cooling.c
> b/drivers/thermal/cpuidle_cooling.c
> > index 78e3e8238116..868919ad3dda 100644
> > --- a/drivers/thermal/cpuidle_cooling.c
> > +++ b/drivers/thermal/cpuidle_cooling.c
> > @@ -113,7 +113,7 @@ static int cpuidle_cooling_get_cur_state(struct
> > thermal_cooling_device *cdev,
> >  /**
> >   * cpuidle_cooling_set_cur_state - Set the current cooling state
> >   * @cdev: the thermal cooling device
> > - * @state: the target state
> > + * @state: the target state, max value is 100
> >   *
> >   * The function checks first if we are initiating the mitigation =
which
> >   * in turn wakes up all the idle injection tasks belonging to the =
idle
> > @@ -130,6 +130,9 @@ static int cpuidle_cooling_set_cur_state(struct
> > thermal_cooling_device *cdev,
> >  	unsigned long current_state =3D idle_cdev->state;
> >  	unsigned int runtime_us, idle_duration_us;
> >
> > +	if (state > 100 || current_state =3D=3D state)
> > +		return 0;
> > +
> >  	idle_cdev->state =3D state;
> >
> >  	idle_inject_get_duration(ii_dev, &runtime_us, &idle_duration_us);
> > @@ -140,8 +143,11 @@ static int cpuidle_cooling_set_cur_state(struct
> > thermal_cooling_device *cdev,
> >
> >  	if (current_state =3D=3D 0 && state > 0) {
> >  		idle_inject_start(ii_dev);
> > -	} else if (current_state > 0 && !state)  {
> > +	} else if (current_state > 0 && !state) {
> >  		idle_inject_stop(ii_dev);
> > +	} else {
> > +		idle_inject_stop(ii_dev);
> > +		idle_inject_start(ii_dev);
> >  	}
> >
> >  	return 0;
> >
>=20
>=20
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for =
ARM SoCs
>=20
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog

