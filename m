Return-Path: <linux-pm+bounces-37115-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40418C20F1F
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 16:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99C5418837F7
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 15:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446A3363BB8;
	Thu, 30 Oct 2025 15:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ykS5ibOb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1A5363B90
	for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 15:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761838089; cv=none; b=YEGcYCe4yckC8+8l2wH16oaUYpdp8wJ+kVPMIw8CXb9uk9CPYpJR5uqyjQOPM9Lesf7U4mAmt5+dLTu/KEuY0ogGPgKR+PCuHzkHfvb57p7RAMpNCbdHua0pAKaXOS0XNQr2Dz3NN8ZSGEhPRCFbWsNT2MuF3XzkDozBihwRbsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761838089; c=relaxed/simple;
	bh=XB11xGL63R2dsjBDo1xzLACnAhYwocbX+tplDz8muzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VlMURjZcl3/fGmTwi0fFEbmqsyQeJgf7AFfm2TqlC44dCzSbPhLbZ8Xwv62qKEo230rRlWD/63in2z38qeZd8mXjKG97oqKodfD0gOrnOSYso3dpjui1uYoIBcHsF00/thl9+TbZ/KP6XfZgqMe5RDxlo93VDxoGlVIL7+bxJ6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ykS5ibOb; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-785bf425f96so32932867b3.1
        for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 08:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761838086; x=1762442886; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2ycPp8pZgEFoeQMpyGYzVQ4IFRsCoJ2aRuKd6SDWpxA=;
        b=ykS5ibObCHGvrPxm47c2x4Tgtx5sQC4UoKIvNO7OMDUehzP4BnEMVQkpkKQMHyJfMu
         OJguViaGuEn09tgLRmkfhc+UopKSJnmrEQQI9hmX53/HR/IOrVjZAQhrC9L3EQSA86r8
         3hDhQqcV6BACvSEomev/mTYOydrmgFfwbIJ/rp9IUw9fqWUf+pxzl53H+UbcbZRhQhGh
         6dqkMnOW181DaQSjDzc29KuBoUrAYGRBC58kIZ/CvFaTokkA6qdm9qVJHGHRKapoAWif
         0hWj/hnjCn21GUuBPdm5CF6vPWO7QzbCoIxj+gUGzFyQAqTsKRBP8sqRUwvUHwehcVsP
         nCNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761838086; x=1762442886;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ycPp8pZgEFoeQMpyGYzVQ4IFRsCoJ2aRuKd6SDWpxA=;
        b=VAHs/GQORsJBD3JDvCw1MAu3YkKJRTHm2UZaEPa2zvllIsS8wm2syKJPRwr4sl5DnJ
         82VEU6DHEN1HB92r/9FUMnH8bxZIIRRg8oDY+et5GV8au0XoCImGNzoD05q3JySkVI1n
         n2HmJkUdVvBkjAe3NxO3eRJRv3Iiu3KDtKghtkJOPBw0acc9GWn8bL4yUPiZLZipqaWx
         uN/l6n2KSjHUyXpH0W+6Ed3QkVOThp7oBPAhoNToUQ9343NqBO96FwErhlUWI4BadPUE
         2mTnyTWQ944hySa5BddW2voViMKEKNR6yvkyVY1y+QnUjDFXjceaKG79WtXplq1WLYaP
         Cdjw==
X-Forwarded-Encrypted: i=1; AJvYcCU9F8QUBm5sbvyEr3e5GhL73xpyWLQDgBLJPjn+wLBgJdq9Gn+bCfo60W+hNj43TVymn/9ZKyovtQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyIWmzVbBL4fGEcaXMC4kTMbViHlqHqUCmlVfb7MgcCpvHueXVU
	NcgmNQlS6N2khoFB3i1S693jBRPRGFl8DvmQ4wdyqw4Eh1J7V0xLA+zMbcErPBO1oEy6BEHtdwj
	uwmTjVDKfE/XNiGT8NSOy3O348eonFBev5zUlXbaELg==
X-Gm-Gg: ASbGncsGoP4Rx5zBxx53YdFDnXPW8Yr/6ClvLaKpo3DuK621aJ149yHgeRwhYEmuvk8
	T9bz6JjeUpwQyJVKEvNTBKIFUCGOO3R1fFqmbTDqAg0hlN+nVk8gqUj6yPyqpXQsjOuZDozoDpB
	tBFqFvqwu38gtREEpvWAmdxXhfKNSgi2GinAq0ducdae5WOyJTx8fHQqt54+Il1UftXJmmJ90dC
	R+Fj4+MXXF8mdU3uNpxeLuXhoAMYhKPlieYM7pbH7GIu5YgXvJShjfzKZy8DA==
X-Google-Smtp-Source: AGHT+IE7cHjINSkLMQTgzs6w+5tGJD0Nm4hSDWwJhVubSFRkYHz6tUwfvq/JjfaEUpptZLodo7e/iRO8bn4zeLZcNk8=
X-Received: by 2002:a05:690c:c34a:b0:730:8858:827 with SMTP id
 00721157ae682-78638e15c6cmr28491297b3.19.1761838086224; Thu, 30 Oct 2025
 08:28:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917063233.1270-1-svarbanov@suse.de> <CAPDyKFpus05RAkYAoG7zjyvgAJiuXwRt3=z-JB5Kb7mo0AK4vw@mail.gmail.com>
 <c379087c-1702-44b7-a890-beb5b77d794b@broadcom.com>
In-Reply-To: <c379087c-1702-44b7-a890-beb5b77d794b@broadcom.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 30 Oct 2025 16:27:30 +0100
X-Gm-Features: AWmQ_bnaXJddKoSJGHltKVC2FCgxq7fO5V7a69ZXCIkr6_3dvFmm3LKqD_YY314
Message-ID: <CAPDyKFowo7+-C4YLLw4XoWz4fU3ykEP1UVEEneCJXBuDjGTStw@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add watchdog support for bcm2712
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Stanimir Varbanov <svarbanov@suse.de>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rpi-kernel@lists.infradead.org, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, linux-pm@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Lee Jones <lee@kernel.org>, 
	Willow Cunningham <willow.e.cunningham@gmail.com>, Stefan Wahren <wahrenst@gmx.net>, 
	Saenz Julienne <nsaenz@kernel.org>, Andrea della Porta <andrea.porta@suse.com>, 
	Phil Elwell <phil@raspberrypi.com>, Jonathan Bell <jonathan@raspberrypi.com>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 26 Oct 2025 at 21:23, Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
>
>
> On 10/13/2025 4:08 AM, Ulf Hansson wrote:
> > On Wed, 17 Sept 2025 at 08:33, Stanimir Varbanov <svarbanov@suse.de> wrote:
> >>
> >> Hello,
> >>
> >> The following patch-set aims to:
> >>
> >>   * allow probe of bcm2835-wdt watchdog driver for bcm2712.
> >>   * prepare bcm2835-power driver for enabling of v3d for bcm2712.
> >>
> >>   - patch 1/4 is preparing bcm2835-power driver to be able to
> >> control GRAFX_V3D pm-domain. This is a prerequisite for the follow-up
> >> patch-set which will add a v3d DT node for bcm2712 (RPi5).
> >>
> >>   - patches 2/4 and 3/4 are adding bcm2712-pm compatible in MFD driver
> >> and update the dt-bindings accordingly.
> >>
> >>   - patch 4/4 is adding a watchdog DT node for bcm2712.
> >>
> >> Comments are welcome!
> >
> > This looks good to me!
>
> How do you want to proceed with merging those patches? I would assume
> you would take patches 1-3 and I would take patch 4.

Yep, that works for me. Awaiting a new version of the series to get
the comments on DT patch addressed.

Kind regards
Uffe

