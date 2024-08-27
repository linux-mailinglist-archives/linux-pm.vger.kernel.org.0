Return-Path: <linux-pm+bounces-12928-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 757EC96018C
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 08:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8DD01C220E4
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 06:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6831494DB;
	Tue, 27 Aug 2024 06:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DcQyWbNt"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02A4143C7E
	for <linux-pm@vger.kernel.org>; Tue, 27 Aug 2024 06:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724739944; cv=none; b=GsViYgL5s1acQh456xIzQMudOhSlr5q0XREZwEr/j66jrrwBzhgWxfuu65X/j4Zpxjcc5zwfHrpKrFwyljGWB+ElEd5k3gAbh5S3cGafMbFtyOrNH13v/ykeSCA1FFcoGQRiiFGJ1i8l5QDgd9RRMxJC+SPD5JBP5GmzScNTdOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724739944; c=relaxed/simple;
	bh=Paierbr3OnV+UMAsLtNyQkn6GQuqyEdNk3kfd9t1Pbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SypZNj5YR0AxfTp7owd51ZDOEyVIw6n6B2SZiWVyfoWxXx2N3RRX8et3hH5HQfolXJp2avg0JV1pan9DF/0v21I++jDpD+uV29rVUX5ek9N6SeWTLV6Vewe/vm94+eKB6PNTgS4A5ngOMz4j+5E6F57ZtBfDg6qco7+NKCYxzeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DcQyWbNt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724739941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KvCt7XxbbMqr/ZTectnTYyzcNnevLnwbiS/dEZsdMoE=;
	b=DcQyWbNtNKlAc3ZUn4Rjt3sqDYFzK1lVTQmhPQeBhO3/aHwF41YIsiy0U3R0t3dkfbirER
	YEQkc2KWZgINuyyMn4PCHAOnsIhaVMyvEwPd1qZpfJDPgHLtPCL0lWewCPECsgv0FkfHcX
	xBoAG34GEorfIzqF3bz9ub/AdKYUIUI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-yqQnMTGXPC2rgLggtaS8OA-1; Tue, 27 Aug 2024 02:25:39 -0400
X-MC-Unique: yqQnMTGXPC2rgLggtaS8OA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7a1d9a712bcso1200700685a.1
        for <linux-pm@vger.kernel.org>; Mon, 26 Aug 2024 23:25:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724739938; x=1725344738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KvCt7XxbbMqr/ZTectnTYyzcNnevLnwbiS/dEZsdMoE=;
        b=iD2uDbO1v6GZ8OCt4kb5rqU1W5R5Wkl3lBvkx78rGNzIXxU7r7Wdm1EQsYJdjGN/qu
         EvnMh+MLFe2kz1xkI3gMKwo5h/BcerMnY5N2MjVOAbDQWDZOHei6GDHaZh+8Inrg0L6J
         H6yTMylxhwiH+eynZCbNrt5biZ9wN+7EVNmcO3T1hbbiLVlI02EwHwTV7O2oO4dfoAIq
         /BrquJuJDNOp0MdbuUPlILxjxVjOjzpZ6oq7tQIOE8np3VPi0J5ui/2EOFH4E4jpem/x
         xPqRQ5M2IqW6VMGu5TAnqpMiIRjyJt2B2KNHRfEpiVSqsnJ8t8+mPansCEHE0X9dKPIh
         Xgnw==
X-Forwarded-Encrypted: i=1; AJvYcCXR6dFusw1Se+N4Q7voLKTI6Q8HormXEsPKl0wMqK8F5iIzXRF9dmY/CA0V6sOO0RdI+tu9G0GFOg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzIuTCslp0BAUUApfm6aDi093VZdkOfSgTRBRBlA6WnxMxq+7a
	4hnHMOWRnMV+/HL1zrxW+L09XIoC3nDO5ZJxVWGfq5JN44UcF2i7PkIMgAKz+HkEn1xpF/X+sRy
	3rDYVNdV5gD0vIgsDJs7jwxRWk+NSayIIhJ8zz23Opm9lTFgnjVeAoRcLrGY9nPfvmbdtyQ==
X-Received: by 2002:a05:620a:19a7:b0:79c:c3d:9c22 with SMTP id af79cd13be357-7a7e4c49e7bmr410980385a.8.1724739938553;
        Mon, 26 Aug 2024 23:25:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOAGCcdImWIfP0W/sHe5KI872sfiULmCGaWHeUiImsKMuTcEl4A00LgBTxnHTb69xUL9c0FQ==
X-Received: by 2002:a05:620a:19a7:b0:79c:c3d:9c22 with SMTP id af79cd13be357-7a7e4c49e7bmr410977685a.8.1724739938189;
        Mon, 26 Aug 2024 23:25:38 -0700 (PDT)
Received: from rhfedora.. ([71.217.43.75])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f1fe176sm521044185a.0.2024.08.26.23.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 23:25:37 -0700 (PDT)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-pm@vger.kernel.org,
	Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Arnaldo Melo <acme@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH v2 2/4] Implement dummy function for SWIG to accept the full library definitions
Date: Tue, 27 Aug 2024 02:24:34 -0400
Message-ID: <20240827062438.71809-3-jwyatt@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827062438.71809-1-jwyatt@redhat.com>
References: <20240827062438.71809-1-jwyatt@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was a symbol listed in the powercap.h file that was not implemented
that caused SWIG to give a symbol not found error, despite not being
used.

As suggested, implement a dummy function that returns 0 so SWIG accepts
the .o files.

Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
---

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
+ * TODO: implement function. Returns 0 for now.
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


