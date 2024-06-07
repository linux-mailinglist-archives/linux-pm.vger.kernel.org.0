Return-Path: <linux-pm+bounces-8804-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F62900C73
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 21:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EB2EB20D48
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 19:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746E914036D;
	Fri,  7 Jun 2024 19:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+wUjyI3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A66AD2E5;
	Fri,  7 Jun 2024 19:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717788392; cv=none; b=Vs+w0tBGQteBLbsiYxfjK7BwoZ4HZtudQih5b9SP23r5LaSFsTi2BppOtQ2AMY7v5Ha60jV0UpnmiQnDUAVFCTWfYDF01JFH75FlDqnpT0sPsTz+7xn32ybaOlBwKH9VxfoRYbYKMIo4nsRXL7XsUooaUx6verJzlIP2o0tG2Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717788392; c=relaxed/simple;
	bh=G79+bqVInJHcymuYBymhLDPTm1SW8aHugZAKnQjXQoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tA3idvXg74cPdlIG4EJNzcZFxwOEyEAZIPX09HJwu/I5RtMwIaVBEsx3awDlWIHo23eC0uqDDsFyLX+aQfnqYGS6ihM17XorZvKSX9GCEf/0p5yGj3AGhlPSDMTNZkpPB17BzyubCyCmheXIeHzqCqeDos0NkNFHcELUn1FJD+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+wUjyI3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B8AC32786;
	Fri,  7 Jun 2024 19:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717788391;
	bh=G79+bqVInJHcymuYBymhLDPTm1SW8aHugZAKnQjXQoM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=B+wUjyI3GdObFOF2X8xCI8HV4H3u+nkcrMGrDH2+DwfwB1e0Tb/5FJVtL6i/dpEH8
	 AUXWisqNYutnJOF+iphclC3qHtL68TD1J7UvDTJyf0EccOyN/OSw2SoyNdJzy5vZRl
	 Tv3rdS2AEO8fp8/Evh7Sq+zdHUCIUIoDss4CK3FFK98WwoApb0JCtWV9b0DWxb9eP6
	 5cPA1n5BL28Zmavk8fKD20Bvolan4gQG00so1x7nuibFrE8pbWMqKovGcETbTQ1akZ
	 lY7dqeLqfsZ/1ucCRgKPrT7q3qErDIt3d8Lu4Y39hOA2cszfevcN6hng1zS65q9C4i
	 QT8B2NhNlEyAQ==
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3d21c5b48f5so14167b6e.0;
        Fri, 07 Jun 2024 12:26:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV4NiPGHuHfQs8d/fjZPKbb5QpPsFej7pHcMRIYTrgkyKsqlg/+XS3aqU3c2Td1yiwXthsrxcAK0Ktq/D/VjmcLTpDb3yzPjDJiP6x/9pZzGv3wxJuumAsenOCu98yk/hCM5iMBZNI=
X-Gm-Message-State: AOJu0YyZC+wlMfv74PQqq0S12+fym/rU0Czep1QJGUlMyosJm7UojVvm
	6pE9RNvr8OpyPyZxBfxzg1NdbyJVdu1baD7LmPORA42k6XCNtJ0Fc0W/OR1L+8OsjO9IgBkYm6i
	M10aeQLhcd1HLSFJ+eCeYhjMeNYA=
X-Google-Smtp-Source: AGHT+IGe4YDLMC1VPuov6ECazHzXXBggKeKCmQyWizyYIsOCWRXbjCnXLn9qaBtY+SGk+U99r0LI7eIRNJn/lvgUIis=
X-Received: by 2002:a4a:a7c9:0:b0:5ba:6959:edf8 with SMTP id
 006d021491bc7-5baae6da3bfmr3588960eaf.1.1717788391242; Fri, 07 Jun 2024
 12:26:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530151704.282453-1-rui.zhang@intel.com>
In-Reply-To: <20240530151704.282453-1-rui.zhang@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 7 Jun 2024 21:26:19 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iVtb8K0ww8REum6T90bu321sWoKCVUN0t-8Wzv9ZvkYw@mail.gmail.com>
Message-ID: <CAJZ5v0iVtb8K0ww8REum6T90bu321sWoKCVUN0t-8Wzv9ZvkYw@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel: intel_pch: Improve cooling log
To: Zhang Rui <rui.zhang@intel.com>
Cc: rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, pmenzel@molgen.mpg.de, len.brown@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 5:17=E2=80=AFPM Zhang Rui <rui.zhang@intel.com> wro=
te:
>
> The intel_pch_thermal cooling mechanism currently only provides one of
> the following final conclusions:
> 1. intel_pch_thermal 0000:00:12.0: CPU-PCH is cool [48C]
> 2. intel_pch_thermal 0000:00:12.0: CPU-PCH is cool [49C] after 30700 ms d=
elay
> 3. intel_pch_thermal 0000:00:12.0: CPU-PCH is hot [60C] after 60000 ms de=
lay. S0ix might fail
> 4. intel_pch_thermal 0000:00:12.0: Wakeup event detected, abort cooling
>
> This does not provide sufficient context about what is happening,
> especially for case 4.
>
> Add one line log to indicate when PCH overheats and the cooling delay
> has started.
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/thermal/intel/intel_pch_thermal.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/=
intel/intel_pch_thermal.c
> index f5be2c389351..fc326985796c 100644
> --- a/drivers/thermal/intel/intel_pch_thermal.c
> +++ b/drivers/thermal/intel/intel_pch_thermal.c
> @@ -298,6 +298,11 @@ static int intel_pch_thermal_suspend_noirq(struct de=
vice *device)
>         /* Get the PCH current temperature value */
>         pch_cur_temp =3D GET_PCH_TEMP(WPT_TEMP_TSR & readw(ptd->hw_base +=
 WPT_TEMP));
>
> +       if (pch_cur_temp >=3D pch_thr_temp)
> +               dev_warn(&ptd->pdev->dev,
> +                       "CPU-PCH current temp [%dC] higher than the thres=
hold temp [%dC], S0ix might fail. Start cooling...\n",
> +                       pch_cur_temp, pch_thr_temp);
> +
>         /*
>          * If current PCH temperature is higher than configured PCH thres=
hold
>          * value, run some delay loop with sleep to let the current tempe=
rature
> --

Applied as 6.11 material, thanks!

