Return-Path: <linux-pm+bounces-17331-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FD79C4140
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 15:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7884DB22233
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 14:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08AD178368;
	Mon, 11 Nov 2024 14:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcnVb/7K"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0F71E481
	for <linux-pm@vger.kernel.org>; Mon, 11 Nov 2024 14:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731336680; cv=none; b=ayzzVf/d28RgPSIqHRENpI7qFeswQHmqukSRp3UwJJIpba1kKJrhAZiFtSkUlEQF1goRkP1XerJNNqvTiLeKMA+aZ/bUMBgXPf+bcS3WxtVEFEpHHZk89WkuDFXwnd233L2ZmhFukFRU3xEfjUT0B9ZxERzvsH8HALs857ze4gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731336680; c=relaxed/simple;
	bh=NYWZ69wuRjyloQdx+RP1ZIBWbJpdqHOYwdwGHpP3M2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Scfn9v0ARlcF7K1GdBVJPT7OqgX4n1vR9u+oay+V7MhVVJ95nhbbzYjD54e2CD5tL1/M3aPMHnDASRyOnMwg/RzyrkmPJlyTabVN+Ge66ZoS9/2mM5AskIw17f80pMvU6iDFrccwoFYHAqtdbBszEp1xnEFt8Z2s4bCTxS6v3+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcnVb/7K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E7DC4CED6
	for <linux-pm@vger.kernel.org>; Mon, 11 Nov 2024 14:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731336679;
	bh=NYWZ69wuRjyloQdx+RP1ZIBWbJpdqHOYwdwGHpP3M2c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OcnVb/7KoOFdnyzFvDVnGQxv/mkN3lHzBPdlBR3V03h9gvFSfmZiyi+W+e8tKbA1+
	 A1P1iZubY4C0+djh3BiTeS5ssjZ9AjG0mSDQmGF1EVLUIuf9qIMBwbgHYD8NWEsPUv
	 qmUuMvUQzLxTocrzbt4InrIltsp7JTkOgL3gEUu61L+8pMscNjcBB71rUrOu0awgk0
	 jkGu0VwwIIkkRqMdxWr12dFReyNq/CdYgDUgZrUpRbjKXTFBRALRl+lv2IU4uX7hJA
	 68dIwP8VdK5QSboM+RXK8vUCOM3HOZcd4JN36VeJ5S+czzPo7mD00rGAi0HesigP6K
	 cVO688T59mbkg==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2958f5387d2so799759fac.0
        for <linux-pm@vger.kernel.org>; Mon, 11 Nov 2024 06:51:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU1WfBMYn0oiQ8wHr26cfrBCeoc2Tezz8NTtkRPNBoDIpgXs5f9GqAHkF7ON3PQxajseO99d/thxw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzjitrmULhk6ktvEtDy37tIJssZ70eD7w0WjajP2pgu0RpYHqqK
	SkegQLr3VT5NqQ/doKFEvKeluP1vQ0Dqwyuhbewnn5vOvcbXOxsYnaBu2JpCe++JFcnMlE7XlB/
	qm5AYqeeWUPqBRlS9vcQqpcFmXzs=
X-Google-Smtp-Source: AGHT+IHhbJVfYvILGDI8thpKoPiB8H4EOhq5XKofAug5RnXENbIgCn9Hy1yLLVFJ0UuajzmsIyFNEfxAwqUH1zAnu1k=
X-Received: by 2002:a05:6870:e99f:b0:277:f301:40d5 with SMTP id
 586e51a60fabf-295602f1396mr9971087fac.31.1731336678601; Mon, 11 Nov 2024
 06:51:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107115608.52233-1-artem.bityutskiy@linux.intel.com> <fc4039a725b77374f36d6934f944db40f643e303.camel@gmail.com>
In-Reply-To: <fc4039a725b77374f36d6934f944db40f643e303.camel@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 11 Nov 2024 15:51:04 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h=VuVLwbo0jVdPcyDZR92Q=02LdnDvtaVM5oK_2A7iSg@mail.gmail.com>
Message-ID: <CAJZ5v0h=VuVLwbo0jVdPcyDZR92Q=02LdnDvtaVM5oK_2A7iSg@mail.gmail.com>
Subject: Re: [PATCH] intel_idle: add Granite Rapids Xeon D support
To: dedekind1@gmail.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM Mailing List <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 12:59=E2=80=AFPM Artem Bityutskiy <dedekind1@gmail.c=
om> wrote:
>
> On Thu, 2024-11-07 at 13:56 +0200, Artem Bityutskiy wrote:
> > Add Granite Rapids Xeon C C-states support: C1, C1E, C6, and C6P.

Applied as 6.13 material.

> Oh, just noticed a typo - should be Granite Rapids Xeon D, sorry. Rafael,=
 if you
> pick this patch, please amend the commit message.

Done, thanks!

> Alternatively, I can send an adjusted version. Thanks!

