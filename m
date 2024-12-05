Return-Path: <linux-pm+bounces-18626-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D82409E5979
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 16:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F14D1885187
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 15:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8063721C9F2;
	Thu,  5 Dec 2024 15:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="AMFR03pa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2ED21A44B
	for <linux-pm@vger.kernel.org>; Thu,  5 Dec 2024 15:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733411587; cv=none; b=vFoMyRwrBUy3MzsTEzkxCJljuHeGX/GQQAwCnLrPbwou+/FCql0x/OjxEUtdWUpjh09GtpKbr7r/uZ0qyyttH9H7/Hm1qCoRxcXGrHJzeIeG8gGbCQKj0k4d1c2KeP88kmg/ZKYhFn+EDtfnigUl1w0YXQnEe4FAka8uW8ucLEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733411587; c=relaxed/simple;
	bh=3weUk4iB77O9B3Vu+VdOtyHO5IHEoisW4SItE5WMi28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QZJ6v3wNgBPawTlsvU9xpn+cVV9tHp0dmnlVlJqv2SkOxP1EShY2wgoPFnGrEM9at/va52gEh2nv+m+zye2S6Npz7P3YQMmaQEw4ZKLwPnXJkk3q1tSkKcIKcVbUS/t3T/Jr9CZ48AEVF3arnWU84cd/Wh9HIwxzgdgNkZw2Wa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=AMFR03pa; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ffc3f2b3a9so9409061fa.1
        for <linux-pm@vger.kernel.org>; Thu, 05 Dec 2024 07:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1733411582; x=1734016382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xoG8I2gOfAa1nhpr3MtzTH/bpYIZ43v6YhQ9f0tgVvU=;
        b=AMFR03paJTo3Mt/jpJPjsi+PGpQD0af8XtUaAuhaaUT6IxZUuwm764x8EbxEcOaOSp
         ZS28y5Q1ceejuLT/r1ElwOD/IGR9DbBQO5XZpgdQokholZO07EDlYFLpoY303WsjHPEN
         nZkT0se7qMByYrvjLedUP2ljzif/N7jYRcP1RTBeQFFUp6+MrFvfp8+uW3jLHlbdxUmo
         jmi0t9sWPjrryi85QJaAb4MX3u9NY28qxzwq6O9WmAtYuk+MdkUCIq0iIn8fKI0sBH2J
         N5Q1OHFqbbyTjxBzdrlFyXCPara4xYAWGCItIpP13EASblQrn1bcEslURHJ6UKzQYqWI
         f53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733411582; x=1734016382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xoG8I2gOfAa1nhpr3MtzTH/bpYIZ43v6YhQ9f0tgVvU=;
        b=QWE8WzS4F/wvsuNaZiKg9I8ejz9ooH2/kNNY9wrdVyKdxnZI4R0X6sMlDNveFTMsin
         o6AkEi1MdJNb9w5mWaCVi8Dp8bzXQui/wj9zt/ZZQpEFtMirtS3zOlQYR5PqmRw3vZ/0
         FnAwZMz5tGO74J8GQ8X59Dr54fBP5YaIG1BGVk2NCcFU2jdoe3SSCmk+BgKrXIOgwQZt
         8lqbWDcpuxSgvxnX2Gyywh7R10xFrpV6mAe3tnkKtY2p/VLAtGkFe3Lt6HJjphP2k70I
         VzFJ/+ZCUqxP9MPWfLCrVHidGKREibj/1zKQUOjIHErw7YZYYEzp438NGkUqEwbi03lR
         AGvw==
X-Forwarded-Encrypted: i=1; AJvYcCXYwRvEeDJkgiX6vMfv48sPXSrnZVXyFs5D9+MBf0072eopRfJlJ6GtNu1hhT3iT6qVHPOWWMDZmw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2NQMpOiEr8HyV1cPHVDTTFRHLWwo6CpEt9R58jhMGWCPMhPmM
	gvC+BCARePjvWkzrTKBsPNMntqayUi8HXkFvrCkn6nrOOWxCL4zGcb1UGUTG+YCO7m4P5idCPgr
	/wfpDg4GxLmL+LovXf1pS8bhBTYGbWQ37DqUa3A==
X-Gm-Gg: ASbGnctCG0wL4nF8qFIsoUlYR02gC2HBkpBxh5EeFZG/Gpy5mpOP1wK6AVYLF0HcseP
	uD4lsHIuoTz1/9RH1XtEAqcMliRCu78HIcA==
X-Google-Smtp-Source: AGHT+IGH/8TdnaDUdGz4vg1jz4T+IjoxlkEVgzEnW/Whszlzb3/tE/OJ68+7OcMZC/v7h9xiQOOLAepDgrXh5t82PkQ=
X-Received: by 2002:a2e:9907:0:b0:300:16c0:9ba with SMTP id
 38308e7fff4ca-30016c00c13mr33128631fa.31.1733411582083; Thu, 05 Dec 2024
 07:13:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116-cpuidle-riscv-sbi-cleanup-v3-1-a3a46372ce08@gmail.com> <eee10593-eb0b-4660-80cf-3027d6a99435@ghiti.fr>
In-Reply-To: <eee10593-eb0b-4660-80cf-3027d6a99435@ghiti.fr>
From: Anup Patel <apatel@ventanamicro.com>
Date: Thu, 5 Dec 2024 20:42:50 +0530
Message-ID: <CAK9=C2W3uxt9aO7NbCfzi6zdp14W_MXvOn2MtGqfzwX89J5aUQ@mail.gmail.com>
Subject: Re: [PATCH v3] cpuidle: riscv-sbi: fix device node release in early
 exit of for_each_possible_cpu
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, Anup Patel <anup@brainfault.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Atish Patra <atishp@rivosinc.com>, 
	Palmer Dabbelt <palmer@rivosinc.com>, linux-pm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 8:10=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> wrot=
e:
>
> Hi Anup,
>
> On 16/11/2024 00:32, Javier Carrasco wrote:
> > The 'np' device_node is initialized via of_cpu_device_node_get(), which
> > requires explicit calls to of_node_put() when it is no longer required
> > to avoid leaking the resource.
> >
> > Instead of adding the missing calls to of_node_put() in all execution
> > paths, use the cleanup attribute for 'np' by means of the __free()
> > macro, which automatically calls of_node_put() when the variable goes
> > out of scope. Given that 'np' is only used within the
> > for_each_possible_cpu(), reduce its scope to release the nood after
> > every iteration of the loop.
> >
> > Fixes: 6abf32f1d9c5 ("cpuidle: Add RISC-V SBI CPU idle driver")
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> > ---
> > Changes in v3:
> > - Unwrap line (100 char width).
> > - Link to v2: https://lore.kernel.org/r/20241031-cpuidle-riscv-sbi-clea=
nup-v2-1-aae62d383118@gmail.com
> >
> > Changes in v2:
> > - Squash patches for mainline solution without intermediate steps.
> > - Link to v1: https://lore.kernel.org/r/20241030-cpuidle-riscv-sbi-clea=
nup-v1-0-5e08a22c9409@gmail.com
> > ---
> >   drivers/cpuidle/cpuidle-riscv-sbi.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpui=
dle-riscv-sbi.c
> > index 14462c092039..0c92a628bbd4 100644
> > --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> > +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> > @@ -504,12 +504,12 @@ static int sbi_cpuidle_probe(struct platform_devi=
ce *pdev)
> >       int cpu, ret;
> >       struct cpuidle_driver *drv;
> >       struct cpuidle_device *dev;
> > -     struct device_node *np, *pds_node;
> > +     struct device_node *pds_node;
> >
> >       /* Detect OSI support based on CPU DT nodes */
> >       sbi_cpuidle_use_osi =3D true;
> >       for_each_possible_cpu(cpu) {
> > -             np =3D of_cpu_device_node_get(cpu);
> > +             struct device_node *np __free(device_node) =3D of_cpu_dev=
ice_node_get(cpu);
> >               if (np &&
> >                   of_property_present(np, "power-domains") &&
> >                   of_property_present(np, "power-domain-names")) {
> >
> > ---
> > base-commit: 744cf71b8bdfcdd77aaf58395e068b7457634b2c
> > change-id: 20241029-cpuidle-riscv-sbi-cleanup-e9b3cb96e16d
> >
> > Best regards,
>
>
> Will you make a PR for this? Or should this go through the riscv tree?

It's not KVM related so better take it through the RISC-V tree.

Regards,
Anup

