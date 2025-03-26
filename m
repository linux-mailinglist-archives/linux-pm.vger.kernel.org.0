Return-Path: <linux-pm+bounces-24534-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECDAA71DAB
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 18:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30F4A18925A5
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 17:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB67B23F427;
	Wed, 26 Mar 2025 17:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyr/IoiK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9A317E4;
	Wed, 26 Mar 2025 17:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743011175; cv=none; b=EaXOGnZTLM+bCT9Ktrn12hccEhLedIG5yU3BUCENUbeVxDKepuky8yEzhEh4r6YbPLHi+1m5Ev8ROQcRfNvoMQEH/9v9ggFtXWqOmI8sQhePXq3Z+X4fxGMEDmPHEABx7Jce5cgUHUiLOzZnXHElqeHvC2wNeQHnnPFsuYxTrd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743011175; c=relaxed/simple;
	bh=miEtypO9MxoEkP52+ubXko+kh6EpUHlD9UatETGQKD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DBRL+Nu43ZSYYhz8astRZQYyk+AsWmtmhaEaA4l0NnDiHYD/zLJ56StITccRaa18tI6tbjyw3euzUq5xwQNcJjJg6RLrHa3A7Icls6dW0E7/G/Y8IG4gmj3ZIObyvWIIb//hk6Xguz7sVHE69V0A6Blpwhg3l44q4UGYprr+nto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyr/IoiK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1340C4CEEF;
	Wed, 26 Mar 2025 17:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743011173;
	bh=miEtypO9MxoEkP52+ubXko+kh6EpUHlD9UatETGQKD4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fyr/IoiK4o9xnAdq94zUAuLJAiYDLNI1cnzYTrWQlAuQLpEHXRjhU0KFBjWiU+D88
	 qSN2sCcP1GvHTrl7C6xQJtX9DvND0MZaH+2VYiLhe5sXQPrZ5XB9/oiyJVs8ninzPV
	 F6jJyuE0IwykP2sCsR0Kn5LmRivb2BlAcA1nosSlULBZTZJ1XjQuYmkw07xoaQkHNn
	 wsWuvRI2XPeMicRp9JvidtyhL6WCWbKJqa3vkS5lnwl/09UuOZBXVLKRj8UDV+T1CX
	 WlsiPWHVFIv6WAFV8zhoGP5+bi4A4/bM0ViNs892Pd5XYAmf+nHTujMEqGzmwISuS3
	 O783XCioVWMEA==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2c7b2c14455so18198fac.2;
        Wed, 26 Mar 2025 10:46:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVTw3/Du27KAWAof4E9KM7tmKF38gZFY7Fk4CQ0Rc5iDR6bqSy28BpY0BXHgWoKXmiwK3gq82r9HU0=@vger.kernel.org, AJvYcCW1PwZC/vQiw7JkPbbsSRJINZZHBhLdK7NG+pg+DK2WmTDNOVP2SdqWX+LLsCldsK7oHzWIxPW5pO0WgB+v@vger.kernel.org, AJvYcCWfYyCTX9eF6cp/iufuEijCcnH1sHfa5gih/TwXZGvfAlr/iXwUvYoKoM8j+J8gf08BdGlatS7DO2DCvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPRoNI+wbnX0KQO4H4WJEDZBVvQcN+LVT2bfmjTjUZCUP6Msmk
	+wwfzdNREzLFjzOuN2OUZ1+1ILT4YocGfJO2CdAkk+Qq4kxvaJ0xWXQN/Wk8WIWV6Hyp/rJuE6P
	dY60463klvNe3WVKF9HaobthXiXs=
X-Google-Smtp-Source: AGHT+IHjCYJ1aKIQUcyrZ9BAzILIIir/5TxXFuxPsahNtlrZl9NR8jJkSDlN0NEYnz5mztENBCa9lEbR2dlli4PK3Xw=
X-Received: by 2002:a05:6870:e38d:b0:297:2719:deb6 with SMTP id
 586e51a60fabf-2c847efaa2cmr313369fac.1.1743011173183; Wed, 26 Mar 2025
 10:46:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <33882f284ac6e6d1ec766ca4bb2f3b88@intel.com> <f18607ca-30dc-43de-be77-fec69968aeec@arm.com>
 <SJ2PR11MB7670F63C7052C88637D305DF8DDF2@SJ2PR11MB7670.namprd11.prod.outlook.com>
 <1ae51ccc-66cc-4551-b649-2f5883e2f5a2@acm.org> <SJ2PR11MB7670B2AEFF7C0DABE6856F258DA62@SJ2PR11MB7670.namprd11.prod.outlook.com>
 <ad852ef9-5207-4b70-8834-2db6aa5e1a51@arm.com>
In-Reply-To: <ad852ef9-5207-4b70-8834-2db6aa5e1a51@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 26 Mar 2025 18:46:01 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hXGUbAM6vTti0D5uyX+-TfHg3NaSLSeZMj27Y9upbNdg@mail.gmail.com>
X-Gm-Features: AQ5f1Jo4d-ADi4h4thY6vmh5kvUiEf_ukqBmctJVztaOo2801xKRgKlhBK2zi3g
Message-ID: <CAJZ5v0hXGUbAM6vTti0D5uyX+-TfHg3NaSLSeZMj27Y9upbNdg@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: psd: add power sleep demotion prevention for
 fast I/O devices
To: Christian Loehle <christian.loehle@arm.com>
Cc: "King, Colin" <colin.king@intel.com>, Bart Van Assche <bvanassche@acm.org>, 
	Jens Axboe <axboe@kernel.dk>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 5:26=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 3/26/25 15:04, King, Colin wrote:
> > Hi,
> >
> >> -----Original Message-----
> >> From: Bart Van Assche <bvanassche@acm.org>
> >> Sent: 23 March 2025 12:36
> >> To: King, Colin <colin.king@intel.com>; Christian Loehle
> >> <christian.loehle@arm.com>; Jens Axboe <axboe@kernel.dk>; Rafael J.
> >> Wysocki <rafael@kernel.org>; Daniel Lezcano <daniel.lezcano@linaro.org=
>;
> >> linux-block@vger.kernel.org; linux-pm@vger.kernel.org
> >> Cc: linux-kernel@vger.kernel.org
> >> Subject: Re: [PATCH] cpuidle: psd: add power sleep demotion prevention=
 for
> >> fast I/O devices
> >>
> >> On 3/17/25 3:03 AM, King, Colin wrote:
> >>> This code is optional, one can enable it or disable it via the config
> >>> option. Also, even when it is built-in one can disable it by writing =
0 to the
> >> sysfs file
> >>>    /sys/devices/system/cpu/cpuidle/psd_cpu_lat_timeout_ms
> >>
> >> I'm not sure we need even more configuration knobs in sysfs.
> >
> > It's useful for enabling / disabling the functionality, as well as some=
 form of tuning for slower I/O devices, so I think it is justifiable.
> >
> >> How are users
> >> expected to find this configuration option? How should they decide whe=
ther
> >> to enable or to disable it?
> >
> > I can send a V2 with some documentation if that's required.
> >
> >>
> >> Please take a look at this proposal and let me know whether this would=
 solve
> >> the issue that you are looking into: "[LSF/MM/BPF Topic] Energy- Effic=
ient I/O"
> >> (https://lore.kernel.org/linux-block/ad1018b6-7c0b-4d70-
> >> b845-c869287d3cf3@acm.org/). The only disadvantage of this approach
> >> compared to the cpuidle patch is that it requires RPM (runtime power
> >> management) to be enabled. Maybe I should look into modifying the
> >> approach such that it does not rely on RPM.
> >
> > I've had a look, the scope of my patch is a bit wider.  If my patch get=
s accepted I'm
> > going to also look at putting the psd call into other devices (such as =
network devices) to
> > also stop deep states while these devices are busy.  Since the code is =
very lightweight I
> > was hoping this was going to be relatively easy and simple to use in va=
rious devices in the future.
>
> IMO this needs to be a lot more fine-grained then, both in terms of which=
 devices or even
> IO is affected (Surely some IO is fine with at least *some* latency) but =
also how aggressive
> we are in blocking.
> Just looking at some common latency/residency of idle states out there I =
don't think
> it's reasonable to force polling for a 3-10ms (rounding up with the jiffi=
e) period.
> Playing devil's advocate if the system is under some thermal/power pressu=
re we might
> actually reduce throughput by burning so much power on this.
> This seems like the stuff that is easily convincing because it improves t=
hroughput and
> then taking care of power afterwards is really hard. :/

I agree and recall the iowait thing that you've recently eliminated
from the menu governor.  Its purpose was ostensibly very similar and
it had similar issues.

Besides, any piece of kernel code today can add a CPU latency QoS
request, either per CPU or globally, and manage it as desired.  The
hard part is to know when to use it and what limit to set through it.

