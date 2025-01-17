Return-Path: <linux-pm+bounces-20639-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9FCA15616
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 18:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFE283A1CDF
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 17:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36BD1A2541;
	Fri, 17 Jan 2025 17:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdVr2uWT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA44188A18;
	Fri, 17 Jan 2025 17:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737136610; cv=none; b=KxRHJVYmfZbuB6t9RXf2N6WiTcyuBqm7XTxr0CcFexChzkaUj10MaZtlLRReGlnOPtVxAWa9zdNBciqTDziN8QKULPqs8uX1YvejZ5vluRRzavtACcGVsQuou/K57izSe6Vmijh8IKFXPVEIwYNFjm+GRSMnquer85ltfqOO6y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737136610; c=relaxed/simple;
	bh=W20FKPQLpsgn7tuGcr40gcGgekycwwtMobddZh1YGAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=chtk/3tgJgxkFrjVSFT88YFtzbL9XzA1dGj5/b09dPYLhD3dtnsfn5QTkS58MMfNiFX84oxwCnKB9KBIzXMYlPunxOCtkl20o42N4fEuMtCP3w7aT1P46sbx+mYzYq6rQCGFTuD/Gv6hU/x+QWqeZTiM3fMJZtcSca1fzE6WU2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdVr2uWT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A0D1C4CEE0;
	Fri, 17 Jan 2025 17:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737136610;
	bh=W20FKPQLpsgn7tuGcr40gcGgekycwwtMobddZh1YGAU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QdVr2uWTsl4QrI1i0QVrO84D+0XhWqtkk+8crShCJcINVUUJAowrDgsWQjPA3b8Fi
	 qTwDRsqXYekV6JJUsp10jKpzfmLhFaKunSKRTqmrJNkLoru2t+sZuFT9+lT8R8bImk
	 FD8NTxYn++gXA57emUIIoCUUNF4fBZ+x7S3ZkkV4gQj8xJ4DePwhizVMnUr8RkZJrV
	 g8e/7qXBCUxn5lLDVv/FICLz2L/N5ij2O2t7DXxmQmoboGB/Z9viDeaBtlj9hWqMxQ
	 i4tzRiJGNwbJDEl80IOQaBjrnSuakq+zpUNclcOMj3a2/OzMqEFQdw33qdc9vPVqhs
	 laCw6Q0j4Wcwg==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3eb7ca55c3bso1413881b6e.3;
        Fri, 17 Jan 2025 09:56:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWluhr77a/b1ZXgQGwRus2ep1PIV+VohXborfWqGdopNju9XdRTGqduFMZUy30P3dKqeo7QfVjcLd2UWvs=@vger.kernel.org, AJvYcCXZyvYob0EjLGmOSuxSOf51AaHJBVhgwTEKQjlys6dh9TcvuneBtaYzApRS+PRYBEGEpyGbSO3Kulc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3LzzYFQ+Yx87eU5o+8fCxjj0DZKeLGwXvDoNGrXbqvtMb+Iqr
	m/7mBPVYM5GP7x/aMo7nIRhOUCrA6GYkBnrMD3KMHrFqY/emEYhCTYeMP6cJqs1LO4fxeCpN2QT
	NmPyBsH8Dw7qQcM8z4mS8NBpEJks=
X-Google-Smtp-Source: AGHT+IEHpotjJYMGNiG1GyFY4aE5frwe0D6oI/88O3Q7jH39v93JVarforfyHexdeJUmwEy5xzz0cvKmTBtmEH+SSV4=
X-Received: by 2002:a05:6808:2f1b:b0:3e7:b2b4:ee7a with SMTP id
 5614622812f47-3f19fd30482mr2969328b6e.26.1737136609745; Fri, 17 Jan 2025
 09:56:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250114190600.846651-1-krzysztof.kozlowski@linaro.org> <20250115071251.ww6z2h2oj2v56sbw@vireshk-i7>
In-Reply-To: <20250115071251.ww6z2h2oj2v56sbw@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 17 Jan 2025 18:56:38 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gbS0xHiK1zHbyvBFTQdkCvUPZWg_jOwf00cYnc4qZY+A@mail.gmail.com>
X-Gm-Features: AbW1kvaqwd8w6CX_qL8qN73sPwqvxoUBDj6KpQAgT9NoTcKXu3LbXufqha0NiVk
Message-ID: <CAJZ5v0gbS0xHiK1zHbyvBFTQdkCvUPZWg_jOwf00cYnc4qZY+A@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: Use str_enable_disable-like helpers
To: Viresh Kumar <viresh.kumar@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 8:12=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> On 14-01-25, 20:06, Krzysztof Kozlowski wrote:
> > Replace ternary (condition ? "enable" : "disable") syntax with helpers
> > from string_choices.h because:
> > 1. Simple function call with one argument is easier to read.  Ternary
> >    operator has three arguments and with wrapping might lead to quite
> >    long code.
> > 2. Is slightly shorter thus also easier to read.
> > 3. It brings uniformity in the text - same string.
> > 4. Allows deduping by the linker, which results in a smaller binary
> >    file.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 6.14 material, thanks!

