Return-Path: <linux-pm+bounces-16074-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D3E9A65A8
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 13:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CD182847B2
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 11:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136071E47AC;
	Mon, 21 Oct 2024 10:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNYvrD2F"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3481E6DC2
	for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2024 10:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729508324; cv=none; b=faDyNPbw6D0UFC+n6yIubI4YhSR6JC2HrTzWnAy/ElSS9gGEoaldaJkR0No5Kblm+Yzybko8UKHJsRvc3W/vKXoKZbhXVYNScmcz1jZs81UCbuaVg6qS0/dJISGtmNjLybcmU0dOme+ckzPqXObeUr75CCM5inc3jD7Eku/r42c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729508324; c=relaxed/simple;
	bh=fW0t+2tGXiYDX/zU1slOLUnBXEYiZ9yl+4ixoUgusUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nkBrp+NZ48QtKfOvOHAp8Gk2Ep99f78En2qcfC6SP/6AD3PKFwmCs4V/KJtxv3lyOvBr//iwv7F/KS9IvOF/EI4FZV6O6G9qYpnMDfZas61Yt7wp+eyW6/B9baqaTZ+GurKcPusG+60yeEPJ92DkX6Q2WXsUXaNM/pKKdNKXSmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNYvrD2F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69220C4CEC7
	for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2024 10:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729508323;
	bh=fW0t+2tGXiYDX/zU1slOLUnBXEYiZ9yl+4ixoUgusUk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RNYvrD2FdG6VLwg44VsuBUFp+dTsEsoiKRQ95MnkX+Ci6UkCrVxoI8/BSfKz005AB
	 GynIrMl2Q9CjvblSKTV99D0CeOEJgdFxnXy3RKOLhTGOqdgFlkx612tCGPrTmZnehL
	 mwS6DZUTRXl7XE7moN1xksGDRNHG4HenGuD+9VxG8b184Evh4jiXlEUOLKYKoYrbTb
	 EE62BztDVD5itZLuu0ShamKA7gMfmwMxaGM/JVG6NKAxle+1NFy9wzmIJD3xkZwY2U
	 SAnNO5tD0IpYBb7c8bBuh2e/5bUJZ++hhQb2mUBs8qha+DiW/WSPUeKDA+gfQ7LnGd
	 ooS6xegYTQySw==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5ebc04d495aso510096eaf.2
        for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2024 03:58:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUhHaPQvVUY6o6TDqEetITd5rzhQJrJMNpBXySpI3H5F5GzA9TBLHT4ANQSJsEXnqf3A42XtitQaw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtydFdEItZAwVda9ZeTsMQku7cTv/ENwF/Ikvv87LF2eQyQI9R
	MOnRH5Upb0O8HE0MFOcF4nldtQxmiAGNLZtg0dz6V6zZDVf6ike5FOdYBXxC8Qtzu2PwMysOwNg
	UEVhpRt9gpuicdLDeXDfZqtOEPt0=
X-Google-Smtp-Source: AGHT+IH/Azp1qL+2fVJvgIhXAaZpzLsULEI4jOmKu0pm2B0sNyVCIPD6HLSwOyq9jLPzMWV4yX/kdMauZcRA54UGfcs=
X-Received: by 2002:a05:6870:9689:b0:277:f176:1830 with SMTP id
 586e51a60fabf-2892c276713mr7885450fac.8.1729508322469; Mon, 21 Oct 2024
 03:58:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014094309.1430126-1-daniel.lezcano@linaro.org> <20241014094309.1430126-2-daniel.lezcano@linaro.org>
In-Reply-To: <20241014094309.1430126-2-daniel.lezcano@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 21 Oct 2024 12:58:25 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hM62YzSB6_UHACi+j5SxLypEtRVeq4M+qfMZ2XUisk1w@mail.gmail.com>
Message-ID: <CAJZ5v0hM62YzSB6_UHACi+j5SxLypEtRVeq4M+qfMZ2XUisk1w@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] thermal/netlink: Add the commands and the events
 for the thresholds
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, lukasz.luba@arm.com, 
	quic_manafm@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 11:43=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The thresholds exist but there is no notification neither action code
> related to them yet.
>
> These changes implement the netlink for the notifications when the
> thresholds are crossed, added, deleted or flushed as well as the
> commands which allows to get the list of the thresholds, flush them,
> add and delete.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/thermal_netlink.c    | 236 ++++++++++++++++++++++++++-
>  drivers/thermal/thermal_netlink.h    |  34 ++++
>  drivers/thermal/thermal_thresholds.c |  36 ++--
>  drivers/thermal/thermal_thresholds.h |   2 +-
>  include/uapi/linux/thermal.h         |  27 ++-
>  5 files changed, 307 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/thermal/thermal_netlink.c b/drivers/thermal/thermal_=
netlink.c
> index f3c58c708969..978cd46c15e8 100644
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
> @@ -49,6 +50,11 @@ static const struct nla_policy thermal_genl_policy[THE=
RMAL_GENL_ATTR_MAX + 1] =3D
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
> +       [THERMAL_GENL_ATTR_THRESHOLD_DIRECTION] =3D { .type =3D NLA_U32 }=
,
>  };
>
>  struct param {
> @@ -62,6 +68,8 @@ struct param {
>         int trip_type;
>         int trip_hyst;
>         int temp;
> +       int prev_temp;
> +       int direction;
>         int cdev_state;
>         int cdev_max_state;
>         struct thermal_genl_cpu_caps *cpu_capabilities;
> @@ -234,6 +242,34 @@ static int thermal_genl_event_cpu_capability_change(=
struct param *p)
>         return -EMSGSIZE;
>  }
>
> +static int thermal_genl_event_threshold_add(struct param *p)
> +{
> +       if (nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_ID, p->tz_id) ||
> +           nla_put_u32(p->msg, THERMAL_GENL_ATTR_THRESHOLD_TEMP, p->temp=
) ||
> +           nla_put_u32(p->msg, THERMAL_GENL_ATTR_THRESHOLD_DIRECTION, p-=
>direction))
> +               return -EMSGSIZE;
> +
> +       return 0;
> +}
> +
> +static int thermal_genl_event_threshold_flush(struct param *p)
> +{
> +       if (nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_ID, p->tz_id))
> +               return -EMSGSIZE;
> +
> +       return 0;
> +}
> +
> +static int thermal_genl_event_threshold_up(struct param *p)
> +{
> +       if (nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_ID, p->tz_id) ||
> +           nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_PREV_TEMP, p->prev_t=
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
> @@ -246,6 +282,12 @@ int thermal_genl_event_tz_disable(struct param *p)
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
> @@ -259,6 +301,11 @@ static cb_t event_cb[] =3D {
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
> @@ -401,6 +448,43 @@ int thermal_genl_cpu_capability_event(int count,
>  }
>  EXPORT_SYMBOL_GPL(thermal_genl_cpu_capability_event);
>
> +int thermal_notify_threshold_add(const struct thermal_zone_device *tz,
> +                                int temperature, int direction)
> +{
> +       struct param p =3D { .tz_id =3D tz->id, .temp =3D temperature, .d=
irection =3D direction };
> +
> +       return thermal_genl_send_event(THERMAL_GENL_EVENT_THRESHOLD_ADD, =
&p);
> +}
> +
> +int thermal_notify_threshold_delete(const struct thermal_zone_device *tz=
,
> +                                   int temperature, int direction)
> +{
> +       struct param p =3D { .tz_id =3D tz->id, .temp =3D temperature, .d=
irection =3D direction };
> +
> +       return thermal_genl_send_event(THERMAL_GENL_EVENT_THRESHOLD_DELET=
E, &p);
> +}
> +
> +int thermal_notify_threshold_flush(const struct thermal_zone_device *tz)
> +{
> +       struct param p =3D { .tz_id =3D tz->id };
> +
> +       return thermal_genl_send_event(THERMAL_GENL_EVENT_THRESHOLD_FLUSH=
, &p);
> +}
> +
> +int thermal_notify_threshold_down(const struct thermal_zone_device *tz)
> +{
> +       struct param p =3D { .tz_id =3D tz->id, .temp =3D tz->temperature=
, .prev_temp =3D tz->last_temperature };
> +
> +       return thermal_genl_send_event(THERMAL_GENL_EVENT_THRESHOLD_DOWN,=
 &p);
> +}
> +
> +int thermal_notify_threshold_up(const struct thermal_zone_device *tz)
> +{
> +       struct param p =3D { .tz_id =3D tz->id, .temp =3D tz->temperature=
, .prev_temp =3D tz->last_temperature };
> +
> +       return thermal_genl_send_event(THERMAL_GENL_EVENT_THRESHOLD_UP, &=
p);
> +}
> +
>  /*************************** Command encoding **************************=
******/
>
>  static int __thermal_genl_cmd_tz_get_id(struct thermal_zone_device *tz,
> @@ -572,12 +656,132 @@ static int thermal_genl_cmd_cdev_get(struct param =
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
> +           nla_put_u32(msg, THERMAL_GENL_ATTR_THRESHOLD_DIRECTION, thres=
hold->direction))
> +               return -1;
> +
> +       return 0;
> +}
> +
> +static int thermal_genl_cmd_threshold_get(struct param *p)
> +{
> +       struct sk_buff *msg =3D p->msg;
> +       struct nlattr *start_trip;
> +       int id, ret;
> +
> +       if (!p->attrs[THERMAL_GENL_ATTR_TZ_ID])
> +               return -EINVAL;
> +
> +       id =3D nla_get_u32(p->attrs[THERMAL_GENL_ATTR_TZ_ID]);
> +
> +       CLASS(thermal_zone_get_by_id, tz)(id);
> +       if (!tz)
> +               return -EINVAL;
> +
> +       start_trip =3D nla_nest_start(msg, THERMAL_GENL_ATTR_THRESHOLD);
> +       if (!start_trip)
> +               return -EMSGSIZE;
> +
> +       ret =3D thermal_thresholds_for_each(tz, __thermal_genl_cmd_thresh=
old_get, msg);
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
> +       int id, temp, direction, ret =3D 0;
> +
> +       if (!capable(CAP_SYS_ADMIN))
> +               return -EPERM;
> +
> +       if (!p->attrs[THERMAL_GENL_ATTR_TZ_ID] ||
> +           !p->attrs[THERMAL_GENL_ATTR_THRESHOLD_TEMP] ||
> +           !p->attrs[THERMAL_GENL_ATTR_THRESHOLD_DIRECTION])
> +               return -EINVAL;
> +
> +       id =3D nla_get_u32(p->attrs[THERMAL_GENL_ATTR_TZ_ID]);
> +       temp =3D nla_get_u32(p->attrs[THERMAL_GENL_ATTR_THRESHOLD_TEMP]);
> +       direction =3D nla_get_u32(p->attrs[THERMAL_GENL_ATTR_THRESHOLD_DI=
RECTION]);
> +
> +       CLASS(thermal_zone_get_by_id, tz)(id);
> +       if (!tz)
> +               return -EINVAL;
> +
> +       mutex_lock(&tz->lock);
> +       ret =3D thermal_thresholds_add(tz, temp, direction);
> +       mutex_unlock(&tz->lock);
> +
> +       return ret;
> +}
> +
> +static int thermal_genl_cmd_threshold_delete(struct param *p)
> +{
> +       int id, temp, direction, ret =3D 0;
> +
> +       if (!capable(CAP_SYS_ADMIN))
> +               return -EPERM;
> +
> +       if (!p->attrs[THERMAL_GENL_ATTR_TZ_ID] ||
> +           !p->attrs[THERMAL_GENL_ATTR_THRESHOLD_TEMP] ||
> +           !p->attrs[THERMAL_GENL_ATTR_THRESHOLD_DIRECTION])
> +               return -EINVAL;
> +
> +       id =3D nla_get_u32(p->attrs[THERMAL_GENL_ATTR_TZ_ID]);
> +       temp =3D nla_get_u32(p->attrs[THERMAL_GENL_ATTR_THRESHOLD_TEMP]);
> +       direction =3D nla_get_u32(p->attrs[THERMAL_GENL_ATTR_THRESHOLD_DI=
RECTION]);
> +
> +       CLASS(thermal_zone_get_by_id, tz)(id);
> +       if (!tz)
> +               return -EINVAL;
> +
> +       mutex_lock(&tz->lock);
> +       ret =3D thermal_thresholds_delete(tz, temp, direction);
> +       mutex_unlock(&tz->lock);
> +
> +       return ret;
> +}
> +
> +static int thermal_genl_cmd_threshold_flush(struct param *p)
> +{
> +       int id;
> +
> +       if (!capable(CAP_SYS_ADMIN))
> +               return -EPERM;
> +
> +       if (!p->attrs[THERMAL_GENL_ATTR_TZ_ID])
> +               return -EINVAL;
> +
> +       id =3D nla_get_u32(p->attrs[THERMAL_GENL_ATTR_TZ_ID]);
> +
> +       CLASS(thermal_zone_get_by_id, tz)(id);
> +       if (!tz)
> +               return -EINVAL;
> +
> +       mutex_lock(&tz->lock);
> +       thermal_thresholds_flush(tz);
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
> @@ -688,6 +892,26 @@ static const struct genl_small_ops thermal_genl_ops[=
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
> @@ -700,7 +924,7 @@ static struct genl_family thermal_genl_family __ro_af=
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
> index e01221e8816b..075e9ae85f3d 100644
> --- a/drivers/thermal/thermal_netlink.h
> +++ b/drivers/thermal/thermal_netlink.h
> @@ -53,6 +53,13 @@ int thermal_notify_tz_gov_change(const struct thermal_=
zone_device *tz,
>  int thermal_genl_sampling_temp(int id, int temp);
>  int thermal_genl_cpu_capability_event(int count,
>                                       struct thermal_genl_cpu_caps *caps)=
;
> +int thermal_notify_threshold_add(const struct thermal_zone_device *tz,
> +                                int temperature, int direction);
> +int thermal_notify_threshold_delete(const struct thermal_zone_device *tz=
,
> +                                   int temperature, int direction);
> +int thermal_notify_threshold_flush(const struct thermal_zone_device *tz)=
;
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
tion)
> +{
> +       return 0;
> +}
> +
> +static inline int thermal_notify_threshold_delete(const struct thermal_z=
one_device *tz,
> +                                                 int temperature, int di=
rection)
> +{
> +       return 0;
> +}
> +
> +static inline int thermal_notify_threshold_flush(const struct thermal_zo=
ne_device *tz)
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
> index f33b6d5474d8..ea4aa5a2e86c 100644
> --- a/drivers/thermal/thermal_thresholds.c
> +++ b/drivers/thermal/thermal_thresholds.c
> @@ -32,6 +32,8 @@ void thermal_thresholds_flush(struct thermal_zone_devic=
e *tz)
>                 kfree(entry);
>         }
>
> +       thermal_notify_threshold_flush(tz);
> +
>         __thermal_zone_device_update(tz, THERMAL_TZ_FLUSH_THRESHOLDS);
>  }
>
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
> +                          int temperature, int direction)
>  {
>         struct list_head *thresholds =3D &tz->user_thresholds;
>         struct user_threshold *t;
> @@ -182,12 +183,15 @@ int thermal_thresholds_add(struct thermal_zone_devi=
ce *tz, int temperature, int
>                 list_sort(NULL, thresholds, __thermal_thresholds_cmp);
>         }
>
> +       thermal_notify_threshold_add(tz, temperature, direction);
> +
>         __thermal_zone_device_update(tz, THERMAL_TZ_ADD_THRESHOLD);
>
>         return 0;
>  }
>
> -int thermal_thresholds_delete(struct thermal_zone_device *tz, int temper=
ature, int direction)
> +int thermal_thresholds_delete(struct thermal_zone_device *tz,
> +                             int temperature, int direction)
>  {
>         struct list_head *thresholds =3D &tz->user_thresholds;
>         struct user_threshold *t;
> @@ -205,6 +209,8 @@ int thermal_thresholds_delete(struct thermal_zone_dev=
ice *tz, int temperature, i
>                 t->direction &=3D ~direction;
>         }
>
> +       thermal_notify_threshold_delete(tz, temperature, direction);
> +
>         __thermal_zone_device_update(tz, THERMAL_TZ_DEL_THRESHOLD);
>
>         return 0;
> @@ -217,7 +223,7 @@ int thermal_thresholds_for_each(struct thermal_zone_d=
evice *tz,
>         struct user_threshold *entry;
>         int ret;
>
> -       lockdep_assert_held(&tz->lock);
> +       mutex_lock(&tz->lock);
>
>         list_for_each_entry(entry, thresholds, list_node) {
>                 ret =3D cb(entry, arg);
> @@ -225,5 +231,7 @@ int thermal_thresholds_for_each(struct thermal_zone_d=
evice *tz,
>                         return ret;

The lock needs to be released before returning.

However, I would generally prefer this to go in after

https://lore.kernel.org/linux-pm/4985597.31r3eYUQgx@rjwysocki.net/

so I'll convert it to using guards before applying if you don't mind
and this issue will go away then.

Otherwise the patch looks good to me.

>         }
>
> +       mutex_unlock(&tz->lock);
> +
>         return 0;
>  }
> diff --git a/drivers/thermal/thermal_thresholds.h b/drivers/thermal/therm=
al_thresholds.h
> index 232f4e8089af..cb372659a20d 100644
> --- a/drivers/thermal/thermal_thresholds.h
> +++ b/drivers/thermal/thermal_thresholds.h
> @@ -10,8 +10,8 @@ struct user_threshold {
>
>  int thermal_thresholds_init(struct thermal_zone_device *tz);
>  void thermal_thresholds_exit(struct thermal_zone_device *tz);
> -void thermal_thresholds_flush(struct thermal_zone_device *tz);
>  void thermal_thresholds_handle(struct thermal_zone_device *tz, int *low,=
 int *high);
> +void thermal_thresholds_flush(struct thermal_zone_device *tz);
>  int thermal_thresholds_add(struct thermal_zone_device *tz, int temperatu=
re, int direction);
>  int thermal_thresholds_delete(struct thermal_zone_device *tz, int temper=
ature, int direction);
>  int thermal_thresholds_for_each(struct thermal_zone_device *tz,
> diff --git a/include/uapi/linux/thermal.h b/include/uapi/linux/thermal.h
> index 2e6f60a36173..ba8604bdf206 100644
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
> +       THERMAL_GENL_ATTR_TZ_PREV_TEMP,
>         THERMAL_GENL_ATTR_TZ_TRIP,
>         THERMAL_GENL_ATTR_TZ_TRIP_ID,
>         THERMAL_GENL_ATTR_TZ_TRIP_TYPE,
> @@ -50,6 +51,9 @@ enum thermal_genl_attr {
>         THERMAL_GENL_ATTR_CPU_CAPABILITY_ID,
>         THERMAL_GENL_ATTR_CPU_CAPABILITY_PERFORMANCE,
>         THERMAL_GENL_ATTR_CPU_CAPABILITY_EFFICIENCY,
> +       THERMAL_GENL_ATTR_THRESHOLD,
> +       THERMAL_GENL_ATTR_THRESHOLD_TEMP,
> +       THERMAL_GENL_ATTR_THRESHOLD_DIRECTION,
>         __THERMAL_GENL_ATTR_MAX,
>  };
>  #define THERMAL_GENL_ATTR_MAX (__THERMAL_GENL_ATTR_MAX - 1)
> @@ -77,6 +81,11 @@ enum thermal_genl_event {
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
> @@ -84,12 +93,16 @@ enum thermal_genl_event {
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

