Return-Path: <linux-pm+bounces-8417-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 978018D47BE
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 10:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EF1F284D79
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 08:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF15317FAC1;
	Thu, 30 May 2024 08:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOpxM5Md"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FCE17E448;
	Thu, 30 May 2024 08:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717059402; cv=none; b=HHs3hVlG5UJXqeWGQ1Uln0jQiyRdVRARXSYYfEpNfFsLxhEOk/6ETnkbFZko0+gPPIUdhFMznt0qlJK2b81J3qawuw5S+E/G7sUmD2vk2BY4rltfoKN9NyQ+xs7gY3AJyny4n6d6/lHheVnnux9iy3jBDM1SuoWm6onYu3ag3Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717059402; c=relaxed/simple;
	bh=EY+BEcJQ9F9LUdm4bF8mu/8KmPSqDEshmLjLao4MQ0E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QrR1CjVXnRKBeD+OpTz+6TcNjwXrcA11CjtNMybPWv3EbhCBSB2Lj3IlacxeqPm/iBjSI/B+Wh/Q84B+zrj7/fKvGP2hXCF6sSvCAvX38kUPQ+EtTFd7iXbPNBuJvV5czNt98pmNDuA5f+JYYFQMUm+wnGKc7petnSXZTCsrMTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lOpxM5Md; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a59a609dd3fso96351666b.0;
        Thu, 30 May 2024 01:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717059399; x=1717664199; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cQNLlC64Z+6NySSM58h4q7W0lLlgYuyQBuL59GO7BQI=;
        b=lOpxM5Md5tkPm6myec87dbl/OHsEv/5OCqpYCBUZQ3zW0BpE6Y1U6wF8EOYtKYHXRT
         8V+x/EsJNaZ1Sb69f4DYUhrg2RHxTU/79vsv3mDe3oOqooPCerPpz0VfoRQa+fq6Myfi
         3TvVpkH3Pbii81PDl1o1MGyxqPrfdayw1KPdFJ5OpyceKl6Zui/V1G8/MWwMcFtyQbkC
         7WbgTn4O3ifNgoeldUGc1UH9X9VWhpCPNVN0k+UmB4QQnVF8eQ7CVND3xGE2YN4eaLSW
         3swPrfG5SGtxyuZ80yYCWUrvXkaBCDejEt6WyBcfpjzpmMOEi9KSeKj5orkV5MVF30nL
         Kp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717059399; x=1717664199;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cQNLlC64Z+6NySSM58h4q7W0lLlgYuyQBuL59GO7BQI=;
        b=W65EEPyAv+Me+8hgjUMPjtcc3qgiJOKmmZMYcHJnX8iy884K2L6bA0/6nnj8W5kWW0
         R5nnTxIdzrYotX0gTg/P+u7jNFLjtXjUVk0XDg3mVWE6CuzPwiDKnuUzHgvKkr9uNHcs
         JnlfxgvWRK6KAw8ELWC7Y90iDWegpkR9uqiRiV+02nGfrgOIxJpH7TQwadrDOj1hql3V
         wM9JtUfD3r6lKwqooWGGOg2mlLRTJtH+l3pwrDvrEQ1fcMdtYxzFP07lO9OqxT77A9W5
         ALNp9rJgVLViqRh2NSgyyOqGrv7WyFTlC2Fn4mlQeFIBJNglPE4B0Uwv6FoohzF71qBe
         VB/g==
X-Forwarded-Encrypted: i=1; AJvYcCXg4usadJK2vPLPzwzXv7TK09bbDkzUd5fABUmlHGQUIBp3Ifh/4YGsN3RP+EZq5gXxsQXnQtarsNyCYHHenmBOCnRWdHiA2GR22lp8O8VYDZZHoAYne4QrsJQCaEYp8SxIOFhxUY4JqeCiwBqZ6w4QQQkT66G+l7c2lqTqWXoBq32U2aponPNXSCPEbGvb7giA5uW0WsVQT5r4NN5Kce4Apf3EQWQ=
X-Gm-Message-State: AOJu0Yzsis6Rt7iO5hftus+sg6HiQdPG6fsGxvBBXCG+kkEFyM74rGvR
	YOmv8+0lg9yiXCJE2Wprgaq2F2BVofNq2vWgjv62pGtX5S5KEeFl
X-Google-Smtp-Source: AGHT+IHkLEVV6E75jVIShiYEHFkNtLk1TaBGd1BSfvKYAYZG6bC/a1gzyQgtYJAgE0LVsGNX5ckQtQ==
X-Received: by 2002:a17:906:38d6:b0:a65:f504:6d48 with SMTP id a640c23a62f3a-a65f5046ee0mr91861966b.2.1717059399308;
        Thu, 30 May 2024 01:56:39 -0700 (PDT)
Received: from hex.my.domain (83.8.128.191.ipv4.supernova.orange.pl. [83.8.128.191])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc500a1sm798430166b.125.2024.05.30.01.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 01:56:38 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Thu, 30 May 2024 10:56:00 +0200
Subject: [PATCH RFC 10/11] ARM: dts: samsung: exynos4212-tab3: Set fast
 charge current for MAX77693
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240530-max77693-charger-extcon-v1-10-dc2a9e5bdf30@gmail.com>
References: <20240530-max77693-charger-extcon-v1-0-dc2a9e5bdf30@gmail.com>
In-Reply-To: <20240530-max77693-charger-extcon-v1-0-dc2a9e5bdf30@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, Henrik Grimler <henrik@grimler.se>, 
 Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>, 
 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>, 
 Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717059384; l=949;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=EY+BEcJQ9F9LUdm4bF8mu/8KmPSqDEshmLjLao4MQ0E=;
 b=kXudDF1YC5D4fcIqIOcVLdEvXLvphHXgfFdfuQ7rFNYKEQsklCP8FjoANLctcXa2OAKOOsBNv
 3FtW7ZSzAqABBhFnKjKb7TL233hDIPYcuvTh4vcOh2yCRn5LJF9JCOx
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

This value was verified by comparing register dumps of the MAX77693
charger with on mainline with a downstream kernel under Android; the
value on downstream was set to 1.8 amps when charging with a proper
charger.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi b/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi
index e5254e32aa8f..b13c135bd944 100644
--- a/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi
+++ b/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi
@@ -158,6 +158,7 @@ charger {
 				maxim,min-system-microvolt = <3600000>;
 				maxim,thermal-regulation-celsius = <100>;
 				maxim,battery-overcurrent-microamp = <3500000>;
+				maxim,fast-charge-current-microamp = <1800000>;
 				maxim,charge-input-threshold-microvolt = <4300000>;
 			};
 		};

-- 
2.45.1


