Return-Path: <linux-pm+bounces-22484-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D933A3C99B
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 21:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A7C63A82AE
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 20:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D93522F167;
	Wed, 19 Feb 2025 20:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8z6RHFf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EA91BE251;
	Wed, 19 Feb 2025 20:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739996639; cv=none; b=k3ZTvyBtfIKSlHi8ni5Rr2wKVVNxHEDAhmWGRNF5mAY988R0abb3togTii6Mgsp61Bay4pzRavjPAY4LmX/9pYD63DVuaW+/lo8EDOr/33Apr7Y4C55ieoZdiSfixZg3krTdxSWJXTou4fYIT4ZX/QhhPW+1wsc+5hX9k4kBYdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739996639; c=relaxed/simple;
	bh=EMy2QRY00y3vndpH243tF2GxFmlF6KLV7i/tcsJueKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XtvlIrtPDUTHOHIplbR98xImYxkiKUgPG+Uiwmga1XX65upiIh4Gi+GvDA3d6zx4X0vcjvKFgsxppcVJIpOUGC/JVzye+Cr7Z+g7qfQl0DvKBEeaTzNl3qf318YZ/F3ILxPf7lLB+vtvzZ/1z0Mmb3OC8nbRyQ2rMA6bhNjsGV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8z6RHFf; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-439a1e8ba83so1404105e9.3;
        Wed, 19 Feb 2025 12:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739996636; x=1740601436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMy2QRY00y3vndpH243tF2GxFmlF6KLV7i/tcsJueKo=;
        b=V8z6RHFfJArQTSWFp13Z14v6cm98khsE4D6n2V4s4Ryl191rqkQ7u1NHyxcUJqgq8B
         G2Ct52hBrED519KiVq6RFOI4y2fzmLe7quNbyKPJzJWqpC6XcJ/puWVqMwqwtBeYKgSx
         mQ1u6jiAqo2rfaJH3JzSI4mg3tDSwg51zzYXu/fKDKNyUx3soC/RNX9dbhoINwWyYbUS
         RiOVsTDc5xvnx6BqYwSmcn+9M4PEe+DyLjz6ggH2Gms8Kk0s+fuae4LmORxtuQiX4W6r
         uRgxAh3pMZ40/90G45rE73k0oBkbrljXYw1Ja8zjDXLmzM3qm5CUAZU6ERvYBLACz67B
         5R7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739996636; x=1740601436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EMy2QRY00y3vndpH243tF2GxFmlF6KLV7i/tcsJueKo=;
        b=UjUFbGAMbnOQfalIndh6mjBsFChxqpwl5ETkQYKWCZLcrkyEuUTTlMFJ/ARzmLvXO9
         wxBM8c+kqidiQ0vLu3n9f/ZmYkzqQZb16wgwa8dVuI9aMkuLPKjGg2PZJ9OsupAkUFZs
         Ssam9ulou26eQ2ESae15HeboBJR93vZwyyCWSJKiHW5J4f1lIGWrp85oMxXb9F/A+Dpb
         xN4JNQ5GLIi9M6ObAYXlH3421s7wLb8Y2kQReUmdZp9YR68XwCBTPMNwMIHZvh/5iVGU
         cjCEyoqYiISaQ3ATWkd8S6plTd68NFMQj+fZuVu35zOKtjmKT0guEMCrifGie8inqmJT
         bNDw==
X-Forwarded-Encrypted: i=1; AJvYcCU85cEyAO+9TxEKE5IeIOSCiFJHZUHOXyfznJ1zlm6WHOx0wPdq30doeEC1VvxDs8iQ9bTSzQv6sbrCOc5P@vger.kernel.org, AJvYcCUZe85Ey9+nGJafDyr21r1iuqQel3vV6oia+cnBpb4T+FlJP1iDEpM9USjRHJU4WmJ4/0Id0qSibTQs@vger.kernel.org, AJvYcCXBCSgy2nikIqC07BZl5oWir7kK3/eDPeffULX/kzAUgDgIeqC2AeAVBSQDtBcDzGoZLV1I/dcy4ZA=@vger.kernel.org, AJvYcCXCzOfGDUyvqDlPeh7Ckplt5K7JWshgulA28zEKmn2+NaZIIqb/8GdFkXdBiMRd5D2qkoX5bTy01ojz@vger.kernel.org, AJvYcCXnKqQJUfz8ZlggFtwwkVmmi1bm2iGTopt95MwOGa5ztC3LFL3flpyQvsW3yq7J+oYJQmgf35h6tyjlzw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzPCjNnm9r7JRLNgsAE9UhLj9sLH7M+yF5BmUxtXc8ZCdKgNi0
	4o6oZO/KQfFng0lcte93mPJ1DNis/d2BgTitPlVofK04USLSJkVO
X-Gm-Gg: ASbGnctvXSS84jzMXDgkRob3vnORTc/vTSoPJc+h6BAwrSqAknymNIIRejuRfsSAyIO
	GRvdlvIPyjq6WAjk/tNwW4rBDXbxzvF4j9i22CmC/Wy5ZXhiupWLxfpEnd0TRPpStkOmrzHwa7x
	KUtQjbtOpvRS6MYHHzI5n+0GgO84+D73L73ymqEURyjzxmTL/+1JoWs5nEicami8nlBqFR7pMgL
	dxyFJb8/JAHE9SPwCYl2wpHdUS4dkPa0Tm2PHtPUO/twpKmztvMDrS+QFDes7J0LzFdIGh/FmiA
	gcmrsaz82ChBgJM4B49cQ0exa0Wq8K3h/ZwyZBJJJwI5fsclD3lnNmD2H35OdxvoRDM=
X-Google-Smtp-Source: AGHT+IG4f59+CX698iufYSZmg97ar++Vk4BBVCCuVRmsKRvyGyXLNfOF7rWePEa5eNVo3mM8fixzrA==
X-Received: by 2002:a05:600c:3c9d:b0:439:5a37:815c with SMTP id 5b1f17b1804b1-4396e74257cmr166567915e9.20.1739996636120;
        Wed, 19 Feb 2025 12:23:56 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1b84bcsm230088425e9.40.2025.02.19.12.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 12:23:55 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Maxime Ripard <mripard@kernel.org>,
 Andras Szemzo <szemzo.andras@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-gpio@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 06/10] pmdomain: sunxi: add V853 ppu support
Date: Wed, 19 Feb 2025 21:23:53 +0100
Message-ID: <17060368.geO5KgaWL5@jernej-laptop>
In-Reply-To: <20250205125225.1152849-7-szemzo.andras@gmail.com>
References:
 <20250205125225.1152849-1-szemzo.andras@gmail.com>
 <20250205125225.1152849-7-szemzo.andras@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne sreda, 5. februar 2025 ob 13:52:21 Srednjeevropski standardni =C4=8Das =
je Andras Szemzo napisal(a):
> V853 has a similar ppu like Allwinner D1, add compatible and the availabl=
e pd names.
>=20
> Signed-off-by: Andras Szemzo <szemzo.andras@gmail.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



