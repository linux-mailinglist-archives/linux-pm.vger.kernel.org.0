Return-Path: <linux-pm+bounces-23985-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9212FA5FA55
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 16:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB39B188A192
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 15:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204352686AD;
	Thu, 13 Mar 2025 15:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eX42QnHJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA18F26739D
	for <linux-pm@vger.kernel.org>; Thu, 13 Mar 2025 15:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741880592; cv=none; b=fe2XHEVtj1F3QHNWKIW8GIf9UCm64UPEnXTDMICFvXPAAeugT1kFZaS5XkpP6VC6CKX9gegv9pqSSPkrE9GuFq98RHcxNnUcyV1NT+qckryN6V1O1Rj9BaqDrPoQT/5+Rax85i3WdQE2MN8JaBEFOBQrR+D/kB4JC8Mgyce4Cpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741880592; c=relaxed/simple;
	bh=3t790TRO5SaD33AnJW2jHXs+ZamYiW02gogCQpq8OoA=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=niIVmHI+Go+s2oyxvkAnyamODEaai52VBEehu9Qohnz3/0BpJGKvymXDyUmF+l68s7j6LBZedRODhXjEbxa4D9//+oG/snPpKr8cvbLnSf3WprizYjlykXzxsJOIL4m8EPM5DFFqVkIp3+uibPOLhdYzkuBqDNX7SZNlg6CCpAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eX42QnHJ; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7be8f28172dso71090485a.3
        for <linux-pm@vger.kernel.org>; Thu, 13 Mar 2025 08:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741880586; x=1742485386; darn=vger.kernel.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HP3mNRFDa3oXlhU0cv5qzQmJ+uKrJehpMIxVwkO9Fc8=;
        b=eX42QnHJEWPq+YgYING9DxF0xbU8w6qZWfB2yHP/AJns4qaFkbsva2s5K285OCgGWL
         t/2sFASQHy/WJ3o1L9P7PH3pNJqiOFHjqVk8kHm5LaH4bISeggHM/LIqSyCEzwjCuvOE
         DWlKU7PU7D/gD46gLI3eZw+G3Up1lZHJhfWVLePZE/Lv8nYR0f0nXxCK1xLp9DvD8N70
         8VmAZ9VmhwfXuQPZX9Lm1AUkrNlGwQBVjtikRomXYhIn+ggKfcssot1ZP7QX1eBolAm5
         O2pt9US9wR3VgRGqNh1qO4KiUuAYCsViCbwveIqHf4IB1e3k4cEplc64fovPOgdPyymt
         F8Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741880586; x=1742485386;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HP3mNRFDa3oXlhU0cv5qzQmJ+uKrJehpMIxVwkO9Fc8=;
        b=Ck40NXntzjrjd+iyxwzKsaqh85DPPR8LZ6RYg3tc0mnfc4ytxqqrbX2vUEU+bqksL1
         cZZe30f0gnlAS4GMxUiTf3p7/k2ml4WcRkLijSEixlGERZQY11xi5VnMRvRlfC50zaQJ
         BTNJcH4d0rXIbX36QH4KQEAvTs+Mvh6L26q6jbzed/0bypgxXjkUEOag2hH2WDkE67/j
         YpBovFsg5lqq0F0rVfZMvgveLj83LtsvFSEObLgD/a5VsKV2KewMv7XFP1ofQjNKzPaU
         VikOENTPFpKLR6DhVsfMxD1ppePNc6RlfLK8DS+M3wr2eU+Iy5ucV3hukgXUJg94eAw9
         xR+w==
X-Gm-Message-State: AOJu0Ywbhl8YBIqw1ilbmmadcbkjBpUZZJoszxVDU19g6EzkIWAhcv/5
	OrH0tbHOU6i5tfV/Pfk5kZymF/TYCKbCtb6UdG9mpiwoVvmmoV6EX1gkPj79ypM=
X-Gm-Gg: ASbGncvi4LeEFfUX9Il1krsBo2NTgcF9IszlXT7UYYVqiU6xfMwExSVlgTskU783Mq8
	RIDHZeZxgQ1mwGgyyAR6kNJ8fmPo1lm+lsCzwBZJi4fbhQnp7C6Q8yG51URtNjftLTDi5yeMzEh
	bpx364yCtB9jYsGaux3dI1vM5ihfZlAPqqNDk4Yh1oQDQWHLZw2+l5TIVq/qXiVPk11NN7aAXA2
	u3B2GnFBp54uuuIViyciUqzMo91D38YZ0bdXHyfMYnJ6UlrgIegNQicUV0eaS3I90r/5axr9xQ0
	WCRQy7ip+KbtB6Sb7I798hodh70U76FgNHiFxGbiS6JqlyJM+7BBVAyPOC2ntWzgY+v4X3x5R7f
	dz1jZFY8=
X-Google-Smtp-Source: AGHT+IG7DGBV7fS0OgNdV+jRDvbbHKYP9sJW8CMWzee0priMRP+NjaycF9KaDGtlbGEG0pwVFVd4tw==
X-Received: by 2002:a05:620a:6085:b0:7c5:4278:d151 with SMTP id af79cd13be357-7c579fb4c26mr20945085a.43.1741880586574;
        Thu, 13 Mar 2025 08:43:06 -0700 (PDT)
Received: from xanadu (modemcable179.17-162-184.mc.videotron.ca. [184.162.17.179])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c7854asm112540985a.38.2025.03.13.08.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 08:43:06 -0700 (PDT)
Date: Thu, 13 Mar 2025 11:43:05 -0400 (EDT)
From: Nicolas Pitre <npitre@baylibre.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
    Daniel Lezcano <daniel.lezcano@linaro.org>
cc: linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH] dts: arm64: mediatek: mt8188: add more thermal trip points
Message-ID: <s2sp5o57-o534-qso0-2733-o0prs6028por@onlyvoer.pbz>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Provide the "switch on" thermal trip point to be used by the power
allocator governor.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index 338120930b..262eab8fd3 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -472,6 +472,12 @@ cpu-little0-thermal {
 			thermal-sensors = <&lvts_mcu MT8188_MCU_LITTLE_CPU0>;
 
 			trips {
+				cpu_little0_switch_on: trip-switch-on {
+					temperature = <68000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
 				cpu_little0_alert0: trip-alert0 {
 					temperature = <85000>;
 					hysteresis = <2000>;
@@ -510,6 +516,12 @@ cpu-little1-thermal {
 			thermal-sensors = <&lvts_mcu MT8188_MCU_LITTLE_CPU1>;
 
 			trips {
+				cpu_little1_switch_on: trip-switch-on {
+					temperature = <68000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
 				cpu_little1_alert0: trip-alert0 {
 					temperature = <85000>;
 					hysteresis = <2000>;
@@ -548,6 +560,12 @@ cpu-little2-thermal {
 			thermal-sensors = <&lvts_mcu MT8188_MCU_LITTLE_CPU2>;
 
 			trips {
+				cpu_little2_switch_on: trip-switch-on {
+					temperature = <68000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
 				cpu_little2_alert0: trip-alert0 {
 					temperature = <85000>;
 					hysteresis = <2000>;
@@ -586,6 +604,12 @@ cpu-little3-thermal {
 			thermal-sensors = <&lvts_mcu MT8188_MCU_LITTLE_CPU3>;
 
 			trips {
+				cpu_little3_switch_on: trip-switch-on {
+					temperature = <68000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
 				cpu_little3_alert0: trip-alert0 {
 					temperature = <85000>;
 					hysteresis = <2000>;
@@ -624,6 +648,12 @@ cpu-big0-thermal {
 			thermal-sensors = <&lvts_mcu MT8188_MCU_BIG_CPU0>;
 
 			trips {
+				cpu_big0_switch_on: trip-switch-on {
+					temperature = <68000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
 				cpu_big0_alert0: trip-alert0 {
 					temperature = <85000>;
 					hysteresis = <2000>;
@@ -658,6 +688,12 @@ cpu-big1-thermal {
 			thermal-sensors = <&lvts_mcu MT8188_MCU_BIG_CPU1>;
 
 			trips {
+				cpu_big1_switch_on: trip-switch-on {
+					temperature = <68000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
 				cpu_big1_alert0: trip-alert0 {
 					temperature = <85000>;
 					hysteresis = <2000>;

