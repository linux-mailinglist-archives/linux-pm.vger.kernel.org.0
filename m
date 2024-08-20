Return-Path: <linux-pm+bounces-12543-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 977B695812C
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 10:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA7031C22176
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 08:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503E618A93A;
	Tue, 20 Aug 2024 08:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R0iM8Bl3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6152C18A6C2
	for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 08:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724143303; cv=none; b=N1POKEnU0EhU/ZFaf7jtK1vFmFtCJZkAW76EcuElkQeSqeBxaD0tFqkbcT6j13jWBxNVFQBDTsyV4UI7cNtgsWzMmuOgrKpJogBcFSZquWZd8MfBQW+QfVpIo7uOqOhMH96hP77ZO2Is4XNzHqxaEVdK6GJ06XcW2uCjA2SKPP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724143303; c=relaxed/simple;
	bh=5N0nCpfI+nhaOWK3OttM8gAvu11x+K2UOJAXcQngNTY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TiGLLJoXlfjv+T44wX9zMD0M+gEYPMPWS21QxXa5inbHdAUQt+o6Kkjghum/9YNtQozpyDf+Qax4TPW4tMUQnxLnZBd2reKie0r/qz1eVbB48H6JPQnhnpbRD0bnphfOKzGbiPZ5HYZPvEE9LCQO00gyvNueIc/mwoaHCPsX7H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R0iM8Bl3; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7abe5aa9d5so560264866b.1
        for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 01:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724143299; x=1724748099; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UWAdMcy/9NR2ReZJmKOUCazwYMQpggfHiZptQK0YIT0=;
        b=R0iM8Bl3McqDIFGmosSr6kZxYcvG7PLG2u35SOxIo3ClI8TzujyHo2VnhbuFG/PsK8
         CJxdkG0Gk3tr7T8nJmn8HiE2Xi/izsT8hGsftcLbHTcnMhZgUPNNz9YVKxa4SQN+ymus
         JnmDT3erjxdzxJAFyWdNpyegD86dCXLj3fwoajz83mwewLA/NKBhXXBxKGxKLzIZO1v/
         X2Xf53PF+tGXe1HA9Ro7xeMdbiRB25GXcQhGPTYdDNXXJYQOLnwF2sqMuucarhT+XjfI
         3HLt4zR7rcVRCtLfK69Td+5+YEZIAiIuB9IcfweW9vQmOxDotIpqtmOBI6EW0T68Qflz
         QNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724143299; x=1724748099;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UWAdMcy/9NR2ReZJmKOUCazwYMQpggfHiZptQK0YIT0=;
        b=bUkY9yfOXqHBWE8rYarTPv0qWkPfakaD94uyQ+3bYxoMl+2Mph7DHmCapvey/3bVHI
         trmQy35QjT224NoLIIparLg6vFvWQmLhwiGsI/kkFl26cJlHgfqXaJel9cqPFM73fpVQ
         XbR46iwTrQz3/IY2YGPpUwjwvcppb5IkVu7Ho/wOzxHjR60ybdi/rLQ1Vc16oprOZLTJ
         E9y0UcW2mL1ySCQXGch6OTDoy9z8Z48SrsPKC/9h0nuWqcTXuGFt2Xgwns8dIpvIe1ow
         dcY+QcxsDYcwzCz+iZwBcBTF31BNUdunqLf5wVPDMFQjLCCfPdaF1v19tCB+TwAXyQbc
         z9hA==
X-Forwarded-Encrypted: i=1; AJvYcCW3C7OBF7RT/u3+OA5tU1mAb41GkJxS2ICAQaQzBXfi8+dbLPrbSHJxOgCWu1mN6QGS9gfqzr7VWg==@vger.kernel.org
X-Gm-Message-State: AOJu0YySbA1Syzi0FTxNPXA08fvPp+gzlSfEdKzZQuReOeSco/+Bu8dB
	vcEuDMdaOs62mN7G16OJe5JeOlu74hXb03QMzJQK2pBuAwo3dcXYlL3Y+tqtZT4=
X-Google-Smtp-Source: AGHT+IFnTZZhFh0VCiwtDwh6MDqi/R4yLEzQF1vj4INSiVJzn84a9KH3cF4dzK2xWm1zg8MzWtyOCA==
X-Received: by 2002:a17:907:e22a:b0:a7d:391f:17af with SMTP id a640c23a62f3a-a83929d3755mr994995066b.51.1724143298645;
        Tue, 20 Aug 2024 01:41:38 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838394880esm729365066b.185.2024.08.20.01.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 01:41:38 -0700 (PDT)
Date: Tue, 20 Aug 2024 11:41:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Zhang Rui <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] powercap: intel_rapl: Fix off by one in get_rpi()
Message-ID: <86e3a059-504d-4795-a5ea-4a653f3b41f8@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The rp->priv->rpi array is either rpi_msr or rpi_tpmi which have
NR_RAPL_PRIMITIVES number of elements.  Thus the > needs to be >=
to prevent an off by one access.

Fixes: 98ff639a7289 ("powercap: intel_rapl: Support per Interface primitive information")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/powercap/intel_rapl_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 8b7a5a31e8c1..67aec73511a7 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -740,7 +740,7 @@ static struct rapl_primitive_info *get_rpi(struct rapl_package *rp, int prim)
 {
 	struct rapl_primitive_info *rpi = rp->priv->rpi;
 
-	if (prim < 0 || prim > NR_RAPL_PRIMITIVES || !rpi)
+	if (prim < 0 || prim >= NR_RAPL_PRIMITIVES || !rpi)
 		return NULL;
 
 	return &rpi[prim];
-- 
2.43.0


