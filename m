Return-Path: <linux-pm+bounces-40575-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A3FD0C362
	for <lists+linux-pm@lfdr.de>; Fri, 09 Jan 2026 21:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7ADB0301B671
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jan 2026 20:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E5E29B8C7;
	Fri,  9 Jan 2026 20:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oB0W8OXy"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C7A248861
	for <linux-pm@vger.kernel.org>; Fri,  9 Jan 2026 20:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767991761; cv=none; b=cbcpSS0LcrorK6Mttx0EVeTHXvKuabDCJB0xa71GldIPE3B5Cob49459XIMIQYKJsMA5snexRLx2Ig8hmUA3yQ/v5RSfJQ/ZS13fOYscaU+x9dycU71lelwoecwOwqwxyzcDtvIMmnW//T4UAhi8K66wAicVUpxaidWSCn6r2Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767991761; c=relaxed/simple;
	bh=lmSrngha8S1iodqCQ5ibvWry8cc5krov+0Wn+POWbVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U0teTK6d3eokISQEFYE8nEig/C8cLv52CSzAGCSXtpa0hAKT+rOCxWoY5E6WhW/LG1zudRf1OkZJKCzNEWmGfz2x3h/rhEL8Pf4ZlZ5C6wMOIc3Rj7FD2PSsVvqC3OG7+GA5QTL8oWj7s8BSXkLBSlJERp+VgDQnoAfVPZsz+ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oB0W8OXy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83834C2BC87
	for <linux-pm@vger.kernel.org>; Fri,  9 Jan 2026 20:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767991761;
	bh=lmSrngha8S1iodqCQ5ibvWry8cc5krov+0Wn+POWbVQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oB0W8OXyq/KSnIJvf4FGUedAWPpqIwNJky6k+b1sGrKMp9FY3jiU3ndvB4pPYWt+B
	 YIOyi0vbewYiIDcV3Icta+lSmQlIvX5iBbt6TXGqLx7AE8bocIgIC3ldNu6ZjEpXMR
	 NeNiMj0LD1b2Z6lEuJyx2frCTLDyz/WVv1T1JDROi2dMyojmX3f2eDumv9m6p8GlAv
	 QWaEX2SJ5F+5jbCIERr7mdaNLNwk7mqmbJIPEw22KLD5Av4Nsv7cu2vSlnfOPhf+3/
	 bCcUQxK7kMsMxrCnNTUC7RlMPOh+kkw01+K6e+yIJaOEs6Hwd1IgDDIs4+2CmJFVzu
	 LwcHLVYj/b3zA==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-3fe9d6179efso2222594fac.1
        for <linux-pm@vger.kernel.org>; Fri, 09 Jan 2026 12:49:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW2U2ljQ7Xjdp50XZRl6owsSC9zhmKOIGxTm1ykviR33GJiY8MocIG5q++k4Nmrg3N3jJmsAXvZWA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzefMwxYOt7DuJGK3JerUZbqxOAQUwIXn3ea3tvZHLv9MpC+1X0
	XZdiPdcXVz9vsddEbC3EUt0kSm/GXElUOhAiMO1KQVaeDgPzgWuzb5in9z+/ko1T8xeO09fn9xw
	aqUlwvRWJADUdHnRsrD3NtTQga9oak9s=
X-Google-Smtp-Source: AGHT+IH2AF2IKp3+x/fUQIk0eMsiHqZAfSKwVKAtfksfYxjvWvqIHKaIJEvWLlnhDTe+vhJvEnjraHEmyq1ON0yk/7U=
X-Received: by 2002:a4a:d131:0:b0:659:9a49:8eec with SMTP id
 006d021491bc7-65f54697151mr4920100eaf.32.1767991760513; Fri, 09 Jan 2026
 12:49:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108053212.642478-1-changwoo@igalia.com> <m27btswij3.fsf@gmail.com>
In-Reply-To: <m27btswij3.fsf@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 9 Jan 2026 21:49:09 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hPHttsxSS=dfBV4_2ANKuqUYvBnLko++ie5nKwRwbrtA@mail.gmail.com>
X-Gm-Features: AQt7F2reoHMKcruymvgt9rJybyawGlPF4XAwW4ghPDph-T_U-vdBHDWri3QQcts
Message-ID: <CAJZ5v0hPHttsxSS=dfBV4_2ANKuqUYvBnLko++ie5nKwRwbrtA@mail.gmail.com>
Subject: Re: [PATCH v2 for 6.19 0/4] Revise the EM YNL spec to be clearer
To: Donald Hunter <donald.hunter@gmail.com>, Changwoo Min <changwoo@igalia.com>
Cc: lukasz.luba@arm.com, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	kernel-dev@igalia.com, linux-pm@vger.kernel.org, netdev@vger.kernel.org, 
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 10:39=E2=80=AFAM Donald Hunter <donald.hunter@gmail.=
com> wrote:
>
> Changwoo Min <changwoo@igalia.com> writes:
>
> > This patch set addresses all the concerns raised at [1] to make the EM =
YNL spec
> > clearer. It includes the following changes:
> >
> > - Fix the lint errors (1/4).
> > - Rename em.yaml to dev-energymodel.yaml (2/4).  =E2=80=9Cdev-energymod=
el=E2=80=9D was used
> >   instead of =E2=80=9Cdevice-energy-model=E2=80=9D, which was originall=
y proposed [2], because
> >   the netlink protocol name cannot exceed GENL_NAMSIZ(16). In addition,=
 docs
> >   strings and flags attributes were added.
> > - Change cpus' type from string to u64 array of CPU ids (3/4).
> > - Add dump to get-perf-domains in the EM YNL spec (4/4). A user can fet=
ch
> >   either information about a specific performance domain with do or inf=
ormation
> >   about all performance domains with dump.
> >
> > ChangeLog v1 -> v2:
> > - Remove perf-domains in the YNL spec, as do and dump of get-perf-domai=
ns
> >   share the reply format using perf-domain-attrs (4/4).
> > - Add example outputs of get-perf-domains and get-perf-table for ease o=
f
> >   understanding (cover letter).
>
> v2 looks good, thanks!
>
> Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

Applied as 6.19-rc material, thanks!

