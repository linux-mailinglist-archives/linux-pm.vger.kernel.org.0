Return-Path: <linux-pm+bounces-1188-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7A38139EB
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 19:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E5B2821D1
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 18:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C2B68B84;
	Thu, 14 Dec 2023 18:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Em8U2JPw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21D7CF
	for <linux-pm@vger.kernel.org>; Thu, 14 Dec 2023 10:26:26 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-552925413dfso917a12.0
        for <linux-pm@vger.kernel.org>; Thu, 14 Dec 2023 10:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702578385; x=1703183185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=601UPuCRwasJAIPUegryVCdBPot9FRMepCdAZlBh5KE=;
        b=Em8U2JPw7MDy/4ElMN1hfPUed4x4c2TGpAzpPkr6IjPfgFgla3lBCjXzlQ/Qss4iVE
         ZZFPMsG+TlzZT3f/LT0mBfMCSKlqTGKXDCfZYdNpbdAfngqUy6P+0jXfVi0EZbcwB5xD
         eU8nhCH7FOU/He7ITiIIPjvA2aXaEWWzsZzLJy2WmQqlkxSq604VoWmP91suDtVmOVB6
         cVTttirHxNaE/6+66uMvcX8KtQYJ7hGy/T5yDWs/65IH+oCOF7IhtQLzKj0WUAxyYO6l
         PBGdyM2HdmF8q7+EfL0YjeTQn6UQV0sUC0ntx8XSmlWJcuWklQRtW9rDrdoWP1XF0S7e
         wVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702578385; x=1703183185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=601UPuCRwasJAIPUegryVCdBPot9FRMepCdAZlBh5KE=;
        b=sS2Hgn2NH0sBmdRa7ID/KaVahu8Z76M7IXbFPayLHoZ9DvXRZlMy0r8rLkiCD1l7c9
         7/Ko419qTdT6b134g+FGEu3vl3562cmlDvkmizz3DwZKEIvIhknHvxekxWC9KfxRltl9
         5ytUp2hgzjEb4kKhFcAFA0eZuUsGx2n8c4cdO/37EyuOaUE3aGdTxAmSJwatDmE+bnk6
         G9DgUsL4AT046973bx8yoJdKDY7PHpkdoTe0VmWZZDOE7uJzC+cyw4FdMM7I6qWVNYwL
         kI3NRDFoLcjITG4JHiIsaSsVffueajuIxxLyFfIwu2ZtJx3AZtF/I1sia0nM7vnallqF
         XP/A==
X-Gm-Message-State: AOJu0Yzy2waLSyw3DnO76TY55QRfcldL2JBFukK3dDXrnJKX73WSldCw
	uPJ+jLKvwXc8LMLeTj/reAsVHx1PcRSXKkAIdPy8RQ==
X-Google-Smtp-Source: AGHT+IGGmczZzBVVmMuiLdJxh6exaXQX79QMiq48LG0ZiVDJdUbjiCdugLinjhG02vM8kE5Q/4yLaX+s77iSkdIiMo0=
X-Received: by 2002:a50:f69c:0:b0:552:7df2:edfc with SMTP id
 d28-20020a50f69c000000b005527df2edfcmr78099edn.2.1702578384993; Thu, 14 Dec
 2023 10:26:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231120234015.3273143-1-radusolea@google.com>
 <9d1009d9-b95b-4152-841f-19470a17ba97@linaro.org> <CAPpbzyhEkqjA0Kv=f_O1hy-dT8o-O4tPB_KpQqbE9b7vwC+2NA@mail.gmail.com>
 <570c9777-3d89-4f3c-b856-3e821883a7e2@linaro.org> <CAPpbzyiZmxhfQDOukEeuDv+B6j3CH43ugx_WyAvR3B-riRZChQ@mail.gmail.com>
 <0412fada-037d-47ea-bc3a-4634d134232c@linaro.org> <CAPpbzyiUEc0_5mDOWGQyXGbN4J4x8PHHBVRRUq4bSmqFdp4XtQ@mail.gmail.com>
 <b5d75de8-2006-40fa-add7-2db59f3e6cc4@linaro.org>
In-Reply-To: <b5d75de8-2006-40fa-add7-2db59f3e6cc4@linaro.org>
From: Radu Solea <radusolea@google.com>
Date: Thu, 14 Dec 2023 10:26:13 -0800
Message-ID: <CAPpbzygHs7Z2S9TJ7vwmhZUtRqfCnxAwFdRRG4q37yetNCPWMQ@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] thermal core: add option to run PM_POST_SUSPEND asynchronously
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 12:25=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 14/12/2023 01:21, Radu Solea wrote:
>
> [ ... ]
>
> >>> I can't go into much detail about the hardware. But let's put it this
> >>> way, if thermal_zone_device_update() takes 5 ms for each device (read
> >>> temp, get trips, set trips, etc). Assume 5 onboard thermal zones, on =
a
> >>> good day, ignoring system churn you'd get to around 25ms (already
> >>> significant).
> >>> Now on top of that add that these devices have multiple functions,
> >>> like a PMIC for example. The resume sequence is the perfect time fram=
e
> >>> where you'd encounter more than one operation aimed at any one of
> >>> these devices. Unless you have uncommonly smart drivers and devices,
> >>> these will be queued.
> >>> The driver in most cases will spin (hardly ideal, but realistic), eve=
n
> >>> if they would yield the effect on the completion of the chain is at
> >>> least the same or, likely, worse.
> >>>
> >>> To the patch itself, I realized I've been somewhat hamfisted.
> >>> thermal_zone_device_init() should not be deferred, and likely should
> >>> execute for all zones before the in_suspend lock-out is released. I'l=
l
> >>> correct that once we've landed on something.
> >>>
> >>> To my 50ms, it's almost the worst-case, but it happens way more often
> >>> than would be comfortable.
> >>
> >> If you call monitor_thermal_zone() instead of
> >> thermal_zone_device_update(), does it speed up the resume time ?
> >>
> > Looks like it does, I'll rework the patch. Don't think the config
> > switch is useful anymore.
>
> Well, we probably have to go a bit further in the concept.
>
> There are some thermal zones which may need to be checked immediately
> and others no. That depends on the temperature speed behavior.
>
> The higher is the temperature speed for a device, the lower is the
> polling (including zero).
>
> So the monitoring delay can be used as a criteria to check if the
> thermal zone needs an update or postpone the monitoring.
>
> As we don't want to change the current behavior, we can add a global
> option telling the polling delay above which we call
> monitor_thermal_zone() and defaulting to zero.
>
> Does it make sense?
It does, alternatively we add a device tree flag to the tz and not add
a side effect to the delay.
Either works imo.

>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>

