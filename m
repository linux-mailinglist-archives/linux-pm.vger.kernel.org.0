Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C722526DC49
	for <lists+linux-pm@lfdr.de>; Thu, 17 Sep 2020 15:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgIQMwz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Sep 2020 08:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbgIQMwp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Sep 2020 08:52:45 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246C6C06174A;
        Thu, 17 Sep 2020 05:52:45 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id q12so1059289plr.12;
        Thu, 17 Sep 2020 05:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding:content-language:thread-index;
        bh=LJ1NxJzh7pPV5ppYGpR1Y1syCcZxD49FHb5l6H+MhPU=;
        b=hDTDG7nnoPUCNmV9yhFnJDJLfQZvHx5zHmmLc17yRun9mZcMCZUryHVH1ARyK0ybeE
         Qgb75+UkBcoHh0EVZpeTdogQYWrUJ+HikFKDTbCUFUuqtTi/v9xAGRv7udbvcle071J5
         77lzfDY022qJZLaaUeFMX54pio3JciwYo2LiGH4mAbU3EhkQBzReGN8Uq0vdzvFw1Gk7
         7YQBMFpLPK805bfuNwSikisQhy599ucwa3yg4dhBVrRWUE7W/k6az/weWc/nxw0QioC8
         63IB7Wvjne300BL8gPFaReWm9EYOV3KTFSZwmI+nOytr+Nh2rdwr+uEGZt7607m7OXwd
         WYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding:content-language:thread-index;
        bh=LJ1NxJzh7pPV5ppYGpR1Y1syCcZxD49FHb5l6H+MhPU=;
        b=pGbaMNeGD7FqYbz9bKJNd3LJ16kijsIsU81XHMp6DW85rXT9qo0YsaU87XZa+FNtPT
         /ZjIt8HsW5q1YvZSplzHd34NA9zFcQ3DzFr2nbmWGkigPtAiZWzoLOzOMJv9sC7EIe8W
         sQ+NMECsJa1ySHKAN4WmD524af+PXzptd4x9lY1wbv+ZUs9GMrpc0DT16vHmtsZGB3XL
         LGyrG/Ovz4bRay+Df7Ikci7TZWqv8peZ5eq3u67ZUOXKqjWEj5VFwYRPWKOwwSTIDRt7
         rEOcTahf4hDtq4ZUtzUIEIKIgvSCVoN2yHtA8aWelua7UEWBGB+VdhC/opjpFdpNwViW
         IfUQ==
X-Gm-Message-State: AOAM5334su9J8rkZ5SOq78DziNM7NEwJvlz+X4eIJVM4v8I4ybx/1Xod
        zskRlK2YPrdLJUvdIoEPh5Y=
X-Google-Smtp-Source: ABdhPJy/P72IzNiIH0AGT2qVQXI824fHhuukU2T/rxyqFRFWL48vm+joRr/+0Y8px+UqtBGkqvipCQ==
X-Received: by 2002:a17:90b:d89:: with SMTP id bg9mr7928146pjb.26.1600347164644;
        Thu, 17 Sep 2020 05:52:44 -0700 (PDT)
Received: from DESKTOPIUKEMQD ([209.9.72.212])
        by smtp.gmail.com with ESMTPSA id g7sm21032792pfr.150.2020.09.17.05.52.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Sep 2020 05:52:44 -0700 (PDT)
From:   "zhuguangqing83" <zhuguangqing83@gmail.com>
To:     "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
        <amit.kachhap@gmail.com>, <viresh.kumar@linaro.org>,
        <javi.merino@kernel.org>, <rui.zhang@intel.com>,
        <amitk@kernel.org>, <zhuguangqing@xiaomi.com>
Cc:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] thermal/drivers/cpuidle_cooling: Change the set_cur_state function
Date:   Thu, 17 Sep 2020 20:52:37 +0800
Message-ID: <1a8601d68cf1$6ea7dc70$4bf79550$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AdaM8RxDFDW73nb5TsGgR07Fcyc++Q==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

>=20
> On 17/09/2020 13:15, zhuguangqing83 wrote:
> >
> >>> From: zhuguangqing <zhuguangqing@xiaomi.com>
> >>>
> >>> In the function cpuidle_cooling_set_cur_state(), if current_state =
is
> >>> not equal to state and both current_state and state are greater =
than
> >>> 0(scene 4 as follows), then maybe it should stop->start or restart
> >>> idle_inject.
> >>
> >> Sorry, I don't get it.
> >>
> >> It is an update of the state, why do we need to restart the idle
> >> injection ? The state change will be automatically take into =
account by
> >> the idle injection code at the new injection cycle.
> >>
> >
> > Thanks for your comments.
> >
> > For example, we call cpuidle_cooling_set_cur_state() twice, first =
time
> > the input parameter state is 20, second time the input parameter =
state
> > is 30.
> >
> > In current code, in the second call of =
cpuidle_cooling_set_cur_state(),
> > current_state =3D=3D 20, state =3D=3D 30, then "if (current_state =
=3D=3D 0 &&
> > state > 0)" is not satisfied, "else if (current_state > 0 && =
!state)"
> > is not satisfied either, so we just update idle_cdev->state to 30 =
and
> > idle_inject_set_duration to new injection cycle=EF=BC=8Cbut we do =
not call
> > idle injection code.
>=20
> Ok, I think understand your question.
>=20
> When the idle injection is started, a timer is periodically calling =
the
> function play_idle_precise() with the idle duration. This one is =
updated
> by idle_inject_set_duration().
>=20
> So when the state is changed, that changes the idle duration. At the
> next timer expiration, a few Milli seconds after, play_idle_precise()
> will be called with the new idle duration which was updated by
> idle_inject_set_duration().
>=20
> There is no need to stop and start the idle injection at each update.
>=20
> The new value is take into account automatically for the next cycle.
>=20
> It does not really matter if the update is delayed. Restarting the =
idle
> injection at each update will be worth in the cooling context than
> waiting an idle cycle.
>=20

Ok, got it. Thanks.

> > In the example mentioned above, we should call idle injection code. =
If
> > idle_inject_start() takes into account by the idle injection code at
> > the new injection cycle, then just calling idle_inject_start() is =
ok.
> > Otherwise, we need a restart or stop->start process to execute idle
> > injection code at the new state 30.
> >
> >>> The scenes changed is as follows,
> >>>
> >>> scene    current_state    state    action
> >>>  1              0          >0       start
> >>>  2              0          0        do nothing
> >>>  3              >0         0        stop
> >>>  4        >0 && !=3Dstate    >0       stop->start or restart
> >>>  5        >0 && =3D=3Dstate    >0       do nothing
> >>>
> >>> Signed-off-by: zhuguangqing <zhuguangqing@xiaomi.com>
> >>> ---
> >>>  drivers/thermal/cpuidle_cooling.c | 10 ++++++++--
> >>>  1 file changed, 8 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/thermal/cpuidle_cooling.c
> >> b/drivers/thermal/cpuidle_cooling.c
> >>> index 78e3e8238116..868919ad3dda 100644
> >>> --- a/drivers/thermal/cpuidle_cooling.c
> >>> +++ b/drivers/thermal/cpuidle_cooling.c
> >>> @@ -113,7 +113,7 @@ static int =
cpuidle_cooling_get_cur_state(struct
> >>> thermal_cooling_device *cdev,
> >>>  /**
> >>>   * cpuidle_cooling_set_cur_state - Set the current cooling state
> >>>   * @cdev: the thermal cooling device
> >>> - * @state: the target state
> >>> + * @state: the target state, max value is 100
> >>>   *
> >>>   * The function checks first if we are initiating the mitigation =
which
> >>>   * in turn wakes up all the idle injection tasks belonging to the =
idle
> >>> @@ -130,6 +130,9 @@ static int =
cpuidle_cooling_set_cur_state(struct
> >>> thermal_cooling_device *cdev,
> >>>  	unsigned long current_state =3D idle_cdev->state;
> >>>  	unsigned int runtime_us, idle_duration_us;
> >>>
> >>> +	if (state > 100 || current_state =3D=3D state)
> >>> +		return 0;
> >>> +
> >>>  	idle_cdev->state =3D state;
> >>>
> >>>  	idle_inject_get_duration(ii_dev, &runtime_us, =
&idle_duration_us);
> >>> @@ -140,8 +143,11 @@ static int =
cpuidle_cooling_set_cur_state(struct
> >>> thermal_cooling_device *cdev,
> >>>
> >>>  	if (current_state =3D=3D 0 && state > 0) {
> >>>  		idle_inject_start(ii_dev);
> >>> -	} else if (current_state > 0 && !state)  {
> >>> +	} else if (current_state > 0 && !state) {
> >>>  		idle_inject_stop(ii_dev);
> >>> +	} else {
> >>> +		idle_inject_stop(ii_dev);
> >>> +		idle_inject_start(ii_dev);
> >>>  	}
> >>>
> >>>  	return 0;
> >>>
> >>
> >>
> >> --
> >> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software =
for ARM SoCs
> >>
> >> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> >> <http://twitter.com/#!/linaroorg> Twitter |
> >> <http://www.linaro.org/linaro-blog/> Blog
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

