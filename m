Return-Path: <linux-pm+bounces-42381-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id DlusEEyVimmuMAAAu9opvQ
	(envelope-from <linux-pm+bounces-42381-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 03:17:48 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DE3116385
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 03:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 20139300C31D
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 02:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C592BD597;
	Tue, 10 Feb 2026 02:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzU6hPtd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79AC26B098
	for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 02:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770689865; cv=none; b=QGErC2tUsALQfH9tig3I81y9/0BblUsed9mqOzM4ZMxNwhu+vQo6vKp1yLFFmcOoGAfECH09N4vQJcpnk/XLic4yhAXnzX4vfxgEJCYj8TEOreipMwAf22N59M5IL2TYtG52jBY+aHJDnYOx50tdOAAhcsudsw1h181aoMlAYl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770689865; c=relaxed/simple;
	bh=x+sOSY//QCezMpRPW8PIgut8blGLbeIdZGRJjQRRcO4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B6lFYUUEtPBnJMpJFy8FZ5W9tUTZPhsErVke5WL47V2da5LGQw4CyLNXzfQy6uul6C8967Tod3XW64M3Cxm4DNq2oU+2XL9dSnobPPgjBXJBF+N6zSr8jz24AhQejLRoozKlqFhrm+lnx3iTzLIuQYkBX5GKcQPs14p3fQx38Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NzU6hPtd; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8c6d8751c88so536713585a.2
        for <linux-pm@vger.kernel.org>; Mon, 09 Feb 2026 18:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770689864; x=1771294664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KxfGF1HkgcEk0da630jDyVz/s1o0G4UkiTYTbi4Udyo=;
        b=NzU6hPtdDzaL/NJ41ZQbuTUqa5ZKhfbi6SIykhUhO2+BNjNL2HCFN+kVuEcEbPtHgp
         iSuT8YI1Zr+m5BMqBtWVHNhYELU071Lg40Kt2UpkXR2Wrd7lrEJFYuMeljVo4n2sTJzG
         a9r7rc4s8wKbj0Gum7e/heGnfH5jb6QIGL9falGHpI8uo7fpYpWPOah39JSAIR9I565x
         cdcfDfj8G8WBFPSpvH2A2yrXH0MdfT8jFKVLqa5k2OHP4Wq+aXjM6XvoEjCADxN35ebL
         v1l9H1FVgu09/tnphFf/2CigiZQNP4xKSBY1JYY7YPnJ5/DFxg23cVo3wxPbxXRGa2SA
         d4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770689864; x=1771294664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KxfGF1HkgcEk0da630jDyVz/s1o0G4UkiTYTbi4Udyo=;
        b=CjtiYdNqeIACJDX2h3lcaOK06SI4MvLhrwW6QXQulPSkbdQ7VkR+oO/dn8eSWTKoN+
         PTGt79028gzawLL7F8mwjm8ctOAbJUDu/TUAXR4rp3zRquKGcpOCVsKWh/syQhwpYxNl
         h0np/LIITqFZwr0gjbJUTIPbT7nQqqAtbdz6fNNqXGeGvl3Kfj9Lqkze8gfY/NbWJlgZ
         zQLPtiAb8wRr7pfk52RtycMGOL/9/pjvbFlJoXptN5Gi+6zWpr6Tc4vAVkgToZqe4UpI
         VS8qH+RpftehqheHPKv72fphrQB5eB+jTVBhV+b4e/Fxveka3L9RXNE946T48T43NfLs
         cZGg==
X-Forwarded-Encrypted: i=1; AJvYcCXAg46bamJtzVnkH22grG4PvuMmquaYDYa8vlx+7v1aO92pohsHu3oPADZ/hGRAaw6H237CbDbm5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnE2Ay7WQY0HRGzo5skufMEu5f98Z22Pw9jeO+VvpWZ3ncNIxg
	XNqhi0fcdVHb2oHodaPNlB4rgaCbU8lrnihv9qu814TLA2OM+8A871fg
X-Gm-Gg: AZuq6aLtrsySUU2KTgpQ3RFFsi2F6YfrayJRT2OwgrGrOS7kSuquWMCCxrkkiyHfpbu
	MKf/MCI9jZ/e8XoXgDHgcsni787cWpkfnpzoxJXyRBKIf8nE4WBunst0W9F0dbOiTzsPeaJ865a
	fIECCe+/h3QmOrTuWIyW18+PSCN8FKNZRA9mylEN+/r+3aXT2kzYyrcqnzNLx2ijyvOrty3I3Qd
	gPNbE0Lf1/baAsf1P2/lfMhVgkReLW8gr6zjuXrCRivsUEy3QZDCWXK/AIc+rwq+oSW5RWocGQv
	JXk0UmBXJyVYeCiJ2qX5hrRqlMyB2KI6Pt7fh1XIskldcVBxG1U1xpgCkcboma1XFJ4nAeidaOI
	G5I88Kzdh+PKnPT4UXSb86u+jeRNcwPjeB9JArSfGbMaKzY893vijxOyJUVqFIx86YXHN16c5rq
	avEVOsBZblzwsp7SpugZ/YDxJK6OUJNQKnO8g96KL42+46GR6Q5wp2SvAYnjCmAl3XnTXzeAsYF
	bk=
X-Received: by 2002:a05:620a:191d:b0:8b2:e986:2707 with SMTP id af79cd13be357-8cb1f6ec458mr74691285a.45.1770689863783;
        Mon, 09 Feb 2026 18:17:43 -0800 (PST)
Received: from localhost (bras-base-toroon21-grc-75-184-144-58-243.dsl.bell.ca. [184.144.58.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf77f320esm937925685a.5.2026.02.09.18.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 18:17:43 -0800 (PST)
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
Subject: [PATCH 0/3] Thermal monitor on PM660
Date: Mon,  9 Feb 2026 21:18:16 -0500
Message-ID: <20260210021819.12673-1-mailingradian@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42381-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D2DE3116385
X-Rspamd-Action: no action

This series adds the ADC thermal monitor on PM660. It also fixes the
scaling between voltage and temperature for the HC variant.

Richard Acayan (3):
  dt-bindings: mfd: qcom,spmi-pmic: Allow PMIC4 thermal monitor on pm660
  thermal: qcom-spmi-adc-tm5: Correct the voltage-code scaling for HC
  arm64: dts: qcom: pm660: add thermal monitor

 .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml        |  1 +
 arch/arm64/boot/dts/qcom/pm660.dtsi                    | 10 ++++++++++
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c               |  2 +-
 3 files changed, 12 insertions(+), 1 deletion(-)

-- 
2.53.0


