Return-Path: <linux-pm+bounces-22686-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 268A4A3FE70
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 19:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78D6219E090D
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 18:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF7C2512E7;
	Fri, 21 Feb 2025 18:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0D4C4bG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1CA2512D5;
	Fri, 21 Feb 2025 18:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740161480; cv=none; b=UoOD7poOmIM2xjlwl20txNy6FAPHMNiMeRMfRp6fMyEWOibR9I7WhIXc+cV6hxyQrXg2fEQY8oRpMrpFuha/udh/EBXskrl8QxI9/vbINV4FzPvH129OnXEjRWoyNYNwDpWRBHQeTwIXajPxAuygERvFIGqY/bCIrySQKKmx09s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740161480; c=relaxed/simple;
	bh=ZXeJpH3wHw7BU/7D32jGOtOKsJu0r75YAYsNnjjEMw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dc78E3g9uq3rE9wQcO5nx1KRJiW4vkH4Hc56ksO7b2lFRuih+x1joYIR7uGgOSCvX9OSCAvmIf73tr1cxmqe6GVQkOpLb1xgq33GUbulAOi4mxBDEs0w35gERtjGLQngABc73lmhqqh3nQrjIU6vabXBbawonGcHNfyo9MKmSsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0D4C4bG; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43995b907cfso15550995e9.3;
        Fri, 21 Feb 2025 10:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740161477; x=1740766277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXeJpH3wHw7BU/7D32jGOtOKsJu0r75YAYsNnjjEMw0=;
        b=i0D4C4bGu3lc2KG02MfdOgGx3V73k5ATzR2AmsnIQMilRRI+tVCc2Kq4qfhzEwD68V
         O8X05oJLVlHpH6Xhm/dLSpiGGQu3r5ne34NutW5j7A4GiT7viVhkt3gBvwcdAMoW/PUj
         mFAVQXIO0G2Ic/9h0YkJCnhb6yJSMXEc1lwxTbxr2zHXMxVI0WQfI+hqTLUYpotTAX5U
         TW3ePeJBD4vQ/Lb5qtlsKGES37H44Si+aAMdGAV1noe/Et1sJ+djM5NTawqQ2xLUrJeD
         JsrccJoE0OkwBV5wgc3M5mPZLL0YRN2upSgG0GUHd2BZwKfSJN39E1rAitiPTP+j3xXQ
         nnug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740161477; x=1740766277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZXeJpH3wHw7BU/7D32jGOtOKsJu0r75YAYsNnjjEMw0=;
        b=E7N/sWDzw011FWVwQMQtWYnDzgQTez9jZ/DMwHKXXDX5jv4d7OCKGQl+KEV41vI7xe
         Ana9eS4EWDeKgZiNNBPwVU4yCxWYf6sgATbFsO3mt7EvmciaOuygr5+dVCb9WVh61Pko
         P4UthkCtI6h30A2S7HbZJ7+7WmC0E3h5m6sDskCO+AxZyXsfGhD65ioa6LZ+CjMA0Z/x
         8hEh7hwU4/iSgHeFMMh5JCYLMvr6LQtCcsZ5KEWj0dIPtVyU4rB+dcHdmPde7kFcMG7J
         V25InST9WldUlfcbAQuDkGGQrFU8+3/qVUfTBpytuRaILjP81lVDzdkMBUuCFDOUKnBE
         7Y0w==
X-Forwarded-Encrypted: i=1; AJvYcCVHjrFVjgd+c7ZXCryOS6U3d5BzBIvk3sSIp1gnpvsvgD8JOYRIkr3wAn57ksV3QPw/EQZcs3aEPrE=@vger.kernel.org, AJvYcCWunID5rs3MrdWWPiPcwObk2rTKkMHn/2VjRlCxNj4ynGsLqvfIuKKjZJWk+V8Mu0a6kuvHpd3Px1/3@vger.kernel.org
X-Gm-Message-State: AOJu0YxVWx6kszH9gGbebV6qep3OS//t19wEFicaXiwKeZhqewE0s9SW
	gIKlr5aRDuTzZcyxwCYDV14Hq2bNVmqbqX/6GHL6SFvDC0mmSDCA
X-Gm-Gg: ASbGncuwACYq7exIXwJYh900cc1wE8C5skOvSnZTegLaMmDKFnFcvLrIkwGoZOyYdQl
	SkLPFcSQ+lFZOAZmFhrRX9NbwGT7Kcy4waj3T7CLE/ybtHjnbypz45m1Wy13EqNiL9+61siNfDU
	kJAonaKzG4uLaO3w2NHquC4t8/g44vpbJ4YRGU4fVh9Rfm0ZUqh7ZxH2qk7AQ7ShSip6Q4VBygW
	Lo12k7YuMGSGeqagJuWly5YPR8ofuTT00Ty9E/+9lCiT37JodOPEQ27klAYQ0L6edO4cqEgH5BF
	9NJJ6/b6cT/cZ2AR9DH46Z9q6fbYD98Wlw0SGLOrsfHnz5CmTCobxCh8T9kwVrSSyapoFtr84jZ
	bsA==
X-Google-Smtp-Source: AGHT+IHF/tsnTWTEpF4H0kg8q1A+TidSDULFwV9+aTYXkyTCuSdYjLeHagAev7Ne5ELDSe/ppYbBWg==
X-Received: by 2002:a05:600c:1ca0:b0:439:9e8b:228d with SMTP id 5b1f17b1804b1-439ae218a14mr35556225e9.19.1740161476437;
        Fri, 21 Feb 2025 10:11:16 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258dcf08sm24356178f8f.36.2025.02.21.10.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 10:11:16 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, Andre Przywara <andre.przywara@arm.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-pm@vger.kernel.org
Subject:
 Re: [PATCH 3/5] dt-bindings: gpu: mali-bifrost: Add Allwinner H616 compatible
Date: Fri, 21 Feb 2025 19:11:14 +0100
Message-ID: <2356358.ElGaqSPkdT@jernej-laptop>
In-Reply-To: <20250221005802.11001-4-andre.przywara@arm.com>
References:
 <20250221005802.11001-1-andre.przywara@arm.com>
 <20250221005802.11001-4-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne petek, 21. februar 2025 ob 01:58:00 Srednjeevropski standardni =C4=8Das=
 je Andre Przywara napisal(a):
> The Allwinner H616 SoC has a Mali-G31 MP2 GPU, which is of the Mali
> Bifrost family.
> Add the SoC specific compatible string and pair it with the bifrost
> fallback compatible.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej




