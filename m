Return-Path: <linux-pm+bounces-33313-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF26CB3A5DC
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 18:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DA7E561A76
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 16:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE4E2D6407;
	Thu, 28 Aug 2025 16:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnciu72V"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3543823B61B;
	Thu, 28 Aug 2025 16:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756397619; cv=none; b=lu2sr86u+nSzBPlrr+huRvh5poIwYYNh095f0UEX4s6jua7CJixxb72Qqgmfzkw/vZyfmpRXhO232NngXouGy3DQcIhMg8KMydbE3Wafb1+rwq3x/7YztWi8CiVj3PCOr7lJYPr+RE++LatJO2xW/8+OhJoIwNNI/pC0mCMDEOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756397619; c=relaxed/simple;
	bh=RDJvXt0gHoOuSxP+lJjqy7yfVQ6BnAWOklvP4EWrXqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q2nGkwsLLQAk9Z9YBFOs/75lJRhlxgot6RRSRk9MLzPUvpu3JYJx1EFrBd5lPnHaQ4atEf6881hZ6Ywx9uz/AE673DcKb4oylNfp6X5m3n8UbTTmf728/DM4e1vqEm4s56mWewKvo1/mZyWfUaxHHZenquUFUnA86hAe1bitPA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnciu72V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C08C4CEEB;
	Thu, 28 Aug 2025 16:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756397618;
	bh=RDJvXt0gHoOuSxP+lJjqy7yfVQ6BnAWOklvP4EWrXqo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mnciu72VRwBeos1UdgZI0CSoArAtKb4+qQxEjGI67WUwf9q0pANwo8/eTsCV0Wc0A
	 WmfoJjYw0m3NVqE7gSzkx06BmuTepMH6WMFc89ERwzcy0pU3zK55sW2Y9Fb5Ml+dmc
	 Tr8n8kN8DSCf24w8C/frerbRwJvqsTtY0nqQ9ct/0QFMJVDTQZKxy2M3afbWI8oaAF
	 /Whazu8Xmo7SyH2Bif9c8zDnPPg8Ot+O347lLVv1sOi2EJwollZjzgGYuvEtths0t7
	 7zCsunf4atngdzscG4zGcgL5hpxiQQ3/+bvzmMi8YSjzPkZ0fkLmWGVGEjsODu8DF9
	 33i1/2Jb51Tdg==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-30ccea94438so871371fac.2;
        Thu, 28 Aug 2025 09:13:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXeGebe6E53yhVopisVq+otfwRWB7mVGb26WLN/svges0Y3ITDB3qO4gtqpE9S0LEgTfN5CN9cl/7bcIdw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7UJrzbYrNo1BRHHlKK7avnQb2+UJc+9rhAa9+Ytvd9pQSUzeO
	AkSan0NpNIbzyJBJ6TBFRhQ4PXzsFm+YgBCIl7Byw02Ih6ZxzORGm8q23A58LPWR1cmxDtvTGZR
	ChZ1ZnXRca5cz17DciVYdgKWirUnY8ho=
X-Google-Smtp-Source: AGHT+IEgT+W9iIpK4oA2lHxw/ap8HkJip0M9BUV5YEGoXypRtQm1T9qZ+IifWC26ZsfEtn210buM3MFAW90tm940nEA=
X-Received: by 2002:a05:6871:314c:b0:315:9a70:9cea with SMTP id
 586e51a60fabf-3159a709f97mr1577222fac.10.1756397617952; Thu, 28 Aug 2025
 09:13:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <724616a2-6374-4ba3-8ce3-ea9c45e2ae3b@arm.com> <CAJZ5v0gGchbaQWRq39JbrX8chca7uefef763coJeup+vUOfyCw@mail.gmail.com>
In-Reply-To: <CAJZ5v0gGchbaQWRq39JbrX8chca7uefef763coJeup+vUOfyCw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 28 Aug 2025 18:13:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h=OG-wgcZBD8mZ51+kb7j3yeDZQt9XfO=fdasLRgQkEg@mail.gmail.com>
X-Gm-Features: Ac12FXwk4apAy_3bRye5EWVBMxU_GQpslLu1N4CI4UKrQJqqZYIRMylLwmBeKT4
Message-ID: <CAJZ5v0h=OG-wgcZBD8mZ51+kb7j3yeDZQt9XfO=fdasLRgQkEg@mail.gmail.com>
Subject: Re: [PATCH] Revert "intel_idle: Rescan "dead" SMT siblings during, initialization"
To: Christian Loehle <christian.loehle@arm.com>
Cc: linux-pm <linux-pm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Content-Type: multipart/mixed; boundary="0000000000001a692d063d6f30c8"

--0000000000001a692d063d6f30c8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 4:44=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Thu, Aug 28, 2025 at 4:26=E2=80=AFPM Christian Loehle
> <christian.loehle@arm.com> wrote:
> >
> > This reverts commit a430c11f401589a0f4f57fd398271a5d85142c7a.
> >
> > Calling arch_cpu_rescan_dead_smt_siblings() in intel_idle_init with
> > boot parameter nosmt and maxcpus active hotplugged boot-offline CPUs
> > in (and leave them online) which weren't supposed to be online.
> >
> > With the revert and nosmt and maxcpus=3D12 on a raptor lake:
> > cpu     online  capacity
> > cpu0    1       1009
> > cpu1    0       -
> > cpu2    1       1009
> > cpu3    0       -
> > cpu4    1       1009
> > cpu5    0       -
> > cpu6    1       1009
> > cpu7    0       -
> > cpu8    1       1024
> > cpu9    0       -
> > cpu10   1       1024
> > cpu11   0       -
> > cpu12   1       1009
> > cpu13   0       -
> > cpu14   1       1009
> > cpu15   0       -
> > cpu16   1       623
> > cpu17   1       623
> > cpu18   1       623
> > cpu19   1       623
> > cpu20   0       -
> > cpu21   0       -
> > cpu22   0       -
> > cpu23   0       -
> >
> > Previously:
> > cpu     online  capacity
> > cpu0    1       1009
> > cpu1    0       -
> > cpu2    1       1009
> > cpu3    0       -
> > cpu4    1       1009
> > cpu5    0       -
> > cpu6    1       1009
> > cpu7    0       -
> > cpu8    1       1024
> > cpu9    0       -
> > cpu10   1       1024
> > cpu11   0       -
> > cpu12   1       1009
> > cpu13   0       -
> > cpu14   1       1009
> > cpu15   0       -
> > cpu16   1       623
> > cpu17   1       623
> > cpu18   1       623
> > cpu19   1       623
> > cpu20   1       623
> > cpu21   1       623
> > cpu22   1       623
> > cpu23   1       623
> >
> > Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> > ---
> > Rafael, I don't immediately see how to fix this properly so I won't
> > try to, feel free to treat this as a bug report.
>
> Sure, thanks for reporting this!
>
> Well, I think that cpuhp_smt_enable() is missing a check.  It looks to
> me like it should do the topology_is_primary_thread(cpu) check like
> cpuhp_smt_disable().
>
> I'll cut a test patch for this later.

Something like the attached one, perhaps.  I haven't tested it yet,
but I'll do that later.

--0000000000001a692d063d6f30c8
Content-Type: text/x-patch; charset="US-ASCII"; name="kernel-cpu-enable-smt.patch"
Content-Disposition: attachment; filename="kernel-cpu-enable-smt.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mevlqqj80>
X-Attachment-Id: f_mevlqqj80

LS0tCiBrZXJuZWwvY3B1LmMgfCAgICA3ICsrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2Vy
dGlvbnMoKykKCi0tLSBhL2tlcm5lbC9jcHUuYworKysgYi9rZXJuZWwvY3B1LmMKQEAgLTI3MTAs
NiArMjcxMCwxMyBAQAogCWNwdV9tYXBzX3VwZGF0ZV9iZWdpbigpOwogCWNwdV9zbXRfY29udHJv
bCA9IENQVV9TTVRfRU5BQkxFRDsKIAlmb3JfZWFjaF9wcmVzZW50X2NwdShjcHUpIHsKKwkJLyoK
KwkJICogQXZvaWQgYWNjaWRlbnRhbGx5IG9ubGluaW5nIHByaW1hcnkgdGhyZWFkIENQVXMgdGhh
dCBoYXZlCisJCSAqIGJlZW4gdGFrZW4gb2ZmbGluZS4KKwkJICovCisJCWlmICh0b3BvbG9neV9p
c19wcmltYXJ5X3RocmVhZChjcHUpKQorCQkJY29udGludWU7CisKIAkJLyogU2tpcCBvbmxpbmUg
Q1BVcyBhbmQgQ1BVcyBvbiBvZmZsaW5lIG5vZGVzICovCiAJCWlmIChjcHVfb25saW5lKGNwdSkg
fHwgIW5vZGVfb25saW5lKGNwdV90b19ub2RlKGNwdSkpKQogCQkJY29udGludWU7Cg==
--0000000000001a692d063d6f30c8--

