Return-Path: <linux-pm+bounces-24888-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B0AA7E65A
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 18:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C5131681B3
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 16:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6592139CB;
	Mon,  7 Apr 2025 16:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="endZq3d6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD1920A5F0
	for <linux-pm@vger.kernel.org>; Mon,  7 Apr 2025 16:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744042448; cv=none; b=ZY8zUAtrvrma5C4aTUf2ROlPq7kbe2M173eG4klnAmreBlk/hHf/bnTgiaKzzcRhi8EeX/lPpoVnkoeP+YjMSfRbmNhaGEAKYAciwgaJyQls8QGCYNATuYUAGuRXVxcJZWfrHU5I6zVaY/7+9K03zPrB4DRYDFxvdybLk4nwH5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744042448; c=relaxed/simple;
	bh=MZ1+v4Yr8SrxsYFLNiPWcJ3X3rXXmM+Atb5i9VRwigw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QvYtOFV4KU8xqFtH0hMasbvqw1Y5tr9B1gP+dpiLacadygqr4k1vToJ72VOviFiZyt1ZCPe8tAtlpgZgU7u6WMJXOLjiyHj3UjsjmZ35K3BNRi2uaiHlNVEB6MxjgqzeMSSgUmPIyXk4LXDXp6ObYt5UoL8Ml5kJ1tzKAsoKKJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=endZq3d6; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6ff1e375a47so43033417b3.1
        for <linux-pm@vger.kernel.org>; Mon, 07 Apr 2025 09:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744042445; x=1744647245; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bod33nGx35GYDGeyLDpG4qYPRiHJzUFJHwZD8P4WupU=;
        b=endZq3d6f2rGBycLrcxNGnEUlxVaR8NwpKrT1XudIkVdUOkbzPggfFGfOlzpYKnUOF
         D1Lga+Nwnt+zVDusaHfz9jmONa54DD7079bRQQA1oafjVIxsPCdLrQQ5bwpsowclji+d
         YSImJOejdLXF6oGTGmuGaj3qaMGVPpXI8ptu/890dc5FwuPqR7xZG4rOJM9hcfKOAi5o
         Jtm1E6S1BsPzc56+0MZh1izD70z/ge+ViuYlo2CQIfmR/2iSioQkql9KHoIiw7zk2enj
         z7RPhShjiortuBqkwrbW8HGxxENiigwiS9dsDhANO0Lz+VKOR6nozIaM55La461Tfn9W
         0QBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744042445; x=1744647245;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bod33nGx35GYDGeyLDpG4qYPRiHJzUFJHwZD8P4WupU=;
        b=IDu9ciGPiKAzauVahebIyKB1skIhkeT4XGmv3/l8iwYxW6U1X3HXv7/vApEoH2I8+K
         /43Xfjwj3K7HTSyc4xm8wFG2wAi9X0mMDk5dfB3aSsisUPZpCE79I/GM9BVb8rD7X8yq
         Lx/Ti+/W49mBlPR+lmhXyksuZDl6G9VcvrCWFFcFkt1ZyvJyooZG3d1fIDbBnhiz+8mK
         QyGKHMoB2q4hgsLYDSrjaMw80rgr8ShUYJzm7/zFpJCozlIX5tlzbjrWdoepPziCfwi5
         ET/CWQQxltyTqe09c2M3SYvLgCjaiEZFHMqT5QnoMGRoaXmhX1T8d4GkU7Ru4ALdGBVo
         TIFw==
X-Forwarded-Encrypted: i=1; AJvYcCVKZWQbOdSLhyMvgiNnFcq+XoDz1ZJhXaHdsYkyAr+8LuQ6hKlD5XW4AQikiUgTtPuYje2L7ih6qQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd3IxInBSwjp0c9I7HQ/TNh+B2DsbsAGrpo75OfzrEenmZC539
	3wk1N958YVi4xzK/gTFs7rEFixyZAp5mFCFZoBFHBEDtkfYaFOOw/PKxGvM+pDwKJQiCOZtijbR
	vQRF+etvcu3nfWLBYeEfmwWM/wllnaXngqrTmQg==
X-Gm-Gg: ASbGncvMZn2j4FanKUpyFMlPo79dh5RaU+ca/9lKP+gKTBqaGiRgYV5uJ/IiaEG/sqf
	t1ZSemTzIAFk1crS2xRMsWvdBViiSm11al/IKr6L8PEp9YKC/LpCNSrSElC7WhhWg/6//rL0umT
	hpcvSBv61Q5CvoJveEnQ87X0lymeQ=
X-Google-Smtp-Source: AGHT+IFoDbEoYCGI/fKsfvc1W3WRJ48PIrl3shNMLSyLyHUCZEKjVWa8xv5qbOXVgK1f6QWGAMLLH1qGHEVK9aquLzg=
X-Received: by 2002:a05:690c:4c11:b0:702:5689:356e with SMTP id
 00721157ae682-703e1546003mr227916307b3.12.1744042445057; Mon, 07 Apr 2025
 09:14:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230621144019.3219858-1-abel.vesa@linaro.org> <2786d9ff-0579-429b-b431-a8547cbf6fb6@ti>
In-Reply-To: <2786d9ff-0579-429b-b431-a8547cbf6fb6@ti>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 7 Apr 2025 18:13:28 +0200
X-Gm-Features: ATxdqUG2bTsfDvA_PWKUIhjRNtwJmFpgrRLM7JC797JM0tWqTf0FSYOqcVvkHm8
Message-ID: <CAPDyKFodE6KokC9uwZZgF+VGCc5JCA5YjB7okUkELAn16V=nvA@mail.gmail.com>
Subject: Re: [RFC PATCH v5 0/4] PM: domain: Support skiping disabling unused
 domains until sync state
To: Devarsh Thakkar <devarsht@lewv0571a.ent.ti.com>
Cc: Abel Vesa <abel.vesa@linaro.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Saravana Kannan <saravanak@google.com>, 
	Bjorn Andersson <andersson@kernel.org>, linux-pm@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Apr 2025 at 16:13, Devarsh Thakkar
<devarsht@lewv0571a.ent.ti.com> wrote:
>
> Hi Abel,
>
> On 21/06/23 20:10, Abel Vesa wrote:
>
> Thanks a lot for working on this.
>
> > This new approach drops the is_off change that was part of v4. That was
> > kind of beyond the scope of this patchset. This new approach changes the
> > boot_keep_on in such a way that we won't need any kind of new locking
> > for a PD. This involves using the patch [1] for adding dev_set_drv_sync_state
> > from Saravana for allowing the genpd core to set a default sync state
> > callback for a provider that doesn't register one by itself. While at it,
> > we can add another such API but this time to query a device's sync state.
> > Then, we filter out each power off request in such a way that if a boot
> > powered on power domain is not attached to its consumer device and
> > the provider has not state synced yet, the power off request is skipped.
> >
> > [1] https://lore.kernel.org/all/20210407034456.516204-2-saravanak@google.com/
> >
> > No worth mentioning what changed since v4 as this version is almost
> > entirely reworked.
> >
> > Abel Vesa (3):
> >    driver core: Add dev_is_drv_state_synced()
> >    PM: domains: Ignore power off request for enabled unused domains
> >    PM: domains: Add and set generic sync state callback
> >
> > Saravana Kannan (1):
> >    driver core: Add dev_set_drv_sync_state()
> >
>
> Could you please share if you are planning to re-spin this series as
> non-RFC in near future ?
>
> We think that these patches would be useful to enable smooth display
> transition from boot-loader to kernel space, something which our team is
> working on, so just wanted to know your plans for this series.

I am working on it as we speak, but I need a few more days for
testing. You should expect something to hit LKML later this week or at
least early next week.

I will keep you posted!

Kind regards
Uffe

>
>
> Regards
> Devarsh
>
> >   drivers/base/power/domain.c | 72 +++++++++++++++++++++++++++++++++++++
> >   include/linux/device.h      | 26 ++++++++++++++
> >   include/linux/pm_domain.h   |  4 +++
> >   3 files changed, 102 insertions(+)
> >
>

