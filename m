Return-Path: <linux-pm+bounces-13186-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC25964EFF
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 21:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B4AA1F240B6
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 19:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB51A1B9B3A;
	Thu, 29 Aug 2024 19:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QzW2R68/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCC01B7906
	for <linux-pm@vger.kernel.org>; Thu, 29 Aug 2024 19:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724960026; cv=none; b=ncf6Psh59GJS7xLX6mCOnDjs3KiHeuHIlCUdPcYcJcMuT/eu0sAeyGkaqVtag5/FOpKAI96HcQSdEAi3u9omX8IUOuZwYFDcjqhYTyH6Whsjy4HmObF4Qa/eE1Bsm9OnMgUO8M9dOcV0LsVWijdeUP7iV28+A2YBGMDEHFPAdW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724960026; c=relaxed/simple;
	bh=PrBn1mpQDMnlrgLBKDe4p8Ampi+IFTnW39FupGagWho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S4RRi8e/IwROtX9c+0LdARhTR6HI5hPBfCjXMk4EZz1GjCQJhMSiR7BkeQXATlagJP12CfX1CHGNvnbjgDGjd7Im+8AitSKAmjW6+9jndvBL/A6iNgmpmrwOzOpeehmVXxBaDlGxy4eoTxfpJ4Gg+I0JV6RZskFEekhNCteo8rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QzW2R68/; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5df9433ac0cso612803eaf.3
        for <linux-pm@vger.kernel.org>; Thu, 29 Aug 2024 12:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724960023; x=1725564823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+89V/Pkw0eErHNWTJZLzdCFWIv36uJ87GHJgsJod6mk=;
        b=QzW2R68/NYdjaOXf0mQbv6augq7I0xl4QRW9ekcjvXW+nfPNgWk1yIOVel42LlPTS5
         PSUAHF/BUe2Z70bD4cEq4AbpMMyj4Fx18/H1cc737mUxRrYSTUSWe34HQU7uu/QNz4Ks
         RoP1tzAHwJs8xfv2Ut85EThLNhZW1KB30vJH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724960023; x=1725564823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+89V/Pkw0eErHNWTJZLzdCFWIv36uJ87GHJgsJod6mk=;
        b=oLsYTqJDRKLEBsr18Pf09G/RRJz0dNdjtFdLJyx8Gc1+mneL40ovgD5h4/LWkxDAew
         KkYgux8mj/JPNzAaX6L/ss2gjYpTyqBf7iyKt89D3vMFvgoiAxDQXz2mGQ5Bt0SH8B0B
         j8EceJ9wDVfFOjdvZWLNQfQEUJq5yxDor+IsIIHOQgjN8/ZGYuJ1K9pgAcWSTWLNxCRy
         FTHQIwtapQIcbVCDfvTICK31Yn7VOAJRB8j5FYw4DziJ53ZM+kI9JdLgHRVtLGoHziUk
         070kRZLGbSKpFUtjP/C5qDOqp4lcdl04FAggUb5uKpY1g92Jk9LvNQ97O3SfJYc/pdlq
         LfQg==
X-Forwarded-Encrypted: i=1; AJvYcCUkcpiqaZ7vbY/0CU9si08tLfQy3pvHVGj3ow2EnEiZ+51jNaXn+Zp49pjhBwKoIM7U97hAb+URCA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGUrsPl+LxaAe6eepICo3fNE5wDBIQfFl/EsmU0lKzY6y6Fisj
	vAjf5//8yYmNFgYDwSssvUrr5Ecdu2QAosMZTLbSuJU9GxsxG+eD9u6V1wGsQ73elcvzE9WSvpc
	=
X-Google-Smtp-Source: AGHT+IFXPRHYk6+0ejypmgvH57xyyPG/AhLIDZ6lBpPF4xkf7WIUP15Z12OO+hwHnfkaa3/SR0aEuw==
X-Received: by 2002:a05:6871:e264:b0:270:4dbb:195a with SMTP id 586e51a60fabf-277900c729cmr3789226fac.15.1724960022928;
        Thu, 29 Aug 2024 12:33:42 -0700 (PDT)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com. [209.85.210.46])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70f67156623sm47556a34.26.2024.08.29.12.33.42
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 12:33:42 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-70f63afb792so354204a34.1
        for <linux-pm@vger.kernel.org>; Thu, 29 Aug 2024 12:33:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVVZgqPuA/D1sV1SPIJwNK3KGFoFRZKwwoxyD0yhIfKclnDAgs0Z5vsi4cMZUitXK3wJhfecGpqJA==@vger.kernel.org
X-Received: by 2002:a05:6830:b85:b0:70c:aceb:c6c4 with SMTP id
 46e09a7af769-70f5c21e47dmr4373135a34.0.1724960022060; Thu, 29 Aug 2024
 12:33:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821214052.6800-1-wahrenst@gmx.net> <20240821214052.6800-9-wahrenst@gmx.net>
In-Reply-To: <20240821214052.6800-9-wahrenst@gmx.net>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 29 Aug 2024 12:33:25 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X+VbFmzMk8mHy6HGf5+W-7YQjTEDPqiJXs0hecbZ_T9Q@mail.gmail.com>
Message-ID: <CAD=FV=X+VbFmzMk8mHy6HGf5+W-7YQjTEDPqiJXs0hecbZ_T9Q@mail.gmail.com>
Subject: Re: [PATCH V3 RFC 8/9] usb: dwc2: Implement recovery after PM domain off
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Russell King <linux@armlinux.org.uk>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	Maxime Ripard <mripard@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>, 
	=?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Minas Harutyunyan <hminas@synopsys.com>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Lukas Wunner <lukas@wunner.de>, 
	Artur Petrosyan <Arthur.Petrosyan@synopsys.com>, Peter Robinson <pbrobinson@gmail.com>, 
	dri-devel@lists.freedesktop.org, bcm-kernel-feedback-list@broadcom.com, 
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel-list@raspberrypi.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 21, 2024 at 2:41=E2=80=AFPM Stefan Wahren <wahrenst@gmx.net> wr=
ote:
>
> According to the dt-bindings there are some platforms, which have a
> dedicated USB power domain for DWC2 IP core supply. If the power domain
> is switched off during system suspend then all USB register will lose
> their settings.
>
> Use GUSBCFG_TOUTCAL as a canary to detect that the power domain has
> been powered off during suspend. Since the GOTGCTL_CURMODE_HOST doesn't
> match on all platform with the current mode, additionally backup
> GINTSTS. This works reliable to decide which registers should be
> restored.
>
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> ---
>  drivers/usb/dwc2/core.c     |  1 +
>  drivers/usb/dwc2/core.h     |  2 ++
>  drivers/usb/dwc2/platform.c | 38 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 41 insertions(+)
> +static int dwc2_restore_critical_registers(struct dwc2_hsotg *hsotg)
> +{
> +       struct dwc2_gregs_backup *gr;
> +
> +       gr =3D &hsotg->gr_backup;
> +
> +       if (!gr->valid) {
> +               dev_err(hsotg->dev, "%s: no registers to restore\n",
> +                       __func__);

nit: IMO "__func__" should not be in dev_err() messages. The message
plus the device should be enough. If __func__ should have been in
dev_err() messages then the Linux kernel would have automatically put
it there.

Aside from that, this looks reasonable to me and discussed previously.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

