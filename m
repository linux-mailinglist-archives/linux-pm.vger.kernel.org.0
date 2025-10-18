Return-Path: <linux-pm+bounces-36397-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7B6BED63D
	for <lists+linux-pm@lfdr.de>; Sat, 18 Oct 2025 19:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A5C54EFCB8
	for <lists+linux-pm@lfdr.de>; Sat, 18 Oct 2025 17:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719982741A6;
	Sat, 18 Oct 2025 17:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Te+AWMYG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5D326B955
	for <linux-pm@vger.kernel.org>; Sat, 18 Oct 2025 17:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760809543; cv=none; b=NYqEQIhOmTehFxPAdUvcGbFXLMl7bYpGxxoNwHnqiuNwzuW+xFioKjAkrHFiDtMSHlgFYlxw3HnHDhimwfqs2Vlyie0wOSJKwasEZ8Xe+csId+S8e7mAuRCQSeb4yqQgOIduqOqa4KBT06hb6OB08p63XEyT9ST5UW+tekdWeXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760809543; c=relaxed/simple;
	bh=6FtTg88GY2fWPari0/xVYIFZl0LtyM/QigeE2PMN1js=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EgEFCx6e6WYqaFFzJLnJrSte8GWJBv61yOE5qd9Ylv2QEpq1GC2PoSrf3ob5E1AvGNwPQUvm0tdnZ7XhjZS3mbv1jE/W6vZGfrN+jUxqrDMflvmVdlQFe4VPn7+gHcpNgjKYubrwfqT1k5GxcULKqV1v/CO9rx9LJtyFAAXQ39s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Te+AWMYG; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-88f2b29b651so438431485a.0
        for <linux-pm@vger.kernel.org>; Sat, 18 Oct 2025 10:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760809540; x=1761414340; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y+vXAMQTTWEmkUojbXBO1de8JWN1eVf43j81u3Bw1Rg=;
        b=Te+AWMYGSj4tmHOYBRMWH/F8IboP3Q+fCgELD0AZlUws+krH6RV8Uny5ukxQz3qZ1G
         zDbf1wBO+WHp8uZTMxsS1tloD6Z/UZKm08XpSXPUBaGSTWS7u0A/wKUyjqmTY6QeXlES
         gzGcPUk7ptrtj9pZGf6snFqyXY+xKP+nXh1Hqoo+v9OsfjizFEz+LOTrsuj5r1IN73hm
         J2BbU41AcaAyLeo/vKhZ9bKj6HSUWrfbqY6szDlYK8JlSZCimx7J2ATI3auenrdl9xgg
         7BSCJckw7gML719L6q9z9T7wBnIylAoeWwm7oeLl6AYbo5xBeP0fkGGG8o/yYj7GVhHu
         1Wlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760809540; x=1761414340;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+vXAMQTTWEmkUojbXBO1de8JWN1eVf43j81u3Bw1Rg=;
        b=NEJ884VjtP3fPFkbLToPezSK197URl1w5qq/VX4CeVxmEkuw8SCdfXAO9L8p/vuV9R
         tJzfI8PpyViuNA4OtdiQq3QWZN/5Kg3Rcv87/LjTUK/ML65r6UZD/0F8I/T4cmDFJF9a
         exnpui4w4KkJNvAhQpop0HzWQ6dQWI18i0If5SrLicf+MeMdtDztxk6QsMbBN4sxxMiV
         dvHv693ra+l3Aabgw5oAYXBxLZTlYR7GeB1VrQuvQzYaacMgtlyiOOotvktZpqwHDCxf
         pFBY0jB/pQtawClpNAGY2PpUJ3LlRyoG3mWgtpP9oVUhECC0jDqyQbgN9p0g1KrGgA4e
         +9CQ==
X-Forwarded-Encrypted: i=1; AJvYcCUro0d2/S0c1+BkhRepNAbhK+d1dLdzBB8q5vZ68yZaKh8RE4KV5DBUZetlY/qn0sWaQ3IU83FieQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLaVulOjgVIEXwqH7nMi0dG3VkjQl9YjSlOSY/T7kprJ9oYBcw
	Sz6s4nh0dvSVUVmufWXvFLfhaFlXwltyoSx7Vf+uaFpsE8HKp3SjKay7
X-Gm-Gg: ASbGncudRXtdDkZnZm/Y1XSw7sO9/yLAZPrpievs9j0R3zk61s2kSVsCI36F6JbEb6e
	I8tWLpK3B2yUwjM1JsTnVc9VXSEuIMZgQhsfNmj6ZNIKdSi1yEMLBPrCkbrbpBX5rSII/zvYJkb
	JHm00HLMVc8YTQbX+J3N8D8XLqpxmk+9iGDcb1cClkYct882BlYuZsNGjlqoM0eB5sXHEd9LUwR
	YZDeCEHCu6B3aosrxL3Fo53Tv0looL9vor2d2rdFnQwUGHbXoHcMw8yYhuSoDzY72TSSsiXAtTx
	+2BEJtP0cEhKLlnz239V1toKxOKr6VSTK1ey7qOOI860Sh4TM+x+vSRu4hkiD7ZnlIqatUp43E8
	yAYFlNozXLNcAl+EJddwQ/JTu7Nbm9D9U4cJyooWqfDPTSRURx9emrqpFZqFxQzVmSl/UZ4Nx98
	LnOvJqb4IkWrR5IszjdrEBW2lgrIH3ltiZSIdDG+s4Jn4zqQAeiQC4GSVhFQboGtQHBL5Yy7FKI
	POttvwdOJrd8jnXBTAwXjCaoCyiTP13ivQvRIWRtNxuPFdCQF37
X-Google-Smtp-Source: AGHT+IF2b+xiML9xjqA23uk9sgK2DYeECM9Ckm8gu0/pdYUA9bmcAEH6Tg4P0+oRe/HNA9P52OxDww==
X-Received: by 2002:a05:620a:f04:b0:88e:991e:cf2a with SMTP id af79cd13be357-890709e6bbfmr1147502985a.44.1760809539813;
        Sat, 18 Oct 2025 10:45:39 -0700 (PDT)
Received: from 117.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:1948:1052:f1e9:e23a])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8ab114132sm20445161cf.40.2025.10.18.10.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 10:45:38 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 18 Oct 2025 13:45:13 -0400
Subject: [PATCH v18 02/16] rust_binder: remove trailing comma
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251018-cstr-core-v18-2-ef3d02760804@gmail.com>
References: <20251018-cstr-core-v18-0-ef3d02760804@gmail.com>
In-Reply-To: <20251018-cstr-core-v18-0-ef3d02760804@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Carlos Llamas <cmllamas@google.com>, 
 Suren Baghdasaryan <surenb@google.com>, Jens Axboe <axboe@kernel.dk>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Uladzislau Rezki <urezki@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1760809526; l=981;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=6FtTg88GY2fWPari0/xVYIFZl0LtyM/QigeE2PMN1js=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QDmUAuND6Y30l5/wiMpkJH4TDC04JmcQb3JxiK1A28k2upCho1xt+vnLZy55U4tUVIHHZi0W9Xs
 LsFR1ERakPA4=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

This prepares for a later commit in which we introduce a custom
formatting macro; that macro doesn't handle trailing commas so just
remove this one.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 drivers/android/binder/process.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/binder/process.rs b/drivers/android/binder/process.rs
index f13a747e784c..d8111c990f21 100644
--- a/drivers/android/binder/process.rs
+++ b/drivers/android/binder/process.rs
@@ -596,7 +596,7 @@ pub(crate) fn debug_print(&self, m: &SeqFile, ctx: &Context, print_all: bool) ->
                     "  ref {}: desc {} {}node {debug_id} s {strong} w {weak}",
                     r.debug_id,
                     r.handle,
-                    if dead { "dead " } else { "" },
+                    if dead { "dead " } else { "" }
                 );
             }
         }

-- 
2.51.1


