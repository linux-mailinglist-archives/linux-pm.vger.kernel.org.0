Return-Path: <linux-pm+bounces-7866-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F948C64BF
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2024 12:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B8E21C224ED
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2024 10:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462775CDD0;
	Wed, 15 May 2024 10:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUUyRmEm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1989D59154;
	Wed, 15 May 2024 10:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715767488; cv=none; b=UntFw3GBPYplOBuDA75HSG+3vU0GesruCF0QI7/IYEnKYyE5mYv4lexRIrZ8LcYnRJV3o25LdhcxZsrbVMsBlMd5a062R/tddmqAZ6YA6u7h40wYh4neqxE1Y0J3R4AT/JelS9GEwfVQp4FG2Zy5+RVcy7G28Ap4EwFz8m4FLjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715767488; c=relaxed/simple;
	bh=RYe526lR6G+ZpwtoxXEihuTAaL1DrZXqa1zXyyP3F2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M3dtufq8IkfDp63NfIoZg8wNFn2YiVob/e3Wefgs7Z3GIIZfES4vZ1TFIgjqss2lKDdugDjwNCbKqIZOuJFv/DI8VV44gkwRvRoWwxToEbaqLImQDCe7PPOgUo0cugu+yGRjkjUlFU4bWkEQ/m1Hb5Lj2UjeV8y4PBDWZ22z7qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUUyRmEm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0900C32786;
	Wed, 15 May 2024 10:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715767487;
	bh=RYe526lR6G+ZpwtoxXEihuTAaL1DrZXqa1zXyyP3F2Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EUUyRmEm0rNVZyiTV2Up3fDqRhGHDCVPLBsQiN1fGGtTnjVQ8ZtZHo8oA+vo8ceFg
	 9aAmQBfi+BDVWTEI/G7xGNQeUVSJiH0Bv4yTuWttSroxqwmRoafEpUc0lEMQQKVt96
	 +BQlJZJZIwjC0kxxJulW4DF52HOM+Uoq94fHeM8liVZi7cyIfjYIJP9jjmp3yMiK6+
	 wda7vQk1ZvlXH2izadtkYbTEvhfn73ujPafKH1so0BhpT6FxI9kQH8nIWCVNc2+yHC
	 9AU83C/wFkw440amCmOyx+na3i/z+JIoVpb+j8VqRH6ntfu9hRkhd66ksCciHPVmQo
	 rrjFtUXVYNJ+w==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5ac4470de3bso1034768eaf.0;
        Wed, 15 May 2024 03:04:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXtlJ1D6/zX4ZXHDysxyaIfdrYGEaSgtery1htNlmRTGjB/xyUQ3UbfmsXajjHqKgGHBRw06N++nitE3n8uacraoyzBoeqvDbXKtkvFWPnzOr32jDpHybeiUqT9rtEbzowIv6pAXs4=
X-Gm-Message-State: AOJu0Yz7fHS4BdX43qjNBvYmPveP+RfzzMUUE52kapibkh9w8JE+bAae
	mKK9B1IJT7Z7dj03Wd21z4n4FU/ZYrU/IyaEOaHPxkg/lJ9e8SQ67TnelKwi4taZ7cHaUHP5UKn
	dOTNtxZ13uhWxvTuVJKGSokoplos=
X-Google-Smtp-Source: AGHT+IFLmIoa1kjthdFne9cPU+Cgy3M/9F26C1/7JjSFpI0XJYbRgVCPRmEW/RscRhAC6qwm3Tq23thmhy6BpyAdVME=
X-Received: by 2002:a05:6870:5246:b0:23c:350c:f157 with SMTP id
 586e51a60fabf-24172fc1a06mr20779283fac.4.1715767486840; Wed, 15 May 2024
 03:04:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1a27254d-110b-4c01-89a0-e5e7b7c986ca@linaro.org>
In-Reply-To: <1a27254d-110b-4c01-89a0-e5e7b7c986ca@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 15 May 2024 12:04:35 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i8n2AwSXLGhLJjRiu-=tXjdCN4dEiJm8-uC2gRCHW0RQ@mail.gmail.com>
Message-ID: <CAJZ5v0i8n2AwSXLGhLJjRiu-=tXjdCN4dEiJm8-uC2gRCHW0RQ@mail.gmail.com>
Subject: Re: [GIT PULL] thermal drivers fixes for v6.10-rc1
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux PM mailing list <linux-pm@vger.kernel.org>, Julien Panis <jpanis@baylibre.com>, 
	Lukasz Luba <Lukasz.Luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Tue, May 14, 2024 at 11:38=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
> The following changes since commit 734b5def91b594d3aa1147d60c45eded139ce2=
eb:
>
>    thermal/drivers/loongson2: Add Loongson-2K2000 support (2024-04-23
> 12:40:30 +0200)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
> tags/thermal-v6.10-rc1-2
>
> for you to fetch changes up to b66c079aabdff3954e93fdd7f52bd8f9ad6482c7:
>
>    thermal/drivers/mediatek/lvts_thermal: Fix wrong lvts_ctrl index
> (2024-05-06 10:33:26 +0200)
>
> ----------------------------------------------------------------
> - Check for a NULL pointer before using it in the probe routine of the
>    Mediatek LVTS driver (Julien Panis)
>
> - Remove the num_lvts_sensor and cal_offset fields of the
>    lvts_ctrl_data as they are not used. These are not functional fixes
>    but slight memory usage fix of the Mediatek LVTS driver (Julien
>    Panis)
>
> - Fix wrong lvts_ctrl index leading to a NULL pointer dereference in
>    the Mediatek LVTS driver (Julien Panis)
>
> ----------------------------------------------------------------
> Julien Panis (3):
>        thermal/drivers/mediatek/lvts_thermal: Check NULL ptr on lvts_data
>        thermal/drivers/mediatek/lvts_thermal: Remove unused members from
> struct lvts_ctrl_data
>        thermal/drivers/mediatek/lvts_thermal: Fix wrong lvts_ctrl index
>
>   drivers/thermal/mediatek/lvts_thermal.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
>
> --

Pulled and added to the thermal branch in linux-pm.git.

Thanks!

