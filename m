Return-Path: <linux-pm+bounces-39639-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CAACC5379
	for <lists+linux-pm@lfdr.de>; Tue, 16 Dec 2025 22:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 47B923001E25
	for <lists+linux-pm@lfdr.de>; Tue, 16 Dec 2025 21:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6031E33A03D;
	Tue, 16 Dec 2025 21:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFD/IxJ9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DC91DF73A
	for <linux-pm@vger.kernel.org>; Tue, 16 Dec 2025 21:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765920810; cv=none; b=h8Q47pQGyA9oKeRoDPA2amacOgKTqsbhvFmBuLHLmxDJCRVnFCKWvHMDZPZiJnDrvMjliYl53uirwyoFUfbTu6xIc+fWG6yq88iCpNVGWcrR4vRxRixI7iqmyI1X+2BouhCncFOEPy1sbakOcLOh6rWXDkqvw+ef10ZgWjaLNbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765920810; c=relaxed/simple;
	bh=m4/PosvYVWcXaVtxjw2E2cyJczRpEzbA94UHzJ+vxVg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QgeIUkYpDOElg7UunWFJLdzaOhTu9jcIQlwOCJlKXRdzD8inbRMutDiHHJlMYhKAUzpr4Wa+H6ItOLPRyAn7eWI3Vyxe2jcRDpHcYKAMoFXcVZCAzjVxj5Qh6Z1ANhzg26UX04llMa9eXNF5ENOiv0Bj5gwsDGgg3n4+WXfr4Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFD/IxJ9; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-640a0812658so8620487a12.0
        for <linux-pm@vger.kernel.org>; Tue, 16 Dec 2025 13:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765920805; x=1766525605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xCYUk76BqorMFZGGzHYlq7Ql2Ms+ChYX93WODaTTv/U=;
        b=OFD/IxJ9OfWZa2qKsN6pw0SCWOBuvFJYsov5AWsDW9k9zrKapukQaquObWkqXxY3dz
         QyFmD3p+yOeX8JvIWjmBGYtu474Nycs4vCdEhtmMdGflD9JK/fDuvotSigmhdoXSjAfE
         1Y9TJ6829VY+87HnHiF0S7/hImSl3/PalDkX+SF7plZD6mPE8+P/ZPvCXaSFOv+qDLcO
         MzUWKcPzpVTXR9FPUJ4cgIgqlAJQp0y3fwM9Hgh6UGmyab+VGy4yZGaU4or029wH1YKN
         ENfGJyfvu6CxUfsbRZXtzLUFxZjwAzPLKPfiy5wGSJgfsA02GgkCi0gFP5uoSuQ69tSl
         UMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765920805; x=1766525605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xCYUk76BqorMFZGGzHYlq7Ql2Ms+ChYX93WODaTTv/U=;
        b=MSbStNJMwgcWC6uvRR9x3IHx3qTX3vr82rOXOmy0LdV03FJVTZXPFnhlVi3HRq0cQ8
         cOALY04VSr5oce2M7XLVBL/NFK0F0X+r9BSxQEhcIwhnWjARlgBW+Flyg7MMogZjCdXh
         gU7lz2/lgN9yXD2EOo1vdWRecZeqVhs6khRQn1LHWrtGzjuppHz6H1OB0b1GAgzIRmb6
         eqlVMpEgLaJmiZL5NqL0MdxKagsCKxA9MZYGU2JjFlBnsqEWi58MwGC65v4GYGPPjFdp
         ixCfjB0O8jVZuiSNcqikXCP0hv/4X46JQVTHwMDSJeJF47IraGkCHk1G+xXX2hKlOzEI
         S5MA==
X-Forwarded-Encrypted: i=1; AJvYcCW8WCzcMvtdW9XmU8PfWES5kkdGGTf6uB8wx6IJeQcgVa5Z00msMDFInSt3p6kgPCEZIrbCmm1kCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkRmTel/CC4QtMaSotMFpoGX2SPuFYT8LW8nx0htrdlEfEs1XV
	tbk405pf8RQqvhss0qRrEgJ6HBppkn2JDH1XwHw1599u7vPCbDxjePg5CrtVWA==
X-Gm-Gg: AY/fxX61knQJ/CAllteQfhnRUg5H3FLqyWkFT8WzIh6V2tHayZgocC867NwADUQRIIC
	e1RjQedMrlIvNDxtATmbBYRxBH6zoQ6xUXZ+qRNUghOiOwjQLRW2WzLTuas+SBt1xX6T00spEAo
	1kK+FygH+IJyoHlobjVf/mRHNbQF0sjkIhQxg3clvg1jBw9I554vMxDZ0tKlomeoaEhx4CR6ZDo
	AuGx2oLkjhxr8Jai+t7AZSSYVRxXPtuCCTxjoQb9hdhPt7X4Dk/TAYGSfLif4SUxnGjcPJjMSCl
	yT62w6zeJtKdKZYK7ThT1bFgZocYvxVrxriOeszT67LLisEhUWimrXO/1fbrduTc/qscnNAk764
	AMSYiTglPzqowhzESBuESiHRq3jgEf81Un4xdLOVfFDVeFognGMG4LkHCp4CA989XFHy9zuxxA5
	PaygzjQeTmtEcc52Z/Y1T8TCkGIUH3BKPJcZSBdAIyszV8htQ6Ywo0
X-Google-Smtp-Source: AGHT+IHa3y/03SZsTeHOlCjDJ8fIVGFQgr/bOY3qYup05WAAN+vlqgxoh1PfI7G59bazy8Aw3bdFPg==
X-Received: by 2002:a05:6000:2384:b0:431:7a0:dbc2 with SMTP id ffacd0b85a97d-43107a0df48mr3058615f8f.31.1765914255221;
        Tue, 16 Dec 2025 11:44:15 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4310adef010sm670171f8f.35.2025.12.16.11.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 11:44:15 -0800 (PST)
Date: Tue, 16 Dec 2025 19:44:13 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
 <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] thermal: core: Use strnlen in
 thermal_zone_device_register_with_trips
Message-ID: <20251216194413.1f12a3df@pumpkin>
In-Reply-To: <20251216130943.40180-2-thorsten.blum@linux.dev>
References: <20251216130943.40180-2-thorsten.blum@linux.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Dec 2025 14:09:44 +0100
Thorsten Blum <thorsten.blum@linux.dev> wrote:

> Replace strlen() with the safer strnlen() and calculate the length of
> the thermal zone name 'type' only once.  No functional changes.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Changes in v2:
> - Format the code differently (Rafael)
> - Link to v1: https://lore.kernel.org/lkml/20251215121633.375193-1-thorsten.blum@linux.dev/
> ---
>  drivers/thermal/thermal_core.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 17ca5c082643..90e7edf16a52 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1505,15 +1505,19 @@ thermal_zone_device_register_with_trips(const char *type,
>  	const struct thermal_trip *trip = trips;
>  	struct thermal_zone_device *tz;
>  	struct thermal_trip_desc *td;
> +	size_t type_len = 0;
>  	int id;
>  	int result;
>  
> -	if (!type || strlen(type) == 0) {

That one can just be:
	if (!type || !type[0])

Although one might ask 'why bother'.
Pretty much all kernel code has to assume that the callers pass reasonably
sane data.
Sanity checks for things that are easy to get wrong are one thing,
but some of the checks in this function look pretty pointless.

> +	if (type)
> +		type_len = strnlen(type, THERMAL_NAME_LENGTH);
> +
> +	if (type_len == 0) {
>  		pr_err("No thermal zone type defined\n");
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> -	if (strlen(type) >= THERMAL_NAME_LENGTH) {

The code does want to check this - to stop the actual copy getting truncated
much later on - especially since at least on caller had to do an snprintf()
into a 'too long' buffer to stop gcc bleating.
But I'm not sure you need to worry about strlen() v strnlen().
(The kernel hardening people probably disagree...)

	David


> +	if (type_len == THERMAL_NAME_LENGTH) {
>  		pr_err("Thermal zone name (%s) too long, should be under %d chars\n",
>  		       type, THERMAL_NAME_LENGTH);
>  		return ERR_PTR(-EINVAL);


