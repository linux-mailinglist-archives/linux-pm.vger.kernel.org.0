Return-Path: <linux-pm+bounces-13642-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF8396CC88
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 04:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D5721C22994
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 02:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8FE136E0E;
	Thu,  5 Sep 2024 02:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R6n5+1rV"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF91B12C81F
	for <linux-pm@vger.kernel.org>; Thu,  5 Sep 2024 02:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725502780; cv=none; b=A70flFrjOaNwVRDRazGBnrvzFLrtiW8c8yGQkjP7Wua/l22EAUPWuwg5DnfiDASP4ORDzjKMwAacnChBgv+S/91ATjOCcoYVPDKvGiOjsXrF/zRtHBeD0jEAGkh9CWb3MXVnF+fQDz3xZ8F92SGCrHysw/RiotWWhhoR4qJb0OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725502780; c=relaxed/simple;
	bh=6rt/Ua2bCTlaRDGfKmgzk1tmRKl373FsbSHmxOuv2Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nZ8mOATIQ52J3wwkqrJL2/kn2TKmz8cXv1FnWCn7RL034H9Yio93Mv2xmi49L7LAN6nyA+P1lNjJ3UTEuSZi2XSh+CLJ8ARclHltxfuyrgqUs0W/lNTK1gt4DP4ySO9KOoN3ArwRJF4hNX3y4qWfRuXnvZnWzQMjWzw2QxdvA50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R6n5+1rV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725502777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0EKP/9IUn+VeZzi5LY6w0YXTYw3bCOdthXlaT1zlipg=;
	b=R6n5+1rVRB9tDsRCr+ZzYDgqpP5eARP9Y+jj3mlte9a5GT3EHftn9cGtATXnzYsfikHKmY
	Rxjri0vRgyKh0wgVJy9fBTh3W8BwxeM/p01FPKc42wWQFiq62bQzC8lRCl3IX15hsTDxh3
	EbDJ/x7K3QgqezFr0pww1TULC8lGpM4=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-b7wOwxNJPUSqJWMkZI-quQ-1; Wed, 04 Sep 2024 22:19:36 -0400
X-MC-Unique: b7wOwxNJPUSqJWMkZI-quQ-1
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-4fcf8ce00f5so106340e0c.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Sep 2024 19:19:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725502776; x=1726107576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0EKP/9IUn+VeZzi5LY6w0YXTYw3bCOdthXlaT1zlipg=;
        b=WDYGAwMsIQ8FA19oNxW4zVTqbfnQiK6Wx1IS7yVlJtADrGH93bcwD2vgu+Xmg9yJ/7
         /ZjCFMypweU9yabEqEwk12Z8fv9coQo8gedsCo9SgZMutSbXYvLPl8uSlGEK19S66O1i
         RE1rIKehDd8ffxbuZgpNkBWLJnm7cF/Wo/UnOT1p8vzvgf8odjS7BCBTPlI+c0Rb18tH
         1SsryJSe6/jAfjLol+ew/IBXPybe8wvfXzjsAF5L4Go5XFwJ4jlu4oJMJH5Hk1tSsZFS
         XMz3w2aXD1dyjQhznSe4nmOW7bw+OsjJ/J26nSg5u/zEoQrPHZG1MWtzYBrZsHuSP32X
         RE5g==
X-Forwarded-Encrypted: i=1; AJvYcCV1Z615hhr1mSjR04Bp4l0Dnlpakz9dhF5KyrtJoUVE7cDoQoz97LkbRz/WpPXYdSi8WsQnUmRYJA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7EwBFy245+2P2x1XZcqiqQY0qUR7fSlLctPjwoNAaoiAhmj5J
	1FnKFwP9gqGYXRWB8jOORrtKFkBZwZeK/0kWvse/g/G7MInHinBEhueXekb+J6POvN0uuDdw80P
	S++DrDdxmdWTIB14tE94/d+YSQ75iwXo+lCJ6Bir27B+D/JVNWhUE3loZ
X-Received: by 2002:a05:6122:7c9:b0:4f2:f1f1:a9f2 with SMTP id 71dfb90a1353d-4ffe4a7d39dmr25535596e0c.4.1725502776285;
        Wed, 04 Sep 2024 19:19:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZbGFUJCYKiucGl1DslAq9mOBBURUKRyE/cFlJqj1Sd8Nknw5XQxplsW9m1H5Rk+rJ0f31hw==
X-Received: by 2002:a05:6122:7c9:b0:4f2:f1f1:a9f2 with SMTP id 71dfb90a1353d-4ffe4a7d39dmr25535578e0c.4.1725502775894;
        Wed, 04 Sep 2024 19:19:35 -0700 (PDT)
Received: from rhfedora.redhat.com ([71.217.47.229])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45801db22b5sm3531181cf.72.2024.09.04.19.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 19:19:35 -0700 (PDT)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-pm@vger.kernel.org,
	Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Arnaldo Melo <acme@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH v3 1/4] pm:cpupower: Add missing powercap_set_enabled() stub function
Date: Wed,  4 Sep 2024 22:19:08 -0400
Message-ID: <20240905021916.15938-2-jwyatt@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905021916.15938-1-jwyatt@redhat.com>
References: <20240905021916.15938-1-jwyatt@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was a symbol listed in the powercap.h file that was not implemented.
Implement it with a stub return of 0.

Programs like SWIG require that functions that are defined in the
headers be implemented.

Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
---

Changes in v3:
	- Renamed commit header, moved commit to be the first in the
	  patchset as requested by Shuah Khan. Adjusted commit message
	  body to match.
	- Added pm:cpupower prefix to header and Rafael to Cc

Changes in v2:
	- Implemented the function so SWIG will accept the header
	  definition
---
 tools/power/cpupower/lib/powercap.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/power/cpupower/lib/powercap.c b/tools/power/cpupower/lib/powercap.c
index a7a59c6bacda..94a0c69e55ef 100644
--- a/tools/power/cpupower/lib/powercap.c
+++ b/tools/power/cpupower/lib/powercap.c
@@ -77,6 +77,14 @@ int powercap_get_enabled(int *mode)
 	return sysfs_get_enabled(path, mode);
 }
 
+/*
+ * TODO: implement function. Returns dummy 0 for now.
+ */
+int powercap_set_enabled(int mode)
+{
+	return 0;
+}
+
 /*
  * Hardcoded, because rapl is the only powercap implementation
 - * this needs to get more generic if more powercap implementations
-- 
2.46.0


