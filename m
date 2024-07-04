Return-Path: <linux-pm+bounces-10638-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFB7927E34
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 22:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62A3E2857DD
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 20:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D47714535D;
	Thu,  4 Jul 2024 20:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KP0ho6JF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF46914374A;
	Thu,  4 Jul 2024 20:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720123464; cv=none; b=t9DaIk7pUi767ZDEM3wOyeqPEf4qch1FhkmZKzGjFevsWfUQZJ5Gy5S8aOp6NsRfAfFKtEKRtBbm6ykywZlAlVkNCGxcLKzVsByUM0KL86JoGfYUkxpGaunFbY1I28wLc0Ds8c00o6eHHyJgbKT6m7vV3ZJ75WXXmDsvoyYRNcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720123464; c=relaxed/simple;
	bh=JBifCK6HZ7uZBXS40Ey9bDlxdAuPuwxPRu8MGiMH2dI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gv7byn+QDP2CchBCWtrsRCf4qeBTE/PXtfgCP14OoI1yDOcGrf/4TT+CypF1/t7cCr5haWFSRLeGMRZBxlfkAxduLWBJDcQVk+Ecg/YEwjyTdhw2Y/tzLS5VPYEmwJzrDzKN5VmzvfA+RNs656V07zwwn3xa47SlweCxIIHBpIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KP0ho6JF; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52e98087e32so1048687e87.2;
        Thu, 04 Jul 2024 13:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720123461; x=1720728261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Z5nRVMseTw3mDtx1kucQJah0kJBZN45sWtryKEAuCM=;
        b=KP0ho6JFLwGRzFtmyC1EeeWZ8rYB2AxlHASHmngtMf/0AXjlr7802uVxbLubr+5oxU
         9zAGRvEFCSn0PoCxOtQtUEoPn4LGcLCVf96eXZ49joqw4J1Tj9MAOE8S/myjObULChtx
         e0UgLkZD2L4jfv5QmtOW+uzUyGX9VoWsACH57yoNWgfpjFmX5bS+jXPQYtOP6ohurUQA
         SCP4HCdl2RZUq318IVf0r+XVO5T3lZb8fSNVx55zufoLBDPNwh92FMQ5XKsdRomeKSpq
         S3BRlXXyT4Dr8Yg2Xu7jtxw37/KilqtIq90rf45b03Mw3Ir5olEsg9xkrRCFj5FR+68j
         U1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720123461; x=1720728261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Z5nRVMseTw3mDtx1kucQJah0kJBZN45sWtryKEAuCM=;
        b=wm9bnCpmrJ3l0bXb08SSnC6v9jhO/qIRUSHqBKICOENIOLPZYdNuGc++gABp77Qc5Z
         SdhKvf5MQbtjgX/S/skdlTwgESEjf9xLSRBDUoONeFubP9I79RA6syE9xhE6SwNohRl8
         3TelsaD40qYx/nM3YWFJXlo11O8awWtkRAx2MpouE5lO1aU4zk7R5/oN5Gqb935Phuwh
         C5aqEGLbGhy0Ko/bNgIsklEIseYirPZKnugIc5jjsNDDYsOhVS8pjBgD1b1SVUlqvkcA
         8UPReHQBkWeaz9a+BKA614+lcPWSF2VNdAE+eBaGsvf+dowetWgPoGZdddAPiJX9hLgF
         6vlw==
X-Forwarded-Encrypted: i=1; AJvYcCVVfL81F6NScBWFGuDkyQ1HV517zOfcpwP85EDP2F72x2k0nRch3/glk/VInf+W1vxSbJud5bnsR7YHPh33uaD8XO3C0GNnFJIQcc4ZaAPb9cMhz5A8rpoPLJRPe6yMeyvZfX9E0vGXKDiSSrzf9q3VuG4M+TrjtaPgs9WYwCdjBimRH3KHlb/DLAqkozeKpjZofzVCdRmlOf5XIbfEeURAmQ==
X-Gm-Message-State: AOJu0YxN9OWkep2Wj2rOy0in/BoCB+G45hPVne0OVvctwsqtde7AGJxF
	bxc7RjkH97IjrDGXwZzf9ghQ13vb+YXeOIWZt1MLHqOKZCeYOJTEaDPfDvu1
X-Google-Smtp-Source: AGHT+IFFTtfYEtPBRv+SnpAh1IglO6gp+0mzzxPzQOQIBSxRMezB6uUJIR6lxE/mXhN/PXOzfdjgtw==
X-Received: by 2002:a19:e045:0:b0:52c:d905:9645 with SMTP id 2adb3069b0e04-52ea0613362mr1959966e87.13.1720123459667;
        Thu, 04 Jul 2024 13:04:19 -0700 (PDT)
Received: from localhost.localdomain (byx56.neoplus.adsl.tpnet.pl. [83.30.43.56])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58b4a97b1f3sm4091149a12.18.2024.07.04.13.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 13:04:19 -0700 (PDT)
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
Subject: [PATCH v2 7/8] dt-bindings: interconnect: qcom: msm8939: Fix example
Date: Thu,  4 Jul 2024 22:02:30 +0200
Message-Id: <20240704200327.8583-8-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240704200327.8583-1-a39.skl@gmail.com>
References: <20240704200327.8583-1-a39.skl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now example list snoc_mm as children of bimc which is obviously
not valid, drop snoc and snoc_mm and leave bimc alone.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 .../bindings/interconnect/qcom,msm8939.yaml         | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml
index fd15ab5014fb..3aed8b77f35d 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml
@@ -56,19 +56,8 @@ examples:
   - |
     #include <dt-bindings/clock/qcom,rpmcc.h>
 
-    snoc: interconnect@580000 {
-        compatible = "qcom,msm8939-snoc";
-        reg = <0x00580000 0x14000>;
-        #interconnect-cells = <1>;
-    };
-
     bimc: interconnect@400000 {
         compatible = "qcom,msm8939-bimc";
         reg = <0x00400000 0x62000>;
-        #interconnect-cells = <1>;
-
-          snoc_mm: interconnect-snoc {
-              compatible = "qcom,msm8939-snoc-mm";
-              #interconnect-cells = <1>;
-          };
+        #interconnect-cells = <2>;
     };
-- 
2.45.2


