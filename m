Return-Path: <linux-pm+bounces-26223-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A4DA9CA65
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 15:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A55407B8A68
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 13:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D584253949;
	Fri, 25 Apr 2025 13:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ml3E6Zhb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7311253348;
	Fri, 25 Apr 2025 13:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745587857; cv=none; b=tthDlGFseaUxRZs+sRzR6E+T0VPkau+L2MHuRxd0Uv7rqbGBP3GvVvh2LbUcayC+8mFBO7jI1Je/W0triJ7BkZ3YoZGuruSyCFCaRCwFxIjvYcX91lsn6dYgRbpb1L+WdekgXwZOOQlVJaQFGZxEi8YYHikWEik0HjnVmRF3u3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745587857; c=relaxed/simple;
	bh=sNj2A/EDw7ZdmP8BVMc/ZzHXMFD2k+M3BHMDaypuwYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W2hednFAAD81SegHkKiMRik1wAGOrX+vYIJ/rd4ZRLnlhFeI8UnfB5+8beoxttNtUDd6KalmgXB/lRMCHtKENB7KKOqNdx1l0O79WDHg2H3oC1Cisj8dbeVPaohKfb5WuBXZU8DAwnnlu7l0LC++DpcMJypy4p5kV0IpsI3N38o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ml3E6Zhb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47FEBC4CEEF;
	Fri, 25 Apr 2025 13:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745587857;
	bh=sNj2A/EDw7ZdmP8BVMc/ZzHXMFD2k+M3BHMDaypuwYE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ml3E6Zhb2SotU8E+L+dkC+ZLsqSjNI1f8GjwEMBr7zcmbwDWSdkUPhXvX2fRE05kt
	 Ip7/Octstq7/Dv4FRaSXKuXzv9OX58jf9U6BumewoOQl81Ru5msYJmt2S4ZphRzryj
	 Ccb2kH+eN6GnnxjkmHsnJnvGaQz7dQaMvh4G9fDFbTDyyVP4ysmJILMVx/fvOagOGj
	 vhb2NlOpjy7SW17yaNOY5Gsq7Du4irAB0AI7Gcau7NzONRULG2sqMfdVuQrfD9NWY7
	 zEbVVpPwUBpBQn/78lC8T+DmF4+b1PeP3JP3Fu0g1HDz6LnBLSvc5WHgsfToeTl78d
	 k9RUdHEGa304w==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2b8e2606a58so1306902fac.0;
        Fri, 25 Apr 2025 06:30:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVVgGwidqHtwCwuv98pXaioA36TKglVs1GMlE6B0BLFxlEGaNvubBzy6+V4zvbjmhDmfdRPLbNKzbw=@vger.kernel.org, AJvYcCWiY1qBBNWUr7240EyGeeKYAmabs99wg3u/hRsNp8W/DlGK7cN+spCGo2hSYM+DNB07S/HxfkWfrsGty1c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpeb4uVbgEtnEIDYp5XfeGTdaCSQhta2tdJKK7bXAs88NxvzUn
	EU3ep5JxSBivQ/WG6Za7nN2FO5AxvNqY6xwRXRaCmZZBgF/NIfCzO5Xr+CFRxDqjCqPs+JuOYtS
	beVKqq6bdlbS2JNJufLTJfbwkYt4=
X-Google-Smtp-Source: AGHT+IGnRgdYGPtbfq0nkjJq0Qn1QIsVI2ProDoVmuhcH47kNRjWvmxksxDMVtDTcaL4/8Q/DAY63T1o6tTuFhv20/o=
X-Received: by 2002:a05:6870:d686:b0:2b7:d3d2:ba53 with SMTP id
 586e51a60fabf-2d9a33102eemr1121477fac.12.1745587856587; Fri, 25 Apr 2025
 06:30:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5896780.DvuYhMxLoT@rjwysocki.net> <aAuMVMQjdEqegT8n@linaro.org>
In-Reply-To: <aAuMVMQjdEqegT8n@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 25 Apr 2025 15:30:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hS9BEAQLUxf983EMgA53euOY837BD4nb2bKE=2htPOWQ@mail.gmail.com>
X-Gm-Features: ATxdqUF9CfayYo9hmCWb8y1bN1A5FPEN2zs8yWFELZN0J33Q5fYsuzI_rtlpcL8
Message-ID: <CAJZ5v0hS9BEAQLUxf983EMgA53euOY837BD4nb2bKE=2htPOWQ@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: Fix setting policy limits when frequency
 tables are used
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	Christian Loehle <christian.loehle@arm.com>, LKML <linux-kernel@vger.kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Sultan Alsawaf <sultan@kerneltoast.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 3:21=E2=80=AFPM Stephan Gerhold
<stephan.gerhold@linaro.org> wrote:
>
> On Fri, Apr 25, 2025 at 01:36:21PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Commit 7491cdf46b5c ("cpufreq: Avoid using inconsistent policy->min and
> > policy->max") overlooked the fact that policy->min and policy->max were
> > accessed directly in cpufreq_frequency_table_target() and in the
> > functions called by it.  Consequently, the changes made by that commit
> > led to problems with setting policy limits.
> >
> > Address this by passing the target frequency limits to __resolve_freq()
> > and cpufreq_frequency_table_target() and propagating them to the
> > functions called by the latter.
> >
> > Fixes: 7491cdf46b5c ("cpufreq: Avoid using inconsistent policy->min and=
 policy->max")
> > Link: https://lore.kernel.org/linux-pm/aAplED3IA_J0eZN0@linaro.org/
> > Reported-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Thanks a lot for the quick fix! It works for me. After the CPU frequency
> was throttled due to high temperature and the device has cooled down,
> the CPU frequency goes back to maximum again.
>
> Tested-by: Stephan Gerhold <stephan.gerhold@linaro.org>

Thanks for the quick turnaround!

I want it to spend at least a couple of days in linux-next and I'd
like to give people a chance to review it in case something is still
missing, so my current plan is to push it for -rc5.

Thank you!

