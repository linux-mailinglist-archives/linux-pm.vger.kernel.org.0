Return-Path: <linux-pm+bounces-42382-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8ByZMVyVimmuMAAAu9opvQ
	(envelope-from <linux-pm+bounces-42382-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 03:18:04 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EF41163B2
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 03:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 182CA3032755
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 02:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEB62C21FE;
	Tue, 10 Feb 2026 02:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICFCPa0J"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB6226B098
	for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 02:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770689868; cv=none; b=pMQwdgKTtyRVrPUvkvF5RIqVMHqssD5m+d9xYcFGQuzLlGNTgXXcQ7AgqoJWhqiUho0IqjapC421nGQYffR/AMh0vGWtN5RaDmTJEVlveGssfuc+UrM4+5Q6RS9R2F0X9IxQFtRpxcFZschRCFZvE953qxjrmgv/P0cBSOkXbYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770689868; c=relaxed/simple;
	bh=64P6TH5tCSVMwzcWGEk/Kd9i/JzKQ974GxQADdiPObM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XK4mB4aD377MF3puUbYbLKs+JzmTBKscisBVoNTiT0UjnFoQgnjdOd41VaI6lWQjBYvc5uiYdA4992EOA1JWY4WF6eAf32hHiQCgD6wgC2iU1DT+kvBkXQ+dgyyaww5V9NK70CK5GqeR87c/y9Ky9CXzz6pd4iiEB5sTMGovGwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICFCPa0J; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8c711959442so496879185a.0
        for <linux-pm@vger.kernel.org>; Mon, 09 Feb 2026 18:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770689865; x=1771294665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFScp6N7rXDmSB9O1T48X3nURBntcNXjOboC9T1hpss=;
        b=ICFCPa0Jguq+DHBZh3jXNkh1xFl21X4gV3dTxDlnEX8XdkftWHCR+nnUdX68OaITwh
         rktgoiGaw8FtxzpYdZG6gjUWIapV1+HOvTg2/CxFEQhKtQ1uIxfLV4oXt1bd+MzJU7NQ
         pcEDBTDyU90dugGfYjlh37lgF4Y1pUmcF7GE/5RjsS/XyZyFjxkYkKEP57kCLKqwHZ6a
         MsQLBu2hvz3flF2iobMTh3Z9oVRRn3fPU1BDQYUfKyADPhBsAj0x9Cwzj7SpLtRNOu0W
         5eX/QXtponiIxQLrP6jYjDFxwffqTYFI3AHBKbO+kml+F7lXJNd18AhC8sg9/YuIHl00
         J6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770689865; x=1771294665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LFScp6N7rXDmSB9O1T48X3nURBntcNXjOboC9T1hpss=;
        b=anMZgh2GKWbsGnZx7xj1okj/tV1ukvmTwSIgSZxO11YcBTgkkXhbJq09NHGocuSSLw
         caN4gRLfhZ1924HloEVDsuaJ467Fiz9DoQiWc8leSvY9GdaSorgdAmL4m2kbcUHnp0Ke
         63FF2oIwLlnGbcRC3upXtERQAdObZ93PrZE2jTbVJa+UFJK5cgbWP0Qig/PXUWLUSbYh
         ipvkj9U3LRuDYzRD0lo7sgS/6hBPQt6MpFJAdXhNTdyszxv5k4Fo5TyqM8pSs+zkurcS
         wF11uXo3Fu+IC+6JD2yoHXOa96uGsb4wl/OkIY17Kc6MwHKJeOWwSpvn8CerSy5fylJI
         XySg==
X-Forwarded-Encrypted: i=1; AJvYcCVE45tkxKtXRCs29KIjrnZO8RqapP+eUdo6YpwVR70ZFxgXopPtPhwKXBRl1H+joPjY2B01a4va9A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUckUNvH0fhh535TWH0qUGEpsrc3yOov5X+5NdhJXxy/s9Jtz0
	4vIRreXKO5rEQ2xzrIeKPwMzBdYU0OFcJoUZsl/RYpSxfTjDHHXtNbBJ
X-Gm-Gg: AZuq6aLenbdtYZZvLuelsyEMuroclBMCV7Z1a/pcptxTMV/4NfplZY8TJWhltb4e9W6
	cyqmAJaKIVMELKAo9UOoxrX9EcYqzOB7D1i8UHCuITKzW/Xzrv0mAKi8GGjVSANiaBmN6kkRrGZ
	7t2l/6idc378y/Mgty/f37XaWdYfHqy+oFSGJArN/YGUPJH1CBmqQ5shLBL2Cgxh98RMJTXHnOP
	rdBKZg/4z1AFxkj89HLBhN4HWIx0jd2d3L4qdFjqL5sxMPE6ZemBSL/RvqqmU4Pau3K3rx5LKwE
	rAyZidiZ5slEv6iE7SaUq5rCEEa8ji9ehIDkv034yjg8sLz+hkGvPc8Dw7Du9tgqU7/RwXWwo4U
	8bs8TNSC70O0DNXihwfMOx48VnP2gOz4zLDBSlE+pwhIaICDUpzCVh3zpYtvHH2NzPruhUOQTbg
	FDgreZYnx+QqPaZQt7iGikIZH2v0DxGozQS5S9D0mRhETpg7H63IB7Pft0qTwx0AkpgjtytCRli
	YMXQHD5xb+Go7Y=
X-Received: by 2002:a05:622a:5d4:b0:506:7049:c768 with SMTP id d75a77b69052e-50672a2446dmr11457081cf.9.1770689865393;
        Mon, 09 Feb 2026 18:17:45 -0800 (PST)
Received: from localhost (bras-base-toroon21-grc-75-184-144-58-243.dsl.bell.ca. [184.144.58.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8953c077a8asm91378476d6.52.2026.02.09.18.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 18:17:44 -0800 (PST)
From: Richard Acayan <mailingradian@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Dmitry Baryshkov <lumag@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH 1/3] dt-bindings: mfd: qcom,spmi-pmic: Allow PMIC4 thermal monitor on pm660
Date: Mon,  9 Feb 2026 21:18:17 -0500
Message-ID: <20260210021819.12673-2-mailingradian@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260210021819.12673-1-mailingradian@gmail.com>
References: <20260210021819.12673-1-mailingradian@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42382-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,linaro.org,intel.com,arm.com,vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mailingradian@gmail.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 37EF41163B2
X-Rspamd-Action: no action

While newer PMICs are compatible with PMIC5 drivers, the PM8998 and
PM660 are both PMIC4. The PM8998 is allowed to use the PMIC4 thermal
monitor. Allow it for PM660 as well.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
---
 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
index 65c80e3b4500..d2fce7f669b2 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
@@ -221,6 +221,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,pm660
               - qcom,pm8998
     then:
       patternProperties:
-- 
2.53.0


