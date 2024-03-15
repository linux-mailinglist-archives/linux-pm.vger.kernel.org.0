Return-Path: <linux-pm+bounces-4984-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8238687CD1B
	for <lists+linux-pm@lfdr.de>; Fri, 15 Mar 2024 13:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 448312833B8
	for <lists+linux-pm@lfdr.de>; Fri, 15 Mar 2024 12:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89461BF44;
	Fri, 15 Mar 2024 12:16:08 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EF71C287
	for <linux-pm@vger.kernel.org>; Fri, 15 Mar 2024 12:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710504968; cv=none; b=dO8pJws8hKPYS+TXjmXfBy/D8yANxB+LYHC9U+ujIcVAh5idG0dOu+CME6QFEulxfLyLlRxGf1AbdJJs07A8m0rIbO7fXpeMf+wuvGKDKZpNpQKwg/WJDRS+U1ORiZn0A7IHDDperOm7oaHqSOdRBEPfcCYZgTGrnLKTiaE++r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710504968; c=relaxed/simple;
	bh=I6Bgt8PA6FmR2lJO81e4ZnZzTIDxFFCIMqMDyGF8Mr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WPmJS6cvnsgjTLUmgAaONCzjBgBgRT7ibkEh0CSHa18K/zHU00etsu5Olu+gAXq5QYeFZLQNxTE+eZX69lKssrVeRgGFSlgwS2JdKW7utivH4KQ7jGnPcA+ThWvOPMiC08hPtWbHdNnnnq/vBfddnAXPDvEloSM7OSuztIEV4x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2228861376aso25432fac.0
        for <linux-pm@vger.kernel.org>; Fri, 15 Mar 2024 05:16:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710504966; x=1711109766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEUlMaVye9RxLQVQWLdZE3b7UE4Nd33rdPptllXe65o=;
        b=J0Y9fwOTcgK65Y4jBY4UPwtUNuXns69i9ciHiRhtm2lpyMRZ6JEYxW1spVU2KRXGi6
         9/hI9X2GwQ1O/2neOsizDM6SfUWiOJP+hIDOM1RZRSYw16iELCVJ4IHHOf12yBh/LJVM
         hGg9uZvXA0k7py6VydJLM5zw63QiP/q3Tq3A8E8fbwsqi9fFgNFZsiVw8oHf6d3UeRwe
         PH0UUSinX4wRpjgokjsCCjlVxLdQnb6ZHOkwZLVzKE0U6JVVPpvFdmyUZzcjYlf6R9Lg
         zisZk46AfaltOwT8hycHMaxcsswb1YXePi2FsrgnxdvkqfoFpiPoS3OqX9Jh01tqrcf6
         vCjw==
X-Forwarded-Encrypted: i=1; AJvYcCVCC21SlLEDj1BygyCWBlIdq4DQM7FwYfIm0/aJxosQCL4DVWQ8Cvq3PitnvQanVQqqHMKUNMOMym4EZnIJcmdkwgZhcDBcQxs=
X-Gm-Message-State: AOJu0YzLQYUsHPrmo8YvF4pQ62JBF9c5coA8b5zr3zRsCs0xYSMV5372
	divJq+mYrMbEAmwnMpyFzGtNrsHtr6GFWxEG8UJ7e4klj5OMh9b2EcbK21TnQtbJMkHsxMDNe/Z
	SOwMXn5uvXMy9YPQayOrysKEurmg=
X-Google-Smtp-Source: AGHT+IGxe8cT9ZdrwZSk2BdwOnDlXr3/NyF6LpCPm+mIA5idKjEAZP4aQqacbVF6US58IGLUVlfbVOSYHEVEzNKj2Yc=
X-Received: by 2002:a05:6871:5b11:b0:221:a151:7f3d with SMTP id
 op17-20020a0568715b1100b00221a1517f3dmr4758148oac.2.1710504966406; Fri, 15
 Mar 2024 05:16:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315055427.lvhpxvojegoqrcvy@vireshk-i7>
In-Reply-To: <20240315055427.lvhpxvojegoqrcvy@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 15 Mar 2024 13:15:54 +0100
Message-ID: <CAJZ5v0jm5tiVBkP2v7BZ0A1a9vn-b7g-anUP9qeNSxwP9sPs3g@mail.gmail.com>
Subject: Re: [GIT PULL] More cpufreq/arm updates for 6.9
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Viresh,

On Fri, Mar 15, 2024 at 6:54=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> Hi Rafael,
>
> The following changes since commit abb3f9717a67a2666b2bc2f19543a657e3d4ad=
63:
>
>   OPP: Extend dev_pm_opp_data with turbo support (2024-03-11 10:39:24 +05=
30)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufr=
eq-arm-updates-6.9-2
>
> for you to fetch changes up to a8e949d41c72a0a860b1c3571d6b274e9b77b6bb:
>
>   cpufreq: scmi: Enable boost support (2024-03-15 11:19:27 +0530)
>
> ----------------------------------------------------------------
> ARM cpufreq updates for 6.9
>
> - zero initialize a cpumask (Marek Szyprowski).
> - Boost support for scmi cpufreq driver (Sibi Sankar).
>
> ----------------------------------------------------------------
> Marek Szyprowski (1):
>       cpufreq: dt: always allocate zeroed cpumask
>
> Sibi Sankar (2):
>       firmware: arm_scmi: Add support for marking certain frequencies as =
turbo
>       cpufreq: scmi: Enable boost support
>
> Viresh Kumar (1):
>       Merge branch 'opp/boost-data' into cpufreq/arm/linux-next
>
>  Documentation/power/opp.rst                    |  2 +-
>  Documentation/translations/zh_CN/power/opp.rst |  2 +-
>  drivers/cpufreq/Kconfig.arm                    |  1 +
>  drivers/cpufreq/brcmstb-avs-cpufreq.c          |  2 ++
>  drivers/cpufreq/cpufreq-dt-platdev.c           |  1 +
>  drivers/cpufreq/cpufreq-dt.c                   |  2 +-
>  drivers/cpufreq/imx6q-cpufreq.c                | 45 +++++++++++++++-----=
-------------------------
>  drivers/cpufreq/mediatek-cpufreq-hw.c          | 19 ++++++++++++++++++-
>  drivers/cpufreq/scmi-cpufreq.c                 | 46 ++++++++++++++++++++=
+++++++++++++++++++++++++-
>  drivers/firmware/arm_scmi/driver.c             |  5 ++++-
>  drivers/firmware/arm_scmi/perf.c               | 56 ++++++++++++++++++++=
++++++++++++++++++++++++++++++++----
>  drivers/firmware/arm_scmi/powercap.c           | 12 ++++++++----
>  drivers/firmware/arm_scmi/protocols.h          |  4 +++-
>  include/linux/scmi_protocol.h                  |  8 ++++++++
>  14 files changed, 160 insertions(+), 45 deletions(-)
>
> --

Pulled and added to the linux-next branch in linux-pm.git, thanks!

