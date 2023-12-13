Return-Path: <linux-pm+bounces-1051-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F2B810E7F
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 11:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F92028166B
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 10:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0212209F;
	Wed, 13 Dec 2023 10:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bg39wl1a"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037A6AF
	for <linux-pm@vger.kernel.org>; Wed, 13 Dec 2023 02:34:15 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5cd81e76164so66042077b3.1
        for <linux-pm@vger.kernel.org>; Wed, 13 Dec 2023 02:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702463654; x=1703068454; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9FZnNzpRdub68izs5qvM26thxhHVaJuKTgF6tB6XgDg=;
        b=bg39wl1aPOasX3spzmIr+nx6l89vhqaryFyKrQw18UtjOSH8wl0ruVUqtDcmA1iZ9Z
         G3OChZvO0nlLm8J1xxZu+EAnnNGaVE9WF67wLTNHEChz39tYzY3lO7ne8tK89dk/o+O6
         SQy0flDUcEwkPBVA79oWf95jbQrSFEXZLBYG9iTbOuv+rK9Yq5EFEfMqJeQKMdc4ShBv
         cD8TdAvfhymSKyyfu7coGCpnPgx1GZzUEFO9YKa7o1q/3WyvAwFV8FJeHyoEhpnnOwp3
         fKswXI5sWTEhZ+XW70Kda9npx7vEaLjPj9iOmt+GfvQdOrhZJ2OQWqIcDxy80Xpm4z2z
         ZagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702463654; x=1703068454;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9FZnNzpRdub68izs5qvM26thxhHVaJuKTgF6tB6XgDg=;
        b=YP7LX0fnBR1zIhAgfra8owFxs4xK59rSNCEX3TtxnG9jN5W8xtJf+lWv9sa20imNjf
         T+OfMAQHz/rI5uveNdLqRCQ4sXnQvhXuaUbYxZDIt6z9NTrT1Ph5NqRaq9QpYpA/pEN8
         DX8x4upAW1dzBIWHAyQBqRMzO8jFkBpJ0rFmYXOdjO41l+d4R1tyOO7uIrh+Ok27xVC3
         qRFujIkIa6+V5w/hpdj9f4toq8QeEv8zE3AnT+LnL9Fhg1so/SXEiyyIEBn/V7Gk7VB8
         1Kx/AzNvvu0bUizXZGOic0c8pEeRNcIhxDXM6u2+qgDgwFWnsQMRA0w2lT6iUpdNgazQ
         LYxA==
X-Gm-Message-State: AOJu0YwqrYz3ngQphFCCeeR5FcBrBnqOwac4DPUJDIRetRFWS2+Y5mwo
	z3jF2NVo84+TKnNtLHfDZgyGcFs6aZgb77Ez1PyTcw==
X-Google-Smtp-Source: AGHT+IE4U9FmwvNewrvjILhFp2HgfiDj9jTykDdH41QxIuQSGD+dELOKoQEHH2rLaM7jTYmF3DiY8atm1BmmQeHHLmc=
X-Received: by 2002:a0d:e981:0:b0:5d7:1940:dd92 with SMTP id
 s123-20020a0de981000000b005d71940dd92mr5986727ywe.104.1702463654048; Wed, 13
 Dec 2023 02:34:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205225856.32739-1-rdunlap@infradead.org>
In-Reply-To: <20231205225856.32739-1-rdunlap@infradead.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 13 Dec 2023 11:33:37 +0100
Message-ID: <CAPDyKFrxhcTREpC3pozgvbi_7Q8BxXzEdYYkLFF5zv=viFVg7g@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: fix domain_governor kernel-doc warnings
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Dec 2023 at 23:59, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Fix kernel-doc warnings found when using "W=1".
>
> domain_governor.c:54: warning: No description found for return value of 'default_suspend_ok'
> domain_governor.c:266: warning: No description found for return value of '_default_power_down_ok'
> domain_governor.c:412: warning: cannot understand function prototype: 'struct dev_power_governor pm_domain_always_on_gov = '
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-pm@vger.kernel.org

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/base/power/domain_governor.c |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff -- a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
> --- a/drivers/base/power/domain_governor.c
> +++ b/drivers/base/power/domain_governor.c
> @@ -49,6 +49,8 @@ static int dev_update_qos_constraint(str
>  /**
>   * default_suspend_ok - Default PM domain governor routine to suspend devices.
>   * @dev: Device to check.
> + *
> + * Returns: true if OK to suspend, false if not OK to suspend
>   */
>  static bool default_suspend_ok(struct device *dev)
>  {
> @@ -261,6 +263,8 @@ static bool __default_power_down_ok(stru
>   * @now: current ktime.
>   *
>   * This routine must be executed under the PM domain's lock.
> + *
> + * Returns: true if OK to power down, false if not OK to power down
>   */
>  static bool _default_power_down_ok(struct dev_pm_domain *pd, ktime_t now)
>  {
> @@ -406,8 +410,8 @@ struct dev_power_governor simple_qos_gov
>         .power_down_ok = default_power_down_ok,
>  };
>
> -/**
> - * pm_genpd_gov_always_on - A governor implementing an always-on policy
> +/*
> + * pm_domain_always_on_gov - A governor implementing an always-on policy
>   */
>  struct dev_power_governor pm_domain_always_on_gov = {
>         .suspend_ok = default_suspend_ok,

