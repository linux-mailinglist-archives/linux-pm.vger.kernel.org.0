Return-Path: <linux-pm+bounces-20808-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC234A192BD
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 14:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DB1D16C234
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 13:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A5B212F83;
	Wed, 22 Jan 2025 13:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astier.eu header.i=@astier.eu header.b="D9MCAh+x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sDkzR72w"
X-Original-To: linux-pm@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBEA211A31;
	Wed, 22 Jan 2025 13:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737553199; cv=none; b=X4OcG388airxp5xRPtYObEIapOcNP/4ow8djgGrhxJenmEZzXYgNKOM87cl85Q04xiosdGCjbB0Uo+EqgPnJKS+pFFMVe8wW6JthmK7L2s6kfK5YWdZgmcbN7CGQwb5CFsdR0FQCOvemtWVDJr1kpQlhCnwewjBioigUKMM+kcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737553199; c=relaxed/simple;
	bh=nJ1qmGLyQtb4yV8ajvn1zrGXGz0t4bV3sm/1q2WXVDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nuBLNcqP1YzWXpq8ZPoOSDPdSIod2uFqI8XMnELprAopPLwSopMjmyP5lsDOFCMysyEoYqd1YoaFNOo/slu6xSc/e24T/n+tldwn1k4j+3vue8WtXvi8lOGoPXre3NciNL+bukx4cpMR2ZJlkvMzzuKUKaZpPoI+1bCSthBBp6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astier.eu; spf=pass smtp.mailfrom=astier.eu; dkim=pass (2048-bit key) header.d=astier.eu header.i=@astier.eu header.b=D9MCAh+x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sDkzR72w; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astier.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astier.eu
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 0620B138029E;
	Wed, 22 Jan 2025 08:39:57 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 22 Jan 2025 08:39:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=astier.eu; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1737553197; x=
	1737639597; bh=9XTOuHU1krjox5MI4CtiJPj+ohcAVmrgkb5DXphKy48=; b=D
	9MCAh+xX6k/h6GsQT+6e9FvdDoT2clPg11iEMBH+80SYO6n94Zfee7aVdg5ee2Tg
	Rnbkzy/L8jKFllXYzK0ZwsmAYqPAatr3A/rPv6urTr77rQxF/olryg/Nvup/ZRvR
	AdEirA/dYRZC5sBiIRlyXsgcLFI7tSrWvfCreAfItdX94p8pddnF/UAVmUetw+iX
	/bAao62P65Wp4E5MVgqhA5P8/PJcp9PL12oRzTjf5WoL8RXQxhxESgAEiDPxHW9m
	3R1wfyWCAbb983SzbBBB8N0T5BpMLeEdcw81aFg1jgxoIuGfNwxYzYxOAunnnt48
	ng+KLZ4z23DRRAvMLTjJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1737553197; x=1737639597; bh=9
	XTOuHU1krjox5MI4CtiJPj+ohcAVmrgkb5DXphKy48=; b=sDkzR72wE91eQslWS
	GlT70qkMtdwbV5QDv79qZv9hAT9F2u8Jr31XeDEHISQ4oH9Idjw0TOkgOXFe4UlK
	zSDJLWzuFS5Dvy6Z54ujCJSnzLVY6FRRfKMe9vQLBFOICh+S9r7W7qaVzk9mQ0oj
	1+Y8UI1gBQk7FJul66fcOZmxX3Z6rN8aEJsFpNiLr/nbkayK2YZdMG0i4uJi+kW3
	Sy9u0cuqw7EufRlMqKdGyjhI4aRi+0Dy3JG0iqxG5vvmBVfGMSypD/0jnT4jMKzz
	DGRomkR6tO9qB7B41a3xe2+aVjacuZ0UdAW5OtQDosyBJJq6yHhyyljeCtyNBzU4
	/qJWA==
X-ME-Sender: <xms:LPWQZ1riR9ruxfSGsUVnNnx9UwaVGURsYxoV85oKDR0HESNDf8wNIg>
    <xme:LPWQZ3pY5oQ_WdXBKj5pFfaR1b0RexJCMseBXVrIG8jbK4eRr82ksMPQON0S933ry
    THsUTTRSYJZOGWJvWI>
X-ME-Received: <xmr:LPWQZyOgad2UJROrMbnOpBa_bC6TsmWQeTUR8Ei0vm4iXZfsVgE1DHcM6ogroJvmseiluton0AgVfN4HPKa33Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedgudektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeetnhhishhsvgcutehsthhivghruceorghnihhsshgvsegrshhtihgvrh
    drvghuqeenucggtffrrghtthgvrhhnpeduudduheffiefgfeekgfehhfdujeffgfeffffg
    tddvjeehveefveeuhfehhfetfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrnhhishhsvgesrghsthhivghrrdgvuhdpnhgspghrtghpthht
    ohepudeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehvihhrvghshhdrkhhumh
    grrheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    grlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghoqhhunhdr
    fhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhord
    hnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhm
    pdhrtghpthhtohepsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgvpdhrtghpth
    htoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:LPWQZw4NAGv6QGBm7umcYJ2J2_RtFzpTuMvUQdjRKBe9uiZ7GEXoqA>
    <xmx:LPWQZ07n6wMHSQ029OS0gekCBScgq4X71m2ODAvB-09qtckyUr-WlA>
    <xmx:LPWQZ4gsEP4L2n_4DuV6Nb2PrcX032q-YfkFq3e053yWyL3herRlrQ>
    <xmx:LPWQZ2634iSBIdSyIKwdBGMqW8GgDNPSXTgoxpATqB_2O2GY6Dm_xg>
    <xmx:LPWQZwqkIKmJBh7ZeEZYNEF_llgZzkpvSyPz_UxDaPdjrRRKYDeq_jKr>
Feedback-ID: iccec46d4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jan 2025 08:39:54 -0500 (EST)
From: Anisse Astier <anisse@astier.eu>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Anisse Astier <anisse@astier.eu>
Subject: [PATCH v2] rust: macros: enable use of hyphens in module names
Date: Wed, 22 Jan 2025 14:39:52 +0100
Message-ID: <20250122133952.501055-1-anisse@astier.eu>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250122131812.466080-1-anisse@astier.eu>
References: <20250122131812.466080-1-anisse@astier.eu>
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
Hello,

Change since v1:
 - rebase on branch rfl/staging/dev

Sorry for sending a v2 so quickly, but v1 was based on the wrong branch :-/

Kind regards,

Anisse
---
 rust/macros/module.rs | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index cdf94f4982df..1eff30d2ca6a 100644
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
@@ -298,14 +300,14 @@ mod __module_init {{
                     #[doc(hidden)]
                     #[link_section = \"{initcall_section}\"]
                     #[used]
-                    pub static __{name}_initcall: extern \"C\" fn() -> kernel::ffi::c_int = __{name}_init;
+                    pub static __{name_identifier}_initcall: extern \"C\" fn() -> kernel::ffi::c_int = __{name_identifier}_init;
 
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
@@ -313,7 +315,7 @@ mod __module_init {{
                     #[cfg(not(MODULE))]
                     #[doc(hidden)]
                     #[no_mangle]
-                    pub extern \"C\" fn __{name}_init() -> kernel::ffi::c_int {{
+                    pub extern \"C\" fn __{name_identifier}_init() -> kernel::ffi::c_int {{
                         // SAFETY: This function is inaccessible to the outside due to the double
                         // module wrapping it. It is called exactly once by the C side via its
                         // placement above in the initcall section.
@@ -323,12 +325,12 @@ mod __module_init {{
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


