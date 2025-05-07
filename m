Return-Path: <linux-pm+bounces-26821-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FB4AAE504
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 17:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F216D9A2449
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 15:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09F628AAFC;
	Wed,  7 May 2025 15:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iM6KmSgS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EE8748D
	for <linux-pm@vger.kernel.org>; Wed,  7 May 2025 15:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746632374; cv=none; b=eQFwJXqBSknmuzHbPH3ROr5EXbfztLW1L2P+MCljbBbgIxVo+TjioRk8quSC2e0hrIis7CjPSiAGNS7fuBTTuH+QEsiEqy6N4YQn/qF4QsLq6yOUd/alrDEmOlsBHp/0vukkPE+v0HxTx3Ekvp+CXNn+kozG402S6GloMK7ajRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746632374; c=relaxed/simple;
	bh=17d1KkqkFnjgiB4XE80ZvS8SIM/DtM9+avsi95yhHsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aCPaFZbUW9RSarvYhc+H+kX01OGfE9jgS8PhiYI3p0r3fg/K6uANfHDUIV3nYuhwPdOz03ktgQ+DTOqlmYhHSzqQYHQN/RpqtI6UB7FhJ2MGZFKxKUUwaz4kEPIEx1GUEUc+Vc4pgpS1aILHZoaXTOYezjmFaIkC/6MGJ7Vp5JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iM6KmSgS; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e756416045bso11772276.2
        for <linux-pm@vger.kernel.org>; Wed, 07 May 2025 08:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746632371; x=1747237171; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KUaFNJP87BHH/Bw6m4JMEgvEp0MBArNEe9xjuJyEGA8=;
        b=iM6KmSgSZiroQcYGYCsE4TKiGYN+6U3ZhEOGBJRGpI9sJFYxAElbUqQClUFcrUU+fS
         4hX/2Xogm1HYdBzH7WdXe0iSRVZucRJhA1PfwQSvZgvxIY5fXuMd11fByf9szoX6gshF
         l2ATiR3OlvUIXYDx54tAG+5J6fR+BGhw9d49puVt2h23IeCq0DucEP6RFHxni+aFPqhb
         sEoi8A01/HB8WeSXHHDHPwz1aLTFxlTpybpDbBVZvxziQqqRygY1Zq3LxfO8mo5jqWVM
         46ddCiLk/PoPkAv4R4zDaWX7xmpfbLxReyWbJbkow4QcDtAdp8gGevfB2Iuj+943d945
         uQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746632371; x=1747237171;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KUaFNJP87BHH/Bw6m4JMEgvEp0MBArNEe9xjuJyEGA8=;
        b=qtzoMyBq7pkRzKJutkUlMhq4JfwDX876oMp4h3N4c1aRWKg+6tlZ9sd/gpB4NCeFQh
         RNY//tBoumoiTZMuGLUSPzoSnr3jPaBEHhU/Eduv87hGt5TrDLG/VGpeUOBfAYXRc/fy
         r0GOH258FskIRV4Niz3WhvuqIDxE3a3u0oJx7B8BxcWL3ozkVg01Fq9ZFHlGz4tR523z
         7bg2gqgR0jb7/CUsY/8q4pNaOgMzpIPpM/XMNr3AIIe5U9PFjB2wbojh0srTy5MniATr
         38TglYkfWdfIrW8SPrpyW/bnxZRmTaIhbmaya/Hn2qn1nTETrPvF+MTcskXcV2DTFj6X
         M5sw==
X-Gm-Message-State: AOJu0YyOkZ8VLOTAACJ5F0ieHgzrmbRLqrnvcoWAb+rWhLndeWc3mNqe
	EJLonjclrAqoqoJTeZF2fkbC2Qr08gWbHfXxXNAt/KzStWj7tTw08UMuxg2eMipUF1w+RY8xVqj
	H1+sUAs5e1vMn12AGub1xN1eIU+gZ7UzlCsc6KFbmL3t3pYP0
X-Gm-Gg: ASbGncvooD3KKnFI0i+IyW92uwqy/5i9yQyf3sxGB7vPHrglCwMdqW/518y0OjG2uYK
	rkWH1hhTzAxttKNvyyj4EUjuD/CDC+wlQvu6T/aJpZmIaCS0kebdQYphsdFqdfGLNM9h4ICvpyC
	TLToZsrW42FoQ+YpGjl53AnnA=
X-Google-Smtp-Source: AGHT+IF9tPa8GbcrKOeIVgTLn4flQMyG+LAp86lN9JQlhuMq209YYQoDzpR+zMRtGPpSalHSBTctwfBP2N4FaOqIM70=
X-Received: by 2002:a05:6902:15c7:b0:e60:7d3b:1e18 with SMTP id
 3f1490d57ef6-e78821fd184mr5050846276.40.1746632371526; Wed, 07 May 2025
 08:39:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12677254.O9o76ZdvQC@rjwysocki.net>
In-Reply-To: <12677254.O9o76ZdvQC@rjwysocki.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 7 May 2025 17:38:54 +0200
X-Gm-Features: ATxdqUH1CUr6fuhuzl2HziQB0l1TdiOvfKKTtfkdtk-QErj0L6uEDcfmgLnrmo4
Message-ID: <CAPDyKFoWVgGQ3KvGqw=6TcndosFo-2kTCHOMSRCL_rNvjj86zw@mail.gmail.com>
Subject: Re: [PATCH v1] PM: sysfs: Move debug runtime PM attributes to runtime_attrs[]
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 May 2025 at 16:29, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Some of the debug sysfs attributes for runtime PM are located
> in the power_attrs[] table, so they are exposed even in the
> pm_runtime_has_no_callbacks() case, unlike the other non-debug
> sysfs attributes for runtime PM, which may be confusing.
>
> Moreover, dev_attr_runtime_status.attr appears in two
> places, which effectively causes it to be always exposed if
> CONFIG_PM_ADVANCED_DEBUG is set, but otherwise it is exposed
> only when pm_runtime_has_no_callbacks() returns 'false'.
>
> Address this by putting all sysfs attributes for runtime PM into
> runtime_attrs[].
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/sysfs.c |   15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>
> --- a/drivers/base/power/sysfs.c
> +++ b/drivers/base/power/sysfs.c
> @@ -611,15 +611,9 @@
>  #endif /* CONFIG_PM_ADVANCED_DEBUG */
>
>  static struct attribute *power_attrs[] = {
> -#ifdef CONFIG_PM_ADVANCED_DEBUG
> -#ifdef CONFIG_PM_SLEEP
> +#if defined(CONFIG_PM_ADVANCED_DEBUG) && defined(CONFIG_PM_SLEEP)
>         &dev_attr_async.attr,
>  #endif
> -       &dev_attr_runtime_status.attr,
> -       &dev_attr_runtime_usage.attr,
> -       &dev_attr_runtime_active_kids.attr,
> -       &dev_attr_runtime_enabled.attr,
> -#endif /* CONFIG_PM_ADVANCED_DEBUG */
>         NULL,
>  };
>  static const struct attribute_group pm_attr_group = {
> @@ -650,13 +644,16 @@
>  };
>
>  static struct attribute *runtime_attrs[] = {
> -#ifndef CONFIG_PM_ADVANCED_DEBUG
>         &dev_attr_runtime_status.attr,
> -#endif
>         &dev_attr_control.attr,
>         &dev_attr_runtime_suspended_time.attr,
>         &dev_attr_runtime_active_time.attr,
>         &dev_attr_autosuspend_delay_ms.attr,
> +#ifdef CONFIG_PM_ADVANCED_DEBUG
> +       &dev_attr_runtime_usage.attr,
> +       &dev_attr_runtime_active_kids.attr,
> +       &dev_attr_runtime_enabled.attr,
> +#endif
>         NULL,
>  };
>  static const struct attribute_group pm_runtime_attr_group = {
>
>
>

