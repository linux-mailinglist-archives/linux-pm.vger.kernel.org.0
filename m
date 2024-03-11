Return-Path: <linux-pm+bounces-4830-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3236A87843E
	for <lists+linux-pm@lfdr.de>; Mon, 11 Mar 2024 16:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F203283608
	for <lists+linux-pm@lfdr.de>; Mon, 11 Mar 2024 15:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F6F44C69;
	Mon, 11 Mar 2024 15:54:44 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E324207B
	for <linux-pm@vger.kernel.org>; Mon, 11 Mar 2024 15:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710172484; cv=none; b=I9gzQmJe8hnTWAFMbb3YsiTlOjqSQV9cEFq6YchZryioB/w7MHUyEZgymN6EfczuiO7abpm7G4QLMcxMlSFbUXktGFuISbYDjSBz042BiLM89zsqEEpKaUdAiakzfkIRpAZ8T+R5+DopYXUGoNe67MS/0RD6ogpePR6UAVf8IrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710172484; c=relaxed/simple;
	bh=xgJpmZGA4JcmgK1X6a5qdEJSyepkykRu0nJC5ej6JNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K2BUMzxKx6Lw4UCtW4DHzjT5Fq1QKZN06JSyV5woiPRi309LofY3zT9U6f6t7gDixhyb/We4I70JdlJBaf4cqT5ndrUeIOy3mNsMTMcC/9wF/2um47lNXTpsGWnZ0F9v6q+oFXKwuZHPWMNLOBJQ7GtLRQJqOIQgkS8cO2jvCmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-221a1722824so195000fac.1
        for <linux-pm@vger.kernel.org>; Mon, 11 Mar 2024 08:54:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710172482; x=1710777282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bzlc33JxxMXWXsKP/nCGNv7ry1zewhAipk0+b85M4Fk=;
        b=XLgSlGaM4vzYk9tgfuKLFWzlQt6pFefW/N3SewP8cLO+YI6lzSiUJZAdw9t9AkgPm9
         rJZ7FFPzOiSSw8Z8cmbOEJItzG8dMCpSzRc4OshJGy+upvh+lzEEVCSQobJrVXlzQMcE
         /hp7GlcbLeJjpK7a6iiTJyHQl0yemoWmdWRIXYFgFwLo1/dxAZpRrGnWF63jBYKfr5de
         s+DQfbwojcf9+fR+jSyAr6TLN1lUrEeakYBA2cJJE1qfYjB3eKne/Irm4+Wit22utDvS
         MS5bOT8Kwhfh0F0b08BdXwwgTpm7Bpquhm+xP2rfa1TFTuJD63XFLuV7eiK29c18f2HM
         5wag==
X-Forwarded-Encrypted: i=1; AJvYcCWWWuk40Nk8LPBVTVLunzZvrPhDLjyWVoDcmFk61C1Xilt8kpFkbpy93qHiwp58FMJJUmAGHY6AxhUQt1GVbprz5fV2Y5mFdfY=
X-Gm-Message-State: AOJu0Yz/qSjBWdEvPVR9axv7m5p2/br+yv9vp12O93ROg6t7/X8RBKDu
	339nQmRXpshAje4U81B/HsBka/yvzOEdvH3AfAdyVQRjfmfb8V7GmJec+AwzTsEGJi3gtvGCbXg
	thGQfUhPyk3Le8tP224JlJ+Q4ldk=
X-Google-Smtp-Source: AGHT+IHPcPY1yuYmkfIFoSfDzBw7swH6LkWHddDRnDZq5LgX67FS6Q8MzT8QySSapB8IueSnojRHKQPZUY+nX+qatKE=
X-Received: by 2002:a05:6871:58e:b0:221:4a4e:7943 with SMTP id
 u14-20020a056871058e00b002214a4e7943mr7171362oan.2.1710172481608; Mon, 11 Mar
 2024 08:54:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311100947.mfbotbjngjvirg7m@vireshk-i7>
In-Reply-To: <20240311100947.mfbotbjngjvirg7m@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 11 Mar 2024 16:54:30 +0100
Message-ID: <CAJZ5v0h_fnUwiPcuiDaX1Fr0BqmNO1GnjPUwvpMTZ093dogwVA@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm updates for 6.9
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Viresh,

On Mon, Mar 11, 2024 at 11:09=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.=
org> wrote:
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
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufr=
eq-arm-updates-6.9
>
> for you to fetch changes up to ad2a91086e288c9ab1d74eee57edabe08bd90471:
>
>   cpufreq: scmi: Set transition_delay_us (2024-03-06 10:54:24 +0530)
>
> ----------------------------------------------------------------
> ARM cpufreq updates for 6.9
>
> - General enhancements / cleanups to cpufreq drivers (tianyu2, N=C3=ADcol=
as
>   F. R. A. Prado, Erick Archer, Arnd Bergmann, Anastasia Belova).
> - Update cpufreq-dt-platdev to block/approve devices (Richard Acayan).
> - scmi: get transition delay from firmware (Pierre Gondois).
>
> ----------------------------------------------------------------
> Anastasia Belova (1):
>       cpufreq: brcmstb-avs-cpufreq: add check for cpufreq_cpu_get's retur=
n value
>
> Arnd Bergmann (1):
>       cpufreq: qcom-hw: add CONFIG_COMMON_CLK dependency
>
> Erick Archer (1):
>       Documentation: power: Use kcalloc() instead of kzalloc()
>
> N=C3=ADcolas F. R. A. Prado (2):
>       cpufreq: mediatek-hw: Wait for CPU supplies before probing
>       cpufreq: mediatek-hw: Don't error out if supply is not found
>
> Pierre Gondois (3):
>       firmware: arm_scmi: Populate perf commands rate_limit
>       firmware: arm_scmi: Populate fast channel rate_limit
>       cpufreq: scmi: Set transition_delay_us
>
> Richard Acayan (1):
>       cpufreq: dt-platdev: block SDM670 in cpufreq-dt-platdev
>
> tianyu2 (1):
>       cpufreq: imx6: use regmap to read ocotp register
>
>  Documentation/power/opp.rst                    |  2 +-
>  Documentation/translations/zh_CN/power/opp.rst |  2 +-
>  drivers/cpufreq/Kconfig.arm                    |  1 +
>  drivers/cpufreq/brcmstb-avs-cpufreq.c          |  2 ++
>  drivers/cpufreq/cpufreq-dt-platdev.c           |  1 +
>  drivers/cpufreq/imx6q-cpufreq.c                | 45 +++++++++++++++-----=
-------------------------
>  drivers/cpufreq/mediatek-cpufreq-hw.c          | 19 ++++++++++++++++++-
>  drivers/cpufreq/scmi-cpufreq.c                 | 26 ++++++++++++++++++++=
++++++
>  drivers/firmware/arm_scmi/driver.c             |  5 ++++-
>  drivers/firmware/arm_scmi/perf.c               | 53 ++++++++++++++++++++=
+++++++++++++++++++++++++++++----
>  drivers/firmware/arm_scmi/powercap.c           | 12 ++++++++----
>  drivers/firmware/arm_scmi/protocols.h          |  4 +++-
>  include/linux/scmi_protocol.h                  |  8 ++++++++
>  13 files changed, 137 insertions(+), 43 deletions(-)
>
> --

Pulled and added to the pm branch in linux-pm.git, thanks!

