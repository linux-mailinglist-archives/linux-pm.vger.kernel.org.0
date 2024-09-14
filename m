Return-Path: <linux-pm+bounces-14218-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE20978D8F
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 07:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FD91B25C05
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 05:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B431A19BA6;
	Sat, 14 Sep 2024 05:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTTL8Nkb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A13A20328;
	Sat, 14 Sep 2024 05:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726291509; cv=none; b=IIhcN/M+NK9QGJw93RvVfwy7mLWeKT7sevK5KzWH86ThLV+5N3crn3A75hV9F8BJIqdLGebpyLB2TzRi3k9D9ibym+0oHt+mmCCPKY53cm5JgxXEiiyOJmRClWR0TX4kB33iSN2208V7DBhU9AovXAuS0VmSTX5Kz/313ZC4/SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726291509; c=relaxed/simple;
	bh=wjv7S2defJHb4w2LIijyyI7ICLEtDGHr6+Y7Ed98jvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ELa4hY23GWtaF9sF9CUwTCdFG1xQM47TZDG43Hc0c64XLfcrwrWQuJfkdEQ9BYakdvJ2IOXzP0ngrZeWzxxhU5JtJ7xupuVaOQOH/UkA9K5u5csx8dEg931smwA8bpQCvjAlkFTA5VR9MWiXp0PyswIQh2JsKpQhsyMDJgXN8dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTTL8Nkb; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-718da0821cbso2238999b3a.0;
        Fri, 13 Sep 2024 22:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726291507; x=1726896307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=drlfe7ijxNosG2VKP6kf49hdRW10I7zx+SACXHP4QNc=;
        b=XTTL8NkbPDsDDQI2nJYP0s0RK2TGumUGM7753YcMANWDVSqaf3xPWHyxvyGHwoBgAN
         aEiJeovLU6Gp1//zmKanx3dOHQmel/FADr3IMGgN9hhBa9mQnf4sYZUgKuUKSNlu5I3+
         C0BpuZtulvxZyuWr9a2NctiDoU7oPOLhU7A4ETJ+iDIL/aMHY7zCiDiXRczOrWkEyU/2
         7KU+5cICZ3UMK8XQI5orqGxO51raRR0Fea9k3RdH1NdTmUJQ6SGS7BiklrvKklvLTZG/
         W8FdYfZC4ybvvl6pvnGb7XZVI/hqYjDrqZoOhWjegkzUEpymn9uFAYbWy1isCSb23Qyy
         R8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726291507; x=1726896307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=drlfe7ijxNosG2VKP6kf49hdRW10I7zx+SACXHP4QNc=;
        b=wNYU+4cevgOUejMJNPunAysR9ctt2LJNfxMY5cDUTleSsYBO2O0exWvOgAMTjDYTC2
         dsPuNnOsKp/ns36wJCgGQMQqVLJqnU/W0+Z49fAl1SXVNkTA8z2yZXXlUBGAK3Sxn5Bw
         Q/iXHRT/ZF34qUgbiy4H/IuCMJ33rgJdkzEJWdBFm2hs70D0O3hkMR79iEP5DtE0AONj
         oz0n3Y09nGS74USL7EnQUADv8BYO/JpvZaqN+SQy6gKQ6JOAt9dE0lH09xIbK6RLtCoV
         fl4ed7XBWqabOQdzy2+JmJ4KmwOa4oaADUOf/jXOtTnpm67CK0z3GVsRmROBz4tkr9bh
         5MoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVz4Aolf4m1VNhzx8Z4/+AKBguUcQMrmXtkI0oChPHYjDwqUg96LdoOX884vZlxkjPE110oNwSWNiEa@vger.kernel.org, AJvYcCWKzXBcFxRZ295Gdffyzo6Uz36p3XIcM71pRYVnhb6pZn+E3cfLq72w0IztObmHVK5d5ZIRE7yrjps=@vger.kernel.org, AJvYcCWTFgcF6V+zSS3ixlJAI8q15bT+DUDlGftDnowSvAC3kZ0EaleHMAs8XDJ9RiuyIVYFWLtgkT+Gser/Dw==@vger.kernel.org, AJvYcCXDAXeHtMJTygMKdK75nL3XPXlu6qHPUh56sH1YijQJIVaL+rBI5LxdDFRvSV/xT4YtOqw3vDuT2dOk6YjEIwY=@vger.kernel.org, AJvYcCXh6foShaEU8WwFbPlqOnLV51ZG3LE1dxu5p7eD2rntv+sNnCqPizOjqNfuTqGxxII3nVzXvTkx1l5AhUfh@vger.kernel.org
X-Gm-Message-State: AOJu0YyEFBnPqCZgz6MXXPG+gpSIGfg8hwhegSzoFLjEpV+5+ccm/C9i
	gnt/PgT8Ds2mEaxOQ94byfKFsRkNM0ajhrnFCN8BYGQ42xyicMhB
X-Google-Smtp-Source: AGHT+IHkKmn2lhDEjah/IlC7WZ3jWd76fP6Gw2PZutOZX4q0PpkGixHypso1ex28/diQ2yFIXgMejA==
X-Received: by 2002:a05:6a00:1906:b0:705:c0a1:61c9 with SMTP id d2e1a72fcca58-719260826aamr11109442b3a.9.1726291507338;
        Fri, 13 Sep 2024 22:25:07 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71944b7b749sm391223b3a.113.2024.09.13.22.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 22:25:07 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Cc: Nick Chan <towinchenmi@gmail.com>,
	Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: [PATCH v2 02/22] dt-bindings: watchdog: apple,wdt: Add A7-A11 compatibles
Date: Sat, 14 Sep 2024 13:17:09 +0800
Message-ID: <20240914052413.68177-4-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240914052413.68177-1-towinchenmi@gmail.com>
References: <20240914052413.68177-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The blocks on A7-A11 SoCs are compatible with the existing driver so
add their per-SoC compatibles.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 Documentation/devicetree/bindings/watchdog/apple,wdt.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml b/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
index 21872e15916c..310832fa8c28 100644
--- a/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
@@ -16,6 +16,11 @@ properties:
   compatible:
     items:
       - enum:
+          - apple,s5l8960x-wdt
+          - apple,t7000-wdt
+          - apple,s8000-wdt
+          - apple,t8010-wdt
+          - apple,t8015-wdt
           - apple,t8103-wdt
           - apple,t8112-wdt
           - apple,t6000-wdt
-- 
2.46.0


