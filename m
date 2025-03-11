Return-Path: <linux-pm+bounces-23848-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 869FAA5C44E
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 15:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AB173A6079
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 14:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A508B25D907;
	Tue, 11 Mar 2025 14:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFz45gOv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1C825D904;
	Tue, 11 Mar 2025 14:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705095; cv=none; b=lc/NqtW778lDfxk9j/WsQxfUUdYU46C6OyXMOygGvRJVCybzQKov8zDiPBGKR6U+NL9ma6QIJK+mvhEiDdUgp3ZCwWxeTHid+dALqVUoXhZeklQIN2+Q6Wy/iTtig3Ss+LrOX86NcywbJe0GR0ya7q+If42H3xX04uoeQcUUhPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705095; c=relaxed/simple;
	bh=y4ryVf0YNOjwtuAvfEB/68jmLIXNfkpji8SHUgQfHwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P+tIjpZ30MLwftnr9QOpIvZjrUiTKbl+g2AOJZAO8hV4kwl8d9wBZUb970l5AmlsMXDp3FaCzuUufX7mZiDJkUZVgy0FRbVBrPvbeMmF+x7FlN0xyzugWDVN5BF3tTDabm8eXvjaoqUJQyODMmTwSZE/Cmez4ArZIhwfin9W0Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFz45gOv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F9EC4CEF0;
	Tue, 11 Mar 2025 14:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741705094;
	bh=y4ryVf0YNOjwtuAvfEB/68jmLIXNfkpji8SHUgQfHwo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JFz45gOv+mS407aMTJdf+Chu+DxdAgVN5NqikGL4HNq1CRmUQ+D/BiDH7OQoz8wEJ
	 WJvgIvDN3t/rDg8C+w90xthx0FWImZSj1Uqvaops/nHCukmcsTv4EYZja97Sr5PYFs
	 XRE1P9+H+SYd6N1ajzoWjiTRyNbS3q3wGyhms6pBLsh9pnMvGmedlB30y0qshKcHxm
	 0xEFooS1zkNYOibtxBQgJEUivIIFYgD8hTgVf/4UhY2i9XhgTkWOuM8ubMllw2x7t/
	 /wexfGIpLCMulxGHOLvuNJwhaRBvfb0aQQdaM5FWlV1c0emAphVwTS/E40Bi0cncYU
	 U5qh6gqurwvOA==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2c2504fa876so1470671fac.0;
        Tue, 11 Mar 2025 07:58:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVvB7N5eC04ZPLk7m8LXq07CAnKi9CKRpnNoRa3SfP482nROvpCzDEW1Jz9mj0oD/fW3r+TzhQ/aMtP0D4=@vger.kernel.org, AJvYcCWbK1TzlKJJ/LSiwMUEP5KcUlNwAECU6/uS03sCU5dGMjXtYaw2JbwCASnjNlWfYg6SymyFyeeMy7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYUY9bbYpMwflnFraoQhpX8I3waNMidfrlMg6gNgHWYgyxhIbQ
	SIYeIEvpf0RhQaAZ+MN6rWdmUU5QSPDmy3jH1Lgfql/OdiQnL3BMNY6Gl19skJH1gLr03bH7TDH
	/wWfecIGVYaa0Gfedqr7UCqs3BPs=
X-Google-Smtp-Source: AGHT+IFQOxYvpetHFZ5qF/modjQEJMQgK5sXcQo1XO+E1NqNBmeXGZ0DgBu5WKIIpycj+LOLM2pmlvVhXDd30xgHFNo=
X-Received: by 2002:a05:6870:b906:b0:2c2:5270:f182 with SMTP id
 586e51a60fabf-2c26136df6bmr9904732fac.39.1741705094125; Tue, 11 Mar 2025
 07:58:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307145547.2784821-1-ping.bai@nxp.com> <CAPDyKFqsE4nArB+Qn5gH5P7vVePpZ6Z7ruas2-EGYsctGV-=4w@mail.gmail.com>
In-Reply-To: <CAPDyKFqsE4nArB+Qn5gH5P7vVePpZ6Z7ruas2-EGYsctGV-=4w@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 11 Mar 2025 15:58:02 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jjezx5sUEZwsbsw-iZiwbirmB+690-syOCur26DvOSNQ@mail.gmail.com>
X-Gm-Features: AQ5f1Jpg9YGKxiXZ8IeOPwdPNsqgPkaGl3fl_2Y1dOoOEeGA0VymC_oHOAASzwc
Message-ID: <CAJZ5v0jjezx5sUEZwsbsw-iZiwbirmB+690-syOCur26DvOSNQ@mail.gmail.com>
Subject: Re: [PATCH v5] cpuidle: Init cpuidle only for present CPUs
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: rafael@kernel.org, Jacky Bai <ping.bai@nxp.com>, daniel.lezcano@linaro.org, 
	lpieralisi@kernel.org, sudeep.holla@arm.com, james.morse@arm.com, 
	d-gole@ti.com, anup@brainfault.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, imx@lists.linux.dev, khilman@baylibre.com, 
	quic_tingweiz@quicinc.com, quic_yuanjiey@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 3:43=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Fri, 7 Mar 2025 at 15:54, Jacky Bai <ping.bai@nxp.com> wrote:
> >
> > for_each_possible_cpu() is currently used to initialize cpuidle
> > in below cpuidle drivers:
> >   drivers/cpuidle/cpuidle-arm.c
> >   drivers/cpuidle/cpuidle-big_little.c
> >   drivers/cpuidle/cpuidle-psci.c
> >   drivers/cpuidle/cpuidle-qcom-spm.c
> >   drivers/cpuidle/cpuidle-riscv-sbi.c
> >
> > However, in cpu_dev_register_generic(), for_each_present_cpu()
> > is used to register CPU devices which means the CPU devices are
> > only registered for present CPUs and not all possible CPUs.
> >
> > With nosmp or maxcpus=3D0, only the boot CPU is present, lead
> > to the failure:
> >
> >   |  Failed to register cpuidle device for cpu1
> >
> > Then rollback to cancel all CPUs' cpuidle registration.
> >
> > Change for_each_possible_cpu() to for_each_present_cpu() in the
> > above cpuidle drivers to ensure it only registers cpuidle devices
> > for CPUs that are actually present.
> >
> > Fixes: b0c69e1214bc ("drivers: base: Use present CPUs in GENERIC_CPU_DE=
VICES")
> > Reviewed-by: Dhruva Gole <d-gole@ti.com>
> > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> > Tested-by: Yuanjie Yang <quic_yuanjiey@quicinc.com>
> > Signed-off-by: Jacky Bai <ping.bai@nxp.com>
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Rafael, I assume you will pick these up? Or let me know if you want me
> to take them via my pmdomain tree.

I can pick it up.

