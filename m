Return-Path: <linux-pm+bounces-27687-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C97EAC4FB4
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 15:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DF237AC830
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 13:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1CA26FD95;
	Tue, 27 May 2025 13:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPL1+zNz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21F47263B;
	Tue, 27 May 2025 13:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748352483; cv=none; b=eiSeajO0HFD408rzztrxyb25tGC4oNU9y5DVYCvYq7BG/+DxRG/0Ak3m5nVxBYdTx1UmhuOVY6WnOOBRzrPDhkKM4ZROVQ8aByg9BYcyU4yAVKx60MAgIjm0ywM7CBk9R7bYe/3obK//kxw7GzbN86phuT3fLF2NJD6oc5L6294=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748352483; c=relaxed/simple;
	bh=6n+ZjVHYJRruRP6QhiS37RnfCFSoYNr/NDgvQBN9BNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b4la8OBN2FTCM6mca5mMa6WDDcCBo2xaGDLvPUG1X8FlKCi2QwSqtzauUo+lkpwaY6Hdw13VK2jeN3GW60wI+chVR+pyAVU4zpwYioGZ711N/7bisU8Nn8ohx18bhh1wtOF91n3ZnIfFCqEijU6NBW/d7n81j5mZw9VzHizQKr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPL1+zNz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A6CC4CEEB;
	Tue, 27 May 2025 13:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748352482;
	bh=6n+ZjVHYJRruRP6QhiS37RnfCFSoYNr/NDgvQBN9BNE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kPL1+zNzo8eovVYJnZOxmhDr7c+ycetyKLvdsuHP2z27c5e9hktGSZxRbhN37wd5H
	 cSpcqe4MO/tXOQ/po6PSOoQ60Pb54GKunFW0kq+jyt0ckRC952ybdi06MSbUNQknVc
	 Cy2EwTIRQuhpDHnwPhSuikSzuMz6UWTbUKRJla3oohNL+/5XTgBSpbFuMuMMx5OgYf
	 kJFizpgXTDo34u2aiSla+rEPWGBWJMd0170QM7vBMSRFLVVRI/b+o7animPG1JYtGD
	 7Hbk7nr6fJtUCneLiDJ22cpxhvBUrsZHppE74oK9fVeFSuoQDDzG4RcM9gztacZ3X3
	 Fg/bcae0SpVEQ==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6066c02cd92so1478592eaf.2;
        Tue, 27 May 2025 06:28:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVCb+VSe4fxON+MnIjZaTy4tIwfuZQscZaBBwAEPLTpYHBJ9EGvp9Wt+tdKNOjQMdZD6W1XmjX8xDc=@vger.kernel.org, AJvYcCWCeq4ehTtoj6f01CpRYcrif792vZ6RDinF4FCTzPB07S50ve2paig2q4jcp2JiVDw0dCvIHkE9gAJ3J42y@vger.kernel.org, AJvYcCXD29hg/p/17oigJvP6k9cU0KQs1HUKp6onhfpkeo6/3ok4C9Mud6RcnGeSsBrqiDkXyHMuSi3ZpwUkUMgZXcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyuNq/QeUAHOlOGaz8PFphKsBdhI5yXg0gjZ+ZapsKvMifaS4/
	RiEAq3ENxjCOStnVgR/mCzdkduh5j9K2DGO75gAq9XVJX4KJOdpoWntcfccjwYKiQGF1dbZRPyl
	+ASm3NXiRh06KJyc1+QjR+diuLoTQhA0=
X-Google-Smtp-Source: AGHT+IFSAqGTRonCyHdzPHXzUnwF15GbCmScNUgBEQdqAtxS6EgzRVvQOgQAmShq5ZmtIno7kTA0NkVHIzzSEu9IsCQ=
X-Received: by 2002:a05:6820:270c:b0:60b:c7bf:5ff4 with SMTP id
 006d021491bc7-60bc7bf6141mr2188782eaf.2.1748352481726; Tue, 27 May 2025
 06:28:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aDVRcfU8O8sez1x7@stanley.mountain>
In-Reply-To: <aDVRcfU8O8sez1x7@stanley.mountain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 May 2025 15:27:50 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jAJN0dAHyUcpD1QvqZO36OmpGS2HpoRNkgG_-vNhO6tw@mail.gmail.com>
X-Gm-Features: AX0GCFvDe7KgMteLqE5TkkcwRDYFaq8UOCj-peIRP-B2k_1-cXP7CZdFbN1z-YU
Message-ID: <CAJZ5v0jAJN0dAHyUcpD1QvqZO36OmpGS2HpoRNkgG_-vNhO6tw@mail.gmail.com>
Subject: Re: [PATCH next] cpuidle: psci: Fix uninitialized variable in dt_idle_state_present()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 7:45=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> If the first cpu_node =3D of_cpu_device_node_get() fails then the cleanup=
.h
> code will try to free "state_node" but it hasn't been initialized yet.
> Declare the device_nodes where they are initialized to fix this.
>
> Fixes: 5836ebeb4a2b ("cpuidle: psci: Avoid initializing faux device if no=
 DT idle states are present")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/cpuidle/cpuidle-psci.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psc=
i.c
> index 3c2756a539c4..4e1ba35deda9 100644
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -456,14 +456,13 @@ static struct faux_device_ops psci_cpuidle_ops =3D =
{
>
>  static bool __init dt_idle_state_present(void)
>  {
> -       struct device_node *cpu_node __free(device_node);
> -       struct device_node *state_node __free(device_node);
> -
> -       cpu_node =3D of_cpu_device_node_get(cpumask_first(cpu_possible_ma=
sk));
> +       struct device_node *cpu_node __free(device_node) =3D
> +                       of_cpu_device_node_get(cpumask_first(cpu_possible=
_mask));
>         if (!cpu_node)
>                 return false;
>
> -       state_node =3D of_get_cpu_state_node(cpu_node, 0);
> +       struct device_node *state_node __free(device_node) =3D
> +                       of_get_cpu_state_node(cpu_node, 0);
>         if (!state_node)
>                 return false;
>
> --

Applied, thanks!

