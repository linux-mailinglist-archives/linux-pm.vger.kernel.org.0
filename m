Return-Path: <linux-pm+bounces-36740-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85144C021E8
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 17:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 898683A4B96
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 15:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1C532E6AF;
	Thu, 23 Oct 2025 15:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="addQnBq6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF5D326D54
	for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 15:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761233012; cv=none; b=Pt2lCeMX5Wrvq9iw5Cqh1e/JWKw+h5BeSFnj1g3cnxswZZR6plhMkjucOypHl7Sv/EBhc/f4dwYAmmzjyIUBY4M1mAhkO6nOKeC9M+YfZNJkrydPHt+PGrcQW+gKE5c2M4W3UkgpHcwQ3YmMKaO0lfh9LQNsOMHyXR4mOJnfnGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761233012; c=relaxed/simple;
	bh=YCILTNSbyosfdViBsQ3Dn1szo1k9Lccn/kFvybxH4n0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HycWZoTyPIu6OGE/vNMlwvSCfeTLYcllRsA4zp1SFHBOU/+aLuc+zcHUOpIfCefsW6qjqE3xSWwUBifzS8ezIgrcl9tfjWzxCZZ+YZ9ymqFMY2D7r4iimzMTD8kg0oFrXfx+LdiFHj2t8FYQ0lKLy0FP+XYSPZstxLD6pwJhLDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=addQnBq6; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-29292eca5dbso13134145ad.0
        for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 08:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761233010; x=1761837810; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Jd/YojK3x6BAqKg2xzVCUWKgrECDyhwMyyAZSD/iCQ=;
        b=addQnBq6u4m1d4YQyx87rwEkhOeQuRPuWrOJza7CHZUj//K8wYOqPMvyXt7HAfXZkO
         1FBRuqGjEoPPXLI5On83j67UXnVVNEwJoQ/AUSeFtvzwl43ecYB8knAQaJk6yCc8nDOV
         4JcKUdPjO4+yMiWwavK73utMmIYqmVf9BVy9jIh2XB4S0LhYo4kWAsyZ+73aONbLKSXN
         ZbkgLRaxKPV6+OItxljaOfJ7jvzNis4HhG/BiCPjXN7+oGpw2OS8TM2KOMylcgMsOwv+
         xwXAfIA2xU/KN6u0Md2CFTNcquJX0TgRfrDljfzf6Gn+kX70GaD3VQDDoZCXj+H7o5E8
         EZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761233010; x=1761837810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Jd/YojK3x6BAqKg2xzVCUWKgrECDyhwMyyAZSD/iCQ=;
        b=AZPIMhZVmnnv+1+ZssdLnQue1ErzvlMxRKxq544xFE1jXXOnALb64773sMc9cCMTIq
         JtKJN9ozd+uGQBdx3RRX7Sw8nN2/0Ks4Jmj7fsC/yOnls04Iji92pYtAKE+MPNF9blcp
         onjc6VyTj98KL2iRh4II/GEYBN0rxUskcCzWhiToYv78HyP9QO2GfnerWciY3cz8o6dq
         Xaj7F7AD8XSf+ia4F4WIZv2CYV1GXrFT+qSy+nqfctsQ4LQ8xeVdqxgz+fshgapMXXqo
         sHyjXy2M86oWBcbtc/VipFJuAJVt3u5qqwQA5qS8iT4IrcGjwF2CnWT/iDnHXpGkQZqI
         PD2A==
X-Forwarded-Encrypted: i=1; AJvYcCW1/8iODXnGgpp7PxADjscjLvuVQtQM/CAQ1hdBulZa+9zNqyrP32mhh5kXITVVq7sSb9BV6Oc0EQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUnkeExHpZ9ruvf8RC3Egy/sbdlbqKQ0I4gn0A5SCJ4k3whM0s
	5+Hbzr2MYpfUc6T8ZVTd7n8/hbbDrxoEuZUfz1+eVdjz9ZuVwi31x6bv+Ca2q7+4IVc=
X-Gm-Gg: ASbGncvKy4IInDgt3lKxUphvsV9D9Vz0ggjO1wvm4ZhL85nxH4f95JEwid5HxTy/xQU
	zERdLNkmp7Yzvv8OvcK4lZQUuioz5iAlF7vB1zR7K+c2pfJ5Lwo/FCItFnLHsbAPonflqrUPRwq
	4KS6ZFnOn0fLW1MFfD5OJy1a+KSpCQ+AzWeSlS9lWHdnKavOJn8IyEhSwEdIxQJFCrhu+oaKwOe
	+kF2xGySQnUW+d7p++4Zwek2n7xNHubwkrWp1EiqKqj0RVTobOEQcuC9uzIzVr9UzsY8DEZh4ZH
	sLNmLVNiTzEhUKQ00rqqeTe6Ar0D7LQDx6HxFLR+LQ9V5fYE2kII73cfMeVwwj7f3HYFX1xS6O3
	EXR57uJlGhiyO531pPPl1Xf+6IeVlsoHghPX0TYMxfk6yCFTBi6pcdjAkdqIaMr7qz0jfwueTgX
	lX6A==
X-Google-Smtp-Source: AGHT+IHq3h6LfhWY2rBpFaDKhPiyqhG73CHPD/V2qNHnHKDNAg0rCU4Vtju+XrMqjCggiDc/6zvHtw==
X-Received: by 2002:a17:902:ecc8:b0:290:c516:8c53 with SMTP id d9443c01a7336-290caf831d8mr319027295ad.40.1761233009992;
        Thu, 23 Oct 2025 08:23:29 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e0f5de1sm27115915ad.87.2025.10.23.08.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 08:23:29 -0700 (PDT)
Date: Thu, 23 Oct 2025 20:53:26 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Tamir Duberstein <tamird@kernel.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: opp: simplify callers of `to_c_str_array`
Message-ID: <gjlcd7nrmipdpim4dr2kfrk5mleo2yt2btwbhxdflzfcpckjjl@fieqlaavqja2>
References: <20251023-opp-simpler-code-v2-1-44230ed00fd8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023-opp-simpler-code-v2-1-44230ed00fd8@kernel.org>

On 23-10-25, 09:59, Tamir Duberstein wrote:
> Use `Option` combinators to make this a bit less noisy.
> 
> Wrap the `dev_pm_opp_set_config` operation in a closure and use type
> ascription to leverage the compiler to check for use after free.
> 
> Signed-off-by: Tamir Duberstein <tamird@kernel.org>
> ---
> Note: this diff is much smaller with whitespace suppressed (`-w`).
> 
> An alternative approach to compiler checking for UAF that doesn't change
> indentation is to add `drop((self, clk_names, regulator_names))` after
> `let ret = ...;` but that felt more prone to becoming out of date if
> more owned data needed to be added to the function scope.
> ---
> Changes in v2:
> - Avoid use after free; add compiler checking. (Thanks Viresh!)
> - Link to v1: https://patch.msgid.link/20251020-opp-simpler-code-v1-1-04f7f447712f@kernel.org
> ---
>  rust/kernel/opp.rs | 112 +++++++++++++++++++++++++++--------------------------
>  1 file changed, 58 insertions(+), 54 deletions(-)

Thanks, tested this and it works.

Lets see if someone has any more inputs, otherwise I can apply it.

-- 
viresh

