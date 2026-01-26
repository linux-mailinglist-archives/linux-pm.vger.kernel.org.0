Return-Path: <linux-pm+bounces-41472-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBGfD/5md2nCfQEAu9opvQ
	(envelope-from <linux-pm+bounces-41472-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 14:07:10 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBB588987
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 14:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F58F30530DE
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 13:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFBD338939;
	Mon, 26 Jan 2026 13:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1fsj6QA/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E603C338596
	for <linux-pm@vger.kernel.org>; Mon, 26 Jan 2026 13:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769432733; cv=none; b=TjQWKQTp4A1FeYuNIg9sxEDysc5pEA4EASQJ3Yr6qzZgAP/8nJR0/gRT9TVdTFVil1fUbQE3P2HapmNMsxmCvkueY26BoyIh8igRfbRprFOFwqU5NtDt3FbbFzhrURGcfb24zF2MtQ/zhU2Zfx55MjX24AyH2ZJ7abr34fmyjbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769432733; c=relaxed/simple;
	bh=quWSaogirGvSyGU+eYcO01e5dALGwdCFt63QGZ45xEw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d7OAlNmqYwfPYwdoyESi8t0/xwqQ1zK/JZN5ekUADdqhE20VtKGH60Nm63aNIO4q/Ww7ulzjt3Vni+H59FTegR7e6ex7PqFIyb/DhM3RFmuD0FhF4BmCnhs1B7/JB4vGkXfrfVF3R/XFFB4J7nutQ/iDZzj9kwO4kg8qOiktGbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1fsj6QA/; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b8701569041so363609766b.2
        for <linux-pm@vger.kernel.org>; Mon, 26 Jan 2026 05:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769432729; x=1770037529; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IZoKiHDA5dept7gPJfQdDlpAT5f6sSqPf63fb7QenF4=;
        b=1fsj6QA/AThlSVf3LHNvadyzWuWF46MBzkoxwbGAw6tb/3sqiskNir56a4YZE81bZC
         oeXiMCp3ggOJOKpyvhB+/H5wieBlVL89ZUHGNQozd8opy4dkU1jwHYeKnruGYN4uroy7
         cWI8DUPBLV4bKfxurc2izGxs7oAJByV/+HDl/t/Z8jYMiO7Wta+Dyr8ywz3g4qwHti0K
         ZFYKbJPNxF3kfm3M3skjqAhoY/BcljvzBzaTqyHfiUYtIZmwAtxNOsRjAXhnfSkBB6q2
         k+3z/WR5Tj8S/PqY8xqL/jAQ36Hts7mOUTFZ8Mb5QtLotCXWmQvzs6W+meQWR34c3B1r
         B2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769432729; x=1770037529;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IZoKiHDA5dept7gPJfQdDlpAT5f6sSqPf63fb7QenF4=;
        b=jJ5TcMu+iuCXFRn64FQ1nG96CHQNPVHtDWjU2xVr3SHzXoqdJB9x4ffXgQ+6pEI6i7
         nKLnieHy+qiJuFovNAF5Az4U528JCl3+IrbzQUtuGaQo3PkSuoQs0LfdcZPyrmSm0TlU
         J5qyh08nRxa/L+hminuGrF3NEw8f63Rqt9iKX++su01AEgR/vb0c4Qqs9V/J4salgJYD
         PcazENWVglPy/Jy+iWe4RN1IHJRGN2GAx8xvfHj/zJnjR4vQdmIUmLoJQffvikNuxPf4
         3B86VM4kFiuuR5FM6F63lrBvkZpMeGmLqdMTavvYtKt3TgUFKQWu7pLc4JMX4/QSyMZ/
         5kuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXV+t0O6XvYzdQI8gTz0If9fulj3TtDqRWCUrT9yN9Q0zQELCp56TJHILagleIFBgJsUX12aL02Sg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz54Dvf9/1RUh3CMW5adzOas6V9ZsSCRmgh7/M+UVGP6RoZk3kp
	6VK5mLyMLwQ6it3lUBrxsanqXxXO4n+KLQuWCeKJqJM5o2IwWl2n8iErjq343YHzvVKc79QKFlQ
	1d3+wtdXsPIX1691x2Q==
X-Received: from ejhn16.prod.google.com ([2002:a17:906:1d10:b0:b88:3e98:7d99])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:d54a:b0:b87:324b:9ae1 with SMTP id a640c23a62f3a-b8d20e44af9mr337635166b.40.1769432729392;
 Mon, 26 Jan 2026 05:05:29 -0800 (PST)
Date: Mon, 26 Jan 2026 13:05:15 +0000
In-Reply-To: <20260126-zeroable-ffi-v1-0-0ef101d1ed85@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260126-zeroable-ffi-v1-0-0ef101d1ed85@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=789; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=quWSaogirGvSyGU+eYcO01e5dALGwdCFt63QGZ45xEw=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpd2aVPY91/Wh1b8DTGNqjiDw+6siqYJgl44iNU
 ZJ/YjGRhBWJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaXdmlQAKCRAEWL7uWMY5
 RpjZD/9oT5g0w6umhbzjmngZGfdzYK4fSuwfVAdqAFqLNnORfzh2XkXm/FEz81hC6vd3BwC7Tb+
 +FSY7bADLbe9a55VbCs8IwS6nyDvuPsnHZoUNFGZCKH/KiIMmxveCI45pir8U26NetYXBMSNxah
 8FRe92VKvomzJEnAmGYOTHEKgOqA3isyA5HZxEcoGEFyVpl5gXX4vnsqlsoF509WECoqz0hZBrp
 J7vxanApMeZearv6nwBMQllprc2tl/gZ4WvV9Ffpf4cKftKbLR3PGm54JX+i6BJXAiajgGBTHGM
 FVGUGXbjWroqFO0AKq8ycK5/JpgKvvTYXtM5nYt0ndi5EaUhvgXgd/5k2y3/QSyB73ZqGEuCTEL
 ayk6bh7Lda4IMguB6AMjMiSnXkBrKmbtJvuGvD37CcBBkfS8ZwGaPom92S8pISrhbKQetfnSKmY
 gXCe0lIf+tn7tU6gYEJD8GgTBX7PKlcWgDo/5cpjiS8dRP60vNYnQAvh1lG+YKC+uYWDZgRr9hS
 mxpBjKIZZOqcDktqjgjsAGu3s+ekO25F56FjtpyP4ONZwoVKmYn5KbAp7mK09XLnB+Oo4PBGz7e
 4L21Y5HU4/4u5wMlM5/v7yV2h3+Diakzj8s37c3vxu5OPqxnlIF1zRwJY7hKAfAzB2FL7J35/6e jaK2+VtXfs+q8jw==
X-Mailer: b4 0.14.2
Message-ID: <20260126-zeroable-ffi-v1-2-0ef101d1ed85@google.com>
Subject: [PATCH 2/4] rust: cpufreq: import pin_init::zeroed() from ffi
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Igor Korotin <igor.korotin.linux@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Len Brown <lenb@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41472-lists,linux-pm=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,garyguo.net,protonmail.com,umich.edu,linaro.org,collabora.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DCBB588987
X-Rspamd-Action: no action

The zeroed() helper was re-exported from the ffi crate. As this usage of
zeroed() has nothing to do with pin-init, use the new re-export.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/cpufreq.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index f968fbd22890546db1758d921e3374359ef9d00b..fadba8e669be33911a30be0254d3d4dcba9f4226 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -1012,7 +1012,7 @@ impl<T: Driver> Registration<T> {
         } else {
             None
         },
-        ..pin_init::zeroed()
+        ..ffi::zeroed()
     };
 
     const fn copy_name(name: &'static CStr) -> [c_char; CPUFREQ_NAME_LEN] {

-- 
2.52.0.457.g6b5491de43-goog


