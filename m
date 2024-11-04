Return-Path: <linux-pm+bounces-16952-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D007D9BB556
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 14:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 935C9282EB7
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 13:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC3B1B85D2;
	Mon,  4 Nov 2024 13:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWLnauoj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113C31B6CFB;
	Mon,  4 Nov 2024 13:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730725472; cv=none; b=IQ3j+tT6C+Qo6AUsw2eKrxDSpIFPXvNwFeeXSokljh2jG/nPZJDRTW4x/XiAbXE1JJnNt9nk+GYRK6Uy0nRAueppPnvJwC3TDH99lzStrlWjhWWvdoFekx0HdL+1V2pqeK/0kcv3q/mPi32YUZwekQ0WOsX+Mi8JX1n9QnkufYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730725472; c=relaxed/simple;
	bh=EnvJIgbrMjwMBPDF+0kk8UDfBVexM71BFeuD0mBFBzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNiZ+LtaFIT3WDk03udw/51knCAn0KID+qA+GkL8X6Rq0IB6VXf7YwPGK9hmm3RKjpnmHHzVKYVgw33bmhscfxLyNXn2+DIVTIBmS/fk4dF5+jtp8+Trff2TnMqrftN+6JHijuX60Ap2CPyAM0gP/FyKspRce2RFdGXsIstgo30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWLnauoj; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9a6b4ca29bso537243866b.3;
        Mon, 04 Nov 2024 05:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730725469; x=1731330269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=POZxJKBo9A+l/bBN4assLUemMcT00Dlq2lvLnr0+PpY=;
        b=gWLnauojvkBJa5ENBhbTLl41NErmyUwhpdqvlP+QGaJbUxX7FPRqQ82lDnMGtUV6nK
         Zltye3DunOELdV1ExwN6zmPLAiGvai4SnV2shsKh6w68Lp9cpzPb9hTt0s0v4pcjXlCs
         KW/e0h2a5o2B0nQRxdB4lvnavfisrMLwFcROVPJIBOILYdvYZmGfF7VKnXSy2Xqvx8OL
         Z5tF/MqO9LT5koU4pKx+EBoHns+UpYmTfnj+e+bL6i4BMa4YvYproUirzQweXXSqy2wc
         qDskhKuvdb78fm789zS0pF+ipI0zA2MXhuupbhWlWPF72QSqLZAlZG+2VK+O/qVfLB3r
         Tj5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730725469; x=1731330269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POZxJKBo9A+l/bBN4assLUemMcT00Dlq2lvLnr0+PpY=;
        b=IcZViZHOLoG+jIlCz6VWd5Z2MPmwFrH8VRlyPQv/F3/Q4NGEcZ06DLZzhsAmhFj9Tm
         3Jpj1zzduwjNyEe0A87jN+SCKqPlV6wMq+qh8UzsRPVW5QHhEQuJ1EDvvfTpRliwyKlK
         yueWbSS3Sa7MtrIOs8YLlvHKCv2xqFxpGd1daaGj/xCinjhbFogrVH5qTN08DFVBgQxV
         AoeSRQ4ziWIahQsaCUpRJ555KA5kzCHwPj4bKYS9FHZKz4oBMP3/xRZ/YQqMFUiNUlsj
         6/BXVhKA0CAadNhQQRdd9OU7ltJc6fwRqntUa5PUj2YULuzr8bEvskAMhOTCKaYCvRTH
         fCrg==
X-Forwarded-Encrypted: i=1; AJvYcCUSqzktFwIt+PLl7C/Ins1mndUEl+SeZMKt4I69XIrt2t5aq8RvZ23RecdK2Mp+mNw4URsGIbh2Y0SE16S5@vger.kernel.org, AJvYcCUiP346Uv7VGav6n1TLfimbe4aTc9hAzMnr8ibEngOn7oXhA2g0ySoCaUf1Xw7Zfwn+9WPpn3+3Af+H@vger.kernel.org
X-Gm-Message-State: AOJu0YyjUhrya1opovs15R0PiG/16Z3qKhrk1Va47V8Ye4jzChPUDtsZ
	01DrGXA5kBXX7Bo/xZLznJQGYJwstAXHmBCwidcJJ6wOGxDmfjBF
X-Google-Smtp-Source: AGHT+IH0wK3KKymt+GJn5Qaz1847qgcdfS+1VGhJ6bZwNBSYDLK4FH5wRl0QQimVTAB92pob+YcmhQ==
X-Received: by 2002:a17:907:3e06:b0:a9a:80bd:2920 with SMTP id a640c23a62f3a-a9e50b9e39dmr1445068266b.53.1730725469092;
        Mon, 04 Nov 2024 05:04:29 -0800 (PST)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e565e08b7sm550089266b.133.2024.11.04.05.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 05:04:28 -0800 (PST)
Date: Mon, 4 Nov 2024 14:04:27 +0100
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] power: supply: sc27xx: Fix battery detect GPIO probe
Message-ID: <ca28b2f2037929c0011fc5c779c332c1d1ad5308.1730720720.git.stano.jakubek@gmail.com>
References: <cover.1730720720.git.stano.jakubek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730720720.git.stano.jakubek@gmail.com>

The DT bindings specify the property as 'battery-detect-gpios', add
handling for it. Keep fallback to the deprecated 'bat-detect-gpio' property
to keep compatibility with older DTS.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
Changes in V2:
- new patch

 drivers/power/supply/sc27xx_fuel_gauge.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index 426d423b935b..f36edc2ba708 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -1183,10 +1183,14 @@ static int sc27xx_fgu_probe(struct platform_device *pdev)
 		return PTR_ERR(data->charge_chan);
 	}
 
-	data->gpiod = devm_gpiod_get(dev, "bat-detect", GPIOD_IN);
+	data->gpiod = devm_gpiod_get(dev, "battery-detect", GPIOD_IN);
 	if (IS_ERR(data->gpiod)) {
-		dev_err(dev, "failed to get battery detection GPIO\n");
-		return PTR_ERR(data->gpiod);
+		data->gpiod = devm_gpiod_get(dev, "bat-detect", GPIOD_IN);
+		if (IS_ERR(data->gpiod)) {
+			dev_err(dev, "failed to get battery detection GPIO\n");
+			return PTR_ERR(data->gpiod);
+		}
+		dev_warn(dev, "bat-detect is deprecated, please use battery-detect\n");
 	}
 
 	ret = gpiod_get_value_cansleep(data->gpiod);
-- 
2.43.0


