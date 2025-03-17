Return-Path: <linux-pm+bounces-24149-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A50A64B24
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 11:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3F0D3B1A9D
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 10:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2DC230BF2;
	Mon, 17 Mar 2025 10:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C1yzDE2t"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BD1221730
	for <linux-pm@vger.kernel.org>; Mon, 17 Mar 2025 10:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742208693; cv=none; b=WLS/s3L6sRGLk36E4Dhv/MHrLL4eHJy8h3OyUs2X835XDLV50+36rb4PIZB2EM4VwUOydw6TeNzlfGoJpFwzL5a4eiUjmOlh/08isko6xp4z/rJN570ZbCrJauknTD1az5P0VzbfiQhAC95QBuEMQm7WDLSMqlJrVtlQCc9kRnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742208693; c=relaxed/simple;
	bh=sHAOrNAdc7cHSKBLIXrku3gX9BKF70mjya/yJWNqFBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ulf3TjLUV++MyIXc/IC4ToARNnwshvsXdPx1abq7MCFc9IZtp7lrQ5UMlPyR66FcFtIEdt4c+cCB4H9m+AsCfC3MeDphD7FAJ8WD+gkLLmfyu0F0b/UtX/R4kfV5jl6JWCSN9Opsmf1AQfqbl2WusGTJFcHTkv29LMxfSY8xDj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C1yzDE2t; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6f666c94285so39529127b3.3
        for <linux-pm@vger.kernel.org>; Mon, 17 Mar 2025 03:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742208690; x=1742813490; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3DL02opBJ2GOeQ6pVsKBzjcKKbv+jea7dqaSnTubtI4=;
        b=C1yzDE2tDhMxxE8RXBDFWu8xkiUX43JsGPLdcGDunE2jMGeJGJpmwR65hphBOhlOvR
         Jvbtvm7eVafYH7v1/khw8pdMRWAgFdbNJBrW3UrlUig27WHjOiTBM+3pSMrXOJpGY/6Q
         Ff5lJriYZAGSpFt71/praDE7ZLaCQUugyXQ4daLDcfd7j4r1MMbpyDYC+Gtww4u8PuEN
         Xx/ZLhd+b902zpK7CwtB/b4fKbw4/Zvl6o2C/Jn3ARxI8WQYzahLFz6Kq28nzlxqUkqD
         Qy5MXyUmCCvExzw7BcZV5QuhNTfF/ROV6OM+JEHfKf80xcMqCvDo2IYsAAZOXglcV+4l
         X8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742208690; x=1742813490;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3DL02opBJ2GOeQ6pVsKBzjcKKbv+jea7dqaSnTubtI4=;
        b=qn4SNoARjACRgTjoOywgfiIdlXCQAQH00w5rVrg+8B79qXn7cirp0sLKxOxWJqCxhb
         SyyU9UmRg3RANLiaQlQeW/TfOjpRnJfNW/K7bMhRIeR7ljWLeGFvENiYvy/YNQm9chTj
         EdmjXddZmO29Opq/RUIZPqFTL3/8Bfh49M8ddDmvT08fAmTE2kGlb9+48ooPgxn8u2j8
         8561VbST4Vjqd1UCMLaXUFsMxrngKw5MxJiEkM0QqCZVcpE7bh6yoydJAKn3KIcsxlXH
         lZaF0O518Qsc86932IQdlxGOoD3Oa8eroB4QH2u9VZv2B7L8ZImIheCzSevjNXPi/CiG
         mFpA==
X-Gm-Message-State: AOJu0YzkPdW5gCWdhnCjvErYG7dfocf9Q43o21HjOsCg8cim9kXYx1Lf
	9DQzLRW95snas1fDRv79mlW3UhCthT604uTzbOkg7Zk4q8MjpO/7xXc1lK1dPqQeU42Viik563c
	CwzjVl1/ThAR7bDhP4h8dK9dDQNto01QFpYTLKg==
X-Gm-Gg: ASbGncuHBrT/Ef9lrPTtiK6ILv4YTA8DxTZXD7DocdefhKduRBu0gC+D/pMxgB/ijdl
	WZitZzhyomH+3J5l/yRID5MhVhsYWfPVuCYPHH1N52GiXLwXG0C6/hC4T5077Cw6D7oCCRdSqBV
	G+Sanx5QgtUqh4NfPsrpNsWQT4fUA=
X-Google-Smtp-Source: AGHT+IG8URJqqSBqONhuu8sYybucoSHmc+ZFyad25qn1SExsn3bIptprwg9F2pyuFSIv1SCLh33c21bFXaSGx6o+e0U=
X-Received: by 2002:a05:690c:7003:b0:6ff:1f58:7ce2 with SMTP id
 00721157ae682-6ff45f43340mr166246127b3.12.1742208689959; Mon, 17 Mar 2025
 03:51:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314095851.443979-1-sudeep.holla@arm.com>
In-Reply-To: <20250314095851.443979-1-sudeep.holla@arm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 17 Mar 2025 11:50:54 +0100
X-Gm-Features: AQ5f1Joaio6_TwbptUke6Aww5lNg-_7Fjau5OFgPk2QOhZDZNiKgiWIAn887rF4
Message-ID: <CAPDyKFqhvJnth4ASfnfj5xTkM625m-rAidZ3zdy01CzkB7e1Ng@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: arm: scmi_pm_domain: Remove redundant state verification
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-pm@vger.kernel.org, arm-scmi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>, 
	Cristian Marussi <cristian.marussi@arm.com>, 
	Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Mar 2025 at 10:58, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> Currently, scmi_pd_power() explicitly verifies whether the requested
> power state was applied by calling state_get(). While this check could
> detect failures where the state was not properly updated, ensuring
> correctness is the responsibility of the SCMI firmware.
>
> Removing this redundant state_get() call eliminates an unnecessary
> round-trip to the firmware, improving efficiency. Any mismatches
> between the requested and actual states should be handled by the SCMI
> firmware, which must return a failure if state_set() is unsuccessful.
>
> Additionally, in some cases, checking the state after powering off a
> domain may be unreliable or unsafe, depending on the firmware
> implementation.
>
> This patch removes the redundant verification, simplifying the function
> without compromising correctness.
>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Cristian Marussi <cristian.marussi@arm.com>
> Reported-and-tested-by: Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/arm/scmi_pm_domain.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/pmdomain/arm/scmi_pm_domain.c b/drivers/pmdomain/arm/scmi_pm_domain.c
> index 86b531e15b85..2a213c218126 100644
> --- a/drivers/pmdomain/arm/scmi_pm_domain.c
> +++ b/drivers/pmdomain/arm/scmi_pm_domain.c
> @@ -24,8 +24,7 @@ struct scmi_pm_domain {
>
>  static int scmi_pd_power(struct generic_pm_domain *domain, bool power_on)
>  {
> -       int ret;
> -       u32 state, ret_state;
> +       u32 state;
>         struct scmi_pm_domain *pd = to_scmi_pd(domain);
>
>         if (power_on)
> @@ -33,13 +32,7 @@ static int scmi_pd_power(struct generic_pm_domain *domain, bool power_on)
>         else
>                 state = SCMI_POWER_STATE_GENERIC_OFF;
>
> -       ret = power_ops->state_set(pd->ph, pd->domain, state);
> -       if (!ret)
> -               ret = power_ops->state_get(pd->ph, pd->domain, &ret_state);
> -       if (!ret && state != ret_state)
> -               return -EIO;
> -
> -       return ret;
> +       return power_ops->state_set(pd->ph, pd->domain, state);
>  }
>
>  static int scmi_pd_power_on(struct generic_pm_domain *domain)
> --
> 2.34.1
>

