Return-Path: <linux-pm+bounces-4560-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B180386CF03
	for <lists+linux-pm@lfdr.de>; Thu, 29 Feb 2024 17:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D169D1C22520
	for <lists+linux-pm@lfdr.de>; Thu, 29 Feb 2024 16:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF14160639;
	Thu, 29 Feb 2024 16:24:29 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5222160635;
	Thu, 29 Feb 2024 16:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709223869; cv=none; b=KYbpIL4MSFbhVNPf6hyr9yTITluqtbYe0LnD+0jnxv4lHRSKDko2YqvNuH4v/VMBm887iMs3SGPSm4Ju6zBEBrCfL+i4F/vuu+x/AcSwwLCyXbJOdsHYgRdlQMbWGmUmyGl510f/UFl0ie/tEfrFYsCMbdj8/aATkgZp/xaiG7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709223869; c=relaxed/simple;
	bh=4cArV84tGXR0uKX2ho7Z9pnB0hR3C/bfm6qAd2SNVTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qnZHnHmFxKpQ+IXL4EolHbvVYqDJZOUhsOT7Ged3NVfb5eZnH5NHgUHjrnWpMFIUtMXJosrasRKh6Vd5me7t3tjWwRuLCGOqgz5pk217sQ9uWQognZ7o15DS5OmDCfrs75dOiZ1MUys8WGuOfZsRmza858oIWGC24pwTNHwe06U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5a0918d6d83so22147eaf.0;
        Thu, 29 Feb 2024 08:24:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709223866; x=1709828666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/cJO8VRDcdzwDw7MAgU6LJ0UXUsjKNc6noWqwXrB0ho=;
        b=VNWQ5XPI/dGMNLSCHXZMSrHANEpoyQYUd8KnV6r1ITw+Wj7lWDH2P3kUXdoZLRE+5q
         nwZiShbxrhAVE0sBAPWzT2+ehUp4VlPT39Lo5XPcc5NTKwCoHzjILZ3/wVdOEo6xJ17K
         Kfk2pVeew21lMXHFk4XjdvfxojjQvunc/vSx7UQ9CHkCdXPUp5MgGeMfptEJLJw1N0WR
         No58mDTHK33RCFHIkByHW/AvCMXorZoyuzqMynrS0BUJKYlLFiztUQGq3yzPYz8a2UlY
         Xi1n8tMEtSiWiOAiD0vYQhi6ycX7VJ2Yxztk+6JmSnoKh6/tX6lV/ghgDFm21KWCdnJb
         Uc7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU5YJeT50R3FXe7Zow46FomWS12DypsVdV6LMI/NcmzL2fHH3MhavHqxMSLM905NDv0w5ktE0Hvvx8SMZatIN8Os52BdWntTOzLxyx8uAg25aYWTX+01Itx4yAzl67ya+0=
X-Gm-Message-State: AOJu0YzX23IzbhOrpWfWpFhP81k273UH6Un6coBTCIrJbyY5gwbZ0+BA
	6ElW4r2YjCOsI09UDfIbXgLgnayWi0eSL443lDnoVit9g//6C2atdS5avO1X7T9Fv7W3fm75ude
	68iVMMQNcQjEVvVvHgijjCZr2Ffg=
X-Google-Smtp-Source: AGHT+IHOiyjDgswN2AgHkRA3gTcRt8YTdNIirDyJYolFeEARr8xuwkzzIAHCUhQkAWON+vbAw3oRG70ar0P03uqnuSQ=
X-Received: by 2002:a4a:625e:0:b0:5a0:4d78:975d with SMTP id
 y30-20020a4a625e000000b005a04d78975dmr2665490oog.1.1709223866709; Thu, 29 Feb
 2024 08:24:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212161615.161935-1-stanislaw.gruszka@linux.intel.com>
 <CAJZ5v0gw52e9zx36YgVLDO9jJw+80BP0e_C92kYyq-ys=f8pBw@mail.gmail.com> <ZeCtEUGQknfHegpR@linux.intel.com>
In-Reply-To: <ZeCtEUGQknfHegpR@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 29 Feb 2024 17:24:15 +0100
Message-ID: <CAJZ5v0jGpzn8kO8P8w_QUvo7MaaVMpURDZjzcdB2DjPkRnSmBg@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] thermal/netlink/intel_hfi: Enable HFI feature only
 when required
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

On Thu, Feb 29, 2024 at 5:13=E2=80=AFPM Stanislaw Gruszka
<stanislaw.gruszka@linux.intel.com> wrote:
>
> On Thu, Feb 29, 2024 at 04:18:50PM +0100, Rafael J. Wysocki wrote:
> > On Mon, Feb 12, 2024 at 5:16=E2=80=AFPM Stanislaw Gruszka
> > <stanislaw.gruszka@linux.intel.com> wrote:
> > >
> > > The patchset introduces a new genetlink family bind/unbind callbacks
> > > and thermal/netlink notifications, which allow drivers to send netlin=
k
> > > multicast events based on the presence of actual user-space consumers=
.
> > > This functionality optimizes resource usage by allowing disabling
> > > of features when not needed.
> > >
> > > Then implement the notification mechanism in the intel_hif driver,
> > > it is utilized to disable the Hardware Feedback Interface (HFI)
> > > dynamically. By implementing a thermal genl notify callback, the driv=
er
> > > can now enable or disable the HFI based on actual demand, particularl=
y
> > > when user-space applications like intel-speed-select or Intel Low Pow=
er
> > > daemon utilize events related to performance and energy efficiency
> > > capabilities.
> > >
> > > On machines where Intel HFI is present, but there are no user-space
> > > components installed, we can save tons of CPU cycles.
> > >
> > > Changes v3 -> v4:
> > >
> > > - Add 'static inline' in patch2
> > >
> > > Changes v2 -> v3:
> > >
> > > - Fix unused variable compilation warning
> > > - Add missed Suggested by tag to patch2
> > >
> > > Changes v1 -> v2:
> > >
> > > - Rewrite using netlink_bind/netlink_unbind callbacks.
> > >
> > > - Minor changelog tweaks.
> > >
> > > - Add missing check in intel hfi syscore resume (had it on my testing=
,
> > > but somehow missed in post).
> > >
> > > - Do not use netlink_has_listeners() any longer, use custom counter i=
nstead.
> > > To keep using netlink_has_listners() would be required to rearrange
> > > netlink_setsockopt() and possibly netlink_bind() functions, to call
> > > nlk->netlink_bind() after listeners are updated. So I decided to cust=
om
> > > counter. This have potential issue as thermal netlink registers befor=
e
> > > intel_hif, so theoretically intel_hif can miss events. But since both
> > > are required to be kernel build-in (if CONFIG_INTEL_HFI_THERMAL is
> > > configured), they start before any user-space.
> > >
> > > v1: https://lore.kernel.org/linux-pm/20240131120535.933424-1-stanisla=
w.gruszka@linux.intel.com//
> > > v2: https://lore.kernel.org/linux-pm/20240206133605.1518373-1-stanisl=
aw.gruszka@linux.intel.com/
> > > v3: https://lore.kernel.org/linux-pm/20240209120625.1775017-1-stanisl=
aw.gruszka@linux.intel.com/
> > >
> > > Stanislaw Gruszka (3):
> > >   genetlink: Add per family bind/unbind callbacks
> > >   thermal: netlink: Add genetlink bind/unbind notifications
> > >   thermal: intel: hfi: Enable interface only when required
> > >
> > >  drivers/thermal/intel/intel_hfi.c | 95 +++++++++++++++++++++++++++--=
--
> > >  drivers/thermal/thermal_netlink.c | 40 +++++++++++--
> > >  drivers/thermal/thermal_netlink.h | 26 +++++++++
> > >  include/net/genetlink.h           |  4 ++
> > >  net/netlink/genetlink.c           | 30 ++++++++++
> > >  5 files changed, 180 insertions(+), 15 deletions(-)
> > >
> > > --
> >
> > What tree is this based on?
>
> v5: https://patchwork.kernel.org/project/linux-pm/list/?series=3D829159
> it's on top of linux-pm master, but require additional net dependency,
> which can be added by:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux.git =
for-thermal-genetlink-family-bind-unbind-callbacks
> git merge FETCH_HEAD
>
> and will be merged mainline in the next merge window.
> So at this point would be probably better just wait for 6.9-rc1
> when the dependency will be in the mainline, before applying this set.

And that's what's going to happen, unless I have any additional
comments on the patches.

Thanks!

