Return-Path: <linux-pm+bounces-30183-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7DDAF9B99
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 22:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C3107AFF25
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 20:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B024F248F64;
	Fri,  4 Jul 2025 20:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SP2YTKq3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1823E243968;
	Fri,  4 Jul 2025 20:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751660170; cv=none; b=pt04eCre8gg/XZenLEwnnjiiKsTGATu6fYqfL3EVUc6pkdZwSIpNw+QaH2XdtG7z26cEmnKuIkwzv52uJvyndMbo4DhhB4oQWC2w0Q8xZhWDSvtKjAClp9Jjy4TAGcaf1YFZrf1r4o7b9z7khsAsBQswan36G37u2fgYoT/YvSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751660170; c=relaxed/simple;
	bh=sfKyAlpcVUQy80XFUpORKTGMx+OCz/EQm3USwht0+Yk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LBVl/L3/Gy+oxIbe3ZIIK1UE42zpS5Y9FlAOTMOHqlLdO2RJOr394U7r5uBhBeKhjilY0NQylx1ZTvD15mKfClqvyGyJAMVPKVrnmeG6VD0+W9MF3Wx9qcKRHNwTBFO8c2oNPOTLDLLRugTwC8t7K60I/hwWJGrZD2M2W4qZ+w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SP2YTKq3; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4a7f46f9bb6so16359141cf.3;
        Fri, 04 Jul 2025 13:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751660168; x=1752264968; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JftnGw2ieRIMfPF9FeFktko6aUdoxCz5p+LPiScYnD8=;
        b=SP2YTKq33IIDli3LjBuPMnhxmTlzpPTD/XS9h52j2n+SLAghxLIpEAOqKqv4NJ5exp
         XGrgexzDBbM8M8ccQBYlR1NeupHh8ES6MZ4M/CrcKMzbUL9EybrjbwGl2zo6xBv51EfF
         uf8BCFSZC753pU2bB1xckM+7JZEv6bin/jokbgCLTf3KubMzwR6QF/fKmO2M7B3QXPcj
         fkBoJJogeu3m8c0562iU5GEPePu21IRjquAQsRO292QbmPo7ti0v/Sc8A9dAN7WVtQmY
         MxggIR2zZA889pI6Zid7YDCIFawQgnUQupjumCuYhn6N0LJYGlecHHjK/c+tgSXqkfTW
         vPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751660168; x=1752264968;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JftnGw2ieRIMfPF9FeFktko6aUdoxCz5p+LPiScYnD8=;
        b=hxSzNwXTvxTGjKgCKUp/Y7bT0ROznMVdy9LpsMvBhRjsnpw6CZaJgcWcnnVE5XBTd/
         JDJNMl5dtS/oU/l/rvnmhZmrdhbk/JsdfUjQBRoAisQ4xExPcwJ+Xd2urrjZchz7aVDU
         JJXGTP0pPaEivVyhsJ2xHUypt2Z2l0v1sRGv9M47YJhBmef7gCul4jWJBjEXzjrDHqcY
         JAns3ooZ6f3MjLqDtdGgLNlOpRNVFaxN1s2CHS7vvP7DD944SJKK3zN0yrQMbNdx6wcq
         etmZBWoJzIsghQzp9bf+xN7Y32ndY5ligL10QjHjz60YlzUJeXZETHdvVYOhAHctdrEY
         CzSw==
X-Forwarded-Encrypted: i=1; AJvYcCUyfEd3mn2xu2b5Q+LYs95ifaci7houZDEYVK+brrmmGyWPqgChpcIEL44mGg1H8vie+BsKmhlvxtx2LQuwmXM=@vger.kernel.org, AJvYcCVupvMl9TtrqgAD2qWqVa7hoWW+tKeOKpRs2AvnSZaQjzPfm5ec4/PDdAQjpbP0nusgLOr5ScW5xhCmnW8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2NyGckBPUaK5ixtHQFxI6qpnc1PtxJXKXOud3mxNZAwKW5GDc
	+JgYByqfLPkyBwbkp3IorcqYWZKDKvQcxk4RI9Ltham4/JWkpQWkh4LW
X-Gm-Gg: ASbGncshw3sD4K0n3eBD/V0I8a1Ol1s2vEcXP/zeQnGG5l+X3LNFvuobhOeC29sSLC0
	P2v8UEUssXH8kBrNo4gmYtbfYdrfbHkwXSU4EWsc5Pl6bn+xM5fsk/0nAuh4irlWiEZQpAwSy0y
	rxjABPcdpdqriQUsD7Ho2JRd7bfnjU8LnS2Sr+Uqe/Bbt1REACALlUmkRfiMLD8gbsm3nezo1a2
	oV2/0/xTa9VBHJhi3AqIrYX97lh9nkBGI7Jzd/y3vDsn12dwsJPZg9iyrNMgWRgD1aDiLxPV7ib
	MKQHZN4+pVjbGWiqdj081aOUQgUTbetIJa0feinW0GPrztOJPPTHoD3HBVxrLsFY1V1vLsqvy4Z
	J2b7aQHuBipmFzfZY+A==
X-Google-Smtp-Source: AGHT+IF1t1aKHOe1fk9iSK6MMX3BAmHjjyKwyg4+tGB5Y4Nti+Dmbb5QN0nFVxAZPfxMG3QwhMXk+A==
X-Received: by 2002:ac8:5fcf:0:b0:4a4:3d6e:57d4 with SMTP id d75a77b69052e-4a99883ca50mr51364261cf.46.1751660167869;
        Fri, 04 Jul 2025 13:16:07 -0700 (PDT)
Received: from 156.1.168.192.in-addr.arpa ([2600:4041:5c29:e400:94f3:d2bb:5ace:77a1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9949e5221sm19772941cf.2.2025.07.04.13.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 13:16:07 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 04 Jul 2025 16:14:55 -0400
Subject: [PATCH 4/6] rust: str: remove unnecessary qualification
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-core-cstr-prepare-v1-4-a91524037783@gmail.com>
References: <20250704-core-cstr-prepare-v1-0-a91524037783@gmail.com>
In-Reply-To: <20250704-core-cstr-prepare-v1-0-a91524037783@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1751660160; l=1218;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=sfKyAlpcVUQy80XFUpORKTGMx+OCz/EQm3USwht0+Yk=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHvRIVvJtq07S1R75iYq2AMmkTap/2F2AhnqArHL10X6H2X/PDdiObvGpzgmEBt9fR6VL1UeMvw
 7vloZt88VjAw=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

`core::ffi::*` is in the prelude, which is imported here.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/str.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 48d9a518db96..f326f0c40ab0 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -232,7 +232,7 @@ pub const fn is_empty(&self) -> bool {
     /// last at least `'a`. When `CStr` is alive, the memory pointed by `ptr`
     /// must not be mutated.
     #[inline]
-    pub unsafe fn from_char_ptr<'a>(ptr: *const crate::ffi::c_char) -> &'a Self {
+    pub unsafe fn from_char_ptr<'a>(ptr: *const c_char) -> &'a Self {
         // SAFETY: The safety precondition guarantees `ptr` is a valid pointer
         // to a `NUL`-terminated C string.
         let len = unsafe { bindings::strlen(ptr) } + 1;
@@ -295,7 +295,7 @@ pub unsafe fn from_bytes_with_nul_unchecked_mut(bytes: &mut [u8]) -> &mut CStr {
 
     /// Returns a C pointer to the string.
     #[inline]
-    pub const fn as_char_ptr(&self) -> *const crate::ffi::c_char {
+    pub const fn as_char_ptr(&self) -> *const c_char {
         self.0.as_ptr()
     }
 

-- 
2.50.0


