Return-Path: <linux-pm+bounces-30063-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB46AF7ADA
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 17:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CFAE17A0D6
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 15:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0072F002D;
	Thu,  3 Jul 2025 15:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMfvuQYx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860372D9492;
	Thu,  3 Jul 2025 15:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751555548; cv=none; b=kdayT70CG7Xx13CUuKZD+1BIN4BR9z9MUpdK1JJ+hxW6/HSb87Ynq3CDFZocXfxERIw2s1tOsyb3y3cRAlxb1JGYyJosuZaFPtIpNRRia2Te4ees2Lf5nznbzaCYqVKzsClfH85XCpYlrEwP+e6lYL37tkpM42yfdnjFcTp3F8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751555548; c=relaxed/simple;
	bh=2VtHhvZZXe9k5UmGankZAg4IjeCT2vcwRjcFNQsN6hQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jvhlXJ5rJgljVvBY0bvOMnBtq5EBdbMaBrbQmea2VZzdrlF4WjRBGF9/Nkiusc4+JgxULQYL1oE1a9bReTX0RpeF67Xme0WrEJFK2QxubjbRn0s6y6+8qG0MPgb9XMWh8GRFgu1367PBsYORTVZ9hwKf2F2nBjwAxhzXY6FcraM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMfvuQYx; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-32b553e33e6so108461fa.2;
        Thu, 03 Jul 2025 08:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751555545; x=1752160345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BUCZaITB+JbIKX4CqImv9IU6yGF5XIw9/F8cQCdwhok=;
        b=PMfvuQYxvexEbuC9M+ffD1jeDS1M1QKsmzILOQgxySVlqovmhVewrqrghm7IMAMXTO
         QKR5x1NezcNuMazGA9cShEws8dN8M5RW9piUK0SB2we7hp00MhcJ+7gIofKhzP7PKACL
         x+ROpiFzNMTTwhA4pZchRPaB5WxG9bhAC16N+nuL24D02PbQA6kfdbLr7ac4iIfJ8uSf
         HsGPnD4Ykj9Ctu8+wmPgRjpQt/UGPJmcaiWCmsNhZwTPrSGKgkyB8o3Em4UEfPdD+Svm
         9Tfm6X0TebofM33V/2SIvwqY1nr/Dj2vldnEb1MndThAhJbfGN7wzBThQzXvXB8rS67v
         sIgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751555545; x=1752160345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BUCZaITB+JbIKX4CqImv9IU6yGF5XIw9/F8cQCdwhok=;
        b=W76fDvVd2FIWxZoaSJFDCuvCV2sSsXxpbc2gIEgtO6mfv2LNWJy/kFNc7p3vBpsj+N
         3OL3P4AY9l+ugvdbhheIC+XbqrdSQOZxDEXdhTaqhH6F4Y75AiIqa461LVx7EwxbxWqB
         4lL5hypxh5VF35tCEwXMl5oI860DzSllyNcypO7ICAh9MTEQrKlRQDQI/cG5sHaSj80M
         lGj4V/wMGv89YdGg2mhb1AsBuIrZNwYbzVEhCSeR9S5q11iW540kWeRD/dlzo/hqNnzg
         zPBQXsMw1bq/jC2UcBfN1S9jNhlB04jk+VnbJ88xxiZjEeZUS2z+cccC0DaVS8wnYbl/
         /Ymg==
X-Forwarded-Encrypted: i=1; AJvYcCVQFRNoxsnC1h8Y+kNHKYnX+W+zgGY8mneMznzIPG5CjmS+bGNfDJPo8pAL7KITZc7vlVzBR1tHuHWL+mke@vger.kernel.org, AJvYcCW3ovZAljjPTjJ7213mFkigk9hXr7+i+1NhAmx26sjPVmxaaWJtFATxfMqOJcrkuPBdmv2t0+HnBio=@vger.kernel.org, AJvYcCW5o1+WneZjLURu4DdEtvmxx4Adbk7G9RWoPalE8OrDWzJ8LwWRO64pU67oUOKj+UbYXo7mLGGL4bvG@vger.kernel.org
X-Gm-Message-State: AOJu0Yym5wjiywVMlgA6AwoHwJCIy7bHN1YaxwIXqyk/751j7GZj8wFY
	d1vJsA166rTGPBTcULvuhin+Njc5qfQDykloEpY/FMALboBQZyU0jD8c
X-Gm-Gg: ASbGnct+9nIskMe/gcqMbiFEDsJmDTA35EBBjdkG6czzSqxoslvt6I42Zfq4HHAYEQt
	63rnHp/zMe2cIeLFlzBEKI6gVsDeCO+qe8qsGlamtJjpQYeVRvtlctIu++VZG8+XKcsE0eBVH+F
	hb7R1I+R56YqlDo8q+ipC7TbkvqSUboyum7Vif5Wti5/F4jruZcYm8/9rdiSwzt5fJqZQUWee3e
	U2MIN+yBcOka5hzQ3Jm3yHcsaqk91gmXrpL9NaJjmUH4Mf1MzPviXaRZY2TZfszBJva/XJTlg5H
	JkayA6m2Y2x/iCUcKwiQpauZbOVDq588Lv7Qwi+9nDF3cZ4GFj65T0WkgFTF5kAtlU1ie1fuVgK
	1XW8lDw==
X-Google-Smtp-Source: AGHT+IHZy8BDgg1jwQmCpKDukxqhrE2LVb6Ay/AY5cKY8tq1yT7pP0bu22FEBsebRudNWJpZ7jrRNA==
X-Received: by 2002:a05:6512:3e22:b0:554:f76a:baba with SMTP id 2adb3069b0e04-556282e0d4amr3008654e87.3.1751555544426;
        Thu, 03 Jul 2025 08:12:24 -0700 (PDT)
Received: from localhost.localdomain ([212.192.12.80])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-556384ae15esm725e87.178.2025.07.03.08.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 08:12:24 -0700 (PDT)
From: iuncuim <iuncuim@gmail.com>
To: Srinivas Kandagatla <srini@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maxime Ripard <mripard@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 1/8] dt-bindings: nvmem: SID: Add binding for A523 SID controller
Date: Thu,  3 Jul 2025 23:11:25 +0800
Message-ID: <20250703151132.2642378-2-iuncuim@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703151132.2642378-1-iuncuim@gmail.com>
References: <20250703151132.2642378-1-iuncuim@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikhail Kalashnikov <iuncuim@gmail.com>

The SID controller should be compatible with A64 and others SoC with 0x200
offset.

Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
---
 .../devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml b/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
index 4424c3c5e..f67470b8a 100644
--- a/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
+++ b/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
@@ -27,6 +27,7 @@ properties:
           - enum:
               - allwinner,sun50i-a100-sid
               - allwinner,sun50i-h616-sid
+              - allwinner,sun55i-a523-sid
           - const: allwinner,sun50i-a64-sid
       - const: allwinner,sun50i-h5-sid
       - const: allwinner,sun50i-h6-sid
-- 
2.49.0


