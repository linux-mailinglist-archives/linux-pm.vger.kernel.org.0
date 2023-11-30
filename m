Return-Path: <linux-pm+bounces-579-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 668DB7FFBCE
	for <lists+linux-pm@lfdr.de>; Thu, 30 Nov 2023 20:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 171062818CA
	for <lists+linux-pm@lfdr.de>; Thu, 30 Nov 2023 19:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E597F537F9;
	Thu, 30 Nov 2023 19:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5EE10D9;
	Thu, 30 Nov 2023 11:51:20 -0800 (PST)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5a0dc313058so136471a12.0;
        Thu, 30 Nov 2023 11:51:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701373880; x=1701978680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJU5RuE0x+xF9mko7R10DFPHzyAQ5KB1GOFj2cnT57k=;
        b=rwtPNW3zhV8z9RabPkiekD+P4kifiy4FHJUC4v+8gGp8bev10lRyFr/HOcDWeYund/
         8TJQMNPgC4UOL9fQpj4PFfv8rU6SMQ7ym3v6vHv1JGjtF2y8ACPuF7qC2Qn5TQnq11Zh
         0qr0XqyfSz4+GjpALilSDEEGNNvHQ/JpDOj9Wpp/uyPTp3z41Cd1ZLvt+wRHnX54+3FO
         QKAJtlpBZDRVs1CAKqyvd8loDE0x/Sy9sPMYYMHb0iXRd86b2MOf2H+I/OECkfxUOeBq
         2xz+XUPNeyhXgwN9NSDVK4LA+BCH4IuRPDWHzIuiQfavCuaOMhuYNP3FfEH5QlhrrJFe
         B1Yw==
X-Gm-Message-State: AOJu0Yzk6TTRODk83id9uUwjMy6OswjLdKHtYZpn9bcQUlCPYHB6HSmM
	SpXL1kBiMS0zuGNTi6uQzr9I6VGB1raPFKZdcuI=
X-Google-Smtp-Source: AGHT+IEFEK0LHZXePrtLzsfQf6R9c7+Ca+68z5ZzBNw0EzmjpUDqlWBqijb28fQCsMkPW9EnYkvf/ceIGlmP9n4sFkU=
X-Received: by 2002:a05:6a20:da91:b0:187:df59:5c43 with SMTP id
 iy17-20020a056a20da9100b00187df595c43mr29063050pzb.2.1701373880126; Thu, 30
 Nov 2023 11:51:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5754079.DvuYhMxLoT@kreacher> <12355894.O9o76ZdvQC@kreacher>
In-Reply-To: <12355894.O9o76ZdvQC@kreacher>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 30 Nov 2023 20:51:08 +0100
Message-ID: <CAJZ5v0jKOarHuhVgS_Q8Rtamt6uP8LKdbVC=moYNO=WT+Kueog@mail.gmail.com>
Subject: Re: [PATCH v1.1 2/2] thermal: sysfs: Simplifications of trip point
 attribute callbacks
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Wrong subject, sorry for the noise.  Will resend.

On Thu, Nov 30, 2023 at 8:42=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The _show() callback functions of the trip point sysfs attributes,
> temperature, hysteresis and type, need not use thermal zone locking,
> because the layout of the data structures they access does not change
> after the thermal zone registration.
>
> Namely, they all need to access a specific entry in the thermal
> zone's trips[] table that is always present for non-tripless thermal
> zones and its size cannot change after the thermal zone has been
> registered.  Thus it is always safe to access the trips[] table of a
> registered thermal zone from each of the sysfs attributes in question.
>
> Moreover, the type of a trip point does not change after registering its
> thermal zone, and while its temperature and hysteresis can change, for
> example due to a firmware-induced thermal zone update, holding the zone
> lock around reading them is pointless, because it does not prevent stale
> values from being returned to user space.  For example, a trip point
> temperature can always change ater trip_point_temp_show() has read it
> and before the function's return statement is executed, regardless of
> whether or not zone locking is used.
>
> For this reason, drop the zone locking from trip_point_type_show(),
> trip_point_temp_show(), and trip_point_hyst_show().

