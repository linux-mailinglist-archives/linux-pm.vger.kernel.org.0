Return-Path: <linux-pm+bounces-12202-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4797C951ACA
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 14:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC9FD28541D
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 12:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CB81AED4C;
	Wed, 14 Aug 2024 12:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mwJ68REh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BBD1A00F3
	for <linux-pm@vger.kernel.org>; Wed, 14 Aug 2024 12:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723638351; cv=none; b=fkRX2ZTL9n+swpeIujHjM+y4dv+KvUpA8YPoUuJ4JxJ5/uYAv2qd99UVtDeYmUMkWq93UPgSyjTA6Rkul67pbYhl53us9c/0nU7TfxWsOMMDwqO/o2remv8btV+XI2yJyBuz3XksUwroRt5fkauiuO4QvZkpiTkhX3IJMYc+b8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723638351; c=relaxed/simple;
	bh=8tzPFbEsdwK4HI7ixI1tqw/hZg62rldk5tfi9WSp0ek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tLIFhdiVi0KZIs/ovJgPGu5V1diQD28oL5uQEi3GCXF/0f7Q1V9GwgP3cqJdhWixHctyPMod3ax76tt31XODimuNrj/lAU8PqluTwcbKKqJaau/1BtG1CLb/yRn4r66PqCapR67z5Pdn9i/9g0n5mBgw1o3swRbUZNJ+NSQOdcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mwJ68REh; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e03caab48a2so725672276.1
        for <linux-pm@vger.kernel.org>; Wed, 14 Aug 2024 05:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723638348; x=1724243148; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c9W+rcl3/x6n/YcRtLISn/hkiAh/kVAHqezbuzoZlzs=;
        b=mwJ68REhiGmJUmhReu+GK5KCZ+i+ixC64Tkb/llGgPP7S9owiV3/duxQD4/MhKx47/
         ccy53nUelVaw50ScPa/qnwshPVqZkxo1C841vHFDZSIW40pNjDa3CqisVuUgsIlsKDp0
         764bxJAnkPsNB/dq9cp92n/U8rQBdJjNtML+GXqzBpeprlDLnr64woCj/wyxydOjKxdg
         A+xYGYebmWHGdQlGRRZdSxoCOTuG1Jk7fI2WpB2ANlW7/vHU0OFyGBCo7GjjUsrA5OhP
         orjyX3Bv/UlQRfke241P76w6xj5Fw7wMgUEwVqTLj+VedkG+QinG5iJWE3J44/vPdWeJ
         HWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723638348; x=1724243148;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c9W+rcl3/x6n/YcRtLISn/hkiAh/kVAHqezbuzoZlzs=;
        b=ShoNdDS+iT/MC4rPSJhbGDWLy/9doD0xk8nQDsqJCFbZxVmZkgNB9mZtZesaocx8z5
         0D4a4FOwKNKMqqi5NXTq4hsTmC5Ft+LYFbOpg5mefB2MRwVyZKjg7gpMbhXLiRS0d0qv
         BaeHMZOuotwbYZuksxKsAdtbZkBp+pDIq5vSBRaZLJlqGPVjr+BAZrr/BocimQxOXU7t
         Y9P5WUNDOh0PAF8IuoU4lS8UfPpXD1bcYW2mmq00tijzxb+p3bMopS7TUbT5TJEl+kWK
         gzfo8mXOiPtZ1xlSOhATub6UEdmw4H1RxAQxz50aQjDfTY/GCHZDvulpFyYCQHHUE5ua
         BQMQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0vD7d7zzfS01rS9jQxPiZfRpnNFaIUiKWWlBsMWRRjJD77ETrYApPeFv9J/LM+q8zOocg28CARq0aBmsJGDTvCa0t3DlSvWk=
X-Gm-Message-State: AOJu0YzM8Mb8gvngshnKnYCPEwXR8Cs01ojAErC16sCczlDst7S03ppx
	KNmScuH70NVKVVchN0OHbSX+OSSBvEC5jzx0MgVz750oTBVG6/4zS7c9UUklvw2BI/PRX5peGR/
	zbSMIiNlD61wDzWdvROAMJ8o7p0fdcDLqE8IjGA==
X-Google-Smtp-Source: AGHT+IG9s5zKEuElzdmu8nYTv+TuYXsEEzkAtXGAXraUgcr2mrfhNdPpz8+DdeopqaF18UtxfyTI7E1EKXrMGt7AwqI=
X-Received: by 2002:a25:d685:0:b0:e0b:f963:263e with SMTP id
 3f1490d57ef6-e1140cd0625mr5768707276.9.1723638348494; Wed, 14 Aug 2024
 05:25:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240728114200.75559-1-wahrenst@gmx.net> <20240728114200.75559-6-wahrenst@gmx.net>
In-Reply-To: <20240728114200.75559-6-wahrenst@gmx.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 14 Aug 2024 14:25:12 +0200
Message-ID: <CAPDyKFpNbrgLOrtofdR3s0hHvao3gt4+6C0Oj5_phrRYi=enCQ@mail.gmail.com>
Subject: Re: [PATCH V2 05/16] pmdomain: raspberrypi-power: set flag GENPD_FLAG_ACTIVE_WAKEUP
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, Maxime Ripard <mripard@kernel.org>, 
	Jassi Brar <jassisinghbrar@gmail.com>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Jiri Slaby <jirislaby@kernel.org>, Minas Harutyunyan <hminas@synopsys.com>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Lukas Wunner <lukas@wunner.de>, 
	Artur Petrosyan <Arthur.Petrosyan@synopsys.com>, Peter Robinson <pbrobinson@gmail.com>, 
	dri-devel@lists.freedesktop.org, bcm-kernel-feedback-list@broadcom.com, 
	linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kernel-list@raspberrypi.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Jul 2024 at 13:47, Stefan Wahren <wahrenst@gmx.net> wrote:
>
> Set flag GENPD_FLAG_ACTIVE_WAKEUP to rpi_power genpd, then when a device
> is set as wakeup source using device_set_wakeup_enable, the power
> domain could be kept on to make sure the device could wakeup the system.
>
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Patch 3 -> 5, applied for next to my pmdomain tree, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/bcm/raspberrypi-power.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pmdomain/bcm/raspberrypi-power.c b/drivers/pmdomain/bcm/raspberrypi-power.c
> index fadedfc9c645..b87ea7adb7be 100644
> --- a/drivers/pmdomain/bcm/raspberrypi-power.c
> +++ b/drivers/pmdomain/bcm/raspberrypi-power.c
> @@ -91,6 +91,7 @@ static void rpi_common_init_power_domain(struct rpi_power_domains *rpi_domains,
>         dom->fw = rpi_domains->fw;
>
>         dom->base.name = name;
> +       dom->base.flags = GENPD_FLAG_ACTIVE_WAKEUP;
>         dom->base.power_on = rpi_domain_on;
>         dom->base.power_off = rpi_domain_off;
>
> --
> 2.34.1
>
>

