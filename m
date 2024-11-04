Return-Path: <linux-pm+bounces-16951-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC2D9BB550
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 14:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB2721F219E2
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 13:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04851B81DC;
	Mon,  4 Nov 2024 13:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmFT/Mej"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161E11B6CFB;
	Mon,  4 Nov 2024 13:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730725443; cv=none; b=F2mZblqn9SLBiE9DXGvWykK69MxEyIx6S1GPEAwGd56KE45wzG4mGwF4wrNX46y5ZoKlvJf065uOQJMiKg13b7WoOsv+xL8O+aHVznIrDLkeOYo+NtuDGdZEUl4+odt07g1Lt2fdtMTDDaLEr0prG4BdIsDxXIIT1uLcQuOVMaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730725443; c=relaxed/simple;
	bh=cIi7IdtDKRTqlb0gwRNppufCAevmGQsObSSOfUk50NQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rxv78/A6k/oSzqyOg84zUzQkgVNpWe2XEvvkiPzXnOIlujLyANs9o91tIzGGX7Z6j/CTDjk7Uil5nu7Bh58H61HdWCGXRmNv5HfTw8a5tekJZphwMnpvJcTeLcl+yRLYLF6/LUDHLzb/JrgiwMpAoR0lCBj8tEep6+1Uwd+Q8hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmFT/Mej; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c94a7239cfso2461038a12.3;
        Mon, 04 Nov 2024 05:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730725440; x=1731330240; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/xNr5bjUuKv+gLsZZo/UhY9wFOFlYAZuNJjx9SZxPu4=;
        b=cmFT/MejzrYZP2vcckvgiGH9CV+wZmLQ/9KW+Aeru8qet+sb+gE/+SqYluuHOrHk2n
         LydFBRzEt1Q4HJzeytZVfn06aFXApxQqwGBi1miO+5dFdjMCLKVmxHtiZXNNJffwAFDL
         QfH1JAcp+/NvrguwaMQcbT5uTYwJMSHw2svrkvFq75Ktbc2+Jm+VbcpkR7kUmKIdmHfP
         8dy/B7JjrzqmwDOfRjvE2I+serHVXQz0TAG5dYV65anHt5oT8E5vivNxI98jVaGE9Hq9
         wkl+HCTxKwzVMyiMw2yKXI4hhrbgQsRLXHatET9l8yeempNEVk6583eHVsazeuUKrA5v
         vwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730725440; x=1731330240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xNr5bjUuKv+gLsZZo/UhY9wFOFlYAZuNJjx9SZxPu4=;
        b=dQFAuHVzEoMWTxuHkYICuf1WR8vpr/YMMXS1rw2BrAqeOmgqb1FrhFeFr5mo+/Mh/z
         Qvh9KP6tLrLmYHp0NJ+07T0OkJcJtu3DYpRi3KUyOwdJE/gZFp8fptKmK7OU4/AnZq5A
         x5PIOKJm6asmTColDv/GXpP8L8sE4nam/St0VWiLGAGU2tMl50oe2bIr6NFMSRwoTvNp
         iDDm5Bq2dBxGvFDt/Ta8Pvo/yVUdCN8baEABdHdhCi6ooZo8YO7XYjprhjJx07mDzH52
         XUgnGs7Mr8YL+RNDBmoc572/smplUeawY98G06JNaFIaJ0txG5sCN+V22NMvSjtb1JcM
         Izfw==
X-Forwarded-Encrypted: i=1; AJvYcCUcci88SnkNvGpvPM6mpFCOPMiC+ac+IFDDQbk4GtDKV3eAMWoumOGkNd4Jk7vWJURY+cQgGSIIP+//mN+M@vger.kernel.org, AJvYcCW2/Am3maQjQ3scvkJyc+eWYJ4Zml+n+t1X008/EUScw8gK5HGez4Q88ufoQKAMX3AvYaN0coCJhzTy@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7tbtJRPWYDZEjQtbV+Xg0tA1Mq9rqysqfP+gjd1Z0VSHdvEvp
	ItCyZUNP5iBYuM3gOD5x1CsO89F2w7qIts+xvT+io9TFMbFh2K0B
X-Google-Smtp-Source: AGHT+IH+wCyNdmki4RIpXvzd9Ia6UtzVSVtMSHIR9aHs0OsKUZqe6byELdEnFU9k8F0hkMXzw2+gXg==
X-Received: by 2002:a05:6402:26c8:b0:5cb:b616:5ed4 with SMTP id 4fb4d7f45d1cf-5ceb923ef3dmr16473289a12.5.1730725440211;
        Mon, 04 Nov 2024 05:04:00 -0800 (PST)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceac74d485sm4168069a12.19.2024.11.04.05.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 05:03:59 -0800 (PST)
Date: Mon, 4 Nov 2024 14:03:58 +0100
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: power: supply: sc27xx-fg: document
 deprecated bat-detect-gpio
Message-ID: <f334c973dd4e6390a0cd51dbde358277a07604d7.1730720720.git.stano.jakubek@gmail.com>
References: <cover.1730720720.git.stano.jakubek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730720720.git.stano.jakubek@gmail.com>

While the bindings have always used the correct 'battery-detect-gpios'
property, the DTS and the Linux driver have been using the incorrect
'bat-detect-gpio' property. Document this property and mark it
as deprecated.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
Changes in V2:
- new patch

 .../devicetree/bindings/power/supply/sc27xx-fg.yaml          | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/sc27xx-fg.yaml b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.yaml
index 9108a2841caf..b10f155afe68 100644
--- a/Documentation/devicetree/bindings/power/supply/sc27xx-fg.yaml
+++ b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.yaml
@@ -27,6 +27,11 @@ properties:
   battery-detect-gpios:
     maxItems: 1
 
+  bat-detect-gpio:
+    maxItems: 1
+    deprecated: true
+    description: use battery-detect-gpios instead
+
   interrupts:
     maxItems: 1
 
-- 
2.43.0


