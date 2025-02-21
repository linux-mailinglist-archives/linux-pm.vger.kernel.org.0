Return-Path: <linux-pm+bounces-22687-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59647A3FE83
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 19:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC8A3189E046
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 18:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE872512C9;
	Fri, 21 Feb 2025 18:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOlXGIFr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697962505D0;
	Fri, 21 Feb 2025 18:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740161671; cv=none; b=i2Lwl8MsfFsLB4Guxr5iJua9wCaXrz0AcHrvsubK/p/SaK07JUj+9BZXiZebUqEVHVja7plw4aI2dWo5c/NuyX7X0xshD/zLlCsjmOZhmwmoIGovUE+WokrnI0/+3we4LhP+oM71TQwpdEYrRDlbFYI5Cb2lyRP1VDMEqaGgKQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740161671; c=relaxed/simple;
	bh=ECSKD5NbGIjHx0Bm2KDf0mIGC/IQOT4lmpj8nrvLpXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s+xdSS3iyjr9RYWPHCQ4a6iCbj5jjrC3XgBsS+7VU7RTj1c6vcvy4WSN4Gvl3PpQAFO0quucAvFJEDRvJjbu3v1u3ESEFwQ1l/mIaLH/LuovYcLY+daSsYQSYyuwziLpzUiHSsFE8u4dPn4oAV1FehzEbXc0R8dHziidRjee3D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOlXGIFr; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4399a1eada3so21278975e9.2;
        Fri, 21 Feb 2025 10:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740161668; x=1740766468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ECSKD5NbGIjHx0Bm2KDf0mIGC/IQOT4lmpj8nrvLpXE=;
        b=hOlXGIFrjwfP0bQroz+pm9HOb9dFDFWpzlGkVsu3qIUHrRQNyA3YTp4HTUPg3t3ZtB
         /RVDxuqpSbiG57Hc7fgKptXqv3SCvZxX90K5OggyN39UT2aSvX7E5Wf/HWxBi05I0RdW
         h+0/Its/gid1QswGjxJi+glGA/Q4BzGyd/XR4sJA0EICwkbVka9gCImYpR251Eyqf1Vu
         HTf6I6ExQLBioRsbpuPCEq73itZ2EzFaaAnCYdZE8vDvUM+NGdLjD8A6UEDkIe3gZwM0
         ud0FqgcMUpKyrNETZRtgNbPwjXTIiF8lJUBNieRev1gRWhjtdyqZTBk0eZC8KAPryY+2
         +NvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740161668; x=1740766468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ECSKD5NbGIjHx0Bm2KDf0mIGC/IQOT4lmpj8nrvLpXE=;
        b=CmUGMEF+68Vv/7DPzZE4R8XZSGz4Bk1jC8KE69r2utJ1lRpZANIQVl1G4JyK6OyX/J
         DWHuMUeEngxyPQsTkmJpfhDl8x4NYGoW58rbPIKjkwnN/XUphDAojjybfBQqKKpogTul
         WeaXP3Q5Tp49VgkRf9mZntcJmyiM9bq6k/BivdReQfh1v3pAy0P8+ff5pMhX9rtz6arW
         ISat7RjBs4Pg3WlVLmDiNrdnZuv6gTUqxkN7RjMLHoPD04rSWgVLZuWwse849G+yOXJl
         PiySrFDQ5HVULiU2QAn/iGdOrbV4iIxf8vjM/oHtLUEvFBlkwdouwvuqV15tTtlZ5wdG
         oVfA==
X-Forwarded-Encrypted: i=1; AJvYcCUrQf6u9oMOJRz5jeg5Uwl6STHyJKetxnjE36O+oyXVU6MkI1wf97EHBkW5qSOFvRzJx00nwB1hHqU=@vger.kernel.org, AJvYcCVTN9wi5zru2brFYEBxl2PTlgT8iQ+QI2uqc/P81AozPmLLJqgvLyVPHBRdAtIv1jHTYDWfpaI6Zj3S@vger.kernel.org
X-Gm-Message-State: AOJu0YwPsklzS1PRkJtFN5RGH/DHciVsNxA3NCbvY9pM/nImvBfPQ//L
	10iSzsll/++PMWDnOkWKzcFxTwEDid7RFPYHqVqP0P+Y/xJa1HUa
X-Gm-Gg: ASbGncs1YqQDNTAmbVkTsIL3eV40c/qU+RpLDpaWGN8NfRM9hTE1e5RWicX835Z/SrZ
	4abmtKf21kOqtXIpmCOenAs/dYV4wdm8W2njKYf5m+Nk4o+bp5MAFg2akt2Izx/+Tpr/toG/hVw
	UjSFSPmIQKaUws1+SOQgvVun8gTlkD5F3yQx5ADnR5Rx4JB9/YlquGpkMGQUR/S8HDvZuZa70Xi
	vZkSK0h2FNff4kSEvT90r49QxobRp7lYcId/U/QYDCs4lCksd1d8CudQKbie3b7o/cFe4LIKXK1
	ShVsjww8VKQoUUxYXQp4coHjRvG5WB4tsw+/vDshqe4Z6JE6p1wqQFkEcC8L3StanMINvAR9IqM
	4JQ==
X-Google-Smtp-Source: AGHT+IFTozi1CVAZhzesUHKfQ2k63P/tS7KXhTKQwhP11mPloHJVn0P3vCQGwTQrLHtArYDTD3nLVQ==
X-Received: by 2002:a05:600c:1396:b0:439:6d7c:48fd with SMTP id 5b1f17b1804b1-439ae1d877dmr40268755e9.4.1740161667381;
        Fri, 21 Feb 2025 10:14:27 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b030be5esm24430595e9.30.2025.02.21.10.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 10:14:27 -0800 (PST)
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
Subject: Re: [PATCH 4/5] arm64: dts: allwinner: h616: Add Mali GPU node
Date: Fri, 21 Feb 2025 19:14:25 +0100
Message-ID: <1911773.tdWV9SEqCh@jernej-laptop>
In-Reply-To: <20250221005802.11001-5-andre.przywara@arm.com>
References:
 <20250221005802.11001-1-andre.przywara@arm.com>
 <20250221005802.11001-5-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne petek, 21. februar 2025 ob 01:58:01 Srednjeevropski standardni =C4=8Das=
 je Andre Przywara napisal(a):
> The Allwinner H616 SoC contains a Mali-G31 MP2 GPU, which is of the Mali
> Bifrost family. There is a power domain specifically for that GPU, which
> needs to be enabled to make use of the it.
>=20
> Add the DT nodes for those two devices, and link them together through
> the "power-domains" property.
> Any board wishing to use the GPU would need to enable the GPU node and
> specify the "mali-supply" regulator.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



