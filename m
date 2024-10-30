Return-Path: <linux-pm+bounces-16763-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D679B6D3C
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 21:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CE0F1F2187F
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 20:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4924F1D097F;
	Wed, 30 Oct 2024 20:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VTAFKu62"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FED1BD9D8
	for <linux-pm@vger.kernel.org>; Wed, 30 Oct 2024 20:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730318674; cv=none; b=rsjmQzsnAW5pSrkQlNlRCNwLR0TX0azHrbVYGhk0O+B/AowN6t+da7VL9ROL2vL2XfHt4uIOIuNaSkLAYrrkiH072c9yxQXW6roT1cJ+XbWqgb+/hHYeh0VgBYzRDvX+wWoqh37R+4BMznsQKghxzEMrpj8ZdzJa8pAIqQyQ2fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730318674; c=relaxed/simple;
	bh=uVgPnvdvVixUrLvSSmzOwFP1ifO3Y5wM1O4TUyu6hVQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BAPjba+cD4UHxugUKVLsjTXMbiMZCAhJtYPD9WOoy+mBJpJMdfMEm9fZbGzjIqG+S9DbGTKTEjQtBlBT8PClJaz4tJ+bbtomsa8YuQ909oxMKSVgx/3LDt+pXAYFVrsCaIVC3rN3NyOXNDQFeRbVmLBvA7yjdTOLC2VczPOpI1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VTAFKu62; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71e49ef3b2bso158700b3a.2
        for <linux-pm@vger.kernel.org>; Wed, 30 Oct 2024 13:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730318670; x=1730923470; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lQzFRfxxx9a4+2mBsj0Xqoq7m6oJoVrd/IVmDiqDLcY=;
        b=VTAFKu62o3GP5mEXNj/d9LEvmaDwRxfnG54IVbgBN0hOGKiIXOGFpeMrzF6Rj0ziKk
         3ydTL5QRsiu6Tndjlzv9A+v8SivRh+9JmRSOtLGjTF4tCFhUMYJGpR1twI4vN48Hat7K
         r15lGmm3plKmIK4yc0bTaTWGS+hQRFcJdG5C67OnXWWqXGMC8V1j+8UVD0wdkrmoMxDU
         T0L9zw0aSn8vEOU3e0Xo5V31qh5N+Q4avNLVoU6fzYoGiaJ7NFeUUTxN7SNZcH5UrSpT
         8juOqBUVntR/MwQByZGiPIhiHHPE+yWN6IfVU9cUc7Y8bWNz0XNOclyp6xm6LYciqBXn
         qJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730318670; x=1730923470;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lQzFRfxxx9a4+2mBsj0Xqoq7m6oJoVrd/IVmDiqDLcY=;
        b=K8Rce34jafh3TLaNi1BqfkG1GCE1/zgF21DWaae/Molz+UodthBkiHVlzl1kRhRqaz
         tZQuWoLUaDiX0TwGt8CNeZBfBwJ4MRbfdgLWmk7FQcO0es+nTomyEDd6xunff3NA1Ucq
         KZ9YxL4h6KI4i7Kz73XZEp/aDNkx38Gb2s8PQY41VjDzadn1y1L2jPwNj4DIiaRcPEBL
         aW7mSsMR4kafmOnA6JXKcgJichKCD+K9yNxbnL+gD6t4FuTiIxAx0fnk+gRRkPHCGCUA
         8mruSuPTmKAOBznjnbujxnX4RveE9zus79MAN0hSysSKSpDhrX14MAcEUGoF93YIg35t
         f8mA==
X-Forwarded-Encrypted: i=1; AJvYcCVezX35rl1WQIMyTFxkCihF4cc0V665KeZ+07DDm6YQHBqkbtljoQMOfWhcc6akWMdcDK5oEeg/kg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxbIJetG2ocq+GhCx9gyGg02UMfe1DdZ3USBoSyAVct+d9qc6zV
	UNDrRqJmEcDc+m36IHui9S7gMs5SIFV9in4dxL6vUermFnkPwPXj0uQ6lupuJZo=
X-Google-Smtp-Source: AGHT+IGVMEfUTc5x54Nwx1RTWRE+uqmsaKPPq5D46+jAG7fPOuoQ1j0ELW9wLdgJ/Zu3YwUM52plmg==
X-Received: by 2002:a05:6a00:3ccb:b0:71e:4ee1:6d78 with SMTP id d2e1a72fcca58-720ab39e56emr5383301b3a.1.1730318670285;
        Wed, 30 Oct 2024 13:04:30 -0700 (PDT)
Received: from localhost ([97.126.177.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a3c046sm9623477b3a.194.2024.10.30.13.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 13:04:29 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Nishanth Menon
 <nm@ti.com>, Tero Kristo <kristo@kernel.org>, Santosh Shilimkar
 <ssantosh@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, vishalm@ti.com, sebin.francis@ti.com,
 d-gole@ti.com, Devarsh Thakkar <devarsht@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: Re: [PATCH RFC] pmdomain: ti-sci: Set PD on/off state according to
 the HW state
In-Reply-To: <20241022-tisci-pd-boot-state-v1-1-849a6384131b@ideasonboard.com>
References: <20241022-tisci-pd-boot-state-v1-1-849a6384131b@ideasonboard.com>
Date: Wed, 30 Oct 2024 13:04:28 -0700
Message-ID: <7hmsilqrw3.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> writes:

> At the moment the driver sets the power state of all the PDs it creates
> to off, regardless of the actual HW state. This has two drawbacks:
>
> 1) The kernel cannot disable unused PDs automatically for power saving,
>    as it thinks they are off already
>
> 2) A more specific case (but perhaps applicable to other scenarios
>    also): bootloader enabled splash-screen cannot be kept on the screen.
>
> The issue in 2) is that the driver framework automatically enables the
> device's PD before calling probe() and disables it after the probe().
> This means that when the display subsystem (DSS) driver probes, but e.g.
> fails due to deferred probing, the DSS PD gets turned off and the driver
> cannot do anything to affect that.
>
> Solving the 2) requires more changes to actually keep the PD on during
> the boot, but a prerequisite for it is to have the correct power state
> for the PD.
>
> The downside with this patch is that it takes time to call the 'is_on'
> op, and we need to call it for each PD. In my tests with AM62 SK, using
> defconfig, I see an increase from ~3.5ms to ~7ms. However, the added
> feature is valuable, so in my opinion it's worth it.
>
> The performance could probably be improved with a new firmware API which
> returns the power states of all the PDs.

Agreed.  I think we have to pay this performance price for correctness,
and we can optimizie it later with improvements to the SCI firmware and
a new API.

> There's also a related HW issue at play here: if the DSS IP is enabled
> and active, and its PD is turned off without first disabling the DSS
> display outputs, the DSS IP will hang and causes the kernel to halt if
> and when the DSS driver accesses the DSS registers the next time.

Ouch.

> With the current upstream kernel, with this patch applied, this means
> that if the bootloader enables the display, and the DSS driver is
> compiled as a module, the kernel will at some point disable unused PDs,
> including the DSS PD. When the DSS module is later loaded, it will hang
> the kernel.
>
> The same issue is already there, even without this patch, as the DSS
> driver may hit deferred probing, which causes the PD to be turned off,
> and leading to kernel halt when the DSS driver is probed again. This
> issue has been made quite rare with some arrangements in the DSS
> driver's probe, but it's still there.
>
> So, because of the DSS hang issues, I think this patch is still an RFC.

Like you said, I think that DSS hang is an issue independently of this
patch, so it shouldn't hold this up IMO.

> Hopefully we can sort out all the issues, but this patch (or similar)
> will be part of the solution so I'd like to get some acks/nacks/comments
> for this. Also, this change might have side effects to other devices
> too, if the drivers expect the PD to be on, so testing is needed.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

We already discussed this a bit off-list, but for the record, I agree
with the approach.

I also tested it on k3-am62a7-sk where I've been doing the other TI SCI
pmdomain work and everything still working fine.

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>

Kevin

