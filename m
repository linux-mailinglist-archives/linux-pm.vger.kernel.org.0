Return-Path: <linux-pm+bounces-12586-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6F6958ECE
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 21:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 353D3B22960
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 19:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7CE19047D;
	Tue, 20 Aug 2024 19:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbVVZmTG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA8C15FA93;
	Tue, 20 Aug 2024 19:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724183374; cv=none; b=N4J9uwNIDIJQhuqKJbG/+4t7xB/GRqTF2ZMXdAgygMaQevDP0dcKwHdvKoYyNpq+0TJGZqW+L09Aca0l/V76ZJdEjZIaGZ9xyOF7IqmBINcHxhrMoRt/tWXwMTiIjJdIXnwh8RcLw4OvjguGhbw2erH9jtq1pWQHUrxjs/GYS3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724183374; c=relaxed/simple;
	bh=wkf9gsj1XSad7V3Dq8I4UyQtzWEYMfLIFCxAydmaCzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H3HPZHagXn4E7Uf5GFqt1iPlNoK4iumusCV4R8iqKOqxPrmRkk6/o3MYeW+fxl37m/7YM8YF3PnRqbIDRiiQ+3Hr8Xv3t+JjeBa6ifL4g2Gyektbu2/elAPlUyZBY0eu5oF1gAFhQ8AC+/N33rHMk38RuosRzc/dMIAGWUjE4f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbVVZmTG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446B3C4AF09;
	Tue, 20 Aug 2024 19:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724183374;
	bh=wkf9gsj1XSad7V3Dq8I4UyQtzWEYMfLIFCxAydmaCzw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gbVVZmTG/SRnVY6iMRmOJQvuRI/8KIUJ9pBlKlB4oJy9xuRxyKvxK9KDnwJrJuqS4
	 nHj4l6KqMEwTOgrXd6qbK9glhJnqEYvVTHkujvxDfuESIkstmV8DUxx1Xt8giD9WVy
	 x03oWr11ujcEfjwoU8BlG4+aYQlbrCOlvISgEGe4t5bTlZ9AlJiILtIpca8J+B8ZOv
	 1V2tnVWcF/XWAGxIirrrWFVkcCeXvvZIiWasaYMG+uPxq3VqUEsnwAw+QmLUqxrO4s
	 0pQRSkmPdoV7BYunY5ewYZnjKKSCROZ3DERwwDXCgJV5PKXaAQkbY++BWHdSOxFs3M
	 Ewi76G9OuiKTw==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-270420e231aso2049316fac.2;
        Tue, 20 Aug 2024 12:49:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCULeQCeYIgKQx8GdbvFSgywG3gCt156yibpWy09KcCXL9pcqnFDlGSSyid8UoUKQ+vFFdzNrkiejh8VrIA=@vger.kernel.org, AJvYcCUjW3FA80bA0ySYpRI07phruKS0ehqOtFsB+esAtzMSS84PYcaXk7Vp2OIliPLwmpZhwJ7fHWuk@vger.kernel.org, AJvYcCWo/KXj7iL72AD9dRzxy5s7Jo0jC4AgnsQ1uTw/wEWSK3IyVkUtCeUryFV5DqMc2IQO5/wGMs76yCo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4p1XAdfVy958I1n+n5rKjxw811PBYUv9EtDqK6H6/XZ4agdLn
	kRMFlz+1TR3/4Ld7tW5HNox3Dqitjw5GOJ+wOHxNS29ebRE7qYUvmff6JRbKr/alaeXIMPvc5Y4
	V1FydHBw9c4XUTk8BTnCKb83+cw4=
X-Google-Smtp-Source: AGHT+IEROyYPyyUToSOegMz5cgcnQfC+ZGutYEi8+81lPeRqkPLiLkJ6XqDwy11TysehDcz1PmHz7jBrDEzmfk2nO1I=
X-Received: by 2002:a05:6870:96ab:b0:270:4a9:c369 with SMTP id
 586e51a60fabf-2701c349c01mr18298140fac.7.1724183372607; Tue, 20 Aug 2024
 12:49:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820094023.61155-1-krzysztof.kozlowski@linaro.org> <CAAhSdy3S_QTBzCNtj8kKDpzxtoeyKWvGLtjgSTViieWimpP-JA@mail.gmail.com>
In-Reply-To: <CAAhSdy3S_QTBzCNtj8kKDpzxtoeyKWvGLtjgSTViieWimpP-JA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 20 Aug 2024 21:49:21 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i7kweDVUGw103kq7kPOoh+9vJMU_8xugHA_hqqkRdaNg@mail.gmail.com>
Message-ID: <CAJZ5v0i7kweDVUGw103kq7kPOoh+9vJMU_8xugHA_hqqkRdaNg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] cpuidle: riscv-sbi: Use scoped device node
 handling to fix missing of_node_put
To: Anup Patel <anup@brainfault.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Atish Patra <atishp@rivosinc.com>, linux-pm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 12:57=E2=80=AFPM Anup Patel <anup@brainfault.org> w=
rote:
>
> On Tue, Aug 20, 2024 at 3:10=E2=80=AFPM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> > Two return statements in sbi_cpuidle_dt_init_states() did not drop the
> > OF node reference count.  Solve the issue and simplify entire error
> > handling with scoped/cleanup.h.
> >
> > Fixes: 6abf32f1d9c5 ("cpuidle: Add RISC-V SBI CPU idle driver")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> LGTM.
>
> Reviewed-by: Anup Patel <anup@brainfault.org>

Applied along with the [2/2] as 6.12 material, thanks!

