Return-Path: <linux-pm+bounces-43534-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBCuI3yPp2lKiQAAu9opvQ
	(envelope-from <linux-pm+bounces-43534-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 02:48:44 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C16F1F9AA3
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 02:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8F7B30F7FD8
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 01:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84D131AA94;
	Wed,  4 Mar 2026 01:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxnlTdjf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B9B31987D
	for <linux-pm@vger.kernel.org>; Wed,  4 Mar 2026 01:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772588726; cv=none; b=ElA3EwdDpFI7wuxMJ1h9I65aik11xP3y5oGHj3d0l4KY7UhEVB/DESP/t428wWc1bOTvrlZ2whVld2yT2S9joN2vtxIy/MD1tGkK/vVLPmuU/W42B/gvS91BNI8kLqGYZ6wBH+JNp5I5WwDbD8FBw+RoTny/mDcm+ailIfL3sGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772588726; c=relaxed/simple;
	bh=YKU/DnmNIxKk/G4FaBPJrYaaIFx5k+4NkZwdBNpIKdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZIf9Eu/Aa8gX28N6Pbda01AyK5mN9GOq0Ppv0N452XbAmxjGU0YsjJpa18v+1YLPDUoH6Vq42g+rd0MzJSpaOfSRD1poK+pGxbes2nZYML6ZAmK3uS31lJV7Nco475I6GFNDOxZGWx2waIZs+aH1VoqK4OORZp/gJlzytJCxD9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxnlTdjf; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-899fb030812so37996236d6.2
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2026 17:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772588725; x=1773193525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMK0diFp+y5MtkQk4eP+T+xRtrAK1MN5VxTGJH3Ujrk=;
        b=IxnlTdjfx3GFqP9x79r146KPdFjfbwImXoEht5zDWJWsM1YUxpU9K08ZgyVYHHmCQd
         9AYn2MFh+vi2xtngV0TK8DD0Gtkzdlomviu6Dn9zi744RkEl+Vg+Z8KkWcNHM61h/Chl
         B1M7Dz9gA1D7gt1hhxV7uDG2rnxy47IjAu2wmpv/H3F+aWFJKRgUKCv/hcr+Z6xRNI88
         TYFsiJLIT+V4e665PgGnRTR8/XZdvLosVoi25T7sNIvJoS6c4CR8fx1NIndSu7efRxVd
         vnDJQWpXWqG+z78FhS1BAA93BFn27t24xKBYSDdEbvMdfG358UshtuAY83a2nbaMt7PN
         QQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772588725; x=1773193525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fMK0diFp+y5MtkQk4eP+T+xRtrAK1MN5VxTGJH3Ujrk=;
        b=rulFKABOBnFm5al4EeJcyYM4xAaxCIaJKjQXWC3P14nuA9ULidUhKx8m6ZJK8g3XTt
         4eWSamqoa/JJ8A7z3DW0P4FwxZmd+0wgr7bXe4Lt7duesSDz60oyj6qs87+mJtcV7jQi
         9yrrp2MeE1k7WTNMzNRoZbe34qRnj19B8Ru+eatPoL2GvYCmSpXBrv2jL5rOgxPTq8yI
         qqjX8uIPzCZ26nZI+UBOm24X1LwpvwT4WkWey46tYJZsk2NUg32sZi510MDKt0l9UeTD
         aGu+3vPjxzJEdcvzUflIK3666vKy6qyeohtHuBBFVUNK+AKFIevRhJO9erNiDcZxo5em
         NSfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCSx7aCP9tUn7MGSIxXph/ezwC0ePBScvS9npbIDQLHkrAMQhP0exyCWSgbO1U+cA2G4k+AlqGpg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBeZu89SWy00nHWJlpSBsdeVWBc4mbmqzcO3tne1iti7uuojDR
	2zarQukExMXAe2Et1rjvHJ/DcMmOg8n3py0CemPNkQbp7hnCy5uVZU0M
X-Gm-Gg: ATEYQzyq6oSUrkQhPRPTojySUHcKAOfxM8TkQ+MTaWUh4Q34ESo31vDGT+9qJdlXq+z
	d9JG7irYIyePd08s5EPta14sT6j84rdLO3tIoKXbEF6tARG4wFCfYBVQoiiIhkCNXrBrBYs9w8j
	9LiaVGXrVORl3OW61LSIzWtC7sUq0l/6N3xu2CEYeiuxeIzuvQ3kIaG+HZHriOBCvbSkBZhSl/d
	vbkpLBCL6XsmCemcD8M89VkMuCiEKKUfMGbP/Ng6nsYRF4bES92MX47R6Y6qGKzYWtdCnQvOMrp
	xtj0dl8ti6fZ7EjDu1wtvW/mWUIQQruRzNSu4UyECBV8bR0Kfee2K7LAvjgOKj2G16Y3Im4Y7uv
	2AKQN38Jq2fVRA5vYSSB8eh/pTFG8IidUwoszp82erouOj8C9FsuC4S/+uxb7vI3q7Uw0QQxpx3
	0y1JaOSEM+1tjOW16gz4lklyl+r4EvrihKpjhZ
X-Received: by 2002:a05:622a:14cf:b0:502:9e4c:2670 with SMTP id d75a77b69052e-508db2ed117mr5799891cf.27.1772588724614;
        Tue, 03 Mar 2026 17:45:24 -0800 (PST)
Received: from localhost ([184.144.58.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c7374e07sm145443306d6.33.2026.03.03.17.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 17:45:24 -0800 (PST)
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
Subject: [PATCH v2 2/3] dt-bindings: thermal: lmh: Add SDM670 compatible
Date: Tue,  3 Mar 2026 20:45:29 -0500
Message-ID: <20260304014530.27775-3-mailingradian@gmail.com>
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
X-Rspamd-Queue-Id: 3C16F1F9AA3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43534-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Document the SDM670 LMh.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
---
 Documentation/devicetree/bindings/thermal/qcom-lmh.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml b/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
index 1175bb358382..ce72347e29d1 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
@@ -22,6 +22,9 @@ properties:
           - qcom,sc8180x-lmh
           - qcom,sdm845-lmh
           - qcom,sm8150-lmh
+      - items:
+          - const: qcom,sdm670-lmh
+          - const: qcom,sdm845-lmh
       - items:
           - const: qcom,qcm2290-lmh
           - const: qcom,sm8150-lmh
-- 
2.53.0


