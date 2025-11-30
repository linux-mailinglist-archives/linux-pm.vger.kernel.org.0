Return-Path: <linux-pm+bounces-38924-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 06164C94B87
	for <lists+linux-pm@lfdr.de>; Sun, 30 Nov 2025 06:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 85456343F4F
	for <lists+linux-pm@lfdr.de>; Sun, 30 Nov 2025 05:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A4B21E082;
	Sun, 30 Nov 2025 05:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzbO+NaE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DC4212FB9
	for <linux-pm@vger.kernel.org>; Sun, 30 Nov 2025 05:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764480441; cv=none; b=q5aBb+psIX8ZzD/Zc3e8ZsHrH1hLmP4edtF0s6AQjPHr/POeuN44oYZOrEnHdeZadWh00uqIB5m41JkK9z2SYt1/r8hReNk6pYvdd3I2BavJs7mN9Iw5jvDBeGekxDMSuaT/s3gKDfsYfbiQp52wo8y+6Qqiuvh3Ca4IOxpgL34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764480441; c=relaxed/simple;
	bh=VAVyHSpca8Z58pvC1Yy7myjBeHrbjXjeXWFK/UXtdKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TR++tV43/DgapIfD3nQf4vJFHs3ismNLLgBBMHTsJbqxJBwKLVdIHk7QCqHBomVTP+vevi/pMh8S6jk+1mor6T9LqS6/I7sKTyZFUT51FQ60pOFXPrBjlaQKrjaqzItR8zZi1II/2x/+XxQJOdK5BDqQwqLfdWMUIhCsxnOPLEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzbO+NaE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A83C19421
	for <linux-pm@vger.kernel.org>; Sun, 30 Nov 2025 05:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764480440;
	bh=VAVyHSpca8Z58pvC1Yy7myjBeHrbjXjeXWFK/UXtdKM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kzbO+NaEf6FQocKdsciIJSzh5IOwQXzYvu+66qBqmTtKyumEsjHl5n2NUbA71NNtV
	 bqq2RoEPBZ3wlZVyth9PMwbixM4O+WipHWANL0dHOMc+TdLkzQ+0ZALIH7K6rvCZnp
	 iW2SVILkQ0jglUDux9Ku7pFtRFG2r68HhrlTIiI7dRqD2shOV3y1To8ScXvyaj5EiV
	 7t9VFyM1xj2g7gzWAWYiL8/JEtTXusFQ4HQnCjx4v2beopWn9TShW8jCrkorjGpG9H
	 mPepFwUNsl81YxgknDquUqjqy4ddHIfkqBcN4kkp6QVie3O0p/wohiABHR7v+WGGaF
	 +5zSkM13s7/uQ==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-3e3dac349easo1871590fac.2
        for <linux-pm@vger.kernel.org>; Sat, 29 Nov 2025 21:27:20 -0800 (PST)
X-Gm-Message-State: AOJu0Yxk2P06gWEQCyF6E2GynW6R9kDQwwtWQlbMeP637ojV1KZxAjlf
	OobrGOHTHgYoH4PibWGofiiYFLw2Ns+da3UbNx5shx2TVdtTyii+SHtNsZuVQt7mr6DeAVVFgGF
	T4E9Xka0OTs/UliR2l+9TT7Bphb9cgk0=
X-Google-Smtp-Source: AGHT+IH5+Sc8lS/8IvZKnG3Vf9xMC79yMlTsu9CurXlmV4cwkw6MxDT4TnZvdrvFIaUwIRM2TJVQy5hClORkgoB3tvE=
X-Received: by 2002:a05:6808:6f84:b0:450:c49f:9a38 with SMTP id
 5614622812f47-45115995a6emr14564050b6e.17.1764480440055; Sat, 29 Nov 2025
 21:27:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113191609.28574-1-ehemily@amazon.de> <20251113191609.28574-2-ehemily@amazon.de>
 <CAJvTdK=_v9q2eGMB6qG3iaDhXMzQHz-EJ4NeDEfBe2fbv+wKfQ@mail.gmail.com> <BEYP281MB5509D3D7A01DEC1FAAEB9DBDBADCA@BEYP281MB5509.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To: <BEYP281MB5509D3D7A01DEC1FAAEB9DBDBADCA@BEYP281MB5509.DEUP281.PROD.OUTLOOK.COM>
From: Len Brown <lenb@kernel.org>
Date: Sun, 30 Nov 2025 00:27:08 -0500
X-Gmail-Original-Message-ID: <CAJvTdKnjreryLA9KuuobwJShbVseHOyujmXBAXRuSUDsCZxSVA@mail.gmail.com>
X-Gm-Features: AWmQ_bml1oVL0eKzdparYdSoLT_jY79yQzST4p-PLvM2atSWa-bVaoYLi3eLiD0
Message-ID: <CAJvTdKnjreryLA9KuuobwJShbVseHOyujmXBAXRuSUDsCZxSVA@mail.gmail.com>
Subject: Re: [PATCH 2/2] tools/power/turbostat: Fix division by zero when TDP
 calculation fails
To: "Ehlert, Emily" <ehemily@amazon.de>, "Zhang, Rui" <rui.zhang@intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Emily Ehlert <ehemily@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 9:00=E2=80=AFAM Ehlert, Emily <ehemily@amazon.de> w=
rote:
>
> We are running turbostat inside a VM on the AWS Nitro Hypervisor.
> Guests are not provided with any power measurements. So reading the
> MSR_RAPL_POWER_UNIT will read 0. Since turbostat expects working
> RAPL for this CPU family, failing to read them leads to an exit (because
> setting the the timer fails). I agree that the patch should disable RAPL
> not after TPM but after the RAPL_POWER_UNIT MSR read.
>
> I am not experienced with the way turbostat uses the BIC counter macros.
> It seems like these are mostly used for enabling / disabling individual c=
ounters?
> How would I go about using them to disable RAPL in general without affect=
ing
> other MSRs such as CPU%c1 which we can and want to read? I would apprecia=
te
> some pointers or rough outline on how I can approach the issue.

Thanks, that is helpful.
I think we agree that this check should be earlier.

In this scenario, we want to override platform->rapl_msrs -- clearing it be=
cause
the MSRs are not actually available...

I cut a patch to replace all the tests of platform->rapl_msrs with a
global variable
that was initialized to (read-only) platform->rapl_msrs, but was
cleared before the test
in rapl_probe_intel(), and when I run with --no-perf (so that
turbostat must use MSRs)
it seems to disable all the RAPL stuff cleanly.

So the question becomes what test to use to determine that we should
not believe platform->,
and we should instead nuke RAPL support?

Once upon a time we used to actually probe the RAPL msrs by trying to read =
them.
If they failed to read or were zero, we would fail the probe and
disable the couter.
But that turned out to be problematic b/c some platforms had non-zero
unsupported MSRs etc.
so we moved to hard-coding the platform capabilities in a table.

In the VM, does the MSR read fail entirely, or does it just return 0
values for unsupported MSRs?
thanks,
Len Brown, Intel Open Source Technology Center

