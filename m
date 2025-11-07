Return-Path: <linux-pm+bounces-37620-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9C4C40900
	for <lists+linux-pm@lfdr.de>; Fri, 07 Nov 2025 16:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27F391A402A4
	for <lists+linux-pm@lfdr.de>; Fri,  7 Nov 2025 15:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5D12F533E;
	Fri,  7 Nov 2025 15:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o6jLEhf1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F8F2F1FC3
	for <linux-pm@vger.kernel.org>; Fri,  7 Nov 2025 15:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762528822; cv=none; b=YPGtBZoUlldL1GYvq406DCgAgIOhb8ZxSls7bk7X09YhPGL0lIJiRYnTg88SUlOi4nwqlqlw036tatssa1pq5basosxc5gXvy4SQroU/mgNLQLH02v/jSs4rO8jGZnwqrYXctt2Q+YV/UaNMuDktIMhEHxb8l5o8XY8uCbJd6Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762528822; c=relaxed/simple;
	bh=kmG68tRMF1kPY1q9rfO7CHCJ7nW2UrBUgxaHdVFnj6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nm5EhHfF+M8LxreNi8ArBtwk7AocIfC31hG2+OriuJnDr/v8/uzpEws4jN5TeEaBYN1TAf1blhqNA7DqywdeX0SDy/hq/HUHMQA9IFsAWcC599MyU1jFVi9DxatGyZbx3Xs2eRPU5D2+PnuTyUgavskvbGRpzdRIzBY63dNxlxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o6jLEhf1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680DCC19424
	for <linux-pm@vger.kernel.org>; Fri,  7 Nov 2025 15:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762528821;
	bh=kmG68tRMF1kPY1q9rfO7CHCJ7nW2UrBUgxaHdVFnj6o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=o6jLEhf1Y2maaTyixByh7C34dfqIfFMx5VhYkGxenQ2yfIbi9Daiv6WkPsdtAI+dA
	 /fNOA6Z9uIyBfvhkhW+CCAgUv7iGt50JfwC6rAuashBw2UgJu3cjaww0pKPWfAvKFM
	 KehV4FevCyD2z0PQrMJ82oSbo88xutSIK8BWR7vK/mt63W1+owQJIxR6eFc88fJbuJ
	 xCUxzjq9ImznXjYzEBbA/eMrH1+/2hVxikHb9Uc9TmjmQGFT7iEhcS4h7EWuZ1cKA8
	 rClUsUmjBcAQTe7H/XCpRNFCNtRMMvTQCZoLApIthIDCMWz3LQCJ+9l6O67qPrD9dD
	 3svYGnScwSXbQ==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-656b8ca52e8so345754eaf.3
        for <linux-pm@vger.kernel.org>; Fri, 07 Nov 2025 07:20:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXWTDPsJ6pngesux+eLuN6IneybPXgjQlvqgGfB66EIxlWUSKMgDAgGyH8W7txoUaWc7hKYSAOB+A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzzLrU7FkveTao6Ko3rqW+AYAgbWcuqRt6l7UAM9kgcE35obOqj
	y25TG9u+i6X6hGHzw9dOWmYiv3+hVVzuGDyDghMdb4zIwjybAPEIfGDcMtH+6MotulaCGYS1Mi3
	vSNS9HYGJ2jR3TWJPHhRcahJQumHz9PU=
X-Google-Smtp-Source: AGHT+IES4Az0qzCiwB3v1Q683tjZFfLurhZkG7kR1xrSEX7VeL4WGckReVCT2aWGZTT6ikfbr4/J1ZnyDH38BymC0Z4=
X-Received: by 2002:a05:6820:2009:b0:654:f452:45f2 with SMTP id
 006d021491bc7-656cdddd185mr1775662eaf.6.1762528820628; Fri, 07 Nov 2025
 07:20:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106142524.3841343-1-superm1@kernel.org>
In-Reply-To: <20251106142524.3841343-1-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 7 Nov 2025 16:20:08 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gXe2UH4thiUHtpc11CMe5z19KHpPc1eEXywCzQAqJ_Cw@mail.gmail.com>
X-Gm-Features: AWmQ_bkFuJApQBeGxpwJRk6PsPlgT8KCC4AVXZmpn0zZyynj-9CnAebXG-Crc5s
Message-ID: <CAJZ5v0gXe2UH4thiUHtpc11CMe5z19KHpPc1eEXywCzQAqJ_Cw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: power: Correct a mistaken configuration option
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: mario.limonciello@amd.com, rafael@kernel.org, lenb@kernel.org, 
	pavel@kernel.org, Rodrigo Siqueira <siqueira@igalia.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 3:25=E2=80=AFPM Mario Limonciello (AMD)
<superm1@kernel.org> wrote:
>
> Somehow CONFIG_PSTORE_FIRMWARE ended up in this document when I intended
> it to be CONFIG_CHROMEOS_PSTORE.  Correct the configuration option and
> make it clear that not all options are required.
>
> Reported-by: Rodrigo Siqueira <siqueira@igalia.com>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>  Documentation/power/shutdown-debugging.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/power/shutdown-debugging.rst b/Documentation/p=
ower/shutdown-debugging.rst
> index cdfa2cd90e5c6..c510122e0bbc2 100644
> --- a/Documentation/power/shutdown-debugging.rst
> +++ b/Documentation/power/shutdown-debugging.rst
> @@ -24,11 +24,11 @@ following kernel configuration options:
>  * ``CONFIG_PSTORE_CONSOLE=3Dy``
>
>  Additionally, enable a backend to store the data. Depending upon your pl=
atform
> -some options include:
> +some potential options include:
>
>  * ``CONFIG_EFI_VARS_PSTORE=3Dy``
>  * ``CONFIG_PSTORE_RAM=3Dy``
> -* ``CONFIG_PSTORE_FIRMWARE=3Dy``
> +* ``CONFIG_CHROMEOS_PSTORE=3Dy``
>  * ``CONFIG_PSTORE_BLK=3Dy``
>
>  Kernel Command-line Parameters
> --

Applied, thanks!

