Return-Path: <linux-pm+bounces-43533-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNJkEK2Op2lKiQAAu9opvQ
	(envelope-from <linux-pm+bounces-43533-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 02:45:17 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4401F9A3F
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 02:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 76E77301BA58
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 01:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCABB31A7EA;
	Wed,  4 Mar 2026 01:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSxBqwrB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74BB31987D
	for <linux-pm@vger.kernel.org>; Wed,  4 Mar 2026 01:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772588714; cv=none; b=hPBzJpWmw1IrGBxGyTF/YZxPO3LosyArnMlmJHa+p/eeCYMvCdJ3b7IIFDceDjVRF83xmF36EdzI/yb6vH3eWqDZk2kwhU0tj7pQhqDtpk0FHMHngpKE/B6KNlkNg0LVTlvm0+3uJlSUgsR7Y+56K2pPBxYas3TQP9tjBhweFwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772588714; c=relaxed/simple;
	bh=zT7VHqFCzDwH7dsnqHKBT6R20zasdavK49rOXk8BcyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tZcV3j4Q+5qJYdRTUqImzBwaQYymV92yF/i1UAgv/pPnRCHj7PspG9fQA4hpUhiA5ah55J/PTNlfFnCRZjnRkoSFCRz0zZGcSyKx/qTd+jaJpMEeWZSdKF17TZ6VcVKikVsmfafVMs1RCH+nOkzrp5rVzldhegxgVlaGp3PKrPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lSxBqwrB; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-89a07f66f4eso21642296d6.1
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2026 17:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772588712; x=1773193512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqMq09LrRUJ7Y1qu+vRwg7gsZM0+ELiCGik6jbn1EcI=;
        b=lSxBqwrBg0009MUZojv0b6NLMmVG3fJ6+uw0OTAJzcQMVcxzvuG+oyTXs/XY6s26EM
         u/Q2AyCAV6FpH7l876ej/SpqC4V68u1KEHhe2eg3f6EHl0pMX/8yjMx72+5kIrAL4KQq
         6i5YSOBHQXBCET73uPZDxv7CPM1RgmPDhEDgR0DM/RNIsWif3Gkg9hXQiI9S7tw+4fgt
         rRZp7b4RH9uOI03Eap6y3GfdO8iaCEMlRTzHEgKjScLG+uH2Vjd+GCCIOMCyvXXm+1RL
         jeq95mtj1mJTfWRc+YUSUnB2YWcbVMzHWzcVJa4Wan8HkUqWmbJRdpgygKDP06AxIN+H
         83Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772588712; x=1773193512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yqMq09LrRUJ7Y1qu+vRwg7gsZM0+ELiCGik6jbn1EcI=;
        b=j2Uj1PvrLOFiqvl+SNYQtSr5s7joofVJsKnVTyUHdFIFy3r5T4vap9BqmiIP+tKQ8E
         hVvBT0tDQ74Vo0cTtTprh1DS0gFiROqOA+Hh5Q7RPqoN5Vppuizo9omz+W8ybb6mJB4b
         dDi2q3F4N9hLwaMvbTMDhWWRLO2GjH/f7Yv9YOnTnvg5Bj7ocf0soOpJuB1L6ChuJSju
         GGu99tCj8DCTQPTxb2sjsuVfMyMk0Uaxodf0rTN7PT+skd8f87emqn2aaad81A9foaTH
         xXELqlfdzezq/fI4huVruxB96+mDwt21haJ8KaNpEzNMR8rW57uTM1RRXMy7EuOsqC+6
         bsog==
X-Forwarded-Encrypted: i=1; AJvYcCU3/02XQ5NHJuvLMVLyMmLXv+e2YgthI2lCsv8rS3/1lsE1hn9zMoe9pXFqZpsWTACu1u0ZaIJgew==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxtvl+fWowftqOSL8zsHyBeL2O0Y8gXQzvFHW48U/32yTUaxwm
	hSJsk3aiyvN9dMoXx7T50mebEuaWVEyOf7ClNbeoEYatDWXR94LzK+V4
X-Gm-Gg: ATEYQzzi8C4tJmiogajfmpCqW7kOr2x6v0qXQmgfs6vRsHFnkAg58riyDn1Ctmnp07O
	ut+0uepXOmrBmHrj2mJGUKBjzosg7lb+qO0cEHnI14KmurksYn+hGq+WSo4PD+nFAWT8ALi7NOV
	CnpGCHwVU2nAPPLRe25FEOdT4r5qgXEznGLUpueJhh6yadS5ywa58jH2e854WUF1UNAYojLEU2q
	CxRU3UYDbWvL/lM3+UDoHGpdDGS1Q7eOE+4soFSczTAJB1NZHx/Y4CPhGiJ+fkJKzSBPglvgjlX
	UlM7rCxArZiziBIPd4kOx0YunM3ftiJ3kTcf55vPYU13otcKB0W+SwBrxku/OtaedaHEUzec8+u
	i6T+ekz4z+c2qirKCjvh6VtndIVwPLafMNbCezEf3peAusgXqrRVqsYUZy0ILXPWgfl35A0MR4h
	3l+IZXxplWNgFmp0wJm0jUU7AIcg==
X-Received: by 2002:a05:622a:199f:b0:506:6ec8:835 with SMTP id d75a77b69052e-508db397445mr5851551cf.54.1772588712615;
        Tue, 03 Mar 2026 17:45:12 -0800 (PST)
Received: from localhost ([184.144.58.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf73451csm1542159585a.47.2026.03.03.17.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 17:45:12 -0800 (PST)
From: Richard Acayan <mailingradian@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH v2 1/3] dt-bindings: thermal: tsens: add SDM670 compatible
Date: Tue,  3 Mar 2026 20:45:28 -0500
Message-ID: <20260304014530.27775-2-mailingradian@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304014530.27775-1-mailingradian@gmail.com>
References: <20260304014530.27775-1-mailingradian@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BB4401F9A3F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43533-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,intel.com,arm.com,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mailingradian@gmail.com,linux-pm@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Add the compatible for the thermal sensors on the SDM670.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 3c5256b0cd9f..6c84f22ae322 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -71,6 +71,7 @@ properties:
               - qcom,sc8180x-tsens
               - qcom,sc8280xp-tsens
               - qcom,sdm630-tsens
+              - qcom,sdm670-tsens
               - qcom,sdm845-tsens
               - qcom,sm6115-tsens
               - qcom,sm6350-tsens
-- 
2.53.0


