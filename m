Return-Path: <linux-pm+bounces-21603-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C82A2DE3C
	for <lists+linux-pm@lfdr.de>; Sun,  9 Feb 2025 15:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2D9D165474
	for <lists+linux-pm@lfdr.de>; Sun,  9 Feb 2025 14:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA631DE890;
	Sun,  9 Feb 2025 14:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoCm13Te"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002741DFFC;
	Sun,  9 Feb 2025 14:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739110447; cv=none; b=W2BiFJmQdESz9lVT/G78qP5EVXXGmfkhw5bLsxTBVNokobTEOoYWlFHSw7YPjoIpQywUJjYMM6fNjRMjrRdjclPCdyr+Uhwq2Ols7ndvw70fEzQ2ZZjYi9ZydMNoG4P2loJAO2c5LOf+gH5D6G717ayNet1xJLbVEpUcl/ezvM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739110447; c=relaxed/simple;
	bh=W8h1d4HaRq6m7GsffjNbhf3j+7ai6GGSjTTsJItg8BE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=SDKxrWyz0J3fzj06PwWsp/dsUqjO9VNmEzDf9r4tR+tkQNWjuoGN+B6nMyx1VhtZUyeB7543GpEs5vl5RRS4s+VQp1QYh6qZB/oedk6k3NmH380gbuJfXZNEiTzr3tlISuH6E8a5HWbjhEP20dt0txNdtz3Ag+jYKu3kH6ZPlbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hoCm13Te; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-52031ffca74so274824e0c.2;
        Sun, 09 Feb 2025 06:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739110445; x=1739715245; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BdfVI1FEi1RbGH/Oqf8dMxEYDzPFDZcIc5xJZU0jAoA=;
        b=hoCm13Telx60XWaQw4rkWlemRU+GDjbGqO9Q1vUbw7b+q72b259iSHt8Yx3i6tfpH5
         3FBOMShTBmGKyie8FaecMI+Lm6/AjAi/F1Lr8nVnAT6RHtP09Ckp97JisXjvKAqU7kPt
         hx/vyt1cb4mrUmNZ0iS/OKBWiAmzOjPhKv7ZfVc/rz3XiKVtLk9T8k1f+wPrqtLFwy6g
         PX6OdrG/NbNBcd2Hk+CiTGnQpLf7pI36x3bH2D9BUH1z544XsYNqAHMV2YiLd6QKBw9+
         AgkhtJho93v4m0zLmh+T7mfSlgb/+2lo4cMOwBpia4w05zPETFEPfwSME2ybwCWNzfLf
         Z+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739110445; x=1739715245;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BdfVI1FEi1RbGH/Oqf8dMxEYDzPFDZcIc5xJZU0jAoA=;
        b=d75uexLzhTPTf4ktBuKrJaZHktK1ZjNviDeAoNUZBpLTaz+fRjvtKrof1P0gOjFCFQ
         zrJ6yTANzCMlr36Tv96HK4WXs1PyI7YAvIWals6dgC0+6xq6PU8fUCIJvhQl4B8lsej9
         7pDL578VY/ciYiNhIUDRE4/Pu2/FDhFSL7O4Ht+SqtR5/gYgcQg/rgVkgZJ1/e5YU8V+
         yYACCjr6Knj47OPgXI/VazKMTHVG7gswGvWCwClGtqTZcXogBEIBVFb3TtWL93Mwh8lZ
         cKWz7KaQAHygF06eu7rqojvfgR9Z6Puk2EJFFft6WYnnmBIhYT1idgrlPu7hyhjtJp2J
         +Lew==
X-Forwarded-Encrypted: i=1; AJvYcCVEBG63bxNVAgO3aFBlpyL24XGCeT3CqwNTrxa/0DB5ekquiG6v5USofpnUNttLZTl438fYAVboAUG6@vger.kernel.org, AJvYcCWyIr70QFA2zmBN9+lYvGze6Y1DQ9wVzlJwM+ahtFWou+QUsUXHre0HAYgkrV5t5GLHiRx7pamjJIsWIw==@vger.kernel.org, AJvYcCXlcUB+yVObLZs3U8AnIFkqn7bpnIo/85NrUTPsBaa+zeqRpLMw8Vpnme8dt2XvIHIAdKGRGWJFIVLZ3K76@vger.kernel.org, AJvYcCXssK2qMQJaz9YXonTqb2yt1GIcT0zEaImla1618YVWYYJ/IFjVg+F6wTCqynjPslS+TezMk18Jb7yzzcA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx72BNtUvZebF3Zc3h2ciLG+0+BRlCxMeqEly2zdEz0zfuKTV8v
	u50WphWfI98XOkal34SoW7FwOO5VPbKRGNQkBqIO+5fDEnqNVSSgn22qoQvL6/kIjOQsmr3Jhtp
	ZRFxYmHiigqgL3LANe3GrZWwB4aI=
X-Gm-Gg: ASbGnctFHaUxufD4IzM9YmPfVhiYZWHjuhlBUdq6kFdIog9snE5eX9rxl3x5kgamg0c
	Fs7C0Cvhvv/1UmoZN8vTRjfoV+FnrJgUMT5ieZsl3ekA55uRpDYcqODxsqSzCtF9/YTe/PAs=
X-Google-Smtp-Source: AGHT+IH2zIcVxLhHDAslRzUTYM81+/U5ecbSPhJWjhRhdFjr7g1KDts4ZfGzh9TH8+t1uN98YVHt8M/Til1GrvoqPWI=
X-Received: by 2002:a05:6122:318c:b0:518:a0ee:e8e7 with SMTP id
 71dfb90a1353d-51f2df12a51mr6646034e0c.0.1739110444802; Sun, 09 Feb 2025
 06:14:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Sun, 9 Feb 2025 17:13:53 +0300
X-Gm-Features: AWEUYZkm3YJI0_JXpjAjzvJez9bKOCTy0qpYG5n8ZphDokC_UXSeTtt6uKBJ5gg
Message-ID: <CABTCjFBx-QpCKFWs5MPCgLAjJWT6ygrvS_A0nJk2BBxmWAxF+Q@mail.gmail.com>
Subject: Patchset status - 'Add support for Maxim Integrated MAX77705 PMIC'
To: Sebastian Reichel <sre@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Pavel Machek <pavel@ucw.cz>, Hans de Goede <hdegoede@redhat.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, 
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, Purism Kernel Team <kernel@puri.sm>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

For the patchset I sent 2 weeks ago, [patchwork][1] shows status
'Handled Elsewhere, archived'. Is anything blocking it?

[1]: https://patchwork.kernel.org/project/linux-pm/list/?series=927848&archive=both&state=*

-- 

Best regards,
Dzmitry

