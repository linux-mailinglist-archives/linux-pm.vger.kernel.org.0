Return-Path: <linux-pm+bounces-38393-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45354C7BAC6
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 21:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2F373A7136
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 20:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3416B309F12;
	Fri, 21 Nov 2025 20:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S434OzRd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F677309EF1
	for <linux-pm@vger.kernel.org>; Fri, 21 Nov 2025 20:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763758121; cv=none; b=aqJwybOTHUCx6TPqqATdjvCdEhmRAXBV5sbXtLncsEe62BnLYT2YbLM/nFW9tP8cAoD5Z7SVf3RiQoM3UOGgoCQWygCT7GSmS8nMQIbPHT950GfzxRybZIvN6u3ihA3NFYUedRwh9RNJlGMcrGsjzy/RNJAabqcFJSLwftaeiSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763758121; c=relaxed/simple;
	bh=6SP3t+XmrpuUwy7xRGD5mkIoFlRuzjo+IHwjwHnyGH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QG0IxsaOSsqGDmCqS549ikjuS49v3bVojnxm6wvGDX60sE/WQWVgaQtAXHKId4qKyv1ATv/vJPOoxhqgNf5jAFH1FVeyBPsArLZJDmxWXQjfuTmAt6a+zc4dMeLpbDu+9/rSiAmXg8eaI6s4deazLWsbGUAg3j3MA1nQLbU//DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S434OzRd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B9BC2BC87
	for <linux-pm@vger.kernel.org>; Fri, 21 Nov 2025 20:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763758120;
	bh=6SP3t+XmrpuUwy7xRGD5mkIoFlRuzjo+IHwjwHnyGH8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=S434OzRdHdEbQ9rItxxMnT0mwo22LMmPU7HHsuYX2pu0QaRbF7bcbSjK0UKLCBof5
	 VvECCLTgOiXhQM7S61laxYl+Ok/iuPzBtc6yc7B1WvDzAe5hf8XbnkpsX7KveEcHik
	 W/Gn5DSbGPKzX5JM5dlb7f3SMFZ5w893ox2zDHGXR6L7etyd0t0duRj1KvZfRcF1nh
	 yNb7cDHVpudJzdFWZFMfizSUs/W+fFTDTXWdgA5k0sN4fuGYLSl3rnbJI7xtW6dgsM
	 rgkGKg4W2rNVcd8K6dYBdSKjjJQQobHC+1hug9RZl+WNo9Fg8MfG4pwqwNWfaix2es
	 0ExgTEK21yafA==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-657464a9010so602234eaf.3
        for <linux-pm@vger.kernel.org>; Fri, 21 Nov 2025 12:48:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUYieFfulxA2hnkstup0OldF56xvGNq6HJnLriVPIbLE7J9ZI1TTtzT/7kqDKUt0xNAQUyAYkc8xg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhHcunzIunhKh0zwoX89MqkwmCJpRRfxwTv3AvQgtfA6EJVnmn
	Y3hYQrPeBB2D0he0g2gsb+eS2ais8kCbobY8rJV2nTQZ3bq9kVj3U7xtsVKYzIrGzxlAotZt/9K
	aIRuoQfUa0BkafgWb8BPhb4wUivVW3V8=
X-Google-Smtp-Source: AGHT+IEfWhK0vaY6gcDzTkMRIGYHeKBewn4hK9KthJdHLYp0DiGP50atsCmFHbakvQi2kS8jvuCyqszNJ8sqJhHTECI=
X-Received: by 2002:a05:6820:2008:b0:654:18f9:10f4 with SMTP id
 006d021491bc7-657908517dcmr1374943eaf.0.1763758119875; Fri, 21 Nov 2025
 12:48:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121000539.386069-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <515d0c022fff823eb7dbad302ab2b4443d6926fd.camel@intel.com>
In-Reply-To: <515d0c022fff823eb7dbad302ab2b4443d6926fd.camel@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 21 Nov 2025 21:48:27 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h=tikYWnUZfh_nqzAcpDiAMXe=0LOX8Y+tWOMO1cpBeA@mail.gmail.com>
X-Gm-Features: AWmQ_bkNBBnnoqchAXaJJ-vxhVvXzu_iqh3QKuzsy0Fby9H5CFJ9sS9ysyZd5qw
Message-ID: <CAJZ5v0h=tikYWnUZfh_nqzAcpDiAMXe=0LOX8Y+tWOMO1cpBeA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Add MSR-based RAPL PMU support
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc: "sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	"rafael@kernel.org" <rafael@kernel.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, 
	"Zhang, Rui" <rui.zhang@intel.com>, "lukasz.luba@arm.com" <lukasz.luba@arm.com>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 2:50=E2=80=AFAM Pandruvada, Srinivas
<srinivas.pandruvada@intel.com> wrote:
>
> On Thu, 2025-11-20 at 16:05 -0800, Kuppuswamy Sathyanarayanan wrote:
> > This patch series enables MSR-based PMU support for the Intel RAPL
> > driver in the Linux powercap subsystem.
> >
> > Following are the patch details:
> >
> > Patch 1/2 - Preparatory patch that updates the read_raw() interface
> >             to allow atomic-context callers.
> >
> > Patch 2/2 - More details about motivation of this series and adds
> >             MSR-based RAPL PMU access support.
> >
> > This series has been tested and verified in the Panther Lake and
> > Wildcat Lake platforms using perf tool.
> >
> > Please let me know your review comments.
> >
>
> Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Both patches applied as 6.19 material, thanks!

