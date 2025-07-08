Return-Path: <linux-pm+bounces-30355-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DC8AFC83B
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 12:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14CB8485A62
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 10:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB0B26B2B3;
	Tue,  8 Jul 2025 10:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="AWvIjsV0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F259321FF51
	for <linux-pm@vger.kernel.org>; Tue,  8 Jul 2025 10:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751970052; cv=none; b=SClNeOSgo71/SxbjJb4sHmEJMqxp1KigZPWmQvXEzu7TJsnKfoi8johcBNH+Q8pOdoqzIqA33ifz1HbegIQcaT6OkMf0i5XJUhpUS+G284Dn/usaNMn+clyBptRIQ9AWyhUqK13KJhYmE1+C43bcG5O0U2pz01Uh6ysXTUN/cEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751970052; c=relaxed/simple;
	bh=pAsIyj8FNU22+l5qIW+892a7jSZOvqUK5br2O2YgYUc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=glfc0nN0j+K2zGRouEg000oYBf0ZUkPNjuuhQdy+vwKn3aTxmLH7sEayuMCcf6vUm2qYPQMpksTvPVX/GEnQLmIcEC9LKJa3tkJyxn5alRQkStizJjgo87VbpVFtHgnXWZneloULi9IGBe9nOW1P86X6JuxTz9yW+m2IONKoWJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=AWvIjsV0; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-60c01b983b6so7497060a12.0
        for <linux-pm@vger.kernel.org>; Tue, 08 Jul 2025 03:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1751970048; x=1752574848; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hoM/9evN0lu0yy22DYH2u1ViVQ0gB3dbplrxb3DKr6Y=;
        b=AWvIjsV0DTz4b3QnAvtvYg6dMtXVDSk/tz9uKRMIJWUNbqHYnWyrcuThLslwhloeWt
         eWyXj6INvQ//gjXeqbe4W8eesvcOVq6YwHazTrJwTr34ye5j1PUF/NypsamqFLxOAlkK
         GIxEKH59Bg6ahTJCJ0nIFzKsXmA+en5AdpdISMXs3LJpJ4jguJpxle5jtG0JfVBTgP85
         4EDjJvpfAX9RN15VKXe6HZWgz6Z0egHFlAvgIJyujLuf5m9vrUEp7py2hQYWskRD4/I+
         tihS6X5eYKjFHlvyovBxTvrgKozQgYLTIfw8bwHeGAYWBO94KvwDccW77y2hvg9Tkqqe
         OANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751970048; x=1752574848;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hoM/9evN0lu0yy22DYH2u1ViVQ0gB3dbplrxb3DKr6Y=;
        b=o6V5lkY9hP+6sKBdoa4NZUKDy5ejNUDiIT6e/9bQY5fR5d8F9wR8pK76w2nkFOS8vs
         N03vX2iULC+emyQZOxDWajYxLdnzvnZjYk6xtYmDsuKkXbvXSI73nsif/wEvQIS14Dd/
         YYTb4zZd4d07bfHlUAbIAa2D+gsEztg3HJZsAJDyJil6FvvA9JNps2scovynkJihdAAB
         pWnXdtOeVEljaop1pgo53QyEjEuf+XdC324qbRPafx+pnG5g+/le6gAysN5PEorCZadQ
         hf8HKE1o8A4BwZrYIDKridffW5uZng6jWzyJMnU8uxvhQMpodABy8niVR9XmGrKGVSnh
         +03Q==
X-Forwarded-Encrypted: i=1; AJvYcCWvQnQYtinp2k2p7cgSD/SfNwS10Rm5cE21Oj0p2wAQVzbKoU/SIfYmuZaHSE8hLr18b9bn3Zl2mA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwuxyEFF4iyam26Xu2RCMZbV8i0WvrFW+saiDkKgW/82oTELMVh
	+jtWkDyHY2SOf2NbPcFyFL4nmtwsPE2NuZ7o6gx6bRr5hQG6NI00Q1475gtonBKcsEc=
X-Gm-Gg: ASbGncvcTLe2bX63aWC8bqeV05yBtOj4n1gbLF8uxCi+7b/VMXP7yI5k8udrPfKJFlQ
	LOl830f011X7adOsIuD46aepGMhgTMvweb4psYRCLFHUsl36DrY986YHWLOO9bA/fN+OjppqjY1
	lzl0MMMQbMFNDIQZSEo/gNp5tcdCVwEgDkJAtNKwuiVPX2Fjzt+oYzlQd4fG9z0fvBr6pvhyjgS
	6KUB+03sUG/IXUR4YzAk1C7nfefZ3ugvFh9mt+N0KevHcAk+kttWmbJRA8/OhdmaMECo0pMyPuR
	3nxl05qFVE8w2ZuWrfgvZbSAoWyBl6sDfmWj0BsGaUNLxxe8ptj+/NFesWCNlCgAvI7JaymBk2T
	/fnD8yX5BpxZYlV/9NfXw1RqmF5kcuWgJ
X-Google-Smtp-Source: AGHT+IH19V1X0ltt7NP7bfNwdO7IOoGaifUMK/um+31+Mxp/DYWPUXnlKl7TgcAkqlDPd4fvJzqPoA==
X-Received: by 2002:a05:6402:51d3:b0:60f:c32a:834 with SMTP id 4fb4d7f45d1cf-6104bf2097amr1851247a12.5.1751970048222;
        Tue, 08 Jul 2025 03:20:48 -0700 (PDT)
Received: from otso.local (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fcb8c80c4sm6827718a12.75.2025.07.08.03.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 03:20:47 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH v2 0/2] Add interconnect driver for Milos
Date: Tue, 08 Jul 2025 12:20:36 +0200
Message-Id: <20250708-sm7635-icc-v2-0-e158dbadb29c@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPTwbGgC/12PQW7CMBBFrxJ53UFjO7HjrHqPikXiDM2IJgY7T
 UGIu2NCUVGX39J783wRiSJTEk1xEZEWThymPNRbIfzQTp8E3OctFKoKjUJIozW6AvYeqHQVIRk
 j0YkMHCLt+LTKPrZ5D5zmEM+re5H316emetUsEhDqrnQKsZSmw/ddy/EwhIk2Poxie324Ix2/c
 9/8OPCXl2v/xfmv4PcJrHGu17ruvbbNosTrn56Q1BDpJ8T9moK97qyyprWu/iW6NhHkjJHnppj
 oNMMKWtQ57HoDHLU7o0ABAAA=
X-Change-ID: 20250620-sm7635-icc-e495e0e66109
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751970047; l=3932;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=pAsIyj8FNU22+l5qIW+892a7jSZOvqUK5br2O2YgYUc=;
 b=M126imFYliguOaNvdJVfC7uQWPko5Mq8IQ1xCgrTpMX/rYWS2ATFuh3UPc1thlgcewAxFqSOY
 ADxawEHrAD8AaUxngjT/vkdykQ9huTq5SBRVVRqUVbRBHopdFIm5LlO
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add documentation and driver for the interconnect on the Milos SoC.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes in v2:
- Rebrand SM7635 to Milos as requested: https://lore.kernel.org/linux-arm-msm/aGMI1Zv6D+K+vWZL@hu-bjorande-lv.qualcomm.com/
- Fix double colon in dt-bindings
- Specify b4 dependency on gcc patches for dt-bindings example
- Switch to using dynamic ICC IDs
- Have .compatible+.data lines be one line
- Link to v1: https://lore.kernel.org/r/20250625-sm7635-icc-v1-0-8b49200416b0@fairphone.com

---
Luca Weiss (2):
      dt-bindings: interconnect: document the RPMh Network-On-Chip Interconnect in Qualcomm Milos SoC
      interconnect: qcom: Add Milos interconnect provider driver

 .../bindings/interconnect/qcom,milos-rpmh.yaml     |  136 ++
 drivers/interconnect/qcom/Kconfig                  |    9 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/milos.c                  | 1460 ++++++++++++++++++++
 include/dt-bindings/interconnect/qcom,milos-rpmh.h |  141 ++
 5 files changed, 1748 insertions(+)
---
base-commit: b803ad80123e6efccfeeffa7cd37f98f642e37f4
change-id: 20250620-sm7635-icc-e495e0e66109
prerequisite-change-id: 20250620-sm7635-clocks-7699d338dc37:v2
prerequisite-patch-id: 30b56c4075513c2b4a44b32a07f270b5cb08d098
prerequisite-patch-id: 37be728e2df777fedd469f7da865e5a256a54b06
prerequisite-patch-id: 32cc06fb5708d126263bc3ac132126e530f72d4a
prerequisite-patch-id: d200c8de06976d3cfa9f1db896301019ab8a68d9
prerequisite-patch-id: f13af5b3633a7969c35f3c1497c3968ff438aa7b
prerequisite-patch-id: 70cc297fa29e022d4ffa74b0aad59f1ed1671e09
prerequisite-patch-id: fb0950b5ebf9ebdbb4381762362f131544252bc7
prerequisite-patch-id: c6593a406bcb7d9cb35bfa54b6fd8fbcaa58ae99
prerequisite-patch-id: 6b126e92f96a5f2152d8ca296489aaf712bbaa17
prerequisite-patch-id: 728eae32feac9247a5a822343f777ca678cd666c
prerequisite-patch-id: 1c49368327e67c86e9e3523213c2d3f8469c226c
prerequisite-change-id: 20250613-rework-icc-0d3b7276a798:v2
prerequisite-patch-id: cfef14406349a8de35f9a9f52a94c27b9760c98d
prerequisite-patch-id: 2a0f6625a75fc2672c5b5b8838daf4c1b84dae06
prerequisite-patch-id: c43395b7274c6c4866e293378c2784e1ede5796b
prerequisite-patch-id: dc669619c955d963b478e6c5bf691b09a9e87e5c
prerequisite-patch-id: ec455ecaae1134984fab4ee9b0ced416c8388733
prerequisite-patch-id: b610e2d9aab84dd752188235293267130a540363
prerequisite-patch-id: de89fdb08c0e9794ea1c758bb8429cd8648d16e9
prerequisite-patch-id: 50c1ce836eff66d606cb886a6e16ad09aa0c4d07
prerequisite-patch-id: 893d74d96ade5999f853b37b46dbf45c2b602c61
prerequisite-patch-id: 1af362b4eb70298089b1f407119831ed47d0e53a
prerequisite-patch-id: 99fc9ac3f20c10960aeaf8f95fbab2299fc1299c
prerequisite-patch-id: 719eac9c833b38f49f788d1f347f580523464ba5
prerequisite-patch-id: e5897f2ff8c6a908cbf4424fe34782cdfd8e78f7
prerequisite-patch-id: da0770cbea0b965c9cc1593f4f70316c1f06db74
prerequisite-patch-id: 9850436dafbeb49b4046094c7cff430f8b156d18
prerequisite-patch-id: 99f36df03d920c8e0735c6ff49b6ce24c64e1c4e
prerequisite-patch-id: 0e282a1707f7d4daa0f997f0e908248797a085a0
prerequisite-patch-id: a2c334a79e965882258455a9d0eaa90412ed66d4
prerequisite-patch-id: d4ff7d798a7cf3260a91672dbabaca06e663651c
prerequisite-patch-id: b9065de90a016b2cf7edb31a3bd1fe222344d406
prerequisite-patch-id: 5e809c2603fb204d11a2bda4126df60ccbf46206
prerequisite-patch-id: a5f457c883c17a5ea0f7226b4eeabc1354c965b7
prerequisite-patch-id: fe9cbf613cf61082c75dfb358d0e362680849f17
prerequisite-patch-id: 022a649bf46677564390068752121c6acf91cd74
prerequisite-patch-id: 259e32af18576dbe8cff7f20633437a80f9a50f5
prerequisite-patch-id: 76e0ce648c22ecd9e5a96d8c5c7b49d74c96fdb9
prerequisite-patch-id: d39b4a58681c5e5699ba045d3a889d843d768262
prerequisite-patch-id: 8e648304c8a8b21db26f1ae991abeb52a11d6ee8

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


