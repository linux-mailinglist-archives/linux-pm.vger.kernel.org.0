Return-Path: <linux-pm+bounces-7840-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0B08C4F7B
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 12:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6C7B1F2318F
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 10:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836AD14038E;
	Tue, 14 May 2024 10:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w0KfWbfF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SrFtHyNO"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C155A13FD7A
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 10:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681946; cv=none; b=era0Ina5IA9P1t+nh+VkMEcWvhJbvEV/ILmSsQ8cJvUZX/G2VP3AP8Z10wLlmFHSk1aHLbpZscrRr7TApfWIdRhtjVF4FdOQJqp1V7G3/VYfJW7JbEra5c7nF/FMUaasmZMbNqCdhp4FD2JRp5z5mI3Xo/4wnkhYKXxM1sdS9v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681946; c=relaxed/simple;
	bh=kX/E8g8Kl85cpQw7TenzVgpFOohrLfh6KB1znuxzgI0=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=XaGIOU+vO7U/jtsQCphkMll8qxOl/4QRcGbWp09jcIEahOe/D2eo0l2bqkJBQIbDMQ5jseAnyww+x5vJDCnnBvAl7cNXbgSevm9FnHwMoEqJ2E3QnVXmrmZRrvDTxWdvpCAkTvAD6kw7eYrBLQ5gzL0rf3hBxfFZ27hJep1HqBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w0KfWbfF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SrFtHyNO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 14 May 2024 10:18:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715681937;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=StqtemzdtfZoP6Je0SXnq7xGigmu2vZeMunuA+m9NQ0=;
	b=w0KfWbfFTbVVPorLyG1aB0WKxBEr+OYFI6k8gGkmIaOwUfBLhe0KCfYQVZNyEchcLcTlvu
	4JulvSnXycb2MxxEFbgSuf8mGgt/MW04KRlwz1kr70+XtaHZIGrwy5GY/R9nuGj9Yl2Ped
	ATIxSfyvk/F1FZdad0nAAXDizfee4Vlo4WHwfkP165TxqxY67ON6Sqom7XEaU/RP8VDfIR
	G4T7Gr4lUP03caCvPtxFh/2by5zJGgxSP0QAqpZM2tqje3W/tTO7xuoGTJL5H5WIH9ccfR
	BQGPeT5clQX+q1kL3lLIKpoVM0ghqQcLq7KLNU6zL1rDvIJREaGBJsHe/GztOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715681937;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=StqtemzdtfZoP6Je0SXnq7xGigmu2vZeMunuA+m9NQ0=;
	b=SrFtHyNOeKRmsHQy+aDZW6WMhF8N2XlYtBs9nN1RzeQ3tk+aYJ4LmKfHHXbF7FYuDWsGf0
	iX00d3PEPoSRldDw==
From: "thermal-bot for Justin Stitt" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/fixes] thermal: intel: int340x_thermal: replace
 deprecated strncpy() with strscpy()
Cc: Justin Stitt <justinstitt@google.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, rui.zhang@intel.com,
 daniel.lezcano@linaro.org, amitk@kernel.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171568193743.10875.13256773729291529190.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the thermal/fixes branch of thermal:

Commit-ID:     03fa9a3ad1d61992a2105aeb1062b349f1a85012
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//03fa9a3ad1d61992a2105aeb1062b349f1a85012
Author:        Justin Stitt <justinstitt@google.com>
AuthorDate:    Mon, 18 Mar 2024 22:36:10 
Committer:     Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CommitterDate: Wed, 27 Mar 2024 14:57:44 +01:00

thermal: intel: int340x_thermal: replace deprecated strncpy() with strscpy()

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

psvt->limit.string can only be 8 bytes so let's use the appropriate size
macro ACPI_LIMIT_STR_MAX_LEN.

Neither psvt->limit.string or psvt_user[i].limit.string requires the
NUL-padding behavior that strncpy() provides as they have both been
filled with NUL-bytes prior to the string operation.
|	memset(&psvt->limit, 0, sizeof(u64));
and
| 	psvt_user = kzalloc(psvt_len, GFP_KERNEL);

Let's use `strscpy` [2] due to the fact that it guarantees
NUL-termination on the destination buffer without unnecessarily
NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings # [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Signed-off-by: Justin Stitt <justinstitt@google.com>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c b/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c
index dc519a6..4b4a4d6 100644
--- a/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c
+++ b/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c
@@ -309,7 +309,7 @@ static int acpi_parse_psvt(acpi_handle handle, int *psvt_count, struct psvt **ps
 
 		if (knob->type == ACPI_TYPE_STRING) {
 			memset(&psvt->limit, 0, sizeof(u64));
-			strncpy(psvt->limit.string, psvt_ptr->limit.str_ptr, knob->string.length);
+			strscpy(psvt->limit.string, psvt_ptr->limit.str_ptr, ACPI_LIMIT_STR_MAX_LEN);
 		} else {
 			psvt->limit.integer = psvt_ptr->limit.integer;
 		}
@@ -468,7 +468,7 @@ static int fill_psvt(char __user *ubuf)
 		psvt_user[i].unlimit_coeff = psvts[i].unlimit_coeff;
 		psvt_user[i].control_knob_type = psvts[i].control_knob_type;
 		if (psvt_user[i].control_knob_type == ACPI_TYPE_STRING)
-			strncpy(psvt_user[i].limit.string, psvts[i].limit.string,
+			strscpy(psvt_user[i].limit.string, psvts[i].limit.string,
 				ACPI_LIMIT_STR_MAX_LEN);
 		else
 			psvt_user[i].limit.integer = psvts[i].limit.integer;

