Return-Path: <linux-pm+bounces-4283-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C39C285FD50
	for <lists+linux-pm@lfdr.de>; Thu, 22 Feb 2024 16:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 788DA285E60
	for <lists+linux-pm@lfdr.de>; Thu, 22 Feb 2024 15:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9840F151CFE;
	Thu, 22 Feb 2024 15:56:03 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F397D153515;
	Thu, 22 Feb 2024 15:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708617363; cv=none; b=A6MXKV4fnRczMpHS0KFuiLhsqSblOB/5crhQWxFLaMtvyd/1gQMEG+bcs6BN1krNOiO7f3X+WstCIEYRwtTSdR1tfqiPKbFq+VsuzFUAJI2mwGnJM16VySIDNQHWcV8j90v46P6GR3akpcXDh1bmSsujrm84h4qO8IUBNh9KlUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708617363; c=relaxed/simple;
	bh=qekAwkVXRT0p765cTKHpZhLkRGZcg5DoBS8NZlj4/fQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KmjD1AGAk4/n2zW5vgqZHJY8y1JTlOwb7/jd894pGcCkjbv7zW0rlATF9Of9eE6ZpXaHaBoVzh7Cv58fbqChsIvdXWxMATErFP44yjbj565mYK5eJ3JRdaqB55jiTHwOm12MM7dzgGBHk+aIvcrX8TYvQ6b+7BWAqqke9qXoixw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5a0333a9779so159387eaf.0;
        Thu, 22 Feb 2024 07:56:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708617361; x=1709222161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DYKeigyDj9ApN01MPpIfl3j1OhPomWEtCdaROd3NttE=;
        b=seCMLmNCakrqJyR46ynDvGcpQ+73Tfm7I5vRkIYLojpFOCX4PXY7gN3IC2r6g4vueM
         p+Rc/IaE43wZU18uHaMMqKacqVhkjWxkgS7B8DsPS87qtSI8+TFkPUMenelaOWYr8M5n
         b34/umx2i4tKa+4Tmu+JfJITyXGd0FE0Q4vhIjzS8+gd1K/XqgGgP53DOrtFYTNozxko
         iP+XtVi+hsnEAd9Ir7xpdqW/G+YS3zWzRNYIb/2b2gbOSyasL9wDEYhI8dlXeKjnavbe
         Ir3C/cGuCKI4uLjydSbDZ2KwWrvi63hZpgqfUvx7Yly4NFW+Je2Z1nskk+emeEB8mY5j
         RVoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNL7ngwX4H002Z4Vaiv/hOHkhwhhDbWuwWyM7kSKt1AYmOBCujhLLx8+d2yaElax2yCy9oiE9IYxqrujuRv4Fj2YbFAX2s5RLwqqDDYVgQfgCG3I/51pwSQ1fDIIBDiOc=
X-Gm-Message-State: AOJu0YwsL+tK/HDAPVUTpSs2EYubDWXojomAWhv4emShdG8rCP+Xe5Ov
	nwgkf2wPV5CCCEpxpWbqVaBBA2wHvQUf36TgkvLEI3PdV4YsixD6Ucn0/H1g4EB0Hjm7SV8IKhe
	YxXIR9jd+cqcegbbjN21ZK2cn2+8=
X-Google-Smtp-Source: AGHT+IHNCebX0O58A6uvn/u7rKrX23Ky5jxA2e9YamBjTNSVjxvlbDgEBby00BKuKAkODBgMhdQw23R9+eAzcMKUXvE=
X-Received: by 2002:a05:6820:134d:b0:59f:881f:9318 with SMTP id
 b13-20020a056820134d00b0059f881f9318mr26634599oow.0.1708617360984; Thu, 22
 Feb 2024 07:56:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212161615.161935-1-stanislaw.gruszka@linux.intel.com>
 <20240212161615.161935-3-stanislaw.gruszka@linux.intel.com>
 <CAJZ5v0hTsXjre_StGizrmUx1JUkzKr9K9KLiHrsvicivMO2Odw@mail.gmail.com> <ZddshlCHwsDTFSYL@linux.intel.com>
In-Reply-To: <ZddshlCHwsDTFSYL@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 22 Feb 2024 16:55:49 +0100
Message-ID: <CAJZ5v0goAi7S5LQYsqs6ja=ouPX_QN6OYxNvLb5oTj=VMS2ZCA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] thermal: netlink: Add genetlink bind/unbind notifications
To: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jiri Pirko <jiri@resnulli.us>, Johannes Berg <johannes@sipsolutions.net>, 
	Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 4:47=E2=80=AFPM Stanislaw Gruszka
<stanislaw.gruszka@linux.intel.com> wrote:
>
> On Tue, Feb 13, 2024 at 02:24:56PM +0100, Rafael J. Wysocki wrote:
> > On Mon, Feb 12, 2024 at 5:16=E2=80=AFPM Stanislaw Gruszka
> > <stanislaw.gruszka@linux.intel.com> wrote:
> > >
> > > Introduce a new feature to the thermal netlink framework, enabling th=
e
> > > registration of sub drivers to receive events via a notifier mechanis=
m.
> > > Specifically, implement genetlink family bind and unbind callbacks to=
 send
> > > BIND and UNBIND events.
> > >
> > > The primary purpose of this enhancement is to facilitate the tracking=
 of
> > > user-space consumers by the intel_hif driver.
> >
> > This should be intel_hfi.  Or better, Intel HFI.
>
> Will change in next revision.
>
> > > By leveraging these
> > > notifications, the driver can determine when consumers are present
> > > or absent.
> > >
> > > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > > Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
> > > ---
> > >  drivers/thermal/thermal_netlink.c | 40 +++++++++++++++++++++++++++--=
--
> > >  drivers/thermal/thermal_netlink.h | 26 ++++++++++++++++++++
> > >  2 files changed, 61 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/thermal/thermal_netlink.c b/drivers/thermal/ther=
mal_netlink.c
> > > index 76a231a29654..86c7653a9530 100644
> > > --- a/drivers/thermal/thermal_netlink.c
> > > +++ b/drivers/thermal/thermal_netlink.c
> > > @@ -7,17 +7,13 @@
> > >   * Generic netlink for thermal management framework
> > >   */
> > >  #include <linux/module.h>
> > > +#include <linux/notifier.h>
> > >  #include <linux/kernel.h>
> > >  #include <net/genetlink.h>
> > >  #include <uapi/linux/thermal.h>
> > >
> > >  #include "thermal_core.h"
> > >
> > > -enum thermal_genl_multicast_groups {
> > > -       THERMAL_GENL_SAMPLING_GROUP =3D 0,
> > > -       THERMAL_GENL_EVENT_GROUP =3D 1,
> > > -};
> > > -
> > >  static const struct genl_multicast_group thermal_genl_mcgrps[] =3D {
> >
> > There are enough characters per code line to spell "multicast_groups"
> > here (and analogously below).
>
> Not sure what you mean, change thermal_genl_mcgrps to thermal_genl_multic=
ast_groups ?
>
> I could change that, but it's not really related to the changes in this p=
atch,
> so perhaps in separate patch.
>
> Additionally "mcgrps" are more consistent with genl_family fields i.e:
>
>       .mcgrps         =3D thermal_genl_mcgrps,
>       .n_mcgrps       =3D ARRAY_SIZE(thermal_genl_mcgrps),

OK, never mind.

> > >         [THERMAL_GENL_SAMPLING_GROUP] =3D { .name =3D THERMAL_GENL_SA=
MPLING_GROUP_NAME, },
> > >         [THERMAL_GENL_EVENT_GROUP]  =3D { .name =3D THERMAL_GENL_EVEN=
T_GROUP_NAME,  },
> > > @@ -75,6 +71,7 @@ struct param {
> > >  typedef int (*cb_t)(struct param *);
> > >
> > >  static struct genl_family thermal_gnl_family;
> > > +static BLOCKING_NOTIFIER_HEAD(thermal_gnl_chain);
> >
> > thermal_genl_chain ?
> >
> > It would be more consistent with the rest of the naming.
>
> Ok, will change. Additionally in separate patch thermal_gnl_family for co=
nsistency.
>
> > >  static int thermal_group_has_listeners(enum thermal_genl_multicast_g=
roups group)
> > >  {
> > > @@ -645,6 +642,27 @@ static int thermal_genl_cmd_doit(struct sk_buff =
*skb,
> > >         return ret;
> > >  }
> > >
> > > +static int thermal_genl_bind(int mcgrp)
> > > +{
> > > +       struct thermal_genl_notify n =3D { .mcgrp =3D mcgrp };
> > > +
> > > +       if (WARN_ON_ONCE(mcgrp > THERMAL_GENL_MAX_GROUP))
> > > +               return -EINVAL;
> >
> > pr_warn_once() would be better IMO.  At least it would not crash the
> > kernel configured with "panic on warn".
>
> "panic on warn" is generic WARN_* issue at any place where WARN_* are use=
d.
> And I would say, crash is desired behaviour for those who use the option
> to catch bugs. And mcgrp bigger than THERMAL_GENL_MAX_GROUP is definitely
> a bug. Additionally pr_warn_once() does not print call trace, so I think
> WARN_ON_ONCE() is more proper. But if really you prefer pr_warn_once()
> I can change.

Fair enough.

