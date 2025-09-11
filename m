Return-Path: <linux-pm+bounces-34487-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B83E2B5362F
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 16:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47727174191
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 14:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A23D343D79;
	Thu, 11 Sep 2025 14:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="So7B1T1C"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AF834AB0E
	for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 14:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757601971; cv=none; b=Q3S+3QwjS0K/wGXM7RSy3Q7Lz1Zar5LFekb0/Xp04JnHUDCVGP6tTQIba7bl+ENtxDQJFmwc2HHz/aqUlYQijAKdaK34WgckOyv51dcbk1C66BzvSLk164sELKiiy/N7mx1FO1kapW3kQs7mCFN5lnmK/Hh20fbY7OfByWNvP0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757601971; c=relaxed/simple;
	bh=VKSX47Aju/DzSJYwp5bYidhSzFn8zeiXLyG/eQpEZMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ECoc27IEyOHEGo0ayRrAp/8bASpLO0wSTeTMfvjxRuueHjuUn0nUOXjM7brQAuLJR3RDzSVWPRlXHH+i0ce00gG1nef4iewp9VJKKm+MLmF5safCoQ3/X2+n9z8fkWpVwZo77MpfD6lOfxUQnF6hfP3V8LISDgJxBlIxRrcnADQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=So7B1T1C; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e98a18faa35so775237276.0
        for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 07:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757601968; x=1758206768; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HG5KODUu0GjbUdNiiv9Xwk+9exlrDUpck0LIesxLbE4=;
        b=So7B1T1CKaqLnhHiPP/+1FWFEu/6R4m7Mbj5/xzn1SE6S1xslf7Jhr9oBemetkknbf
         mUV3o0erG1SIkW5Y/MHYT37UHVGW3TE8CRVYfHVeXOwP7SUKwqDjqaF1dYNVNvSWf/UK
         nOtD5PhR0U4xC4G9+92USMeC3V1YD4gVCmT607p+HM1gVGaVv8wXB1lXiJtpLF/8CfrP
         Pu6Ppe0MHyPMWyzVa42Wq2h31rTVK8pl4mAtAiBNaHZ7BGqo3YE54ygZOfTRArfKMoXS
         bKZhZWJqVKRFIpJG4wYe0kGjldN4WcENcRo+No/axwP/KWnYRLnZAC1J/7GbpdJWi7MG
         znvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757601968; x=1758206768;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HG5KODUu0GjbUdNiiv9Xwk+9exlrDUpck0LIesxLbE4=;
        b=rcMGH2f85++z0WtynAMIY9sCi3T/3AfgPgYYHqxAtlniuP9h1QGq8PfuQShQD/mHQV
         WNyM+/17Ou2wInS2ccvyQY6hjEQCJbDMcxZ83EI1YvZ+z7x6dPueCpsmD0EE8bq7cDfL
         Yh0a1Y/RbKnQu6Zljx/xJyWr/pM/Ru4e4lpZZgl4TH4uB/hnA/KvK436xeKnhRdAahRT
         e1DyvJ3s/L0wzjIygeZUBP+4656Ea+0K7hKVMQ93nLUL2MwEm/Ve8rVYVPtXF45QgktY
         Qkr8MJ6CMaW1aJIuni7NeKFFJvkQBskb6ac/4uAEa5NZFLEHtavb/nWLa1LfyEsH40Kp
         vLqw==
X-Forwarded-Encrypted: i=1; AJvYcCUM0F+z4DjmGRQT80406IfF9hwoRdn4REb5TmrBnuc14KpRaeu/ROyLeIfZEmOuDXGohi1yGbPOIw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/4r8gJAA/YKjW+pNt2KHNIBJ7602yLy5pyKRulpj4o0TOSBL6
	yQMc8Tk0nOwBNtgIQtmqHhHKkNbmquuUz1P2PAsEy1v0+RjzX8K15feMT2Fqip83r0eJorwWX0O
	zQPuetTwMyjIUVMREsDAKJTWm9aTVVk3qsl1u6+jebA==
X-Gm-Gg: ASbGncs4AYoAJIN/SojeRZL+dG740A7mTyXTY1bYWkJrdm3GBMkvAKV7n3tqAqKSPWR
	RriAmPvD6evJYVoeatiLuw6kIKAKlmCUNwMddW3UYi8duDM6AyTzftPy8xNOZPQu60oRfAEOUzO
	l/vUVAa9gMbks9fGmzJwMQdMeT3/zmFRj3R2PCN3C+m424DJI/yotHsmSK3M7tNsWwx7E3urJx7
	Q3vbazZIGyMU1oyF7dPtffWcBHcPA==
X-Google-Smtp-Source: AGHT+IGA14KLSVMCK2zV6p8As0+Jn95rbWVq+KPV+CqkNJxyiiFOFLcSxRvo/0exdQaaGDHMXMlIe6ixp4mKa1e9IQY=
X-Received: by 2002:a05:6902:1892:b0:ea3:d40a:2563 with SMTP id
 3f1490d57ef6-ea3d40a2737mr1177746276.41.1757601967783; Thu, 11 Sep 2025
 07:46:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902-pm-v3-0-ffadbb454cdc@nxp.com>
In-Reply-To: <20250902-pm-v3-0-ffadbb454cdc@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 11 Sep 2025 16:45:31 +0200
X-Gm-Features: Ac12FXy4zlU7KeT4OFE-vyI1bqh6ZB1528BpXJl_SwXQzUbCOw7DO0NcEvUZLJA
Message-ID: <CAPDyKFqBJQ92HH1tSq1rfbXV1OwbyvgChyHfv7ykJqf2A6qYpw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] pmdomain: core: Introduce device_set/get_out_band_wakeup
 and use it in usb
To: Peng Fan <peng.fan@nxp.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Peter Chen <peter.chen@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, imx@lists.linux.dev, arm-scmi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Sept 2025 at 05:33, Peng Fan <peng.fan@nxp.com> wrote:
>
> This is pick up of [1] which does not have response in about 5 months.

Sorry, I have planned to have a look at this, but just never got to it.

> This V2 patchset
> - includes usb driver changes(patch 2,3) to give people a full picture on how it is used.
> - Rebased next-20250729 to resolve conflicts
>
> To i.MX95, USB2 and USB3 are in HSIOMIX, but there is always on logic
> to make USB2 and USB3 has wakeup capability when HSIOMIX power domain
> is in off state. Otherwise the HSIOMIX will be kept on when
> USB2 and USB3 are configured to be wakeup source and Linux suspended.
> With this patchset, HSIOMIX could be powered off and Linux could still
> be woke up by USB hotplug event.
>
> Patch 1 introduces device_set/get_out_band_wakeup
> Patch 2 and 3 are drivers changes to use device_set_out_band_wakeup
>
> [1]https://lore.kernel.org/linux-pm/20250311083239.3336439-1-peng.fan@oss.nxp.com/
>
> More old discussions:
> https://lore.kernel.org/linux-pm/20250311083239.3336439-1-peng.fan@oss.nxp.com/
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Overall I think the series looks nice, but I will make some more
thinking of this in the next few days and come back with some proper
comments, at latest in the middle of next week.

Kind regards
Uffe

> ---
> Changes in v3:
> - Add a new patch from Xu Yang to detach power domain for ci hdrc
> - Add A-b for patch 4
> - Link to v2: https://lore.kernel.org/r/20250801-pm-v2-0-97c8fb2a433c@nxp.com
>
> ---
> Peng Fan (3):
>       pmdomain: core: Introduce device_set/get_out_band_wakeup()
>       usb: chipidea: ci_hdrc_imx: Set out of band wakeup for i.MX95
>       usb: dwc3: imx8mp: Set out of band wakeup for i.MX95
>
> Xu Yang (1):
>       usb: chipidea: core: detach power domain for ci_hdrc platform device
>
>  drivers/pmdomain/core.c            |  6 ++++--
>  drivers/usb/chipidea/ci_hdrc_imx.c |  8 ++++++++
>  drivers/usb/chipidea/core.c        |  3 +++
>  drivers/usb/dwc3/dwc3-imx8mp.c     |  4 ++++
>  include/linux/pm.h                 |  1 +
>  include/linux/pm_wakeup.h          | 17 +++++++++++++++++
>  include/linux/usb/chipidea.h       |  1 +
>  7 files changed, 38 insertions(+), 2 deletions(-)
> ---
> base-commit: 1b09efec32046a9c78cfecc46a26b1b139a3e8a8
> change-id: 20250729-pm-243ff7097e44
>
> Best regards,
> --
> Peng Fan <peng.fan@nxp.com>
>

