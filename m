Return-Path: <linux-pm+bounces-8409-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2A78D479D
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 10:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7161F282D94
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 08:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CD9176AB5;
	Thu, 30 May 2024 08:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyK9vlvF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387CA15218D;
	Thu, 30 May 2024 08:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717059391; cv=none; b=e3lmsk6BXFaE4KtJqbjyZrRF71eYMcX9R/l9oTlc4qbMD0xb3IKrb8n8PbGiZeoR5Khb6YT14Uidras3Bwi9JRlt4M1Uy73kKYdfYFrMLw5KOwtYnt3F90O8tHu4SxSb6MdloD29Hzav9lbWVxHf5NORSilzYil0uRLG76HxSo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717059391; c=relaxed/simple;
	bh=xgN5sPCevFL3dsnXeVkOmW6b6l95Xb66gcGeR/Rr6O4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ggempJO5EFJ7VbavUzsjtgJOhH+fwqjYUCGVsMK3tKyXFcOGcs9ZAuvtGmqiryeAH1kdEmYEuh4i5KjfutKFBJMyrqHl16N3oxO0tynGU/SSuVzvcUd9HVgQlNMZe2CR2HaEFrjDQlj3XTa81LE5Kwdi8gtb+izye5XppWy9Uho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RyK9vlvF; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a633ec1cecdso48753966b.2;
        Thu, 30 May 2024 01:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717059388; x=1717664188; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4u0mVIC+TF9G0asIIdA4dwFhaqzCvDfO1MH0BIe1340=;
        b=RyK9vlvFC3oc9Ue506cRR7Nkbi1gn86JLxK9czoyL7InQVbWwWZ8AZnxzApR7wnVZ/
         EfNUyXxk/PnbEQjwLC8zBVcg+4C+CnkmIK01VAoFy4TKZv76m6THMkyqATANFtvnAYah
         YRmg6hOisapUGseSTKm0pbWOyFSHAt+vchmowk2Es4/MkoBZlzTI417EJNqLEvDAJOcu
         Edh9im9+7R97lfEA0oKVXhos9IqP6g1F8yGc5UdonX9qikwhDrA/oF68oQUJ8Uy4/WAq
         pnOMo1TG1fGo6B5EOIR5mq1zqfW9PKxQxb/e3WQyAZN4aiWi7Fk52AQaQYAm0nmaQiq8
         iSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717059388; x=1717664188;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4u0mVIC+TF9G0asIIdA4dwFhaqzCvDfO1MH0BIe1340=;
        b=Byp9ubXFyi4+n88GlTwK530qrasMa5hqfKfRCTxR3/fcp9VBcsTvXeHLWL1KUeNhg8
         QULp4HMOO1OiH7Q/WwHmLT4nmtnEJY5hB4eXolS6wng571Q2gcwT/NcssJ4DC3oc+VOw
         VZP84sEyyPKshRl1aNYx2D2sJytRDz5WQvg2zDtg/PXrLhPW9SP4YM6rKPhotQkb+his
         7bE59sZLbGx7XRJUck3mDfl1tvqXXaAlRMY/ktEZVIHpt1Y9LubXIdol8kHV327CU3v4
         siLoz0S/YRhrRLnc/u1LZW2ZxCQlkPQaXBmZZcM5m68dqbnPYKzcIpJMqdx6BdWgk0OQ
         Dydg==
X-Forwarded-Encrypted: i=1; AJvYcCUS1S8uYk4ZhKdlRjHj9jPFFFCrBh/rQf1iKFrHjvEE1wX4O3SKR9/7OfYjJvcZEDzn5FnFmeir7aiCoUo3w2p2C+HmYevFjpNJ5xGC0bX/wCI4IUAqNWRk7rkV41o/dFHVVuwHs274pt8KRDCdrgkdV62dwVTGyAnx5Yop6JzUOq3DvEy6Jyln4dyNtiE0otyYcPXbL5Kd4KnPimzfI14dQ6hYWUM=
X-Gm-Message-State: AOJu0YzpPF8EdcUC0bOUIHuI7stt8YqSEfJrkGUUypURoaNsROQgggbe
	FblTCjC2CV+TL+P+OMrJJUgCU/rdiQsxNx8XF5WuScKl9stxowjE
X-Google-Smtp-Source: AGHT+IEyP2TS9/8Qy85Y+45YpmvtAjOgeIsLUmtMQMYTPbaD2wIPFr75VbxtQQSyD6Y5jnCC90wdSA==
X-Received: by 2002:a17:906:1b46:b0:a66:b9a8:74ad with SMTP id a640c23a62f3a-a66b9a87be9mr10297266b.10.1717059388537;
        Thu, 30 May 2024 01:56:28 -0700 (PDT)
Received: from hex.my.domain (83.8.128.191.ipv4.supernova.orange.pl. [83.8.128.191])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc500a1sm798430166b.125.2024.05.30.01.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 01:56:28 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Thu, 30 May 2024 10:55:52 +0200
Subject: [PATCH RFC 02/11] dt-bindings: power: supply: max77693: Add
 maxim,usb-connector property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240530-max77693-charger-extcon-v1-2-dc2a9e5bdf30@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717059384; l=1063;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=xgN5sPCevFL3dsnXeVkOmW6b6l95Xb66gcGeR/Rr6O4=;
 b=9yUpKW0zqhfzMTUuyPlJgp1hjyMIPUsM3qmJQhpwZ9btkMmUIBqVTeVX28r/iJnLYrbkUOH0g
 scqSoAnh1wjB/Y4IQa9qUWVeaaQLf439Ykk2wto1MP50v5dqmKzcqqc
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

Allow for specifying a USB connector to use for charger type/OTG cable
detection.

The way this is done is inspired by the rt5033-charger implementation.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml
index 4f80cc5418f5..e5b29a8aed56 100644
--- a/Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml
@@ -71,6 +71,12 @@ properties:
     enum: [4300000, 4700000, 4800000, 4900000]
     default: 4300000
 
+  maxim,usb-connector:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      USB connector to use for charger type/OTG cable detection. Phandle
+      to a USB connector according to usb-connector.yaml.
+
 required:
   - compatible
 

-- 
2.45.1


