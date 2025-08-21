Return-Path: <linux-pm+bounces-32793-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAC0B2F3AD
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 11:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C86B17ADB9
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 09:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431CF2EE616;
	Thu, 21 Aug 2025 09:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="ej6xZPXl"
X-Original-To: linux-pm@vger.kernel.org
Received: from forward202b.mail.yandex.net (forward202b.mail.yandex.net [178.154.239.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0FE2EE604;
	Thu, 21 Aug 2025 09:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755767795; cv=none; b=n2oU/IyTmjs/WqTdl4uSY9FV6Tr5oa9SElt3caHMO1/QhfuqOZ1RXwQOuajTubRicR+TYNO9A5sk4z6Y/bG9l8wdChOK4oWiYWPV56QMWN8LG478Q2wKpZitP2DVrr6T8S80JZLP7R0Hn+BvH0qs9+zMnvIg6E441nW6hGDDi1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755767795; c=relaxed/simple;
	bh=vvMrVOuYm6BcHLiTT3qDyU9DJstF/etgjeUIHGPLcZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ei6nWWJKENR6AF43GADkZ6HhYw0yLpnyT0I8RTSqzqFD2ZlMO53jlhTXbV7a3OyZ1e/kjlwMwi3opWJvRre2RHstksvq/Ou4O8Qfe0J+MO0+CNGY1/od/xUBvaT/M5EQ49TvyME1EwaQMC673hgXQrFUXOBTICUWs2DqwLLUbBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=ej6xZPXl; arc=none smtp.client-ip=178.154.239.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d102])
	by forward202b.mail.yandex.net (Yandex) with ESMTPS id 0AA30C30BD;
	Thu, 21 Aug 2025 12:16:28 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-57.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-57.sas.yp-c.yandex.net [IPv6:2a02:6b8:c1e:3dd4:0:640:3df:0])
	by forward102b.mail.yandex.net (Yandex) with ESMTPS id 2B712C0132;
	Thu, 21 Aug 2025 12:16:19 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-57.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 7GPa9oQM4W20-V4G1IgMK;
	Thu, 21 Aug 2025 12:16:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1755767778;
	bh=+oxfSLeJG45INcAyiGg9Z5dnZbHuhhmAG8IvgpEVqOI=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=ej6xZPXl6F/rFYiWv3cRrblJJO7tQryE9chGeKYrcYl323TaXBWOajXFkqt1ZAlCj
	 K6FXSX4aM1fUnJK4UVt/F11iq4PdZ1V3z+w5QYyLgI6IRpcXZJf975DmvYDvXTbEI5
	 Zwkuc3ObpLPSV1IwTc6qcH+ZwW1kmTD4TmOI3fOs=
Authentication-Results: mail-nwsmtp-smtp-production-main-57.sas.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: rust-for-linux@vger.kernel.org
Cc: vireshk@kernel.org,
	nm@ti.com,
	sboyd@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH] rust: opp: use to_result for error handling
Date: Thu, 21 Aug 2025 12:16:05 +0300
Message-ID: <20250821091606.7470-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Simplifies error handling by replacing the manual check
of the return value with the `to_result` helper.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 rust/kernel/opp.rs | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
index 08126035d2c6..9d79c2816af5 100644
--- a/rust/kernel/opp.rs
+++ b/rust/kernel/opp.rs
@@ -12,7 +12,7 @@
     clk::Hertz,
     cpumask::{Cpumask, CpumaskVar},
     device::Device,
-    error::{code::*, from_err_ptr, from_result, to_result, Error, Result, VTABLE_DEFAULT_ERROR},
+    error::{code::*, from_err_ptr, from_result, to_result, Result, VTABLE_DEFAULT_ERROR},
     ffi::c_ulong,
     prelude::*,
     str::CString,
@@ -500,11 +500,8 @@ pub fn set(self, dev: &Device) -> Result<ConfigToken> {
         // requirements. The OPP core guarantees not to access fields of [`Config`] after this call
         // and so we don't need to save a copy of them for future use.
         let ret = unsafe { bindings::dev_pm_opp_set_config(dev.as_raw(), &mut config) };
-        if ret < 0 {
-            Err(Error::from_errno(ret))
-        } else {
-            Ok(ConfigToken(ret))
-        }
+
+        to_result(ret).map(|()| ConfigToken(ret))
     }

     /// Config's clk callback.
@@ -713,11 +710,8 @@ pub fn opp_count(&self) -> Result<u32> {
         // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
         // requirements.
         let ret = unsafe { bindings::dev_pm_opp_get_opp_count(self.dev.as_raw()) };
-        if ret < 0 {
-            Err(Error::from_errno(ret))
-        } else {
-            Ok(ret as u32)
-        }
+
+        to_result(ret).map(|()| ret as u32)
     }

     /// Returns max clock latency (in nanoseconds) of the [`OPP`]s in the [`Table`].
--
2.50.0


