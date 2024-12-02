Return-Path: <linux-pm+bounces-18324-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA88F9DFD95
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 10:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F8E31625B3
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 09:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971E81FBEA7;
	Mon,  2 Dec 2024 09:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALRiZqeh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAF91FBCB1;
	Mon,  2 Dec 2024 09:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733132890; cv=none; b=GPl8j5gYu6MJoVJ+loW1hNNAyAc4gY7ViQnpy28F+GLzKa1fNYivncGirYVsHg3ybPFobN6dgVVJsRwxiYQtKvS46JxoTwReAQeBxk1PZLL3O0+AwcVhePgKPiF1dOVv9kW1IUfPTmeJfV4yiuziuIR6ErOpccVJ/rao4W8YI68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733132890; c=relaxed/simple;
	bh=iVyaZKxO2BmEs20P5C0zG17CFpaLKpfBWni/drskwwY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nDSwFomJ+BsPie1s0N84a6WXT+PQJSw/WVJ+TU2t8HrgsDDxe/hhlqh3HGmwXsUdgjBfDaNvtiP18ikOi+BChQjWDkwHaU7KUXDVh4jko3Po1RhRGTn9B2MdNA+iEBr5Tk/7ZWM9EcifsxoAg4+ZlKTX3Dz19Lu7y+yRYiR4fw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALRiZqeh; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa53a971480so623256766b.1;
        Mon, 02 Dec 2024 01:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733132887; x=1733737687; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6OlJi6DuwyfQMjGwJMUgh5OIHj779pVW3nNLD3+J98I=;
        b=ALRiZqeh7pPu//Q9zs8eSYUe7FHsPq45IQH5K9sGK9j22KJp5D8Vf+p6r5vokO11x4
         dfyyFTw2Ssb+xvt8/sB2dXb1LX9CNKw7LRkLG5DxqTxY1bNj1EDr6U1r9ph3Hgj3x2vC
         BOhxQi8qeUipj7NLj3PWM88IU8YJLZhfCz5ZFrKrN4siBTR1Q0DFdzfnrc7ucPl5CX7t
         HbTRTxWjLeFFonfqGvnXtIcWijXxlqkAupgenG9QBP5jRjHGg3fqrAIdbQQOwWFJrSDL
         Hgl+D9dsZ8Uq1DBxgmCAojsWkI0/IYBzdU+GzlSO3ulHK7yM4bTmiZlBKpccdLJyEIQe
         +6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733132887; x=1733737687;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6OlJi6DuwyfQMjGwJMUgh5OIHj779pVW3nNLD3+J98I=;
        b=AZ4dGBO5xoMkWZ9eXRpUFQDWablO3Rz/6YLSi9qy8oBbp+FQP4ODJdTZcabnN9Exx1
         NdxLauI5ue1vMSgnLcmtH5PmoGvpqg5qg8L0WfdniAnL6DaMlXOFVFUjz6dZjJ8IRXTI
         Q2yLW/crTl4fO/em7HizzUKyMkP372RXMe3cIoYkHhJBYWuFmDOaQVqeURDaQxmevrDl
         Dixt69iL6+d6ScFMFhUN+GMT9P5VRlNOSdJ8obyldsqXN8aZsfDSV7KxaxUak8fsp9qE
         oJW9V/LA01Uw/JmBvZneFW78D75C14oXjL6JNARev+8dKU0ox/uDXjdwwtViUkTq0MEz
         iudA==
X-Forwarded-Encrypted: i=1; AJvYcCUFYKz7MkgNHAS6FbW+1D6C8yJ+eDbuDrVkoGQDw2ALiRTtToPKhcIdtnnCUS8Ga9RfovbKIHNI/oix@vger.kernel.org, AJvYcCVdt/XKFJ/wFpkZxVP5d46SEu8Xl+2c32r3gs7/s18QCnx5OGejrK1owPh5tAE6or+4AXpMIcrwtglJ+g==@vger.kernel.org, AJvYcCWErh8Rsywm1SReFx1EjhSonj23PQB3ul+/Z+Umc7X3Vx0t/kb0DLCCbfMHhwisHxLc+STcPMzi12wxV3OT@vger.kernel.org, AJvYcCWMzFNde35kkjklj1KjU1AFDSA55VhPrnM2p1pW0HuG27U7E1yPqfATeRdKWftIsUY4tZFi0/bk4ugePdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWfKrhSV6qZfMxGy/MArolt39+m875E1JbnNO0oDdr7ebKoRZ5
	9atGDc6qZ8EzaGLwannITHvsNJf2riO8rc9fSNgu+bsfFejz7K14/US05aHE
X-Gm-Gg: ASbGncsm8rZdqIxogmHgfrrnXbDnVwerqtj9We3NHv6SDr50TwwBcUh//jlLtYrilx5
	rZJLiEKs1eZw7qz4JB7I3nd+99Fqkf+3Qajc1uu9rsx17TrYsEp2gosJIe1JX/fnfXkAEqmLUa8
	cPGiGobHgxmRJhcRyFhpW06z+XxvpS/zBTppAY3FTHQb+/aPXN4SiB/d9JHkPrB9fOY3xtO/SXQ
	ZpINLZ8dq6M69fhCKDic87WBfbyXs4yCX923BYd6ST/GImd
X-Google-Smtp-Source: AGHT+IGXhYTHcGl82HQ7c4wZOtPNRaymliGjINI9HRMz3yM+uAQl3MX7QUwfKvdheAJ5NWl3hmHrRg==
X-Received: by 2002:a17:907:778b:b0:aa5:1224:ed78 with SMTP id a640c23a62f3a-aa580f2b453mr2247428766b.15.1733132887045;
        Mon, 02 Dec 2024 01:48:07 -0800 (PST)
Received: from [127.0.1.1] ([46.53.242.72])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aa599957594sm487059766b.197.2024.12.02.01.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 01:48:06 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Mon, 02 Dec 2024 12:47:55 +0300
Subject: [PATCH v9 2/9] dt-bindings: power: supply: max17042: add max77705
 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-starqltechn_integration_upstream-v9-2-a1adc3bae2b8@gmail.com>
References: <20241202-starqltechn_integration_upstream-v9-0-a1adc3bae2b8@gmail.com>
In-Reply-To: <20241202-starqltechn_integration_upstream-v9-0-a1adc3bae2b8@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733132883; l=739;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=iVyaZKxO2BmEs20P5C0zG17CFpaLKpfBWni/drskwwY=;
 b=5feR+eQcmcJ3J+DcnmfEkHj/AQfS3NecPH/Qp5h+/Kiguf0ROFoDQVsAuAlVLBQvGIBp3dfHx
 tDzsVk2dK1iB0MG+QEkN15Jf5A12oFdve60vGct9T1tKSip81TUy86A
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Add max77705 fuel gauge support.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
index 085e2504d0dc..f929e7e2b82a 100644
--- a/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
@@ -20,6 +20,7 @@ properties:
       - maxim,max17050
       - maxim,max17055
       - maxim,max77849-battery
+      - maxim,max77705-battery
 
   reg:
     maxItems: 1

-- 
2.39.5


