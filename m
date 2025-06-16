Return-Path: <linux-pm+bounces-28823-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CCFADAFCE
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 14:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 552491885362
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 12:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7414A2E4259;
	Mon, 16 Jun 2025 12:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jN7PV+OK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A052E4250;
	Mon, 16 Jun 2025 12:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750075576; cv=none; b=isDPNaD1YlTmmmY4AXGGPawbBzRcKkyx7CUJFClrkDB5TqO3s+kVNdIeJawlSxQXi+bbcYlc1mTFiNaNsLaInlVAzuVr8AbdpBvjLTJTjXnAAhAq2bElfM92FPhM5VmyZan5DLmq31Bb+i+kCoxJQHD9MjSCc5OaMG7bQ2hyJ3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750075576; c=relaxed/simple;
	bh=4uEpYiyn+cDmCnrHepPRVMLDX/06gaPZ5NPiOUGm4UI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IOA+2NEEr9Eawzwg7msL7XL3jzXskC0XzeW54dJ9lMoV157Ga5u2xv/Jn1/Kj0DeOwzVydzpZEm7aC315ZnGXk9sCTdHH5McKYGoERQJrnu9JdYjKWuyuyhL+V1dlofFV9OkqEVFkBxNhn+ZdRM+JkJw7wMLOFLR+uUsowDz7L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jN7PV+OK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E13C4CEF1;
	Mon, 16 Jun 2025 12:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750075575;
	bh=4uEpYiyn+cDmCnrHepPRVMLDX/06gaPZ5NPiOUGm4UI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jN7PV+OKe4kK7t9sezCh4YDmcotyMEV/FWqyy/aCKXD/bOqeWDNrs47EPsxF5GuDQ
	 csKk42KVD0tGGf90XBNrOhPMfW7/wXCyudLRkjG7uIbjUYgGCKAOxIqlyv9viPilW/
	 VwM7G9nWHt+PP4bJbnvzUkU28YilMdnTJBhUpfC7wx9zxLh+zXrUlBWxJXnW9WSomp
	 WeDlSpVjsrOD3B2friMRlenZU4uVcEj5bJ38HHVgsK/0TawB6PzQRx9BZy1oKRlTXl
	 /zcUlk5lZHAoLie3m7KXqs4a6iLQJIdgXxz5r+GLShy7pR9tY9Q+PZHHsN1UmO6E3X
	 d6qg5dobC4Naw==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-610dfa45fa2so2591135eaf.2;
        Mon, 16 Jun 2025 05:06:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVK4QGEhh7f0DJ19qy33VJv8HMPLGbBYXAdAouf16xFplHWcFULCtXGZhG1/IhUVC0AeTMMPGANLSQ=@vger.kernel.org, AJvYcCW6qqBQQlksWCQgPAVNeIL0zXT1h9ULlDFcfyUxgdQj7Z3BNrSzW34RNXxEHm/jSmdu97fwmpgjZcroSa0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyihupECx1c3Rm/doFd6vTSWSByybZkbZnEjT2QzOvK5o0k6rJt
	DLQujCpVLQFpYTTvbzFS9zy0VyBXAtQ1LJ0AWrmli/GJgi/98hw3DGtYkEM2HOkop+2SRFr4Krq
	we21zr2vkVgRIvdRf6D9UVDiF1NLCmAc=
X-Google-Smtp-Source: AGHT+IFy1zym+4Q5imP+75KVhgYVa7eHhY8Xhr4U2gwmYKuGk22DNuQAO20NmOw30FKtPOKaK9ZjcznZH1gHNpaBOEE=
X-Received: by 2002:a05:6820:2290:b0:611:6fa:fbb8 with SMTP id
 006d021491bc7-61110fdf602mr4938153eaf.6.1750075575051; Mon, 16 Jun 2025
 05:06:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613214923.2910397-1-srinivas.pandruvada@linux.intel.com> <0dc5ad78ecd3e9a692c50ffb860bb1b0f93fef39.camel@intel.com>
In-Reply-To: <0dc5ad78ecd3e9a692c50ffb860bb1b0f93fef39.camel@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 16 Jun 2025 14:05:59 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jY1HRqDtCBkDWD6FyWNGS+U1K2Y=9BqS7rgVZYS06dMg@mail.gmail.com>
X-Gm-Features: AX0GCFsY5nZpGvBPcGJEONjmDPFJldt-XLNs0OESQtrgSBIELofuZNG7LUPK0gU
Message-ID: <CAJZ5v0jY1HRqDtCBkDWD6FyWNGS+U1K2Y=9BqS7rgVZYS06dMg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] thermal: intel: int340x: Add throttling control
 interface to PTC
To: "Zhang, Rui" <rui.zhang@intel.com>, 
	"srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>
Cc: "lukasz.luba@arm.com" <lukasz.luba@arm.com>, 
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 2:47=E2=80=AFAM Zhang, Rui <rui.zhang@intel.com> wr=
ote:
>
> On Fri, 2025-06-13 at 14:49 -0700, Srinivas Pandruvada wrote:
> > Firmware-based thermal temperature control loops may aggressively
> > throttle performance to prevent temperature overshoots relative to the
> > defined target temperature. This can negatively impact performance.
> > User
> > space may prefer to prioritize performance, even if it results in
> > temperature overshoots with in acceptable range.
> >
> > For example, user space might tolerate temperature overshoots when the
> > device is placed on a desk, as opposed to when it's on a lap. To
> > accommodate such scenarios, an optional attribute is provided to
> > specify
> > a tolerance level for temperature overshoots while maintaining
> > acceptable
> > performance.
> >
> > Attribute:
> > thermal_tolerance:
>
> yeah, this is much better to me.
>
> >  This attribute ranges from 0 to 7, where 0 represents
> > the most aggressive control to avoid any temperature overshoots, and 7
> > represents a more graceful approach, favoring performance even at the
> > expense of temperature overshoots.
> > Note: This level may not scale linearly. For example, a value of 3 does
> > not
> > necessarily imply a 50% improvement in performance compared to a value
> > of
> > 0.
> >
> > Signed-off-by: Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>
>
> Reviewed-by: Zhang Rui <rui.zhang@intel.com>

Applied along with the [2/2] as 6.17 material, thanks!

