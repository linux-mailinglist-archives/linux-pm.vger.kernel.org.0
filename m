Return-Path: <linux-pm+bounces-37460-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F4BC35B5A
	for <lists+linux-pm@lfdr.de>; Wed, 05 Nov 2025 13:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C1F204E6408
	for <lists+linux-pm@lfdr.de>; Wed,  5 Nov 2025 12:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9564A315D30;
	Wed,  5 Nov 2025 12:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tO88aW2X"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA82B314B64
	for <linux-pm@vger.kernel.org>; Wed,  5 Nov 2025 12:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762347209; cv=none; b=dgTrWuPjfu3UFqNYa2WeyYYvScxEnA6wdhTj1l3SBMPyRHZCCNK9iZVbS+RZ4wBoJrIemu17T5eckbuCvmquRLtkxhtyIsLCk2GkC4roZcQUOBELPRibaf/4yT5e9h64MUCVpw2rBmlkLLRTjSiFxpV2QkYlWGQCutEpbuqM78Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762347209; c=relaxed/simple;
	bh=+ZOOz+bd9i752tRldCuS12aOoHVwIBWiXPKmP/KxxI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FyLSxBKcCPR0Nr8wpyblclES1QlbpX9UwIJX9YrSWloQ9BUn/s1/JMXh+JxprSMCsynKL9nK/FszojtvMXyV5ZWK1LmpX21qbMh0IwUSQ2d9cY+zislIEiyOeW1H4hz8iOnZfFzpddEwKpVwwx3eBeJy2tL0nhdRL2Dc5sNfe8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tO88aW2X; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-63fd2b18c40so869678d50.0
        for <linux-pm@vger.kernel.org>; Wed, 05 Nov 2025 04:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762347207; x=1762952007; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jssj8tcz0aY4xx9zjyBXJVY+CGYy95sOugmtidwxoNQ=;
        b=tO88aW2XEymmZlg8+1B+OhDnem5E2e+1wEdhZf6Qt7stm8/6vymVy2KvLgaRtacbsT
         IpGU+0SHBDJiCo3Op8nJCoL6y0se97A+TqZE0hXmrg5pO5cXmwdMLInAjD7/uzPwb5yJ
         Do5WLMB5Ir0zQL3oAG+erHu747Ox3Nyh4IUEdrWcRG41KTcLboXr0WdtNfSgshRr35mR
         zhZn+/+B82GjS5HZe2S8yB4CSeE8KcQF5KN3Y8MJkj7+bSQOqsa91r5S1Yx44g9kKjU5
         2eaFJMXlzbpjv7CXr+HzSpY9ziYh425irVZol3XlkXQCUTpeq1qjA6RzlFBPAwVxtFIy
         hpEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762347207; x=1762952007;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jssj8tcz0aY4xx9zjyBXJVY+CGYy95sOugmtidwxoNQ=;
        b=k/uTv+e9YYQ82zwkko0XtaJ5cbbXfgmQ/7cLDDHbfLfgz4CUzQFIcRRtxOXe2TBjUn
         7H0xP1MOD2k7kPE0eRlmuXc9UwLjzLmeJ3gmsIEjzK8Ag/n9POvOQWD+LK7GDnX7KUOc
         vJS3XJkA95XYvV3H9rBAbIA2u4gjUA/kAdcYSAbnk7AX8qCqXFZZySsX4k9BypL2lmAp
         CS6nN5zuRpVX2n6UDFFUn2GBqVlfFA+uFPW2bWIswqShs7vuWTclrAmIpWAcM2RR858r
         3/B2M5JeJTDhCHSglEMpc1CMR11EdxknPUwJDNafSvTLcAo2s52t08Die9Cd5C6MLHX2
         SBtw==
X-Forwarded-Encrypted: i=1; AJvYcCVyqf3FTyBgV0Kq9jeegMmVctlK5csOSoR7p3DOsjKoUDoG93aKEvnNlutFItpHDY1z2hlINXZ6lg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFnUOBxMgoDOSksZXrv+nTU3EbnEzwIADApsHPLtlaq/ubHJ8i
	2E1vpDH8EVFFVcm857Oh0tnJQddqSkYDjGOY8XVE8VwWzyz1fyF+yMWl74bzUb7qVMAXDGSfuLC
	vLLA5h7tCNJErU11DSeGOjOhdei3LGpubg/2K41x9Dw==
X-Gm-Gg: ASbGncssFPfIFuSro4no7sPgtmueDR5yVLFl1TDxGUQlRmIOttfiP7zmkwNrlq+Muoc
	eBX8JtsPaocxA7j7cFOBiF/62ZUeLPVJESsnnDinSqhTx9Rswwy5GUO5R29oif5tDxiXHkzcjss
	8vW6OaVxr2LRf3FlAzDjJWV5WjXmWWHdcLiLXjLzbJRpN7pO4XW7UrCR48rcezHUxnG0jRAcDEc
	XtzPr+VJpN5SpN4JESpIIatvSIM+Ox5s6oRvOyaIMl/Ib2NJOsPq+74xqTdzw==
X-Google-Smtp-Source: AGHT+IEfE0sgdiFVkZmKF1dZxXig2jTxj45vJSC6LxMQVNg2FzDnEW5ajmYQgYPmXHM9+L5zmqyzIeI1NXQMsR92k1k=
X-Received: by 2002:a05:690e:15d4:b0:63f:bca7:fff6 with SMTP id
 956f58d0204a3-63fd3571aadmr1876951d50.36.1762347206857; Wed, 05 Nov 2025
 04:53:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031183309.1163384-1-svarbanov@suse.de>
In-Reply-To: <20251031183309.1163384-1-svarbanov@suse.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 5 Nov 2025 13:52:50 +0100
X-Gm-Features: AWmQ_blullTpT8Nfe-qMS1ztFmCY1ERew4O3PuDztRrqUvx0BImetke1Cxs_hWE
Message-ID: <CAPDyKFqHizQKSDCuPopNBWtt1mNCNuWegv9c=PcXEEVaUaP3cw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Add watchdog support for bcm2712
To: Stanimir Varbanov <svarbanov@suse.de>, Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, linux-pm@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Lee Jones <lee@kernel.org>, 
	Willow Cunningham <willow.e.cunningham@gmail.com>, Stefan Wahren <wahrenst@gmx.net>, 
	Saenz Julienne <nsaenz@kernel.org>, Andrea della Porta <andrea.porta@suse.com>, 
	Phil Elwell <phil@raspberrypi.com>, Jonathan Bell <jonathan@raspberrypi.com>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 31 Oct 2025 at 19:33, Stanimir Varbanov <svarbanov@suse.de> wrote:
>
> Hello,
>
> Changes since v2:
>  * 2/4 - Use maxItems instead of wrong minItems in else clause (Conor).
>
> Comments are welcome!
>
> regards,
> ~Stan
>
> Stanimir Varbanov (4):
>   pmdomain: bcm: bcm2835-power: Prepare to support BCM2712
>   dt-bindings: soc: bcm: Add bcm2712 compatible
>   mfd: bcm2835-pm: Add support for BCM2712
>   arm64: dts: broadcom: bcm2712: Add watchdog DT node
>
>  .../bindings/soc/bcm/brcm,bcm2835-pm.yaml     | 38 ++++++++++++++++---
>  arch/arm64/boot/dts/broadcom/bcm2712.dtsi     |  9 +++++
>  drivers/mfd/bcm2835-pm.c                      |  1 +
>  drivers/pmdomain/bcm/bcm2835-power.c          | 17 +++++++--
>  4 files changed, 55 insertions(+), 10 deletions(-)
>
> --
> 2.47.0
>

Patch 1->3 applied for next, thanks!

Note the dt patch (patch2) is also available on the immutable dt branch.

Kind regards
Uffe

