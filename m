Return-Path: <linux-pm+bounces-313-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E2C7FAC5F
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 22:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58A701C20FA4
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 21:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FB33EA8D;
	Mon, 27 Nov 2023 21:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2929510D2
	for <linux-pm@vger.kernel.org>; Mon, 27 Nov 2023 13:11:54 -0800 (PST)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-58787a6583aso170153eaf.1
        for <linux-pm@vger.kernel.org>; Mon, 27 Nov 2023 13:11:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701119513; x=1701724313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zVuvnLDret0q36FPIUVgCq1rFqP7t64pTb1+6wjkDJk=;
        b=WC+sdY1PfqKVLWOcpWRQL4jQ6Tftwh5ZXTsb4cLZV9F/KNPq6VmGwhPFl9+i+NgxHv
         yAowl5AMGe0UXeemU6j1T13DjAhnw7gAhLOFZ8LbJykHqiod7ss4OMupSP3CHOXZpiZU
         MMxNox5x9wLEjKDqTOfPkQjWs4xcR/pkxpO5RaqXSE6x69O14pIio6SJ+mH9QrDGIkK5
         BAPyey4AUoqufwUOeNKL0A5SlVnkV/ctPE2jR/WjfX6yZ+ef6DMMAbdQHCy3j926LcSh
         bqilYRKVWDkhqT67TNf2nx6h97JxFqI6h3V76Lbxf4xDqEH0126/SuHb9GclRIe29Zxo
         9Fjg==
X-Gm-Message-State: AOJu0YySf9+1jOHEt7u3lrJOPOGLn6dJXp1GBM52uz0OLGC5RbcTEa5d
	qltzPzebVWFE7zskT482h4eJdia19PAU/8XBkgcn2Z2+
X-Google-Smtp-Source: AGHT+IHnO3a1YMII1YwFsY/W3dI6YwY3e3tnkDNyg81CQVbxjStRHtgQymgKEZcOyunpdvtzVoXdll7rTpATug26m6Q=
X-Received: by 2002:a05:6820:b0b:b0:58a:7cff:2406 with SMTP id
 df11-20020a0568200b0b00b0058a7cff2406mr11416027oob.0.1701119513495; Mon, 27
 Nov 2023 13:11:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127043144.kkyyaut4e7gpzr2r@vireshk-i7>
In-Reply-To: <20231127043144.kkyyaut4e7gpzr2r@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 27 Nov 2023 22:11:42 +0100
Message-ID: <CAJZ5v0ifcNJPoKPaLYyHQPnJWoCjLFsNXuYmysVuOHtEVNPQnw@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm fixes for 6.7-rc4
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Stephan Gerhold <stephan.gerhold@kernkonzept.com>, Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Viresh,

On Mon, Nov 27, 2023 at 5:31=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
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
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/ar=
m/linux-next
>
> for you to fetch changes up to 8f96e29aae31354191227ad476dc7f6147ef1d75:
>
>   pmdomain: qcom: rpmpd: Set GENPD_FLAG_ACTIVE_WAKEUP (2023-11-23 13:08:0=
1 +0530)
>
> ----------------------------------------------------------------
> Christoph Niedermaier (1):
>       cpufreq: imx6q: Don't disable 792 Mhz OPP unnecessarily
>
> Stephan Gerhold (3):
>       cpufreq: qcom-nvmem: Enable virtual power domain devices
>       cpufreq: qcom-nvmem: Preserve PM domain votes in system suspend
>       pmdomain: qcom: rpmpd: Set GENPD_FLAG_ACTIVE_WAKEUP
>
>  drivers/cpufreq/imx6q-cpufreq.c      |  2 +-
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 73 ++++++++++++++++++++++++++++++=
++++--
>  drivers/pmdomain/qcom/rpmpd.c        |  1 +
>  3 files changed, 72 insertions(+), 4 deletions(-)
>
> --

Pulled, but it would be kind of nice to get some description of the
material other than the shorlog.

Thanks!

