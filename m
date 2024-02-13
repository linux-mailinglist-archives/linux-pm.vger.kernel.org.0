Return-Path: <linux-pm+bounces-3878-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F2C8531CA
	for <lists+linux-pm@lfdr.de>; Tue, 13 Feb 2024 14:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06F8C28B4D8
	for <lists+linux-pm@lfdr.de>; Tue, 13 Feb 2024 13:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A270B5647B;
	Tue, 13 Feb 2024 13:25:10 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E7355C39;
	Tue, 13 Feb 2024 13:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707830710; cv=none; b=TE4d2rgi/B+abQaUwoZK5nSitP582u5WX6aIFiw7eGnPNAJIBU2hNp0a1ieLe3oGS9vXZrld/WCPzN8D1YZb57+svI3OrrqHA/TGkxGlXS70p7KJ1MpWgZyjYUvJShqfxfdEP5X0gbUvmTnZET72W3Cq7m2/R6EjG5Dti5/AoR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707830710; c=relaxed/simple;
	bh=BuP2fEtUQ9kaCVHxizBDl+xi1iQ8avDbnjrFV0E2smo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pJljCCP+IRWIb+9ZwSoemC2o0TQlPZKa3yLHUSG15eFDm1Jegeuf+ATVXD3BWw7KST7AE2D3/HHBHg8wEYTEnbovarhWXPnG2MK8MoVAlU8jMPxaRAPaRnNqdabiAE1Dzj4Pq+R2fja71ACw++mn3nL+9usc2GpQU6HbbJH+BYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-59a24bf7cadso1446772eaf.0;
        Tue, 13 Feb 2024 05:25:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707830708; x=1708435508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JyOEb8nFY+eaNn935rSpFarrcUwnblrpSQYTTPI23Kg=;
        b=DN5c9o+zW6oTz+kwlxmP5VRzwozKbeVpRrPtyADE2NgJt4328cj2olJcU9XuRXd0Qj
         30Tod452PSxat9uwOx+XcCsy5d147RDw7qnd1HG57+C93PacxLqjFdJN7TxIPE4sYCxz
         nC65JiX+NEohR5vZbon3I+dT3q5uhCdmCQGJwE9ZNC9OrsjmNNeuJUw7Dnnc9xi3xDwJ
         Pba+zOx0FYy5SVV9sy46S5qBvJedk/uZHVcgO6emyWl0NNcnqSWFQ80oxbVrrDJbM3GD
         uuXfZXqGLjG1SiQKU3WlpvWBVSY/IQqcMxAR0i+D7HsL+GKXqWIfXLYso+36JW2jhASw
         nnyw==
X-Forwarded-Encrypted: i=1; AJvYcCWdNe5pbIBhhcDZKxM7WkVEVs7vGecqgW4GtDjCQiocEm//owG0Zimnx1soBF3eKJ9OgjSmL4BqwkfkXwzAb6GKn4ibwWp5
X-Gm-Message-State: AOJu0YzlQg6/ZqY1YrhpIh3c9nVqHjPDioGisLNZWK2IVj/28DrhTqo/
	nzByQeuZtpy4W0D2Usr1z2alTbh3tTOsf5tOH0xAhfA4WYhfZf4eF6LglwGWMGd38DpCteiTFs/
	HbdSWr39Lb2fp5vDl9PwC8KqG0W6yb0ha++8=
X-Google-Smtp-Source: AGHT+IHeK2kSACoewx3yDaBqwgKtKsPVAWepN8UHoR8OSgHu4gDZtO6NvTQZCdCEHarnhmC5fkOZfLfutA4syHGKDGI=
X-Received: by 2002:a05:6820:1f8e:b0:59c:eb7b:c04e with SMTP id
 eq14-20020a0568201f8e00b0059ceb7bc04emr7427957oob.1.1707830707845; Tue, 13
 Feb 2024 05:25:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212161615.161935-1-stanislaw.gruszka@linux.intel.com> <20240212161615.161935-3-stanislaw.gruszka@linux.intel.com>
In-Reply-To: <20240212161615.161935-3-stanislaw.gruszka@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 13 Feb 2024 14:24:56 +0100
Message-ID: <CAJZ5v0hTsXjre_StGizrmUx1JUkzKr9K9KLiHrsvicivMO2Odw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] thermal: netlink: Add genetlink bind/unbind notifications
To: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jiri Pirko <jiri@resnulli.us>, Johannes Berg <johannes@sipsolutions.net>, 
	Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 5:16=E2=80=AFPM Stanislaw Gruszka
<stanislaw.gruszka@linux.intel.com> wrote:
>
> Introduce a new feature to the thermal netlink framework, enabling the
> registration of sub drivers to receive events via a notifier mechanism.
> Specifically, implement genetlink family bind and unbind callbacks to sen=
d
> BIND and UNBIND events.
>
> The primary purpose of this enhancement is to facilitate the tracking of
> user-space consumers by the intel_hif driver.

This should be intel_hfi.  Or better, Intel HFI.

> By leveraging these
> notifications, the driver can determine when consumers are present
> or absent.
>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
> ---
>  drivers/thermal/thermal_netlink.c | 40 +++++++++++++++++++++++++++----
>  drivers/thermal/thermal_netlink.h | 26 ++++++++++++++++++++
>  2 files changed, 61 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/thermal/thermal_netlink.c b/drivers/thermal/thermal_=
netlink.c
> index 76a231a29654..86c7653a9530 100644
> --- a/drivers/thermal/thermal_netlink.c
> +++ b/drivers/thermal/thermal_netlink.c
> @@ -7,17 +7,13 @@
>   * Generic netlink for thermal management framework
>   */
>  #include <linux/module.h>
> +#include <linux/notifier.h>
>  #include <linux/kernel.h>
>  #include <net/genetlink.h>
>  #include <uapi/linux/thermal.h>
>
>  #include "thermal_core.h"
>
> -enum thermal_genl_multicast_groups {
> -       THERMAL_GENL_SAMPLING_GROUP =3D 0,
> -       THERMAL_GENL_EVENT_GROUP =3D 1,
> -};
> -
>  static const struct genl_multicast_group thermal_genl_mcgrps[] =3D {

There are enough characters per code line to spell "multicast_groups"
here (and analogously below).

>         [THERMAL_GENL_SAMPLING_GROUP] =3D { .name =3D THERMAL_GENL_SAMPLI=
NG_GROUP_NAME, },
>         [THERMAL_GENL_EVENT_GROUP]  =3D { .name =3D THERMAL_GENL_EVENT_GR=
OUP_NAME,  },
> @@ -75,6 +71,7 @@ struct param {
>  typedef int (*cb_t)(struct param *);
>
>  static struct genl_family thermal_gnl_family;
> +static BLOCKING_NOTIFIER_HEAD(thermal_gnl_chain);

thermal_genl_chain ?

It would be more consistent with the rest of the naming.

>
>  static int thermal_group_has_listeners(enum thermal_genl_multicast_group=
s group)
>  {
> @@ -645,6 +642,27 @@ static int thermal_genl_cmd_doit(struct sk_buff *skb=
,
>         return ret;
>  }
>
> +static int thermal_genl_bind(int mcgrp)
> +{
> +       struct thermal_genl_notify n =3D { .mcgrp =3D mcgrp };
> +
> +       if (WARN_ON_ONCE(mcgrp > THERMAL_GENL_MAX_GROUP))
> +               return -EINVAL;

pr_warn_once() would be better IMO.  At least it would not crash the
kernel configured with "panic on warn".

> +
> +       blocking_notifier_call_chain(&thermal_gnl_chain, THERMAL_NOTIFY_B=
IND, &n);
> +       return 0;
> +}
> +
> +static void thermal_genl_unbind(int mcgrp)
> +{
> +       struct thermal_genl_notify n =3D { .mcgrp =3D mcgrp };
> +
> +       if (WARN_ON_ONCE(mcgrp > THERMAL_GENL_MAX_GROUP))
> +               return;
> +
> +       blocking_notifier_call_chain(&thermal_gnl_chain, THERMAL_NOTIFY_U=
NBIND, &n);
> +}
> +
>  static const struct genl_small_ops thermal_genl_ops[] =3D {
>         {
>                 .cmd =3D THERMAL_GENL_CMD_TZ_GET_ID,
> @@ -679,6 +697,8 @@ static struct genl_family thermal_gnl_family __ro_aft=
er_init =3D {
>         .version        =3D THERMAL_GENL_VERSION,
>         .maxattr        =3D THERMAL_GENL_ATTR_MAX,
>         .policy         =3D thermal_genl_policy,
> +       .bind           =3D thermal_genl_bind,
> +       .unbind         =3D thermal_genl_unbind,
>         .small_ops      =3D thermal_genl_ops,
>         .n_small_ops    =3D ARRAY_SIZE(thermal_genl_ops),
>         .resv_start_op  =3D THERMAL_GENL_CMD_CDEV_GET + 1,
> @@ -686,6 +706,16 @@ static struct genl_family thermal_gnl_family __ro_af=
ter_init =3D {
>         .n_mcgrps       =3D ARRAY_SIZE(thermal_genl_mcgrps),
>  };
>
> +int thermal_genl_register_notifier(struct notifier_block *nb)
> +{
> +       return blocking_notifier_chain_register(&thermal_gnl_chain, nb);
> +}
> +
> +int thermal_genl_unregister_notifier(struct notifier_block *nb)
> +{
> +       return blocking_notifier_chain_unregister(&thermal_gnl_chain, nb)=
;
> +}
> +
>  int __init thermal_netlink_init(void)
>  {
>         return genl_register_family(&thermal_gnl_family);
> diff --git a/drivers/thermal/thermal_netlink.h b/drivers/thermal/thermal_=
netlink.h
> index 93a927e144d5..e01221e8816b 100644
> --- a/drivers/thermal/thermal_netlink.h
> +++ b/drivers/thermal/thermal_netlink.h
> @@ -10,6 +10,19 @@ struct thermal_genl_cpu_caps {
>         int efficiency;
>  };
>
> +enum thermal_genl_multicast_groups {
> +       THERMAL_GENL_SAMPLING_GROUP =3D 0,
> +       THERMAL_GENL_EVENT_GROUP =3D 1,
> +       THERMAL_GENL_MAX_GROUP =3D THERMAL_GENL_EVENT_GROUP,
> +};
> +
> +#define THERMAL_NOTIFY_BIND    0
> +#define THERMAL_NOTIFY_UNBIND  1
> +
> +struct thermal_genl_notify {
> +       int mcgrp;
> +};
> +
>  struct thermal_zone_device;
>  struct thermal_trip;
>  struct thermal_cooling_device;
> @@ -18,6 +31,9 @@ struct thermal_cooling_device;
>  #ifdef CONFIG_THERMAL_NETLINK
>  int __init thermal_netlink_init(void);
>  void __init thermal_netlink_exit(void);
> +int thermal_genl_register_notifier(struct notifier_block *nb);
> +int thermal_genl_unregister_notifier(struct notifier_block *nb);
> +
>  int thermal_notify_tz_create(const struct thermal_zone_device *tz);
>  int thermal_notify_tz_delete(const struct thermal_zone_device *tz);
>  int thermal_notify_tz_enable(const struct thermal_zone_device *tz);
> @@ -48,6 +64,16 @@ static inline int thermal_notify_tz_create(const struc=
t thermal_zone_device *tz)
>         return 0;
>  }
>
> +static inline int thermal_genl_register_notifier(struct notifier_block *=
nb)
> +{
> +       return 0;
> +}
> +
> +static inline int thermal_genl_unregister_notifier(struct notifier_block=
 *nb)
> +{
> +       return 0;
> +}
> +
>  static inline int thermal_notify_tz_delete(const struct thermal_zone_dev=
ice *tz)
>  {
>         return 0;
> --

