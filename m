Return-Path: <linux-pm+bounces-3792-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57209851580
	for <lists+linux-pm@lfdr.de>; Mon, 12 Feb 2024 14:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12251287456
	for <lists+linux-pm@lfdr.de>; Mon, 12 Feb 2024 13:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400863B2A1;
	Mon, 12 Feb 2024 13:33:29 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from host1.jankratochvil.net (vps2.jankratochvil.net [31.31.79.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53733CF5C;
	Mon, 12 Feb 2024 13:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.31.79.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707744809; cv=none; b=EMpoHdaP6ZDp7OuijbL/xacnhcaWBjVgo4KMIdJElOsmjK8h7JQujuv0li7VhwV+0M0/2NJDn3lOt7vFIV8pFanuujk6BKBOr6a/n27sknAh0E/uYCitO0VI9y9IqjgrMWt+EoOys+siJyDJsQaOoahgXUEYPoyLtPr4rcO9Sb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707744809; c=relaxed/simple;
	bh=mbMvS2i6KjPk7tDz75036G5x2zXpGKPhcwrkeS/fNg0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cI2uikjTWVFmjymwDNmMQiQq+8YCYM3Jdnj291BBi0ecM57DNaE1JbaL5GXFFwqGCmmM6/qdpLSBk4FDottFJBEuBG15jg3F1WZzoEQXZmGjjFgP00j+aWtDxuSk1FF2FnjzeO0LvttiF8XMcpHMSb5AHzQY9fIjTcR/oRBp5vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jankratochvil.net; spf=pass smtp.mailfrom=jankratochvil.net; arc=none smtp.client-ip=31.31.79.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jankratochvil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jankratochvil.net
Received: from host1.jankratochvil.net (localhost [127.0.0.1])
	by host1.jankratochvil.net (8.17.1/8.17.1) with ESMTPS id 41CDWuTv341755
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 14:32:56 +0100
Received: (from lace@localhost)
	by host1.jankratochvil.net (8.17.1/8.17.1/Submit) id 41CDWuwZ341421;
	Mon, 12 Feb 2024 21:32:56 +0800
Date: Mon, 12 Feb 2024 21:32:56 +0800
From: Jan Kratochvil <jan@jankratochvil.net>
To: linux-kernel@vger.kernel.org, trivial@kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH] Fix cpupower-frequency-info.1 man page typo
Message-ID: <ZcoeCAbRHKeH-HCb@host1.jankratochvil.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.2.12 (2023-09-09)

Hello,

utils/cpufreq-info.c
        {"related-cpus",  no_argument,   NULL,   'r'},
        {"affected-cpus", no_argument,   NULL,   'a'},

Jan Kratochvil

Signed-off-by: Jan Kratochvil <jan@jankratochvil.net>

 tools/power/cpupower/man/cpupower-frequency-info.1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/man/cpupower-frequency-info.1 b/tools/power/cpupower/man/cpupower-frequency-info.1
index dd545b499..47fdd7218 100644
--- a/tools/power/cpupower/man/cpupower-frequency-info.1
+++ b/tools/power/cpupower/man/cpupower-frequency-info.1
@@ -32,7 +32,7 @@ Gets the currently used cpufreq policy.
 \fB\-g\fR \fB\-\-governors\fR
 Determines available cpufreq governors.
 .TP  
-\fB\-a\fR \fB\-\-related\-cpus\fR
+\fB\-r\fR \fB\-\-related\-cpus\fR
 Determines which CPUs run at the same hardware frequency.
 .TP  
 \fB\-a\fR \fB\-\-affected\-cpus\fR

