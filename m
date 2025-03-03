Return-Path: <linux-pm+bounces-23299-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB10A4BF85
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 12:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DF6D1629D5
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 11:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2CE20CCD9;
	Mon,  3 Mar 2025 11:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcg4DFRr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A816E2036F9;
	Mon,  3 Mar 2025 11:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002998; cv=none; b=Jlf0E/tqqvNgPubPtF9ezZAcv1YrBA+O12peRxqI8F6sY82Y7m9Z98pysFYbvDijHsX/ugs3/puE9935/0CPDHJ5ArzFR87/Cf2Y1egehiFhrHm3CfjwHxlEGbFRYWYr9NSqnQh2P5vycZomlIEGKx1RuK86VyQMrT+5mD0BlEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002998; c=relaxed/simple;
	bh=EPUaYsz9RGP9Mfmct+MjKUCihkIdRVMvNEvFaiL85yo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f0HlTWKMVtUBRlrWv28Xzp/579gLapERIfrriRSVGLfm5Co5SvlHosARFwGEWVqljs0J33dLmJer7/RosUkOxwytNgPM+o4jioOqur3ZJDCuNmdg8aVsnnLRPOmCta68uJBlqlQqlby9E4k6jDb8owD9FgtzdpF97Yt0/4CUR0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcg4DFRr; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-549490e290dso3171845e87.2;
        Mon, 03 Mar 2025 03:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741002995; x=1741607795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pbRgFCwk7Kav0J9k0Ma2PmL6NESow8QOcvEaprV4e+A=;
        b=lcg4DFRrO9oMmV3cojgDgjz6K0Ro/QqeT7mFFmN9844jh8559rdSyrXg7ggN1lFg/R
         QT1vl0vTo1xp904pMm0lfH7G1vNcV31vlg1dJwOWQopEJLm913D429lpGtmtDaCL7wha
         mYpuWWdeEQ8lNH/7Lf8Fj3yILPkXb9+gCUPS0cw2FevzZK7zzGCVQOQw/keNedtppKE4
         e5j2MQUviKKc/FtHKzVs2D1psk741uPIB3upCy7jUed4wqJn3ktPNhLlSr1ipVBuno9Q
         jZnaViV9LmL0Udw0Vs6xEMDnIi/ol6shnzZKg/GuOZBQRmOb5Z6EnxZAKrohPWniN2PM
         J/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741002995; x=1741607795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pbRgFCwk7Kav0J9k0Ma2PmL6NESow8QOcvEaprV4e+A=;
        b=rZNucrkHrIfckI8qS/23puFiSYzczPnSUxGNCbFIp85twxio2WM6vfACwFnn1JSdSx
         0lB36Adwh1fuJ7z2BciqLJfhia6FFvIvPa5m/e67I1Sf7VYCQwVzyHYQV1qkbCZW7/Va
         yiY3saVl6N2d8SCkp/XnZYICHyi9GbFwqAdFTukobx5PmlEpWOMX9fb7mLPHHM6uZcS4
         V9rSf4A7zCOaoq1XpAGUi1txo6gq2t92ZjYmSfNcIAjPnEl6BQlQNEo+Gt2dINDz6n60
         Tg1nIhn3lnMUAWYPXTzt/cbOe1tyDt37Vj6bDFMrJu9wu5jmaDhOKR3Pw3lLnpcuIVsc
         MzMg==
X-Forwarded-Encrypted: i=1; AJvYcCUQOUcw4DQusQzxcm8c0fAGnEmVzXfWmiAEHGjqkJc+86RqsNQWrkTeqFv6yuvIdSwF4MzYLsHJUzwA5dCk@vger.kernel.org, AJvYcCX3mE21VW+BU7Y/aq7DDQHMerWFPhZGQaLriPYKmvsM5GWDbTBXR+2/68zE5+wL/uoa078g7fnf4ewM@vger.kernel.org
X-Gm-Message-State: AOJu0YwHK7eFGE8TQbsD7L6MndDMf8Uu6ihmLf3byH1yOAuQbSPGyB9U
	3ItRc+LXY9kzK0En/7b/AEHthj6yAIk74AK5otfD0H1E7zIqhyHx
X-Gm-Gg: ASbGnctdxXIdExv9S1ByfJ5fDhTt9aOXceC8i6bydq66zzD9KZtOcsIoVFZ8Y26V5wL
	b8Wx0ktqsaRhjm/3pl6/JTdLklmE7cOQis+vof0l3RGq6g5Uk4XLwPmsRJDl67kydIOigGu/Lu5
	iKXXb+M0+sJR4ulxaFjZieslGzyfLcCZtqnlKL2GGBgxBP7yTw+78Lo9M3cCOeloZ3sYHRnEMmy
	M9+DuEYuxn70r6XG9BrKF1QzBqyQR6jI8ziiVRxUSCLYOU8qBRXAfbLlmCA+PB+0g61oKnSYraB
	3htX8a25wGyHwitsLprUhSeoDP/WtNcCDBk=
X-Google-Smtp-Source: AGHT+IE14Kz+bAZcHvS8EnHx9OLxfEmTwZXbj/JyckNJPTgTfvtpnACPfWH43rqQOq/qJWRTLLkWPg==
X-Received: by 2002:a05:6512:3d19:b0:545:ea9:1a19 with SMTP id 2adb3069b0e04-5494c10c72bmr5706279e87.5.1741002994430;
        Mon, 03 Mar 2025 03:56:34 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5495f630cb5sm511817e87.212.2025.03.03.03.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 03:56:33 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] power: supply: Add support for Maxim MAX8971 charger
Date: Mon,  3 Mar 2025 13:55:00 +0200
Message-ID: <20250303115502.89457-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MAX8971 is a compact, high-frequency, high-efficiency
switch-mode charger for a one-cell lithium-ion (Li+) battery.

---
Changes on switching from v2 to v3:
- fast_charge_timer, top_off_threshold_current and top_off_timer converted to
  device attributes. Other vendor properties removed.
- removed max8971_config
- removed unneded functions and definitions along vendor props removal
- added __maybe_unused for resume function

Changes on switching from v1 to v2:
- swap phandle with graph for extcon
- added power-supply ref
---

Svyatoslav Ryhel (2):
  dt-bindings: power: supply: Document Maxim MAX8971 charger
  power: supply: Add support for Maxim MAX8971 charger

 .../bindings/power/supply/maxim,max8971.yaml  |  68 ++
 drivers/power/supply/Kconfig                  |  14 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/max8971_charger.c        | 758 ++++++++++++++++++
 4 files changed, 841 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max8971.yaml
 create mode 100644 drivers/power/supply/max8971_charger.c

-- 
2.43.0


