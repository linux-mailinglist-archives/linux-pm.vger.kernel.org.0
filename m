Return-Path: <linux-pm+bounces-11581-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5441393FCC4
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 19:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EE38282732
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 17:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F7A18D4A0;
	Mon, 29 Jul 2024 17:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCsUWP4d"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C7418C353;
	Mon, 29 Jul 2024 17:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722275290; cv=none; b=LoPlXWneQ3yupVbJwBDQDeHGuiEi/yrAl8SGC9ZQAo+LpGHb8/mgiScyGQ1hmWv18o1Qup/J+B7R4FlShGYCg8V0WW8/32HDfbmP/9bO1WkGyDzLEDksWnxoBvzvafyQkc7kKS95fS2AgWsk8TQxgSBG2sfZW4p1MJybuSyEpsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722275290; c=relaxed/simple;
	bh=caLjgArHqT0iX4aNbMz7ThFMSlU4O/1uHusrmF0QQ/8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W8xYdQvRQ77KsY8pVP3RELR++Z+5kU9EQlzhwY3AnRS13Lq82eJzV6JxmVZoIlW1JOTqhNmVYA+msl80JipauydWXpKGvrd9ig7L7k+qY9ztuFx7Nq2PT28AK6BP2933AWZqX9pOn3Jg6sKbT45wJA477mFJg5kGJW9lgXYiMiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JCsUWP4d; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-368712acb8dso1525981f8f.2;
        Mon, 29 Jul 2024 10:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722275287; x=1722880087; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PHSCo9OtmlT0uXzVvp8H+25FMgbSAgLEpICh0lbC9n8=;
        b=JCsUWP4dsV9Lq6lDmbtXQhmSuIfZVWGI7N8ZcUq4W9LxOrE+mFrjSSXPJe6NGTjbp+
         haeYwOo2jTrvdHtjnN6mI/R5otoak7fdPAENTkAzXMRo4U7vcFhUeaexFQhLG+gHAzQ3
         DeClsuQ3Fnv4HK0ArVtXXggmd6ctsg+CPdptYUPYIqpcbVO8NiUzWBx8hmfr1oV1PjMN
         vj+9sVKYVGhqVcR4e0f13S3yJfBEQGq9FQOD9nDExlTJp89HevsY9wUS7lxR6KhJuCbv
         s1w8pp/tDJwu6NtfqvXBInbFzfz4vtL9NvuAbKuhY4TKMjjCIREM9Sf5wzcDU4BFTABJ
         XJ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722275287; x=1722880087;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PHSCo9OtmlT0uXzVvp8H+25FMgbSAgLEpICh0lbC9n8=;
        b=o8QKX3XT7OnAJCtqULbYCCTjmKFGkStLgSoqp80u0roxom9EUAuhwoZVZ0yHqK2YKG
         1b6gNxIFvtuVguqP3xE6Nb5q/BBRLjFPiF/smjo3WCEPp2jjBf19sEGGryFJ0hVvVdiO
         QrYP7lCx7vgtQOlG4Ad8HAzuT+jz6MPmyp9WTjOc+BiJyl5jkqofPMxtvm3ME72sdlNG
         yUY6JEGSINNeYv/SUO/Up1QEIsm/MSSen6R+1luL6hr/3EL6NranLPuDD5Oi+vjyaHyi
         PUGMYYIKJu+TfCK9NBJBAmZWBdLHXDfUugADY+RjRc//LJSnwc0LKnkIOj7H8mSMUP76
         875Q==
X-Forwarded-Encrypted: i=1; AJvYcCXwGL5vZkWGxdseOnuXBim+MeQVQGf7FmdXWWO+YEmaPpILFMiId1IqXNJYZhgdmHuFm0Bb/fjDZi3kYKGp8VLJ/PthtgSOeAzfvMrgfc8R//lN7WGHdLQWs8pwYlmcm2JLJ3n0VNJWiJLIgRbrIdBbGGY5/HYUHGwC4RdWuUIH6bVeLkyCbNA8/AwQJRd8pZ4Khf+iKV6l6iTwXUKhht8PHhFfsts=
X-Gm-Message-State: AOJu0Yy0C5o1xJOGm6keGDGGHu0cNwyAkz6hzYRGahPXIDsPTivajr0b
	/5bNJ33oJVlbxqMCZd7KfTRmz35+wobVkBHnCq9WBY801V6tIkac
X-Google-Smtp-Source: AGHT+IGwptssli/bPxkEfWvX7Isew7g3cblPii2OfQfYYq8mJymlTY5DXHn5VDrv9RDKBYkdgnCFrg==
X-Received: by 2002:a5d:460e:0:b0:360:96d8:ab7c with SMTP id ffacd0b85a97d-36b5cee9dc6mr6137919f8f.11.1722275287312;
        Mon, 29 Jul 2024 10:48:07 -0700 (PDT)
Received: from tablet.my.domain ([37.30.0.99])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367fc8a7sm12716550f8f.59.2024.07.29.10.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 10:48:06 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Mon, 29 Jul 2024 19:47:44 +0200
Subject: [PATCH v3 10/10] ARM: dts: exynos4212-tab3: Drop CHARGER regulator
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-max77693-charger-extcon-v3-10-02315a6869d4@gmail.com>
References: <20240729-max77693-charger-extcon-v3-0-02315a6869d4@gmail.com>
In-Reply-To: <20240729-max77693-charger-extcon-v3-0-02315a6869d4@gmail.com>
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
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=916;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=caLjgArHqT0iX4aNbMz7ThFMSlU4O/1uHusrmF0QQ/8=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBmp9W/WGax3Jobdmy7vUBKLwCxJvPKRgZI5znqk
 7rkTrRhG3GJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCZqfVvwAKCRCzu/ihE6BR
 aLZrD/9pqcbCSRs8SwBt76KCrY+d6MUKKK+BMgFJcj6I/MS6ta2DQWlccNns9Tpqzls+ZvMa/Gu
 xlgSxIePd6CaRl03IsdW8e+OsoBHsdoVqDitjYChSOKpCfTZPcI87FinaxOFvJWmFDrdVvQBoXm
 9M2YhJY3ozq20eJ0lZscBXOw4uJ3rneXZ8rtYBRuQfYLSlAZc+8zk4o3gOjVnD3PlJ/HUBgA9hg
 GlDV2/yzuCYR1Mcw6KGXLUYu7VqF8pfDp461Bdo4WlUcZ1JEKVQl51kF32MRjqLXYyUVQ7VxM5W
 yDGtZW4EXGHKmkbmVORTC4vGszMKjavhr+tDcK+pPAFpZC5hHIygtyW1PduQbThS5Gw/VtaCK30
 uhiUN0YgQM13nkCdN3f34rXlHA1sAYOa8jQ83Zut4Co05NnSuB98Ewf+rO9OZ1EJF3bQU0v4L0s
 fP+WIUyqutDEzcoV2krQWkYDUJBvx6aSTuEfpmrrvcCuVwbV5eWBwRGmLBQ+tTT1MFE//kF3OP6
 rt41RF9y9OLF1s3fuMjoMYPvdcP/OCaygRRxILFAgC3yGjHS4ZYEozTkPLvr3VNNX3kZPxVgJTo
 NkEMPwLKabX9b1ir0OBhVp7DFuvWrxZNyKxQuycffyMotbqLaorahQPBrhqn55AjQKFH6l2Yf6E
 ZFiV/WWlfApXfjw==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

We don't use it for managing charging, and it interferes with the
extcon-based charging mode switching.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v3:
- Added this commit
---
 arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi b/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi
index 7309b4e1cc3d..2006cdcf3909 100644
--- a/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi
+++ b/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi
@@ -148,13 +148,6 @@ esafeout1_reg: ESAFEOUT1 {
 				esafeout2_reg: ESAFEOUT2 {
 					regulator-name = "ESAFEOUT2";
 				};
-
-				charger_reg: CHARGER {
-					regulator-name = "CHARGER";
-					regulator-min-microamp = <60000>;
-					regulator-max-microamp = <2580000>;
-					regulator-boot-on;
-				};
 			};
 
 			muic {

-- 
2.45.2


