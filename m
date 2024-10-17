Return-Path: <linux-pm+bounces-15891-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E029A2AF9
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 19:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 198601C21F85
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 17:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1A71DF98C;
	Thu, 17 Oct 2024 17:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GMOcQ8jI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C8E14EC47
	for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2024 17:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729186284; cv=none; b=n6ytNBGbGf/QYUMP9GNq+WCPQNVHsXv+Ma/3bMB/yDTefobRI1aun82inVGFg7PB89PiPgFblgOCPSGoGW36Gxo3eokQYsVs/HYlxLtNJWawiDu+YdDOEmCwhr3jt6VE6YYoJh1TImNBFoFAEcqgvbeGiqcOzHqYAXGQuKlV+Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729186284; c=relaxed/simple;
	bh=QZKivi4oYJtvbzCOhFA0G+1NIr+1kUV57OnmO7H6PkY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oAN+Fbn+vdLJw8wMRdMnW3wpu5ZK0+UajX4OIHI1N1ihFy60M7tzlfXpdc+aFTcpMxOucsVnGMLBM5OHb4ug1fXhooPapwqaQfamaD6nmS0oEAJ5TcdrqWwts6Cjk0rZquK7IegDWCwP0mnLC44rsdN66g4rAyIBijMhOk9l3Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GMOcQ8jI; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539e690479cso1438518e87.3
        for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2024 10:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729186278; x=1729791078; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tQ8yWTOGhDbSPdENvfKVWd9QsC7QTDOhirLbpOMXIMg=;
        b=GMOcQ8jI2YzOdVXfUlgGh795W94yB0mrhS8wjXVtYXymxZ1KWxtMfWZWDPvqvuOY5x
         hDNEEegHCdrjXqcngSnKkNUtr8HF1usXvELvEem8LK/NzhWTjIxMTl/iMMnvzVlNR88I
         rgAHzxUF2qQUC+w1rFVL7Vz/tf8zlWPgUyG/hmmrn6Xhz922kaSIxWuEuh9qZxTOK2JI
         SXs/E2LHCIwKFJnf/YzXlQNNp8ZuU5pVmefHbUhsk+dktLq6nkt283S0BW9Cq0JMMKKu
         btZTlKRcbCtn23fCV0Ih3I7P+au5dUeVJVWPhiDmewX6aoR1m94cu6kRhcGgDPZzO65C
         6xOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729186278; x=1729791078;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tQ8yWTOGhDbSPdENvfKVWd9QsC7QTDOhirLbpOMXIMg=;
        b=fA6CDLRnbjrZ5L+hEjdr0RCXKNt+in65+etKaxmtg4AmjdUQC5vSCOnvmYbpt2lwjH
         P7Q2zfTC4/tBPmAbg5JVZcqhsoPRRtwoZLRTIP5Ppf8pvUVprXy9tfgzBlL0GLrvufjS
         q6e1jEIJt4QFpgz7LpDUjjEusHbfx8GUm9EUdPt+BMRSQl6gTTYXNhchbyUeid/Gbt/F
         WcrCVbOWiyhqoJH/8N2naMcKPtkeUxdK6BOYQ3yacMluRG4RCTMgl8QYU906IP4p5LVn
         KEPo5AQEn9abbN2En4RB5zWKQ2xWu0XvErwNGvWvPTZDCTQCmuuN2qbHbJRJr8qTDJpo
         bqCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXs0PhBibxPsuTpLOTbahcO9nFC7C/ZY325g5YRYAiVmixQ1VlIOBZipR5OgwwxYhdLYOcv1Lq5iA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy877whv0orBRfwvW1zpZJBsBPk/5/PR/fQLzTCt1DfRJk7I7JP
	46Beb2snA0sSJfIJnUswK6eOM9NxCpe5wSoHRR7mxP4lTd1mpANdnHgPl4Ek31Q=
X-Google-Smtp-Source: AGHT+IFGWRnCw6tCOc2QSTDK7CM5p0tGG38ybQAIFT9gk/jZusrB7vJ2NVorx8HlrEckQKtwWCoQhA==
X-Received: by 2002:a05:6512:3d23:b0:536:7b74:ef50 with SMTP id 2adb3069b0e04-539e54e81c1mr11072264e87.18.1729186277766;
        Thu, 17 Oct 2024 10:31:17 -0700 (PDT)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00-70b-e6fc-b322-6a1b.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:70b:e6fc:b322:6a1b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539fffb1a92sm826104e87.101.2024.10.17.10.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 10:31:15 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 0/2] interconnect: qcom: add support for SAR2130P
Date: Thu, 17 Oct 2024 20:31:12 +0300
Message-Id: <20241017-sar2130p-icc-v1-0-bd3a8befa4aa@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOBJEWcC/x3MQQqAIBBA0avErBOc0Qi7SrQQm2o2JgoRiHdPW
 r7F/xUKZ+ECy1Ah8yNF7tiB4wDh8vFkJXs3kCaLGmdVfCY0OikJQbFG65jYeDdBT1LmQ95/t26
 tfWju8/heAAAA
X-Change-ID: 20241017-sar2130p-icc-e0149e2e3a95
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Odelu Kukatla <quic_okukatla@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=829;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=QZKivi4oYJtvbzCOhFA0G+1NIr+1kUV57OnmO7H6PkY=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnEUniD8Z72gK0SVgOZ7TSD6Bk6OYvKSO8N9pY9
 Ox0d/Xeg7yJAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZxFJ4gAKCRAU23LtvoBl
 uLlyD/9cAWyH6+Mr0W7dTUihp+up1t+evGCfSTaTROj1pT47PUGpneOJz9Tja5VLTA9Dw3lqsCK
 AfwVHLTH9Aq1Cd22vL/e6ivseq/ta9usP+WwVNxrd3ww1ql7kzEQR3b/D4oPPgMW/RC+mWyAtDF
 3T5PrWxnOnLz+GPM34XTHoJ4VS2rR8hf4akvaQtY7GRAY/igLMXtmraxx8RLqUCYmkUHDiO+gXm
 Z6VN51VVPSzQOSZDS+p67mLX/Uz9STMdOAx6EbL5Af27j8Qb+wPBHlQ5fGUrE917Ecr45BehCpN
 l9GpbgqoWbWAZ3/R6jLcytV2cBr2zuzS7vZVIstMjg/9Pv7wagyB0lA7v4463iK/yUYltg2HUQS
 ZeUfb36jDwZFUv7wY50wfIaoQ3HVMe9Ipk/VBzC0Rn8TiItPq1D0LQbz6h9ps4hfFmO7a3qQ18F
 tJqkeARCbrhgaIIkV9Wm/Of+LNlvNtDFN5o8XUsQTVPZWiMjJ7h29edI4kII6mw4jgT/56fjGqS
 rDrkHmF+FbLVuXr9gIB8aZ7ys7rA69XYALEMP7BanryahWW1x3UapSdex91a4JDdDpKXMYRcKuQ
 +y+hTrSKdLwzmWLWp4AZu4vXIR7DVYYXRw+USK+g49945y/ZigErwMVdWrMlQBm5VH54vIxuOaY
 zmCyAz7OdHy5ckw==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Add driver for the network of connects present on the SAR2130P platform.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Dmitry Baryshkov (2):
      dt-bindings: interconnect: qcom: document SAR2130P NoC
      interconnect: qcom: add support for SAR2130P

 .../bindings/interconnect/qcom,sar2130p-rpmh.yaml  |  117 ++
 drivers/interconnect/qcom/Kconfig                  |    9 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/sar2130p.c               | 1930 ++++++++++++++++++++
 .../dt-bindings/interconnect/qcom,sar2130p-rpmh.h  |  137 ++
 5 files changed, 2195 insertions(+)
---
base-commit: 7df1e7189cecb6965ce672e820a5ec6cf499b65b
change-id: 20241017-sar2130p-icc-e0149e2e3a95

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


