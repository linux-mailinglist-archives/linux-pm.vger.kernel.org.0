Return-Path: <linux-pm+bounces-22049-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 369E7A3512D
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 23:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E67C17A1C9C
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 22:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1537026E15B;
	Thu, 13 Feb 2025 22:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y8oiwHZK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C05E26981D
	for <linux-pm@vger.kernel.org>; Thu, 13 Feb 2025 22:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739485467; cv=none; b=DwAo8uG/F4fWhwW7Glr1NHNHiyW4bsYygMPsQGzzZ+eZS+GrMePliOnJLVut290t0GM2BoYzFdu5fEcBNQVrQvgVJ4cXcFevMEcoldz4QY7ZTTqRvodDltCrCShzwXIYOoxV2Aq1EWve0Ny34hoAN1XiQ4Jo1eIB49R7nY64IEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739485467; c=relaxed/simple;
	bh=7FRfjoGFhfUSUt468TjZa6ZCPVf+awWsq/1VBYfIRuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCo25cySlOtrH/UZy36/e0gg4V2AnZReQAdfKMcY6A/fn+BS5hszZGmdL55IwsMdR+k0qpahJOH8MbJkYJq74bs9W+R8RbrqORA6SzuhA3I1svnn7t8PHUn7X10bRU5bD2PzvhANGmfOstUCZlmGZFD7E8fYFI343lOyrsSW7A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y8oiwHZK; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54504a6955aso1139207e87.2
        for <linux-pm@vger.kernel.org>; Thu, 13 Feb 2025 14:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739485462; x=1740090262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=30VlZ7jh4l0IEP8QnG7/qbFduRo38zLaP6BKsGUzZqw=;
        b=y8oiwHZKt0YgBCbAg5t+SxwG1YA7ts5LGsMlOC5bAan4Gwn3uoDcJre7tIsCvY+Jr6
         AGKJDoKwr/Pe96R0/r9+B+1plf1X26uRsSwSSzIuOzumm3DeWfnxoOBllqgqVC1Vq+co
         pZ3WYgY6H8GIxnnGpp29Z75wSSouVJlnBsu9Jde3N0fBJnEREZ/7Gu8jJuIu4oTjqsiZ
         vJikLet9XSXD/7+wlAOEMxi+Ffu4doCexCUJO1BCiRRH/lNVU2fPB420GDzKA1U/3lz/
         jRG00VODDZyL5an01O1L2VKhelZsqE01TYgEOdxdSpEcSYWyBy19EwqZQ8hUAW0h5bG6
         lN5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739485462; x=1740090262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30VlZ7jh4l0IEP8QnG7/qbFduRo38zLaP6BKsGUzZqw=;
        b=bi/zGD311JCCc9QlCttDM1OzyEc0D/hfQK84AjqDLhYOXR7BsaqWzCAHVE1GUOxNhW
         YBn5VOc0FgEkRg/nNQMC2HGcH9gjySHvBXQWw6tpYI2s4YGPp0nNM//GZ/L4ARzKNjmN
         3EgyDb3VdVHF9YtDQMoX7WHkqZEDs4wuqc984p87IjV4O6mwXjk0LR4dHuHNFYutZQnu
         waRL5D9+VKWkte0+eounXFRvbRy7PQHziEbHL0V3R9fBOww4Te+8w/7V3rECz2lGZud+
         OtYT5wtXVWtqG+6PwxdrOk4vo4kGG1E/UzBz6Vmld8nC54cfv+r+PkR/RrSfnuCaPiaX
         UzrA==
X-Forwarded-Encrypted: i=1; AJvYcCVx7NYLXPnfJQrCapCD9N30Oa9eQo59HCe0A5r2h+vZXqor8+qHbGGVw68oZKolZHxXzEzBC7sNqA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1ODCW4tWPvSsQmLsNx5Zey+K3I81zvSA3BCx+f9E59HgEkK98
	FeO5LwSJVkxzT0+Ig6skcGmTSOy4scc3TtwqS297/DKPPZA7sHE6gVXYFSAWx2365VHMx6BA+/0
	vx2Q=
X-Gm-Gg: ASbGncunNo0gcwViGTvQZVH8AIhs1F0PwBmmLLbauUdWbvq1T9AjktW71LT6hGpJ9Ci
	7p8itMXRhIwwva/FH4JDbBD5CcT/9fjyyNLX2jHQAQtnq6Pl7T5GeRsCfjPKJ096NE8Z6FXPKIO
	T2pJFkx/9qvRnjsbVGdSRuPd/oIXdKXJx2pVR+b04u2V43B5PL3KhEnUUkJWY1j8+yNlw9z+U/U
	cIrowLSA74oICzVEoXVJQtKk6h8JlNC8qftf3c4JfsGjB/527RLs5/57yAHkv5b2V2DQHJo3108
	VCc2hrD9gtkYivG1jY+jx+IOOBRSiQa/Od7kmmt//3b23eegv+Z9fNf7Lzb4ExqE7J6sX4o=
X-Google-Smtp-Source: AGHT+IHuu1+RSvJrrCNOvck4+O9LWm7v9dHEk7GUicB1Vdkhxazd1lrqf+b7glyWor8ZgNaAhVRjGg==
X-Received: by 2002:a05:6512:ea6:b0:545:16f0:6ca2 with SMTP id 2adb3069b0e04-5451ddd6730mr1552626e87.42.1739485462508;
        Thu, 13 Feb 2025 14:24:22 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f11ecf8sm299005e87.243.2025.02.13.14.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 14:24:21 -0800 (PST)
Date: Fri, 14 Feb 2025 00:24:18 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: aruhier@mailbox.org
Cc: Sebastian Reichel <sre@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] power: supply: qcom_battmgr: abs() on POWER_NOW
 property
Message-ID: <yfbgbdugk4xdjpemozdzcuxczx4xd5aphykuksf3lhn22dsgkf@fcfgddu6gpyt>
References: <20250213-patch-qcomm-bat-uint-power-v1-1-16e7e2a77a02@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-patch-qcomm-bat-uint-power-v1-1-16e7e2a77a02@mailbox.org>

On Thu, Feb 13, 2025 at 05:51:38PM +0100, Anthony Ruhier via B4 Relay wrote:
> From: Anthony Ruhier <aruhier@mailbox.org>
> 
> The value for the POWER_NOW property is by default negative when the
> battery is discharging, positive when charging.
> 
> However on x1e laptops it breaks several userland tools that give a
> prediction of the battery run time (such as the acpi command, powertop
> or the waybar battery module), as these tools do not expect a negative
> value for /sys/class/power_supply/qcom-battmgr-bat/power_now. They
> estimate the battery run time by dividing the value of energy_full by
> power_now. The battery percentage is calculated by dividing energy_full
> by energy_now, therefore it is not impacted.
> 
> While having a negative number during discharge makes sense, it is not
> standard with how other battery drivers expose it. Instead, it seems
> standard to have a positive value for power_now, and rely on the status
> file instead to know if the battery is charging or discharging. It is
> what other x86 laptops do.

Documentation/ABI does not define ABI for the power_now. However for
current_now it clearly defines that it can be positive or negative.

> 
> Without the patch:
>     $ acpi
>     Battery 0: Discharging, 98%, discharging at zero rate - will never fully discharge.
> 
> With the patch:
>     $ acpi
>     Battery 0: Discharging, 97%, 10:18:27 remaining
> 
> ---
> Signed-off-by: Anthony Ruhier <aruhier@mailbox.org>
> ---
>  drivers/power/supply/qcom_battmgr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

-- 
With best wishes
Dmitry

