Return-Path: <linux-pm+bounces-20806-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1185CA1923A
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 14:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E50A33A2136
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 13:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D21212FAA;
	Wed, 22 Jan 2025 13:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astier.eu header.i=@astier.eu header.b="x/FV46x8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S/GvuI9W"
X-Original-To: linux-pm@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D06212D65;
	Wed, 22 Jan 2025 13:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737551910; cv=none; b=kPvN56Av4/leD2/CnokQcf4ocD9SMnPG8x9yyL1fpkk+rF8yOS+i4dGweGZjTvu2cuZ+/E+1uVlaFOM5gb3yLP4Xb4NHt7tuCsbToIdcC8cH8/a94EMdHiLKksNdEzTysdqVXAzv3tRzVYZtUIuf+7skKcdFP+6oIQqXZnFTClg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737551910; c=relaxed/simple;
	bh=e3pDpNr7LIoemvD8SJUiR6qZvNZ6sWOWHNa8uQlKNKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=taznpjakukAK9zXzQAp+JJoVX8Rwv78eSclZmijnWeNhN3heYsEHDYOCEKJricHnV1onjhAydQvbSgBsEBD/k03VyP9V+aK1NlMU8Nr9Sv57U8XyQuaFlkmWLMRZ9Kn5SpQuZSLFny/GDD2kLVBIjBwL7HKJwIQ54nfY9yloqEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astier.eu; spf=pass smtp.mailfrom=astier.eu; dkim=pass (2048-bit key) header.d=astier.eu header.i=@astier.eu header.b=x/FV46x8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S/GvuI9W; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astier.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astier.eu
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id C349E13803A1;
	Wed, 22 Jan 2025 08:18:26 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 22 Jan 2025 08:18:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=astier.eu; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1737551906; x=
	1737638306; bh=ontZw6X6IBvgguBLzJzHhiOahNo6LTFDdkuotxFXsKw=; b=x
	/FV46x8i62D2lfhWdPCwUmcCStMmMZ/qlFaTiXIby/EVS68hSEWi6JGzkuhJKXzB
	TbA5I48BIdKb3LWj0L+KN9DTPtUo/T2uugsCdE9cwMK7gjnv0AYE7EThv7FHWqgR
	dSIR2bQMWb6hbBR5V0G4ek9yndC10fkia2IjC2w7+NzL7nV1LlDu/QvMU2T/3MTB
	siwNe3EU2gqm/z2d9vh2X0arSx4s4X0xo1iH4DYrqezkc16OEYgaPA/KlMWNKZ3F
	gshNPPmcRMHDNSP3pdalb1bl97NcNHDvLI218WAsTC+xoeJq9y5LGTNBrogShNM3
	lvKO5P5L8y7VQQtT38mRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1737551906; x=1737638306; bh=o
	ntZw6X6IBvgguBLzJzHhiOahNo6LTFDdkuotxFXsKw=; b=S/GvuI9Ww/CpMZl2b
	JVCJWahK3A9k86Q+gjGEDzv2CXrEwq6D5H0wRJT7ffkYgmGznkgGj1VMFUgdYSR9
	WKjuqkPs/jpmxPih1e6EzQcKfRLnd0B4kmKikVuTBJkwfaxlzmI7kZDXiQc8hbZD
	Fq/z+dSWpxcn+kKMGNN1si63+wCIzKVlAIUuy1B1lsyCjdYuToCRX5D9Qo5y5gdT
	blTFrGg1KN0Ki5UGQpEJdaSV0RBp3eHaa2/6NUtJgk5geH1Vx7qMm76gl5BLnoKC
	8RNJ6oqQP0SYATo3xVF0wz/BS/gGBdejQ9p0hTdQhyZDArIfbdrRizeR1tFqAExJ
	ovwFg==
X-ME-Sender: <xms:IvCQZym6WBrowh9VfJC3ipp8fWakYF-WADqcUSRZd5SmkELU2foWag>
    <xme:IvCQZ501ymKLYjKmbvE7VxreqQffKLQzAvK34XDGZIkYLqst2bvdkbal60k-X6fl6
    DEk6VFBueebRTxGNvA>
X-ME-Received: <xmr:IvCQZwo6YEal8xZZK58ER2tgwrJGlf6rmS3hO2numi2S9BpXHnMtu_wRSt0Ovr75iIW7y4zRfLJ-XHCNoQ8E6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedgudejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehnihhsshgvucetshhtihgv
    rhcuoegrnhhishhsvgesrghsthhivghrrdgvuheqnecuggftrfgrthhtvghrnhepudduud
    ehffeigfefkefghefhudejfffgfeffgfdtvdejheevfeevuefhhefhteefnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnihhsshgvsegrsh
    htihgvrhdrvghupdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepvhhirhgvshhhrdhkuhhmrghrsehlihhnrghrohdrohhrghdprhgtphhtth
    hopegrrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgig
    rdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopegrlhhitggvrhihhhhlse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopegsvghnnhhordhlohhsshhinhesphhrohht
    ohhnrdhmvgdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtg
    homhdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphht
    thhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopehlihhnuhigqdhkvg
    hrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:IvCQZ2keOd3XVTaUp4EhsDJV3JMJTTYX8wabYpIFsKe6vV5pE_Icmw>
    <xmx:IvCQZw0NtNVVHPCwpIDD7AAjmIvrGGtQB8DV7cUhXuseQvK31C1TPA>
    <xmx:IvCQZ9vYRZC66i0k7fWQ9--zeFZXSgTvg6hVTL_JkfQpECqu8QI3vw>
    <xmx:IvCQZ8WoE3VfKZsj1olWMOPaJ55sewY1r_uNUbaWbsLQT4RnmzvbZA>
    <xmx:IvCQZ5Fzg48FiqZELcZ-fENFyWGREzELyV-BLUTLWk0cBv7Ls00xbfUk>
Feedback-ID: iccec46d4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jan 2025 08:18:24 -0500 (EST)
From: Anisse Astier <anisse@astier.eu>
To: viresh.kumar@linaro.org
Cc: a.hindborg@kernel.org,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	benno.lossin@proton.me,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	ojeda@kernel.org,
	rafael@kernel.org,
	rust-for-linux@vger.kernel.org,
	tmgross@umich.edu,
	vincent.guittot@linaro.org,
	Anisse Astier <anisse@astier.eu>
Subject: [PATCH] rust: macros: enable use of hyphens in module names
Date: Wed, 22 Jan 2025 14:18:12 +0100
Message-ID: <20250122131812.466080-1-anisse@astier.eu>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <5c93f6aaff0bcbc907d14d3a74ee5073fa135a07.1736766672.git.viresh.kumar@linaro.org>
References: <5c93f6aaff0bcbc907d14d3a74ee5073fa135a07.1736766672.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some modules might need naming that contains hyphens "-" to match the
auto-probing by name in the platform devices that comes from the device
tree.

But rust identifiers cannot contain hyphens, so replace the module name
by an underscore anywhere we'd use it as an identifier.

Signed-off-by: Anisse Astier <anisse@astier.eu>
---
Hello Viresh,

Does this solve you problem ?

Regards,

Anisse
---
 rust/macros/module.rs | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index aef3b132f32b..4cac332087b0 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -182,7 +182,9 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
 
     let info = ModuleInfo::parse(&mut it);
 
-    let mut modinfo = ModInfoBuilder::new(info.name.as_ref());
+    /* Rust does not allow hyphens in identifiers, use underscore instead */
+    let name_identifier = info.name.replace("-", "_");
+    let mut modinfo = ModInfoBuilder::new(name_identifier.as_ref());
     if let Some(author) = info.author {
         modinfo.emit("author", &author);
     }
@@ -292,14 +294,14 @@ mod __module_init {{
                     #[doc(hidden)]
                     #[link_section = \"{initcall_section}\"]
                     #[used]
-                    pub static __{name}_initcall: extern \"C\" fn() -> core::ffi::c_int = __{name}_init;
+                    pub static __{name_identifier}_initcall: extern \"C\" fn() -> core::ffi::c_int = __{name_identifier}_init;
 
                     #[cfg(not(MODULE))]
                     #[cfg(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS)]
                     core::arch::global_asm!(
                         r#\".section \"{initcall_section}\", \"a\"
-                        __{name}_initcall:
-                            .long   __{name}_init - .
+                        __{name_identifier}_initcall:
+                            .long   __{name_identifier}_init - .
                             .previous
                         \"#
                     );
@@ -307,7 +309,7 @@ mod __module_init {{
                     #[cfg(not(MODULE))]
                     #[doc(hidden)]
                     #[no_mangle]
-                    pub extern \"C\" fn __{name}_init() -> core::ffi::c_int {{
+                    pub extern \"C\" fn __{name_identifier}_init() -> core::ffi::c_int {{
                         // SAFETY: This function is inaccessible to the outside due to the double
                         // module wrapping it. It is called exactly once by the C side via its
                         // placement above in the initcall section.
@@ -317,12 +319,12 @@ mod __module_init {{
                     #[cfg(not(MODULE))]
                     #[doc(hidden)]
                     #[no_mangle]
-                    pub extern \"C\" fn __{name}_exit() {{
+                    pub extern \"C\" fn __{name_identifier}_exit() {{
                         // SAFETY:
                         // - This function is inaccessible to the outside due to the double
                         //   module wrapping it. It is called exactly once by the C side via its
                         //   unique name,
-                        // - furthermore it is only called after `__{name}_init` has returned `0`
+                        // - furthermore it is only called after `__{name_identifier}_init` has returned `0`
                         //   (which delegates to `__init`).
                         unsafe {{ __exit() }}
                     }}
@@ -369,6 +371,7 @@ unsafe fn __exit() {{
         ",
         type_ = info.type_,
         name = info.name,
+        name_identifier = name_identifier,
         modinfo = modinfo.buffer,
         initcall_section = ".initcall6.init"
     )
-- 
2.48.1


