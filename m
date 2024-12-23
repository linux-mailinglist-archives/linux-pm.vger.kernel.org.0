Return-Path: <linux-pm+bounces-19714-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BDF9FB2DF
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 17:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E9157A0376
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 16:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D6D1B6D0C;
	Mon, 23 Dec 2024 16:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="dKhJz62U"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-10625.protonmail.ch (mail-10625.protonmail.ch [79.135.106.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1B71B6D01
	for <linux-pm@vger.kernel.org>; Mon, 23 Dec 2024 16:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734971298; cv=none; b=Fw/VAuZtZXKebZn3Zt7gLwGHP47qV5kGC2cvwL+qknyM/DJID/EW1hjhI2Rssq+8pNPwCd/bWe1qtXrourbg/zLNOXwxEbBqX3uAUan0Ts3MV6eWKwT1Lok1BvxES+xGGnD23jJ790klzI+eo+8x4Ki44Tg4foa+BpMCkZYxTG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734971298; c=relaxed/simple;
	bh=YwniGKnAg4EDmwYBiUYaoSDvo6SUYsXGJQgDPG4yMSE=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=rJGHzULVpFHvTY8t3GcuD7DqtWwWSRx/1JfOHG1VkNtScQu/WPK/rq4hL93AuX6UdD9ZaO8KRh+HyJn1C2Go77HZpw5NXtakZLReAfpiH5YoHIW7LPdF6g9yIJV4cqB4haIzJ0dEmEc/6pgow+eweZ3qHKzkcK5Wj6aph7tRHs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=dKhJz62U; arc=none smtp.client-ip=79.135.106.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=protonmail3; t=1734971294; x=1735230494;
	bh=bqyMZPUwM8jdoQ7R6OfI9h6Twr/FyoQIi75Q+q7W9u4=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=dKhJz62UltxDlEmpJaPB4/KU5pncU8BXKp64nZSktCoyu/p2SxGL/p6GJpNE+niVM
	 oRTB6rnkEDxmmsmUR26ZKa7rx4G5gMHFNNYG1jmZCQJV1j3uAyYOLrg0nnXiVGQbDg
	 uBrJVPK+TDnUpBmeW+AZK6tB0Q1bmA+R35d0U1jSf6EJlRN6MyUbjlWv2Mn8OG11eQ
	 r7eWB6KuwZlt51nk/OU7MIERljnMPVX34wr7tabRX/v0mbScPuoxmLBzDBUcVfzww8
	 QwNbJIK/88VBZ7bj63gGpgObQkEzDPpHV/+uE+Et5eWYk48xb9xp2xxkBTFj0VLehv
	 40ntThRWXFv+g==
Date: Mon, 23 Dec 2024 16:28:09 +0000
To: "rafael@kernel.org" <rafael@kernel.org>
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: [PATCH v2] thermal/debugfs: change kzalloc to kcalloc
Message-ID: <LrNqRlU9exQU3mj1YCsmuWHYkpX3ZtUkks2ajMaCbmODAmeO0U0zMIDUVOsIjUyVMaImb67YdBy6M5NFOUqrkdmzgIxILRxZ_pbhOsOvtcI=@ethancedwards.com>
Feedback-ID: 28410670:user:proton
X-Pm-Message-ID: 7953223c63a835d43bd4e9b315c0fdf4d734ad51
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Use 2-factor multiplication argument form kcalloc() instead
of instead of the deprecated kzalloc() [1].

[1] https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded=
-arithmetic-in-allocator-arguments
Link: https://github.com/KSPP/linux/issues/162

Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
 drivers/thermal/thermal_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_debugfs.c b/drivers/thermal/thermal_de=
bugfs.c
index c800504c3cfe..29dc1431a252 100644
--- a/drivers/thermal/thermal_debugfs.c
+++ b/drivers/thermal/thermal_debugfs.c
@@ -876,7 +876,7 @@ void thermal_debug_tz_add(struct thermal_zone_device *t=
z)

        tz_dbg->tz =3D tz;

-       tz_dbg->trips_crossed =3D kzalloc(sizeof(int) * tz->num_trips, GFP_=
KERNEL);
+       tz_dbg->trips_crossed =3D kcalloc(tz->num_trips, sizeof(int), GFP_K=
ERNEL);
        if (!tz_dbg->trips_crossed) {
                thermal_debugfs_remove_id(thermal_dbg);
                return;
--
2.47.1


