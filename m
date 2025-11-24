Return-Path: <linux-pm+bounces-38469-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E33AC81279
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 15:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D475E3477A8
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 14:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7292877CF;
	Mon, 24 Nov 2025 14:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2mYLnSl"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCB5284689;
	Mon, 24 Nov 2025 14:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763995931; cv=none; b=pLXaRyiJ95sBmGyvH6ay4jmxxEvRSmvMRjw9Lbx4IZfXRdY1FoJAB1miXue0yMeAWoHcb9CVQUZSkg5u3qnGhQnuPdtFUzf3VBwlUkgIWeCazL7Qnr+T5Qh2xeSTuSBxG+i/oEiTY8+WjAe+Jk44JnTASyMbA/iWDDKT1RTUYH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763995931; c=relaxed/simple;
	bh=Ppl5jcUBV28m+G2H7ZpG+09UuraaMIVrQKkmLcz0k+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fnBOGLbnPwNzb8RdYKShFOiDb9atSDau3d14WBFwJdV2Fv9KEvCjLdWf1X43QHlrsdiW68BIbZ+4MUsa45WKJ+7sR4KdftnMd0tqq2ZNXd/ezbt/xpAbYpPIVUtj2ptyJXyXT+8VQdLLGEdDYV1kY31QWAJ/x5k/Gc6SUNA+0X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2mYLnSl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F32C4CEF1;
	Mon, 24 Nov 2025 14:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763995931;
	bh=Ppl5jcUBV28m+G2H7ZpG+09UuraaMIVrQKkmLcz0k+s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=m2mYLnSlr6CRJyNta1vrzf+cqAlK1m85GuTlIVjE0KiMA7DxDvNrlPriqfSjTz4Xu
	 7/YR8QoNkPMOcl101RMxlPoc0v0CEMww6Wkg9uT9zM29cO2FXvgjQ9LjN916oDKkF5
	 QRMJFp5hwmrvSKg5LAw1EqGGmZR+oN8FnLfbVsFm34cGc19Di46nJi32SV/Zd8J1XH
	 1mcNeBPJvijzg/kvjDOphPjl1AV8Px4iiNd3b96HzDO3m8Ei+H6Oxmlr2qEukuBhpw
	 hp1ZGd7kJaY1697xZOkNGq73CRdZKnENz3Itbeek3BeNz+qqJDhoxYi2GXKZpV1aoK
	 SpTXnHzvdnP8A==
Message-ID: <4a277387-ca59-4688-bf7b-13da62589fcd@kernel.org>
Date: Mon, 24 Nov 2025 15:52:05 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] checkpatch: add uninitialized pointer with __free
 attribute check
To: Ally Heev <allyheev@gmail.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, Joe Perches <joe@perches.com>,
 Jonathan Corbet <corbet@lwn.net>, Andy Whitcroft <apw@canonical.com>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
 David Hunter <david.hunter.linux@gmail.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Viresh Kumar <vireshk@kernel.org>,
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
 linux-pm <linux-pm@vger.kernel.org>, dan.j.williams@intel.com,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 James Bottomley <James.Bottomley@hansenpartnership.com>
References: <20251124-aheev-checkpatch-uninitialized-free-v5-1-0c523b1a3f5a@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20251124-aheev-checkpatch-uninitialized-free-v5-1-0c523b1a3f5a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/11/2025 15:44, Ally Heev wrote:
> uninitialized pointers with __free attribute can cause undefined
> behavior as the memory randomly assigned to the pointer is freed
> automatically when the pointer goes out of scope.
> add check in checkpatch to detect such issues.
> 
> Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
> Link: https://lore.kernel.org/all/8a4c0b43-cf63-400d-b33d-d9c447b7e0b9@suswa.mountain/
> Link: https://lore.kernel.org/all/58fd478f408a34b578ee8d949c5c4b4da4d4f41d.camel@HansenPartnership.com/
> Acked-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ally Heev <allyheev@gmail.com>
> ---
> Testing:
> ran checkpatch.pl before and after the change on 
> crypto/asymmetric_keys/x509_public_key.c, which has
> both initialized with NULL and uninitialized pointers
> ---
> Changes in v5:
> - fixed checkpatch doc
> - Link to v4: https://lore.kernel.org/r/20251107-aheev-checkpatch-uninitialized-free-v4-1-4822a6ac728f@gmail.com
> 
> Changes in v4:
> - fixed UNINITIALIZED_PTR_WITH_FREE description 
> - Link to v3: https://lore.kernel.org/r/20251025-aheev-checkpatch-uninitialized-free-v3-1-a67f72b1c2bd@gmail.com
> 
> Changes in v3:
> - remove $FreeAttribute
> - Link to v2: https://lore.kernel.org/r/20251024-aheev-checkpatch-uninitialized-free-v2-0-16c0900e8130@gmail.com
> 
> Changes in v2:
> - change cover letter and title to reflect new changes
> - fix regex to handle multiple declarations in a single line case
> - convert WARN to ERROR for uninitialized pointers
> - add a new WARN for pointers initialized with NULL 
> - NOTE: tried handling multiple declarations on a single line by splitting
>         them and matching the parts with regex, but, it turned out to be 
> 	complex and overkill. Moreover, multi-line declarations pose a threat
> - Link to v1: https://lore.kernel.org/r/20251021-aheev-checkpatch-uninitialized-free-v1-1-18fb01bc6a7a@gmail.com
> ---
>  Documentation/dev-tools/checkpatch.rst | 20 ++++++++++++++++++++
>  scripts/checkpatch.pl                  |  6 ++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
> index d5c47e560324fb2399a5b1bc99c891ed1de10535..865aaaf6dc51b1c3f763b3cbb8713da3d00db960 100644
> --- a/Documentation/dev-tools/checkpatch.rst
> +++ b/Documentation/dev-tools/checkpatch.rst
> @@ -1009,6 +1009,26 @@ Functions and Variables
>  
>        return bar;
>  
> +  **UNINITIALIZED_PTR_WITH_FREE**
> +    Pointers with __free attribute should be defined and assigned in one

You did not implement my proposal fully. I wanted to express that their
declaration should be in the place of use, meaning first use.

> +    statement. In this case declarations at the top of the function rule

This does not solve it, because one can declare, define and assign in
top part of the function not achieving what we want - place of use.

Not sure if it is worth debating on, so overall (although I did not
verify regex very thoroughly):

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

