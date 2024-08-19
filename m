Return-Path: <linux-pm+bounces-12431-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 243D5956C45
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 15:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9BB61F220FB
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 13:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33CC16A920;
	Mon, 19 Aug 2024 13:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ji0ClNat"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEC5154C19;
	Mon, 19 Aug 2024 13:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724074670; cv=none; b=XmffOQ4r/7MKPTHocc5m9HtGsn5jsXdFiMCiU904nGsWcmxIx83Ln23ABeb67vt9rOeOOWaoJxYeku6GHlXJ2Wao+QdHnURq4lLTPZqTuKQ6eQBwUGHeipXtSy8pAKQ95hyzRSFkctYIMnMnsoCt2Q950iiFIrQprQ9qKx3sTKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724074670; c=relaxed/simple;
	bh=rVy1qRS0SJhSXR4vtZMoN+Tops67+Fjdn7Mv8qiD2p0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h6UlC/Vbyzx9I0DpiQ01zNyBBWCIPQixVUCKltyJN9JhNnoFnqLC2yIgpVm+ZTzG8XDtNs08SHVmaZG4VCPzX6wmP/S4KA5UyCpn+fwKxJe0vKjGCPGjVfDMlZly8NnQqLv7bH2KEceVb2lFAQCeluf7rEXVKH1blY5lQ+PbXOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ji0ClNat; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F76C32782;
	Mon, 19 Aug 2024 13:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724074670;
	bh=rVy1qRS0SJhSXR4vtZMoN+Tops67+Fjdn7Mv8qiD2p0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ji0ClNatEuxXJ1OHUuewm83Zq8m8+J34VRSEX+9UDaD+VW67+k7ng7awNu5zx5p+J
	 DqhqhRRMlDt6D+c2wUIqhNNmR172l974ROY1n5CmqZibNCm5iry4BKlVmPsbp7H674
	 ik6zgxVFSiZ0rmih5FEqgfcggDWoSf0rrOIfMBtWj1iWuJ/vZePG2gOmgW5zqkPedE
	 uhDQqgGLm7Z5AeiPnIEWF83VWCOUw+HWzT9ljbCWj5SQjjhILJQVR+0SrBVrV1lZos
	 A5OpK/sZmpU/HcwUreDsv+TGfCwvE5FMAQoOnkcdBVxaGjidJ2TBBbMqLZCXoJcyU3
	 7sfXp4xDtkqeQ==
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7093e583913so195019a34.2;
        Mon, 19 Aug 2024 06:37:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUd51t6tpteWUEHCHcmyNhlxJQPY4MLTcSH7JJKD/7TRUDplIS3BahDg1YHkYIwaAOQxjFnvDSKZQYG4foFZI36ay9IRo4n1lX69BpT2cwYQOKQRUhK9/lJNXvr5SA+fIDdTjGsULY=
X-Gm-Message-State: AOJu0YyUBIYxZWt7zAgUIObb4Fqmzk1H8SXt+l+fopxusVVhI+NYNomB
	t0wsJF9oEsLwtwx0JWE1Ccdh8IGJUPAbbOjh9MYgSgrHDQgpLdPXdG4cMMB/m/qmReiZHFkl7yi
	0+eOnDF6kSE314GspgkqsmluIy0s=
X-Google-Smtp-Source: AGHT+IHAGH62qOFRLR1D8gK4aIMko6ZL3c2yvs3npwd1+junyryE7t5K1rzRMHyoDSIsuL2/hYd3WwynnV7lYIEHiP8=
X-Received: by 2002:a05:6870:c6a1:b0:260:23bb:1087 with SMTP id
 586e51a60fabf-2701c0a67e7mr5742696fac.0.1724074669423; Mon, 19 Aug 2024
 06:37:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816113332.7408-1-sumeet.r.pawnikar@intel.com> <1b28d2bd9cecb2151bcbc9e4d8f81f79d4ca9f92.camel@intel.com>
In-Reply-To: <1b28d2bd9cecb2151bcbc9e4d8f81f79d4ca9f92.camel@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 19 Aug 2024 15:37:35 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ieaqVajc+X+XHcK8JMo0pYS3ofoW1_aaEdNZzc8dM+Gg@mail.gmail.com>
Message-ID: <CAJZ5v0ieaqVajc+X+XHcK8JMo0pYS3ofoW1_aaEdNZzc8dM+Gg@mail.gmail.com>
Subject: Re: [PATCH] powercap: intel_rapl: Add support for ArrowLake-U platform
To: "Zhang, Rui" <rui.zhang@intel.com>, "Pawnikar, Sumeet R" <sumeet.r.pawnikar@intel.com>
Cc: "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, 
	"rafael@kernel.org" <rafael@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 9:58=E2=80=AFAM Zhang, Rui <rui.zhang@intel.com> wr=
ote:
>
> On Fri, 2024-08-16 at 17:03 +0530, Sumeet Pawnikar wrote:
> > Add support for ArrowLake-U platform to the RAPL common driver.
> >
> > Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
>
> Acked-by: Zhang Rui <rui.zhang@intel.com>
>
> > ---
> >  drivers/powercap/intel_rapl_common.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/powercap/intel_rapl_common.c
> > b/drivers/powercap/intel_rapl_common.c
> > index 3cffa6c79538..3edf8decb811 100644
> > --- a/drivers/powercap/intel_rapl_common.c
> > +++ b/drivers/powercap/intel_rapl_common.c
> > @@ -1267,6 +1267,7 @@ static const struct x86_cpu_id rapl_ids[]
> > __initconst =3D {
> >         X86_MATCH_VFM(INTEL_LUNARLAKE_M,        &rapl_defaults_core),
> >         X86_MATCH_VFM(INTEL_ARROWLAKE_H,        &rapl_defaults_core),
> >         X86_MATCH_VFM(INTEL_ARROWLAKE,          &rapl_defaults_core),
> > +       X86_MATCH_VFM(INTEL_ARROWLAKE_U,        &rapl_defaults_core),
> >         X86_MATCH_VFM(INTEL_LAKEFIELD,          &rapl_defaults_core),
> >
> >         X86_MATCH_VFM(INTEL_ATOM_SILVERMONT,    &rapl_defaults_byt),

Applied as 6.12 material, thanks!

