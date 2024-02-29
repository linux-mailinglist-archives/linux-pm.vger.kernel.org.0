Return-Path: <linux-pm+bounces-4557-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB18386CCB8
	for <lists+linux-pm@lfdr.de>; Thu, 29 Feb 2024 16:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 951901F233F9
	for <lists+linux-pm@lfdr.de>; Thu, 29 Feb 2024 15:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C63137C3F;
	Thu, 29 Feb 2024 15:19:05 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC71A86275;
	Thu, 29 Feb 2024 15:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709219945; cv=none; b=jEhE8Ri5z6/mTNnepsBmc5IEshTnoL2lD9v4c0rQlUzawBphcCkG0RMXF9f1bIqZMA/dNLV6likd8XrAb4WOcQdkdzcuFrqK/Rc3rxOAXFwQ0n0QW8Z6C6YSgSrdwObO1OnFy1HFnDT9X3LwIO2RHfHU5Re4kWppfkJz0QnWY80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709219945; c=relaxed/simple;
	bh=U7xDd7oBSPeV1KWV0hUtjF85Xi/FpTbUJwNhsDwgyEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LBCbt2OMz+y9fr8D00KZQr1qvGzrjgeaVMWLmpJl2N6uqfRLAX2yKfsCqR6yzC21bF2Jb++l8jWBoXcNSrSI6kzGMnLR+ymUudMdbTNIJnjuLUlV7EwRiYiIB9Vg5J1GwbQwXxS40eGr/c4DSF2Dot3z0XrNasAgVjJBL8DnOC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5a0b0a2819cso9053eaf.0;
        Thu, 29 Feb 2024 07:19:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709219943; x=1709824743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWCwBQu4qpipUBiAe8+W7XFWSTpU4TgmkSATlkkWejs=;
        b=v5RPBNYHQ64PWLHNjYZtaD1T8jAlQxxfj2/ng8ttN4xbHAlWwo17+l1mj91vp/iT6W
         8Pxw/7wtfITnbH7iITU6g6Bu051JUEXjEOnPWDZxnAovNvKpOgEe+N1EiTk761rLnMQ+
         I7eHfLRDgVMlOBZ9ae2Eo/N5MyvayofGfF8WwmGabEKOc3OLfl0mw2CsSXZfxn+P33US
         6DB3iFre7nymI0pm2fHgMTA4gmYadIfeAKDsITYwg61adb3nfrNhy3O9x45n0SOVVQmC
         shMLiHHpdzCpuIyJbs8GPryaayY//4aciFQan2Wt16QCsVUxMvvvjAOaxxY+r3WU+tVI
         Oq8w==
X-Forwarded-Encrypted: i=1; AJvYcCVdToOMja5NrrdCzthjuhb+awRZ6c40ZC4yEuVXcbyNByn67bGXmjgv9h2Th+zDvEN8RgJ9xBnWbtiYqHruP+eHd9/ZNb8z
X-Gm-Message-State: AOJu0Yz2Mw/tAD1XAyhrobuBWmz4SfmVlz67j1XXwCc97JNH27SFAxwN
	URBfygMdOokQDDxS/3B1c9tqAKeywLSHqIUiO33RmxSRk8t8WGQdPMKLdY6rN1wIzcikq90h2g4
	3LippdwtqG2FL8QegupUyeCUjISE=
X-Google-Smtp-Source: AGHT+IFt7K9nQTccSO+c6s1yivaZIDniLkptzacnfi8qYbswhbDLNOczkDt0F7uW+uK7q0Wb1KXWJ7I6NSEJc7PEvjY=
X-Received: by 2002:a05:6820:352:b0:5a0:6ef3:ed8e with SMTP id
 m18-20020a056820035200b005a06ef3ed8emr2360509ooe.1.1709219942823; Thu, 29 Feb
 2024 07:19:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212161615.161935-1-stanislaw.gruszka@linux.intel.com>
In-Reply-To: <20240212161615.161935-1-stanislaw.gruszka@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 29 Feb 2024 16:18:50 +0100
Message-ID: <CAJZ5v0gw52e9zx36YgVLDO9jJw+80BP0e_C92kYyq-ys=f8pBw@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] thermal/netlink/intel_hfi: Enable HFI feature only
 when required
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
> The patchset introduces a new genetlink family bind/unbind callbacks
> and thermal/netlink notifications, which allow drivers to send netlink
> multicast events based on the presence of actual user-space consumers.
> This functionality optimizes resource usage by allowing disabling
> of features when not needed.
>
> Then implement the notification mechanism in the intel_hif driver,
> it is utilized to disable the Hardware Feedback Interface (HFI)
> dynamically. By implementing a thermal genl notify callback, the driver
> can now enable or disable the HFI based on actual demand, particularly
> when user-space applications like intel-speed-select or Intel Low Power
> daemon utilize events related to performance and energy efficiency
> capabilities.
>
> On machines where Intel HFI is present, but there are no user-space
> components installed, we can save tons of CPU cycles.
>
> Changes v3 -> v4:
>
> - Add 'static inline' in patch2
>
> Changes v2 -> v3:
>
> - Fix unused variable compilation warning
> - Add missed Suggested by tag to patch2
>
> Changes v1 -> v2:
>
> - Rewrite using netlink_bind/netlink_unbind callbacks.
>
> - Minor changelog tweaks.
>
> - Add missing check in intel hfi syscore resume (had it on my testing,
> but somehow missed in post).
>
> - Do not use netlink_has_listeners() any longer, use custom counter inste=
ad.
> To keep using netlink_has_listners() would be required to rearrange
> netlink_setsockopt() and possibly netlink_bind() functions, to call
> nlk->netlink_bind() after listeners are updated. So I decided to custom
> counter. This have potential issue as thermal netlink registers before
> intel_hif, so theoretically intel_hif can miss events. But since both
> are required to be kernel build-in (if CONFIG_INTEL_HFI_THERMAL is
> configured), they start before any user-space.
>
> v1: https://lore.kernel.org/linux-pm/20240131120535.933424-1-stanislaw.gr=
uszka@linux.intel.com//
> v2: https://lore.kernel.org/linux-pm/20240206133605.1518373-1-stanislaw.g=
ruszka@linux.intel.com/
> v3: https://lore.kernel.org/linux-pm/20240209120625.1775017-1-stanislaw.g=
ruszka@linux.intel.com/
>
> Stanislaw Gruszka (3):
>   genetlink: Add per family bind/unbind callbacks
>   thermal: netlink: Add genetlink bind/unbind notifications
>   thermal: intel: hfi: Enable interface only when required
>
>  drivers/thermal/intel/intel_hfi.c | 95 +++++++++++++++++++++++++++----
>  drivers/thermal/thermal_netlink.c | 40 +++++++++++--
>  drivers/thermal/thermal_netlink.h | 26 +++++++++
>  include/net/genetlink.h           |  4 ++
>  net/netlink/genetlink.c           | 30 ++++++++++
>  5 files changed, 180 insertions(+), 15 deletions(-)
>
> --

What tree is this based on?

