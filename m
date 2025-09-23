Return-Path: <linux-pm+bounces-35225-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C96B95DDB
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 14:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97BF97B0642
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 12:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B442ED842;
	Tue, 23 Sep 2025 12:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kO3kFJ8f"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2640257853
	for <linux-pm@vger.kernel.org>; Tue, 23 Sep 2025 12:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758631615; cv=none; b=N1bQxH/eWL26yAu2dnIZKwgc46lyTugKB/p301y6d2sc0vgSDBnW4iiaOXSC0MPctfGuFO9glawoYa7Wk6NDYuE0RhNJn5bU0SBV1z+qY4tVbUqsAyHjUZ6/41ecM9Px5aiu3wFV/wytX3YST+z93BJFSgQU+qHU/dwFQ54ZsaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758631615; c=relaxed/simple;
	bh=QBw//bisdaVVv769b0vPAafO2Q1m+S5aT6y/sEq9bIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B7kpjsVPfMmUpq5+oTlR+qkdxtwQNPFz55sfm4eRImmKrLU0KZeCWGbQbp5SmpQhr4luYVQweCBvUJUE/pjoI9gE8Y1b8MxrSb0Uq/0iGcOjXWlOWErHdIXLTGLrAsraROFv8wq3gbwHw0D2ddtrVCAYRW8s4Nz6wRm0lu5w8jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kO3kFJ8f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E5AC116C6
	for <linux-pm@vger.kernel.org>; Tue, 23 Sep 2025 12:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758631614;
	bh=QBw//bisdaVVv769b0vPAafO2Q1m+S5aT6y/sEq9bIQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kO3kFJ8fvJVRKy2SuzN+5Kyv0YAIUeMELdPspluEjdLYKx91hZPNlfPTqPBsa1zeB
	 6L+FXrQmchHI9NRUGTep+genkVCHKyGGomF1u/8OZ8vPNwjo+AI+5c++ORh0RKdhDD
	 78Al47qvfQ4ril4XcRMeKFb1aTDC2KJ2NH1hRINdqmnsrA4BVYscnswChNs6L8tvOx
	 FEkFcsnqfET9JrBzj98NCcc95q2IAZNTTRzuEI4KxynHIcf0g0gFrE77egbM9JRth3
	 5I3ZdNcsPZXG0J0uBmaKjJO976OqBUNKJe6w1HL2woshoR/SEo07nRFa8zuL+F22Dn
	 avIZ2+yqS/fgw==
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-793ef18e8a3so294031a34.0
        for <linux-pm@vger.kernel.org>; Tue, 23 Sep 2025 05:46:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWHgc9cuWapWglQ5agfv3BiIyVYXSY0wXPeI7rJPCwPgLE0cG3XjfMdN9EkyqNkUgcSpmJlDbICDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJb4DG0Re9LpZhEFOszNL/K1wfG8jD1re0udASaNTFH3iTrT2/
	pQG9OiHBOSfzIJSSu4bcwc2gJCzk6t47L8B2JQBNm4y7AD7LIPi3ZjNwYqDtJKDM8BfKaPSthvl
	67wwt6Sh615al3g1YSmkjpU66DlRGnCQ=
X-Google-Smtp-Source: AGHT+IH2cu5soOXNx2mAgcBxxu/fcRxQgsouIVkHIcUGWSn3UVBG50dC7MCk8hM+8YSX7YQUgSpks7g0ZSO7OLqAPRk=
X-Received: by 2002:a05:6830:3508:b0:797:7375:526f with SMTP id
 46e09a7af769-797737554a7mr15306a34.3.1758631613948; Tue, 23 Sep 2025 05:46:53
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e221cef4-a26c-4f9d-ae5c-7dffa78b5e66@kylinos.cn>
In-Reply-To: <e221cef4-a26c-4f9d-ae5c-7dffa78b5e66@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 23 Sep 2025 14:46:43 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hshbbbTncpkZoS98jq+ChiARSZCNn5P8kaEduADbmHSw@mail.gmail.com>
X-Gm-Features: AS18NWAbO4yUnYMXGSnMg65n3bkdgeuwkt8M3Y_CpbjnEnGr1_54DhtYGp4a1BE
Message-ID: <CAJZ5v0hshbbbTncpkZoS98jq+ChiARSZCNn5P8kaEduADbmHSw@mail.gmail.com>
Subject: Re: [Question] About unnecessary policy_has_boost_freq() calls in freq_table.c
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J. wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	"zhenglifeng (A)" <zhenglifeng1@huawei.com>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 23, 2025 at 10:53=E2=80=AFAM Zihuan Zhang <zhangzihuan@kylinos.=
cn> wrote:
>
> Hi all,
>
> While reviewing the cpufreq code, I noticed that in
> cpufreq_table_validate_and_sort() the function policy_has_boost_freq()
> is still being called, even though most cpufreq drivers do not make use
> of the CPUFREQ_BOOST_FREQ flag.
>
> code in cpufreq_table_validate_and_sort():
>
>          /* Driver's may have set this field already */
>          if (policy_has_boost_freq(policy))
>                  policy->boost_supported =3D true;
>
>
> For drivers like acpi-cpufreq that don=E2=80=99t rely on CPUFREQ_BOOST_FR=
EQ
> flag, this extra check looks confusing and possibly unnecessary.
>
> Would it make sense to move this check into cpufreq_boost_set_sw()
> instead, so that the call is only made when boost is actually relevant?

First off, setting policy->boost_supported doesn't really belong to
cpufreq_table_validate_and_sort(), so the idea of splitting it off
that function sounds reasonable to me.

However, cpufreq_boost_set_sw() is used as a .set_boost() callback, so
it gets called every time the "boost enabled" setting is changed.  It
doesn't look like a good place for updating policy->boost_supported to
me.

