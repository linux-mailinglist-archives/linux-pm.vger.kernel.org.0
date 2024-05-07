Return-Path: <linux-pm+bounces-7585-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A938BE2F0
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 15:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35DBE1C21B65
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 13:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADEB15B995;
	Tue,  7 May 2024 13:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVAjNaNm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A0A15B150;
	Tue,  7 May 2024 13:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715087138; cv=none; b=B3+6gi6t3Iyr9GI7qZE4ijpHP+0A9wzrK/xjLr559HLhGum+HUyrr+4sofV5cHKswhJiwNmSOy/aLT3SOUoWFrlLPDrR0D2khxFajaTOlYf7RruciWDQlj/LUelEjuFHH9lwwKQoMEXjJ6mEhhGklYkaMmXmH6auK566MMhaV78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715087138; c=relaxed/simple;
	bh=Z8VMtHJyfVYcVZJH2yLQCtvZuapbpiYbq5cmW07OS1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G/KCYSS5NOgwbt3n0agZjoaT489e0pFKIU//Wxk0G6nbXWm/DH31ITV+/hd3C+HduuAfUKAAD+aBHUqDM3KivW30eWUWu6YF1MCkPCbZmrwKSw/fqYKzNCJFFEZ1N9a3q8wCv4neg8bv31HDVE7AP1DRwmStxMRcoO/3MPzmL9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVAjNaNm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BBF1C3277B;
	Tue,  7 May 2024 13:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715087137;
	bh=Z8VMtHJyfVYcVZJH2yLQCtvZuapbpiYbq5cmW07OS1s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AVAjNaNmc9Th7GIHT6/yzrj/n0Wke58WvBFb1nfjLFtMmMxjFy1+CbmpVUoDi+51b
	 ZDWI9UiCqD2uD2Bu/MlqHVc8rKzSxQ7udgBmU6hBeu/D/tdRyR/zszsFYtbyS3D+S1
	 wHzu3yEQ1rDxpZTQ+4xcRUSw+yzh6N4klVaYb0ADJAxQyyRe58iF//ofKhhm465gJo
	 JwBVnCqdt2KcEjV8CGZuvWavnDEbnhYRJ7uAH9QSj6ZvMO6r6/3zwHs0Si0ld5zu5P
	 3Gwg5soZadpRYxMLkge0qdFRs1mLmXkj0wxvSb2YWlvkCDJ8sJ5JapcgDzSgiOdX0U
	 XplQlT2V1armw==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5a9ef9ba998so740167eaf.1;
        Tue, 07 May 2024 06:05:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXtqr67YCynhv0SGE0Ar3+uybgiO9HfDzmu6yPOVpFNVDh0zAdGEj65oM1muz93qQBFx2YOY4JrJihK2NoFpUbce8PYhsRBZxE9vaDF7BCJRXRNqMYDdKQ9lg181UKUeN+xZjZH0hc=
X-Gm-Message-State: AOJu0Yxgp+Ai2/2iT7k4Sp2RJfpb3LfP8E0K2A5+8AzJwSNM18QXemIM
	5zHGcJzQ7hq/WsNCJisy418JtgiGC1jm/X8f/oqLF94Krt+f0ICCggxR0aZuKG8OKgsV2q8ouoD
	xS39pyBNiplDLB5NIh+Xr4Uc1/MA=
X-Google-Smtp-Source: AGHT+IEfljPaDk5f6tWjsMdb88ycr4+1AhpQrlLpvrmnQTEHHTOwZrN7Rjbk2i0MevVO/5xs8WCh1mn/4QirEKgQE4s=
X-Received: by 2002:a4a:c805:0:b0:5b2:89f:452 with SMTP id s5-20020a4ac805000000b005b2089f0452mr6095425ooq.1.1715087136751;
 Tue, 07 May 2024 06:05:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240505-epp_cached-kdoc-v1-1-c03800fe0d63@quicinc.com>
In-Reply-To: <20240505-epp_cached-kdoc-v1-1-c03800fe0d63@quicinc.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 7 May 2024 15:05:25 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gOA2cTk4vDq2H=BwNWMo62QHnfUtHL86gSCYYxykVbGA@mail.gmail.com>
Message-ID: <CAJZ5v0gOA2cTk4vDq2H=BwNWMo62QHnfUtHL86gSCYYxykVbGA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: fix struct cpudata::epp_cached kernel-doc
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 5, 2024 at 9:07=E2=80=AFPM Jeff Johnson <quic_jjohnson@quicinc.=
com> wrote:
>
> make C=3D1 currently gives the following warning:
>
> drivers/cpufreq/intel_pstate.c:262: warning: Function parameter or struct=
 member 'epp_cached' not described in 'cpudata'
>
> Add the missing ":" to fix the trivial kernel-doc syntax error.
>
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstat=
e.c
> index dbbf299f4219..7ddf05c9ba88 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -213,7 +213,7 @@ struct global_params {
>   * @epp_policy:                Last saved policy used to set EPP/EPB
>   * @epp_default:       Power on default HWP energy performance
>   *                     preference/bias
> - * @epp_cached         Cached HWP energy-performance preference value
> + * @epp_cached:                Cached HWP energy-performance preference =
value
>   * @hwp_req_cached:    Cached value of the last HWP Request MSR
>   * @hwp_cap_cached:    Cached value of the last HWP Capabilities MSR
>   * @last_io_update:    Last time when IO wake flag was set
>
> ---

Applied as 6.10 material, thanks!

