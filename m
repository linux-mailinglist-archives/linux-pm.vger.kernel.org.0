Return-Path: <linux-pm+bounces-7775-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D395F8C47B8
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 21:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 113171C21534
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 19:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070FB75813;
	Mon, 13 May 2024 19:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTZ6b88x"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763E076C61
	for <linux-pm@vger.kernel.org>; Mon, 13 May 2024 19:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715629275; cv=none; b=H73YVnaykiTVscx9hLaZXXWBxv0d6PkC6rK47TjWD6r30OuviRMR47JdyorABSKdRYTFuJouUA2TPyn8x8tljLokuub/6BUOhtfcy8ztwxJYm7pmo8NsKcaNvte2+x+xrpPdqtqsVG9DnuS92iFqPFoGi6yt/be+3M8jOnvRtTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715629275; c=relaxed/simple;
	bh=/56kRW7iugO46N3DzDvaEg5nOAtaRmJcotbBhk4f6T4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FAFYe5+nx1jWAhDonI/AFLW9t3Oq5JpcuolnUjwKwRqkEk9My4z5jOXsLjEoJM8ZYg2xZScuNmdIhOVF8HDCHQ2+fVxu32PVN1UrsY1AO54mM/gJT+KZIEFWkQx/rfltgHGkAVBElSQXDw8jANn+f2TB8Y5g36/sKInx6RNE/RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTZ6b88x; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-62050e00cfdso41619387b3.3
        for <linux-pm@vger.kernel.org>; Mon, 13 May 2024 12:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715629273; x=1716234073; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jlHa5xnuk4u4JJnbLwjp+C75jgoCJBeVSx+OyMaYG/E=;
        b=BTZ6b88xZw+p9hSOgb719IgfGzueWSeKHAmoaV+GODd2Za6yg5Vsy04rDE7FvuA6Rt
         5w0Cl6Fs+LXpjYiJAvj2sg63NH6j49MmOiQSzzXgIpgR7WZcycyEwnEKpJrv9nD3FSc0
         6Hrocs1YUhlfFKzDoG7fCzRqYink2O/VXyndiRpNj/intJRi9qIkUvV7EIEQu4jkoYiy
         HNKRYNV0ZtQe40zHNMEWgSr63g1rq5LNkZPhbHVH8oypi6SGqvhamdVBFmYo7MThUvet
         l7rg43jZORf977yBccwiNJYB/qPrAPU2dHZYTtClcHJoiIkPVCGpzAPacX+mvgkiSlTX
         kCgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715629273; x=1716234073;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jlHa5xnuk4u4JJnbLwjp+C75jgoCJBeVSx+OyMaYG/E=;
        b=olo7edehsJXjSdBFAqG5ulKNrfG92eOmg7rIX+8CdpS3sFdjpYuk6PbdBWtzLN+FcV
         ng5xD9d4jpmPCSiYyJqXWAeiEkgajr3G4H6ijpymiL6wUzNFpzdZ+K8rbwA5P31RFSe/
         rpKa6lElm5zpL/wGCy2f94uqwW2uaRVjoZT6tDO82MGH8ECkN0dL2Vx0yIekNEmS3iZU
         Zx+go1+3lpa+xBv8ufT6Z1TkdCaX6oNosNOT2FAl3TrxYrbaGp3u+eRMWEKjqAhJd/Jn
         M0Nl8eD2Q7hNyNrz+P49hB0rz6dAsPi/T5OMdnXkjxOSAIR2W4qcQZeXvB/6WG8hfuHY
         AabQ==
X-Gm-Message-State: AOJu0YyEkMBAR+T2s4I1yc9JuawYx0pXnOpodPYW7gn/55gPWSyrvPfN
	c8uRdHqVUAFRdiYxjh/v9SgK05IOkXxLuY5erVBAsCaeq2x9/EYh9aE84A==
X-Google-Smtp-Source: AGHT+IEsnsnDK32pw0z2jo774YS6rxgRVETtsw+VvlmGnwMzUJf0tdfZ47CB85kJOk7D28ep4+KqxQ==
X-Received: by 2002:a05:690c:f83:b0:61b:3356:d16d with SMTP id 00721157ae682-622aff902aemr115948547b3.19.1715629273320;
        Mon, 13 May 2024 12:41:13 -0700 (PDT)
Received: from lenb-Intel-NUC8i7HVKVA.search.charter.net ([2600:6c60:4a00:22d:edc9:ad0e:d214:6024])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e26fc1csm22266417b3.71.2024.05.13.12.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 12:41:13 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 06/15] tools/power turbostat: Add ARL-H support
Date: Mon, 13 May 2024 15:40:42 -0400
Message-Id: <f04fcc7ac8ceb87933244cca28759d0fac6103ce.1715628187.git.len.brown@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <231ce08b662a58d4392da998699b3d4a7e2e87cf.1715628187.git.len.brown@intel.com>
References: <231ce08b662a58d4392da998699b3d4a7e2e87cf.1715628187.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Zhang Rui <rui.zhang@intel.com>

Add turbostat support for ARL-H, which behaves the same as ARL.

[lenb: also add ARL-U]

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 672936015b55..fadf96934f4e 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -922,6 +922,8 @@ static const struct platform_data turbostat_pdata[] = {
 	{ INTEL_FAM6_RAPTORLAKE_S, &adl_features },
 	{ INTEL_FAM6_METEORLAKE, &cnl_features },
 	{ INTEL_FAM6_METEORLAKE_L, &cnl_features },
+	{ INTEL_FAM6_ARROWLAKE_H, &arl_features },
+	{ INTEL_FAM6_ARROWLAKE_U, &arl_features },
 	{ INTEL_FAM6_ARROWLAKE, &arl_features },
 	{ INTEL_FAM6_LUNARLAKE_M, &arl_features },
 	{ INTEL_FAM6_ATOM_SILVERMONT, &slv_features },
-- 
2.40.1


