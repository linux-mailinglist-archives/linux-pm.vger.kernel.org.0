Return-Path: <linux-pm+bounces-7781-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 115208C47BE
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 21:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 426131C2309A
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2024 19:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796CE77106;
	Mon, 13 May 2024 19:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQosSUwA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA5078C9B
	for <linux-pm@vger.kernel.org>; Mon, 13 May 2024 19:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715629282; cv=none; b=Xx6RrQGhuIrh5XKWpq/mT0biZyLqVPpXM1d6MDfq54pJeDuwTtkQ0tw1JmSEmlkdOGnTHVhWy2JS7mBBhJG26P3XRBFpWg3rTz24kRwGx82CQr3+y4XY3Pu3i9gCxs4MN0fx8UPPrbtuv/P3O8zfNYpjeDJGJpKSEvtjOlMo0go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715629282; c=relaxed/simple;
	bh=eyybGurvXPKOdgEHelbizngpeXLU1f6uuOGJVZrulF0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TegUqrUqc9Z6MV5I610G5olwZjXJQ9HI2+oD2kO3lkWgiM1iRf9l82gD1TwDORf145omvCsTtTHkFv5MgpK/UztEUAlQy+wtd8wrSQNkZMNl2X50AGknvz7H86B9S9fltln4r3ojndWSiBr5fiFKckB+t5I9vXTXDZnND1THweU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQosSUwA; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-61b4cbb8834so47775947b3.0
        for <linux-pm@vger.kernel.org>; Mon, 13 May 2024 12:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715629280; x=1716234080; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=38jqqlJZVvGGUbdoNrB7K+2/3DOfDJmmPNESSEmSYg4=;
        b=DQosSUwA0fSdpcN90kv3CB5hb2R8yBlj7FKkPIcm+tTr2N34gugrGWrWQQ6/oVQo5b
         GwwBUgP28RphRVmZJS7GwIFm1iChjzdvv+sEHul1b1gpIn3aqpq3rtMj4f1JpeG6Z+1c
         n2dEtQoXVi7RCd8+0kDK/JoDAdTsIzCPZMoVqnP3GetfznQ6SuOig5hmgfOg3a+2ITNr
         OtPhiQ+A2Pg7ae03GP+29xI9fLUqyjITxEzTipLleX74DC41Y1eNEKiyhG/+eQjz7NL/
         UPVS5vilFH07joJTOE5hOqeUK1Sj3Z6Hf00u2QlZYRJ0WshjuwC5Ii8xLr+Cvk+p2kdV
         ZCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715629280; x=1716234080;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=38jqqlJZVvGGUbdoNrB7K+2/3DOfDJmmPNESSEmSYg4=;
        b=wEZl/yuMMn1krFislZauABpuO7BScdM7lagX2M4Pr0iE/bfSDMOPalOC2RtXSk68vm
         7WRpPJHgaXGUCwTb8eUhDdNvkpHjnQufBjKIGfmLfi0j+4XuKzLE7P012LkLBze8ABlu
         F+JVi6CYOlNkcKwiPI4XBS3ZC+fmY1KAze8+fO4fGZ7ZOW9rj/6BzAZr8UlU0Ba6ONCc
         jQvyYiVZnMRmeIjDoR8YSjru9ApmQQLWhZv2P/QxsvszYMdmzuRkVtxsfIQPg5vI0wji
         Eeo0iiQgd10wWuRqGm4iRBWHILIAzTuITjXHZk7zGEZqhXoQk2iynMHcQD01Vc/5/YFg
         wW8Q==
X-Gm-Message-State: AOJu0Yw1OtZb/J7lkbM1EYsSnV0fJoUQH4dTGn97z/nIEbehtaqvX99z
	p69cIkobSw8T5IpSS2tcnDAo2w6kIcO5vciahzVkgDnMubhRM/7vgxwj+Q==
X-Google-Smtp-Source: AGHT+IFnj7nNYv1se8ontbmPyBH5tL6LjY+7tIfwhoTNQ2IA8aMArIhfAb0SDRVM/yK3pnWuKebVYQ==
X-Received: by 2002:a05:690c:6408:b0:618:8a27:6150 with SMTP id 00721157ae682-622affc0e4cmr116401687b3.24.1715629279777;
        Mon, 13 May 2024 12:41:19 -0700 (PDT)
Received: from lenb-Intel-NUC8i7HVKVA.search.charter.net ([2600:6c60:4a00:22d:edc9:ad0e:d214:6024])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e26fc1csm22266417b3.71.2024.05.13.12.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 12:41:19 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 13/15] tools/power turbostat: Fix order of strings in pkg_cstate_limit_strings
Date: Mon, 13 May 2024 15:40:49 -0400
Message-Id: <a0525800e2dc9fe03968a632ae2d145ed36f35b4.1715628187.git.len.brown@intel.com>
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

From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>

Change the order so that it matches the indexes defined in:

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 1ae13e30a366..0369df4f1078 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4013,7 +4013,7 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 }
 
 int pkg_cstate_limit = PCLUKN;
-char *pkg_cstate_limit_strings[] = { "reserved", "unknown", "pc0", "pc1", "pc2",
+char *pkg_cstate_limit_strings[] = { "unknown", "reserved", "pc0", "pc1", "pc2",
 	"pc3", "pc4", "pc6", "pc6n", "pc6r", "pc7", "pc7s", "pc8", "pc9", "pc10", "unlimited"
 };
 
-- 
2.40.1


