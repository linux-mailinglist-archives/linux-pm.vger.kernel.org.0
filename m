Return-Path: <linux-pm+bounces-20892-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 012A7A1AADC
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 21:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8F403A81E8
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 20:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8261ADC8E;
	Thu, 23 Jan 2025 20:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUdOYgWu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037FA1ADC70;
	Thu, 23 Jan 2025 20:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737662858; cv=none; b=AvHOw2qnd8KY2kQKqJfIO5gTQj+MPDTbVKXKTG6AUKO2tC0LTtle9xPsh12r8+WNQHSOOyzaQsFcrbqPz0zSYirkD9MW350bINqd/xsO+k1cjryYtZoZtRr+HUpSOqqFwR0qQ4uwOOxcaUVUKpSJ/xX8dA47FCrEWtfEbja4K0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737662858; c=relaxed/simple;
	bh=e2OVK8Ddfw9uI2kSKge59UBY8eO5YlBqbhZSC/ylD5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AnhDpxIWJSju1qqrDlLGlVMZ00rRtzld5svLsBYpdIzUaimpjgCUmtRs4r3f1EyzbDBZVrlTbRdX0Fg1qbTJVBdVCb6qKmZiDg4CTx9DsbstrjGbt4dUs3jBBazPPfk+mA8Fl8lx7zPSGKVSt67BF6OF9j7164ffpmNcpS9L4NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUdOYgWu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A8BC4CEDF;
	Thu, 23 Jan 2025 20:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737662857;
	bh=e2OVK8Ddfw9uI2kSKge59UBY8eO5YlBqbhZSC/ylD5s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jUdOYgWuGHXGx62S6wluJxpqf2oMdMy42NtlncxMz9xovpZcKqn9se5XXs3GGbOrO
	 iQh6K/M9lH2qchPVWYkhUGp8JkUnWCg7c95mwS/Jm/2oGPHjjfjtRwutiHSNTWoo3G
	 ZXd5ROteCTkBksivXe+rKKTMd1xp4KZn3uQcGT4COgY+Z3toQoes6gGjl767RD8UKm
	 AcqI6yhKKixVfzS9AMFyMqStdXauHa/ZBSLUmonWpQG6xFF2pzPK79VhRhRIFPI5VU
	 y3t7dho6ccxRteZStP4VNxsZzX79H18/SiYzDOMQa9u0Dx2QB+2zlvTzfOyxFukyMz
	 8WlEZWxu5b2gw==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-29e70c9dc72so765898fac.0;
        Thu, 23 Jan 2025 12:07:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVjuIlTmeo1na18mEHWUKvZsnJPI7q4bE6R1IBTppli48JnlYPSMqrwkfC4AkWAetgvwRJhqoCRGhgBrL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBvugtZvp2oBE4gK/6YCKmyJpv+x3tLF/9DrXDaScxiMoAm5nD
	nb77+i12IBN5qYR0EF9tWWEyyOpvWpnRMt6jsCI51DQXLZTqkUIqtvaWKB1qsBl05E/ktRDCTeA
	aSR5aEnmM/qC5hogg3f1Swai2GHk=
X-Google-Smtp-Source: AGHT+IGbDwDE0IJNwA5kmFlJAW0zX7Ply0nT/HfUDMfW8PB0wBqUHp63naKhr7pwMu1YxqdpV/Ek/1x8C/IzaGZjxhQ=
X-Received: by 2002:a05:6871:5e08:b0:29e:70c7:a3eb with SMTP id
 586e51a60fabf-2b1c099a815mr14567233fac.7.1737662856719; Thu, 23 Jan 2025
 12:07:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117101457.1530653-1-zhenglifeng1@huawei.com> <20250121063815.ddqh7t2qt32cwx7e@vireshk-i7>
In-Reply-To: <20250121063815.ddqh7t2qt32cwx7e@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 23 Jan 2025 21:07:25 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0joB+xnRKLn_sFFFOsUnkD8smP=nEJCobDGsTQkkYnciQ@mail.gmail.com>
X-Gm-Features: AWEUYZkatgqjdJahuOD__u7Lertm9jP3BkwY_xf3QD77wmQNP-drNa2SfuQKcQ8
Message-ID: <CAJZ5v0joB+xnRKLn_sFFFOsUnkD8smP=nEJCobDGsTQkkYnciQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] cpufreq: Fix some boost errors related to CPU
 online and offline.
To: Viresh Kumar <viresh.kumar@linaro.org>, Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxarm@huawei.com, jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, 
	lihuisong@huawei.com, fanghao11@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 7:38=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> On 17-01-25, 18:14, Lifeng Zheng wrote:
> > This patch series fix some boost errors related to CPU online and offli=
ne:
> >
> >  - patch 1 fix an error that causes the CPU stay on base frequency afte=
r a
> >    specific operation
> >
> >  - patch 2 introduce a more generic way to set default per-policy boost
> >    flag and fix a error that causes the per-policy boost flag remians t=
rue
> >    when cpufreq_driver boost disabled
> >
> >  - patch 3 fix an error in cppc_cpufreq that causes the CPU stay on bas=
e
> >    frequency when boost flag is true
> >
> >  - patch 4 remove the set_boost in acpi_cpufreq_cpu_init(), since it wi=
ll
> >    be executed in cpufreq_online
> >
> > Change since v1:
> >  - remove update of min_freq_req
> >  - optimize the conditions for executing set_boost in cpufreq_online
> >  - fix another error in cppc_cpufreq
> >  - remove set_boost in acpi_cpufreq_cpu_init()
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

All patches in the series applied as 6.14-rc material, thanks!

