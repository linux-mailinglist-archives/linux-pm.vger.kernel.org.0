Return-Path: <linux-pm+bounces-35350-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D88B9FC06
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 15:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A0E61C23CB0
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 14:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD282D23BF;
	Thu, 25 Sep 2025 13:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcYXPhQt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590EF2D1901
	for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 13:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808520; cv=none; b=cdjI12R0K9IYApEgIUVvSsoqWoH6lm3nwETo3ZN56aFaeS0AtYzYEU83PprDffwn37nblggCIJLmUtA0S4ygDtds9stpmq4Ye/42pQq/MCtClko/iYOTt1BT0yBGMa7ptZ1IX8P0VsdzcygKX3DAKkGt0EBTm9r+OwovZn2R+0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808520; c=relaxed/simple;
	bh=zng85sA8+SsVec6zNo4TiEoP/H6f+tIcV689AAppDzE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KtYIref3aZUPJQK74Yhi9G6RAGouzzrl/GEbf8HQprztWoZTxjP8oH9qCqH14DNXuM20wjDKQ1+jz3Spd2rffew4geGTXhre5HweSVPGjeCQVnbTAcDAqmuzJZdtwEbDrrtNXDubH6kp372r9qIIqNJvduzFFqAIZQVgUORtU8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EcYXPhQt; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-7946137e7a2so8794226d6.0
        for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 06:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758808517; x=1759413317; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NYha/ksIy3nvgxYlzdJIQEddJjIGfcGOB5STOc36XYg=;
        b=EcYXPhQtkXXRN7OTov2ez9YRzmFF4pdKpT+1C30EZOesc7+986YR52Y2wti6MkR3c7
         E8wqFyf8rFflFZMsomMVUqAqz1qa0lDKweu8x2Hwoi6G/KLwNmWUHtKHWknP0LAKERIB
         qMqkB3kyT1A+QER7Kwr+6/CqyEx6z9jkqLgfoFYHFadzVK7y7OSjSIg98jsY8qrT0iKu
         Jq8vHlWdf7tS/YJ8nkzFo6oKXWOe71Th1wxLuNx9NUXVG9DVNzfkDe4ESx9qcFPB97zB
         lGGXENCy1LWY6NV0oA4kkcAspPFsx5oGFhffY8U2rg5Sdkp6fhIg7Es67gPHi0HRhYVb
         TcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758808517; x=1759413317;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NYha/ksIy3nvgxYlzdJIQEddJjIGfcGOB5STOc36XYg=;
        b=BOApiCJd2Gn/NXnNzzWcJGdwaEWNCGl5EiQpcmrw2JzraWd693IYMizLhZP8pkdTFG
         gWVevlhajRWZyTkfAZ509EeuvYkIfdLloHqR8YHhKBkfT7bL7W0wJ8rxdY7D+aubqYOL
         M01/pWLmLvFSz1N6uU3IVxkae0gun2a2F8w/bOfUPiPjOBWNW2h73/NY12AXiihBabe+
         BaaOUTQGNwMrDmZ/kCCN5zAqVjxpTamVluJ8533vF940n1tyiikNUViE+UgOCoc8hbRM
         PIdsePdtlVHhhHDemtXYnToDSZn2bpJHcJY7etdXzm5MFUc9l+jrQ1yoA/Uuyu1C/2p/
         e8Ow==
X-Gm-Message-State: AOJu0YwLKV6k2qEBYbYU7d5bUWh+ltLrAV3eilEnuskg6o5xKkjO5W84
	26uPmFesoHApU/eV8TbDYdqA3s6x9xtecNnPKzlDYeu5r3Gp8jj/GKbO
X-Gm-Gg: ASbGncsOqI9SFLK0KhSX1iLPzY6V0p2W0UMDAzhZ+8EGOpeBcEqRAseQJObWQhiOafS
	rod46BCwbaqHlEksrHCPfZp7XYbGErlnzSe62IJe1BqJyV1JfIV5+I/CAomBFE5HvAfXhPSli4k
	wnCFQA2Z5KWHi2TcWGPs63+WEvDTjvZCMlrnX3Mx3Snf+ZYdu8HiRE1munfK16Ko8LVEJyJ6LSX
	FB0s/FsK6Y5Ip+2HunksW1YMp8zUBDM7PMOqDmINmgMuH1ZwAFUaVcSvi3iyiSRdF1aeHpdH4X8
	/zwmg2M0gvJQJ5AFVpI4nw9gxT4ItmK/TygL+mK1s2JTJyAqAikb30+pNkS2vQxCR3qTTysePZ+
	LkgPMYW85MgVqsGMsQzXMpl5qAZwdXVrl0m5scw14FbUjY5iCUWuVN+KJA7iyV+sQ/NoP3qBN44
	Lszlk1YAmZeTdNk3EI+HKKz8839ns2YdSoOSaLckw0kRGoAtD/Ohm7DKy4XodfrXDYOyZh
X-Google-Smtp-Source: AGHT+IEZqYEZb8mISdLJuHBwRf4k0Tn3piTiphxdju20VgZskXS1fQZSSYTbb7BgZgibnFeCDmQS/g==
X-Received: by 2002:a05:6214:27cd:b0:78a:e10c:1f6a with SMTP id 6a1803df08f44-7fc2864221fmr42029446d6.1.1758808516914;
        Thu, 25 Sep 2025 06:55:16 -0700 (PDT)
Received: from 137.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:7c:b286:dba3:5ba8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-80135968d5esm11536916d6.12.2025.09.25.06.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:55:16 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 25 Sep 2025 09:53:58 -0400
Subject: [PATCH v2 10/19] rust: macros: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-core-cstr-cstrings-v2-10-78e0aaace1cd@gmail.com>
References: <20250925-core-cstr-cstrings-v2-0-78e0aaace1cd@gmail.com>
In-Reply-To: <20250925-core-cstr-cstrings-v2-0-78e0aaace1cd@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Jens Axboe <axboe@kernel.dk>, Alexandre Courbot <acourbot@nvidia.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1758808437; l=1049;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=zng85sA8+SsVec6zNo4TiEoP/H6f+tIcV689AAppDzE=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QIVNC06tKtgyxIKxAK3EObC8MiCaZE3yn180AX/LsynQ5F4vys0WrFsiwfjmzPM+0UA7iPHoZU6
 G25wrGtAh8gk=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/macros/module.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 5ee54a00c0b6..8cef6cc958b5 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -228,7 +228,7 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
             type LocalModule = {type_};
 
             impl ::kernel::ModuleMetadata for {type_} {{
-                const NAME: &'static ::kernel::str::CStr = ::kernel::c_str!(\"{name}\");
+                const NAME: &'static ::kernel::str::CStr = c\"{name}\";
             }}
 
             // Double nested modules, since then nobody can access the public items inside.

-- 
2.51.0


