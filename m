Return-Path: <linux-pm+bounces-20939-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F58DA1B466
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 12:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D31373A744E
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 11:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E9821A94D;
	Fri, 24 Jan 2025 11:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2xss22X"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D0021A928;
	Fri, 24 Jan 2025 11:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737716750; cv=none; b=n9RqMMJ1Vk+nqs1Sc/87OpN8xHkmrBtqu+1TmvfiIartGvgdQ9LLdtmpDWuS6psQODlPRpQq4xXRrYLlEV9X2lryJjM+TAvqWUoSgajZNPF757q2601KmdfMMF1uDVZ3bmJqRz/O9sVbxveQNwWxwuq0KcNLyfT/WwABNf8iBWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737716750; c=relaxed/simple;
	bh=CBFb9cadK6CI8XSq0vtxlBS7O6t7I082PLHFx/6xqJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ahl10iwXLIzs4MXajAcKNNV+lcvUxj03MRreSQ84VpmCG2JfzxKnPzxrRtahn65XXPsB3oV4w5/U5WFl9eusudGCCBXskfaWnv14i9E4DZukLUazy39iWq7oByQCoutg969y+03sxJbmadooFbHiuf8Rc7VbCZgSX10LJrTHQ2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2xss22X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C542C4CEF0;
	Fri, 24 Jan 2025 11:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737716749;
	bh=CBFb9cadK6CI8XSq0vtxlBS7O6t7I082PLHFx/6xqJg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=e2xss22X+GyHcg3L8RAGJnHI3wDEOvPUmDUd72VUO16PECn3RbKh71bUJsCjz4MHd
	 34alIyJ7KAOL1PhHPmxJ8W6ZekOE7ybWqTa8Yi/U5HZVx5iPXhA7OQsPv/iDuqwGdD
	 RIoAyWvWanAC5dkN7+Vej8NoM8kxx4GFamPhoe4GdoZ4pWSeVhC8DVAMStEOXmq/IH
	 b9xNJyKxptQn4ZmyTBB2eKnumhh359jLGlyW5QahtLgPUgFatOjU2FaacQhNvAWxZB
	 Q7fZYMvH/pSF/rbwsu8wZDf4msxdCVQ5/q+XOaDGzvw3VuUt/w/QtKOeNm+aFsPuEO
	 qOqYyDaSZwucA==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-29e5aedbebdso1053430fac.0;
        Fri, 24 Jan 2025 03:05:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUEA64ceVm0Ej1oNehdyIZgNxhuqr/RuUAFuWJym5f78hLnAQ7PG0kO52ieyP3VEEISDIg+BOmvvAM=@vger.kernel.org, AJvYcCVroL6+JevdKO2+uKMAIZShweCRxkYaPd3tBvh/jGT2TiNc5nbksFWfbbL7KoOMP0Eiu27/5KBZfQ==@vger.kernel.org, AJvYcCVtCBAEnmNQ/GoNG9DQzp4NT7AkuIaAaihmdedFoUFjZCob2j+BvPItXopmy5tAYIkjt/nQpDHX8pk/HaZuNg==@vger.kernel.org, AJvYcCVv02tgNR9vqTxZ1XmEWJyhgZrsmOZqTe4GUk6TP3nDko3tINIjifeRxNLvpv7FhfbuY2O4bbv8EtwrbC2k@vger.kernel.org
X-Gm-Message-State: AOJu0YwXfBTtzZScGtWDUDVjs677HPIiEp9jaVl4pTFE7InnPxWFJHCL
	aIdD/PPyMGYblmWQS5st9fA5ioU3+pSC0n5Hq4x61ngzHKNhJA3bmLBNzyy6/7B9tYsUZWW2Unb
	n6b9IgtO0JYtremhXaFcLGH8lbkc=
X-Google-Smtp-Source: AGHT+IF9SQa/+bL5eAQooEMEc4F5um8UWTrom9xFFpSH41EcICfOloxWkQjjLH9ovO30qYEM+acRaxA2bbdUNAtBaco=
X-Received: by 2002:a05:6871:6187:b0:29e:4a13:603f with SMTP id
 586e51a60fabf-2b1c09e6ad7mr17574182fac.4.1737716748305; Fri, 24 Jan 2025
 03:05:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1737707712.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1737707712.git.viresh.kumar@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 24 Jan 2025 12:05:36 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jYSZQKkLN-TO_h0AazhHZtHgpavTnnAscLPYLmjX3LaA@mail.gmail.com>
X-Gm-Features: AWEUYZn3vDpFuQgrmPTKrUBYJK1_bLxZl9mOCsSZPYdX_ojBCvjxJpMU7z9GFhg
Message-ID: <CAJZ5v0jYSZQKkLN-TO_h0AazhHZtHgpavTnnAscLPYLmjX3LaA@mail.gmail.com>
Subject: Re: [PATCH 00/15] cpufreq: simplify boost handling
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Cristian Marussi <cristian.marussi@arm.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Hector Martin <marcan@marcan.st>, 
	Huacai Chen <chenhuacai@kernel.org>, Huang Rui <ray.huang@amd.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Naveen N Rao <naveen@kernel.org>, 
	Nicholas Piggin <npiggin@gmail.com>, Perry Yuan <perry.yuan@amd.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Sven Peter <sven@svenpeter.dev>, 
	WANG Xuerui <kernel@xen0n.name>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Lifeng Zheng <zhenglifeng1@huawei.com>, 
	arm-scmi@vger.kernel.org, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 9:58=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> Hello,
>
> The boost feature can be controlled at two levels currently, driver
> level (applies to all policies) and per-policy.
>
> Currently most of the drivers enables driver level boost support from the
> per-policy ->init() callback, which isn't really efficient as that gets c=
alled
> for each policy and then there is online/offline path too where this gets=
 done
> unnecessarily.
>
> Also it is possible to have a scenario where not all cpufreq policies sup=
port
> boost frequencies. And letting sysfs (or other parts of the kernel) enabl=
e boost
> feature for that policy isn't correct.
>
> Simplify and cleanup handling of boost to solve these issues.

I guess this depends on the previous series?

> Pushed here:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/boos=
t
>
> Rebased over few dependencies from PM tree, will push to the arm-cpufreq =
tree
> after merge window is closed.
>
> Viresh Kumar (15):
>   cpufreq: staticize cpufreq_boost_trigger_state()
>   cpufreq: Export cpufreq_boost_set_sw()
>   cpufreq: Introduce policy->boost_supported flag
>   cpufreq: acpi: Set policy->boost_supported
>   cpufreq: amd: Set policy->boost_supported
>   cpufreq: cppc: Set policy->boost_supported
>   cpufreq: Restrict enabling boost on policies with no boost frequencies
>   cpufreq: apple: Set .set_boost directly
>   cpufreq: loongson: Set .set_boost directly
>   cpufreq: powernv: Set .set_boost directly
>   cpufreq: scmi: Set .set_boost directly
>   cpufreq: dt: Set .set_boost directly
>   cpufreq: qcom: Set .set_boost directly
>   cpufreq: staticize policy_has_boost_freq()
>   cpufreq: Remove cpufreq_enable_boost_support()
>
>  drivers/cpufreq/acpi-cpufreq.c      |  3 +++
>  drivers/cpufreq/amd-pstate.c        |  4 ++--
>  drivers/cpufreq/apple-soc-cpufreq.c | 10 +---------
>  drivers/cpufreq/cppc_cpufreq.c      |  9 +--------
>  drivers/cpufreq/cpufreq-dt.c        | 14 +-------------
>  drivers/cpufreq/cpufreq.c           | 30 ++++++++++++-----------------
>  drivers/cpufreq/freq_table.c        |  7 +++++--
>  drivers/cpufreq/loongson3_cpufreq.c | 10 +---------
>  drivers/cpufreq/powernv-cpufreq.c   |  5 +----
>  drivers/cpufreq/qcom-cpufreq-hw.c   |  7 +------
>  drivers/cpufreq/scmi-cpufreq.c      | 11 +----------
>  include/linux/cpufreq.h             | 20 ++++++-------------
>  12 files changed, 35 insertions(+), 95 deletions(-)
>
> --
> 2.31.1.272.g89b43f80a514
>

