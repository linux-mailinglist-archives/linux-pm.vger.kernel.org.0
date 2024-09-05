Return-Path: <linux-pm+bounces-13687-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A23E696D72E
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 13:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E69A1F25324
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 11:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC905199956;
	Thu,  5 Sep 2024 11:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VuhV2LFS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234CF199947
	for <linux-pm@vger.kernel.org>; Thu,  5 Sep 2024 11:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725535939; cv=none; b=oNKWuQUHNbvBHsv4yetsfBjr70eFVqj92QanWExazL72aCoRweD/yjpIjn7zACrQiqAz5JRY9HX9iZ0g9XcvtyVlTet/dt58cR1ThXmOu8rwrOtqlExR/TPv/V/QxOfYPXWzyBeA7YRuLRv3Po84m2lQGt5cg7/zVg1l47dMgAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725535939; c=relaxed/simple;
	bh=3qZzaYmpiDZJPb0FBA+dUOf5gH2svOgHL1P3EL9vJ+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OMBz3sCPjeMKpb6W/Jv9YUhHjXrv82rxHtre8ZppCYSlVyDiQWXaY+Qh08HlJ03c4GF7nLPL+z/gr7Tga4Dp26SqeeIvB4Hc+ZhkUCB7PTF+PWr08Bzz4vk53oFv1rudiLCBTWToLrf2rVPGeP+KR9nE/Jn9EjpBWmQ4AdCc5kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VuhV2LFS; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e1d2cf4cbf1so204402276.1
        for <linux-pm@vger.kernel.org>; Thu, 05 Sep 2024 04:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725535937; x=1726140737; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BE62jvNjRymeBPRNCoV4pu9zk/FV0GIpysTD3uE/Nh8=;
        b=VuhV2LFSn4qb2p4fTMy4O+KD7aJuFkVMmL62Z0vG/mMW1Z8fiY3qXzMlqkvaQk/kxQ
         s+IO213RSndd46q4JlA2apfx9IkkEAyllKba12Kqs0SpX+1lDIFQMKi2ZUdMIVCpeOJW
         cK3YYFihUAHYAaFnICTHWM7VIZKIhq9Hyk1A5p6eE09GIgMOv/SOGpDaU4cIDY4rUngX
         x7FadMvcUyO84fNhNPbRtf/EC0avBvBueVCaoEDk2GW9RiK6f0HvHXAB4j7T3ewHPtSI
         /OL32VeeH42YjaNsvlqjBAKL7McM0+kEMu8qcJ9DWvFvZi/Ye0o9Xek6R7lbJ57nI2TC
         xjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725535937; x=1726140737;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BE62jvNjRymeBPRNCoV4pu9zk/FV0GIpysTD3uE/Nh8=;
        b=hlnbe4nKT/gWXrQdioUSF/Q7n0Y2E8Zeq7umjlc+Z+mTZ/8DlbrU9u63ZDC85LF1CT
         INlPFQ/oWbuJlirzqvkGMVe+SZWR3kYYFcCRgScp4uoD3M4ENZBPhfRYsdZ+PFnd+Gm2
         AXccKaZNBI8Bv8nq0wvFVpP5T6BhWvj4MfX3230fyvJRysE7V5bH7Ye4EXg48dwcqUR8
         pb0OuO5hi/YUeKqSk94btIDKdmOm6w5A6dfOipvMHF4IW/YCK5EsDOnOOqvKlOJGPzLV
         nyt5wIergiSzSBl/HfsrTIBHEqtLEX+6m9Xee3JwrjUZvTBVIWZ7DRXvfdD5QoQ1GUfS
         efEw==
X-Gm-Message-State: AOJu0YyPgREZhwRjDCenO1Spz6zRU9PLswFq6t+h0GWm5JlpnPRMK9aj
	Pp+KPAzxHUyYQxp4UJbqaD+H2CZYbyL2T55Jd68MY0w3LnIr/Q4XLkGLy2Ad7foCbw4BBpRU93p
	EV57Zg4aTUY9UgrronU0KQ2i16wFhhteG93cZZw==
X-Google-Smtp-Source: AGHT+IHygd3KTX3EiW5rVbf+Gfj+wNPvBrt4G9Mi/elE8/M1C1pE+bPBemzUuvOcTWQEiq8y22JwXAOEFht0eCV1T7o=
X-Received: by 2002:a05:6902:d47:b0:e1a:8e31:e44d with SMTP id
 3f1490d57ef6-e1a8e31e75cmr16230309276.14.1725535937095; Thu, 05 Sep 2024
 04:32:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819-lpm-v6-10-constraints-pmdomain-v2-0-461325a6008f@baylibre.com>
 <20240819-lpm-v6-10-constraints-pmdomain-v2-2-461325a6008f@baylibre.com>
In-Reply-To: <20240819-lpm-v6-10-constraints-pmdomain-v2-2-461325a6008f@baylibre.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 5 Sep 2024 13:31:41 +0200
Message-ID: <CAPDyKFpH9TQ3P75CXxHmgo+y8z-C_iYCzFzqR93w1Mt9jhFBBw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] pmdomain: ti_sci: add wakeup constraint management
To: Kevin Hilman <khilman@baylibre.com>
Cc: linux-pm@vger.kernel.org, Nishanth Menon <nm@ti.com>, Vibhore Vardhan <vibhore@ti.com>, 
	Dhruva Gole <d-gole@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
	Markus Schneider-Pargmann <msp@baylibre.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Aug 2024 at 02:00, Kevin Hilman <khilman@baylibre.com> wrote:
>
> During system-wide suspend, check all devices connected to PM domain
> to see if they are wakeup-enabled.  If so, set a TI SCI device
> constraint.
>
> Note: DM firmware clears all constraints on resume.
>
> Co-developed-by: Vibhore Vardhan <vibhore@ti.com>
> Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
>  drivers/pmdomain/ti/ti_sci_pm_domains.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> index 963272fa387b..8af907579152 100644
> --- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
> +++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> @@ -76,6 +76,23 @@ static int ti_sci_pd_set_lat_constraint(struct device *dev, s32 val)
>         return ret;
>  }
>
> +static inline bool ti_sci_pd_set_wkup_constraint(struct device *dev)
> +{

Similar comment as for patch1, should this be a static void intstead?

> +       struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
> +       struct ti_sci_pm_domain *pd = genpd_to_ti_sci_pd(genpd);
> +       const struct ti_sci_handle *ti_sci = pd->parent->ti_sci;
> +       int ret;
> +
> +       if (device_may_wakeup(dev)) {
> +               ret = ti_sci->ops.pm_ops.set_device_constraint(ti_sci, pd->idx,
> +                                                              TISCI_MSG_CONSTRAINT_SET);
> +               if (!ret)
> +                       dev_dbg(dev, "ti_sci_pd: ID:%d set device constraint.\n", pd->idx);
> +       }
> +
> +       return true;
> +}
> +
>  /*
>   * ti_sci_pd_power_off(): genpd power down hook
>   * @domain: pointer to the powerdomain to power off
> @@ -117,6 +134,8 @@ static int ti_sci_pd_suspend(struct device *dev)
>         if (ti_sci_pd_is_valid_constraint(val))
>                 ti_sci_pd_set_lat_constraint(dev, val);
>
> +       ti_sci_pd_set_wkup_constraint(dev);
> +
>         return 0;
>  }
>
>
> --
> 2.46.0
>

Kind regards
Uffe

