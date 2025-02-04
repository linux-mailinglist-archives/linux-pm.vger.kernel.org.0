Return-Path: <linux-pm+bounces-21331-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4309BA27497
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2025 15:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEA163A34D9
	for <lists+linux-pm@lfdr.de>; Tue,  4 Feb 2025 14:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19F42139B1;
	Tue,  4 Feb 2025 14:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z8kwqlIR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02592135DF
	for <linux-pm@vger.kernel.org>; Tue,  4 Feb 2025 14:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738680083; cv=none; b=R7qyEU8MfWcaF3qNxH9cHYpJy0vIkV1wX55UBnBYBKv2tcMm0mqNSn9YyE3CjHlT1gKMpl4pw4Onnab1Wec7K51uu9LA28ZJ77M8v1XqKm3q26VNTM7yeDtBr7sBbpl11jsAW/NGAdm1FqWmv6rImB/CRr3GIgfLe2ySxAoy+VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738680083; c=relaxed/simple;
	bh=VratI1gorIVk++mXMPkarxHqA4WaMNC+n3Th3vZqImw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pJNSQ9BJ6s5KX6R1xsvxBBdCbycXrY1oc2ZPmmjsICnBUi8io3TvZD4nfdUuKfiS5h/3GmDNk45oYqxWuLJQa0kCKahoH+YVYpTRk07YgrlUuU0ojUWKiGgNtL/5T1raVzAAmcsOevi3ILfjSlA9CSMPaMaPI/mgB0B7+jLdxJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z8kwqlIR; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e5b1c7c31b2so439537276.1
        for <linux-pm@vger.kernel.org>; Tue, 04 Feb 2025 06:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738680081; x=1739284881; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OGRkyDL8K72mesTVBS1vSQICOMIKizD7o9itaR6TuIw=;
        b=Z8kwqlIRtQIVO4dijUkFo9mq6XUwaJPS1tIDkTibl4HMgb8o1sT+yW1gHzmC2zkGec
         MopoWpBuVcEOexihtNz1QveORDvCLHkE6LZfibbO3R5r06k/at+VFvPyBzwXwhpXUWgW
         /czbxVI/62LD+eb5lzpSxEE34g2OpBc+MoS+7apTmT6NAE9sLS/5AcToyClDiqOLgSpc
         eA3TeaTZ/NDpeaEMFGufrz5eGxFLHdFe4T0+ft5xmG0n/IBjxjLYRoPMtVTIet75u5Iz
         VUc4as9p+NW7ZQTxWDFl6TRdP2LlZFwv+S/S+z5M7NVv2aRB+I3zJmb0f09ttm+XGP7q
         KoAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738680081; x=1739284881;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OGRkyDL8K72mesTVBS1vSQICOMIKizD7o9itaR6TuIw=;
        b=QrP0PvTZ3rU+FVt04jp5WrJ66lachMveNpTvxtCUac8rolG7OAv+jTYilS8GQXovz5
         aKAOU7HCcMM2BmAY3h0bJFdbtyRRxIIs4YpCJSb3vwVPLtlEa3c0m2HFrGNzX2TgYCHm
         XZ7/bkwA2+AurLWnOSeVUPCwJUsGD+hucQ5RfGEMOuMyLVN/IkQsRq3YeCNW9YNi+qSU
         K7n+wv+vBOfsF6VdyoFGZv4m9UImo5QJYO91Gi9ZvWndHNPzdreE1W1blJ27sl3VqS18
         lV2ayos6/s0LL5gxiZ5wTowxUyqkzBQVUKsTQW2RR3ww1/z3W0UGXc/onDeraJtyh+qy
         YLDA==
X-Forwarded-Encrypted: i=1; AJvYcCULwLVoPzERxpsU25mqbBHaKpUlAZpLyNwpODpEAKD6gs06AlbiQvf4d9VZOkRhpPWiVny+oPBS9g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxx8Pswe1zXnLBKzklOTUmHyh/P7W5JFOpFP4xxHoljYmIhtPU
	fEE3vfKgZQOHWYM7K4RKwqf7A18rEv2BZ1ASA6EEBbpJ+SF+pC3eYukBJiX/RNTTG+fV7auAv8e
	CDaQKmdz5WDp+uvqtDfPfdBqvrlUC9gC0DM5DCg==
X-Gm-Gg: ASbGncu5tPNgujqv6B/MBDdkCBbzXFbGjXTNbQVtMZCifozwiz5tKwIvnikui+ObzF6
	MHefz0NbE4v+Xu6BLSA6WlfkY1i1HK1/Ld3aYpN+ZVC+1OI4Zoq4DDnlRg9X1wXup8eZfpQH1mw
	==
X-Google-Smtp-Source: AGHT+IHEJHlC85HQWuM8lzCRPkCYTm26DmKxbsrdNmEcZl5QzCLwHRfJAPEcrlu9g8m1xdXmVFXRg09aHtNqBmMw1dc=
X-Received: by 2002:a05:6902:2748:b0:e58:fd2:2cdb with SMTP id
 3f1490d57ef6-e5b135b71f1mr3313017276.7.1738680080564; Tue, 04 Feb 2025
 06:41:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250201111926.31278-1-wahrenst@gmx.net>
In-Reply-To: <20250201111926.31278-1-wahrenst@gmx.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 4 Feb 2025 15:40:44 +0100
X-Gm-Features: AWEUYZk20DnMMJ7T5J2UmZk0KreMLJqzyGpladqXRRAACEg9YOoR9C2hEGMA9Ow
Message-ID: <CAPDyKFojVOnjb2gGx3PS=rqRvysRTqeiUAHx+XJOtXzXBSRzYg@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: bcm2835-power: set flag GENPD_FLAG_ACTIVE_WAKEUP
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, Peter Robinson <pbrobinson@gmail.com>, 
	"Ivan T . Ivanov" <iivanov@suse.de>, linux-arm-kernel@lists.infradead.org, 
	bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 1 Feb 2025 at 12:19, Stefan Wahren <wahrenst@gmx.net> wrote:
>
> Set flag GENPD_FLAG_ACTIVE_WAKEUP to bcm2835_power genpd, then when a
> device is set as wakeup source using device_set_wakeup_enable, the power
> domain could be kept on to make sure the device could wakeup the system.
>
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/bcm/bcm2835-power.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pmdomain/bcm/bcm2835-power.c b/drivers/pmdomain/bcm/bcm2835-power.c
> index d2f0233cb620..d3cd816979ac 100644
> --- a/drivers/pmdomain/bcm/bcm2835-power.c
> +++ b/drivers/pmdomain/bcm/bcm2835-power.c
> @@ -520,6 +520,7 @@ bcm2835_init_power_domain(struct bcm2835_power *power,
>         }
>
>         dom->base.name = name;
> +       dom->base.flags = GENPD_FLAG_ACTIVE_WAKEUP;
>         dom->base.power_on = bcm2835_power_pd_power_on;
>         dom->base.power_off = bcm2835_power_pd_power_off;
>
> --
> 2.34.1
>

