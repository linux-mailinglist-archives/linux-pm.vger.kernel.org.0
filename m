Return-Path: <linux-pm+bounces-4831-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7180387843F
	for <lists+linux-pm@lfdr.de>; Mon, 11 Mar 2024 16:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1073BB209E8
	for <lists+linux-pm@lfdr.de>; Mon, 11 Mar 2024 15:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C17944C6E;
	Mon, 11 Mar 2024 15:55:20 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9474207B
	for <linux-pm@vger.kernel.org>; Mon, 11 Mar 2024 15:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710172520; cv=none; b=L7+h40Abp/Yg8Muq/nCXD0ezvUbi4pPWh+kYL6laUOHgzJWuy6MmLcRFlpHZ5Ice4BnwnCvNoXXHRuGtTSksot8Z5hjUnNz6eZQ6fO2yXo37FmdCbsq+HzaYPpmXOeLIJVinAt0KcWG1Had+Oe5Wtq4DLZpyHpyhA4K5mS5Fbe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710172520; c=relaxed/simple;
	bh=h6zHgg7mf5mFoO2ErF0lAl1jKyzkgcEMO4Gs7OiB7t4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=khQMx2+TEJrDsBqN7St5O/NCjk1NHcs6wXuz4xoOaCgws/CN9ITOKZYGfxrIWZ6xJ0lcQOfsP5qMpqCZ6rPSg3UzmvOXgQ4aXfv/2KxgoO9PJBlttsyOpmdmwGL0OEh4y/cdn6Ez4D0lMJHDtRkjYPdUfUz4HZS4CQb8HtqqKus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-221a1722824so195117fac.1
        for <linux-pm@vger.kernel.org>; Mon, 11 Mar 2024 08:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710172518; x=1710777318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uouTbraU/drItc126e8JrpLkMLkqJnX2TR3WsGb9FX4=;
        b=pY1PDBA6VyOaj5OcajkTgrCaemI3F7PhIEiRqEStX8KvUI6bqgAwiz02/zGsEa1AOG
         DD5Aolix0ru3j5B5MZgqgTKF+K/2vVEjwMNhZeQrAaux/LEdSzxI2LsV8PMizct7XsyO
         i0lKCu27kO++tiIogpQt0ulzYR4MRetRULLxhIYsq5F+rHPu5m/S0zktIDjJzAaqWXPD
         T6z3LGxdVbfMOVZMKw3dKpz+wxdvnNji5YZYgBHcFJS35pAQGZqCmORzrgfs7cUZYo/x
         FcHaFYwmpgPNPgLem7JPZEizH/dXDdgN+pzLWBDLjMv3KsPzJFcrEG5RVlNSQkgY2ivp
         T/EQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCLhn9QE3KIvbFCqVtUgu+ZYLosQ6Ht0RWjAym7gwlZxd8fW3zP8hi5nvqFSVophvexpfpgbIvBCrRMjI/ku8G9w+FmSWFD2o=
X-Gm-Message-State: AOJu0Yzlwh5ENjWpRgNcYDEdh0L+5J4+IsM/1puuumvI7GbXaLq18SmB
	Lf6EKi9qpW9gGLm6Ts6BpsoES5EidL+JpqNXrelSIEd0z5dzlXQi37orwbRTqbxgRHyW3Uh1Wy2
	NMRvOhHVLW9pgEt32LFs/v2tyMg13C+JYjVo=
X-Google-Smtp-Source: AGHT+IHtuJwx0APXrGRaW8CXGvxXyqn1JQmV98NnB6djpvywxuPB5xQeV3fEWdL7Eas7VKJJj3jUlzKgoaQ3NNukCTM=
X-Received: by 2002:a05:6871:58e:b0:221:4a4e:7943 with SMTP id
 u14-20020a056871058e00b002214a4e7943mr7172812oan.2.1710172517996; Mon, 11 Mar
 2024 08:55:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311052525.x232vfpvqlmm6x2e@vireshk-i7>
In-Reply-To: <20240311052525.x232vfpvqlmm6x2e@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 11 Mar 2024 16:55:07 +0100
Message-ID: <CAJZ5v0jp7JCk0g+w+r9+y4TrcW5Qt1Ukeg57uYYdoHCgeSubhw@mail.gmail.com>
Subject: Re: [GIT PULL] OPP updates for 6.9
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Viresh,

On Mon, Mar 11, 2024 at 6:25=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> Hi Rafael,
>
> The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd3=
3d:
>
>   Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/opp-u=
pdates-6.9
>
> for you to fetch changes up to 13c8cf339e1a7a3d3e48fdebbb882b3a5a90f708:
>
>   dt-bindings: opp: drop maxItems from inner items (2024-03-11 10:39:24 +=
0530)
>
> ----------------------------------------------------------------
> OPP updates for 6.9
>
> - Fix couple of warnings related to W=3D1 builds. (Viresh Kumar).
> - Move Move dev_pm_opp_{init|free}_cpufreq_table() to pm_opp.h (Viresh Ku=
mar).
> - Extend dev_pm_opp_data with turbo support (Sibi Sankar).
> - dt-bindings: drop maxItems from inner items (David Heidelberg).
>
> ----------------------------------------------------------------
> David Heidelberg (1):
>       dt-bindings: opp: drop maxItems from inner items
>
> Sibi Sankar (1):
>       OPP: Extend dev_pm_opp_data with turbo support
>
> Viresh Kumar (3):
>       cpufreq: Move dev_pm_opp_{init|free}_cpufreq_table() to pm_opp.h
>       OPP: debugfs: Fix warning with W=3D1 builds
>       OPP: debugfs: Fix warning around icc_get_name()
>
>  Documentation/devicetree/bindings/opp/opp-v2-base.yaml |  2 --
>  drivers/opp/core.c                                     |  1 +
>  drivers/opp/debugfs.c                                  | 14 ++++++++----=
--
>  include/linux/cpufreq.h                                | 20 ------------=
--------
>  include/linux/pm_opp.h                                 | 18 ++++++++++++=
++++++
>  5 files changed, 27 insertions(+), 28 deletions(-)
>
>
> --

Pulled and added to the pm branch in linux-pm.git, thanks!

