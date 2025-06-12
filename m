Return-Path: <linux-pm+bounces-28538-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA962AD6EFF
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 13:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D23CF189766C
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 11:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E2E23C397;
	Thu, 12 Jun 2025 11:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYrqXgYV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BEA23A99F;
	Thu, 12 Jun 2025 11:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749727702; cv=none; b=lIBQ4Nyan9N9EjemE2PSGDNO4axECkK18IQyxbRDgdknvd/CNuTvv9rPdBwwgQ9vTQk4lUcv8hXqz4KoSfRaMxX7QYeBnMsb0+sINvr9LnSrQFW8k7vV1hOPBYyG9SN5bFUYGWzHblFoIFta3ZCCBdH1n1fLl21FNGGCxikCTJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749727702; c=relaxed/simple;
	bh=1/KbsW/gcwjCdnVYU77jL7Kaf1eUU9AWH51RP/DsUQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pk8vUe0sUy8anqfL9JNVm+j+z9HmDpDyV0qw5xVqgEg0r2n0UWI4Rfz7fFfQk7+V+lAwFpusslnWwcUweRZ7Nu4cpfp6fgrIK2VvOOrK5HVewD9olKatTnXGSP5gTIkvYPW1ZPMF9ZZfIzQewO1nSk3xH3WrtTKqIs+wqxLAtqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYrqXgYV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64715C4CEEA;
	Thu, 12 Jun 2025 11:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749727701;
	bh=1/KbsW/gcwjCdnVYU77jL7Kaf1eUU9AWH51RP/DsUQE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eYrqXgYVg/6rW0J77/BEZVRGVNILH3fR6PM2dPrN9Reato9AQSBEY5GWZ6oAF1vEy
	 aKL3HfK9/2bHOxTv2iBVWlx828A78Vt5U0vfeLUxMj6u02qf3vO37KRN5mw8YNWvTf
	 f8+xgFUbwrf2+2q2czoapzoYUQzm1Z7YHMIScm0Fh9CSD9dR/vHju4jhPGEB8bbkYo
	 ty+Kb+JsjmW1Gvvfqsk8pxlleI92lpm0J8R+sUCXFbE0nN7NtxDKngLHu6ZW7lF4zo
	 PvfI+xPnGrNsj9ScNdDXwXKajY+YvnLqZ2UU8frKDS6hqMLlTsJszy42qb9Aw7dKkB
	 /RWi404/Q2LiA==
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-735b9d558f9so242169a34.2;
        Thu, 12 Jun 2025 04:28:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU4nb1cIa4WaBG0aPKW6FSc4QGKGsUVZYNqZBee6hWTDUxs9CwSKilN6kQhXy3irK4CDUdDr9DFog==@vger.kernel.org, AJvYcCV+pyWmeENxYUy6kAR/vxJgGlTxJzd50eUUktTG/XLRVuE/Ch6cVHK8CMUNEvg8+JiEddpAYo1BFPMlpXW9IaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTpwHrTVLEq2QPzsTdgpjPwFnuNg918gcokj1y4dom8/DHlzhM
	Bsl9L+MQ5vGiue885lIjWVhD+954+I0hqHdH7/TdEYO57ZHdmAg30Y8CAet8u79CzrAwRmnsvO0
	LKKcPSjj6//VXyWvOh9AJ8ehEs1s4BmU=
X-Google-Smtp-Source: AGHT+IF+BjTKeLo0Qwww4FDhCePZuXScWeqju5su8oE4tZpEFob0L7ljXvWTrQ00j9O10rbSuKbS2ZeKUTmnxoA4Nzs=
X-Received: by 2002:a05:6808:18a5:b0:3f9:2fdc:ee93 with SMTP id
 5614622812f47-40a5d14dc02mr4977325b6e.30.1749727700627; Thu, 12 Jun 2025
 04:28:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612104446.hhwn24f3nkasyefa@vireshk-i7>
In-Reply-To: <20250612104446.hhwn24f3nkasyefa@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 12 Jun 2025 13:28:08 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0it5nNwJkyhy_9MoK+RLQ3fcGEjEjEZYVcFYBbB4xiZ7Q@mail.gmail.com>
X-Gm-Features: AX0GCFuAtzvTmjOCp9H9SNay_96NVnTAvW4_kqmajBT3gkaNrNNJ49iD9MTo_EU
Message-ID: <CAJZ5v0it5nNwJkyhy_9MoK+RLQ3fcGEjEjEZYVcFYBbB4xiZ7Q@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm fixes for 6.16-rc
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Viresh,

On Thu, Jun 12, 2025 at 12:44=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.=
org> wrote:
>
> Hi Rafael,
>
> The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd13544=
94:
>
>   Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufr=
eq-arm-fixes-6.16-rc
>
> for you to fetch changes up to c7f005f70d22cd5613cac30bf6d34867189e36a9:
>
>   rust: cpu: Add CpuId::current() to retrieve current CPU ID (2025-06-12 =
10:31:28 +0530)
>
> ----------------------------------------------------------------
> CPUFreq fixes for 6.16-rc
>
> - Implement CpuId rust abstraction and use it to fix doctest failure
>   (Viresh Kumar).
> - Minor cleanups in the `# Safety` sections for cpufreq abstractions
>   (Viresh Kumar).
>
> ----------------------------------------------------------------
> Viresh Kumar (4):
>       cpufreq: Convert `/// SAFETY` lines to `# Safety` sections
>       rust: cpu: Introduce CpuId abstraction
>       rust: Use CpuId in place of raw CPU numbers
>       rust: cpu: Add CpuId::current() to retrieve current CPU ID
>
>  MAINTAINERS                    |   1 +
>  drivers/cpufreq/rcpufreq_dt.rs |   4 ++--
>  rust/helpers/cpu.c             |   8 +++++++
>  rust/helpers/helpers.c         |   1 +
>  rust/kernel/cpu.rs             | 125 +++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  rust/kernel/cpufreq.rs         | 173 +++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------=
------------------------
>  rust/kernel/cpumask.rs         |  51 ++++++++++++++++++++++++++++-------=
-----
>  7 files changed, 299 insertions(+), 64 deletions(-)
>  create mode 100644 rust/helpers/cpu.c
>
> --

Pulled and added to linux-pm.git/fixes, thanks!

