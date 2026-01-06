Return-Path: <linux-pm+bounces-40317-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2FBCF88CB
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 14:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68345306C990
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 13:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1067C223DE7;
	Tue,  6 Jan 2026 13:37:00 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804EA330664;
	Tue,  6 Jan 2026 13:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767706620; cv=none; b=K/d0N6Dqc1vm64LSoHok9MeWimqsKaYMp96eGV1pcOOz5mx0iA2h0gYJnnsQnQFlUJLk6lCrqqevxxXZXUckqZ8uRw23GdbBoctUWWfJmBPcsrfNupMyO6SxknwJihn+2sdV2m7UOq4y3jF/gx011sIuEMjwbII3d7LesRLg4Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767706620; c=relaxed/simple;
	bh=M11x21cG7PYRgb0iBjoKP/n6OKDvX2GQSnQdp5LPWkk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=UnQ7KadZ/8l7mbwrSotUXmvpGICYkX/u6189G/q6YfEmegbUDw5RdSWzy8HBkSt/IsI7EMG/7uNsocTqAuNyxCyFXKhv6j1+OjwZ6R3OJIePfcGYyBO0dLAYst6ad6fFOtHOI1LlCcWH7apjj3eyha2PRHuoJli3dip2zvLd9aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB2F4497;
	Tue,  6 Jan 2026 05:36:49 -0800 (PST)
Received: from [10.57.11.122] (unknown [10.57.11.122])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E87B3F6A8;
	Tue,  6 Jan 2026 05:36:55 -0800 (PST)
Message-ID: <71f63cb7-2d9b-49a3-9b04-a47e2edef5e0@arm.com>
Date: Tue, 6 Jan 2026 13:36:53 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
From: Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH] MAINTAINERS: Add myself as cpuidle reviewer
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I've been reviewing cpuidle changes, for governors in particular, for
the last couple of years and will continue to do so.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 765ad2daa218..ea1d4c85b865 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6554,6 +6554,7 @@ F:	rust/kernel/cpu.rs
 CPU IDLE TIME MANAGEMENT FRAMEWORK
 M:	"Rafael J. Wysocki" <rafael@kernel.org>
 M:	Daniel Lezcano <daniel.lezcano@linaro.org>
+R:	Christian Loehle <christian.loehle@arm.com>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
 B:	https://bugzilla.kernel.org
-- 
2.34.1

