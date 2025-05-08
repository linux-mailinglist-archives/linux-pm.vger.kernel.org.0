Return-Path: <linux-pm+bounces-26869-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5FAAAF2A3
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 07:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D19F04C64A4
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 05:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DE22153C7;
	Thu,  8 May 2025 05:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uTscQ/6z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB039213E78
	for <linux-pm@vger.kernel.org>; Thu,  8 May 2025 05:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746681105; cv=none; b=LBzBxEO0tfai5x7D0fXbuczPhl9GzNDWMtI8oeIxi7piVf1ruZWi3X7u5n5eIXWmYQ3HPStEh8uHwRULd7Tpj5j0nVD9QW9twyutTUuI8Sb5WxU/b8RD/3+jeDZqQ38lMoHJa8Pi712NOlMhB3Rlqsv+gnlZ1RAhnSqn3iKRHX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746681105; c=relaxed/simple;
	bh=3uw99ddUMLeQrKWsp1+1b+V8SVKL/YldYrtWvjtNYcE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g/i+EoIwwpMXbjxo3xkxIJjobfbAo4LO5P+yK7qlttTYrc7exOdY0mxnlImWtPy91+xgzhiKGIezqVjd/3qE+gQbUgPKaNvReuPvr81DlrD++oam41gL6Z+sui3jxb7Zoqwvm+kZxssArSt2mc/AJ//CtlRrKQ6/KUn1GtDpBb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uTscQ/6z; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22e4c94ed70so5908175ad.0
        for <linux-pm@vger.kernel.org>; Wed, 07 May 2025 22:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746681103; x=1747285903; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZkuBRw05Sy7EYSCt6VyIOWdi3s1ObjekFGBZ5YExy/0=;
        b=uTscQ/6z8RS6LYGOiHOIYrkvQ5GmGvMbtusqu8r+DucFDxeSeaVsrlex8yv2nzeACF
         3DC4l3uCPsh6s0HQRBjcun7gbfFRxVkNWiTI1ncfp9/nlqMYS9yZhV/D4HPkafGCWqq9
         hvAnGxafwzFj3Ks8nnVrbYZYC1OXIHy/WH5LrN4yRgGK+eEOJWXnqMsJ/9HG9FNS2F46
         W9Pe94eSi/cQZX6fyrjNnr3o4JiTOYUP9vBvo6iMrxeOMc/fSqgLwz5jq8F576yU+zZP
         aXLpmyEmZ/u0EDNYZI9TkrBblfWPO2SrYVbCy512VVa2RgDdEsDDMtOsI98sj4lYfNUE
         Ih5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746681103; x=1747285903;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZkuBRw05Sy7EYSCt6VyIOWdi3s1ObjekFGBZ5YExy/0=;
        b=cKCg0K8oAvTV5qgqAWYBU6tdUw7uBRqnqtVhTwIjUxemeVsO20qhz1IiR0K0h1twnX
         ZakfftObpIurV9c0SdUg0xVFRkQy+0YXMCNr/brVJeyDUtZWSijwJlMBhgAAYS4ISX7o
         keHmfAKKNf32xX83ox0oUmCPg7FzaLpi3sNEylRYiAxaITiVf29Egrj+VEBGx2UiIjR8
         IAxrLvvkTYo3rbQ0Hv4lXrC4yubD37+KXI5HF74Obgpunpdj1Bk10/W8sN3B55xvBJI7
         mEdeSSGh5ofOE0BsRfZWBtvVhmUDkfpQAZA5qYxh68DQMpDPWlP7sRI0kv/51iY7vQHY
         /Gfg==
X-Forwarded-Encrypted: i=1; AJvYcCWiyR6envcMFAfEH9jKgxqCWQLLxKNoT9PBrne77661XLlA+FVSlVMIsH0/nNjsTmDsBIZNo2ikEA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+5wBUaCHabw620MEuRwUfcm17oB0/MPLB+KeMeVV98pg43Fqd
	AJ1WcWx82p43g8Z/TagE56bPaCITgV/yAadhWU0HYehVQUDjHpCrMb/JKlKexJ1tSBtJdfMdK2a
	Ixg==
X-Google-Smtp-Source: AGHT+IFqi/sBjRSvaoAz7eZ3j5I77pIqUeGYHqCXjKMp3cZTaUN3BhT0tP3SmQRRmwUf1j4EPXnzb1Q6Nqg=
X-Received: from plok6.prod.google.com ([2002:a17:903:3bc6:b0:220:ea57:34e3])
 (user=amitsd job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:990:b0:22d:b240:34c9
 with SMTP id d9443c01a7336-22e5ee2cfd9mr89525335ad.53.1746681103163; Wed, 07
 May 2025 22:11:43 -0700 (PDT)
Date: Wed,  7 May 2025 22:08:52 -0700
In-Reply-To: <20250508050856.674782-1-amitsd@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250508050856.674782-1-amitsd@google.com>
X-Mailer: git-send-email 2.49.0.987.g0cc8ee98dc-goog
Message-ID: <20250508050856.674782-3-amitsd@google.com>
Subject: [PATCH v1 2/2] arm64: dts: exynos: gs101-pixel-common: add graph
 property to connect tcpc & fg
From: Amit Sunil Dhamne <amitsd@google.com>
To: sre@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	peter.griffin@linaro.org
Cc: andre.draszik@linaro.org, badhri@google.com, tudor.ambarus@linaro.org, 
	alim.akhtar@samsung.com, dima.fedrau@gmail.com, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	Amit Sunil Dhamne <amitsd@google.com>
Content-Type: text/plain; charset="UTF-8"

Add "port" binding to represent vbus/vchgin connection between tcpc
connector & battery using OF graphs.

Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
---
 .../boot/dts/exynos/google/gs101-pixel-common.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101-pixel-common.dtsi b/arch/arm64/boot/dts/exynos/google/gs101-pixel-common.dtsi
index 84fc10c35629..45b079c16146 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101-pixel-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101-pixel-common.dtsi
@@ -186,6 +186,14 @@ usbc0_role_sw: endpoint {
 						remote-endpoint = <&usbdrd31_dwc3_role_switch>;
 					};
 				};
+
+				port@3 {
+					reg = <3>;
+
+					conn_batt_vbus: endpoint {
+						remote-endpoint = <&batt_conn_vbus>;
+					};
+				};
 			};
 		};
 	};
@@ -197,6 +205,12 @@ fuel-gauge@36 {
 		interrupt-parent = <&gpa9>;
 		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
 		shunt-resistor-micro-ohms = <5000>;
+
+		port {
+			batt_conn_vbus: endpoint {
+				remote-endpoint = <&conn_batt_vbus>;
+			};
+		};
 	};
 };
 
-- 
2.49.0.987.g0cc8ee98dc-goog


