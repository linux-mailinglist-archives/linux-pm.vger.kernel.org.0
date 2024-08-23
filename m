Return-Path: <linux-pm+bounces-12830-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0580795CE52
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 15:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 955FCB21463
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 13:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2569A18858D;
	Fri, 23 Aug 2024 13:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmBJaGQD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFD9188005;
	Fri, 23 Aug 2024 13:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724420891; cv=none; b=Wc3hVrKJoJ3tsxMmoQvhDrO4HBHXKkoWa8wqibVtEDUKlEiim9DtsG++QhSN+mgH3PucrrEdj68YlRiCzoLR/VN97V2c40OwnIDlE6jlRPZ7kTyLIs2wbrfU6/KkDvIRbOplXcS8JU94qF+MoI/PJFkTHSlHQ8WTG2eV54uDFZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724420891; c=relaxed/simple;
	bh=crE7eg+oJ5Pe8wnaFLMXkKVXJtV0r+sYAkypoHKXQQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p9hsjdp3nP99KTyv+QdHodJ9VNNUokIHPjEh+/+LJ8T4mBBqaPS/k1eIflTHpiE+6XnwX6IaSzleM+tc1h4lvb12rZa8tAvbfSB65BoVeB4XerLROweatoZp/uQb8FY/N+WcQM+FWp//LnxR4yojK7ixM41Ny/ZEkXc508KMnyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmBJaGQD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC10C32786;
	Fri, 23 Aug 2024 13:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724420890;
	bh=crE7eg+oJ5Pe8wnaFLMXkKVXJtV0r+sYAkypoHKXQQs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mmBJaGQDWHLlGdpQZMDaff8qyvhbkiSg+EuK0SbPKT9MogonlWUVC0B8T8MnQstuL
	 S9O58ljRSuLBo+ZRDTtuJZ1kDhjRIKDedLUlxtqhM/OOBM6eePLQer3nWaquUpctyT
	 Z6f8w7zsiik/mxl5fPMx56/8WQ6t82I5PTuZs0Qx5Ru4x1ORo2aGHi0hJSFz3wb4v8
	 HOFu+sBKRAj8A1oPLz/8SLDbQKe1b4TmPlB2wwNEHDT17Ud1J1Re0zW1ng9G3maclo
	 XQt9DUwuqetzIiSQ11fmIf5aCrhhV1oIWdsbznUdfXUjAnSAbgpJC1yYL46LD0ktfS
	 OknAdF1loMgtg==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-268eec6c7c1so1377167fac.3;
        Fri, 23 Aug 2024 06:48:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU75usVkK2ZVG6dzfNtz1Uy8UciF0v0RTbDwR/7NS1xvcLAspOgJpS8uRfelz+lkKSzHAp1qxppVi+4jxgFAes=@vger.kernel.org, AJvYcCXtU0N6fBVo3zCWHd7mU5Zx7g5JAaO3l5dlflKfFkMGLesA36STz0GHrhS4Lxp+hzA6B2kqk6F5jiY=@vger.kernel.org, AJvYcCXykyacmKWETq8/7A/ysU+wsrv1K00IcrAebz0wBvSr5Va5801xXV1vywI7bZPOIhrIPMcSAI1vlfvV4Lcx@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6zmB/5HIgQKCloS+jeN1s4RD2Z1jzH233VZU6qd8DnTwMQ0gu
	zswv73rQ+yGOgJqk2BSoWWSEB2iQ5907CYaptjp/7KT0o/BnEdcjadszoom0RLpTuOD5IZcJMpZ
	FMtRGfkp8wSaXWMmIuoLQYhfw7yI=
X-Google-Smtp-Source: AGHT+IEu0D6hq/lsydItFebNJCZhwrDgT2WK9OU/y6HJagCTafzNVTShJ7evITYTte9QASr5sdkqrNoQe0hO8UPYNzk=
X-Received: by 2002:a05:6871:706:b0:268:a074:39cf with SMTP id
 586e51a60fabf-273e641fa92mr2479445fac.8.1724420889823; Fri, 23 Aug 2024
 06:48:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fa719c6a-8d3b-4cca-9b43-bcd477ff6655@stanley.mountain>
In-Reply-To: <fa719c6a-8d3b-4cca-9b43-bcd477ff6655@stanley.mountain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 23 Aug 2024 15:47:57 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iti+wbiKBPKMpJ_nDRLCW5ZyKsjZJ6OSbVB_ih3RCwBQ@mail.gmail.com>
Message-ID: <CAJZ5v0iti+wbiKBPKMpJ_nDRLCW5ZyKsjZJ6OSbVB_ih3RCwBQ@mail.gmail.com>
Subject: Re: [PATCH next] powercap: intel_rapl: Change an error pointer to NULL
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 2:51=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> The rapl_find_package_domain_cpuslocked() function is supposed to
> return NULL on error.  This new error patch returns ERR_PTR(-EINVAL) but
> none of the callers check for that so it would lead to an Oops.
>
> Fixes: 26096aed255f ("powercap/intel_rapl: Fix the energy-pkg event for A=
MD CPUs")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/powercap/intel_rapl_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/inte=
l_rapl_common.c
> index d110c5da5cfe..2881687d7900 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -2157,7 +2157,7 @@ struct rapl_package *rapl_find_package_domain_cpusl=
ocked(int id, struct rapl_if_
>                       topology_physical_package_id(id) : topology_logical=
_die_id(id);
>                 if (uid < 0) {
>                         pr_err("topology_logical_(package/die)_id() retur=
ned a negative value");
> -                       return ERR_PTR(-EINVAL);
> +                       return NULL;
>                 }
>         }
>         else
> --

Applied, thank you!

