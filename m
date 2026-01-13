Return-Path: <linux-pm+bounces-40730-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (unknown [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD72BD18AF9
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 13:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49236305CA1C
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 12:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E375938BDD7;
	Tue, 13 Jan 2026 12:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVnJwR7H"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE739389DE6
	for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 12:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768306840; cv=none; b=uJu7I5o8fbwz6PFhCw9NYln1izxT0fQGRq7GAyalhRwpnvNw7jaiAHqO49fOHLWSbd9HvfRsY115smnD2XiucuBkjOjWFSIsHPV5D6aO0Mj70zTcJBsfTNqMR9xIYfb3HHRAz+J8FfVzt8BQpRogenX6i/7U/lepbDmAb8/Zvjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768306840; c=relaxed/simple;
	bh=P5gRgjefKtxc1aH7ygniSpxvkeuNAZon7uiHFBTNfLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TMJg0/o4AMEYSgq+IX4YHfOawbKrKRpQKoAv449zR5kG2wAjjmaL1fSgoUL28YsFtgryd71Jwkul1HlbRsbJZSl9v5qxPgOhedj9EXXpnG4aJDFc4UUpWAN1yh3HHgpbP2TVPwNHNt00LZ4PWYYy251/unXszJHxPJGbr4nRtJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVnJwR7H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72087C2BC86
	for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 12:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768306840;
	bh=P5gRgjefKtxc1aH7ygniSpxvkeuNAZon7uiHFBTNfLk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bVnJwR7H9V/cwcKhocBMl+Uv9JjIQrf/RIzAR+CRBVfUc3lPrH5W8+hLNyJ50quKN
	 cTEsXJBGkv1fNU+DlyQrl0ERkC2GZCzrvmlBNvDtDpLK/vtisj4tdfZ0XUbcoTRLgo
	 gAivTs+EjeeGQcnRlfftDFOgHtY6+f8hYpONDM0MhmRAqLQSgK+GNIG+aeKjahiB19
	 hodTDsNND0JKjE9I+rSnt3LLvaCkmCFVNYPQm1mUUd6c7i44KWnG9dZI5CGBjzK8N3
	 pqf5IGQn/EmC++IlTGN4dN3SjWuxS1rdcC0w/ovZ9ikx329QNAfvWs3g97MVWyeJ+d
	 5jOhqezz4ImXw==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-3eae4e590a4so3988332fac.1
        for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 04:20:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVF42zxjZONJMtfjH+D5wdA+T9wSSarPi1iBsUA8u2vIqL3X6RnF7IScdxEMFmwfLYBvsixZpP+RQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcLDV/C23qAfeF9UG1vH7CUd8WAe1QbA/v0s93KURnbfm6PrPC
	3c6Dz7saHxDLkulH7dBzzb89suokBreunefZGAyMEXN4qyV3hmk2tUc0iDlqhOvX8V5FHRhKeCO
	gFlGt3vWcQ7U9OqnpGaHRhwUod0BrN/8=
X-Google-Smtp-Source: AGHT+IHoHHswB0bVkCSVKzHdrbnFeXCS9yy3/hfy5Eulu9pNx1Cz2rjiMCc7RqeNuiOhPLmwds/LdiOjW2+YzvmJ/w4=
X-Received: by 2002:a05:6870:3353:b0:3f5:b004:314e with SMTP id
 586e51a60fabf-3ffc0b5e85bmr11243280fac.46.1768306839476; Tue, 13 Jan 2026
 04:20:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208105933.1369125-1-pierre.gondois@arm.com>
 <20251208105933.1369125-4-pierre.gondois@arm.com> <14ad55ce-413f-46e0-9ce0-f35fc421056c@huawei.com>
 <73da1186-5edd-4465-bd49-e18d9064a501@arm.com> <ea9111b5-cd85-4526-a959-54d8037d6ffb@huawei.com>
 <36630a40-b6e6-4bf6-8fa1-1a004e0d2798@arm.com> <ppzoeb4wod6jjhlvkiqogcd26v3shfh5cjiuq63r7bbnsyzzok@sdx5usgvcqzu>
In-Reply-To: <ppzoeb4wod6jjhlvkiqogcd26v3shfh5cjiuq63r7bbnsyzzok@sdx5usgvcqzu>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 13 Jan 2026 13:20:26 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hZMSWxd6u0ZpPosDu9j0ibYeGyqRRqnaiVBNcA1kmPXA@mail.gmail.com>
X-Gm-Features: AZwV_QgdeeU0Yff2EnrYzP1j2Dyq3O3JKtZW7aYcABbvmdqvht5oWdMXfxIKwkk
Message-ID: <CAJZ5v0hZMSWxd6u0ZpPosDu9j0ibYeGyqRRqnaiVBNcA1kmPXA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] cpufreq: Update set_boost callbacks to rely on boost_freq_req
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Pierre Gondois <pierre.gondois@arm.com>, "zhenglifeng (A)" <zhenglifeng1@huawei.com>, 
	linux-kernel@vger.kernel.org, Christian Loehle <christian.loehle@arm.com>, 
	Ionela Voinescu <ionela.voinescu@arm.com>, Jie Zhan <zhanjie9@hisilicon.com>, 
	Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 2:30=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> On 12-01-26, 16:02, Pierre Gondois wrote:
> > In:
> > cpufreq_set_policy()
> > \-cpufreq_driver->verify(&new_data)
> >   \-cpufreq_verify_within_cpu_limits()
> >
> > the requested min/max values are clamped wrt the cpuinfo.[min|max]_freq=
.
> > However this clamping happens after the QoS constraints have been
> > aggregated. This means that if a CPU has:
> > - min =3D 100.000 kHz
> > - max =3D 1.000.000 kHz
> > - boost =3D 1.200.000 kHz
> >
> > With boost enabled, the user requests:
> > - scaling_min: 1.100.000
> > - scaling_max: 1.200.000
> >
> > If boost is disabled, we will have:
> > policy->min =3D=3D policy->max =3D=3D 1.000.000
> > without notifying anybody.
> >
> > Ideally I assume it would be better to prevent the user from disabling
> > boost without first asking to update the scaling_[min|max] frequencies,
> > or at least detecting this case and have a warning message.
>
> I don't think this is a problem and doesn't really need special care.
> It is the user who is disabling the boost feature, its okay to force
> set to clamped values.
>
> > Please let me know if you prefer not adding the new qos constraint,
> > I ll try harder not to have it if yes.
>
> But even with that (the issue pointed earlier not being a problem), I
> think a new constraint for boost does make the code cleaner and easy
> to follow.
>
> Rafael ?

I agree.

