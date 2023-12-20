Return-Path: <linux-pm+bounces-1445-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3814A81A8B6
	for <lists+linux-pm@lfdr.de>; Wed, 20 Dec 2023 23:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99C88B21DB2
	for <lists+linux-pm@lfdr.de>; Wed, 20 Dec 2023 22:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D2A48780;
	Wed, 20 Dec 2023 22:05:31 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B420C495CE;
	Wed, 20 Dec 2023 22:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oldschoolsolutions.biz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oldschoolsolutions.biz
Received: from [192.168.0.174] ([80.128.175.14]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N9cDF-1rCXxu0CaD-015Y3k; Wed, 20 Dec 2023 23:05:23 +0100
Message-ID: <39e0f711-9331-4fd2-9d78-be53afb5c37d@oldschoolsolutions.biz>
Date: Wed, 20 Dec 2023 23:05:22 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Amit Kucheria <amitk@kernel.org>,
 Thara Gopinath <thara.gopinath@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
Subject: [PATCH] thermal: qcom: tsens: remove dependency to NVMEM_QCOM_QFPROM
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:V+zYi2CmJPxb6VwJ0IPL3maI6fGFCWwBhE/8+esM30YWVFomRwZ
 Zlet4Nqy6+TdqDkTXe9vrakGYGh8YkcbYx7YoauhDuTwKWqmLNZUrWcb7PUOpRJ26sjzv0Y
 vu+Ew+1x4Wm4mWLZnK8pAMgpDvV7wgge8dYdeNWcucOVajok6C64xj7kRPNI/6DnIZe/B4o
 b3w4c6fkQE+kysFxFA8Ow==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1Disa2g06GY=;R1t8Wdpy+zB8Unov9NHgEAgQgv1
 YdSQTxkGBX/BCjOjlVmlc1c5EipgFoOSo7HVbxRslGrPG+3wE9BmEvFcGuoDoaaK/nJk2t77R
 GGxxQnCxEwLBd/a/fHX0kvgKvH5j3+1o8FMn1NRm2E5d0XT/k7FkzGwtjTc7aw6Z4LmUDDrmv
 0KrpCUV1tt2/HQHVPcmwTT1tNMP89CJWs16teZ44cdGX50Vjp8kPW3Bt2lvQuvG3puTpv8KB/
 jmu/3ihW9v5JcHkYlde/u8Oa774KnhjLj4NFEaeEeco8K/rt3OjqBEWf+hDTYXhFWsb0gnGKv
 sv05zYfkrURKBm9EtU+4P1uKjQ5zype/FJ0SbgUNAumhAjLSjXX4+NtfM0MYFzTyWWBDnw7h6
 w/pH9kIKm/um/Z3YeOdGO3Yz2X/6hDaurbNYo4R3uvPeMXmXNm/u97Qu8IinKEiNA8ewUSmDb
 UMII48alWhZacK8ssxUaA4OdXnogf22XrIOWyNyOHTY3fL+4f2VWD2GZTVXB3ksPPXQliFpas
 XjB2D1K6NqcBbbAtaXxeUkx9fdQQlLBnXm5KAFJqlXTbYYDgfKIZmSZyM+kjQZGNF9Tk4Ik1h
 lmq4gK4Kc3F1gQTXdQvMmcRhkK8SP8rqP4YIMyd2cL9Dy55sJetMdCjR7SlFdJcInoXiWSa0i
 M5tLycPL5Jsujws2qt0fi2o5qng2iuAv0ip6TJ3e9y5sxKpq4EeUvfqJyMwHdhZJkFOajsbAt
 O49S4JIPvAEiTcmc+qMcdTPRab5qoUs3fwQ9agUnd5KgKQPwZUbmNSkXlpZccqXxhVGCG78Cg
 fTUs2Z3HGTbYNPjrBIyS/Y0yypsz02NeXEg0tTf2yDj/vEWMWRtaReLbXPCpf75nGAb1Ndw3o
 Rw5OXajO6Dkzqvw==

The dependency to NVMEM_QCOM_QFPROM seems to be a problem when using
"make menuconfig", it will exclude QCOM_TSENS from the build wWith
bad effects on power management, observed on the Windows Dev Kit 2023,
and Thinkpad X13s. Removing it doesn't have a negative side effect,
as it seems. Observed this since v6.6.

Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
---
  drivers/thermal/qcom/Kconfig | 1 -
  1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
index c4ebb1977b177..09d9b35c57bd2 100644
--- a/drivers/thermal/qcom/Kconfig
+++ b/drivers/thermal/qcom/Kconfig
@@ -1,7 +1,6 @@
  # SPDX-License-Identifier: GPL-2.0-only
  config QCOM_TSENS
      tristate "Qualcomm TSENS Temperature Alarm"
-    depends on NVMEM_QCOM_QFPROM
      depends on ARCH_QCOM || COMPILE_TEST
      help
        This enables the thermal sysfs driver for the TSENS device. It shows
-- 
2.40.1


