Return-Path: <linux-pm+bounces-36620-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7761ABF9E72
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 06:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3673C42772F
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 04:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12C72C21D8;
	Wed, 22 Oct 2025 04:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iFw8Gssu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F1F2D1931
	for <linux-pm@vger.kernel.org>; Wed, 22 Oct 2025 04:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761105707; cv=none; b=dckG0YXhRsDMtPNPsInUYn4twcTo90u4vM3Cbh5ARyRR1/dM227MPMcmcbMaA+X9SRupNTH6ZfK585we/xKQqZdoOenMZN2lCTvG7FwEXzTEmtyQQiozV1RMuU8urwvqFkciYViqkppmiXX3knO5naGnxRQiQL2jvpSUMF0CDO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761105707; c=relaxed/simple;
	bh=9jY3EA5gEkdui7bFU/atDea6tp+oL2Xa05/E1ZXf344=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+HmVPzvJd+ZUTZHwVgE9vkvd5XoxdCG4O9s+J7xfnRw+1NMPG+MozCK0WuWgtFMEhsRLhUQ9upVHOQKqEIFaUNn2M2EsI0O2YGJ9/IF1VN5gzhSN/Nq5Vz+0UueXkNbjk9nhE8CDCS1uTCXH1gKCRlzfvI6MhKCMDoKoCHSg6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iFw8Gssu; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-27c369f8986so62215385ad.3
        for <linux-pm@vger.kernel.org>; Tue, 21 Oct 2025 21:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761105705; x=1761710505; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5XEGeI2U2r41+s29akUYCWbcwFKMTqkQOw+6CMAYMfM=;
        b=iFw8Gssub0rHLihQtmEQ/Py/Rtd0e0Q826rqACMtralrtUXw5FLLIuwfqr+fSyv3Ac
         1fH/5SRTMeCM9vG6TIoj6OFUS+O/s3PgFqMQXwqxleXqoIupf5/h65xAR9gv3cuSVElx
         PY+UEN8qoZF5rW0PVx6Ll2Yy6/DegeLAoSp5wA2pAO+k3HcbqWX6LWMM0sWqrnBntCn6
         xdnqvYfXboFd6mfCMC49Py0MmynGJcSmCWl2oqToAheHUCr8b3FoPmeTcLrlBpe6w4oU
         kdfx2KenWYD3Cqblcxs4S5JPijSu33S44Vq0qJHDlwFFuSr221qiGHJkvVBBy3Oal/Ov
         HToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761105705; x=1761710505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XEGeI2U2r41+s29akUYCWbcwFKMTqkQOw+6CMAYMfM=;
        b=VOn7jBIz3Tc+C7cAC2EUiyx0yTsSTE+8u9785wxZAiuQXhwkDhJYOzF09g/aDLBdXE
         BdQIwXM4t1ZbgF5HmmR8vMeZI1j9nQLGI0RwwDruQtKE9QSuXU2fTYS5B6Dz8b9fEbfH
         K2uCo0Y3cxdmdSXNg04VL3AwRNR3y39QXlWO40/JE1dtnOYNaoWyXSRVbNAgHISaHrMZ
         O6ASCYQx+sfvEKYLBN25vxEajYqEPGPN8BearRWR5RPIQso2V0Jl0jRooIuQJEsSqDh4
         GaxUeq+R6F1QfuPHUFKcNm2oukM/zZIw8AjPbbjTe994j51FnA0nCnXMPOgkhUGxj8eZ
         /2SQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQh0rPjykWvEm68jVbIgwUZRM22vppQq8XNTcmVN6eRYcmoZQeE638HmYXPQY+ssra5UqlCAOKQg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv3PvL3zDlc3vY1xA/enUSN9O2mVduC/Q/9q5OJVgu1jUgDPsh
	FN+yVB0JrzVA4Pl/82FEqhtPJV0sKeqfKBcvoGwWUgfWUfS3GwwS5XlxQVI+PNqaAp0=
X-Gm-Gg: ASbGncsAArt0m4UAe0htnfCvKtGgwlcBU+78T89VgWggdDuqilB+UgbOwDAxEAUoljo
	8TMKRXjdPatXvba58T+ivZCG4lWnDOwB57I1pmSyKTrpBf2vx7Pm7gAXv+HZnMRzAmVGVhGVrKB
	2gx8T6U3t4NBpyQr94FkEZzw9iaAO5loKf3vxzfRhKIASS4lurJMGOm7SIQFfOHgjaRqy/gLkBr
	stJbUXOm3kusXy4yJMn2f7WuNmXf5+cuxmAhKvqTh+VAIJCFOJMtooQELmkuJAAeM6gLL7R7q3B
	Y94KplJbTtpmHIy3ETNhRgQB2pD847wXB6eDEf15Fqi2sk4GC4AUo2Qu3SKlfQSiJ7k9x7qRM4N
	owZwcxBmI7kGFFGc5wDjt+hoxEA9Pxo9PCXM1XUTQ+enVbqtAnuvY/pj64UyLgCB5EX2aOWcsg6
	N2CfBoKD7PUKan
X-Google-Smtp-Source: AGHT+IEYWTGPLkVLKAMGZYnPNOk1bG7CyHUMxRahoDXL1MDVvSzLtlyzXLVhQRT4L6q1WhaGPTRqNA==
X-Received: by 2002:a17:902:f70f:b0:290:2a14:2eab with SMTP id d9443c01a7336-290c9cf8f2fmr233326615ad.11.1761105704778;
        Tue, 21 Oct 2025 21:01:44 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292472193acsm125225365ad.108.2025.10.21.21.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 21:01:44 -0700 (PDT)
Date: Wed, 22 Oct 2025 09:31:41 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v18 11/16] rust: opp: fix broken rustdoc link
Message-ID: <bjoulx2acrfpnqmwmnamunihzuaakyk3i6m3gvtcxklssmznt2@azfbrjhiedi3>
References: <20251018-cstr-core-v18-0-ef3d02760804@gmail.com>
 <20251018-cstr-core-v18-11-ef3d02760804@gmail.com>
 <gcdcwpotzidrksmsnyvesnojcylbb2fqpiue4fijhj2cmayli5@7lpyessslxka>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gcdcwpotzidrksmsnyvesnojcylbb2fqpiue4fijhj2cmayli5@7lpyessslxka>

On 22-10-25, 07:57, Viresh Kumar wrote:
> On 18-10-25, 13:45, Tamir Duberstein wrote:
> > Correct the spelling of "CString" to make the link work.
> > 
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
> >  rust/kernel/opp.rs | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

I have instead applied this one now. Thanks.

-- 
viresh

