Return-Path: <linux-pm+bounces-2087-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4693829C94
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jan 2024 15:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D02A286F8A
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jan 2024 14:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC754A9B5;
	Wed, 10 Jan 2024 14:29:11 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B514BA92
	for <linux-pm@vger.kernel.org>; Wed, 10 Jan 2024 14:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6ddf73f0799so132590a34.1
        for <linux-pm@vger.kernel.org>; Wed, 10 Jan 2024 06:29:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704896949; x=1705501749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e0uQV6ql8qfjywgggyZb3Typv6QUO73+dKsfhO0kJ5I=;
        b=B0XiXukgghciUGsgfmH+Fw31TNirJlN5ALxzJJJFaBS3E7OIK7XBfZ9QrZdHmx0UIN
         8x2mr3muU0YMIxJrEVg3fRyvsbrCdm3YP8QrhewyoESaiOeY0L/VNDqWxZ5NgJXTl9yY
         aIkNf9USCGKOoU52rsfvt/hy/lH80rg4lWpZGCOpmRO4rtMUlhU+XLGJuHFfK7c5nZOc
         UHEZj5nDTILE3e2+F4H4odD57NKimywCDZLMim69plDf97nHYnD5T+9BggbJ6ZtEsvy3
         P5sUt11ygUY5DrF+RIFyMUEKhDJlzWABfYypaNke5L/dGObx8md8SvnlUBx0n42MpSj4
         xgEw==
X-Gm-Message-State: AOJu0Yy/+gl7Rjay+RW2zgtNhS/edGUyN7+j5hVPR02g3hC3W2XbY1l/
	PYsJsql00wRp2lfgJI2mCixxHch3qYu1cWw+bqxxoRg5
X-Google-Smtp-Source: AGHT+IHa+BzlTIUAjoIeuq0mSa1PxmQR0DXX9gJhG1yEWOo1wOgJVWydUT2Bp6p15dDd5bs8wkiXfT5C1oYyYd3z/ug=
X-Received: by 2002:a05:6820:2e02:b0:598:9a35:71f1 with SMTP id
 ec2-20020a0568202e0200b005989a3571f1mr1527816oob.0.1704896949588; Wed, 10 Jan
 2024 06:29:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110122356.142997-1-sakari.ailus@linux.intel.com>
In-Reply-To: <20240110122356.142997-1-sakari.ailus@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 10 Jan 2024 15:28:58 +0100
Message-ID: <CAJZ5v0hg=OTRUHi5Z2YW7f425C6Kw2+B5R+YhwkYj6Vo+zkamA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Small runtime PM API changes
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, laurent.pinchart@ideasonboard.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 1:24=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi folks,
>
> Here's a small but a different set of patches for making two relatively
> minor changes to runtime PM API. I restarted version numbering as this is
> meaningfully different from the previous set.
>
> pm_runtime_get_if_active() loses its second argument as it only made sens=
e
> to have ign_usage_count argument true.
>
> The other change is also small but it has an effect on callers:
> pm_runtime_put_autosuspend() will, in the future, be re-purposed to
> include a call to pm_runtime_mark_last_busy() as well. Before this,
> current users of the function are moved to __pm_runtime_put_autosuspend()
> (added by this patchset) which will continue to have the current
> behaviour.
>
> I haven't included the conversion patches in this set as I only want to d=
o
> that once this set has been approved and merged. The tree specific patche=
s
> can be found here, on linux-next master (there are some V4L2 patches
> there, too, please ignore them for now):
> <URL:https://git.kernel.org/pub/scm/linux/kernel/git/sailus/linux-next.gi=
t/log/?h=3Dpm>
>
> Later on, users calling pm_runtime_mark_last_busy() immediately followed
> by __pm_runtime_put_autosuspend() will be switched back to
> pm_runtime_put_autosuspend() once its behaviour change has been done (a
> patch near top of that branch). I'll provide these once the preceding one=
s
> have been merged.
>
> Comments are welcome.
>
> since v1:
>
> - patch 1: Rename __pm_runtime_get_conditional() as
>   pm_runtime_get_conditional().
>
> - patch 1: Reword documentation on driver use of
>   pm_runtime_get_conditional().
>
> Sakari Ailus (2):
>   pm: runtime: Simplify pm_runtime_get_if_active() usage
>   pm: runtime: Add pm_runtime_put_autosuspend() replacement
>
>  Documentation/power/runtime_pm.rst      | 22 ++++++++-----
>  drivers/accel/ivpu/ivpu_pm.c            |  2 +-
>  drivers/base/power/runtime.c            | 10 ++++--
>  drivers/gpu/drm/i915/intel_runtime_pm.c |  2 +-
>  drivers/gpu/drm/xe/xe_pm.c              |  2 +-
>  drivers/media/i2c/ccs/ccs-core.c        |  2 +-
>  drivers/media/i2c/ov64a40.c             |  2 +-
>  drivers/media/i2c/thp7312.c             |  2 +-
>  drivers/net/ipa/ipa_smp2p.c             |  2 +-
>  drivers/pci/pci.c                       |  2 +-
>  include/linux/pm_runtime.h              | 44 ++++++++++++++++++++++---
>  sound/hda/hdac_device.c                 |  2 +-
>  12 files changed, 68 insertions(+), 26 deletions(-)
>
> --

All of this LGTM, but it touches multiple pieces that are all in-flux
now, so can you please rebase it on something more consistent like
6.8-rc1 (when it's out) and resend with all of the tags received?

Thanks!

