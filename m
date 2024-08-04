Return-Path: <linux-pm+bounces-11886-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF38946C76
	for <lists+linux-pm@lfdr.de>; Sun,  4 Aug 2024 07:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D64B1C2157B
	for <lists+linux-pm@lfdr.de>; Sun,  4 Aug 2024 05:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9573A8D8;
	Sun,  4 Aug 2024 05:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GY4q7uPB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EC3D531
	for <linux-pm@vger.kernel.org>; Sun,  4 Aug 2024 05:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722750035; cv=none; b=MsCDqJOUZGNz9KdGeReFzdmH3ZLrdNWLxYwRnNYQ8/ummYA3bN6c42VfQd0dxPgAbXUX3y/6UzRx7CbqtdsjYTQIuIAIepSYBby/k9opyfrvkzzMT5UH1xqdBaRfzlrqgqjeBkPhLoco2wXXuwEQUxnxeSs6Z5IFkT4ejGn1FOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722750035; c=relaxed/simple;
	bh=ZI9fPJt840zyCD0T/bdD2HXJKwtHsbp4pPiV3WmPfv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tqdhdCLfgRjlMVWHW12BQ5VrvuWJEwlzJ0MVO7/nMbbjdzbVhujTrA4e0oop8tV4GpTGz41B8nHRR+CvvH9QXICo3SPYqKaBQy7+602sVsx87crIegaHq5iGGTXorBcwlLPi2SDEILZwLd++vFEIXX3JXp03NClfR3kFJvic/sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GY4q7uPB; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-530c2e5f4feso1496683e87.0
        for <linux-pm@vger.kernel.org>; Sat, 03 Aug 2024 22:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722750031; x=1723354831; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I8Wu94fGKiTMPD1PzKnesNCvm5Ij4LDiKxVI9I0uyRk=;
        b=GY4q7uPBdDWYTU7rn8t5qP1GB/6SGbKY69kZXh4mQKhaUT+gOphxgECKRIvNX01Jmv
         GwQzD4gW5SU+OgM9cB5wfeXqe74vnUkkpyVKfQgQ9jqGJmv27JDXcZ/xXZ2bJuUBgxAR
         DD8lTxjNkETzHEv8IzZU5DklFe3lE1jWkBnbUOS9Efid7b8V+tHGT6P7J4xRQ+EamiOy
         K+BFzHm9xNz3bW91iO9mKfblfxuxGUBEx7E0nRo9pW41o3ofJtDK5zheD/ZkbSsk253c
         0uHvbYRBnD7skEwqJggPr43k7NyyssvWgzygOiwzAnZOS/xMJBGWRBztnOXoMcyRuhZg
         pV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722750031; x=1723354831;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I8Wu94fGKiTMPD1PzKnesNCvm5Ij4LDiKxVI9I0uyRk=;
        b=kY5QqAwoRHPsT+0bEqc7Qv/MIg5bwAOV2LBLr2HQD9JX2hTbW0t5ldORgLf/JEZuM4
         Ik8ZLJtob5eDXAsScBzbro/H1Yt8OqqBL6zH2ACQ67NCDIRGePewUEhwjxmyWG6ACOuf
         nBElWCEHs5FnawIJLSKYOnKE+UUfKXfyFyxYCOkz9vfEm7chE7WZS3DjE6sjJ3MGVI1D
         SLVLPmjBMrkHfFf+foVmPHouyzq5IruIVfdwszhcUhDrVky9J+FQtFO7PEGQ24ialiqp
         FHUVDakk7mchPWn8+F+eE0buvvmmO0nE0axRQX5mpR9OYDHgccjRE+Oc3ssEMi0IXJlG
         7nFw==
X-Forwarded-Encrypted: i=1; AJvYcCXRy2Rq+UgD6Ml8MGE8sLdBjl76l04AfENqKLrLkzPcCtKww/AQQbnzsr4bERel0Ku4ht+aFgq7TQrffkPBUJRIh7RYNmmsbbM=
X-Gm-Message-State: AOJu0YzzKT5SEGYDFbW824dgelzvb1jGYLhj53IcU6MzAKwgYDF6DpMl
	LbetLLtYUnvRm8Me0VomCfCTWdH4cEaorKwA/FW3htPIehzchDBwKOwF/Kp1YfM=
X-Google-Smtp-Source: AGHT+IFfmnlD6mrDT3KruFvoon8BUGprvXegwalTaKHvGV+9P6kPPphMtaSDcjG1NUuShKFfX0CTEw==
X-Received: by 2002:a05:6512:1590:b0:52c:e28f:4da6 with SMTP id 2adb3069b0e04-530bb3b1517mr4682167e87.51.1722750031400;
        Sat, 03 Aug 2024 22:40:31 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9bc3bd7sm292248466b.34.2024.08.03.22.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 22:40:31 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 04 Aug 2024 08:40:12 +0300
Subject: [PATCH 08/11] interconnect: qcom: sm8250: Enable sync_state
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240804-sm8350-fixes-v1-8-1149dd8399fe@linaro.org>
References: <20240804-sm8350-fixes-v1-0-1149dd8399fe@linaro.org>
In-Reply-To: <20240804-sm8350-fixes-v1-0-1149dd8399fe@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Jonathan Marek <jonathan@marek.ca>, 
 Robert Foss <rfoss@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Georgi Djakov <djakov@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mike Tipton <quic_mdtipton@quicinc.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=856;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=ZI9fPJt840zyCD0T/bdD2HXJKwtHsbp4pPiV3WmPfv4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmrxQ/jMwL35sKEU5D9Tjp6mYCnOmmqoQLsUae1
 0DawQf91CuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZq8UPwAKCRCLPIo+Aiko
 1Wd1CACoGYeZT9QIFHk06IumJN0/f3vOzPfA9od+eKNLVIGC6yd7rm9bCEyQzomcgGvPKr0Hxzz
 ppcABqc8lJWSoKS3xOJDQ8kD5vZCwVV4MGJ3acpjzTsYn0F2T6GXEp3Sj7DGftexTbNh3Z/JhBx
 RYS5hdWYsl6yIgSeVKkIo2KoCxvbv3NtX6o/AylXee2y6ZgOXlE90ASOPKaRg+siUF2I7SFsWvR
 ALaRIt8XmnvWLl2KLVShljReh+EiVuvwBXguCSYi3RqH9dFpHFgdW50ru6PZyu6FO35ucww3HlT
 CKHK8YPjkcXBS9TJ6g3zS4L3BiEv95HTup5R9lfaU4olHiCn
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Enable the generic icc sync_state callback to ensure interconnect votes
are actually taken into account, instead of being forced to the maximum
value.

Fixes: b95b668eaaa2 ("interconnect: qcom: icc-rpmh: Add BCMs to commit list in pre_aggregate")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/interconnect/qcom/sm8350.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/interconnect/qcom/sm8350.c b/drivers/interconnect/qcom/sm8350.c
index 108934fc8ebf..4236a43dc256 100644
--- a/drivers/interconnect/qcom/sm8350.c
+++ b/drivers/interconnect/qcom/sm8350.c
@@ -1811,6 +1811,7 @@ static struct platform_driver qnoc_driver = {
 	.driver = {
 		.name = "qnoc-sm8350",
 		.of_match_table = qnoc_of_match,
+		.sync_state = icc_sync_state,
 	},
 };
 module_platform_driver(qnoc_driver);

-- 
2.39.2


