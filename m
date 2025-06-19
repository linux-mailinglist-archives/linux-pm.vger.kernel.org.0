Return-Path: <linux-pm+bounces-29090-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E936AE0979
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 16:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6611F1887FD9
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 14:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BFF28FAAD;
	Thu, 19 Jun 2025 14:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XjycNjfh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB8028DF25
	for <linux-pm@vger.kernel.org>; Thu, 19 Jun 2025 14:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750344935; cv=none; b=Jk1h+aSOMj/gLKnCfpksCsKVSgCk9DreX8v3+jzDu0huYYSduZ3Xzl8ZsL2/lapowv62NprtfYw+OIpD5oohyB2tmhW3UlWsGzNRRB85gDrxypMHcedE29ohbB/d6wpYHa81QZUGK/dQxq55dYVzz7mnB3/LAcA4gqzBGrBYqPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750344935; c=relaxed/simple;
	bh=iDLIU8cKqvcbXUMIYZ0LyAHF4U27oo4VJDAhYAedWfo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E9IjrCn8QxKy1pK34hKmsT8EadpLh+zs7KXIVRBIiqtxL4J2m5GiVLC/OTD6Ul3sP7BLerrTMwdufzGaNDStssca7nBfSp6U/l38kpAjUlpH+3Cq/29C6w3NCP3eFnuSkPKsE/UVg7zs8nmsjapIp7mLm12CpTWN/WZU0W/SN7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XjycNjfh; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-451ebd3d149so5711795e9.2
        for <linux-pm@vger.kernel.org>; Thu, 19 Jun 2025 07:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750344931; x=1750949731; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e9GucHfZPCayxh1y8Bqgadbm6OXspkCQUE4SSbOEVnA=;
        b=XjycNjfhOvt2kNBpm+RHazbZfv9Q0LvHUmDtRIhyaXZo8JODRgLZYD4WjBzsVuktxH
         TS/+a0im5wzY7CpSzvFxl9jkg2kSJ48xrgWVRAFIyFSfqA8dBthJvQcb4tk6ofaaz4EO
         fdyrPALL2DbpZwmDiFHYUHlCas3WS9AA7ydMwWSLxspaTge4ikOdZYDnWzl3traVaidE
         1ZbXx6y5AnS/nqES6y+seHadVm09zhhjBeld1mGIGD83vXQAisFrDlXhmEwegFjZn9lr
         89b0dng7Ll88OzkYn5YnZ01TX0OMc/HeQ+MGuKUSS123cmLrcu95S98qbF48UDcrRP8w
         m8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750344931; x=1750949731;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e9GucHfZPCayxh1y8Bqgadbm6OXspkCQUE4SSbOEVnA=;
        b=m1wnUgWVUu2Ep3MiWTbIlS469b2YYeNzPXeOxTnTY7CZ7csjRxMmEftAQBiCxbe2Oq
         N6ImXsIAXKHLy7pEt/Y/rvYab43W0tcA3O3Yd+uxXIHgS+kdAT8TyMnK0CvIllnI2dxx
         PdTb2E9TvRFpHrV1a1+98xttBfhJ0cT7+4SDhWkhDBKX/J2p3++gn/ZgC0Q63QfJ2PPF
         LqKTxuPDX/EO9h9RZYO4Yavc1gxxJ7uyRlNj4C04bSgahNhLDR6kcLzFRJ2DrzRqOwjK
         0J2SXhTfMDQi9CsJfJRJeUTYrzH1WBJ3SoIqAE+mmH13US1okIL17C+Mkzwpj4UYKvLc
         24gw==
X-Forwarded-Encrypted: i=1; AJvYcCWfvFktzMuezOCJU1PH4YdFW24+1B9wsK30Oy58qhJkIQXitgKIY4DjPlXuCoHRZKbdkt8wWTKXxg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzje2VOUfxjQ5ilMTYhpUYmcmf2GtG229IEmasrWwG0JRkESAyI
	uQ8vhC06TLTvy6bIjnCc7fRTywrZLFQoaOhvOEbOmD/P2SCwRw6cehbW4u4HW/x0ZYI=
X-Gm-Gg: ASbGncslb/vtf+27TAu8dmI0GXcDLVo0qTDhGrEyeg7N4+UH4Yo8PTMJN68k28DmyFM
	iM9alvLqCtO5hNSq+8nDPX7EziMSMXLjqpALH28xFcKk0yUxIVC3Z0prwywni0FWXrY36OpY9xx
	hZ/bqSpW/e7ZtKVuCQEujgD8ce/k3APLc93fjFc8kD8wN19FRkl1cQpPZaKaAXtFUCOr4Wz9axO
	hyLRZ3RT9tMrt98q/20N7UGs8WvZalLrR/v4y1povK4F2ZGFKvF7ZauGqlbFaZ/hcMWI87MVMVB
	3nytUbAXn9rPlW9sJDD4Bg+wx9Hwf/Q6/0VppnjoUn2pjlWrmMgVpUOwBGsMmz5xBa26dtIxLzk
	8kiXep9CHAJpgscdKdGMTLw==
X-Google-Smtp-Source: AGHT+IGGobIpKkCLpRzDl1QxoCvpwI+jTHKHBg4d9lnILMNs8XoDrDP97vfxlViyNKxyIg5xdhuMjw==
X-Received: by 2002:a05:600c:5025:b0:43e:afca:808f with SMTP id 5b1f17b1804b1-4533cb5ddabmr223699075e9.31.1750344930711;
        Thu, 19 Jun 2025 07:55:30 -0700 (PDT)
Received: from toyger.tail248178.ts.net ([2a0e:c5c1:0:100:b058:b8f5:b561:423c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535ebced8asm31343715e9.40.2025.06.19.07.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 07:55:30 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 19 Jun 2025 16:55:18 +0200
Subject: [PATCH 10/11] MAINTAINERS: add myself as smbx charger driver
 maintainer
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250619-smb2-smb5-support-v1-10-ac5dec51b6e1@linaro.org>
References: <20250619-smb2-smb5-support-v1-0-ac5dec51b6e1@linaro.org>
In-Reply-To: <20250619-smb2-smb5-support-v1-0-ac5dec51b6e1@linaro.org>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-hardening@vger.kernel.org, Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=971;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=iDLIU8cKqvcbXUMIYZ0LyAHF4U27oo4VJDAhYAedWfo=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoVCTSU5Fs57qbeZWVqSoR+0UKygRpv6l1Ryj9+
 AffIy9CL9KJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaFQk0gAKCRAFgzErGV9k
 tu2VD/0bwY7vbtIlaRWJOFEsK2l1vGsoZuolMH38cKaAlU+IG2W1Fyq7WlUOc2DUn81OGrnksUG
 yr9FjFGovg0DW/ycFt2vSbP6LA7yLbYPanceKT5Plpoj04RZjUbpHkwBACBHVFFo9N9Hy6S+gpd
 g4Srrq5bUjcAKOiSoJO/XIDkoxNV3rdRsJHgBwcoAlMfjoLbGM/soOrqLKhoz/JQqGJUxLsxVL+
 5xU/dSpdXppIkgbzQ6Bjifldq+0v1l7ScdXUTo2Buew2c8zf5nVBkeniJnZ3F6zWXwnaMfBfNBb
 Bq0SYmvymuQeXCYEKqfIUzC+Y0XbTK04cjjeTDwswET04SL2LwBOsmOX0EBIYhum1QjaF6QiGVm
 QJYn35ZyzKMTDoZCO/V6huqhrp8h6t9UGwVfk+YJlJp1NQgH+4sAXTaFqRQzuaUAMsN+wv3GJqV
 kpwMVH4S21qj41ZgWQrHd+QM7Xk4I61d5mXkZt6afscFVFax4lCIRnjUWcn9NbVlACvCJ6fVsLT
 Iwgamw41FbjE6dCtXHRuYKEcssWNZ0trX+cZZhkQyFi9pdyXHMmXQwMKIXDW6IjCsS3ry8F3Qvr
 61LmxgvrbQC5+ViIxKJcQzemtaZisZlI0/HzjEaCGTpCYdTVBmDtMGhV6RSh18t5bE0Dc3D2Ttx
 c1Wm6jRS/gyDmfg==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47

Missed when this originally went upstream, add myself to the MAINTAINERS
file for this driver.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c2b570ed5f2f28341a3bcb7b699cbb250ffa2a88..a32e53d89c29cacf6e456258c4c7c0206cf8abf2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20565,8 +20565,15 @@ L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
 F:	drivers/mtd/nand/raw/qcom_nandc.c
 
+QUALCOMM SMB2 CHARGER DRIVER
+M:	Casey Connolly <casey.connolly@linaro.org>
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
+F:	drivers/power/supply/qcom_smbx_charger.c
+
 QUALCOMM QSEECOM DRIVER
 M:	Maximilian Luz <luzmaximilian@gmail.com>
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained

-- 
2.49.0


