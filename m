Return-Path: <linux-pm+bounces-36747-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A70C02719
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 18:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 96A874E9CD4
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 16:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826AC2D9ECB;
	Thu, 23 Oct 2025 16:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Prdk/SBo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7696B2D6E64
	for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 16:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761236858; cv=none; b=qPVO34NKOeHCILEP1Ohlscyb9OhjEE2H47D7aS1LvJiA3u69v34yCIY+x/99hYzV8HCyuN8LGUj+Xw2+FWFWqcKH/eR3UDItvleurHOpL1y1pQA/DpBnW2DoRYy2jf8vMvxU7EHfPtFToQgrWCDKfqzKOzOwOg3d7lBKH9GhAIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761236858; c=relaxed/simple;
	bh=97MO41jRSpevZOQY5X/s6jqv4fmMPnX3F7sJNNlsleo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fi9m+kbvFOpLeIHLjlyt4TzpBZBKfKbJxjHKvaA0LrkCBj0JFl+tDCIT7MujVlCRMcbAa4w9Y6AMJDvYRwAFxX2sjG2kuNvo/7JOM1eyK3ytiqqbEbpBZ5ww4sDh29hYJxvqCsslPdfzNiPsR2VPLWizWobLTPug4Gk70D3tr+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Prdk/SBo; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-63c556b4e0cso2082020a12.1
        for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 09:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761236855; x=1761841655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97MO41jRSpevZOQY5X/s6jqv4fmMPnX3F7sJNNlsleo=;
        b=Prdk/SBofghIdtzCeMBtAvJyI7nlROk7g2TwGmQ3o5R9VZEILaksGldZ+H2+iWi+s6
         l9FTfZS16hPTzScJA8prerCGLoP8y5i0SMRHOavog3f5yLoguaOY27V0bQjIYLQxzDPB
         YRNs1PweZsaccigXXB26VDi6eTdwxqA7xvgL6sJJ3JJVbW/L5weyVsJ86S5NOj5LPNfU
         lBnesfC7nyGsGXVmCIbuR2WyESddOYcgzF+I2kXb/RjmVSVad6+BvHP7phcphn3ElSUx
         WGg/iCfqqncmWwMLn/dLnmM7aK69LVSCwJrok4e+iWRH+mv24SY0z8jy461KcIaPov0O
         Kp/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761236855; x=1761841655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=97MO41jRSpevZOQY5X/s6jqv4fmMPnX3F7sJNNlsleo=;
        b=rFkb2yH10p2KYehikJNW5pSjowocg5ylSUTw2OjI7rc/40ymxKaRTBgEh8uwAhkfQ+
         9KYc9U8bSOG9Mg/wX5Zw1ladbRChV+iNufPjyXdMoVkaGb25RDb0azeITlew8QJW8dTH
         t/kQcdevvcfW2Ty4Lselui6gePeTOSTx76kgu94uszJEvk05Dc0lRmvKi/5SgHnKKhx/
         PL8DiQjj4ai9XuVyAtPzEeSWhUZMt8LsLP9WXK+j8fEX1cZwI2/1ugmln8VYwAdmGN6P
         8hn7YadiOP6kojhUFL424sPZMnaW1g1kiLTZBq+TzXu6sxIiwmWNOQBsWRCap09I5535
         15kw==
X-Forwarded-Encrypted: i=1; AJvYcCWgQfsIDkEcxH3+Qb8C+4t88/2f0xv7aFBxjA4vHXAocxf/hel1Z7a35AtU793cK+gak/n7TO84nQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyD1XNGxAfGorKerzyGEx9UZbfHd717BLVlSTLaEWcQ+pCr08Ab
	O7fvoWLbDQXAJbj7E9sDEFFu0d0K2OtAGfg+4OsvJz1UoL8xdALOryS6/UfQMwuuHmgmkHuw24b
	ypKIKrYvXdy1bgC9rbMt7f0pvaW+xYAqRRsWVdJT4
X-Gm-Gg: ASbGncvoAfKzdQ/4ztjo8g3Lm5t6SxeBPCgRdlAKKrpPyCNsd1Hxi77uKdED5i7q0qJ
	prPQphydbnyJOGYD0dlLXjQOYumDDv1QMoPchz0d5ipj6WKIxHGpfkM2dNhSsvsOb28MWHfnmct
	wM/HJ907CrIuy7VPDIUlMualQse1TB2BLCEGgYw/pZ2UXqYK2Av0s5A15bYNH13/SyX9sNBprTv
	S5s0Jsmgpz1+0NuQrkjlMpdICYgpc0GCcES3MwDs1D+xUgetVTcGiekXWoG35sAezzROZZXi053
	IhJN4eXOVq8OzFtccjM0UGv4cg==
X-Google-Smtp-Source: AGHT+IGRu6yI1emkCCw3nvVlzdH/6fU0sebXYjptgLv/4PO9Xk3ol/HgZ5f+hbDRyxJrRiKEy/KfoNbWzUlcluN7VUM=
X-Received: by 2002:a50:9e2a:0:b0:639:e9a4:a5f1 with SMTP id
 4fb4d7f45d1cf-63c1f6cef09mr20904049a12.27.1761236854479; Thu, 23 Oct 2025
 09:27:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002113404.3117429-1-srosek@google.com> <20251002113404.3117429-3-srosek@google.com>
 <CAJZ5v0iQToOkedruYqsowSm8=fxpnyJf86JJHB36E8+aCSZ5Hw@mail.gmail.com>
 <CAF3aWvFSomq+cm2sj+KjkYw=WODsrwH-VLDL=yOc6o9dqc5hWA@mail.gmail.com> <CAJZ5v0g72U3+u_KedKpZh2TuN-iYbXPcnZhN16oDvi4UqUTr7Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0g72U3+u_KedKpZh2TuN-iYbXPcnZhN16oDvi4UqUTr7Q@mail.gmail.com>
From: =?UTF-8?Q?S=C5=82awomir_Rosek?= <srosek@google.com>
Date: Thu, 23 Oct 2025 18:27:23 +0200
X-Gm-Features: AWmQ_blF7s0d_2rpPBOJV_yCAuUzVG3-BC5mVNgcU7WAEA9ki3dMFD97y8RMCx8
Message-ID: <CAF3aWvFc5ZZo3VaJSr68FwGuCFYJU=tXsJ6Fm1vmNLs4B=+8dg@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] ACPI: DPTF: Move INT340X device IDs to header
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Alex Hung <alexhung@gmail.com>, Hans de Goede <hansg@kernel.org>, 
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, AceLan Kao <acelan.kao@canonical.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Tomasz Nowicki <tnowicki@google.com>, 
	Stanislaw Kardach <skardach@google.com>, Michal Krawczyk <mikrawczyk@google.com>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 5:11=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Thu, Oct 23, 2025 at 4:41=E2=80=AFPM S=C5=82awomir Rosek <srosek@googl=
e.com> wrote:
> >
> > On Wed, Oct 22, 2025 at 8:46=E2=80=AFPM Rafael J. Wysocki <rafael@kerne=
l.org> wrote:
> > >
> > > On Thu, Oct 2, 2025 at 1:34=E2=80=AFPM Slawomir Rosek <srosek@google.=
com> wrote:
> > > >
> > > > The ACPI INT340X device IDs are shared between the DPTF core
> > > > and thermal drivers, thus they are moved to the common header.
> > > >
> > > > Signed-off-by: Slawomir Rosek <srosek@google.com>
> > >
> > > I've actually started to wonder if int340x_thermal_handler is needed =
at all.
> > >
> > > It just creates a platform device if the given ACPI device ID is in
> > > its list,
> >
> > That's true. It creates platform device for the given ACPI device ID,
> > but only if CONFIG_INT340X_THERMAL is enabled.
> >
> > > but acpi_default_enumeration() would do that too with the
> > > caveat that it would also be done for CONFIG_INT340X_THERMAL unset.
> >
> > Not exactly. scan handler returns ret=3D1, so device is marked as enume=
rated
> > https://elixir.bootlin.com/linux/v6.18-rc2/source/drivers/acpi/scan.c#L=
2314
> >
> > > That should not be a problem though because if CONFIG_INT340X_THERMAL=
,
> > > there are no drivers that will bind to those platform devices, so the
> > > net outcome should be the same.
> >
> > If CONFIG_INT340X_THERMAL is not set and there are no drivers to attach
> > to platform devices and int340x_thermal_handler is removed then you are
> > right, acpi_default_enumeration() will enumerate ACPI bus anyway and
> > create platform devices for all ACPI device IDs. However, for me it loo=
ks
> > like it was intentional to prevent this behaviour unless INT340X driver=
s
> > are "present" in the system (were enabled for build so should be).
> > I am not sure how DPTF works and what may happen if platform devices ar=
e
> > visible in sysfs while drivers are not loaded.
>
> Such a dependency would be unexpected and confusing.
>
> Also, I'm not sure why it would be useful because the lack of drivers
> means that the devices in question are not handled, so no
> functionality related to them is provided by the kernel.
>
> > >
> > > Thus I'm wondering if the way to go might be to drop
> > > int340x_thermal_handler and simply keep the device IDs in the drivers
> > > that use them for device binding.
> >
> > Even better. If it's not required for DPTF to prevent enumeration
> > on the platform bus I can simply remove the scan handler.
>
> I would at least try to do that.

Makes sense, so I'll give it a try. Removing handler will result with
only two patches, one to update dts_doc_thermal kconfig and second
to remove the dptf scan handler, the rest won't be needed for a new
patchset. Should I send it as v4?

