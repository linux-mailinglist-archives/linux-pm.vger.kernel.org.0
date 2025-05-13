Return-Path: <linux-pm+bounces-27072-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C391AAB4FA5
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 11:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D44171650CB
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 09:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1702144A3;
	Tue, 13 May 2025 09:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X8SnbIPY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1A3212FA2
	for <linux-pm@vger.kernel.org>; Tue, 13 May 2025 09:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747128197; cv=none; b=a9S4PjIkDPWKkAUZc5FUVzCSK7l7XnYntc3exHrEVLnkZ/KsqXqre1umA1FvrtBJJSw5/pYGfz0z+NlI1+HhDcMP1KPD87ta9LDgZxfnqVI0xpzyeZwdhhkPgqq0bBLQn2Swa7ER0PaqC1spvvRnamazVTIPD5MItPgwb/dIrTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747128197; c=relaxed/simple;
	bh=PUZdM1h8WI1vqC/o9GJnYO6sqlQvrPktbx07wyl5Imc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XpKwI0bfyDCt620Is1tmlRlIVjIDk866m+YC3A2skxgZaJpZ9kQ57C8pe+V7LTXSEglKYv4nRh4eNukXZ1Kr814ydZ+KdyW708dY+kLi9MSLZqVkwfvAr5t6x1g7FD6/hXEyWLPj+E8B7tFGNjKyPI5UityMMrQGDNZP/YU4CK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X8SnbIPY; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54e7967cf67so6524233e87.0
        for <linux-pm@vger.kernel.org>; Tue, 13 May 2025 02:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747128193; x=1747732993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUZdM1h8WI1vqC/o9GJnYO6sqlQvrPktbx07wyl5Imc=;
        b=X8SnbIPYMfVAzs5kZ2Hfs7BjnVNEnljduCrMqkyWSt1XZQK8XQinlzhXx0CI0smPFk
         HI+JRIG+4b/ktseLIMSa7UgpZ4ycRWlTk2OOjfSMiYp2nX9Pr2W+KfUeOTFI4cDYwS9x
         Qn0/jrdmRct7fglUKE6c4/2/ALpNOi+dHhwQbvJfjaoOx152ipOTyllOi1FrjdXYcOQn
         jipBemN/GHYO6xVNnNNfRKo6zLUA01Ppj16jpBa82YL/Y4QdBMtscjc5Wdb1FhD/VNUR
         AniHqDQaujOSNMHZNkc9q7eEnXko4LVEats/oP7UZBe5iTbFpTZu5r4RdpnDYu5Q0oI3
         bmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747128193; x=1747732993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PUZdM1h8WI1vqC/o9GJnYO6sqlQvrPktbx07wyl5Imc=;
        b=mvJwozpFOMmv8tqv8+Vhj3eLOr/Q0ip0lExcNAoIARqc3gRxxkgSwtiAjj2hZihu0d
         sM0J+m4q0Oxa0da5m92FggF0W0ryDsBt8uPzPLwFT34He7W4tTQC58oszaC5ToHdDdlH
         CUMl87bmzBME4pb8J87ff9k8xUxHsK421aMmCpPoBZuJ8WptLBqQyjx3XwqGRtR5mvKw
         5JRQA+fja4amHz9xrKrU15TLOlPsP1zfKPWDdubpns07w9WeSXgGPfl/Du1HybbOHJIM
         EoJva6g9AGdT4iEtLp+kTXr0NDbafMlSbxx0UBWunQ72ip0YO6OADXXyO82Hn3e657AU
         g+7A==
X-Forwarded-Encrypted: i=1; AJvYcCXyx9guDaHpXsHp3JMZOrYP1w2RRCdau0KbknRDMYF5WHP+e/yldi4bsWdjlUZLPzo8LIdXuisdwA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKX6IcRnDK5U51P7L5jF2zjConCJjlKpyI87FVdW9Yefn2Zopf
	nhxB+uMUBGq4tCFEbiexN7c3deWYgSPM5FGzm9LZ4uw8DX/icfgwMawgTsoAhhDzhRiI/zXcn3d
	rWykBUb4Ip6hySI8xrMh3X1Em2Bs0WuZ/kZN7eA==
X-Gm-Gg: ASbGncsXOtnmIRcGS960FkGnA00bIB11osiCl/5Wioe13h2WURWPu0M4boefSF961B1
	E2T+UvZOcAjVL/RCsn/AbmrL2VA3rEPE2apQ84iWvCS8zeLz1mxKB5T0fmdHoVZFKP35GKdgDnN
	cavmUrOe+FQmptpjD2Az+o7ng68TpIYOJG
X-Google-Smtp-Source: AGHT+IG3yJ2I/gSRbNR8Yc9mQ5D3H3jOM524XFmnhYp45I4Txi2GP3DWvoHzF8HaXmyZuGDfMmUhius5uFgg07Xw0xs=
X-Received: by 2002:a05:6512:660d:b0:54e:9c8d:bdc3 with SMTP id
 2adb3069b0e04-54fc67eba75mr4238045e87.49.1747128193339; Tue, 13 May 2025
 02:23:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5889368.DvuYhMxLoT@rjwysocki.net>
In-Reply-To: <5889368.DvuYhMxLoT@rjwysocki.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 13 May 2025 11:23:01 +0200
X-Gm-Features: AX0GCFuBGgsy8OIbyZ_iRPj1JK6HiLr8l-sZYvuduHVP_RhHrCBW63Oul_hd7iM
Message-ID: <CACRpkdY57K7_rhQiXKbOpTGneQRvpJ33E-fG8ejMHzcBaTQE9g@mail.gmail.com>
Subject: Re: [PATCH v1] pinctrl: amd: Fix hibernation support with
 CONFIG_SUSPEND unset
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mario Limonciello <superm1@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	linux-gpio@vger.kernel.org, Basavaraj Natikar <Basavaraj.Natikar@amd.com>, 
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 8:27=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> After recent changes, pinctrl-amd will not support hibernation when
> CONFIG_HIBERNATION is set and CONFIG_SUSPEND isn't because it will not
> register amd_gpio_pm_ops then.
>
> Address this by restoring dependencies on CONFIG_PM_SLEEP where
> necessary for hibernation support.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> Mario, this is on top of:
>
> https://patchwork.kernel.org/project/linux-acpi/patch/20250414203551.7793=
20-1-superm1@kernel.org/
>
> which is currently in my bleeding-edge branch only.

It seems the prerequisites are in your tree so take it there!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

