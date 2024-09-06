Return-Path: <linux-pm+bounces-13814-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAAC96FBA2
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 20:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 427F01F2AA0D
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 18:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B281D9328;
	Fri,  6 Sep 2024 18:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJU9skAz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF9713D24E
	for <linux-pm@vger.kernel.org>; Fri,  6 Sep 2024 18:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725649021; cv=none; b=O3BC0rW5dzC1EPOwAmWeoGO5o3TMGsw3yT6nXBjAwnKcnTYffZ3OUvcj67DEAES11PYjbH2LoRmNNfM+pE04f6RVPYZ+swo8UkSXeRHgc8uY+Hixf3o/gfCe2z3XP0Q5YbT3UtkAuS7RH9uKWCsMd+rfzzrVPLuVPfhvmyqkzCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725649021; c=relaxed/simple;
	bh=M3ML4WU7CJgDPj2J3PizEsQJWR/rMehwxrpGfq19TYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UN59YSfTq6cqenuFVujJUSppn20RHKmj/5TYSvFghdBid0PT1OZwTo4u7VQHO35l3jRwXrO/E+uYh2ZxHSnacYg98HkEPUr87Vu17IgyPBnq3qYKlfUjaSRusbQSlqvev7BZXLTntBOeFlWxIzEQCbngwZrydnzpe6lS+LGLu9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJU9skAz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40BADC4CEC7
	for <linux-pm@vger.kernel.org>; Fri,  6 Sep 2024 18:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725649021;
	bh=M3ML4WU7CJgDPj2J3PizEsQJWR/rMehwxrpGfq19TYM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MJU9skAzP+HLrWSkQnm97kQCJUSpAWXht3EirhxNHySDsSEk7FFEx3Rv3eFOVAlUC
	 8ZrVEM55zOvKjsHXZpc0+OoxUOgTigUXoTLqUBuFcHg8NCKOGLWUxwQFKfn9YwkzoH
	 wgxdk/lynxMMkUvO0Qcle02/5g8o2asnFhoR201wq8eNY8bwcm6bsz2X0csb3ndiVa
	 kiTRYiWWMzZKhEbA1P5vtJgfLxZt5lCBthB+9pXuvuYJFEI+5UqmkI454kPlfps72s
	 N7ffgUkFN577TS+p9zBxx2iCyLVNGITJTav+cxwi9uWKjpXRCdiPbKlpzG9MbtZEDm
	 sb36fWNeBJPuw==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5dca9cc71b2so1442491eaf.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Sep 2024 11:57:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWhrj7Kr8QPCLmGbzyOQSjX7s0B8NO7wSL0KulbJnRVSh0yw7O5OASdh56BLX2L1jTo/EueUiluTg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx39/t3Jue6/seER4xVSavHWZI7MXqaCB1Uyni2YrMyYRgD2nRC
	cUT9DeWaVX3qUi5zK7kww/ChhTNWRRJLKkfWS6bsHtmD6ZH6lfBUbSRgEN9et8Y6bGupndWE8Zi
	KcEfaXQcOyHKAGGhhv8vf3le8QVA=
X-Google-Smtp-Source: AGHT+IGUIEulByp2qLxt2SWHWENLzpbowzSov6WBM66RHNGUNcP/UbQy6oZ7Dt0aWS+QbeGH/PqPIfA+ipHBpDQF0iI=
X-Received: by 2002:a05:6870:1590:b0:277:f5d8:b77b with SMTP id
 586e51a60fabf-27b9dd81873mr253694fac.32.1725649020675; Fri, 06 Sep 2024
 11:57:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906055246.exjgfkrqesllh45z@vireshk-i7>
In-Reply-To: <20240906055246.exjgfkrqesllh45z@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 6 Sep 2024 20:56:49 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iWUvRnmY-NKMFOpPA=yMKJFN0oLSCHMELccNVXVrdqOQ@mail.gmail.com>
Message-ID: <CAJZ5v0iWUvRnmY-NKMFOpPA=yMKJFN0oLSCHMELccNVXVrdqOQ@mail.gmail.com>
Subject: Re: [GIT PULL] OPP updates for 6.12
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Viresh,

On Fri, Sep 6, 2024 at 7:52=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.or=
g> wrote:
>
> Hi Rafael,
>
> The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f01=
7b:
>
>   Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/opp-u=
pdates-6.12
>
> for you to fetch changes up to a84372012e9329daba8082efac98f3bc0b443aa2:
>
>   dt-bindings: opp: operating-points-v2-ti-cpu: Update maintainers (2024-=
09-04 20:43:43 +0530)
>
> ----------------------------------------------------------------
> OPP Updates for 6.12
>
> - Update maintainers for operating-points-v2-ti-cpu file (Dhruva Gole).
>
> - Drop unnecessary of_match_ptr() for TI driver (Rob Herring).
>
> ----------------------------------------------------------------
> Dhruva Gole (1):
>       dt-bindings: opp: operating-points-v2-ti-cpu: Update maintainers
>
> Rob Herring (Arm) (1):
>       opp: ti: Drop unnecessary of_match_ptr()
>
>  Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml | =
2 +-
>  drivers/opp/ti-opp-supply.c                                           | =
2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> --

Pulled and added to the linux-next branch in linux-pm.git, thanks!

