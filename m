Return-Path: <linux-pm+bounces-22688-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE82EA3FE8A
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 19:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 125BD189E0BC
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 18:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11F3250BFE;
	Fri, 21 Feb 2025 18:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTL2s/wC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C0E1E7C05;
	Fri, 21 Feb 2025 18:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740161746; cv=none; b=RLdHYzocuLGtGsXi4t8KYEbkZoK2jFjqHs5XjhAzKswdCbn4Bs0tTXRzQULPoVkky5+/yFMlwuZYIpa824LM7ALWI+IwLPqDNUxwShnuSedALuk1LXsgURaaBR/xFlsYN9lq6uVhULLdpN0j4A1HQQSW3jTOilO29UUPgLyG58E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740161746; c=relaxed/simple;
	bh=4XQxXF+PqlTv7K3oBNr3byDHUiGFiR8jDQTmJ+u89x0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pENOL4HHcFXfAjDai+8zYQqKpnF+LrZbXUwQHbYmCoWU1dPp0AX2/W3tId+j3wvlvJEQ4WQ1w9ZDoYpS0DQAEiS8NBrQNGHzYDwlizwSjKvjMsY09VsBXlXgPb/N7cmxqxG6R0bmqawe/4FQQYIN2owiK4wzZvLNJENnt5qS8aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTL2s/wC; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38f26a82d1dso1334822f8f.2;
        Fri, 21 Feb 2025 10:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740161743; x=1740766543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4XQxXF+PqlTv7K3oBNr3byDHUiGFiR8jDQTmJ+u89x0=;
        b=BTL2s/wCeSg6Zd7VMSmbXsz9IkruIZkwXVATHEF7EtLx7LR5Y6Nw989Qm9v3DEvFpP
         Ac8ECXZs1BnNsqts/YtYQKSgacmDmZcAPcsTXWZAInoo8AI+tVY3ZZIxeyQeiDGNvowV
         1VwFqBRHMOSwgJs1UzmyRIRFBsEMC5AMZwydN5jW8oWQhxPsMpmVtogT0EEGS4By2PAb
         QJOdazKjSH+pglsM0abDRTq5ofBK+wYM4DaD7+eJUt2kjDiT4zl3Kl9QEMbPUekVevRn
         6iXPnIZKJ78c9b2jrJ9Qn0AgABletPgz10c8C7OrNyJ++XPEKJMKPRI+ttF5q0ZqBngW
         2iyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740161743; x=1740766543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4XQxXF+PqlTv7K3oBNr3byDHUiGFiR8jDQTmJ+u89x0=;
        b=FRqsqUja18phFNbgghHQunjKdNiBXnKnkyldmMsEtfkRnDNlPqMmCAmfH8/LbBkF7q
         TcUBBI1ADQT6yCFiIKALoh4GPUkTmunK/qnZL4kUBYL7jHxP/ndpXJpDeHpXc08elrDg
         Ud3VzLuKOAPRo7d5dkPe8C76IkUZrfMmFIso6iLPNUtSFZPCXTArr61pRpemZLJ4aI3r
         rctyBZi8Y91wlheHp27rkArvNw9XmMtRsH96KuVTmSgBF6praRjEnXsdzRbxYJ1HDvcS
         xt+faI0JNOAfqgsveUJPPuqlC/dKWbjSnwDftvdDBeHIcPtaCQf1+wGX155m1MJ9m42Q
         VH0w==
X-Forwarded-Encrypted: i=1; AJvYcCVd7tNlGNmjLW0Lmtyg+HFgGQu9pb7ScITR6Wqs+LtQT6G9O6bbsEmvqT62ucDQIpXkO0Lv9gMUAfg8@vger.kernel.org, AJvYcCViUja9eFiG5E8GqsfadXH+goC26xcpCdF1O2tofyE/LFpib2Ph80oSk0a1Iz8IO65m/JVDk3mWU10=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLfHLTqFpwrA/fjh854rmhCRZc4FaAP01nbchpU6EWQdxZR7oq
	Eg0SQ7r2AzmeMPeUIDzLgKbsLCwQpNV2EHW1+AsQiMZ05W+HkPeY
X-Gm-Gg: ASbGncsvY0M7zpCmvtk3ojz57v0AMxcQv3ijYOekQsNtlz9XUmqDm41ZwwNsdTIhqAu
	XpCmj6qV5dyjM36ukybZ2y61kT2N/JOV6ff2D30W2YlrC9RmhYqTFYx8PmlYbgkMAyc+lOGVvVy
	AS62yvGIycKB0dDH4N1cM2viPlV/896cg10Mgaco4IcVFxdr7TrtvcDaSdV24idHefG9Y9H3Xjx
	seujdKm4wLvyE41S9DSluHsz1Rp7OefSTR9laluHv/vEBvRQFXB/GO7GUZGWI7R+/zYY36MRdyn
	ZyFgW5x1QAmAT3QDH2ZraLG+5yVsV1A6+EncTq/hzMU8S2owQD4wiCBQaw722006LHgLytGUzGR
	o3Q==
X-Google-Smtp-Source: AGHT+IEUcd8ZVq/GSMpj0nEp4xNKJ3oVuqW8jkTX+24Fpx6yj7XA7+1f/SvbeSr2zKHVbT8cItUZ6A==
X-Received: by 2002:a05:6000:1543:b0:38f:46c4:4a6e with SMTP id ffacd0b85a97d-38f6e979cdcmr3162525f8f.24.1740161743326;
        Fri, 21 Feb 2025 10:15:43 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f2591513bsm24244645f8f.55.2025.02.21.10.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 10:15:43 -0800 (PST)
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
 Re: [PATCH 5/5] arm64: dts: allwinner: h616: enable Mali GPU for all boards
Date: Fri, 21 Feb 2025 19:15:41 +0100
Message-ID: <13703667.uLZWGnKmhe@jernej-laptop>
In-Reply-To: <20250221005802.11001-6-andre.przywara@arm.com>
References:
 <20250221005802.11001-1-andre.przywara@arm.com>
 <20250221005802.11001-6-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne petek, 21. februar 2025 ob 01:58:02 Srednjeevropski standardni =C4=8Das=
 je Andre Przywara napisal(a):
> All Allwinner H616/H618 SoCs contain a Mali G31 MP2 GPU.
>=20
> Enable the DT nodes for that GPU, and specify the regulator providing
> power to the VDD_GPU pins of the package. The rest of the DT node is set
> by the SoC, so is not board specific.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



