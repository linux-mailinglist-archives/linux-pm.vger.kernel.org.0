Return-Path: <linux-pm+bounces-8822-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88166901763
	for <lists+linux-pm@lfdr.de>; Sun,  9 Jun 2024 20:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9581A1C20358
	for <lists+linux-pm@lfdr.de>; Sun,  9 Jun 2024 18:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C034C3C3;
	Sun,  9 Jun 2024 18:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/DY6W/b"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101A5200C7;
	Sun,  9 Jun 2024 18:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717957290; cv=none; b=g6jjhCpL3fWaviJn+JGNcjnh/e229U3Dqw12KLMoV3dVUzCh8E4gx+qPFOAhOUGUB0CbjzRLZl4iMdPItmWALvxKuDuFWjN4qQDIXCpSk4ZQY98yuIh9HgQr5rR5GC5AlH/m4eMrUlZAgJzeTQWT4QMZqEJvjWmAE9nMTcOnKqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717957290; c=relaxed/simple;
	bh=KOkX8jwurDQld+QlBv0V38OKpgKCWjKILaLxBbiPyLE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jF8D7Tr9kNwb+yWVS1dTqSzJsT0BCSUG3Licmq/Y4L8J4glv7245ko8d1niRma3LGTBDqpd/cwKP40Mw0feLLSnj1lNCT5w+mohIqoNofe+2INuSH+J/Bt06cnV4l+sUrW07NuwUsSOWYADremOutJcjwTbcUc/4BZzV39ehiOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/DY6W/b; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e73359b900so41312821fa.2;
        Sun, 09 Jun 2024 11:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717957287; x=1718562087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AJ3/N1rRgvqAj4Oiv8BpAZDAAW7UDDeKyFOjASvyBQs=;
        b=k/DY6W/b6/7BjgDKC8wK6Bi/eG3PfYvg1e0LivCXQHtSJ2vm1GRKIdkWui1+V6Hoq6
         RWU4Hs2uk0qsLAKwN7KVJLwOc/PBaK8FKHyGbO7Os5tdVU703jRjdM4lS+lxo6tDvRk/
         tbbu/Kgh6+UMh+3K641eaCR8hRk5nTr4SRF2AQGFjSUEb99c+7lzwFDqKtLeWW/2kYsk
         q85/SH5mfNLXg/uaG5UgzxH4MHGTdsmTqSjzWYSZ/Heepz3bh/BS8VIDNJSok8iCy1mH
         7kdiildRRDgwPjZv7MZ7yET0DkgwrbMV86Cg91Lcfdfye6pRKx6yEURdLAr3PhbjmLSE
         uaRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717957287; x=1718562087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AJ3/N1rRgvqAj4Oiv8BpAZDAAW7UDDeKyFOjASvyBQs=;
        b=Cq9e47JeOljZ2pRs+tIMmMrK9Bhu3bh9aIoHUIoAQ9Lleo3wCqovHyZRDR1D2N/+YY
         akZREuCufaweEwUIWNzGBZJ0g/WWh+nDA14YLNM49vFPAF4+snY6kR0aMCJJYsDgksEw
         nVQW2K62x0J821vJaRNQ05K1LPvLDBsIoEpEOB61TKendYTirccV91xkkn7RiQKtwelA
         FIU+u3y+mjAB4SgqXtyUGvCIY6gBto2VzRAxcjX7l63Ovtv3qsL5Z61XSup8yJfHnrS5
         XWrmuZ8XTzT6Qiqzg7gAoURaMKLoN0OlzUgGP3LtIN7rN/TBMhxXpeXF8Fr/UxBct3fw
         Xd5w==
X-Forwarded-Encrypted: i=1; AJvYcCV3tYr6qWWoLa7JAfGFGjozxg3a2PGeyA3lxPhgq+MKK7T+LCZNi/NMV2ENwCiSxzkPpQOrTRlMwIfIgngr6+VRk10pH/KW658RNSW3K1wjZ5sQ+svU2qApheWIPkC5dfUH8bVpnYGs+uXI59FZxdMxc1VYz5gNuted2m4FU8lFVaEUmTLjgBpY+18fraLMSRI8Gj8rELfWScvg8BC8j8zGvg==
X-Gm-Message-State: AOJu0Yw0iOt3l3ZqrCdfKYS3K393LeOXyDejSByOTTKBVZWkPi/4ASSj
	doowgyz2UaYcngspIuOtUa3dyzngjhfcw5PbZHxUYNmMHga5xa3Wk4kZwA==
X-Google-Smtp-Source: AGHT+IHqVEZNjTDF7WWqnYMLstPdIJHXxtv+sg5PyBPBPt3ibxDoQUcjxCsmInu4o7z4jJcEgBbfCw==
X-Received: by 2002:a2e:9811:0:b0:2eb:d87f:7d78 with SMTP id 38308e7fff4ca-2ebd87f7ecdmr17982411fa.30.1717957286324;
        Sun, 09 Jun 2024 11:21:26 -0700 (PDT)
Received: from localhost.localdomain (bza83.neoplus.adsl.tpnet.pl. [83.30.46.83])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ebd5a63bf2sm6679841fa.33.2024.06.09.11.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 11:21:25 -0700 (PDT)
From: Adam Skladowski <a39.skl@gmail.com>
To: 
Cc: phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Adam Skladowski <a39.skl@gmail.com>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Georgi Djakov <djakov@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] msm8937/msm8976/qcs404 icc patches
Date: Sun,  9 Jun 2024 20:20:53 +0200
Message-Id: <20240609182112.13032-1-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduce new ICC drivers for some legacy socs
while at it also updates a bit of qcs404 driver which seems
to not receive much attention lately.
Please take in consideration i do not own any qcs404 board
so i cannot test anything else than if it compiles.

Adam Skladowski (7):
  dt-bindings: interconnect: Add Qualcomm MSM8976 DT bindings
  interconnect: qcom: Add MSM8976 interconnect provider driver
  dt-bindings: interconnect: Add Qualcomm MSM8937 DT bindings
  interconnect: qcom: Add MSM8937 interconnect provider driver
  interconnect: qcom: qcs404: Introduce AP-owned nodes
  interconnect: qcom: qcs404: Add regmaps and more bus descriptions
  dt-bindings: interconnect: qcom: msm8939: Fix example

 .../bindings/interconnect/qcom,msm8937.yaml   |   81 +
 .../bindings/interconnect/qcom,msm8939.yaml   |   22 +-
 .../bindings/interconnect/qcom,msm8976.yaml   |  107 ++
 drivers/interconnect/qcom/Kconfig             |   18 +
 drivers/interconnect/qcom/Makefile            |    4 +
 drivers/interconnect/qcom/msm8937.c           | 1374 ++++++++++++++++
 drivers/interconnect/qcom/msm8976.c           | 1443 +++++++++++++++++
 drivers/interconnect/qcom/qcs404.c            |  126 +-
 .../dt-bindings/interconnect/qcom,msm8937.h   |   93 ++
 .../dt-bindings/interconnect/qcom,msm8976.h   |   97 ++
 10 files changed, 3354 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,msm8937.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,msm8976.yaml
 create mode 100644 drivers/interconnect/qcom/msm8937.c
 create mode 100644 drivers/interconnect/qcom/msm8976.c
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8937.h
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8976.h

-- 
2.45.1


