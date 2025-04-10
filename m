Return-Path: <linux-pm+bounces-25081-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1CEA839A1
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 08:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 937281B6216A
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 06:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99CA204584;
	Thu, 10 Apr 2025 06:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mzw1lRdP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418DF1DFE8;
	Thu, 10 Apr 2025 06:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744267439; cv=none; b=mZpw3G932DjevNMKKrLy6rGBLyFQfDXuLwMAaA6D9epAoMPEt07NMojVAgsZGkhPcbXzx/Cbw8zD5130Gm09jE4XUSY0oWZqNhHWm652Komkw+K4WFsjey9KQ1PUHUUTcsDJtNYjgSoeblAdlzUfCmkju5fS82d/5A7dZNJnAFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744267439; c=relaxed/simple;
	bh=YV128qhGuAyvX2XLDTOXX2NTQVmvho5pgSBUUl0uM3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ah04Gh5axr6Uwg8BAuppn8MUMB+iTKqIA8S8P4M+ZVIEw8YTFsXsdscG8Q5Mpe3/y0LIYaraLc5VVDhdB5tLJYS5blLwfYrUIqH8kM+CDrLNAfZXCTulhGp54TJmt+NXzMORtykOpywDMxvvCoch/Qf0eNN8YzoS+l1BXBw+x0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mzw1lRdP; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43d0618746bso3004395e9.2;
        Wed, 09 Apr 2025 23:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744267437; x=1744872237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YV128qhGuAyvX2XLDTOXX2NTQVmvho5pgSBUUl0uM3I=;
        b=Mzw1lRdPo02QVuh9s+UZh5mH9ugApObNp6FmDb9HaL2JEjYeCFo66Yr8OX4+lhXoNd
         k0UO0ajbnvt1fpiS+YCzfw/U5YVZmImdNfzv+5LkLMQ6JAkFWllw3iGVMsRpwqOBgjs4
         EGJSttMp2nbIhyrfQtCm9u7lFRMasSF0y8d1zBUD3U1PJImgeZQ9YgqKm8ySec8a1l0h
         9Ggy6X5S1SlkodS0cntTiutBVT3tzA6UPXXSeRR5sHuKfwOS3LVOELfLN7eFjjblXYK9
         SMfp8+V6OUES6T0R8SBOLwKmY05iMzv3jW8jaY75uPh9GLPs893BBsjlkHeEiddlzz90
         Vdog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744267437; x=1744872237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YV128qhGuAyvX2XLDTOXX2NTQVmvho5pgSBUUl0uM3I=;
        b=YfJTBGTGEy7Q7v8tc4GnHGRigZ5Nj9PR8cwD0ezpl1PQPNr8TjNBrhf1Lpoq7Y1IyG
         l7gMnhfTDPKJx1SzdysKcmsmL1zqBl1Qkmehrc57WExJ1540w8Y3QPQcnG6YN0Gy3/I7
         yOgLxdscsAZYmpWIlr9C2N4EzbwOvmO9O0jKSJr7U+nf9HoGgARzXu9UUtmkB8GAQxkG
         7KNl7PEkLqAEz4BuEjIn9DkduKm0FqR2kOmLyANEC4Nbufmqh1StDPeaxt98HatimpDt
         bZyfKC5iyefuP8/+JxCybPr1nRHqmD0rJcZ960fs2zcBtIQjnpkZchIXLz+x2SynyUkk
         DZkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgp8WkJTzE3nSLB7T6f7atAZ4Wbzco962VGypLUqQfE4oepLhe0PHOogUorncZRbtwKE8fDovkbuQb29B80UGHpAU=@vger.kernel.org, AJvYcCUoVbMYjuLYCP6ocZ3Xw99kgZ0ib4HcscbWAPp883SZlBIS6165vV7i8OtSXVVF4lHySJB8rZKme9N88NMo@vger.kernel.org, AJvYcCV1IwHCAx60aqa32kXYNxIcJsVHZU8LuGbuWLRa0zUeOORxSdUqC/Rib9Rc0/y3VDAb0idY29QTk8c7CC1m@vger.kernel.org, AJvYcCW8D9vJNrD0JHqk73lhxiGG9WIvj7h/akezFPbDcPmA6iWOkgqQgxJwLX+LVSx4GR4zJftAPBU9G4c=@vger.kernel.org, AJvYcCWDZuKnzwYV4cKXQJGtgECIJpQxmTK8zGZ5eRceKQh2JSKnA6NiIB3xlY2h6iDEsI32Y+11REjRnr5Dqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMgZlRw3i5Kl6Jg1lFiEKISzRhrAeZmIl8MclK7da2q1RHIG0i
	nsAaew9FpQoEzzM/D+vt5NVamvL3eJQDZqgxLxwXPyxMh6IQyTLY
X-Gm-Gg: ASbGnctjZtwyMlrII+VGRNGcQjICGgm+HknT40zVYsbeBYSunMpjWWWIyo/kC+uCvVj
	MgBjeB70k+kNM/V3vXqTU8DJ0IZrcNtjn4pNIXa3OXkOLnz7TVj34hwxq6xPifP+rQFtkRrP5EC
	YpBjZMwwHuyP6wkIqPhpXF9I2sB6JlKNKS0w2bgqZIOTBHipxUOplAnTKDVTVw2E7as4EQTuHDP
	Qd/JfL9qY6/4RDyUWLeYCsucKTlMw0PjdafoJ3x9J9D7ysqUUHEtcxxs8SpMBhIZVV2CGu4DmPo
	xdaQz8h6o2vXjgxMRoGYw2Am3a5pgNjY4+KcDcNmNGAczwSnojstgO9e6BsnGwX9gg44qu5i7A4
	d602CB6ox9LGu4pqL
X-Google-Smtp-Source: AGHT+IEL1gPJzOAzRp7flPkyN4Ef+Ndtjxrjlvobznu4GMFiYPht20jH1k+dVvg8c3EBb+I0DiJViw==
X-Received: by 2002:a05:600c:3512:b0:43c:f689:dd with SMTP id 5b1f17b1804b1-43f2d7e9229mr11997625e9.19.1744267436516;
        Wed, 09 Apr 2025 23:43:56 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f207cb692sm46662105e9.40.2025.04.09.23.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 23:43:56 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
 Stephen Boyd <sboyd@kernel.org>, zhouyanjie@wanyeetech.com,
 Conor Dooley <conor@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Steen Hegelund <Steen.Hegelund@microchip.com>,
 Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-mips@vger.kernel.org,
 imx@lists.linux.dev, linux-rockchip@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-renesas-soc@vger.kernel.org
Subject:
 Re: [PATCH 01/19] arm64: dts: allwinner: h5/h6: Drop spurious
 'clock-latency-ns' properties
Date: Thu, 10 Apr 2025 08:43:52 +0200
Message-ID: <4999502.31r3eYUQgx@jernej-laptop>
In-Reply-To: <20250403-dt-cpu-schema-v1-1-076be7171a85@kernel.org>
References:
 <20250403-dt-cpu-schema-v1-0-076be7171a85@kernel.org>
 <20250403-dt-cpu-schema-v1-1-076be7171a85@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne petek, 4. april 2025 ob 04:59:22 Srednjeevropski poletni =C4=8Das je Ro=
b Herring (Arm) napisal(a):
> 'clock-latency-ns' is not a valid property for CPU nodes. It belongs in
> OPP table (which has it). Drop them from the CPU nodes.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej




