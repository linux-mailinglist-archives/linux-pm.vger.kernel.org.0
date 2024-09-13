Return-Path: <linux-pm+bounces-14147-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E0E977F2D
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 14:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDFA8288E47
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 12:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C6A1DA2FF;
	Fri, 13 Sep 2024 12:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rA+Mhk4A"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A512C1DA304
	for <linux-pm@vger.kernel.org>; Fri, 13 Sep 2024 12:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726228964; cv=none; b=WGrAMppRBKMhMbzx09WxpoQLN3EG3jSO8lbP+vL7IzKgCXijvjZTTOnu17Pz4sNqfAlxX6X4fZhz1h68DSiham9zyH6zkYOGaSqADXax6Nq0oao7t+G9rzd5gWVe1dUMwGnqXkT0KCbHXYDGt3dUg/i0U6vy5jiMNSZCDoGysWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726228964; c=relaxed/simple;
	bh=6PYXJ738FyEPSY1pHIaLaAl1aXVKY84HLyB+bqbrerQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nuVFChJrSHBHmLs+0GXNLF9LX/qFq1I9cJt/nEwFT3k8exwqqBqr0G4OKVHwcR9JloWzhffV65A/8scNVhueZqd9udbXb0V6fIsfleawW9DEn3IUXQuCAKN3QqbzjEJEdYJHe9RBJEHJPvnsmXrnn5y26g82dspPjLo/5I3cIMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rA+Mhk4A; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6d6891012d5so16844927b3.2
        for <linux-pm@vger.kernel.org>; Fri, 13 Sep 2024 05:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726228962; x=1726833762; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZC5y+gbKcz2lOvMDPSoSOYxaB5aaC+GKTx2bSEhxRuM=;
        b=rA+Mhk4A2PBdoIDqwvQ4dq/KFPQldiLaL0pwmPkWDii/tQ8tuARiy/OoEgRwdf0ksg
         o90Nd+c9Kupsiz4TswI49pjs0wjFKq4ChvSLkyku/ZPWIkyG/GNolbUl4tOzVk8kJtoG
         UHFulYgyl2rDr0IkJGAZZf0J59xmb7Tv1G1JgxzJMFGaIkQjNJvekSJ6sbVxTH7GvYGp
         t0TKk5SmM6nGV07XAbaKRvazzhEleeSM32rAy5wKRtE2ZVjOJKSbHrFA7j+GHxWGLTaM
         NDjRBlI89/CPtXR7VoT5HSNkHNt1vlIQOMZgX2TNKQMnqmucRWDMJYlfhMrBSYdizHT/
         bI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726228962; x=1726833762;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZC5y+gbKcz2lOvMDPSoSOYxaB5aaC+GKTx2bSEhxRuM=;
        b=HBVaWZVwnbHzFNmS990f4wAKeDsriXWmKcrVn4J3qRk2hKgMXBgNhH/8Na4Kk27cD3
         DElwRMUrX2xWEn3jCvERZzbhQ1FPi/j7XkyKdTqlZZ21uuYtjrX1uooXNF35gfjGRrYV
         EwCJG6/Rph4LizmWIb7RVJjXHTlRPT34MU6NaGkmKeEmdNUoO50y9B4gjWDEWc00iRBw
         FWqL4XhV0XZ8BkLJv8+0KdPoVhYaulE6+PjWjXlCUnsG9CiXPB50BvIEaj5EKffVxbyd
         xQX/vB1GGCP/KIYjMarWE4OBsCW6RXj15A/Aq7RPTULL0YfWMSaTkis2yvz1f2mLwydG
         BsMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiAwwNHaru5kqyfh9m9NKMRta3vHGsTbMvA9ewdWuXgr5hFqFahyALlBGLCsip8SgI7EqQ6D4MsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbJNqsCki4yzyp716pAS/ZwLY3CKEvN8LnpA/kCL7CHolwoKc9
	CaffoJAtug8B92HqbRKAfmgfzBXYWCMB9XyKmceCWKA73EeiNi85DDSejzk+b5H+hGw5YnmRUNC
	qpORK9sSSvQzK3nCU0YAr2TJUVzS0ZV0h4u5QPA==
X-Google-Smtp-Source: AGHT+IH/TIqGo3l3sKrn6rpgbmS38MaCtup4PWkQrq9QHy/ehShUvJOygofHes+RONDG5YkXaBXtAw9fG7336kRilnA=
X-Received: by 2002:a05:690c:7084:b0:6b2:7ff8:ca1 with SMTP id
 00721157ae682-6dbb6b40200mr64523607b3.22.1726228961582; Fri, 13 Sep 2024
 05:02:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1725459707.git.geert+renesas@glider.be>
In-Reply-To: <cover.1725459707.git.geert+renesas@glider.be>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 13 Sep 2024 14:02:05 +0200
Message-ID: <CAPDyKFqFwA4AEbTVvUXbjyUG+zQutGm-xN3uCxDta+Z-8cmh4Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] pmdomain: core: Debug summary improvements
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Osipenko <digetx@gmail.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Jagadeesh Kona <quic_jkona@quicinc.com>, 
	Taniya Das <quic_tdas@quicinc.com>, Abel Vesa <abel.vesa@linaro.org>, linux-pm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Sept 2024 at 16:30, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
>         Hi Ulf,
>
> This patch series improves the table formatting in the pm_genpd_summary
> file in debugfs.
>
> The first two patches are fixes and cleanups for commits in upstream.
> On systems where performance_state is always zero, the first three
> patches have no visible impact.
>
> Thanks for your comments!
>
> Geert Uytterhoeven (4):
>   pmdomain: core: Harden inter-column space in debug summary
>   pmdomain: core: Fix "managed by" alignment in debug summary
>   pmdomain: core: Move mode_status_str()
>   pmdomain: core: Reduce debug summary table width
>
>  drivers/pmdomain/core.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>

Applied for next, thanks!

Kind regards
Uffe

