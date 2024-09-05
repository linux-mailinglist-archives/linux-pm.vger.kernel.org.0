Return-Path: <linux-pm+bounces-13683-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE56296D6EF
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 13:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A0461F23266
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 11:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24056199397;
	Thu,  5 Sep 2024 11:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHYJk8Td"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ADD199392
	for <linux-pm@vger.kernel.org>; Thu,  5 Sep 2024 11:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725535098; cv=none; b=LojtbsZnJYaMEpS0QoTfWD6+FY+ULKbleHXuTlRIcFxr0SzN7YgRntjxGCChj62kOMrySpgpM5PeWQHOTzdsn/YmYHONS6l3a3V22qrpHS2CAYBcsNiIu55Hof+HXCDx+fmdsQO8fN6q3syqkqneVqKN5+RF6Mg1DcZaqBcQ0T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725535098; c=relaxed/simple;
	bh=4ZmhARIDPTOgzCoaptBw1hMhUMyzPxKuVNG7puNp4t4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQM5QeZbFS0Qy0MQ0GprXfEmzP+1ZRVAGNZpjXr9XSM7iMJmerv0lejyMcljDPxr0aRQQceFgLJ2eVhPkYOlKw7MbFiuM2HKvARgCgLGfsStM2KiCa8CPLxJ0xchiOlzUToYIvrQQYnOO+JmZ9myjYU1+3NVF6ZWhNo8a+mj2uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHYJk8Td; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763ADC4CEC3
	for <linux-pm@vger.kernel.org>; Thu,  5 Sep 2024 11:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725535097;
	bh=4ZmhARIDPTOgzCoaptBw1hMhUMyzPxKuVNG7puNp4t4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GHYJk8TdjA7ZpO2OQZtVUfnIO8oRPP2p3an+oZ9o7EuCKgV2ReBZdbVIRH1ElNmDa
	 ZywAcUW3bs5KI0MYNWNiffvlhP1T3O3TMdqWjA/ZXDOP81i6wKu44GhGrv8cS+f/e7
	 SwgvZbaYY+lX0QVrgVhAPLx54r8Yp8mwlnT3k/QcCiPKt6/3ypZt7hZ82BMaeZn13F
	 WoqBJh+WUuyc2sS9lqdTJp+TdcIkjEvPkw04VlMd5Nxbw1BVElE4nuc2+/4mJOOTxJ
	 TlwfUFUYYf+h88lVNP6+3SvKlRR2olNMLSDr9/Z4wr53kicmqdsuHxYzJYAXyPyrVo
	 zQnMVzd20yJ+w==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-277f0540c3aso416577fac.3
        for <linux-pm@vger.kernel.org>; Thu, 05 Sep 2024 04:18:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVJF6ekG2qxKWMTTFa5bvQHnwsxxyUUh7/rj68zGgWajEM5Vi/9HLyuWKfer4IBR6DnRWMQBg3dwA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv+SeUnA31THk2gMaMxCYR3fTRTTKquE2wk7hdhtKM0/6h2Sad
	2j5rWj6OTO3KeCambkfh3VwBJT6eFPY7J66lMjSjIG7aoUO/hgfo7lZb2TfLM8zI5NGdQq08dyX
	sQMrmugKRF7RkRZc1zXX32Yz4E2E=
X-Google-Smtp-Source: AGHT+IHzRiqt/KenoHm6KPImqF8AZFbSEVLMooRXZh6jXZHMlZdOHU1UWoXnBFa7y4oVZ7IY4UiVEhEdlhWLsyT1928=
X-Received: by 2002:a05:6870:7182:b0:260:f5ab:62ff with SMTP id
 586e51a60fabf-277cce567b3mr20868573fac.44.1725535096813; Thu, 05 Sep 2024
 04:18:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0297acf4-aab6-4561-9d8f-5c9082fe4869@amd.com>
In-Reply-To: <0297acf4-aab6-4561-9d8f-5c9082fe4869@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 5 Sep 2024 13:18:05 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i+KSgM26qOZ1d-jF+vr7cixuoiuFwyS4S3kOtQFgFfQg@mail.gmail.com>
Message-ID: <CAJZ5v0i+KSgM26qOZ1d-jF+vr7cixuoiuFwyS4S3kOtQFgFfQg@mail.gmail.com>
Subject: Re: amd-pstate development for 6.12
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 10:11=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> The following changes since commit 431c1646e1f86b949fa3685efc50b660a364c2=
b6:
>
>    Linux 6.11-rc6 (2024-09-01 19:46:02 +1200)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git
> tags/amd-pstate-v6.12-2024-09-04
>
> for you to fetch changes up to c3e093efbc6cac7bf9dc531dcb751b86daaa65b0:
>
>    cpufreq/amd-pstate: Catch failures for amd_pstate_epp_update_limit()
> (2024-09-04 15:07:34 -0500)
>
> ----------------------------------------------------------------
> amd-pstate development for 6.12:
> * Validate return of any attempt to update EPP limits, which fixes
>    the masking of hardware problems.
>
> ----------------------------------------------------------------
> Mario Limonciello (1):
>        cpufreq/amd-pstate: Catch failures for amd_pstate_epp_update_limit=
()
>
>   drivers/cpufreq/amd-pstate.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)

Pulled and added to the linux-next branch in linux-pm.git, thanks!

