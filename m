Return-Path: <linux-pm+bounces-9739-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28595911CA3
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 09:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A6AE1C22814
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 07:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9090169AD5;
	Fri, 21 Jun 2024 07:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kU8B+QFo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E9012D74E
	for <linux-pm@vger.kernel.org>; Fri, 21 Jun 2024 07:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718954205; cv=none; b=U0a8PGnm2aMBYTlkFJ8FkZ0MdmkkbwJ7xrtsAaGw+muMpyeEWeU1cRdMnyVeo8e1mo0wKyj9B9AxUBvKhCTVLpuO7BbZ+/q9yeoM3q7in+5Ag5VPmbRYcNL+Rv98YEiCzx7HIayriSwD6faU54l5f4tQqIEf2KrCpB8K1bEBKRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718954205; c=relaxed/simple;
	bh=P+91xxFEluTaDI2TnVurqN4jrHncZCNMsZc7d2bCDqc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AwN/5drRX+lurxyZG/EZCPuox2av5+1CClCqlCSrduJsk0bCm/bonH2mh/N6UkWA1xFYBBfLSVCaj8XJo7bsMtSx/TlnEg+zoMJS4meu9tfmNUkupE/iozOHJ8EcV3ZvSmoLHXvaNU63iwSGixh0n4ZsrbYKag1VhivvC4h6nc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kU8B+QFo; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3632a6437d7so995386f8f.0
        for <linux-pm@vger.kernel.org>; Fri, 21 Jun 2024 00:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718954202; x=1719559002; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+DCVn1j55e5ajfxU4ywGKuZZgRbg1a8LJ+8x3Pif5bk=;
        b=kU8B+QFocQAork16HiNMebKHc5yj3nhqYfosu+pR8T4wI3jjDHtxecsTAde6Y4yyQH
         q7ezryMxRUboRj/V01liA67OkRrwpw4B/HQ+nrGsAiEW/UVJ5vWSpCJuM9EScL2hmdXQ
         eqcDOoZmZu/oh+ieUpB2slzBKeuYRigaSpUupzMqbgZc2sTGnhTXhk13EG2HvGDHsYZj
         GtB5+OaxKcBhWlujEMat80dcQV52raWZrF5va2glIWz32rUCRXWLAS36YRijmNKUaYZr
         04W3/CSMg4E4dCpH8JgSTKh/7cOWpjauzjqmbNe1KJw0yB5I1aJoNnezVWmDmAlBnDgw
         kWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718954202; x=1719559002;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+DCVn1j55e5ajfxU4ywGKuZZgRbg1a8LJ+8x3Pif5bk=;
        b=Fx5KmXFZBq3UYNXBBJ1dXS1jjBMiDiL2k78BV45Gcp4FZBhb03UMPk3tnsAOcmSNv8
         1TI/3EQZ/CAKARhWWSefOq+6VeOTyOVph80lHO+nsIwqTSyV8KW6I6evHtysJqnCSuhM
         IjcRKx3g7ELvUddKT1JhiCSluUgbZF9TChFNijB+0DAt0PRyK9wSNOs8i84N0QHivEiS
         812pXbAtQ+sQDqRyF+Js/+dwyQ+dSQESfEiE15z34XSDgsGL8OADeHEjnvzjuvs8FUsy
         jsUN2mRN3lEjMqOviAB82jlpK5O5T65Gp2JVHwTMqNHPUwxVBLSOhAanYEnaI20fJUdO
         7qkw==
X-Forwarded-Encrypted: i=1; AJvYcCWVDmu3WMsuzvLoBhD89p3a9y/jQ630ohqk/QVLUqcDrXEnHTUk7zQ4gx45nhRpIV3XyBl5m9fSF27Y1WvQphAF++tAHMDOOyA=
X-Gm-Message-State: AOJu0Yyv/A46RL5sgPd2SSVUZt7EY1Ohxsd+6lPDKqqj2f1jXHTCx5Yp
	+ka+2mYYMtac1dCAmxmkDOgyY//tWL6lBhwqcuO9SWZlIxu0pzogQV+UiFdwpHsO0+znChCXskB
	e
X-Google-Smtp-Source: AGHT+IF5sFoAP29akLxvGK45M1UjSB9l7BLcx459eKNtxkohSNzhLG3IvD7TMpltf7VwV6NX+Ib5CA==
X-Received: by 2002:a5d:6e8b:0:b0:35f:204e:bcf0 with SMTP id ffacd0b85a97d-3609ea612f5mr11099793f8f.13.1718954202105;
        Fri, 21 Jun 2024 00:16:42 -0700 (PDT)
Received: from [127.0.1.1] ([82.79.124.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c7befsm879041f8f.95.2024.06.21.00.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 00:16:41 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Fri, 21 Jun 2024 10:16:35 +0300
Subject: [PATCH] power: supply: qcom_battmgr: Enable battery support on
 x1e80100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240621-x1e80100-power-supply-qcom-battmgr-v1-1-40cb89a0c144@linaro.org>
X-B4-Tracking: v=1; b=H4sIANIodWYC/x3NwQ6CMAyA4VchPdukq0OJr2I4wKzYRNjsUDGEd
 2fx+F3+f4UsppLhUq1g8tGscSpwhwrCo5sGQb0VAxN7qplxcdKQI8IUv2KY3yk9f/gKccS+m+d
 xMGyO3nN/DkFOBCWUTO66/CfXdtt2W6frL3QAAAA=
To: Sebastian Reichel <sre@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1188; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=P+91xxFEluTaDI2TnVurqN4jrHncZCNMsZc7d2bCDqc=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBmdSjUCQj16z/0jBkUuL9UkkjhId1kStmFNWoQR
 VcONv+3jwKJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZnUo1AAKCRAbX0TJAJUV
 VshuEAC5YdNtaarfm70PNzm0+GVT0Or57gIpbGajLxKLbfBFNhFUGO6qDSNcM9BpHUtD4BDm2sF
 Jy8643ACzREF10YNGJuBiC05IJIxZZXDexQHdIRdhYMexDsy3Ae3uaV1atSSdmd3qPB8cD7eR5Z
 DcuEhVV2piO2/jKIDl24qoEQvc/3la26STJRV8nJfwSIHmpIQYKYuBJiNGsaH09GbxSRd3j+y6F
 iFCQSwYYLVSV4Jlfbt9zDKE39SOp0ZLb16Wa/izO6VRSnOHj50G1NILPCj2p4foctSHVfbgYqb1
 uSo7glDao46R23jeEDmDUYrCnnDXUCppaOn2mzq84FC6lAlDZA/m5CxYtK3pczxiVED8ezAn1/I
 onUcVF2Xoob1HJ/PNk4j7xdNjOryjIhLw/305hUjfm+Aw8VTkQhkKIixAVXOvgyTKspPl4XtW5T
 h52uoKf0flgSnlh2CTNGk7bS6QvQVhnjdx5o/Z5Y4XTq7B3tLlBcm5mXJnlRVleBRQqxmEWMSbx
 fk0V46O4A2dkOV5XqsYN4OHWLnBQTemnFY7M4GBr2ZSBozkTI6orgEkcWbzeQbwF9rIzexi5N5Z
 tgPS4hHojJwsmNewQc/5lumGH81KG5naR9UShKvF2JNVGeiHKTHM918cvlw99PRzdmtJhMO5sCa
 6crefepvl0LlhLA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The x1e80100, being a compute platform, provides functionality for the
exact same power supplies as sc8280xp. Add the compatible and assign
the sc8280xp match data.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/power/supply/qcom_battmgr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index ec163d1bcd18..46f36dcb185c 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -1308,6 +1308,7 @@ static void qcom_battmgr_pdr_notify(void *priv, int state)
 static const struct of_device_id qcom_battmgr_of_variants[] = {
 	{ .compatible = "qcom,sc8180x-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
 	{ .compatible = "qcom,sc8280xp-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
+	{ .compatible = "qcom,x1e80100-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
 	/* Unmatched devices falls back to QCOM_BATTMGR_SM8350 */
 	{}
 };

---
base-commit: 2102cb0d050d34d50b9642a3a50861787527e922
change-id: 20240522-x1e80100-power-supply-qcom-battmgr-83442b7cce60

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


