Return-Path: <linux-pm+bounces-29580-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F796AE9AE1
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jun 2025 12:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 191841C402E2
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jun 2025 10:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7435A21D584;
	Thu, 26 Jun 2025 10:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jKz8j8yZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9784121D018
	for <linux-pm@vger.kernel.org>; Thu, 26 Jun 2025 10:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750932671; cv=none; b=V873oaNLdDllM02Gl8yxKM2ezQpHwUYBSrl28ulxXtuypFp0xxtqGoS1IL0qs8DMLtjaQjbTVtadJea0kprGIQrdR9GUJGglcqnwW7D17zO4uPHiGomPJ5y91mvkA7NhTEjWrEz7ymFbFXA1fgjb2+Q/jdaalOitqyQe+IjUdRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750932671; c=relaxed/simple;
	bh=6/CYJDnKQKVbQcwXiQ2rMzs2H9ssDvR6KIpjsUQ6QdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SEHh62P1e56hYq1pgZeaj5c2iP7ryg7RJcHpsDvb1nYi3YgSutMccGOz3uVk/fwLa8UpJvl88GRH5bfOhqCeR7Dkq79OxU3PiBsaASfPZBpnKfjD4Bt7fvMFMXdAb/CrxH4CW2cwDNkIDEQ3LLRfBtZOBVO7eWQujbr0k0tQurA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jKz8j8yZ; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e7b4ba530feso640603276.1
        for <linux-pm@vger.kernel.org>; Thu, 26 Jun 2025 03:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750932668; x=1751537468; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9Q9r85ztpEpS9CYbZbkPRdk5F829Mu+gn5m9UjJJ67w=;
        b=jKz8j8yZKBOa7biATTQpt47NE380p0arVVW2TvzqXbvq5RyIZnCMi7nhD/HhMXYxG9
         14ETF+3PzaHQPT51FU9gAiJNWVJT85d/s62Z/nGx47ZAS3XiL9bxnMyzzcoNRbkZaOLu
         Bkd578TgrI4eXkwPYweFBrsvKq4O9eYvRqwGWeN5V7lULHQgK5mVRsFHG16Azj4t/2SK
         Lft3M3XvrCJQaDOO7S6P7H8OEktGZLHitpS5Y04PLE12f5xCteSaouVLNrkEWLL7i7d2
         mMDby3gOo1GYd2hSAYRcTizT47AXZTWEDaRBRASJzsGv8l5L/L5Nh2agqwAlL8SrnNUn
         x/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750932668; x=1751537468;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Q9r85ztpEpS9CYbZbkPRdk5F829Mu+gn5m9UjJJ67w=;
        b=YpTzEu616v4f3H2fI8O6IwF2cHGHM2KhaV9nGsNnTaRXF6uDhAjeFe2RLRHlorQFur
         jr1z4uvZprvAgVV1VidHzpAVrEX579uji0TsYvkSuBdfcuGw60p8l7x+kyxVpWMIUxIW
         wt6j9pYvr/DI5OxMraUQuPDBoNh8pF/FaCSLYLHsnvJq2pyLRqwAwh37UYOKick3TfNI
         bf38jufH4diuXs3VS8SjCm61QDjEXkJgsRXyX5RGodx8c2FpsrmkAQsm3Nlgvt0Nci1y
         ZB9VOcW16KEXhv+J+C+eIhuNTCMWf4NodN+N2aArdujDT87Xj/jZphsMfh59bpCpoJYT
         s5Iw==
X-Gm-Message-State: AOJu0YzX6CYwA936g4NDIxcTRBzCTM5Xzr4A64ftNQkIR6jq18EGq6zj
	peSYxotvrEgpWGvFxHhEfgp2gZXv9nhBoTazUFSP1Chd5BKisFtkC+CNOcWNuGAAegjEGlc+api
	ncEHBTu42yFXUEMndy1YVjAiRmdxuQyqgk+rUDcRBJg==
X-Gm-Gg: ASbGncubsx8Gk4h7EeXbsbgUC/Ro93vwOuX6Nr6L/sTauKmL8wrul/Uya5rnJYaXpoH
	Hdg77tosEH1MecGaDlBstps0xGNH+Dtyfin0CzDfPigFkGZAM94ziBNFwnh566uXYHgdBAGfw9k
	G7UFCADI2qQoRVTEHLrZWVKrplNO4nt/EZMxMjyyXYvjp7
X-Google-Smtp-Source: AGHT+IFTNjmMODL7y1EvHVTNC82M3od38DyxrG8NO+F9c5mpyvxWXa3dqoy9a/B0A36TiqGlH0TnxzyON/TB5m34CYM=
X-Received: by 2002:a05:6902:210e:b0:e81:9581:4caa with SMTP id
 3f1490d57ef6-e860178bba2mr7662593276.34.1750932668573; Thu, 26 Jun 2025
 03:11:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <22759968.EfDdHjke4D@rjwysocki.net> <3903497.kQq0lBPeGt@rjwysocki.net>
In-Reply-To: <3903497.kQq0lBPeGt@rjwysocki.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 26 Jun 2025 12:10:31 +0200
X-Gm-Features: Ac12FXzz6qmhiLsuzk245wnHwdyyM19B97SD0ZUjObz7zXjCLdLDg9DQbgqL-iI
Message-ID: <CAPDyKFqXvNDqZjePwvF+mgs7bba47uoeH-7XvJkqZ2K4-bmXgg@mail.gmail.com>
Subject: Re: [PATCH v1 1/9] PM: Use true/false as power.needs_force_resume values
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Jun 2025 at 21:25, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Since power.needs_force_resume is a bool field, use true/false
> as its values instead of 1/0, respectively.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/base/power/runtime.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1827,7 +1827,7 @@
>         dev->power.request_pending = false;
>         dev->power.request = RPM_REQ_NONE;
>         dev->power.deferred_resume = false;
> -       dev->power.needs_force_resume = 0;
> +       dev->power.needs_force_resume = false;
>         INIT_WORK(&dev->power.work, pm_runtime_work);
>
>         dev->power.timer_expires = 0;
> @@ -1997,7 +1997,7 @@
>                 pm_runtime_set_suspended(dev);
>         } else {
>                 __update_runtime_status(dev, RPM_SUSPENDED);
> -               dev->power.needs_force_resume = 1;
> +               dev->power.needs_force_resume = true;
>         }
>
>         return 0;
> @@ -2047,7 +2047,7 @@
>
>         pm_runtime_mark_last_busy(dev);
>  out:
> -       dev->power.needs_force_resume = 0;
> +       dev->power.needs_force_resume = false;
>         pm_runtime_enable(dev);
>         return ret;
>  }
>
>
>

