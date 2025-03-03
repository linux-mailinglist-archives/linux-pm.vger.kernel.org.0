Return-Path: <linux-pm+bounces-23296-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB57CA4BF5E
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 12:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C60933B3623
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 11:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E463620967C;
	Mon,  3 Mar 2025 11:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wN/8O2WM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D7E1F4297
	for <linux-pm@vger.kernel.org>; Mon,  3 Mar 2025 11:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002493; cv=none; b=GV5JOqILMYFXEiEtKDivh5n6FOUfFX2VZkjOcONc4yGcVapW3IVW7RN63pKjy4CXZn6YeWQtascSfB6MlpsIBpPu5E08AmLsb7jzb+Cwljg5VTrbGSLqaNtuIxnSwAtCWms6El0J3hs5SocHX3hAzQgzyDioU5WPt2dXXTwR0PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002493; c=relaxed/simple;
	bh=b+lx7Mhr5F+6MDHZhmiQwGCwKX8l5EMHGINdzkXhal8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P2q04Kjvqf1caecrVa0hG6pJN+1W1KK2L299XWj3FJ0jDgiaPG8z/u7CMyl2TbYsCFUjN9+b8bgZ/4XJQHNUKfZKNvrtlJFZm4Zh++OZaJA0fpZr/RLg6lydH5J4tGnPxJ6tGazu5PXh4h8eGvKOT4YgrSc8MY/Tc/elD8Atoto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wN/8O2WM; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6fbaa0582a6so36501837b3.1
        for <linux-pm@vger.kernel.org>; Mon, 03 Mar 2025 03:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741002491; x=1741607291; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3d27QuSpy+kpWSA5wCmX6ePb2qWRbp1n87DWygzb7ZQ=;
        b=wN/8O2WMt4I5yir/lgd3E7SUqlJ9+m/EGjVskD6DwNQ/INU+WFSV1LuUTum9JOZ4rI
         GzTa8nOlST/rmUPMLQUKoAwVOWjQpkNU+S6Que+nLCk5kHlHRZCXc7gU6Rw8/O5xZdiP
         6dzXQFj6OqNOWXCjPrsd5P6piOfniZmWzpkdLwWQssZXrtXjlzlporGPgVW1Kpsz/wnH
         s+2tw5kdfkkjvm+ySXdP86K0lBYey7Hgxs30Vbr8ewQM1LJv3n27QzK4f6rLr95Nj+Gp
         bTc2vk3wH3hxLZHkMItJKCuflAaHmjg0md6c8fsqsUA+xr+86zeaP08D2bEviwrXeNZx
         B1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741002491; x=1741607291;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3d27QuSpy+kpWSA5wCmX6ePb2qWRbp1n87DWygzb7ZQ=;
        b=qXX8DW0tcQ1iQg2sBWfPiyYJMhoB3Be7srotpDDnWYjxTsOLy8t1tbj7K9tvqjQD7d
         xGHASeFTRGhcS1tBH3rJ74gYjL+V3yhoAGBAYBCNCoj3aE5fD95gs/9hEFt4PNQP/aaP
         2ATixSthhsJ8eOwELs3PJd1SrLVKPzqGxdckq0Xs/E3UbljRDK2yo9dar7IjAQQSNA8C
         WbLUAghaE1RYw563myhG4v/lNJEPFPyFUDiJL3VQ96/OSlxKKWXY/zfbahHIaO24tp8e
         TJgoPZephiBmV1EfnRPW15fYCsaYo1kL8HgBqT9ak9gsCOJPpkEdHRKxDigTaMaFfkaT
         USew==
X-Gm-Message-State: AOJu0Yz/+2emYfvR2p74tCQ2FrumomiWbhR4BHYc9/gSrucWDVFzZnrZ
	3gDz5P267mp0sITMcVan0CL7wdVkP1pJNARNW81W9oa2sVun4LKIRZrIaIE1hIBcMRV4/FwyCOY
	CBORZ3BUeqM/GcQHIFO2DofenEHtLjxg243dfwbu+oH/Ubgbi
X-Gm-Gg: ASbGnctwQzryTI4oOsj4bSWUQnLIZQUFzrUsE0hOMvGhrm9mxDcluUGPZPVKQEPKvVP
	fEgbi0Px1PX8G/pbryHva8UrI3c6yuJpNM1ZiyKfv0PZaDIONlLZPvuFY1BkoBZXYBsntagCHqq
	It1dz67Lgo6FcBVoO8uh0DMZbMfWE=
X-Google-Smtp-Source: AGHT+IHY4RKTZsPxwlz0x+EffBNFnn1gwEl6xaAlLeZ/6mf2UqQ19PPfFUHpUPqZ9jx4BIUjRwHBk146p8gg5ejQdyY=
X-Received: by 2002:a05:690c:45c8:b0:6fc:ed3e:ec3a with SMTP id
 00721157ae682-6fd39496a58mr245848667b3.5.1741002491087; Mon, 03 Mar 2025
 03:48:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2309120.iZASKD2KPV@rjwysocki.net>
In-Reply-To: <2309120.iZASKD2KPV@rjwysocki.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 3 Mar 2025 12:47:35 +0100
X-Gm-Features: AQ5f1JqlJPhh4XtTkm3850xwbDEaX3GA_R4NEixheKuA3ybh1Xra9hR1TqZF5cM
Message-ID: <CAPDyKFoSr3EmAcJzw36You7BLfq-TY7KkvdtrZ_O4Wq2a=6AYw@mail.gmail.com>
Subject: Re: [PATCH v2] PM: runtime: Drop status check from pm_runtime_force_resume()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Johan Hovold <johan@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Feb 2025 at 11:56, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Since pm_runtime_force_resume() requires pm_runtime_force_suspend() to
> be called before it on the same device, the runtime PM status of the
> device is RPM_SUSPENDED when it is called unless the device's runtime
> PM status is changed somewhere else in the meantime.
>
> However, even if that happens, the power.needs_force_resume
> check is still required to pass and that flag is only set by
> pm_runtime_force_suspend() once and it is cleared at the end of
> pm_runtime_force_resume(), so it cannot be taken into account
> twice in a row.
>
> According to the above, the pm_runtime_status_suspended(dev) check in
> pm_runtime_force_resume() is redundant, so drop it.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Seems reasonable to me! Please add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>
> The previous version of this patch is here:
>
> https://lore.kernel.org/linux-pm/6038511.MhkbZ0Pkbq@rjwysocki.net/
>
> v1 -> v2: Minor changelog edits.
>
> ---
>  drivers/base/power/runtime.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1982,7 +1982,7 @@
>         int (*callback)(struct device *);
>         int ret = 0;
>
> -       if (!pm_runtime_status_suspended(dev) || !dev->power.needs_force_resume)
> +       if (!dev->power.needs_force_resume)
>                 goto out;
>
>         /*
>
>
>

