Return-Path: <linux-pm+bounces-16075-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EE59A65C3
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 13:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B74D1C209F4
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 11:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEAD18E373;
	Mon, 21 Oct 2024 11:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rgk3Lxgs"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DF639FD6
	for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2024 11:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729508581; cv=none; b=u4aAWSbBtMVC2StGDBg3sjj1uxQcXaG/mFo8EtWVsSu1s8kgG2q/w+5yO/Ku2v2CX2HYpE3iLemJf1FId2f0W/v+0HZqj3nUudxUBqboDAeZpC4IqXQWMzfSCL7r/eKz3lnD2GfpJ3cvqab5BPsfHgb/5FZqVGby6isMhpZuARE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729508581; c=relaxed/simple;
	bh=rOuWXlJluCYpKS11KolEZPEoUdINwB4EMZmMV4yrFWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FAFL7s5/k8O9BuPbY8INWGKo0Nd/H6c1DPuMMiyxd7WIeVTYsctLO1xl8DVt89ekwst15ZMJvM1CT7LrxMXyeXSg8AFKIp93/l/pTrX3x7nLNBXPOiB/4yvrlQ4+XQqOcRlP5zwKBkUDe7bjSTTh7hDGaYMoY1I7iF6g7Fc3b9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rgk3Lxgs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D67C4CEC3
	for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2024 11:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729508581;
	bh=rOuWXlJluCYpKS11KolEZPEoUdINwB4EMZmMV4yrFWQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Rgk3LxgsKoQ/Qcp9ChjWGtmIyWXhWlIQDH1298/4brxBAbeqlkh6nBFzZEcr0mENV
	 WGDd9K0mgeo/jomzDkRiz69C1hB0GECNiVe9WBPJWhqrzRqzcJpH3ZjLJ4FEKiOlbZ
	 jM9GF8eglKXVrLUqtnd5yKa0lLSJ1HNR+v0rXnclDsR85reHAwOtxqvl2pogDkgEZC
	 /1v8NrLc9cmkZwg2LwXroW6kcW0msqhKIAH6YLcwxNjqZleiHGE3bPqot+v8rVATb6
	 dzwXmfHKi10MtVMtVkeB/qtGWCMkKIB7rBmqxNv7Nwmbn3lKGU3Jt9tJjb3BIMykpV
	 wrYGnNpistbdw==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5eb60f6b4a7so1661391eaf.0
        for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2024 04:03:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXj9qt4G8nkIaolQ+baHYtNPyZOwcqfy2ak7l8ZBjmEgtH2atLN6q9hmjGNWTaVhs9ypFbeZdSUiA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv/J6D9xy+w3+wL24BqUC69PJ60ojBX7CyLcoCr6q2N09kzg3W
	JDhhkkn20G6wnokg7Jsb8JXg3tiQfiWDT5JW5URcFaEnjsmxZTAx6Dt91WBtQCJDYYlUT34Vqc9
	NZYiWEsdXHkBCu5TeVYw0IMYOajs=
X-Google-Smtp-Source: AGHT+IHkvQC+q4l+I4cmS9y8Ba4UF/0aFN+LpkJBFcwViZYRuZz0k3xFpc39vuBh7EwXfic7rF5qmuPJ/uGHfUZ4Sgo=
X-Received: by 2002:a05:6870:910a:b0:288:c383:788d with SMTP id
 586e51a60fabf-2892c33d830mr8373218fac.21.1729508580311; Mon, 21 Oct 2024
 04:03:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014094309.1430126-1-daniel.lezcano@linaro.org> <af8d8c7d-2f98-4607-a096-f85a9390489d@linaro.org>
In-Reply-To: <af8d8c7d-2f98-4607-a096-f85a9390489d@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 21 Oct 2024 13:02:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iSA1sfEqiL7gfXD7w=n_u2j3SG2WSfWMH1WSf2FazQDw@mail.gmail.com>
Message-ID: <CAJZ5v0iSA1sfEqiL7gfXD7w=n_u2j3SG2WSfWMH1WSf2FazQDw@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Add thermal user thresholds support
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, lukasz.luba@arm.com, 
	quic_manafm@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Mon, Oct 21, 2024 at 10:28=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi,
>
> as there are no more comments and I think I took into account all the
> feedback, is it possible to merge this series so I can get rid of
> monitoring its status ?

Please see my reply to the first patch.

Apart from a locking issue in thermal_thresholds_for_each() that will
go away when the thermal_zone guard is used in this function, this
looks good to me.

Of course, I'll give Lukasz the time to review and test it before it
gets applied, though.


> On 14/10/2024 11:43, Daniel Lezcano wrote:
> > The trip points are a firmware description of the temperature limits
> > of a specific thermal zone where we associate an action which is done
> > by the kernel. The time resolution is low.
> >
> > The userspace has to deal with a more complex thermal management based
> > on heuristics from different information coming from different
> > places. The logic is much more complex but based on a bigger time
> > resolution, usually one second based.
> >
> > The purpose of the userspace is to monitor the temperatures from
> > different places and take actions. However, it can not be constantly
> > reading the temperature to detect when a temperature threshold has
> > been reached. This is especially bad for mobile or embedded system as
> > that will lead to an unacceptable number of wakeup to check the
> > temperature with nothing to do.
> >
> > On the other side, the sensors are now most of the time interrupt
> > driven. That means the thermal framework will use the temperature trip
> > points to program the sensor to trigger an interrupt when a
> > temperature limit is crossed.
> >
> > Unfortunately, the userspace can not benefit this feature and current
> > solutions found here and there, iow out-of-tree, are to add fake trip
> > points in the firmware and enable the writable trip points.
> >
> > This is bad for different reasons, the trip points are for in-kernel
> > actions, the semantic of their types is used by the thermal framework
> > and by adding trip points in the device tree is a way to overcome the
> > current limitation but tampering with how the thermal framework is
> > supposed to work. The writable trip points is a way to adjust a
> > temperature limit given a specific platform if the firmware is not
> > accurate enough and TBH it is more a debug feature from my POV.
> >
> > The user thresholds mechanism is a way to have the userspace to tell
> > thermal framework to send a notification when a temperature limit is
> > crossed. There is no id, no hysteresis, just the temperature and the
> > direction of the limit crossing. That means we can be notified when a
> > temperature threshold is crossed the way up only, or the way down only
> > or both ways. That allows to create hysteresis values if it is needed.
> >
> > Those thresholds are refered as user thresholds in order to do the
> > difference with the trip points which are similar.
> >
> > An user threshold can be added, deleted or flushed. The latter means
> > all user thresholds belonging to a thermal zone will be deleted.
> >
> > When one or several user thresholds are crossed, an event is sent to
> > the userspace.
> >
> > All aforementioned actions and events lead to a notification to the
> > userspace.
> >
> > Along with the kernel changes, the thermal library has been extended
> > to provide the different API to deal with the new user threshold
> > netlink events and commands.
> >
> > In addition, the thermal-engine skeleton uses these new API by
> > flushing and adding user thresholds as well as getting the
> > notification about these actions.
> >
> > Overall the series has been tested with the thermal-engine skeleton
> > and some selftests which are not part of this series.
> >
> > Changelog:
> >    V5:
> >      - Added CAP_SYS_ADMIN needed capability when adding, deleting and
> >        flushing a threshold (Rafael)
> >
> >      - Remove the pid information to prevent leaking pid inside
> >        containers. Also the information is not really needed (Rafael)
> >
> >      - Renamed "THERMAL_GENL_ATTR_THRESHOLD_WAY" to
> >        "THERMAL_GENL_ATTR_THRESHOLD_DIRECTION". Did not used '*_DIR' as
> >        suggested initially because it can be ambiguous with 'directory'
> >        (Rafael)
> >
> >      - Renamed 'last_temp' to 'prev_temp' (Rafael)
> >
> >      - Used CLASS constructor/destructor to get / put the thermal
> >        zone's device refcount (Rafael)
> >
> >      - Moved locking inside thermal_thresholds_for_each() (Rafael)
> >
> >      - Reflected the changes above in the thermal library and the
> >        thermal engine skeleton
> >
> >
> >    V4:
> >      - Fix missing stubs when THERMAL_NETLINK=3Dn (kernel test robot)
> >
> >    V3:
> >      - the first patch of the v2 series has been merged
> >
> >      - Modified the description to split the information between the
> >        cover letter and the patch 1 description (Rafael)
> >
> >      - Made the thresholds code as part of the core (Rafael)
> >
> >      - Converted the thresholds into a list and directly declared in
> >        the thermal zone device structure (Rafael)
> >
> >      - Changed the name of the field in the thermal zone device
> >        structure to user_thresholds (Rafael)
> >
> >      - Added #include "thermal_thresholds.h" (Rafael)
> >
> >      - Combined the conditions in the function
> >        __thermal_threshold_is_crossed (Rafael)
> >
> >      - Moved the function thermal_thresholds_flush() before
> >        thermal_thresholds_exit() (Rafael)
> >
> >      - Change thermal_thresholds_handle() to return void (Rafael)
> >
> >      - Move the list field on top the of the structure threshold and
> >        renamed it list_node (Rafael)
> >
> >      - Changed THERMAL_THRESHOLD_* notifications to
> >        THERMAL_TZ_THRESHOLD_* (Rafael)
> >
> >    V2:
> >      - Compute min and max in thermal_zone_device_update() but keep
> >        the loop as it is (Rafael)
> >
> >      - Include slab.h to fix compilation warnings on some architectures
> >        with kmalloc and kfree (kernel test robot)
> >
> > Daniel Lezcano (4):
> >    thermal/netlink: Add the commands and the events for the thresholds
> >    tools/lib/thermal: Make more generic the command encoding function
> >    tools/lib/thermal: Add the threshold netlink ABI
> >    tools/thermal/thermal-engine: Take into account the thresholds API
> >
> >   drivers/thermal/thermal_netlink.c             | 236 +++++++++++++++++=
-
> >   drivers/thermal/thermal_netlink.h             |  34 +++
> >   drivers/thermal/thermal_thresholds.c          |  36 +--
> >   drivers/thermal/thermal_thresholds.h          |   2 +-
> >   include/uapi/linux/thermal.h                  |  27 +-
> >   tools/lib/thermal/commands.c                  | 167 ++++++++++++-
> >   tools/lib/thermal/events.c                    |  55 +++-
> >   tools/lib/thermal/include/thermal.h           |  40 +++
> >   tools/lib/thermal/libthermal.map              |   5 +
> >   tools/lib/thermal/thermal.c                   |  17 ++
> >   tools/thermal/lib/Makefile                    |   2 +-
> >   tools/thermal/thermal-engine/thermal-engine.c | 105 +++++++-
> >   12 files changed, 662 insertions(+), 64 deletions(-)
> >
>
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>

