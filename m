Return-Path: <linux-pm+bounces-34522-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E289EB5434C
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 08:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6ABB562977
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 06:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9613F2951B3;
	Fri, 12 Sep 2025 06:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpNfUPyh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5398828725A
	for <linux-pm@vger.kernel.org>; Fri, 12 Sep 2025 06:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757659932; cv=none; b=rPX9tV33mvG2z5McgQ9BpSNz+TMawQWhOnqai2+I8P1txLTQQ6jMYHzweGUujsqY3EqtpYseqdhkNRqxDM2GvhA/X6fMn/1X4Txs494qJK5A+V9MFFQOfbej46e0BNQxZGSTVJQmv0kI0rYnPgAlUmYAsbHTVoy4wUsZGwVex5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757659932; c=relaxed/simple;
	bh=4jsSkRx+IjEMBxPTsR02v2orYmAPSIB2nNu/YIBdHao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eKwvNaUge2uf+DbgvGDIyHxc6QH03MrXqwD9NVsdix+swYr6cmwEV0c5RS6aV1DwxSbvOd7GinpR1sbo/RG6+usgUufCey8qbj+MSjl8IhBspA4zLaGFtiL6RkIsez9ZhoWedQtjsq8vBXS3qLvJEf73RrQ7AxHafC9GZQPOWxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CpNfUPyh; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5608b619cd8so1893951e87.2
        for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 23:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757659928; x=1758264728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BTTBebWWhXN3M2UYO9CY59G3Xi/GF94b78s/3/RA3Mg=;
        b=CpNfUPyhhyanYu4ycDhEVbUrnsOVmbilCx4r++UUMg4Wzm/MkaCPiD5M+kcZ7QvME9
         31y5R3rgMi27zgT2qCik+Dyq6+lAPKCBTMrqlA0yw/6Z0lUdtQRhJr6X5PByV7AtJoA+
         3Wc5iFJhAXi2ipPSA5/OuG4/U7CsO4uZKf0aKI/o5WR/jHQ9pwwH3WFl43EN7oJhRHdo
         Py0BFrZBaRKuWE5etJuyKl7ROAcDdjGIGW8m/+6TysKf22pMB2HUrfrXwqtOK/Zkp7Sy
         WLBsmrXZoTOqWv/J5UANZ2Dm44WcbS8WXq9nmnCfGMj+nc3Zg9xiWoPR0chAGe6hZLM4
         lZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757659928; x=1758264728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BTTBebWWhXN3M2UYO9CY59G3Xi/GF94b78s/3/RA3Mg=;
        b=MPR2Nt5VDk7B5lVQpmlz8v+IkzwT5amwWXmyo9kU5l8bqLeGheVUBlCm5JNiZzI6mb
         Qjry84d0glvS19ZQeRMXHMHTrjYFUEX/1Yk3pn0leh8P3igoV6pgStleKrracGoM09Qh
         jIMaTxfblRniBQlJUJeOpHRgSxpFDimQASU5FWNVhg5+28JpY5XTQyPUSYRbuLfTRsj7
         Gt1r294BLS9VaN2vOmrjdm4J+72IFm/DxOtLsWFgENNbb80MR8LGgJ8hcbikKavXA/5E
         KHlMhvc+d4MdB4I/uaCRm5q/lA5n+R3A9I/Dv+Wg2radl/a8x9RnY779eEmukj6VbD17
         0VYA==
X-Gm-Message-State: AOJu0YxuyYg2mHcXLCrFeuE0L9/Jf0t6G4ZNTTY/zAOAny9LYfAAKc1Q
	saIS8j+vX7QANxTUdkmDY296fvC8YK1I7vmVbhP1YiD+lGDrDiVQ7RxCEBKdLQ==
X-Gm-Gg: ASbGnct3AkibrXc12ZJNIIWYW7Lfo10nr2wn4rg71w5+PEQ5jHNLfJBrepNXtLtqQLI
	rT2cIyPvXoJFER5sLkPN2QunMXUcpOVnRlMohYhcQWBQKrlnxrI8kMZVTznB4DSwHRBASpJ1jhy
	Hib79iuxhZw9hzSsz21gpUkMyXMfzWTTL50BYsBQ3ULy4KPxxb3WGU00+577wxyhTRcjp7ZlFqY
	wMW5gG0VVifg8be+307cp/7Qd3xJiMnbB1j/6jaoboi5mshipImChtstzYpdcF6Kt2QDyIO1o9q
	VWgaw2VVTPjQOJMy27bEwn+GEsZTNKR6m0q62CZOEiPzR3rH+z84G/wP1kZA1DdV/F00LQry0DL
	FEY79zY2CAG1Hkw==
X-Google-Smtp-Source: AGHT+IHbStwX8UvTaaxauHpx4VlCk3zXqkxaVM6ehQuMNCkmsiivpfkznPcjNjP44Z0KKwun2cLt5w==
X-Received: by 2002:a05:651c:3543:20b0:336:6c93:9726 with SMTP id 38308e7fff4ca-35138cfbec6mr3457941fa.4.1757659928149;
        Thu, 11 Sep 2025 23:52:08 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f1c5d5a49sm7180351fa.66.2025.09.11.23.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 23:52:07 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/1] dt-bindings: power: supply: bq24190: document charge enable pin
Date: Fri, 12 Sep 2025 09:51:45 +0300
Message-ID: <20250912065146.28059-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document active low Charge Enable pin. Battery charging is enabled when
REG01[5:4] = 01 and CE pin = Low. CE pin must be pulled high or low.

Svyatoslav Ryhel (1):
  dt-bindings: power: supply: bq24190: document charge enable pin

 Documentation/devicetree/bindings/power/supply/bq24190.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
2.48.1


