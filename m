Return-Path: <linux-pm+bounces-34620-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3FFB5700D
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 08:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2E6E1899026
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 06:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB2F276020;
	Mon, 15 Sep 2025 06:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2thQLtu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86C62652A4
	for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 06:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757916511; cv=none; b=sdBDpGg9ceOu66jiZSpET37xnJAdexnBAqdYHX14TIuV0UnNsztIVrff5MaZjcfeNG8Hhb7pWbzqEELYp+Z+iWpKJQt1uQQYj+zAIHJNtarXnIegzQmygAbWxDO//hrN5ljMs8VVMazGs89Ew7TRAL71PQuw7LfngG1bGAND0m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757916511; c=relaxed/simple;
	bh=7VzbklctKdIrn6OpeqjjDqcdvSxO6Lzp/1BHbgsjrIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BL5q2z5nNjtUX4KozYWrKNYUyjM+HsOE8yKzymfrMsP5lWSAqIPf+rVX9Mt52iCSUMoENNpOxF5Y1FLSUX+xJylKDS2/F9gliJjVV6sktuJrjX8gtsmg4u7/ebw6VFWE54m/YQ0QtPydlQ3sDpR2uH7wU3o9OU7riY8OXry/hQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2thQLtu; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-56afe77bc1eso4149077e87.0
        for <linux-pm@vger.kernel.org>; Sun, 14 Sep 2025 23:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757916508; x=1758521308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+bAX19gw/9gH1ginZH4Z7Vwie8QhvssmibHNzq3eoY=;
        b=S2thQLtuERHfqEu0cb8GSvjx7+x4W/aCl8/6dLJ7M3I4XNCmH8TX61DwiUUtAS89zr
         ST7R1t/wsrIGYRMC/Jd6PSqD5BXrUSG8V9V0PM1rcCR8l8XB5yIdYdLEOnT9dAsW8FBp
         QV87jKxEm1oPhGqS7GQlUbCjL1gZNLmQ30qnYv+mUlD8xjYJVgvcxoOOWKv44ND8/bQg
         HBFAFL5Kk8GtPjzArG2N69yp+n3MAlt3uZTXSWFsrs5htbs+/XhTborrjqc/NFz9AsB3
         gdN+QzCNLpMUgrgvieUFMK5it8uon2nem7iT+Uht+Nq1FpVaMmLjm4AMErjUiZ97sMGJ
         ZidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757916508; x=1758521308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+bAX19gw/9gH1ginZH4Z7Vwie8QhvssmibHNzq3eoY=;
        b=m4Z3sRCYojy7nj79RRwhwDSY2g3v+BFBxmDuFSjfvjeMVaqnqHOk+XDAx8yRK1puNV
         J8KHbeaXVZYFoW9yWEPUMzHcH/pjXHIEcUUgoIsx/sCccrgX6PsLlEOXVXRk9/TY2BAK
         WpSfGPa6WyI0i3eTQmOSRDTkMLUxJRJTnjL/Jlb7K3MCVlmRe3T76A2n3M+O00njrjtG
         TCNcNBd+JTkmZqjhgeuyh5JQ6NQMeE3n3yFwOfKc7AsIqR5go2gUNTTUvCkC5+tN/Knd
         uboORRgGu1Ms5y/PETwi/cZjHaEJcQ0/+ixJ33nttQVhKGLFrTp4sKDRnsZ8aqMnWXVa
         QO/g==
X-Forwarded-Encrypted: i=1; AJvYcCV/YbVO7IEgnflPXdAVVwRLauMXY3uOe3gfj5oNJ4InVNjx8tKq0mM+JmbGKyk1bSyYy3804H05oQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlmpcTp7A4VdzHLsI8MWNvbtAmTTRP3JydU5Pblg5vAy+gAiuR
	EFyiR2ll0HM3La+/4j19delxEqz0YxTb8PSnbv36+a9HROBkj2TQiCc3CBYDL7/M4g9GIyn6LHZ
	hJjVdf8MPB4EVd6I944obxniVH2Y+Gj4=
X-Gm-Gg: ASbGncsPUShe5R3ouhtT43J+1RNhV4g0fty3CynY7s7lcKQf/1hHyXqgiv4d7i9kVA2
	385pMOQ6gSmrDCqMk8VGLo4VlyNtwHgBcrrCr2N3mOpWG2RiuiuyEmGugRMZsxhMpZS7hOReg4+
	N7V0zIzR+es/mPbPtT7DV4iUiFy8wiaU76hiTUu+qZFts6NR718oEsroZJ+OLUNLrouxHL6FYwx
	jipKyiedKRqW/XYEQ==
X-Google-Smtp-Source: AGHT+IGFGnkhckMa356Nxb0PE7sy4MulP40ZRRHJNJXJXO8vi8UJyukObUTHuMngTBbku9KLRFQWU0gFKtiEEN2v7mM=
X-Received: by 2002:ac2:4bcd:0:b0:571:3afa:33dc with SMTP id
 2adb3069b0e04-5713afa35f7mr3565655e87.16.1757916507877; Sun, 14 Sep 2025
 23:08:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250906-t210-actmon-v3-0-1403365d571e@gmail.com>
 <20250906-t210-actmon-v3-5-1403365d571e@gmail.com> <29ec10fa-1ca4-43eb-a865-7219d39c7140@kernel.org>
 <c1b0bffe-f5d4-4d71-bfb6-b047d3d2866e@kernel.org>
In-Reply-To: <c1b0bffe-f5d4-4d71-bfb6-b047d3d2866e@kernel.org>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Mon, 15 Sep 2025 01:08:15 -0500
X-Gm-Features: Ac12FXxfBqN3bMySguM87nRxs_1fzm1bjR4kMnBwk53fxGN6c3-9HEkbRgJ-OG4
Message-ID: <CALHNRZ9G_OA0+quNP=NwnwX43iaV1JWxjJFM0Aoect9Y8jGjWw@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] memory: tegra210: Support interconnect framework
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Dmitry Osipenko <digetx@gmail.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 5:07=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 10/09/2025 11:39, Krzysztof Kozlowski wrote:
> > On 06/09/2025 22:16, Aaron Kling via B4 Relay wrote:
> >> +
> >> +static int tegra_emc_interconnect_init(struct tegra210_emc *emc)
> >> +{
> >> +    const struct tegra_mc_soc *soc =3D emc->mc->soc;
> >> +    struct icc_node *node;
> >> +    int err;
> >> +
> >> +    emc->icc_provider.dev =3D emc->dev;
> >> +    emc->icc_provider.set =3D emc_icc_set;
> >> +    emc->icc_provider.data =3D &emc->icc_provider;
> >> +    emc->icc_provider.aggregate =3D soc->icc_ops->aggregate;
> >> +    emc->icc_provider.xlate_extended =3D emc_of_icc_xlate_extended;
> >> +    emc->icc_provider.get_bw =3D tegra_emc_icc_get_init_bw;
> >> +
> >> +    icc_provider_init(&emc->icc_provider);
> >> +
> >> +    /* create External Memory Controller node */
> >> +    node =3D icc_node_create(TEGRA_ICC_EMC);
> >> +    if (IS_ERR(node)) {
> >> +            err =3D PTR_ERR(node);
> >> +            goto err_msg;
> >
> > return dev_err_probe
>
>
> I will send patches to fix existing code. I also found some more issues
> which I would like to implement here.
>
> I apologize for coming with all this at v3. I should point out things a
> bit earlier, although how this patchset was organized also affected revie=
w.
>
> Anyway my comments are mostly non-critical things, so v3 is late to
> bring these, I understand. That's on me. I appreciate your work and
> please do not get discouraged with my comments.

I understand and that's fine. Get it done right the first time so it
doesn't have to be redone later. I will try to get a new revision out
this week once I cycle back around to the relevant devices here.

Aaron

