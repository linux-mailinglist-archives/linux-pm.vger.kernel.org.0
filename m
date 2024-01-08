Return-Path: <linux-pm+bounces-1927-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB552826F3E
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jan 2024 14:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A8642839A0
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jan 2024 13:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452D540C1B;
	Mon,  8 Jan 2024 13:06:45 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF8E45946
	for <linux-pm@vger.kernel.org>; Mon,  8 Jan 2024 13:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5958d3f2d8aso339040eaf.1
        for <linux-pm@vger.kernel.org>; Mon, 08 Jan 2024 05:06:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704719203; x=1705324003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z9ePyfvf7p6QsSJTohWy6AHSw588XqIbegiXU1AytT4=;
        b=aKmM5WjpeAftmEbw923kZn5l+DxWWla6aEFFHvHC0XQoJu2nT0e1fUFaJyrzRb4kJh
         VjgOJfLE6eVymE48tzBeg/Kd57O68O6FuQK5jE7+sRpTCwrI5GXz0uwNjnB0gsbyaWtF
         /ZAqY+dC+KExKqNhAy2jLo2BMBD2CJ2yNIU5gNwCCGRtjepawGWUVNpgXWM+NRzElIwR
         4XyZPL60VusMe78xA6nlcdowEmHNhFNPhUIT/BVMUhSeharSFwztyUNxxap4J4+ft6GV
         6ZKkaSshYSCIYemR2vPcsAMbG1JYxEsugjqM89iUnieGv5m6JXOILbOvn3dylsWW2xLm
         rIfg==
X-Gm-Message-State: AOJu0YwsDa/X8agP4T8jq/PAsvlIiVZKsFvWgeYechouYSygOUKvAZgq
	uTWlOqL5z7jkE6lD8SbIwpwucJmpbb5hE5tINv50jGJ3
X-Google-Smtp-Source: AGHT+IEIJjcCETTgz5jDPmcHqxsvJh7J/mgEcbr82VXGs9gHj4uEXgb5S25nII4OVOIPqDjPVzsBioFwNVUTI+g2e4M=
X-Received: by 2002:a05:6820:388:b0:598:6f59:3 with SMTP id
 r8-20020a056820038800b005986f590003mr386708ooj.0.1704719202749; Mon, 08 Jan
 2024 05:06:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108095513.qlrwjon6qwhealvk@vireshk-i7>
In-Reply-To: <20240108095513.qlrwjon6qwhealvk@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 8 Jan 2024 14:06:31 +0100
Message-ID: <CAJZ5v0jmC+AxP_8bF2CA+XrZNoCQ2_qgUkcVzY-b_z4Z7N-3mQ@mail.gmail.com>
Subject: Re: [GIT PULL] OPP updates for 6.8
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Viresh,

On Mon, Jan 8, 2024 at 10:55=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> Hi Rafael,
>
> The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa=
86:
>
>   Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/opp-u=
pdates-6.8
>
> for you to fetch changes up to dcfec12b67980cba139a6c3afba57ebd4936ebe8:
>
>   OPP: Rename 'rate_clk_single' (2024-01-05 15:55:41 +0530)
>
> ----------------------------------------------------------------
> OPP updates for 6.8
>
> - Fix _set_required_opps when opp is NULL (Bryan O'Donoghue).
> - ti: Use device_get_match_data() (Rob Herring).
> - Minor cleanups around OPP level and other parts and call
>   dev_pm_opp_set_opp() recursively for required OPPs (Viresh Kumar).
>
> ----------------------------------------------------------------
> Bryan O'Donoghue (1):
>       OPP: Fix _set_required_opps when opp is NULL
>
> Rob Herring (1):
>       opp: ti: Use device_get_match_data()
>
> Viresh Kumar (10):
>       OPP: Level zero is valid
>       OPP: Use _set_opp_level() for single genpd case
>       OPP: Call dev_pm_opp_set_opp() for required OPPs
>       OPP: Don't set OPP recursively for a parent genpd
>       OPP: Check for invalid OPP in dev_pm_opp_find_level_ceil()
>       OPP: The level field is always of unsigned int type
>       OPP: Move dev_pm_opp_icc_bw to internal opp.h
>       OPP: Relocate dev_pm_opp_sync_regulators()
>       OPP: Pass rounded rate to _set_opp()
>       OPP: Rename 'rate_clk_single'
>
>  drivers/opp/core.c          | 294 ++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------=
--------------------------------------------------------------
>  drivers/opp/of.c            |  57 ++++++++++++++++++++++++++++------
>  drivers/opp/opp.h           |  24 ++++++++++-----
>  drivers/opp/ti-opp-supply.c |  13 ++------
>  include/linux/pm_opp.h      |  28 +++++++----------
>  5 files changed, 244 insertions(+), 172 deletions(-)
>
> --

Pulled and added to the pm branch in linux-pm.git, thanks!

