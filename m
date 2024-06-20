Return-Path: <linux-pm+bounces-9708-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AB6910FF4
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 20:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5F681F22E83
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 18:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0511C0DD1;
	Thu, 20 Jun 2024 17:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKDWfyzm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075371C0DC7;
	Thu, 20 Jun 2024 17:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906280; cv=none; b=PoTjZXD3B3ZfdhGzN4ZiY8WCpJrw8Xr6awG47961Tkmh1snm2OcrzOzkjPBWYGVIZXDbIBrnxJqfUEmPnf7mvHwMSLpjxMd5WQJM/tdloHuUajtpe9fkXW1Vhmr8jkFH+ED4/0oWliqDDvO2GQJEf2WUZAYHpaln9xqAZBU1UTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906280; c=relaxed/simple;
	bh=4bCyXtthAFkbsH2+NEQwplsuZeRsrS5uPvYZ7QzNVVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LtAUFnAo5LVFEVWzjiuoq162YKtPEAovusUtVGkxUyDDZLzCdXs/CDO0UR/W0LrhU2C4EOBuTCFqZJtSCM3ry5Cu6BbLfwWNibqG/iyhST2lrkRGLyiPorAUH8nzdZS6AD26icd0ZKy97L5i5Wffow4PbF2Re3xNmG8cEpGhcj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKDWfyzm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 914A0C4AF0A;
	Thu, 20 Jun 2024 17:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718906279;
	bh=4bCyXtthAFkbsH2+NEQwplsuZeRsrS5uPvYZ7QzNVVo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mKDWfyzmoySPRsK4BfM0ik7ZlzIpDCjTm79qOemh5QGGBIGoinZCBXjXUwtXPX9Cp
	 2RtVFa+wunfQoPW/Ufk1jcHwoTEBYYWei87GDBrnCpj5xy1t2sBNKwy0Pzrt4DUDtB
	 Uqknktmw3oX2E6It1SJqc4nDTxZWq+T1z2lrsuQ1gD79hfdx1iC79PIjxbP8DCPk3Q
	 gNAovXZBvC1dkyc2mySJX3g7MIIBXrOXBrLGShhAaJ065IPwrjbSayrBdpdPSaoGSJ
	 P0nMUwMMeqjY6szxFo8/XtFU/Nr0imv2RSN7BCeUDf3KqcQIIoRxePce3avQKYr3oa
	 khjompqVmly2A==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5baf76164fbso142084eaf.1;
        Thu, 20 Jun 2024 10:57:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUPBbJ52qAcYnbzxSDkLHn9Yz/DBItw7LpxvbRm00TaqMsUchc/zTvvhZgU+Daq0GwlVaa2eNqI4u+IvfU+0vgdy9UC2WSxzueWdbh5rixEqxyezyol5W788+FRGJ30+/zJ4hC4i0g=
X-Gm-Message-State: AOJu0YxiISLMISrG8qDOMCjzCF/7HhRF269x0/NpSZXxIENwhiVvD/J0
	rlKjmOsjqUGHwlmyT1xH9pxWlLE/A7J2PAmsgGNOtUickIOWunP16IkG5zLnwdQEE5ZPMpczvvg
	vQ6xuoTXOiBUzX7QiJhLzTuRH6FI=
X-Google-Smtp-Source: AGHT+IFh4bYzrqWPFf1eR/+oQK7fNO6ATrGARpU3u98/IV984+MFgS814jByg/N7OUIIur719jePuK9i+Y+A5ZflHvA=
X-Received: by 2002:a4a:c60f:0:b0:5bd:af39:c9d9 with SMTP id
 006d021491bc7-5c1ad9093ebmr6990270eaf.0.1718906278917; Thu, 20 Jun 2024
 10:57:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619031250.2936087-1-tj@kernel.org> <20240619031250.2936087-2-tj@kernel.org>
 <CAJZ5v0i=0QqkvjA9mnqcX6Yv-T+rQ7ZKvuF1HPJL8pG2kqicGQ@mail.gmail.com> <ZnM3J7pvg6fyksby@slm.duckdns.org>
In-Reply-To: <ZnM3J7pvg6fyksby@slm.duckdns.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 20 Jun 2024 19:57:47 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hSZSExp=h3=V9=41BkAX2d9nxjVd+ZhENETSJ-hg9Seg@mail.gmail.com>
Message-ID: <CAJZ5v0hSZSExp=h3=V9=41BkAX2d9nxjVd+ZhENETSJ-hg9Seg@mail.gmail.com>
Subject: Re: [PATCH 1/2] cpufreq_schedutil: Refactor sugov_cpu_is_busy()
To: Tejun Heo <tj@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	void@manifault.com, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	mingo@redhat.com, peterz@infradead.org, David Vernet <dvernet@meta.com>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tejun,

On Wed, Jun 19, 2024 at 9:53=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello, Rafael.
>
> On Wed, Jun 19, 2024 at 08:45:42PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Jun 19, 2024 at 5:13=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote=
:
> > >
> > > sugov_cpu_is_busy() is used to avoid decreasing performance level whi=
le the
> > > CPU is busy and called by sugov_update_single_freq() and
> > > sugov_update_single_perf(). Both callers repeat the same pattern to f=
irst
> > > test for uclamp and then the business. Let's refactor so that the tes=
ts
> > > aren't repeated.
> > >
> > > The new helper is named sugov_hold_freq() and tests both the uclamp
> > > exception and CPU business. No functional changes. This will make add=
ing
> > > more exception conditions easier.
> > >
> > > Signed-off-by: Tejun Heo <tj@kernel.org>
> > > Reviewed-by: David Vernet <dvernet@meta.com>
> > > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> >
> > Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> >
> > for this particular change.
>
> If the cpufreq_schedutil part of the second patch looks good to you, woul=
d
> it be okay to route together with this patch through the sched_ext tree?

Please feel free to pick up the $subject patch (with my ACK).

As for the [2/2], I don't think I'm sufficiently familiar with the
scx_* stuff to make any comments on it, either way.

Cheers, Rafael

