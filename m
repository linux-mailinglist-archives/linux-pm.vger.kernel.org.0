Return-Path: <linux-pm+bounces-15975-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F206D9A42ED
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 17:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B28762820C6
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 15:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D32201277;
	Fri, 18 Oct 2024 15:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXCSdq51"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8F913A271;
	Fri, 18 Oct 2024 15:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729266703; cv=none; b=VHAZef34/esUzVho4dZdNKVVJ6UVt6cF+tg+5P4RL1o8x5Yn3qM/i8ODoxOfUc8Sr7z99sbQm3LJ26t94EpEviI7ZLhE7GYd6kudVnIjjZ4c/xKb5MZCnnFNeCf5lXs1MZ5p/bCsFFprFfpQziLIumHRBPKdxg48tXBSKNUaBDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729266703; c=relaxed/simple;
	bh=QVzTZxjNOE0M1li/z0q6FSJEzTWtod6BICNDhR24qUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NYlqLL8X6o91vPDc117e7WICc/b3xTeoYQiuKYaEkSJPlSX2niOtMGOVgZvBNJhYHXF9JBaTvfgW/jYhoGzo5da44In7FbzHDJDGSPbFXT62VPULXpB4v+UAOUFAsrJ3b8H+YUd6fsUtNGvFk1cUK5AJUyFmwa0nLK0HuA1GXXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXCSdq51; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E26C4CEC5;
	Fri, 18 Oct 2024 15:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729266702;
	bh=QVzTZxjNOE0M1li/z0q6FSJEzTWtod6BICNDhR24qUM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DXCSdq51uOyQQhpJZ40UXNptH/SNbKTR/8WEJ6FEvQb4o6MKnhKV2+CzODP9oyraF
	 rJLp3yEPIfmcrEnIw9mSa6i9RK3mrOVyucYwpiqjA21jc+t1zgCyK3THidQM5eOC8/
	 jSWruEAsSfKui9OU9V2xGnJTSWUyojOp6jk1G0AfxPPv9LB481CkClbEeDG8S35toe
	 Cx6R20I7IrW+yCJskmG+EY1Q3rbGNvMVGeI0gYF7nunUW6bYuh0y5uFOugPBJFGPvk
	 xH2um8OJbUfAtIyFN1LMFCs7JR831YdyjajX0ivd3VlwLolSZuST6ek320TmTYdSDs
	 xsUCsbS8WlzSg==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5eb70a7739aso918429eaf.3;
        Fri, 18 Oct 2024 08:51:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUuAQQco5vYstblsP7wHDQlPXlZ4sqr4HNku1y9nt1150iCGCsHQlKaNaGA8nyOOoi8dTRaF11GASv/CLljENssZzSyLA==@vger.kernel.org, AJvYcCWQLgb/eeh003jpqyY8yu4TIRV4z1qilEI6bzGLujAo/2iPrOK7LiUtcN50y1D3uZhkv+ru6swDYpoWaQI=@vger.kernel.org, AJvYcCXUP/RLMv9J59sFhKmmlbvb9tfb7RGuEjPkFehW6HDJpSbkyF3RnNpC6TjhQkTlrC/E/UwMqOIVzRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUW5A07+d8XX3jF37kF8oNB1KTBjF6JMsfrk7aHxm2fRlj1KrM
	YovAo3B9wq/Z2L1aJS3vxhNYE2cuqCen1t+vG5jCbeNQTuSMDPKHWW7ACmzP1pGqWMQuBJZuH9J
	S6gqcO76+sawwbweDqEw0oOnJCHk=
X-Google-Smtp-Source: AGHT+IFxBxqPqrTUzPnKxGUsZDhzcA+u57J6btm+kB1rkP0e/cNWH8xugrpHsm2L/ujl7kqV3FzfAy/1E84umq5cGXg=
X-Received: by 2002:a05:6870:468e:b0:25d:f0ba:eab7 with SMTP id
 586e51a60fabf-2892c2dee3emr2676610fac.18.1729266701780; Fri, 18 Oct 2024
 08:51:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017210439.3449324-1-david.e.box@linux.intel.com>
In-Reply-To: <20241017210439.3449324-1-david.e.box@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 18 Oct 2024 17:51:28 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j0ZG=2chXuAkc2NDp1+-_SKrGx1s0MHyNdr8weNqPbgQ@mail.gmail.com>
Message-ID: <CAJZ5v0j0ZG=2chXuAkc2NDp1+-_SKrGx1s0MHyNdr8weNqPbgQ@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] platform/x86/intel/pmc: Refactor platform resume
 functions to use cnl_resume()
To: "David E. Box" <david.e.box@linux.intel.com>
Cc: david.e.box@intel.com, hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, rjw@rjwysocki.net, 
	srinivas.pandruvada@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 11:04=E2=80=AFPM David E. Box
<david.e.box@linux.intel.com> wrote:
>
> Several platform resume functions currently call pmc_core_send_ltr_ignore=
()
> and pmc_core_resume_common(), both of which are already called by
> cnl_resume(). Simplify the code by having these functions call cnl_resume=
()
> directly.
>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
> V3 - no change
>
> V2 - New patch. Split from V1

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

>
>  drivers/platform/x86/intel/pmc/arl.c | 3 +--
>  drivers/platform/x86/intel/pmc/lnl.c | 3 +--
>  drivers/platform/x86/intel/pmc/mtl.c | 3 +--
>  3 files changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/=
intel/pmc/arl.c
> index e10527c4e3e0..05dec4f5019f 100644
> --- a/drivers/platform/x86/intel/pmc/arl.c
> +++ b/drivers/platform/x86/intel/pmc/arl.c
> @@ -687,9 +687,8 @@ static void arl_d3_fixup(void)
>  static int arl_resume(struct pmc_dev *pmcdev)
>  {
>         arl_d3_fixup();
> -       pmc_core_send_ltr_ignore(pmcdev, 3, 0);
>
> -       return pmc_core_resume_common(pmcdev);
> +       return cnl_resume(pmcdev);
>  }
>
>  int arl_core_init(struct pmc_dev *pmcdev)
> diff --git a/drivers/platform/x86/intel/pmc/lnl.c b/drivers/platform/x86/=
intel/pmc/lnl.c
> index e7a8077d1a3e..be029f12cdf4 100644
> --- a/drivers/platform/x86/intel/pmc/lnl.c
> +++ b/drivers/platform/x86/intel/pmc/lnl.c
> @@ -546,9 +546,8 @@ static void lnl_d3_fixup(void)
>  static int lnl_resume(struct pmc_dev *pmcdev)
>  {
>         lnl_d3_fixup();
> -       pmc_core_send_ltr_ignore(pmcdev, 3, 0);
>
> -       return pmc_core_resume_common(pmcdev);
> +       return cnl_resume(pmcdev);
>  }
>
>  int lnl_core_init(struct pmc_dev *pmcdev)
> diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/=
intel/pmc/mtl.c
> index 91f2fa728f5c..fc6a89b8979f 100644
> --- a/drivers/platform/x86/intel/pmc/mtl.c
> +++ b/drivers/platform/x86/intel/pmc/mtl.c
> @@ -988,9 +988,8 @@ static void mtl_d3_fixup(void)
>  static int mtl_resume(struct pmc_dev *pmcdev)
>  {
>         mtl_d3_fixup();
> -       pmc_core_send_ltr_ignore(pmcdev, 3, 0);
>
> -       return pmc_core_resume_common(pmcdev);
> +       return cnl_resume(pmcdev);
>  }
>
>  int mtl_core_init(struct pmc_dev *pmcdev)
>
> base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
> --
> 2.43.0
>
>

