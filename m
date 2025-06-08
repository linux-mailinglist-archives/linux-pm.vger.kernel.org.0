Return-Path: <linux-pm+bounces-28233-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF3BAD13B0
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 20:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D8F61889DEF
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 18:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9D01CAA79;
	Sun,  8 Jun 2025 18:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1sABN7/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772281C861F
	for <linux-pm@vger.kernel.org>; Sun,  8 Jun 2025 18:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749406738; cv=none; b=gi29763SoNK+EscYon8Tfmup/smLq1BziQfuHEqA7fh+crE4ZUkWU3IgUqX/Mmh3rkf8phYbeWi3I4MQ/XLcm8IyMuzzV8Wq6Reoks87rBB8zt3GNHutt21rr9Pqjvq8BnxotINy8Q8mioA8tOtSXpb1PbPnx8IQgaz/+sxDl20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749406738; c=relaxed/simple;
	bh=2nVzzCw6Ww5ivS2gXhWTGXHuL+d6utwbX3kCYWa81L4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DE26ZAMAKzSyWGcIALt7drjBl0kc4Qk0kXcf3iD7v9aLVJpBDZ72H5MRdYd2GdEDFc3+4PG1sYv16uk71u5nk2AMQc+2c9jvOjUKQrmep5hCq2xMyE9tnbNUgrU7HBHXnH/SxUOj3BQXYE47c+9Ne70yja2Zjbn7j/QIdUWpzAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1sABN7/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E3AC4CEF1;
	Sun,  8 Jun 2025 18:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749406738;
	bh=2nVzzCw6Ww5ivS2gXhWTGXHuL+d6utwbX3kCYWa81L4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=r1sABN7/HB1DV1w/sS+S+pZTpjHpDmp2Y3VLHrURVxr/0/lAkf2Zh/jDCbSIMdBIW
	 s0Jbl8Qku+GefAlwqkc8PgyWUDcElMhJ3UeNVlFCUpIEAKK7v6WEQsxmQxfRJlFRoZ
	 INaijcldAov7v6y7E/LCNWzagA9LjdhvXX6TJ/E+FN9FMJlFkauevrx063b/RXB2o5
	 SzIVtPwLylZN6nTXDP2VxDMeSvgsMMwBzKLJFBS0aAEpnCoxaj+QFEvevxeqn3Zjhi
	 /vHPBBj4702FpoypZhyWFesBReqRskcDMRKNFTkGqnv2gPVQPUsxRtJiX7AuSObjVW
	 /0slsjbyiYG8g==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 08/18] tools/power turbostat: Remove add_rapl_perf_counter_()
Date: Sun,  8 Jun 2025 14:17:07 -0400
Message-ID: <8445eee54bf1914656060491bfdd5403cc208eb3.1749406068.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <780da8a9557f2d114aaffda0eb0a517fe6a244c8.1749406068.git.len.brown@intel.com>
References: <780da8a9557f2d114aaffda0eb0a517fe6a244c8.1749406068.git.len.brown@intel.com>
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

As the only caller of add_rapl_perf_counter_(), add_rapl_perf_counter()
just gives extra debug output on top. There is no need to keep both
functions.

Remove add_rapl_perf_counter_() and move all the logic to
add_rapl_perf_counter().

No functional change.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 7e7d25d2362a..2651030c506b 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -7853,44 +7853,39 @@ static int has_instr_count_access(void)
 	return has_access;
 }
 
-int add_rapl_perf_counter_(int cpu, struct rapl_counter_info_t *rci, const struct rapl_counter_arch_info *cai,
+int add_rapl_perf_counter(int cpu, struct rapl_counter_info_t *rci, const struct rapl_counter_arch_info *cai,
 			   double *scale_, enum rapl_unit *unit_)
 {
+	int ret = -1;
+
 	if (no_perf)
 		return -1;
 
 	const double scale = read_perf_scale(cai->perf_subsys, cai->perf_name);
 
 	if (scale == 0.0)
-		return -1;
+		goto end;
 
 	const enum rapl_unit unit = read_perf_rapl_unit(cai->perf_subsys, cai->perf_name);
 
 	if (unit == RAPL_UNIT_INVALID)
-		return -1;
+		goto end;
 
 	const unsigned int rapl_type = read_perf_type(cai->perf_subsys);
 	const unsigned int rapl_energy_pkg_config = read_perf_config(cai->perf_subsys, cai->perf_name);
 
-	const int fd_counter =
-	    open_perf_counter(cpu, rapl_type, rapl_energy_pkg_config, rci->fd_perf, PERF_FORMAT_GROUP);
-	if (fd_counter == -1)
-		return -1;
+	ret = open_perf_counter(cpu, rapl_type, rapl_energy_pkg_config, rci->fd_perf, PERF_FORMAT_GROUP);
+	if (ret == -1)
+		goto end;
 
 	/* If it's the first counter opened, make it a group descriptor */
 	if (rci->fd_perf == -1)
-		rci->fd_perf = fd_counter;
+		rci->fd_perf = ret;
 
 	*scale_ = scale;
 	*unit_ = unit;
-	return fd_counter;
-}
-
-int add_rapl_perf_counter(int cpu, struct rapl_counter_info_t *rci, const struct rapl_counter_arch_info *cai,
-			  double *scale, enum rapl_unit *unit)
-{
-	int ret = add_rapl_perf_counter_(cpu, rci, cai, scale, unit);
 
+end:
 	if (debug >= 2)
 		fprintf(stderr, "%s: %d (cpu: %d)\n", __func__, ret, cpu);
 
-- 
2.45.2


