Return-Path: <linux-pm+bounces-29466-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BCCAE7C19
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 11:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BA517B2188
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 09:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3592A29B783;
	Wed, 25 Jun 2025 09:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="CandxWgS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4346729B79A
	for <linux-pm@vger.kernel.org>; Wed, 25 Jun 2025 09:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750842817; cv=none; b=h9XuTgjxyrcZOkCMsFWxrf8C2lDpVIo2Wn7N1xeC831j23JCS2ZqK+hqZ339lgSksc5tXCMxmSOQPwkyBXdwc+70rkKtQyDzCqLTZQKSwTTveYqlofh7ZUUjHAv+Lt1HKdDZWVk4W3RS66unFeCkTO9Bdxs5BTayij5HyTs0d+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750842817; c=relaxed/simple;
	bh=4sR5fPpma/GrOJli/eLiVTPPr/9TVkwqVfopkbkw2Yg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CW+v+Svt2lpGDXc5GkLHUXXiGEgWujFY+6i6pKO8u+aSibWuNbRGsWsumAeq2cZTCn3XDrxSUuQHJrz3onv5tNDTs5K+bbtsuHpdVZQ150gyW4uEREp9YzQjS48nOFVCEtXrtUoonjEPY/WfW/9U0zdC3cnzS72clFFVmUo2vRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=CandxWgS; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-604bff84741so2817673a12.2
        for <linux-pm@vger.kernel.org>; Wed, 25 Jun 2025 02:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750842814; x=1751447614; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ks2KgKPEFickNI0g8cLhP0+7PkHVzo+kxkQrWM9s9Jg=;
        b=CandxWgSEa4zslHSRGyTO6dsjXvFLFADwNBqczzvZvsMIgh29Buk46VcZDX8xeg0Ve
         SNE3FQcpEUor9G3ujm8oSMA/zk0ior8Gxc7scTMWmFh0J2TUp3rKu2vOzkVehQEwuOef
         9k/V43W9L/DbiPEMV4PRyKjJKXspK0OGtAiAWaXJ7PpZWga9vUVSi8mQN/hWAhyOMQuH
         QFBmHRXNiJ6LotIPeHhnp2BNHTbmX3WIAGYxsCTT3AAYIzrY+SPez1BcwDATg13wQN7o
         dnrlZvgpYqzOEyx3Oj3MbdHTkKDdC5+OcGOFSjDnN0bKO7sDqq6zuRJsRgn3nQ3S59xU
         Favw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750842814; x=1751447614;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ks2KgKPEFickNI0g8cLhP0+7PkHVzo+kxkQrWM9s9Jg=;
        b=IQMoues7gHaLdIlLZ3XD7/RX2nF5DKhutqmypI/J0fkTffb4lZPCAaEeRUCI6phtDD
         V02VKk+SoZJjCCwV27U/2W5qvQ8jteMFJsIqJ+zMpeiebaD5LNnBmGXsr+cyUvHkpDDb
         R0jJSW+WzYtDBgcl0zGCrdMjvguH0ZDXcyv2aiQtxoF9DFD8DlRtPde5CPyEgvUFI6/5
         JBogXh70Tz9LTReky55owhgtus8h7WVHhO/USOoO0UCU7vHksXLqq9VVAaAmiTC1JKU3
         IpMduRKsWAPMLQC/IMbppH0g0OoQ5lGKOArE7IDADpsj2dNprA2a10rff5s0wVCYIwCr
         ErNg==
X-Forwarded-Encrypted: i=1; AJvYcCWKXBEnycCBBBOl40ncj3jmSreCX3b40PZAFpPskdVY+T6yM8wGNaROhHq+Afx+Cwei4rpxwHWTCA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxz/r/XNOKvWqB8lZFsZpSOVFIlTgYbcsEtpiThIqKT+ULhRzA
	7HVXmL8JUMce6m/Fk61uTwZhny3zb3ZtliHzXNncR41pJo76VIV+5EY3MQotVSzZulg=
X-Gm-Gg: ASbGncv9X1eCv0WVlg+vwhzDz72KeU29ukxOLoPgZ8M5cBtF0KhqRe8KtOzNXxnT3vh
	Bq55aSZgmPiwvp1eucJI4WBROmwIpJnx6xPctm3LQ+LnN4dq+baNAPqkaOREZImzj/VOoo2KUPy
	BeKepNu/HV3mAfUODOK4bnX2QdeVchJTofIhLyUsEBBAj9skuglOGh/x85xutUyDFLoU1C6h3Xn
	xf89WipnU1CTAIWbWWyEx0A6DH7y03W0lUai5WgtyfwAY52K0XSgMyi+zLXMIOQKeQQKqJKmfO4
	iX+EcvfAS6/1Nt/LXzDOfbbWRGfXl0fuBkv7I2KXLotLwMasvF16gK7pnJNNmm1qps6Zsyxo310
	mrpBiB5GSpNKxJu1M81IadIjU08McIMlGSw487rsefNM=
X-Google-Smtp-Source: AGHT+IG3W5RmwW0KXa53tzqdC7aGtVxDcyIrcDLyCjEyycANLI9U+Z+hJ/jXQi64INJPHjABBmW7Xw==
X-Received: by 2002:a17:907:7289:b0:ae0:35fb:5c83 with SMTP id a640c23a62f3a-ae0be9dc2c3mr227506966b.28.1750842813609;
        Wed, 25 Jun 2025 02:13:33 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0541b719fsm1002786366b.128.2025.06.25.02.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:13:33 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH 0/2] Add SM7635 RPMHPD power domains
Date: Wed, 25 Jun 2025 11:13:22 +0200
Message-Id: <20250625-sm7635-rpmhpd-v1-0-92d3cb32dd7e@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALK9W2gC/x3MQQqAIBBA0avIrBPM0KCrRItyppyFJgoRiHdPW
 r7F/xUKZaYCi6iQ6eHCd+wYBwHO7/EiydgNWmmjrFayhNlORuYUfEKJ7jDolLWONPQmZTr5/X/
 r1toHeTYSf18AAAA=
X-Change-ID: 20250620-sm7635-rpmhpd-dcb5dc066ce2
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750842812; l=624;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=4sR5fPpma/GrOJli/eLiVTPPr/9TVkwqVfopkbkw2Yg=;
 b=8C1xOSR+fZgfOr54HLuwAQbc2nKk/SYaba1UqxJmSlY8b+huwWPWF6bTrhmee79uk+3mUFy71
 0mNZhETK1znDIZB43YvACA7IC+galriMioJlCwd9mFhd0P0OjvZYVvO
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add support for the rpmhpd power domains in the SM7635 SoC.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Luca Weiss (2):
      dt-bindings: power: qcom,rpmpd: document the SM7635 RPMh Power Domains
      pmdomain: qcom: rpmhpd: Add SM7635 power domains

 .../devicetree/bindings/power/qcom,rpmpd.yaml         |  1 +
 drivers/pmdomain/qcom/rpmhpd.c                        | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250620-sm7635-rpmhpd-dcb5dc066ce2

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


