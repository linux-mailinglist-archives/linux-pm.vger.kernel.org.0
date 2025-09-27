Return-Path: <linux-pm+bounces-35502-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B606BA5E1D
	for <lists+linux-pm@lfdr.de>; Sat, 27 Sep 2025 13:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4872D189DD6D
	for <lists+linux-pm@lfdr.de>; Sat, 27 Sep 2025 11:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09462DECD2;
	Sat, 27 Sep 2025 11:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8DBl0JA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277BE2D7DF2
	for <linux-pm@vger.kernel.org>; Sat, 27 Sep 2025 11:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758970997; cv=none; b=qwL7hGVdRkKmRoN8p9MAhlVx8FWHFZ3DUjrX88zpy//hVrp6LHhECRHdN5YLQLzlUH26jTTeJDyL0ckRzzMXcdoKEIDca4jFHwnRO70eJ9ehpp60NDlH9AF+/JiLhg05+DKEP9mwWnncTuxUtvd/Nelo8kLSu9HdSX9cYN4n1d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758970997; c=relaxed/simple;
	bh=MEPk8mF0XWJhaPBW8X4rO7lqawwu25cscAs0P6vTG3s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=b2YWLxOLO9FrLf/UCLbRWqCPMFRhyJHlDcCnfg9ieVtr5GCE5i/rsuS6nmCb18qe1NJU+MRWQqUS55K5KMVJG9YFNbb0Ud8/AUkVApatPnX7KummnLh0jXvU58nN38LxXmfXpwgnYRcjPZERBSDMptIce/5Iqxq5n8o/LAuanrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B8DBl0JA; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e2e6a708fso18428945e9.0
        for <linux-pm@vger.kernel.org>; Sat, 27 Sep 2025 04:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758970994; x=1759575794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tkNWDYlAClljJacvPFHJT9/32vyeFE8E70qgHvwmkb8=;
        b=B8DBl0JAKft7KS0mBXk4ZY/ok6mJDWMh2p+a5mIpvq0gcIDr/nrOcKqyZZpb4sEwsn
         0JvCxISZgsr2Y6Com5U6VjlE8zGBC0ir58SwzAVi+kaOBqi0LcziH3q8uwCxP2kfY2jf
         oZ7zw1MKqyWSqsxH3xCjcxxgYRAiEEsYTDw9E1YXLmvMm3u+NRE7s3Xw4mrNsX3oBMD9
         YEVlT/0fJil/YiUuHHGONX2ymzrPDhHDbfn5rPwaPpLZxwx+TuBR2hFju6qEKe2uTsgY
         aCeRYI6sqWOcBkoVzVMeQh3k/9rZGfxTxFOETegROEUGv6k6i0PKaJEC58q2hRISmilt
         mzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758970994; x=1759575794;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tkNWDYlAClljJacvPFHJT9/32vyeFE8E70qgHvwmkb8=;
        b=FoCTDgqGNi/JS0Q7PO5bJ7hz3jAKR6CFGZ5jyR1xgQ392MEQRYsjRcSB+j05vTsiyQ
         SWuN8pTjSDFhiyevy6aypnIEh3lFoEbWZsE29x9rmRX7qUbkWqHS67RD2d5NIN24+1v3
         BH9Q5RJhbKpYILJ616tuhYoSoOyCm/Ptvw5mbDmluWb+prsmKNFsNLi51gMnAVQLiLwE
         Gk/HOAYYOHQUwr08DXisJ/owkxpT1nrRMh1n/c9QXmMRTzYsZb0XVBm0Qk9ILK1SIywx
         38abaPSj99Oszdg25IQ6Z6lcXrbW690R+yClZ+3RAqeOerNo8yDZ4SX9Vn4d7fpnJ/pf
         l5IA==
X-Forwarded-Encrypted: i=1; AJvYcCVLbr+qzRAR8QNrWQAFWeLO0i2RLYl1/yV7d9OozfjnJxVvHdAbdjOPsSsUnffp4GfKSGPXVYkRgg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWBFBvU4OZsMQMO3Nsq9FfIa2mMSgLzQlK3tYOLn545r5+XOtk
	S5E6Ip9v9DTXLtyTWUf9R1PKzvsMACe1Ft+FHEaRHQQ9mHvBnehoGjX1
X-Gm-Gg: ASbGncvFsSRLb4/NgVPRniBbbcQZk72VGlP/MPl4auigoHzIKQW0iMLXwsC6tG70S3r
	MbWgONzqIQjhJOwoqaC2wv+aDbMfTPoCBnvnK2V5oD8/HDjRQwtZdiONlUm7F7kAGgUE2/HoiB2
	HXU4b2WYU84KUDNjNqRoV7R3Kx3CtYxrHjLp/1M9C3ldc53O1RS60BOb9Mt2pm5vM+s1rCBqoV+
	DGq+hicU/LG9Yp7rWEPufxbCRiCkUdVk4riW+mfdck4+uDd1m4UlxXTEcbd4HzT7ujFT2X43e21
	3FEYxgkSQ+EMWfSUldv4ZDnnr4ez2gY8VDfWRTW0xpjC/rl+4T12bi8NP05VmjwnVzCQWbE6+hF
	WhJiR1c+coESDOwfKSlfJw6GZZDA7FjatBMtEH6+GtxAZZpu6q94qRPduz5a8rPWgpii2+QApVW
	4MywkOb6/tg7Zm3Q==
X-Google-Smtp-Source: AGHT+IF79XdU3MiveCiJWHuSLef1NIT2fZqNrN2anDonGJumcYidxmAS11xssMvpXUUEBE8RsYnPGQ==
X-Received: by 2002:a05:600c:3e86:b0:46e:4784:cdf5 with SMTP id 5b1f17b1804b1-46e4784d03cmr11911565e9.15.1758970994270;
        Sat, 27 Sep 2025 04:03:14 -0700 (PDT)
Received: from Radijator.localdomain (93-140-175-232.adsl.net.t-com.hr. [93.140.175.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33bf70b5sm106190035e9.21.2025.09.27.04.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 04:03:13 -0700 (PDT)
From: "=?utf-8?q?Duje_Mihanovi=C4=87?=" <dujemihanovic32@gmail.com>
X-Google-Original-From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <dujemihanovic32@gmail.com>
Cc: David Wronek <david@mainlining.org>, Karel Balej <balejk@matfyz.cz>, 
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org
In-Reply-To: <20250913-pxa1908-genpd-v4-0-55e4cf32f619@dujemihanovic.xyz>
References: <20250913-pxa1908-genpd-v4-0-55e4cf32f619@dujemihanovic.xyz>
Subject: Re: (subset) [PATCH v4 0/4] Marvell PXA1908 power domains
Message-Id: <175897099249.11004.17270115916151643401.b4-ty@dujemihanovic.xyz>
Date: Sat, 27 Sep 2025 13:03:12 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2


On Sat, 13 Sep 2025 23:12:47 +0200, Duje Mihanović wrote:
> This series implements support for the power domains found in Marvell's
> PXA1908 SoC. The domains control power for the graphics, video and image
> processors along with the DSI PHY.
> 
> 

Applied, thanks!

[4/4] arm64: dts: marvell: pxa1908: Add power domains
      commit: 1ee5305033c227610c072f32c4ac8ba0adbd42bd

Best regards,
-- 
Duje Mihanović <duje@dujemihanovic.xyz>


