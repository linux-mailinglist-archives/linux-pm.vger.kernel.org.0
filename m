Return-Path: <linux-pm+bounces-12321-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 416D69543D2
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 10:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6792B1C22047
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 08:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AC513A896;
	Fri, 16 Aug 2024 08:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3dk1ZJS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9CE12C465;
	Fri, 16 Aug 2024 08:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723796359; cv=none; b=ZLV7VAj33sT7tn2+DD+wkozESHNz1JM1/8sN6N04FJQyetg9ujgOzn+90wcFhlcY2vdUTfQSIHoWb3KH5Y9gWlSHu/khJt12v7hnxx12/MvQQr1stftx8FzINJAc5kZd4Jkpfz7zhNMkTwvo0+9W5twCw2HHKVAVbZfqsoOgexA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723796359; c=relaxed/simple;
	bh=hw9bscDFCN3vQXC6NtThwBJyizDt4UmRCGdr2F/CUvE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ttP709IFDdXHWcMhYMxG+MnY7bevGYu46wDGXA3byudCi5iA5WNbp0jraanV00VTyUh2mWj5EsZzeasxcubAm8SAsZzFVnYGmeQNby4pRx9e93MGswnGSltZJl+RSPKXbtEAqBToTKnpLpFqG62crSYw4rbzrPlXf/cqt/wjViU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3dk1ZJS; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-368313809a4so1429775f8f.0;
        Fri, 16 Aug 2024 01:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723796356; x=1724401156; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OuFOTwnVfJo3Y5EGzlmZmw/h1XsJN7qD5nElULC2qxw=;
        b=M3dk1ZJSboFVTJu3ob1+m++WC6CKJhDJkVVNPXELlI65YlQSuBqfegG8ur8C5bXCst
         BkRi2B3k8Gu4c8Fre6lvyg5qHtz9PLlvzlOq9nlF864H5d7rC7T4doEaSQShkCi7CEU8
         ky2bnSG8HPCH5v/QLkLASCbjuHPh77cEksh2fC0PV7Z9GwmiLJGNUoiw/SRkNN9+4Isu
         5Vs2u4hSCpyBmYN98qI0R99grkJCtp3kvUBsyI0lSqkN6uuptaJYXGg5sG9kY+302uYw
         Mb0rQsR0g0p47KAT1oCm3AKLsZlfUyKXKB/iMhNN1BERaXRqoNViL5OAvNbAjXhqWcC7
         G/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723796356; x=1724401156;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OuFOTwnVfJo3Y5EGzlmZmw/h1XsJN7qD5nElULC2qxw=;
        b=HVU/dX4VqpiFApJFSWrhidi/GDAyrKBLdWRaVWbpRuMPHTAc+i20vDkPMZ/k8eRBhI
         onaUPNUQYQM0qxF9Ydi7EQXQavQ3eYhZGd604m3Kf4HCegTsTtKVzZh+DmMTLxLIWUoM
         0vw1+9G5avFv+5vYZtrbppNxOSW6FxxL92bfYrEo+3o9PnCamkNah089BwAAaQWKggja
         HXHbaQ25IAVA3LaYZCSnWVwH0WVSK5TZwtczS5Sn8tPf43FPMs5N5IZlHZQ9AAQPouvS
         psRr22zvAwdxN/kj2DScfiWwfWfhIOfDtUY4qBj+qhPZMdemPx66Bz4ZFEodMje+baor
         K1mQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdMFzMA37sBeEbyvySxaiP8VB9Ivr69SWHNUB+i2AWObgz4ceCCSKPrYFS6ze4Lz72Latmh4fVogG260WlyhCl27BsVwRtR+zGnr8QTBkr8utifEKT8Itx/tO4ucfUtIRpSqurd7Dto8ft4nUlNEFBq8Kk+oXmcyEEiFho174FksIkzV1igL8Sc+gMcDRPBl8amjQI/tOJHAHjJVMbeOn/tgA//b8=
X-Gm-Message-State: AOJu0Yx3zSDEtGkk3NJdfVLrd8LK30Tza6Dk4ZSpBZh3wavwqQij+pf/
	obdMoFtfEIFS47Bt9+RSVvm5KimYE1BZV1mEPmA6v+eEJ9Har77l
X-Google-Smtp-Source: AGHT+IGGVQuQ8zMyFMMGEoBO6ujH/sr/qCBYErhFw8TbTMZzGRD67A0Q/9o2jMrWQj5olGsuXutEBQ==
X-Received: by 2002:a05:6000:4a:b0:36b:ea2d:fd5a with SMTP id ffacd0b85a97d-37186d7b2e8mr3437830f8f.22.1723796355464;
        Fri, 16 Aug 2024 01:19:15 -0700 (PDT)
Received: from tablet.my.domain ([37.30.8.221])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded35991sm69732645e9.21.2024.08.16.01.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 01:19:15 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Fri, 16 Aug 2024 10:19:07 +0200
Subject: [PATCH v4 01/10] dt-bindings: power: supply: max77693: Add
 monitored-battery property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-max77693-charger-extcon-v4-1-050a0a9bfea0@gmail.com>
References: <20240816-max77693-charger-extcon-v4-0-050a0a9bfea0@gmail.com>
In-Reply-To: <20240816-max77693-charger-extcon-v4-0-050a0a9bfea0@gmail.com>
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
 Artur Weber <aweber.kernel@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1566;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=hw9bscDFCN3vQXC6NtThwBJyizDt4UmRCGdr2F/CUvE=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBmvwt9rAhxytB9Lc18vnFg3zgPPljMqkf50Mp6b
 NdBnWipLeeJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCZr8LfQAKCRCzu/ihE6BR
 aPJhEACdsnef5g67ckXGS2TQ1QCDItHM8qP/BfBh5lcEFmL1LK8IoE4VSxLhJn03/O0hTSEoOU7
 l29k1yLv+vulxktdeuAbrVoobqjnQlhHk1IQg4Ek3eDOI/JOr+zWL6l+WblJjuhPliQgBvSm8xM
 dKOpoiBmQaCg4vn0cNsMNaUANFZvOFuLm774j7B8uWE3FdvqjuZ82/WMeDQTVrJX7EN689sVu2H
 ZQWgupx4QwWP7Q8y5QWkEWqT2QNc7w2k8fHdoQm4NTPsHeM86j0SLxHLuWjMKyi4TN+szpvaibR
 k8I/peX7DmiU60ewbBzbPja+HBcLoL9HXpEnwZvG2XPK2My/1jvBj+8m2mYsgd9tJpCLACeAgxQ
 MvXvrnuat/rOpMgYVqPHC0w/wL7oPGcgx2YQ55DYabvAmaWPmg1Y6puh5djkZWL0C0xAF3z1xNL
 TWhVrFUtUCZqTrFRADf7iVDibBpuhVBBjqgzJ3EYks1HrmEbS1OY6FGtrZdyRgJhzA7UITgxzXC
 wW/0+Tce2/7lmDTP93r6b1irWAo20GGBMSLFLCzQAKWVamsx8wfm+OdehYJAD5gUiu8YwQzXth/
 cHz+Q1Hi5DTudsTlIStQmDEhc/f50nUxy4aaFDc/ruptQ+of5eLuySK+y10MhAum85nZYgYJvMn
 a3r4Xj8BmCqoKAg==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

Add the monitored-battery property, so that its constant charge current
property can be used to specify the current limit to use for fast charge
(when plugged into a wall charger).

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Henrik Grimler <henrik@grimler.se>
Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v2:
- Switched to monitored-battery property from separate fast charge
  current property
---
 .../devicetree/bindings/power/supply/maxim,max77693.yaml         | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml
index f5fd53debbc8..2f4437dafdc0 100644
--- a/Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml
@@ -16,10 +16,19 @@ description: |
   See also Documentation/devicetree/bindings/mfd/maxim,max77693.yaml for
   additional information and example.
 
+allOf:
+  - $ref: power-supply.yaml#
+
 properties:
   compatible:
     const: maxim,max77693-charger
 
+  monitored-battery:
+    description:
+      Phandle to "simple-battery"-compatible battery node.
+      The constant-charge-current-max-microamps property of the battery
+      node is used to specify the fast charge current.
+
   maxim,constant-microvolt:
     description: |
       Battery constant voltage in uV. The charger will operate in fast

-- 
2.46.0


