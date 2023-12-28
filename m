Return-Path: <linux-pm+bounces-1646-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D11081F7FE
	for <lists+linux-pm@lfdr.de>; Thu, 28 Dec 2023 12:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8829284E54
	for <lists+linux-pm@lfdr.de>; Thu, 28 Dec 2023 11:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6136FD6;
	Thu, 28 Dec 2023 11:58:13 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCFB79C6
	for <linux-pm@vger.kernel.org>; Thu, 28 Dec 2023 11:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-593f182f263so1263276eaf.0
        for <linux-pm@vger.kernel.org>; Thu, 28 Dec 2023 03:58:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703764691; x=1704369491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vWvHOcapyI3VDJEZRgtkXEFnB+dZ+jZDayXlSDpRaXU=;
        b=tpTAb5PG8DS3euuEPzTJ3WTPZnEJAUHQC6w2E4lZloOKUO1FhWlNQNyG6GuMfO9pyX
         VxQdMuD0kGWzQHr7NtuiJgERNJNtgSuPDS0Tpg61fKpodwBNMYHGoM8njsbjEJvIt3QS
         O8lfbdyAD78IFEMLgEBS3PdlOMuY0dgBfwpc0CPrqfXRuIquji2yIKBKZSeXUYnqcxUf
         94PMt62yuUhBuN7fsw5UvnVCTpQPWps+rliEDg+CpAUBHSoXQaTq5kCyvWtNNZsyJRpp
         j03fE5yTqLXN16Xr7HAdXOJw4HVvKEZopA90b3NpYspD/7AS28C+k+rw+uKecY7mB5So
         QLsA==
X-Gm-Message-State: AOJu0YzIMeWeBb9U/taXE+77/8PJJmVEY1kP2lzcnpUzZCzZF8/quzNC
	g8nrBHNaTywYSMm9n+K0IYJdrOWru2dNJ1xfZys821OV
X-Google-Smtp-Source: AGHT+IHrMUKq6bysUL1sqASxOH7ck45tAQXdTxR4oJfKOga54QSevGxoeSg1DNuHGb1yhpc3Ope1PBUui62/3cQdqsM=
X-Received: by 2002:a4a:d1b0:0:b0:594:177d:8bd6 with SMTP id
 z16-20020a4ad1b0000000b00594177d8bd6mr14423912oor.1.1703764690767; Thu, 28
 Dec 2023 03:58:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228100248.180721-1-stanislaw.gruszka@linux.intel.com> <20231228100248.180721-2-stanislaw.gruszka@linux.intel.com>
In-Reply-To: <20231228100248.180721-2-stanislaw.gruszka@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 28 Dec 2023 12:57:59 +0100
Message-ID: <CAJZ5v0gMJFVZToWQPTNstQOpYF9+yDiMYk74dasGp5VWW_-ndA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] thermal: netlink: Add thermal_group_has_listeners()
 helper
To: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 11:49=E2=80=AFAM Stanislaw Gruszka
<stanislaw.gruszka@linux.intel.com> wrote:
>
> Add a helper function to check if there are listeners for
> thermal_gnl_family multicast groups.
>
> For now use it to avoid unnecessary allocations and sending
> thermal genl messages when there are no recipients.
>
> In the future, in conjunction with (not yet implemented) notification
> of change in the netlink socket group membership, this helper can be
> used to open/close hardware interfaces based on the presence of
> user space subscribers.
>
> Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
> ---
> v2: Do not return -ESRCH error when there are no listeners

Both patches in the series look good to me.

Daniel, any objections?

>
>  drivers/thermal/thermal_netlink.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/thermal/thermal_netlink.c b/drivers/thermal/thermal_=
netlink.c
> index aca36c4ddbf3..332052e24a86 100644
> --- a/drivers/thermal/thermal_netlink.c
> +++ b/drivers/thermal/thermal_netlink.c
> @@ -76,6 +76,11 @@ typedef int (*cb_t)(struct param *);
>
>  static struct genl_family thermal_gnl_family;
>
> +static int thermal_group_has_listeners(enum thermal_genl_multicast_group=
s group)
> +{
> +       return genl_has_listeners(&thermal_gnl_family, &init_net, group);
> +}
> +
>  /************************** Sampling encoding **************************=
*****/
>
>  int thermal_genl_sampling_temp(int id, int temp)
> @@ -83,6 +88,9 @@ int thermal_genl_sampling_temp(int id, int temp)
>         struct sk_buff *skb;
>         void *hdr;
>
> +       if (!thermal_group_has_listeners(THERMAL_GENL_SAMPLING_GROUP))
> +               return 0;
> +
>         skb =3D genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
>         if (!skb)
>                 return -ENOMEM;
> @@ -280,6 +288,9 @@ static int thermal_genl_send_event(enum thermal_genl_=
event event,
>         int ret =3D -EMSGSIZE;
>         void *hdr;
>
> +       if (!thermal_group_has_listeners(THERMAL_GENL_EVENT_GROUP))
> +               return 0;
> +
>         msg =3D genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
>         if (!msg)
>                 return -ENOMEM;
> --
> 2.34.1
>
>

