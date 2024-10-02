Return-Path: <linux-pm+bounces-15065-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7991F98D3B4
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 14:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97F1D1C20D1B
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 12:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2969F1CFED4;
	Wed,  2 Oct 2024 12:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHIgr/07"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04398184
	for <linux-pm@vger.kernel.org>; Wed,  2 Oct 2024 12:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727873615; cv=none; b=EOnDRP3t9+15/keersiSuOGL8/OCAOHh99ecO/MmknxDT6s8YxYIOhCBGRYfQa3TXJ6Aw5/FpXmb0578v00TXSDkJzWSZ9kv5OI+N3Hy7vj1dW1JfGz1gbHjU3EJblKEi6a/g9MEWGVQdKOfViDeHLGOaBp2hLijFoN0/We4kTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727873615; c=relaxed/simple;
	bh=SszJKMyMIEvI2qzPf9XaCvwtY9BJc0yi/XGI5ebmBUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jpMraO6P2yOgMt3Dl+pvFHSfO8nQnHvTJloTafWlKAFB1co7rY4VKJ8gyhyCygz31Y/oxMof+mmb3ZMjBHuLeP6PW01z7KTf2YpdOtkhgssi8LtgFW68kRb+8I/LlY6z3osIL/lGpOdK2iDWsU8Yx8c3sZPbQ4Dk30VeAwAPEp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rHIgr/07; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9064DC4CECE
	for <linux-pm@vger.kernel.org>; Wed,  2 Oct 2024 12:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727873613;
	bh=SszJKMyMIEvI2qzPf9XaCvwtY9BJc0yi/XGI5ebmBUE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rHIgr/079NBQSmpfsztESu/jetMRtTbqMKF9YbEtaA2uFAdGCzufaetD7QRgXjNig
	 hr9UsHRrxz5YmmPW/jK0cgUHd+Rkx5Ue/P2A0ollrU2rj0v3jnrruF0OjQt8Wq+P6g
	 jwx7QeCmXtmpWmsjMk7IDwrtSFhz3Zhz/5pvRycHr+IvCDnJpb4gagisqb0ayW/Usz
	 cgrecJh+e7j5GyS2eAPo6lB+QJbZ9g3PT4ohErHDHnOGuSCMaynku4gyyS4P9IX1ym
	 +vEfxbNv1Ht5WK8Z3lc0bdr2CJ4trvrvT9lWEjns3KOdTQv8spsw47+7hfk7G2wDTU
	 5I3VsGw1C89Jw==
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e109539aedso3117148a91.0
        for <linux-pm@vger.kernel.org>; Wed, 02 Oct 2024 05:53:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWNifjQsago4PpMl0/qny1+XGRhlF33DJrDi5l7lReN9fCiklVTWOaaP2geDyjp2s6o3um6qM+tQA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq09YwzTjOiM2GilbhsO4RaDuBiA77Zbx4YOMC7e5BpIGZ67md
	SoPc150Ovz423W1Q0feB4Bk3eTl5a7kmt+MfthaQj8T3PBfcPN9e5mmbkTi2TRQnxah0RysYrLA
	z/y2rsc58B114LDXhoXu+hFNIhGs=
X-Google-Smtp-Source: AGHT+IFMiWraPf03xlivVSd+e51izbCxxQtSSLll+qxMri7iGCgk6RTfYDmu+J4iznH4TwOmfFnPqpOp7fjdTkP5tpk=
X-Received: by 2002:a17:90a:f40d:b0:2e0:a931:cb11 with SMTP id
 98e67ed59e1d1-2e18454bfafmr4064018a91.4.1727873612927; Wed, 02 Oct 2024
 05:53:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923100005.2532430-1-daniel.lezcano@linaro.org> <20240923100005.2532430-4-daniel.lezcano@linaro.org>
In-Reply-To: <20240923100005.2532430-4-daniel.lezcano@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 2 Oct 2024 14:53:18 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gpHpH70YTRpNgPiAtCpkRS6i4h_YS4-a3HL8qLkk9zZg@mail.gmail.com>
Message-ID: <CAJZ5v0gpHpH70YTRpNgPiAtCpkRS6i4h_YS4-a3HL8qLkk9zZg@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] thermal/netlink: Add the commands and the events
 for the thresholds
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, lukasz.luba@arm.com, 
	quic_manafm@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 12:00=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The thresholds exist but there is no notification neither action code
> related to them yet.
>
> These changes implement the netlink for the notifications when the
> thresholds are crossed, added, deleted or flushed as well as the
> commands which allows to get the list of the thresholds, flush them,
> add and delete.

The last three commands need special privileges I would think because
they essentially cause the kernel to either allocate or free memory
and they may interfere with what the other processes in user space do.
For instance, one process may flush the thresholds for a given thermal
zone while another process is using them.

What controls the level of privilege required to use these commands?

> As different processes in userspace can interact with the thresholds,
> the process id responsible of the action (add, delete or flush) will
> be added in the notification.

This may leak PIDs between containers which has been pointed out as an
issue (for example, see
https://lore.kernel.org/linux-pm/20240704-umsatz-drollig-38db6b84da7b@braun=
er/).

OTOH, the thermal engine should not need the extra information because
it knows which thresholds were added by it, so any other thresholds
would be added by someone else, wouldn't they?

> This way a thermal engine is able to
> detect if another process is interfering with the thresholds. A
> process id of zero is the kernel as it is by convention usually.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/thermal_netlink.c    | 239 ++++++++++++++++++++++++++-
>  drivers/thermal/thermal_netlink.h    |  34 ++++
>  drivers/thermal/thermal_thresholds.c |  38 +++--
>  drivers/thermal/thermal_thresholds.h |   6 +-
>  include/uapi/linux/thermal.h         |  28 +++-
>  5 files changed, 313 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/thermal/thermal_netlink.c b/drivers/thermal/thermal_=
netlink.c
> index 97157c453630..8d92ebeb72fc 100644
> --- a/drivers/thermal/thermal_netlink.c
> +++ b/drivers/thermal/thermal_netlink.c
> @@ -9,6 +9,7 @@
>  #include <linux/module.h>
>  #include <linux/notifier.h>
>  #include <linux/kernel.h>
> +#include <net/sock.h>
>  #include <net/genetlink.h>
>  #include <uapi/linux/thermal.h>
>
> @@ -49,12 +50,19 @@ static const struct nla_policy thermal_genl_policy[TH=
ERMAL_GENL_ATTR_MAX + 1] =3D
>         [THERMAL_GENL_ATTR_CPU_CAPABILITY_ID]           =3D { .type =3D N=
LA_U32 },
>         [THERMAL_GENL_ATTR_CPU_CAPABILITY_PERFORMANCE]  =3D { .type =3D N=
LA_U32 },
>         [THERMAL_GENL_ATTR_CPU_CAPABILITY_EFFICIENCY]   =3D { .type =3D N=
LA_U32 },
> +
> +       /* Thresholds */
> +       [THERMAL_GENL_ATTR_THRESHOLD]           =3D { .type =3D NLA_NESTE=
D },
> +       [THERMAL_GENL_ATTR_THRESHOLD_TEMP]      =3D { .type =3D NLA_U32 }=
,
> +       [THERMAL_GENL_ATTR_THRESHOLD_WAY]       =3D { .type =3D NLA_U32 }=
,

It would be better to call this THERMAL_GENL_ATTR_THRESHOLD_DIR IMV.

> +       [THERMAL_GENL_ATTR_THRESHOLD_PID]       =3D { .type =3D NLA_U32 }=
,
>  };
>
>  struct param {
>         struct nlattr **attrs;
>         struct sk_buff *msg;
>         const char *name;
> +       pid_t pid;

I'd rather not add it as mentioned above.

>         int tz_id;
>         int cdev_id;
>         int trip_id;
> @@ -62,6 +70,8 @@ struct param {
>         int trip_type;
>         int trip_hyst;
>         int temp;
> +       int last_temp;

Or prev_temp?  It should be less ambiguous than last_temp.

> +       int direction;
>         int cdev_state;
>         int cdev_max_state;
>         struct thermal_genl_cpu_caps *cpu_capabilities;
> @@ -234,6 +244,36 @@ static int thermal_genl_event_cpu_capability_change(=
struct param *p)
>         return -EMSGSIZE;
>  }
>
> +static int thermal_genl_event_threshold_add(struct param *p)
> +{
> +       if (nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_ID, p->tz_id) ||
> +           nla_put_u32(p->msg, THERMAL_GENL_ATTR_THRESHOLD_TEMP, p->temp=
) ||
> +           nla_put_u32(p->msg, THERMAL_GENL_ATTR_THRESHOLD_WAY, p->direc=
tion) ||
> +           nla_put_u32(p->msg, THERMAL_GENL_ATTR_THRESHOLD_PID, p->pid))
> +               return -EMSGSIZE;
> +
> +       return 0;
> +}
> +
> +static int thermal_genl_event_threshold_flush(struct param *p)
> +{
> +       if (nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_ID, p->tz_id),
> +           nla_put_u32(p->msg, THERMAL_GENL_ATTR_THRESHOLD_PID, p->pid))
> +               return -EMSGSIZE;
> +
> +       return 0;
> +}
> +
> +static int thermal_genl_event_threshold_up(struct param *p)
> +{
> +       if (nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_ID, p->tz_id) ||
> +           nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_LAST_TEMP, p->last_t=
emp) ||
> +           nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_TEMP, p->temp))
> +               return -EMSGSIZE;
> +
> +       return 0;
> +}
> +
>  int thermal_genl_event_tz_delete(struct param *p)
>         __attribute__((alias("thermal_genl_event_tz")));
>
> @@ -246,6 +286,12 @@ int thermal_genl_event_tz_disable(struct param *p)
>  int thermal_genl_event_tz_trip_down(struct param *p)
>         __attribute__((alias("thermal_genl_event_tz_trip_up")));
>
> +int thermal_genl_event_threshold_delete(struct param *p)
> +       __attribute__((alias("thermal_genl_event_threshold_add")));
> +
> +int thermal_genl_event_threshold_down(struct param *p)
> +       __attribute__((alias("thermal_genl_event_threshold_up")));
> +
>  static cb_t event_cb[] =3D {
>         [THERMAL_GENL_EVENT_TZ_CREATE]          =3D thermal_genl_event_tz=
_create,
>         [THERMAL_GENL_EVENT_TZ_DELETE]          =3D thermal_genl_event_tz=
_delete,
> @@ -259,6 +305,11 @@ static cb_t event_cb[] =3D {
>         [THERMAL_GENL_EVENT_CDEV_STATE_UPDATE]  =3D thermal_genl_event_cd=
ev_state_update,
>         [THERMAL_GENL_EVENT_TZ_GOV_CHANGE]      =3D thermal_genl_event_go=
v_change,
>         [THERMAL_GENL_EVENT_CPU_CAPABILITY_CHANGE] =3D thermal_genl_event=
_cpu_capability_change,
> +       [THERMAL_GENL_EVENT_THRESHOLD_ADD]      =3D thermal_genl_event_th=
reshold_add,
> +       [THERMAL_GENL_EVENT_THRESHOLD_DELETE]   =3D thermal_genl_event_th=
reshold_delete,
> +       [THERMAL_GENL_EVENT_THRESHOLD_FLUSH]    =3D thermal_genl_event_th=
reshold_flush,
> +       [THERMAL_GENL_EVENT_THRESHOLD_DOWN]     =3D thermal_genl_event_th=
reshold_down,
> +       [THERMAL_GENL_EVENT_THRESHOLD_UP]       =3D thermal_genl_event_th=
reshold_up,
>  };
>
>  /*
> @@ -401,6 +452,43 @@ int thermal_genl_cpu_capability_event(int count,
>  }
>  EXPORT_SYMBOL_GPL(thermal_genl_cpu_capability_event);
>
> +int thermal_notify_threshold_add(const struct thermal_zone_device *tz,
> +                                int temperature, int direction, int pid)
> +{
> +       struct param p =3D { .tz_id =3D tz->id, .temp =3D temperature, .d=
irection =3D direction, .pid =3D pid };
> +
> +       return thermal_genl_send_event(THERMAL_GENL_EVENT_THRESHOLD_ADD, =
&p);
> +}
> +
> +int thermal_notify_threshold_delete(const struct thermal_zone_device *tz=
,
> +                                   int temperature, int direction, int p=
id)
> +{
> +       struct param p =3D { .tz_id =3D tz->id, .temp =3D temperature, .d=
irection =3D direction, .pid =3D pid };
> +
> +       return thermal_genl_send_event(THERMAL_GENL_EVENT_THRESHOLD_DELET=
E, &p);
> +}
> +
> +int thermal_notify_threshold_flush(const struct thermal_zone_device *tz,=
 int pid)
> +{
> +       struct param p =3D { .tz_id =3D tz->id, .pid =3D pid };
> +
> +       return thermal_genl_send_event(THERMAL_GENL_EVENT_THRESHOLD_FLUSH=
, &p);
> +}
> +
> +int thermal_notify_threshold_down(const struct thermal_zone_device *tz)
> +{
> +       struct param p =3D { .tz_id =3D tz->id, .temp =3D tz->temperature=
, .last_temp =3D tz->last_temperature };
> +
> +       return thermal_genl_send_event(THERMAL_GENL_EVENT_THRESHOLD_DOWN,=
 &p);
> +}
> +
> +int thermal_notify_threshold_up(const struct thermal_zone_device *tz)
> +{
> +       struct param p =3D { .tz_id =3D tz->id, .temp =3D tz->temperature=
, .last_temp =3D tz->last_temperature };
> +
> +       return thermal_genl_send_event(THERMAL_GENL_EVENT_THRESHOLD_UP, &=
p);
> +}
> +
>  /*************************** Command encoding **************************=
******/
>
>  static int __thermal_genl_cmd_tz_get_id(struct thermal_zone_device *tz,
> @@ -575,12 +663,130 @@ static int thermal_genl_cmd_cdev_get(struct param =
*p)
>         return ret;
>  }
>
> +static int __thermal_genl_cmd_threshold_get(struct user_threshold *thres=
hold, void *arg)
> +{
> +       struct sk_buff *msg =3D arg;
> +
> +       if (nla_put_u32(msg, THERMAL_GENL_ATTR_THRESHOLD_TEMP, threshold-=
>temperature) ||
> +           nla_put_u32(msg, THERMAL_GENL_ATTR_THRESHOLD_WAY, threshold->=
direction))
> +               return -1;
> +
> +       return 0;
> +}
> +
> +static int thermal_genl_cmd_threshold_get(struct param *p)
> +{
> +       struct thermal_zone_device *tz;
> +       struct sk_buff *msg =3D p->msg;
> +       struct nlattr *start_trip;
> +       int id, ret;
> +
> +       if (!p->attrs[THERMAL_GENL_ATTR_TZ_ID])
> +               return -EINVAL;
> +
> +       id =3D nla_get_u32(p->attrs[THERMAL_GENL_ATTR_TZ_ID]);
> +
> +       tz =3D thermal_zone_get_by_id(id);
> +       if (!tz)
> +               return -EINVAL;

What prevents the thermal zone from going away right here?

It looks like thermal_zone_get_by_id() should do a get_device() on the
thermal zone object it is about to return and then the caller should
do a put_device() on it.

Granted, this problem is present already in the thermal netlink code,
so it needs to be fixed (I'm going to send a patch to address it) and
this patch will need to be adjusted.

> +
> +       start_trip =3D nla_nest_start(msg, THERMAL_GENL_ATTR_THRESHOLD);
> +       if (!start_trip)
> +               return -EMSGSIZE;
> +
> +       mutex_lock(&tz->lock);
> +       ret =3D thermal_thresholds_for_each(tz, __thermal_genl_cmd_thresh=
old_get, msg);
> +       mutex_unlock(&tz->lock);

I think that the locking can be moved to
thermal_thresholds_for_each().  At least there are no other callers of
it AFAICS.

> +
> +       if (ret)
> +               return -EMSGSIZE;
> +
> +       nla_nest_end(msg, start_trip);
> +
> +       return 0;
> +}
> +
> +static int thermal_genl_cmd_threshold_add(struct param *p)
> +{
> +       struct thermal_zone_device *tz;
> +       int id, temp, direction, ret =3D 0;
> +
> +       if (!p->attrs[THERMAL_GENL_ATTR_TZ_ID] ||
> +           !p->attrs[THERMAL_GENL_ATTR_THRESHOLD_TEMP] ||
> +           !p->attrs[THERMAL_GENL_ATTR_THRESHOLD_WAY])
> +               return -EINVAL;
> +
> +       id =3D nla_get_u32(p->attrs[THERMAL_GENL_ATTR_TZ_ID]);
> +       temp =3D nla_get_u32(p->attrs[THERMAL_GENL_ATTR_THRESHOLD_TEMP]);
> +       direction =3D nla_get_u32(p->attrs[THERMAL_GENL_ATTR_THRESHOLD_WA=
Y]);
> +
> +       tz =3D thermal_zone_get_by_id(id);
> +       if (!tz)
> +               return -EINVAL;
> +
> +       mutex_lock(&tz->lock);
> +       ret =3D thermal_thresholds_add(tz, temp, direction, p->pid);
> +       mutex_unlock(&tz->lock);
> +
> +       return ret;
> +}
> +
> +static int thermal_genl_cmd_threshold_delete(struct param *p)
> +{
> +       struct thermal_zone_device *tz;
> +       int id, temp, direction, ret =3D 0;
> +
> +       if (!p->attrs[THERMAL_GENL_ATTR_TZ_ID] ||
> +           !p->attrs[THERMAL_GENL_ATTR_THRESHOLD_TEMP] ||
> +           !p->attrs[THERMAL_GENL_ATTR_THRESHOLD_WAY])
> +               return -EINVAL;
> +
> +       id =3D nla_get_u32(p->attrs[THERMAL_GENL_ATTR_TZ_ID]);
> +       temp =3D nla_get_u32(p->attrs[THERMAL_GENL_ATTR_THRESHOLD_TEMP]);
> +       direction =3D nla_get_u32(p->attrs[THERMAL_GENL_ATTR_THRESHOLD_WA=
Y]);
> +
> +       tz =3D thermal_zone_get_by_id(id);
> +       if (!tz)
> +               return -EINVAL;
> +
> +       mutex_lock(&tz->lock);
> +       ret =3D thermal_thresholds_delete(tz, temp, direction, p->pid);
> +       mutex_unlock(&tz->lock);
> +
> +       return ret;
> +}
> +
> +static int thermal_genl_cmd_threshold_flush(struct param *p)
> +{
> +       struct thermal_zone_device *tz;
> +       int id;
> +
> +       if (!p->attrs[THERMAL_GENL_ATTR_TZ_ID])
> +               return -EINVAL;
> +
> +       id =3D nla_get_u32(p->attrs[THERMAL_GENL_ATTR_TZ_ID]);
> +
> +       tz =3D thermal_zone_get_by_id(id);
> +       if (!tz)
> +               return -EINVAL;
> +
> +       mutex_lock(&tz->lock);
> +       thermal_thresholds_flush(tz, p->pid);
> +       mutex_unlock(&tz->lock);
> +
> +       return 0;
> +}
> +
>  static cb_t cmd_cb[] =3D {
> -       [THERMAL_GENL_CMD_TZ_GET_ID]    =3D thermal_genl_cmd_tz_get_id,
> -       [THERMAL_GENL_CMD_TZ_GET_TRIP]  =3D thermal_genl_cmd_tz_get_trip,
> -       [THERMAL_GENL_CMD_TZ_GET_TEMP]  =3D thermal_genl_cmd_tz_get_temp,
> -       [THERMAL_GENL_CMD_TZ_GET_GOV]   =3D thermal_genl_cmd_tz_get_gov,
> -       [THERMAL_GENL_CMD_CDEV_GET]     =3D thermal_genl_cmd_cdev_get,
> +       [THERMAL_GENL_CMD_TZ_GET_ID]            =3D thermal_genl_cmd_tz_g=
et_id,
> +       [THERMAL_GENL_CMD_TZ_GET_TRIP]          =3D thermal_genl_cmd_tz_g=
et_trip,
> +       [THERMAL_GENL_CMD_TZ_GET_TEMP]          =3D thermal_genl_cmd_tz_g=
et_temp,
> +       [THERMAL_GENL_CMD_TZ_GET_GOV]           =3D thermal_genl_cmd_tz_g=
et_gov,
> +       [THERMAL_GENL_CMD_CDEV_GET]             =3D thermal_genl_cmd_cdev=
_get,
> +       [THERMAL_GENL_CMD_THRESHOLD_GET]        =3D thermal_genl_cmd_thre=
shold_get,
> +       [THERMAL_GENL_CMD_THRESHOLD_ADD]        =3D thermal_genl_cmd_thre=
shold_add,
> +       [THERMAL_GENL_CMD_THRESHOLD_DELETE]     =3D thermal_genl_cmd_thre=
shold_delete,
> +       [THERMAL_GENL_CMD_THRESHOLD_FLUSH]      =3D thermal_genl_cmd_thre=
shold_flush,
>  };
>
>  static int thermal_genl_cmd_dumpit(struct sk_buff *skb,
> @@ -623,6 +829,7 @@ static int thermal_genl_cmd_doit(struct sk_buff *skb,
>         if (!msg)
>                 return -ENOMEM;
>         p.msg =3D msg;
> +       p.pid =3D task_tgid_vnr(current);
>
>         hdr =3D genlmsg_put_reply(msg, info, &thermal_genl_family, 0, cmd=
);
>         if (!hdr)
> @@ -691,6 +898,26 @@ static const struct genl_small_ops thermal_genl_ops[=
] =3D {
>                 .validate =3D GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALID=
ATE_DUMP,
>                 .dumpit =3D thermal_genl_cmd_dumpit,
>         },
> +       {
> +               .cmd =3D THERMAL_GENL_CMD_THRESHOLD_GET,
> +               .validate =3D GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALID=
ATE_DUMP,
> +               .doit =3D thermal_genl_cmd_doit,
> +       },
> +       {
> +               .cmd =3D THERMAL_GENL_CMD_THRESHOLD_ADD,
> +               .validate =3D GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALID=
ATE_DUMP,
> +               .doit =3D thermal_genl_cmd_doit,
> +       },
> +       {
> +               .cmd =3D THERMAL_GENL_CMD_THRESHOLD_DELETE,
> +               .validate =3D GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALID=
ATE_DUMP,
> +               .doit =3D thermal_genl_cmd_doit,
> +       },
> +       {
> +               .cmd =3D THERMAL_GENL_CMD_THRESHOLD_FLUSH,
> +               .validate =3D GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALID=
ATE_DUMP,
> +               .doit =3D thermal_genl_cmd_doit,
> +       },
>  };
>
>  static struct genl_family thermal_genl_family __ro_after_init =3D {
> @@ -703,7 +930,7 @@ static struct genl_family thermal_genl_family __ro_af=
ter_init =3D {
>         .unbind         =3D thermal_genl_unbind,
>         .small_ops      =3D thermal_genl_ops,
>         .n_small_ops    =3D ARRAY_SIZE(thermal_genl_ops),
> -       .resv_start_op  =3D THERMAL_GENL_CMD_CDEV_GET + 1,
> +       .resv_start_op  =3D __THERMAL_GENL_CMD_MAX,
>         .mcgrps         =3D thermal_genl_mcgrps,
>         .n_mcgrps       =3D ARRAY_SIZE(thermal_genl_mcgrps),
>  };
> diff --git a/drivers/thermal/thermal_netlink.h b/drivers/thermal/thermal_=
netlink.h
> index e01221e8816b..3f85c636029c 100644
> --- a/drivers/thermal/thermal_netlink.h
> +++ b/drivers/thermal/thermal_netlink.h
> @@ -53,6 +53,13 @@ int thermal_notify_tz_gov_change(const struct thermal_=
zone_device *tz,
>  int thermal_genl_sampling_temp(int id, int temp);
>  int thermal_genl_cpu_capability_event(int count,
>                                       struct thermal_genl_cpu_caps *caps)=
;
> +int thermal_notify_threshold_add(const struct thermal_zone_device *tz,
> +                                int temperature, int direction, pid_t pi=
d);
> +int thermal_notify_threshold_delete(const struct thermal_zone_device *tz=
,
> +                                   int temperature, int direction, pid_t=
 pid);
> +int thermal_notify_threshold_flush(const struct thermal_zone_device *tz,=
 pid_t pid);
> +int thermal_notify_threshold_down(const struct thermal_zone_device *tz);
> +int thermal_notify_threshold_up(const struct thermal_zone_device *tz);
>  #else
>  static inline int thermal_netlink_init(void)
>  {
> @@ -139,6 +146,33 @@ static inline int thermal_genl_cpu_capability_event(=
int count, struct thermal_ge
>         return 0;
>  }
>
> +static inline int thermal_notify_threshold_add(const struct thermal_zone=
_device *tz,
> +                                              int temperature, int direc=
tion, pid_t pid)
> +{
> +       return 0;
> +}
> +
> +static inline int thermal_notify_threshold_delete(const struct thermal_z=
one_device *tz,
> +                                                 int temperature, int di=
rection, pid_t pid)
> +{
> +       return 0;
> +}
> +
> +static inline int thermal_notify_threshold_flush(const struct thermal_zo=
ne_device *tz, pid_t pid)
> +{
> +       return 0;
> +}
> +
> +static inline int thermal_notify_threshold_down(const struct thermal_zon=
e_device *tz)
> +{
> +       return 0;
> +}
> +
> +static inline int thermal_notify_threshold_up(const struct thermal_zone_=
device *tz)
> +{
> +       return 0;
> +}
> +
>  static inline void __init thermal_netlink_exit(void) {}
>
>  #endif /* CONFIG_THERMAL_NETLINK */
> diff --git a/drivers/thermal/thermal_thresholds.c b/drivers/thermal/therm=
al_thresholds.c
> index f33b6d5474d8..6d9a0cf8031f 100644
> --- a/drivers/thermal/thermal_thresholds.c
> +++ b/drivers/thermal/thermal_thresholds.c
> @@ -20,7 +20,7 @@ int thermal_thresholds_init(struct thermal_zone_device =
*tz)
>         return 0;
>  }
>
> -void thermal_thresholds_flush(struct thermal_zone_device *tz)
> +void thermal_thresholds_flush(struct thermal_zone_device *tz, pid_t pid)
>  {
>         struct list_head *thresholds =3D &tz->user_thresholds;
>         struct user_threshold *entry, *tmp;
> @@ -32,12 +32,14 @@ void thermal_thresholds_flush(struct thermal_zone_dev=
ice *tz)
>                 kfree(entry);
>         }
>
> +       thermal_notify_threshold_flush(tz, pid);
> +
>         __thermal_zone_device_update(tz, THERMAL_TZ_FLUSH_THRESHOLDS);
>  }
>
>  void thermal_thresholds_exit(struct thermal_zone_device *tz)
>  {
> -       thermal_thresholds_flush(tz);
> +       thermal_thresholds_flush(tz, 0);
>  }
>
>  static int __thermal_thresholds_cmp(void *data,
> @@ -122,7 +124,6 @@ void thermal_thresholds_handle(struct thermal_zone_de=
vice *tz, int *low, int *hi
>
>         int temperature =3D tz->temperature;
>         int last_temperature =3D tz->last_temperature;
> -       bool notify;
>
>         lockdep_assert_held(&tz->lock);
>
> @@ -144,19 +145,19 @@ void thermal_thresholds_handle(struct thermal_zone_=
device *tz, int *low, int *hi
>          * - increased : thresholds are crossed the way up
>          * - decreased : thresholds are crossed the way down
>          */
> -       if (temperature > last_temperature)
> -               notify =3D thermal_thresholds_handle_raising(thresholds, =
temperature,
> -                                                          last_temperatu=
re, low, high);
> -       else
> -               notify =3D thermal_thresholds_handle_dropping(thresholds,=
 temperature,
> -                                                           last_temperat=
ure, low, high);
> -
> -       if (notify)
> -               pr_debug("A threshold has been crossed the way %s, with a=
 temperature=3D%d, last_temperature=3D%d\n",
> -                        temperature > last_temperature ? "up" : "down", =
temperature, last_temperature);
> +       if (temperature > last_temperature) {
> +               if (thermal_thresholds_handle_raising(thresholds, tempera=
ture,
> +                                                     last_temperature, l=
ow, high))
> +                       thermal_notify_threshold_up(tz);
> +       } else {
> +               if (thermal_thresholds_handle_dropping(thresholds, temper=
ature,
> +                                                      last_temperature, =
low, high))
> +                       thermal_notify_threshold_down(tz);
> +       }
>  }
>
> -int thermal_thresholds_add(struct thermal_zone_device *tz, int temperatu=
re, int direction)
> +int thermal_thresholds_add(struct thermal_zone_device *tz,
> +                          int temperature, int direction, pid_t pid)
>  {
>         struct list_head *thresholds =3D &tz->user_thresholds;
>         struct user_threshold *t;
> @@ -182,12 +183,15 @@ int thermal_thresholds_add(struct thermal_zone_devi=
ce *tz, int temperature, int
>                 list_sort(NULL, thresholds, __thermal_thresholds_cmp);
>         }
>
> +       thermal_notify_threshold_add(tz, temperature, direction, pid);
> +
>         __thermal_zone_device_update(tz, THERMAL_TZ_ADD_THRESHOLD);
>
>         return 0;
>  }
>
> -int thermal_thresholds_delete(struct thermal_zone_device *tz, int temper=
ature, int direction)
> +int thermal_thresholds_delete(struct thermal_zone_device *tz,
> +                             int temperature, int direction, pid_t pid)
>  {
>         struct list_head *thresholds =3D &tz->user_thresholds;
>         struct user_threshold *t;
> @@ -205,8 +209,10 @@ int thermal_thresholds_delete(struct thermal_zone_de=
vice *tz, int temperature, i
>                 t->direction &=3D ~direction;
>         }
>
> -       __thermal_zone_device_update(tz, THERMAL_TZ_DEL_THRESHOLD);
> +       thermal_notify_threshold_delete(tz, temperature, direction, pid);
>
> +       __thermal_zone_device_update(tz, THERMAL_TZ_DEL_THRESHOLD);
> +
>         return 0;
>  }
>
> diff --git a/drivers/thermal/thermal_thresholds.h b/drivers/thermal/therm=
al_thresholds.h
> index 232f4e8089af..f97ffb715d2e 100644
> --- a/drivers/thermal/thermal_thresholds.h
> +++ b/drivers/thermal/thermal_thresholds.h
> @@ -10,10 +10,10 @@ struct user_threshold {
>
>  int thermal_thresholds_init(struct thermal_zone_device *tz);
>  void thermal_thresholds_exit(struct thermal_zone_device *tz);
> -void thermal_thresholds_flush(struct thermal_zone_device *tz);
>  void thermal_thresholds_handle(struct thermal_zone_device *tz, int *low,=
 int *high);
> -int thermal_thresholds_add(struct thermal_zone_device *tz, int temperatu=
re, int direction);
> -int thermal_thresholds_delete(struct thermal_zone_device *tz, int temper=
ature, int direction);
> +void thermal_thresholds_flush(struct thermal_zone_device *tz, pid_t pid)=
;
> +int thermal_thresholds_add(struct thermal_zone_device *tz, int temperatu=
re, int direction, pid_t pid);
> +int thermal_thresholds_delete(struct thermal_zone_device *tz, int temper=
ature, int direction, pid_t pid);
>  int thermal_thresholds_for_each(struct thermal_zone_device *tz,
>                                 int (*cb)(struct user_threshold *, void *=
arg), void *arg);
>  #endif
> diff --git a/include/uapi/linux/thermal.h b/include/uapi/linux/thermal.h
> index 3e7c1c2e71a7..bcbaf62a1727 100644
> --- a/include/uapi/linux/thermal.h
> +++ b/include/uapi/linux/thermal.h
> @@ -20,7 +20,7 @@ enum thermal_trip_type {
>
>  /* Adding event notification support elements */
>  #define THERMAL_GENL_FAMILY_NAME               "thermal"
> -#define THERMAL_GENL_VERSION                   0x01
> +#define THERMAL_GENL_VERSION                   0x02
>  #define THERMAL_GENL_SAMPLING_GROUP_NAME       "sampling"
>  #define THERMAL_GENL_EVENT_GROUP_NAME          "event"
>
> @@ -30,6 +30,7 @@ enum thermal_genl_attr {
>         THERMAL_GENL_ATTR_TZ,
>         THERMAL_GENL_ATTR_TZ_ID,
>         THERMAL_GENL_ATTR_TZ_TEMP,
> +       THERMAL_GENL_ATTR_TZ_LAST_TEMP,
>         THERMAL_GENL_ATTR_TZ_TRIP,
>         THERMAL_GENL_ATTR_TZ_TRIP_ID,
>         THERMAL_GENL_ATTR_TZ_TRIP_TYPE,
> @@ -50,6 +51,10 @@ enum thermal_genl_attr {
>         THERMAL_GENL_ATTR_CPU_CAPABILITY_ID,
>         THERMAL_GENL_ATTR_CPU_CAPABILITY_PERFORMANCE,
>         THERMAL_GENL_ATTR_CPU_CAPABILITY_EFFICIENCY,
> +       THERMAL_GENL_ATTR_THRESHOLD,
> +       THERMAL_GENL_ATTR_THRESHOLD_TEMP,
> +       THERMAL_GENL_ATTR_THRESHOLD_WAY,
> +       THERMAL_GENL_ATTR_THRESHOLD_PID,
>         __THERMAL_GENL_ATTR_MAX,
>  };
>  #define THERMAL_GENL_ATTR_MAX (__THERMAL_GENL_ATTR_MAX - 1)
> @@ -77,6 +82,11 @@ enum thermal_genl_event {
>         THERMAL_GENL_EVENT_CDEV_STATE_UPDATE,   /* Cdev state updated */
>         THERMAL_GENL_EVENT_TZ_GOV_CHANGE,       /* Governor policy change=
d  */
>         THERMAL_GENL_EVENT_CPU_CAPABILITY_CHANGE,       /* CPU capability=
 changed */
> +       THERMAL_GENL_EVENT_THRESHOLD_ADD,       /* A thresold has been ad=
ded */
> +       THERMAL_GENL_EVENT_THRESHOLD_DELETE,    /* A thresold has been de=
leted */
> +       THERMAL_GENL_EVENT_THRESHOLD_FLUSH,     /* All thresolds have bee=
n deleted */
> +       THERMAL_GENL_EVENT_THRESHOLD_UP,        /* A thresold has been cr=
ossed the way up */
> +       THERMAL_GENL_EVENT_THRESHOLD_DOWN,      /* A thresold has been cr=
ossed the way down */
>         __THERMAL_GENL_EVENT_MAX,
>  };
>  #define THERMAL_GENL_EVENT_MAX (__THERMAL_GENL_EVENT_MAX - 1)
> @@ -84,12 +94,16 @@ enum thermal_genl_event {
>  /* Commands supported by the thermal_genl_family */
>  enum thermal_genl_cmd {
>         THERMAL_GENL_CMD_UNSPEC,
> -       THERMAL_GENL_CMD_TZ_GET_ID,     /* List of thermal zones id */
> -       THERMAL_GENL_CMD_TZ_GET_TRIP,   /* List of thermal trips */
> -       THERMAL_GENL_CMD_TZ_GET_TEMP,   /* Get the thermal zone temperatu=
re */
> -       THERMAL_GENL_CMD_TZ_GET_GOV,    /* Get the thermal zone governor =
*/
> -       THERMAL_GENL_CMD_TZ_GET_MODE,   /* Get the thermal zone mode */
> -       THERMAL_GENL_CMD_CDEV_GET,      /* List of cdev id */
> +       THERMAL_GENL_CMD_TZ_GET_ID,             /* List of thermal zones =
id */
> +       THERMAL_GENL_CMD_TZ_GET_TRIP,           /* List of thermal trips =
*/
> +       THERMAL_GENL_CMD_TZ_GET_TEMP,           /* Get the thermal zone t=
emperature */
> +       THERMAL_GENL_CMD_TZ_GET_GOV,            /* Get the thermal zone g=
overnor */
> +       THERMAL_GENL_CMD_TZ_GET_MODE,           /* Get the thermal zone m=
ode */
> +       THERMAL_GENL_CMD_CDEV_GET,              /* List of cdev id */
> +       THERMAL_GENL_CMD_THRESHOLD_GET,         /* List of thresholds */
> +       THERMAL_GENL_CMD_THRESHOLD_ADD,         /* Add a threshold */
> +       THERMAL_GENL_CMD_THRESHOLD_DELETE,      /* Delete a threshold */
> +       THERMAL_GENL_CMD_THRESHOLD_FLUSH,       /* Flush all the threshol=
ds */
>         __THERMAL_GENL_CMD_MAX,
>  };
>  #define THERMAL_GENL_CMD_MAX (__THERMAL_GENL_CMD_MAX - 1)
> --
> 2.43.0
>
>

