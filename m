Return-Path: <linux-pm+bounces-11110-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A51B93151F
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 14:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65D5B1C20CC7
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 12:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F0918FC69;
	Mon, 15 Jul 2024 12:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKKtlaX4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD5318F2F1;
	Mon, 15 Jul 2024 12:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721048130; cv=none; b=q9gBvEnuUD+230klBdgH86l2DipxFs8YIRopOoL4JahKeM68vU/EStTQZCTPjd/LUfoRz7UDhIHse+Z4JwrRqDDR/mMEJ1M9yi42teVB8WCgeqT+3iaNpZFwVqkihTMle8VIMKhixoxdAF5CxKlY2TnXV5SswWnFWVViEelWKM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721048130; c=relaxed/simple;
	bh=qWV+h/xYbFz0ncn8qK2kKImU9+PgmBKdHlR1+5460gc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZfUq1kvzUzr+Mt8VE8qj4PQcR61BLavZKi5t5Vf/nglrjFAA6B5Oi4TxqGG0n5r63vDFhsYrIbE8zQz7CNc4gcr1VaxUPFZfM9Pe0333KFPn/h9eOdmy7+g2ntHJeIKTqo2RrIkmOEIN8ENWGnVwjJz+uH/Un3IlkVOaFnWTTug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKKtlaX4; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-595850e7e11so5301347a12.1;
        Mon, 15 Jul 2024 05:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721048127; x=1721652927; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8XYGMuF1Px9oyTqZPSe/yTfw7ie0wV1T6OCEdpBxL0w=;
        b=eKKtlaX4weirzgG8ry0dK5CHDI7LjrxwzF/uk/mUmmk9EiKsLmsIXXwNbwZmUPd19R
         1VGlEx71Fd5yUZ37llegT+2dwIh7FKJcTtt84hqZ3RBBmZ63MnJBRPn/9579twIGK3qn
         bGUnqsDQgxYju8FcR1hgML1Xqfj1RGOgJNHMa8pp24so8b/1G5QtKlEzvrAHPuLYkn9t
         hVTfnfa/NvcMV3sf2O0V6GFq3UMp+NjMpvX7A65kcmQi8z4zz5tHadltLf41OynHSlds
         pAPEj3oI2T00KkB4SJIYDqlUmdv722+fd/HKE9AwGSBQRcDcUBTCEtxoEerLyeG7WlBX
         KDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721048127; x=1721652927;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8XYGMuF1Px9oyTqZPSe/yTfw7ie0wV1T6OCEdpBxL0w=;
        b=eK8SaQ0FGBkZ5NOvxcRXQ+gMy1itFyYknjV6jU37szCTor+trgUONipoXA7lBqn/m1
         Unh9b9fDYDyHrlWZZh28vIVHUuj+Bz9Cgi+ukjqwK6iYSK36izfquep4DZOLH2cvvrWD
         Qtp5C1WNGYwvuylFgRvMMqFyznYizZQad/NSsnB8K5InQO+vYKbT1OkcEYXyC7XSeo3j
         J1X0iYHx6vER6fRYTkgr6lW6zc6HH4v8dqgrH/1EmSqZOpASwG5w782R7hKh6u1kMUHq
         ynRnpwVPKUKRh/EvYOMbVJSQ7zNQdFJT3X0bj9UU3EQyv193946YXUDQBkHTpgk6q0eB
         IRkw==
X-Forwarded-Encrypted: i=1; AJvYcCWVQ2MoY72gryhuG8ta4ZWIh0vCq7yF5MiV9sYvmt6FtIuwg8MjZY7e80V6j9KfF8PRQXRN3UQp6VvslfyQUlBeWfWbwzrO+6KgjavjjDG5FcIQLLaPIy1/SrtmFA85CXZDbzWShIGBTQc8q+LtuiQgY6moixJ2LAsXGQoTSrbNQ1Ebl2cCLWARg1QW1/kR/1Al44EVHHb88/gNxR6JRznsjjCHt5c=
X-Gm-Message-State: AOJu0Yz4hvCNkGREFkyPY2lk1UKlNOG1N5kf7gt3kXXkPCZV/513AUCr
	gIsCIGb9MCnkp3IcSSyIqx1CBRa0nC29h6XzmcJh4y7XdNFV8+bgvet7jz3i
X-Google-Smtp-Source: AGHT+IFmHSVvcKYIfet4Vd+j7mQCt11AG4ZGYcRC6ZqhWGgENzJ92CnMf6jnirVTsXjCdmjb0Rdetg==
X-Received: by 2002:a05:6402:2353:b0:58b:1737:1143 with SMTP id 4fb4d7f45d1cf-594b9b047d4mr16175281a12.9.1721048127126;
        Mon, 15 Jul 2024 05:55:27 -0700 (PDT)
Received: from tablet.my.domain (ip-37-248-157-210.multi.internet.cyfrowypolsat.pl. [37.248.157.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b26f62165sm3333307a12.87.2024.07.15.05.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 05:55:26 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Mon, 15 Jul 2024 14:55:10 +0200
Subject: [PATCH v2 8/9] ARM: dts: samsung: exynos4212-tab3: Add battery
 node with charge current value
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-max77693-charger-extcon-v2-8-0838ffbb18c3@gmail.com>
References: <20240715-max77693-charger-extcon-v2-0-0838ffbb18c3@gmail.com>
In-Reply-To: <20240715-max77693-charger-extcon-v2-0-0838ffbb18c3@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1385;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=qWV+h/xYbFz0ncn8qK2kKImU9+PgmBKdHlR1+5460gc=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBmlRwqz/mNBhtmHMjP9x0SegLgvHeyjSasKP4io
 /Ot65+rEcWJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCZpUcKgAKCRCzu/ihE6BR
 aE2xD/0XcYfzNUnxcW31v4agx+YsQLMSCJvVejsHdSOgFuf+5W50fQwce8+oElnO+jms5rNOAxr
 bkU3c5zJOd7nuM695tJTUJ+1Kh0v3Gf57jhb86dHgiYq0fXIteWyGyX2jRGU2pSNg9gH/Zz1eCH
 IWXUV/eoXvZk75f+O17QgoX2W/noowMHOwwlNFM9CukLbCoE7t1a8pTRvIlgKg7l+5HQRe3JghA
 GJVfHucjWQx9+4KjOolKOJg/Vozo6ansJrmD0vsEPGD8E16Ob7vXk9aDt4xuvyqELKEqB2J6zHm
 3528VHJ8tYBV/U/tQ+fV0jXveYUJdRQxi6sCWMtXSdOWka8M3cfjQfuyqO0tljBa3R3ZAdnRS/v
 d+7ZwyEkv1g5XtdfxfYCXq9qbOFvf15BBZ9BCMtHWYwI0qhTiHUinnxw5flSLJgmXprV26JPLyf
 LjR2IfOUoLqN6SW1NouTOfIn9uUw+3YdUs6obQgu39FhnUva16GL/2xVevNf7wlrlvflFPfJRKY
 ZdK8ZaeUTcW37nwNBvKqs7ZEZXRGYovByT2w3SLe2ASEwRdbbEsxOtvW45G5V1HjJi+ydpiPKQ3
 Spw14yinRB1wu/6zmMBDWgfUXT3UdS022XroseU6wIENBoebyHjSIv+zeNyDt07Gkf9+/tzWdET
 Wcg0439UjsJcHEA==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

This value was verified by comparing register dumps of the MAX77693
charger with on mainline with a downstream kernel under Android; the
value on downstream was set to 1.8 amps when charging with a proper
charger.

Add it to a new battery node and pass it to the MAX77693 charger
so that the fast charge current setting can be used for charging.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v2:
- Switched to monitored-battery
---
 arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi b/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi
index e5254e32aa8f..7905e33234f2 100644
--- a/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi
+++ b/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi
@@ -153,6 +153,7 @@ charger_reg: CHARGER {
 
 			charger {
 				compatible = "maxim,max77693-charger";
+				monitored-battery = <&battery>;
 
 				maxim,constant-microvolt = <4350000>;
 				maxim,min-system-microvolt = <3600000>;
@@ -294,6 +295,11 @@ submic_bias_reg: voltage-regulator-5 {
 		regulator-max-microvolt = <2800000>;
 	};
 
+	battery: battery {
+		compatible = "simple-battery";
+		constant-charge-current-max-microamp = <1800000>;
+	};
+
 	sound: sound {
 		compatible = "samsung,midas-audio";
 		model = "TAB3";

-- 
2.45.2


