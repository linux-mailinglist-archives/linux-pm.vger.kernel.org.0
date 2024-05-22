Return-Path: <linux-pm+bounces-8063-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A02128CC954
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2024 01:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C5E5282B5A
	for <lists+linux-pm@lfdr.de>; Wed, 22 May 2024 23:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7C5149C7E;
	Wed, 22 May 2024 23:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPQPtkH/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AB6149C6B;
	Wed, 22 May 2024 23:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716418903; cv=none; b=QYxDX5KLy4j4kk6xpoRmk0H/VkF3yWp8wFGoyJ3IhkpN8k+2CNWY87kxqx2F/4W85qaD+Q31rUu5YB1QOn7CQyhOQ2j7ahFPOShHQz4iTi4zi56ZmnFZDzwJQoFWz4aW5BHTpFIMMsKkVw0gbs/Y/qwkNwJgzUencrYnL34pnjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716418903; c=relaxed/simple;
	bh=2S4UwANZHDCvcGjJ6kOp8Lq7CBUh0RxJBiNqIllq/lA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jH6sMfpgrF7nSs+XPsIoAO4amyParkt/MTVV+e9gzBqU18v44Wbtl8A+BCjT6M0KDnMvfxhXRzcyb6UtPzL5Gs/kCYSslB8RVXOAdmcAeHJnkqYUBpfuZJyECXSuWoPxHJvXfTlOcak/Gcdxk0BEXCBOEWZjHKXS27lkQ0I6n1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPQPtkH/; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6f264d5dadaso2321453a34.0;
        Wed, 22 May 2024 16:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716418901; x=1717023701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NuOISrKNUc5YSpf1n3iTvx1BpiFjgcJLUsrC21l2FZg=;
        b=NPQPtkH/F3ZJ4/bbE7dwthXhoMhHa34rU/52s+tOyyvrCxCttaRGxENBZLQ56W3Iwk
         mSbhL4ss16zQQEdGuSwujE0oY5zaIbUysYQZjFbvW2YYubjG+lUyswzkLDlpoqlrxutU
         Jp2wL1GoC0HZmX1KrXVXOL5kiZd2yh2omGvtB1J3vZiWYapYX4w3DNctimM6MunOWM1N
         ywWF4QdfEWeYzOGiPxOj8kFJMIp7qA/50NDCXGRhd6Bc30yYUZmV9FUyYjIHwc19ogg7
         +2lLZIb4IuyggTZ7o/dP1jmPk3vDNdRBxuRQZFknG4AkT27K2riXSi7cQHiMgVgHdr81
         MlQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716418901; x=1717023701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NuOISrKNUc5YSpf1n3iTvx1BpiFjgcJLUsrC21l2FZg=;
        b=qdbMNbA/5h5q+AVjG6RGoCIPpds9F4p2b3gcDZw9b24T2IqiUdSICRahr+u+dU/jEE
         x5YrCRnHvBEFhkcFco3JXEsqjy3LbRO59IT6AotlJpII2bXtf1lPiqQjBySUp7VQyBuA
         5+WhP7yOb6hfWtNjXqP91I7tpqvgtpg/stQwDuKs5YPeXvXVHbRHj6vXSc8I/jdfm6ic
         TSZEchA9HDmHKNjykvwnsrXO83pdpaCeI4DGEPCwsPA6xUtCyWqQ7NRy5twOkH6v7zpc
         n3U8sOJv/ko8XTtCrPhlMiUv8oEysIOLARSoVQsJznm61aywzIe4gv/9qAAYSBxkdEjZ
         l3NQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHKN+wl7IfuHLx7/n/BSiADAFQJ1dUsStyhzDCqr2PrJvSFQH0an2K7kYDdJNWYY0mVZooia9Xq00rAIelol8vsXXXP2E76bM=
X-Gm-Message-State: AOJu0YxJWtHO4WGnTkRig/ytj3zw24/KmSvt6zwGg7SDFdie1ST8tD0u
	+811hvmAM5i6ay/N28xI9uWMExXLA3BsMXL70Vf2WgglTbeUWFMc
X-Google-Smtp-Source: AGHT+IHKH8RUcmcUS/pRwyHnuEDoFRBxr2XM//8lFtCVqbLCFRgxWFFFRteUww5UtB6vYheybsTg2g==
X-Received: by 2002:a9d:7a42:0:b0:6ee:3b91:5e3b with SMTP id 46e09a7af769-6f669819b4amr3614442a34.27.1716418900945;
        Wed, 22 May 2024 16:01:40 -0700 (PDT)
Received: from localhost.localdomain ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f0ff995ccdsm4155936a34.34.2024.05.22.16.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 16:01:40 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-sunxi@lists.linux.dev
Cc: devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	broonie@kernel.org,
	lgirdwood@gmail.com,
	lee@kernel.org,
	samuel@sholland.org,
	jernej.skrabec@gmail.com,
	wens@csie.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	sre@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 4/4] arm64: dts: allwinner: Anbernic RG35XX: add AXP717 USB power
Date: Wed, 22 May 2024 18:01:32 -0500
Message-Id: <20240522230132.364915-5-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522230132.364915-1-macroalpha82@gmail.com>
References: <20240522230132.364915-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add the necessary node for the USB power driver and bind it to the OTG
port.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts  | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts b/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts
index ee30584b6ad7..96a43d55baab 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-2024.dts
@@ -307,6 +307,10 @@ reg_cpusldo: cpusldo {
 				/* unused */
 			};
 		};
+
+		usb_power: usb-power {
+			compatible = "x-powers,axp717-usb-power-supply";
+		};
 	};
 };
 
@@ -323,5 +327,6 @@ &usbotg {
 };
 
 &usbphy {
+	usb0_vbus_power-supply = <&usb_power>;
 	status = "okay";
 };
-- 
2.34.1


