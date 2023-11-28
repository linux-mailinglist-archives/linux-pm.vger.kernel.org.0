Return-Path: <linux-pm+bounces-332-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD76D7FB0A6
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 04:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09F0C1C20A8B
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 03:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8AA6AD8;
	Tue, 28 Nov 2023 03:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zVC8UVKG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A376D1AA
	for <linux-pm@vger.kernel.org>; Mon, 27 Nov 2023 19:45:03 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cff3a03dfaso3772885ad.3
        for <linux-pm@vger.kernel.org>; Mon, 27 Nov 2023 19:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701143103; x=1701747903; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aqENqkO0tzrRX6nk+5fxLZVKpn8EWHtoTOpSeab41CI=;
        b=zVC8UVKGgInZwiFTyJjth1vIwQi+4PzCK0cbicx9tD9Dv81pJk4WdKIWQ94kI9onu0
         16ktOGtWPECtj1fBCJOgUYmIOPEiJy5RddSoCkfEDJIMjphvdKr08yea8SLgs6R53BV+
         SeHI06qgnKX1qTVQnlwCXr5mmR7OHA1SoIfzw6XnhVGzX9rpBz2PkAEWith7MgC+hsor
         oynu3wvcYTcFxH8ElKO3yJ+lXXuMOP9chRHsg8EAKYL4q+w2OzDoobnYEdc2M+/Eaz2y
         43ZWQ8O+h/nZge2XKd26a9mekVOsdnyPymQaIlYOUcOhmr80fuyoQpiD67+5Bx9lziLn
         hfbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701143103; x=1701747903;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aqENqkO0tzrRX6nk+5fxLZVKpn8EWHtoTOpSeab41CI=;
        b=gV8cXUf8/iUo9sk0yOijVYUPqLJKHGnKWf7AtWHuGxNo3Sbkadee5FP5rvsijgbYUF
         +l/1LtxsEqte08hySXZ7pWyr6r+TcWLZdG2PGTU0h9kT1f/hNJQPQsJMQg2hoCfQ1sIU
         uvZfmfEbem9qFZFOh5i02NuF/dSA17fTVAp/9E9de1VSVOaKYzyOwYIJzwexJii6u1j1
         YCMmxsvo/4gxrtYPgTa5pjU/YJLEa2+vTzey2udNpZtOiLGsHeYpaOWNyOBeASId6T0N
         8lgF9VzBBXx6lw01FHLiRnyBx09qUv4JSGNef1b/6a90xlMeFqKiagUtLYJkTjrd8Qy8
         ibdw==
X-Gm-Message-State: AOJu0YwR3xIDlFzQ/n/5B0vYBmQvlJTD3w0TnR5xegp+Jg5OmSr6V4ev
	U94py8feZw2uUzsQseAU9B2YZw==
X-Google-Smtp-Source: AGHT+IEaUMiQHyszTrL36vf+MA6N6446tYXLZrlSLesGkGZOlRqtuYMkwapte9LMbq0x55O5SJp21w==
X-Received: by 2002:a17:902:d48d:b0:1cf:c78a:f50 with SMTP id c13-20020a170902d48d00b001cfc78a0f50mr5942861plg.23.1701143103077;
        Mon, 27 Nov 2023 19:45:03 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id t18-20020a170902d21200b001cfad45d6bbsm6199748ply.247.2023.11.27.19.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 19:45:02 -0800 (PST)
Date: Tue, 28 Nov 2023 09:14:59 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [GIT PULL] cpufreq/arm fixes for 6.7-rc4
Message-ID: <20231128034459.fwgzqilxo2gl32ep@vireshk-i7>
References: <20231127043144.kkyyaut4e7gpzr2r@vireshk-i7>
 <CAJZ5v0ifcNJPoKPaLYyHQPnJWoCjLFsNXuYmysVuOHtEVNPQnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0ifcNJPoKPaLYyHQPnJWoCjLFsNXuYmysVuOHtEVNPQnw@mail.gmail.com>
X-Spam-Level: *

On 27-11-23, 22:11, Rafael J. Wysocki wrote:
> Hi Viresh,
> 
> On Mon, Nov 27, 2023 at 5:31 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > Hi Rafael,
> >
> > The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:
> >
> >   Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/linux-next
> >
> > for you to fetch changes up to 8f96e29aae31354191227ad476dc7f6147ef1d75:
> >
> >   pmdomain: qcom: rpmpd: Set GENPD_FLAG_ACTIVE_WAKEUP (2023-11-23 13:08:01 +0530)
> >
> > ----------------------------------------------------------------
> > Christoph Niedermaier (1):
> >       cpufreq: imx6q: Don't disable 792 Mhz OPP unnecessarily
> >
> > Stephan Gerhold (3):
> >       cpufreq: qcom-nvmem: Enable virtual power domain devices
> >       cpufreq: qcom-nvmem: Preserve PM domain votes in system suspend
> >       pmdomain: qcom: rpmpd: Set GENPD_FLAG_ACTIVE_WAKEUP
> >
> >  drivers/cpufreq/imx6q-cpufreq.c      |  2 +-
> >  drivers/cpufreq/qcom-cpufreq-nvmem.c | 73 ++++++++++++++++++++++++++++++++++--
> >  drivers/pmdomain/qcom/rpmpd.c        |  1 +
> >  3 files changed, 72 insertions(+), 4 deletions(-)
> >
> > --
> 
> Pulled, but it would be kind of nice to get some description of the
> material other than the shorlog.

Ahh, my fault. I created the pull request using the branch name instead of the
tag. I usually do the right thing and so the description comes by itself.

-- 
viresh

