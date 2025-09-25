Return-Path: <linux-pm+bounces-35359-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CCEB9FD2B
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 16:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99021384BC8
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 14:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5ED302756;
	Thu, 25 Sep 2025 13:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MB0/rmK3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC863019B4
	for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 13:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808576; cv=none; b=C++A+Gy+nkmLOzoiHAt8/NEcCTho0OZDNgt7RFe+nUpx1T/3vIo8amYlBUzhaeGE/4U5EnZ2SOAexKf6HOSzAa0UHJK0zB87TMgSb+WnJSotCmDxod5Iv9MEDmyU0Za3U0PW1juWT5AOOjqNeroKn+03WEjBRgYCUXvR2zIY1gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808576; c=relaxed/simple;
	bh=O/wu2Lf29nUdzSaspIKYEix0WPxikVmVfF3mQ9scbuU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p3QLYPKquKxIqOwxhOMiMUEmTO3R59B4T84vhvJI7m4PFzUJVE6/TlhEg2qg+G7XuoK9yI9CcuAchxUeqrg9qH4za2fLb0baxUM9ySQL9NLvT3LVkSg+eq4cBILk0DVHOobMV/VaJuQ/PB+UV68Nyx2aZ3+BfcIQ0YWBmPMFVtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MB0/rmK3; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4db385e046dso5461601cf.0
        for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 06:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758808573; x=1759413373; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=67z28WQrX/ogTxUcpWCJ1GAunLtCBeF3o3dpHhKNjK8=;
        b=MB0/rmK3l+ZRaaJREG3duYQEux480HIjS3w7cDDn9IykqdqjNqzjOjDqQVDV0/G/4s
         UPQkg6GOHh6MdmyUN6KUCiYfeHXt7DkQt1w2k0lMIuHYcsWvF8ztNoFG/9gzlWWZH+F/
         bvdDMJX9OXV4YCVBRzPmCkv84aUyg5kQxj24i5gOa0jFxhQ1URlSiQCapmMwlPYF6LCG
         aEEg39hR2APw6sgoqVJt4aYQ7gpqspPtBL8ekCXej+8wDl/h9lDuCqJ7XJWYmbiOEbg8
         mgv7+3GJPG0OhDg7h8khmsT5dex/FwZGLyfFAa3f90dGucAi8zN50dLJkhBTAHTQN+LR
         wgnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758808573; x=1759413373;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=67z28WQrX/ogTxUcpWCJ1GAunLtCBeF3o3dpHhKNjK8=;
        b=WwcC8eG0V4FWL+m+IdCI1pCf/5ggqOMfr8mu6fV563HL8/J64TfvOM6iLzMi9dFOZA
         gcNwZQeCMByB/o3bPhCto+W8goEj8VSuAqZ2w00ePg/rINdvBfyLvEEbqkHYLtUAuRtr
         KeEMvBYtwGVnevRujAkhySTzbP8rkg6D8g0n0afzHYpdgd40WdTReGwFkQlRubkD+WWB
         e2OyTVF6IG9bq+VLusLchieEIEQQHy7uZzeN+bDJf4SLz3rwJZQguyxgB8fCoWvihfPR
         hjgSCLnmlNuBL/N3nQQfhOPKB6RyxRut7B449hvV8omWl2eN3AmfRyV9r2k8W+wrjwPR
         a90w==
X-Gm-Message-State: AOJu0YyXBDuvdmKfhCX6xe4xBM9AJL0B97ZO/u0mf7cGmwLkPoLoLz3w
	VdwH7+4nDvdG1TSIzm3hcjyD4vcnKtn1hHoMdMFeqL51rHtqnBscRLyv03mXDaA7p91Clw==
X-Gm-Gg: ASbGncsCyBDxXQSGu/u7oQ15IPVmzP/3JDOvq+ZivWKhEkEN8pvKzAkxa0ZI7t6IntQ
	56G7e7JxkR4t/jEXufkd/xnW6v1Vrr86WbbuhUws0y9gYyq/w69MGjvdlyrVtFuVmxCfGShQh+B
	vtYOiBmLq1gJbS0NsmljmwWWGRAVzYOQvGfg4tywnRhWTytSPfo4uSVeox0AvkOeyQnE+UrhTZN
	qrd/gpxZ3naC5dL9zGBrAz9BMAhpv/8D7NFosqzFKPAmoJDFTkeZI5KEP3kOJy/karLysqTGxtf
	a5GL+BGcCmwhlUE4SOLWcAPJMx7oAwG26f5Wej1cB/H4HXS2UVBJ0GgD+Mt8Fy6WgRkPWUdXPpm
	hFUY4T1eDiZqJdawi0+nfxxDcWMK0wQY8Ee79RRGl5LpAcYECWzZ0YuMubbe4ytbSH3sRoL6VVD
	faDpJpgPi7ezPGoQAlJ097em/T3uD6DzihGKO10QEwLo6DhAgEYLsp+bsK+3To0urfN4es
X-Google-Smtp-Source: AGHT+IFqm26OFmsSA0nKzITzw08x0KzoFRvLAeGfptjPnF7Ljbfyc5/369jW8FthqI8ZOsSRAhkw7g==
X-Received: by 2002:a05:6214:1cc4:b0:786:e3b6:bb99 with SMTP id 6a1803df08f44-7fc3128e0c3mr48349976d6.29.1758808572677;
        Thu, 25 Sep 2025 06:56:12 -0700 (PDT)
Received: from 137.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:7c:b286:dba3:5ba8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-80135968d5esm11536916d6.12.2025.09.25.06.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:56:12 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 25 Sep 2025 09:54:07 -0400
Subject: [PATCH v2 19/19] rust: regulator: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-core-cstr-cstrings-v2-19-78e0aaace1cd@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1758808439; l=2550;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=O/wu2Lf29nUdzSaspIKYEix0WPxikVmVfF3mQ9scbuU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFsLawjfMUC3xaiUohpUXzdZt822yLFxnKyQ3hJFQI3UAkDtLeyUoqZ2lgOdZhmeuCD54hWBgXN
 /2qfobXSOOAA=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/regulator.rs | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/regulator.rs b/rust/kernel/regulator.rs
index 65f3a125348f..dff8fb00566f 100644
--- a/rust/kernel/regulator.rs
+++ b/rust/kernel/regulator.rs
@@ -98,12 +98,11 @@ pub struct Error<State: RegulatorState> {
 ///
 /// ```
 /// # use kernel::prelude::*;
-/// # use kernel::c_str;
 /// # use kernel::device::Device;
 /// # use kernel::regulator::{Voltage, Regulator, Disabled, Enabled};
 /// fn enable(dev: &Device, min_voltage: Voltage, max_voltage: Voltage) -> Result {
 ///     // Obtain a reference to a (fictitious) regulator.
-///     let regulator: Regulator<Disabled> = Regulator::<Disabled>::get(dev, c_str!("vcc"))?;
+///     let regulator: Regulator<Disabled> = Regulator::<Disabled>::get(dev, c"vcc")?;
 ///
 ///     // The voltage can be set before enabling the regulator if needed, e.g.:
 ///     regulator.set_voltage(min_voltage, max_voltage)?;
@@ -142,12 +141,11 @@ pub struct Error<State: RegulatorState> {
 ///
 /// ```
 /// # use kernel::prelude::*;
-/// # use kernel::c_str;
 /// # use kernel::device::Device;
 /// # use kernel::regulator::{Voltage, Regulator, Enabled};
 /// fn enable(dev: &Device) -> Result {
 ///     // Obtain a reference to a (fictitious) regulator and enable it.
-///     let regulator: Regulator<Enabled> = Regulator::<Enabled>::get(dev, c_str!("vcc"))?;
+///     let regulator: Regulator<Enabled> = Regulator::<Enabled>::get(dev, c"vcc")?;
 ///
 ///     // Dropping an enabled regulator will disable it. The refcount will be
 ///     // decremented.
@@ -193,7 +191,6 @@ pub struct Error<State: RegulatorState> {
 ///
 /// ```
 /// # use kernel::prelude::*;
-/// # use kernel::c_str;
 /// # use kernel::device::Device;
 /// # use kernel::regulator::{Regulator, Dynamic};
 /// struct PrivateData {
@@ -203,7 +200,7 @@ pub struct Error<State: RegulatorState> {
 /// // A fictictious probe function that obtains a regulator and sets it up.
 /// fn probe(dev: &Device) -> Result<PrivateData> {
 ///     // Obtain a reference to a (fictitious) regulator.
-///     let mut regulator = Regulator::<Dynamic>::get(dev, c_str!("vcc"))?;
+///     let mut regulator = Regulator::<Dynamic>::get(dev, c"vcc")?;
 ///
 ///     Ok(PrivateData { regulator })
 /// }

-- 
2.51.0


