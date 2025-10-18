Return-Path: <linux-pm+bounces-36404-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 01ABDBED673
	for <lists+linux-pm@lfdr.de>; Sat, 18 Oct 2025 19:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A053E346528
	for <lists+linux-pm@lfdr.de>; Sat, 18 Oct 2025 17:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D3A2FB99F;
	Sat, 18 Oct 2025 17:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHG+AFkM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB83C2EC554
	for <linux-pm@vger.kernel.org>; Sat, 18 Oct 2025 17:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760809566; cv=none; b=aTgeCdnd8fw21QT0JG8d+Njlrd/ix0E/MQ4OOh8BcIuJ8K3tFb6Qw0mqyCDgOkYxub6zlE6WcNA7fVyo41ffsg/HRiyCkEzOJcTMID1JwW0p2is+kXRDDFN4sn+7K9oqWx2gym+iEfLrY2u4ODOlWqXgkm0HlBZsO/WnINwwkOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760809566; c=relaxed/simple;
	bh=uLnXUd5iHMMEJTAMJKY0bsxZkX3e5rGAkuIO16n9SP8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oaPMZiKnzvW69b9xHU8eQ7D39Z9Pz2yu6u8oXK8X5F4iYpS60lOkogIiBr+UOVRfWfuxpUsgugTGNrs6w+AfJym62OHl7xvv9oF1NfXUTAPjnXRMC2G9yHlfRQQemoc3hughdoohSpBdtd7ErC50zSijjAVNn0SMPeIyAXFDI4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHG+AFkM; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-87bb66dd224so40543096d6.3
        for <linux-pm@vger.kernel.org>; Sat, 18 Oct 2025 10:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760809563; x=1761414363; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ycwx31K2mxLEujn4A81pZPUGOjv1ArmgOKcrq9XGsoU=;
        b=lHG+AFkMbyufoj+SWOxxS4Jlzvye3+ZRVR3Wqpp8AfEOyxhL6mE+AOcVUJ4AiDmGLo
         1zhxrXq0n/n7BN0pZHr2D/IT0qYPM6Xs7IMW4VddAkyMUlyWQru1bVTzds4jFXGiH4OE
         vEe737BsPF3vXZF9wUdFgnj92fXmR16e/txtYSxdRajM+5jwe0cKQD9f2N/zenHtA/g3
         YPHhTMxWPUB90rIEpcevr0hUWrU37oC7li/e+I0Xi1MvMy43keNy36zeW2JTJ+X/1wMv
         skmkD+LA555N1oOfWNasqygss72HyIrUfzboyc6cYQkeAS/qMqMyT6p8eUyi8TlQbY5K
         YC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760809563; x=1761414363;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ycwx31K2mxLEujn4A81pZPUGOjv1ArmgOKcrq9XGsoU=;
        b=kCiHR4pJwK0u3GwiLZdhpxdFG2WxelbTBnK292S9yt2uY6A3bdw1VECk3k72XUKV9l
         AwJd73R8ztr1CP1z2HhYBOfKfQe7E2nZfsel40Nl0qCmHhfJsjbvHExfstayDW60X/Mo
         G45zgcvwfwaS3McwtvglXSz5/GI01if1Xqf0E+P3/af3J1jRnNe/eU69TSxiAANb/3OJ
         jjNpKiCLDO4e7bj/vZrIR/H2RDvYBkARkvivebDY/Ar1qjNVvJxiCnVDnkFjcXxj0yMY
         gYbK2QtN2E1jGgNV/Tf2mOl4X2DXIxi+G2jRjwT2KwDu5DK5XzMNy7TMyVHqo7mcQ32g
         zhyw==
X-Forwarded-Encrypted: i=1; AJvYcCVup3aiVHsmaXL313BXR+ehMZpO4nCFni21XtHH9+BWYBSzA/MSjQhQ3UbBp1diGeP2KfVMza/nUg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwmlaSMkBUvDeXzCCB8bvcOx1i79ynUU1ew2VsAE6dlNjpd2tf
	6cRp9Dq3nCmjCmA03LzHFE6oLndIwK9c5aubropf32f00TXtDExbGlXc
X-Gm-Gg: ASbGncsmvirT0ro2aQz9berNzM1i6Z3OUJUdlIdVNfzMpFKd1fxQJcMb7SNnDe787Pf
	vXemQl1IzJBC2mMVOl29WRyDwoMzDRdSpxNTnly9j+eJXtlgKX9celm2zL3cPnO6mDSNlcbnU2y
	qoEgvYQM1nJWGqcD0jipUe9XzjCBx12lBLwIqnqxyWRJsQtGeHALph9GNOhMFaNL4Id0klUljPU
	szMQnUjLjY31KzWXhPQChozD6EqAZMBEUBn92hJJoDwWN8inNc6pz4zvY4nNxO+qULap+JnHXHC
	frDu+0Ag5/UCQVSsmVmZ/26w0Vf8XZZ1U4SZgMyr444imsoNv90DGOBR/dXvMaa4XqYcdBmRBer
	bnInF0jOiHfOp9IEjFeScz9mzued/oagMn7GobA2BrxGhgtHyoJTw6pDY+yNcBYh8doipRBxmHK
	/f1mPXIKVLKNBPqQFjGjnU87cse2Qzh/Lov94arRMLEljIwalSnd/PlhDKJViIcqRM9vUi+9NN0
	nfkomTIz6/dEY+6P6PQxl6jCO0ctRdAV2tfJGH/KUMNC74bcOzqz1kxzePp/O30E2VQca8ULA==
X-Google-Smtp-Source: AGHT+IGG7z7f3MNU21/Rti4PmtrZca4GFxKfblibRIkboUBwmpGvzYHP42u9XCSh6vTqFJ+cvotYfQ==
X-Received: by 2002:ac8:5910:0:b0:4e8:9596:ee77 with SMTP id d75a77b69052e-4e89d1eca83mr102709391cf.10.1760809563421;
        Sat, 18 Oct 2025 10:46:03 -0700 (PDT)
Received: from 117.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:1948:1052:f1e9:e23a])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8ab114132sm20445161cf.40.2025.10.18.10.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 10:46:02 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 18 Oct 2025 13:45:20 -0400
Subject: [PATCH v18 09/16] rust: remove spurious `use core::fmt::Debug`
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251018-cstr-core-v18-9-ef3d02760804@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1760809527; l=668;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=uLnXUd5iHMMEJTAMJKY0bsxZkX3e5rGAkuIO16n9SP8=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QGXXqQt9RHGxpoBFZLlXeLUPAugoqd/q2N96Ig7iFhgm9rnqX6mshM+HDXmtIVBN7F9GI6CbJIb
 k7xYI3LBrrwQ=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

We want folks to use `kernel::fmt` but this is only used for `derive` so
can be removed entirely.

This backslid in commit ea60cea07d8c ("rust: add `Alignment` type").

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/ptr.rs | 1 -
 1 file changed, 1 deletion(-)

diff --git a/rust/kernel/ptr.rs b/rust/kernel/ptr.rs
index 2e5e2a090480..e3893ed04049 100644
--- a/rust/kernel/ptr.rs
+++ b/rust/kernel/ptr.rs
@@ -2,7 +2,6 @@
 
 //! Types and functions to work with pointers and addresses.
 
-use core::fmt::Debug;
 use core::mem::align_of;
 use core::num::NonZero;
 

-- 
2.51.1


