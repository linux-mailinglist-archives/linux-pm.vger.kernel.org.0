Return-Path: <linux-pm+bounces-41782-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NCqJ/W1fGm7OQIAu9opvQ
	(envelope-from <linux-pm+bounces-41782-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 14:45:25 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5B0BB4D0
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 14:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6E4DA3015BB5
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 13:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DD330EF8F;
	Fri, 30 Jan 2026 13:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blZoQbm1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A4C3093CF
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 13:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769780442; cv=none; b=DEnHViOMzYsElhpyCmmTffxsjh+WlYvgWNwN+fgM2yVKUqyAvNbjLQgIVjSBUEHdtDNW50Gm9IL03MuV4M+uOQJhGUVGCAUTdfAEgT9pXOuufjqJ+yevdQJlNLvrE75BOYhYSojuoQzmfsk9as9vCAKgHEkcd72d/2uzQ2cWaqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769780442; c=relaxed/simple;
	bh=95iIyzopFkQ9D9uWqLqTERrAIhio7k7WYfD1g3owJoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cGd2MkC/KslnI35kgdBJ/eoojB+ZCCgZybjJawKzN0FuKIDodE+kN1FhBTwTtErQcv+8RkI0LBA7ghpVK5bu+vB1WmIs6tuinO88x/nZMENU4ZwEWE61ibJp3qDwrio7zB37mcdKeZlO4Nv8qqL5LEE7SuoZnusAQhO75eTgKOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blZoQbm1; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-48039fdc8aeso12801805e9.3
        for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 05:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769780440; x=1770385240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32vh1XyNdNiMvWqowSj9FrbYVVxs5wH5KyB1e47QLpA=;
        b=blZoQbm1TGnULKAvX7Dt5nuA4UhwXpAbj/oSkSN/YzqSYHtxdgDspU5rX9/y3iXM2p
         N2S9cHYz9ixV5IzAbx+I7bZkoL+tBGbhL/U5Zl9j1nqOsOF5Cuu5JDk8Emnf0Dfn/TY/
         5YvkF0lca4vm5Q4Bi3kkShPX2rlwfdsFwX8kNaP8mrASjwbzTN9yQjcvFP6fe9zp7x6h
         G5QlPCWxvbsoWccwIKv7l+VPZ6taHAEgwnR3MWa2jGG4ce+p1K8MBFrTcsqgnaQDX2/w
         Q+lvLBYWVPzdtD+yIwOlSfbX1f+/pOjliIBt+HD5K19qWbcZlbOd5Za4rqB+xt44d3y3
         eF/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769780440; x=1770385240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=32vh1XyNdNiMvWqowSj9FrbYVVxs5wH5KyB1e47QLpA=;
        b=jKPJFqHWZY7dYwmskZ4GCNkwQdHj0ZqEziraYby/G81N3MlyS70hKmTDcNRifmE2fL
         7OdtxdvuVfHFue29RL8O5O6qunqi0HZKIlFHU/AOHmf4Ca8PQystyiyWgh/qNfF7aNgK
         7Q7sFBrmLTNnhuGRFYNu9Gl9WkFWoxMaXIU/7Fobb2RqtgT4NUGnfPjEEAvrVyPkRjk9
         UJmAmkMP5R8Iw7dJfL9Bu8clH817jd0ELfsoNv2PdA4JHRlgj/4GmEdqALrfR3lH30Yg
         5UpnRij+rijEYvs5oAEcuYFMWGsfesnkj8jmvKhR5NYHLVrhck7mOZ3jFGQnSZOtJgaf
         tc4w==
X-Gm-Message-State: AOJu0YxHbTOg0DqlFBK6w0K/rvzjD6GRKbFoXZRfqbhcun01RG299pMN
	CFoI0CIqsUC6j4fPgmPCokTFZDqR6gMzEuLa2KMA+s6t1RV4Ck3d0BRv
X-Gm-Gg: AZuq6aKjLu3z44RhIH8zV5gkZnp1N4kDrwpBRn/g+ev/L7IIs4bg1LBhkele5IgAax9
	dXSI66usW7wSL+znWD4+lRfiohyvv3FE3JtylAmVd6DuX7iKOTuFioM+ucZtsU+825cghirFTz5
	EAK6Q5hz9EMcr007WQgApqE8/hjJWoCzsgHb5ru7a7VKQYGf9XxmlCZs50xb3zG1UwzGI7E6pjU
	ZnA1sf8A8YQ13q865jJTRR2zmAk51X+J1tmSD6ILZs3XsaVT62mYMd3GPE7aaMkOsC1Cvekl3jh
	eSqyY0hCeT//2VXPooz+nLOMqWSxp36wrdmxdIQO3F2SrpOzxsoTOBTuaRg12lqfLbaGbedlH7f
	O+9U+W9BFAOSNKPpunCRstiqPKcRoLH+5CWLmqh3l/OXTbVCsS/XELI7F3vEoywzXs95MFPdIux
	iE
X-Received: by 2002:a05:600c:5289:b0:477:abea:9028 with SMTP id 5b1f17b1804b1-482db44931bmr44744325e9.6.1769780439546;
        Fri, 30 Jan 2026 05:40:39 -0800 (PST)
Received: from xeon ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cd8fadfsm199106075e9.0.2026.01.30.05.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 05:40:39 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] dt-bindings: power: supply: cpcap-battery: document monitored-battery property
Date: Fri, 30 Jan 2026 15:40:20 +0200
Message-ID: <20260130134021.353688-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130134021.353688-1-clamor95@gmail.com>
References: <20260130134021.353688-1-clamor95@gmail.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,atomide.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41782-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clamor95@gmail.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5D5B0BB4D0
X-Rspamd-Action: no action

Document monitored-battery used to describe static battery cell properties.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../devicetree/bindings/power/supply/cpcap-battery.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/supply/cpcap-battery.yaml b/Documentation/devicetree/bindings/power/supply/cpcap-battery.yaml
index 694bfdb5815c..6dcca55d6d90 100644
--- a/Documentation/devicetree/bindings/power/supply/cpcap-battery.yaml
+++ b/Documentation/devicetree/bindings/power/supply/cpcap-battery.yaml
@@ -55,6 +55,7 @@ properties:
       - const: chg_isense
       - const: batti
 
+  monitored-battery: true
   power-supplies: true
 
 required:
-- 
2.51.0


