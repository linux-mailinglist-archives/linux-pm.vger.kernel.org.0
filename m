Return-Path: <linux-pm+bounces-30579-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19360B00276
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 14:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65A7D1C26844
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 12:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A49D2641E3;
	Thu, 10 Jul 2025 12:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmpQJ+VQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A7125DB0B;
	Thu, 10 Jul 2025 12:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752151894; cv=none; b=hkkULqUqeM9dGvcn7DZDWRKc9+oganC+gDcHjl0n1K8ChtpfNrZgp4Hpycc29PQ2tmLacu0XY50e8iprsFZni0ZViCo15TXdvOHFzWmokNCC5qiUDDiesPgbfOKQJ0Vd0gRt3u1chPRnh+fTsk6w2xOAZtTurqFHSw1P/+eHL6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752151894; c=relaxed/simple;
	bh=38JoIBohSs7Sq2sPbmWWZIheJpPwxPjwp0vyk3caMtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cLpjkf/MfbLehCnMfIuTS4svR/HwF8YrptViq8e1qqTW4R8aaM6Cv8i3x80uP99bJW6ocn4PcR14gtJYB3cWyH6ZTRcgfosZg79bcpY9h9hnNrw/5ymf94X9JgHWhWFW41o2ecdyO55N2e3HkOmMvAcFtYdaDf2DaQ5ulxTmHMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmpQJ+VQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88135C4CEED;
	Thu, 10 Jul 2025 12:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752151893;
	bh=38JoIBohSs7Sq2sPbmWWZIheJpPwxPjwp0vyk3caMtE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kmpQJ+VQsjUwxsZB3uOeyVmmIVnJ9sdQvp5K6Ey7bQS0Gzmva70L61RvjnbaABFz1
	 zg+e+2X2LnwavyTXHbhlOfNp3voMUUOvBDH/zg4iZhKWQO8MHEZDCRXGtIZbgEsEOH
	 kAkl3W4k74+XWrC5kb1WiVoM/vvL615XvbLSPhuRf0V9KGUKgdcztf52hPMcypnP8I
	 qSFRv17T83G58b1QfqjrwZSVNzcLIT91kv4rQPwHIKZ4fSNk3aVLrc91g/NAryp2at
	 LgRtwYj99seLRDfuX8G7WIk8/WQdVYJ9b3YTkWdPCcNdqQ0cBZuYQBQmSnnw4LaIy1
	 4vE8IZbZfg6EA==
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-73caf1152bdso403749a34.3;
        Thu, 10 Jul 2025 05:51:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUIYCf7SLgfjXJEefruPpH/cRcWAlf/2diDZeor7TMPe6EkQOH88msV14rul3qxcoQAUjAwwvIggjBkNt8=@vger.kernel.org, AJvYcCUJP2kgv3hr8ZGct7nXKeaRBL0tsySK5TLJ6bDfYgBp6W6sv2zZihiHoLVvSBJWJQjgHSBqOGTlakc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygf6tON7+NE6Z8ayemoGqx8ujjcDakJguH7XDzL1iBlTu++NrK
	QOhI/yyUPj1Qkz+FVI33WBo0ntEI3pEbImjd7mftHrLZKm8FOqF8KaH9oWqM7S3ug/SJIv/WRrS
	a6okPxICNYfs5D0sx6C5dLnFWFV1vtTk=
X-Google-Smtp-Source: AGHT+IEmDM+v6DXiodktofoUeqFFRtH/zVCOaNczQ8oxD6c3Wp40OHPhtQeaQ3NhCyWhOZZMO6bXHx/VZaSvtF2fAaw=
X-Received: by 2002:a05:6830:8313:b0:72b:9af7:d766 with SMTP id
 46e09a7af769-73ce60a8a7cmr3116941a34.6.1752151892868; Thu, 10 Jul 2025
 05:51:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709104145.2348017-1-zhenglifeng1@huawei.com>
In-Reply-To: <20250709104145.2348017-1-zhenglifeng1@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 10 Jul 2025 14:51:21 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gS_65p9vhZYfSQNya22i3pjg1rkbBXgSYCVW5t5X5a1w@mail.gmail.com>
X-Gm-Features: Ac12FXw27TubSgPJyFGizte78njcE2qDkdE-9AhccuoOrTcg92sHjWpbAiO1Vno
Message-ID: <CAJZ5v0gS_65p9vhZYfSQNya22i3pjg1rkbBXgSYCVW5t5X5a1w@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] cpufreq: Some optimizations for cpufreq.c
To: Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, ionela.voinescu@arm.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, lihuisong@huawei.com, 
	yubowen8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 12:42=E2=80=AFPM Lifeng Zheng <zhenglifeng1@huawei.c=
om> wrote:
>
> This patch series makes some minor optimizations for cpufreq.c to make
> codes cleaner.
>
> Changelog:
>
> v2:
>
>  - drop patch 3 and 4 as they have been applied
>  - drop patch 6
>  - move invariance initialization instead of add a
>    static_branch_disable_cpuslocked() in error path
>  - add a Fixes tag in patch 2
>
> ---
> Discussions of previous versions:
> v1: https://lore.kernel.org/all/20250623133402.3120230-1-zhenglifeng1@hua=
wei.com/
>
> Lifeng Zheng (4):
>   cpufreq: Move cpufreq-based invariance initialization to where all
>     other initializations have been successfully done in
>     cpufreq_register_driver()
>   cpufreq: Init policy->rwsem before it may be possibly used
>   cpufreq: Move the check of cpufreq_driver->get into
>     cpufreq_verify_current_freq()
>   cpufreq: Exit governor when failed to start old governor
>
>  drivers/cpufreq/cpufreq.c | 40 ++++++++++++++++++++-------------------
>  1 file changed, 21 insertions(+), 19 deletions(-)
>
> --

All applied as 6.17 material, thanks!

