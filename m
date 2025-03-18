Return-Path: <linux-pm+bounces-24229-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 993B7A66D87
	for <lists+linux-pm@lfdr.de>; Tue, 18 Mar 2025 09:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64487173AB4
	for <lists+linux-pm@lfdr.de>; Tue, 18 Mar 2025 08:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709C61F418A;
	Tue, 18 Mar 2025 08:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nXCHckg0"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF2F1F585D
	for <linux-pm@vger.kernel.org>; Tue, 18 Mar 2025 08:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742285366; cv=none; b=fRCx5NFRyUc6hyb3JGSqrn16r7KicrSC6qoEQkoy0mexRbcd+tWjru5mwkb4qatB0QRcAUbtt3hYao7/xsO8XOfEPFZ7eeaYdIrhEJ1RrSFkI2t7dtW1U1S+tdQC2yPn+9TJ1e4ey6A28+dKPfMbKnWq5bSSfhwqe12xk+qBmn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742285366; c=relaxed/simple;
	bh=D6thwv3zdfXcOP7M3+VV50TXw1V5msQDRbjcSy9AiOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R1verRZLnF6MhaHqTWb96lsm66kV5PlszctwAsb645u010v5qTDY4nZwlNamj7y832AQms64/Wo2gA1xveowA1mjuc1XFke0Uknn+ETIxO72giRlePWuMqr645lRwG4zh3oQ5zNmvTOteW01+fIpEy2v2Bzi4WZ1cjRdepx35ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nXCHckg0; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742285352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CZXRpA0wyKkasWk/hQ6UZeNlh8su/0nwCd2IcXauex8=;
	b=nXCHckg08DvLorApQntplAGtSSb4D0qf9qufIaDYQBSpZvSuj4Xdm6y8A5uFMBRlA78CIy
	Ei/ABVd7fQvN8omefTPpvj8IqNADj0Ubdtg9948H+cVuvCTM8xg8UttNhB6yihXRop9bq1
	xFjqtqrapGjpXqEAttfx7dXg/4LEN3c=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <len.brown@intel.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PM: hibernate: Remove size arguments when calling strscpy()
Date: Tue, 18 Mar 2025 09:07:55 +0100
Message-ID: <20250318080755.61126-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The size parameter is optional and strscpy() automatically determines
the length of the destination buffer using sizeof() if the argument is
omitted. This makes the explicit sizeof() calls unnecessary. Remove
them to shorten and simplify the code.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 kernel/power/hibernate.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 10a01af63a80..ddf7c4a5736f 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -756,7 +756,7 @@ int hibernate(void)
 	 * Query for the compression algorithm support if compression is enabled.
 	 */
 	if (!nocompress) {
-		strscpy(hib_comp_algo, hibernate_compressor, sizeof(hib_comp_algo));
+		strscpy(hib_comp_algo, hibernate_compressor);
 		if (crypto_has_comp(hib_comp_algo, 0, 0) != 1) {
 			pr_err("%s compression is not available\n", hib_comp_algo);
 			return -EOPNOTSUPP;
@@ -1005,9 +1005,9 @@ static int software_resume(void)
 	 */
 	if (!(swsusp_header_flags & SF_NOCOMPRESS_MODE)) {
 		if (swsusp_header_flags & SF_COMPRESSION_ALG_LZ4)
-			strscpy(hib_comp_algo, COMPRESSION_ALGO_LZ4, sizeof(hib_comp_algo));
+			strscpy(hib_comp_algo, COMPRESSION_ALGO_LZ4);
 		else
-			strscpy(hib_comp_algo, COMPRESSION_ALGO_LZO, sizeof(hib_comp_algo));
+			strscpy(hib_comp_algo, COMPRESSION_ALGO_LZO);
 		if (crypto_has_comp(hib_comp_algo, 0, 0) != 1) {
 			pr_err("%s compression is not available\n", hib_comp_algo);
 			error = -EOPNOTSUPP;
@@ -1455,8 +1455,7 @@ static int hibernate_compressor_param_set(const char *compressor,
 	if (index >= 0) {
 		ret = param_set_copystring(comp_alg_enabled[index], kp);
 		if (!ret)
-			strscpy(hib_comp_algo, comp_alg_enabled[index],
-				sizeof(hib_comp_algo));
+			strscpy(hib_comp_algo, comp_alg_enabled[index]);
 	} else {
 		ret = index;
 	}
-- 
2.48.1


