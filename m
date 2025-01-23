Return-Path: <linux-pm+bounces-20831-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27238A1A03D
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 09:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAB1E3A720F
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 08:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1B220C47E;
	Thu, 23 Jan 2025 08:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6McpOru"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C08520C00D;
	Thu, 23 Jan 2025 08:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737622712; cv=none; b=hZsbB5wVREDrik8N71Vrdl3tbmbD7DijTocK6EahFRHPLGBpzT4xwaQ63pHU7NACrdoCoGyQhXBaIRcFNewKEcz5OOj729yqYMs506JWrKWvudzOwGw+EM/baXpUWgNvQpg+w9DB37aCXl8uIM5MVMo8x81xK1jlGO1/pi8Bppk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737622712; c=relaxed/simple;
	bh=HkyeRQ66zp1oc6NXegGG+5zPV8GgPQJyFzgH5zMyigE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=q7D9bM2jwpCv1Zw7HLbrJp1IptI1z8hQj/wceh5Kn894BrG2bRws/r3eTWWlB7NHgaX2SJLDswA/DLLd4zKy/Yt+tNK0+jW0QQGaG3Cyt32GXqFuRiR3fSxYdYilVnmtO7t35i/F+/I/SUqPK1Vnoevpo5vpvve1I2FEZBFSy8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6McpOru; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38be3bfb045so1221273f8f.0;
        Thu, 23 Jan 2025 00:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737622709; x=1738227509; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkyeRQ66zp1oc6NXegGG+5zPV8GgPQJyFzgH5zMyigE=;
        b=M6McpOruscsWDOzcdeDw/uEBtammRmlfH3opcjr5YJwVGs0cTG0ojYJK2iD86Xve69
         +Q9GKu+C7vxmvi8CXP6o/UJZNvidPvxuVag1kBRd4vQ7cOZ+bPrncMHZpKkiwZfY52z6
         WeR90hPbivu1sVlUkQUq+P+bbxj7ILKTIyarcNrpZ+p2AStUqxZdV+1tfXHjm3EX9qoZ
         9T8EtX/y5St/7sA9rUBiQbdvtt9SnpTNpbNVO6P9q2oJhlj+jE+JEYB6F11iXkoVKMmO
         ieTs18wlT2fDvdVe/oWekYewiyXMzI9K5V0lcrP1/hAnGsjKGYB8/TVuT9erF4qdT4N8
         1qpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737622709; x=1738227509;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HkyeRQ66zp1oc6NXegGG+5zPV8GgPQJyFzgH5zMyigE=;
        b=bL7PHrwghmopBrjPJJPKE/48y6ecgrott4zh0flVYzuLuxpce8DbXXGOp/ogfylzWH
         WifdFTw3Q7z/dcpTzXQV/bRjtjgZ6QDiiG4lFvBKC+WSFZd5RFCK/bzcUH/HrB5i97X5
         6uvpe5+Vxooz7s872nRLICNd8z6wN2N9n1SeEntqXE6sFLX5dFBdHowLtdZcBHPws29D
         NBtkjh6+Ctf58nhWO8JGmyP3JOqKeUEN+I3Q7JXr2BZKorFJtNn9Jw6SRXgreoq7cOHY
         UBHzh5n1a0fUyjZfGX6FGO77vLh0gzsmcenwOActP0XxLaEdbxoTfB4GPLb7F/aoYyC+
         tazA==
X-Forwarded-Encrypted: i=1; AJvYcCUG9HGVrzQBKBU0g31UqMQuDa5QIgSwlxrgQdLkfOWWuBxH8zEW5FBgBVndjQkgk9CC599i41dCg3y2@vger.kernel.org, AJvYcCV5qdw6yK6syI5FVjQZDsFP1SgIiNFZet0w90iM1emuAXlAaDymhuK1BPDW9ajApM+Av4Oe12/fHkU=@vger.kernel.org, AJvYcCV7CF0CIggqXvBVr1Md5lYICke1z/c8m8Rfc9xFg8SqF2og9Tly8dVQr8p2Ag5ZDcWohDuVPFW6tgdDsluC@vger.kernel.org, AJvYcCWT6VellgufhCioEGlwIWznbB1xdkkiSPGL6qDXTPb+xWmW5TsZic0ofk8pJp++WhV5U+KaHLSio/SleQ==@vger.kernel.org, AJvYcCWtv4uhBjeAolPeYmg572b2gZhCz4r9Z98IXKQV1yX8iXHggpQty7FiOqELu+tg+J3JLs4N0NS82RnE@vger.kernel.org
X-Gm-Message-State: AOJu0YzHgUJGPUtRUuBWkJzw1qlHl5A8KEWg5NxrDSyYhTK4eNrjdQs4
	V6cJTw1C2jhOZsvT/7xlGOPO/tv9W4A3ThSyLk04t6mJw1SZHHvP
X-Gm-Gg: ASbGncvcBV8dJFoY7Q4AfWVAL7ofMSpmuK01ECNJ9OC+RGJfP9XLt2n8D+OAdJKJTB+
	k92moCJztV8ejPSq+lpLBNw7nADNvwz2jp7tNtjYFmWMCJ7FOsTmyKNFW0gkclKji3otVj1emaf
	o9o0qg+bfJlI3APQnUNpELBVSntWkVxZ4pKkUy+AzJPgjWg6sJh1D611rSf1TzBlyBc/8wmgeXL
	ZMIi4Hj/nkenWPtZGvY8ZNBPgiZjLhj/gAPE9V8hLoDyWCkgS9kzXOOCGyU1G3j+UkSW1dhkxXg
	hrqR1P3hPp2jByLhBACsGvCQxTKXmjM1DVkm5MUn6eQ=
X-Google-Smtp-Source: AGHT+IHc1t5fGPvcthsivd2P9fI8/r4mtQiSRE3tXH+2jfQUvFcq70i0y1FajJPpW7lEuohcXqidQg==
X-Received: by 2002:adf:f8c5:0:b0:388:c61d:4415 with SMTP id ffacd0b85a97d-38c22275647mr1806903f8f.18.1737622709399;
        Thu, 23 Jan 2025 00:58:29 -0800 (PST)
Received: from smtpclient.apple (185.174.17.62.zt.hu. [185.174.17.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf322236csm18793946f8f.39.2025.01.23.00.58.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jan 2025 00:58:29 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH 05/12] clk: sunxi-ng: add CCU drivers for V853
From: =?utf-8?B?QW5kcsOhcyBTemVtesWR?= <szemzo.andras@gmail.com>
In-Reply-To: <36af1162-cd43-4045-bb43-b8bbf44f9788@quicinc.com>
Date: Thu, 23 Jan 2025 09:58:17 +0100
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Maxime Ripard <mripard@kernel.org>,
 Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org,
 linux-gpio@vger.kernel.org,
 linux-pm@vger.kernel.org,
 linux-riscv@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <266DB665-67E8-40FA-8BE6-E7F82955BAEB@gmail.com>
References: <20250110123923.270626-1-szemzo.andras@gmail.com>
 <20250110123923.270626-6-szemzo.andras@gmail.com>
 <36af1162-cd43-4045-bb43-b8bbf44f9788@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: Apple Mail (2.3776.700.51)


> On 23 Jan 2025, at 00:23, Jeff Johnson <quic_jjohnson@quicinc.com> =
wrote:
>=20
> On 1/10/25 04:39, Andras Szemzo wrote:> =
+module_platform_driver(sun8i_v853_r_ccu_driver);
>> +
>> +MODULE_IMPORT_NS("SUNXI_CCU");
>> +MODULE_LICENSE("GPL");
>=20
> Since commit 1fffe7a34c89 ("script: modpost: emit a warning when the
> description is missing"), a module without a MODULE_DESCRIPTION() will
> result in a warning with make W=3D1. Please add a MODULE_DESCRIPTION()
> to avoid this warning in all of your new modules.
>=20

Thanks for pointing it out, I=E2=80=99ll add it.=

