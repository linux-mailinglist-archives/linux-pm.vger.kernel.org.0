Return-Path: <linux-pm+bounces-30060-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD616AF79ED
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 17:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CA0116D7B5
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 15:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D892E7BBF;
	Thu,  3 Jul 2025 15:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ciw/whlb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794C12B9A6;
	Thu,  3 Jul 2025 15:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751555036; cv=none; b=syo0fGgVxW+5OOt3rAVDw98FRBKMooG5/queiako1tXZpqVaCw7SP9QA2IUq4DdbsDbhzVkvwlquoDsdOkfwN17BnuTXE/ijAE28Q8o+0lAcqCe/3D7cnYtVhLKKyXn7OXhwEWamr3ywrkOavg4wgUsHeKz7hhMVuu62ewShr6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751555036; c=relaxed/simple;
	bh=agq/qe8sXsc3dCu6lab7Vni2cwMdaK7LfiV13CgmH/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YfilRFQfP9PbJ5UayoyUJ2Ue5V8bc8CIef1t21MDX7poVsMtq5qebEK80/hYWh4ajbgni6elh0L624mRa0MfZtaiSiJ1zTEO4gdPHMLVEnfoxuzW7iy4ZwirqVAEN1usaXpkwLGBAaT5zSlzvbbgyGZUwVnGSpoIxdNaJlLJVdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ciw/whlb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45276C4CEED;
	Thu,  3 Jul 2025 15:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751555036;
	bh=agq/qe8sXsc3dCu6lab7Vni2cwMdaK7LfiV13CgmH/0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ciw/whlbBkJv7CbcN4DuFihAaw2gPPgWaXmYRESD5tWV7Dxq3JfbGiJaSgv8BC8e5
	 Y+fZnuyOD2ILcXwRKPPxHpOa+/elaFSnR6imbvthYByfLxQltru16nB3kM94L1plfb
	 4esjB/XSspLFe7WkoR5BA5ZdRP2rumvE6t+HxCyDlRIzYBm06MeJVTjFQOrf4AClCR
	 KPHGWJyZLK4PYT3SukB/LxWPobsxCz5MZKe9CTOvRGOlo43/GCNCky+jm2wfPvmga9
	 /cAuJ1R1s1BzatidqjQbdIFLIrRuG5uamwu53ZDynYlB8b20BSFCHiA/VMv3Nu5+LH
	 xZsmMIG2IUXOw==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2eacb421554so19956fac.1;
        Thu, 03 Jul 2025 08:03:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVekMUOrkoR642cVJFigebJPqfK6yc/rHSg01ezeA9yRIxH8rzx8mFgQQsYqZl0FkX8ryPrkpQtv83lFmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQJczjxkjbyaqcf38c6J/3ToiuuXPcO1+aOSRcGiOO1a35he/Y
	LwXKc2AkozoNiwUMrlEdIZWbtZenwcAbKPEpJVfPPkI2zzxRAPi3QiF8N529Z0yFiiGZ8gqAo7V
	75+P+v6ZA69VzfNSRfvNVcpOBObW2hoY=
X-Google-Smtp-Source: AGHT+IEqy5XefO+GaHlEDA7AIKCnaU/Uvzlfmt0/ui1TVGFVpiq35KhvPC9/VafsQGyHh8koBGWrsQ4D7WyTcMOWgeI=
X-Received: by 2002:a05:6870:2420:b0:2eb:adf2:eb2 with SMTP id
 586e51a60fabf-2f76ca89a81mr2583505fac.36.1751555035383; Thu, 03 Jul 2025
 08:03:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626154244.324265-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250626154244.324265-1-andriy.shevchenko@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 3 Jul 2025 17:03:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hQLbKZ-DBWcQ-VKryV24Lc-=nsqJQ_fpkystvq6kVCbw@mail.gmail.com>
X-Gm-Features: Ac12FXzVKYTQZ3rI1JVwVCd722cmyjy9biQf3ZlkFDmrXr5Lz0hYK0O90PHnecw
Message-ID: <CAJZ5v0hQLbKZ-DBWcQ-VKryV24Lc-=nsqJQ_fpkystvq6kVCbw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] PM: Don't use "proxy" headers
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 5:42=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Update header inclusions to follow IWYU (Include What You Use)
> principle.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/pm.h | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index f0bd8fbae4f2..938b1b446a5d 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -8,14 +8,15 @@
>  #ifndef _LINUX_PM_H
>  #define _LINUX_PM_H
>
> -#include <linux/export.h>
> -#include <linux/list.h>
> -#include <linux/workqueue.h>
> -#include <linux/spinlock.h>
> -#include <linux/wait.h>
> -#include <linux/timer.h>
> -#include <linux/hrtimer.h>
>  #include <linux/completion.h>
> +#include <linux/export.h>
> +#include <linux/hrtimer_types.h>
> +#include <linux/mutex.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
> +#include <linux/util_macros.h>
> +#include <linux/wait.h>
> +#include <linux/workqueue_types.h>
>
>  /*
>   * Callbacks for platform drivers to implement.
> --

Applied as 6.17 material, thanks!

