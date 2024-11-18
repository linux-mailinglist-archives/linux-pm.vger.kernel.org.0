Return-Path: <linux-pm+bounces-17698-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3264A9D0DD7
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 11:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2B022825C5
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 10:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49DF19412E;
	Mon, 18 Nov 2024 10:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPco839/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144A117E01B;
	Mon, 18 Nov 2024 10:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731924604; cv=none; b=mkvzTTm7kGM0c4qILeVr0xrOBZWXo3x3ZW0XOWeM4KoVsY7HTkcHoF35cIkgSfutOXW1tMVhpZK7OQXLOtgZ7wDUAu2p67afjwFsWRYxEPqij9QRyY8CIvPLvwaiCfRfbCiizs4dlH0d59eXjuvfElx3Qd2ZWriWfLGx3qscpzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731924604; c=relaxed/simple;
	bh=gES/YI8J+uY43qFcYFJFQDdZCjIIvFKdVHt8Cx7j4Ks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mz+RVnwbbB3XZ2TKBIhsxDoDl8pwyL3B28vWhl6ppdZE1WQzz2iVQsd7uzWogqujofBYVYpZ5dgzWPaho4nNE8Imnt+R2xVE0kjTGJ9dKs7BZTdhn676ghdbL8m6mEESKA1Dz5uiGkMBGIl8g9tn8mq+uXdFeKvNJYAQLlft84s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPco839/; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9ed7d8d4e0so295340866b.1;
        Mon, 18 Nov 2024 02:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731924601; x=1732529401; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n7VSA4VpES10XaA8gB1WdvZsXgmDNfsDCe5+S5WIIkA=;
        b=GPco839/KyBONRxrQ5zWKXot949TXU9qtzC+erfZEsq/KpmVQC08De+QDkibWc6V5O
         e0u4WYxXqzsCtGNRa38yq48OaEaOpPCSlUXjNo2kby3sVHDejkRvXBqPu8zkubGTAFEY
         Co2FS4k6VAjSGwaIo4c4AO4KBXvMAwuGtmoXvAnWAhzOXiNTE7zi821KJdb21Wuse6mA
         6mES9s0i+rqH4QyPpuPHlip3Mr2NPbnqZtJHFKxORkFbEcFBmjxwQZX1pcndhzuK0NEd
         Px9S7gEDWqTbzfLrWArZBM+y5BCUsekMyefTbvdMLA0sXdDMT5s1wrJIdsVY4tSiAekl
         MCqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731924601; x=1732529401;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7VSA4VpES10XaA8gB1WdvZsXgmDNfsDCe5+S5WIIkA=;
        b=AHXfLYIMJuJcnNXJR7gOk5oYytFLTDhYEFsG3C7sbJQE1xSkKJsrca0FaD0RcPQC2a
         xMJedAzMNmw/W7ewmgPNCnlWZmxeir/OsrhwT5mGVI4wEXuXsBUCRIEnuYkLdRYidcCi
         56bfdrLGlOpk7WsUPBkfsX8GpcCYymNZAgFiOiigtrHqKmMVrv4XwDl8c2s05uklKN9G
         LXLEBwW3+J3NCTjOqKUDOss4ckxOHkKbibXDh+CwL2e7ud/LewrOUQCHBEnSa+WkMLdJ
         36Ni6LJ+qPFxGS6Avnp566jCul2FuovLv+OwbjBmpiEHygI7PxjyVQN+8ca1AIdKC1O1
         BgXA==
X-Forwarded-Encrypted: i=1; AJvYcCXB/iJKs+R21lvJXzDCsJr7qg7lzxbKPOCNg1tnVX2t9QE8NfQzzJpfShdMLyuv9I7fsYeo0vwWTEKa6NcphA==@vger.kernel.org, AJvYcCXQbLcoBqa+6dwTZ+gAUbnvubo5n1IMDw72Qwy+1h3vH1czES/5EU27+7JR+bIGZbA+PNj49/RA4YFn@vger.kernel.org, AJvYcCXoAbziDOCfkcFHoswkVn6E+PePK88zjiYN2MZmwUMxLNma0SJcKfYwdzgRThUD/2iGoiZNq/06IJ4DApI2GpaYnYU=@vger.kernel.org, AJvYcCXtUIkhUhZxdWhOByVQ9/wRpjffV1WFvkQ4PUWPi0t3unjvetOlozfVUTm9hVJ58PL3JFTuKURhOT8J2GlE@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl95ztngrkC5KJtbxQSPvrEP2flXBK2CtfHH6Lr8eWPSr2nKW8
	rPDehfSaC/6XJhWQW6ERQFGqEmCD/ROV39/iNcQ0d0mfPRpheTs2r7Vk1g==
X-Google-Smtp-Source: AGHT+IFVn+W6t7IcvDHzZ8JEBQMCSTtIpGFYZyel7ibDDUcP897/DW1p4IYqqtYfdKiVpsTwnCY1Iw==
X-Received: by 2002:a17:906:daca:b0:a99:88ab:c7cb with SMTP id a640c23a62f3a-aa48347e0fbmr879397366b.33.1731924601276;
        Mon, 18 Nov 2024 02:10:01 -0800 (PST)
Received: from [127.0.1.1] ([46.53.242.72])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aa20e046932sm518546366b.170.2024.11.18.02.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 02:10:00 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Mon, 18 Nov 2024 13:09:53 +0300
Subject: [PATCH v3 1/2] power: supply: max17042: make interrupt shared
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241118-b4-max17042-v3-1-9bcaeda42a06@gmail.com>
References: <20241118-b4-max17042-v3-0-9bcaeda42a06@gmail.com>
In-Reply-To: <20241118-b4-max17042-v3-0-9bcaeda42a06@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, Sebastian Reichel <sre@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731924598; l=1055;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=gES/YI8J+uY43qFcYFJFQDdZCjIIvFKdVHt8Cx7j4Ks=;
 b=r/k4DDMvo/iWEzDXWTNKTdhAJ+2yN2gMZDbBBo0/+qpXaIxtBxrxlSbcICNM9WInILIvXpnR+
 +H8C6RzzOzvBbSTtw42c+JXXlJIvIZMBNAH/oZfjB9gXGMlrJC/ZiNZ
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Fuelgauge blocks often are incorporated in bigger chip,
which may use only 1 line for interrupts. Make interrupt
shared.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 drivers/power/supply/max17042_battery.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 496c3e1f2ee6..99bf6915aa23 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -1103,14 +1103,7 @@ static int max17042_probe(struct i2c_client *client)
 	}
 
 	if (client->irq) {
-		unsigned int flags = IRQF_ONESHOT;
-
-		/*
-		 * On ACPI systems the IRQ may be handled by ACPI-event code,
-		 * so we need to share (if the ACPI code is willing to share).
-		 */
-		if (acpi_id)
-			flags |= IRQF_SHARED | IRQF_PROBE_SHARED;
+		unsigned int flags = IRQF_ONESHOT | IRQF_SHARED | IRQF_PROBE_SHARED;
 
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
 						NULL,

-- 
2.39.2


