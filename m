Return-Path: <linux-pm+bounces-27484-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9A3AC0468
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 08:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D43B81BA517E
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 06:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A7722170F;
	Thu, 22 May 2025 06:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Xcw8FIDO"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43559221291;
	Thu, 22 May 2025 06:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747894365; cv=none; b=ppu4NyGLrPisDeC9f6yuAfiz/3JsT4FfUWqOAYOfHVeuGdiRonlAO7jZrjHVOr9xyS7ldgGJAhxxgB6W+6N4pTbjHLBFuwYybib16M+0nbVYhxSO1GxMzWxl9EuESpymGiCnKHNjviNBHhpcREDDqC1++fFp8pgAfS6H2KaN9/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747894365; c=relaxed/simple;
	bh=mr/yG+BnV8Mnh9ArXhuG5PDfpkWs668BnsqJ23XMZ/k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iXRpKXJSLeKEhz0ikjfSLjxxJ0YWOuAy7iHCx1s8z03Htj9quAC2Np+Ra9+eo0NwPfgas53f98EV6uV5A4Vq5HDGZc4TWUJgGU8s7lQHN4IFGUpkX6ZbEM6OOLWlJiLmVHrKjLQDEC3SSJzKxwqGkCYh+Tb8zPZ8ZS90/C90hYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Xcw8FIDO; arc=none smtp.client-ip=68.232.139.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1747894363; x=1779430363;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=mr/yG+BnV8Mnh9ArXhuG5PDfpkWs668BnsqJ23XMZ/k=;
  b=Xcw8FIDO0Sy9cFglKK8io7nFQcIBeqqcJoiYGTeQcciqJhNhURHCjYa+
   gXz53uxTeMGkvIppfipYc9VVm+IiFUTwvCJrj6E+sGLcEZ1SZRyosefDp
   5Ruoc+58hAjtbVbbdEP7lL+w5FEo62NtVPC0yNu6MO31VneUqYd8/ohKa
   KJGQw9nPZ053wzEUrnxql6dTlQ+326qN8bJnF6GK7z5YGppORnWbOW9iy
   YM6NOzikxwQiPnHNIa/hsLTovGXfYJLpJvhls3oMvW4C1wPB3VMVfHhI1
   a66Q3uOb1DkHOvuEjTlKPapB31CHVdSsXQelC0kk1hppBYOCa3TOET/hn
   w==;
X-CSE-ConnectionGUID: E47T8syWSlO4D7mo9nsUpw==
X-CSE-MsgGUID: MiY0TADZQAGFjgczC7E5GQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="200688465"
X-IronPort-AV: E=Sophos;i="6.15,305,1739804400"; 
   d="scan'208";a="200688465"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 15:11:31 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id D07C5E8FE0;
	Thu, 22 May 2025 15:11:29 +0900 (JST)
Received: from yto-om3.fujitsu.com (yto-om3.o.css.fujitsu.com [10.128.89.164])
	by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 975DFDA7B0;
	Thu, 22 May 2025 15:11:29 +0900 (JST)
Received: from sm-arm-grace07.ssoft.mng.com (sm-x86-stp01.soft.fujitsu.com [10.124.178.20])
	by yto-om3.fujitsu.com (Postfix) with ESMTP id 237C4400585BB;
	Thu, 22 May 2025 15:11:29 +0900 (JST)
From: Shinji Nomoto <fj5851bi@fujitsu.com>
To: Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Shinji Nomoto <fj5851bi@fujitsu.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] cpupower: Fix a bug where the -t option of the set subcommand was not working.
Date: Thu, 22 May 2025 15:10:58 +0900
Message-ID: <20250522061122.2149188-2-fj5851bi@fujitsu.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250522061122.2149188-1-fj5851bi@fujitsu.com>
References: <20250522061122.2149188-1-fj5851bi@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The set subcommand's -t option is documented as being available for boost
configuration, but it was not actually functioning due to a bug
in the option handling.

Signed-off-by: Shinji Nomoto <fj5851bi@fujitsu.com>
---
 tools/power/cpupower/utils/cpupower-set.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/cpupower/utils/cpupower-set.c b/tools/power/cpupower/utils/cpupower-set.c
index 0677b58374ab..59ace394cf3e 100644
--- a/tools/power/cpupower/utils/cpupower-set.c
+++ b/tools/power/cpupower/utils/cpupower-set.c
@@ -62,8 +62,8 @@ int cmd_set(int argc, char **argv)
 
 	params.params = 0;
 	/* parameter parsing */
-	while ((ret = getopt_long(argc, argv, "b:e:m:",
-						set_opts, NULL)) != -1) {
+	while ((ret = getopt_long(argc, argv, "b:e:m:t:",
+				  set_opts, NULL)) != -1) {
 		switch (ret) {
 		case 'b':
 			if (params.perf_bias)
-- 
2.43.0


