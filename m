Return-Path: <linux-pm+bounces-37505-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E80C3AA5D
	for <lists+linux-pm@lfdr.de>; Thu, 06 Nov 2025 12:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2081550068B
	for <lists+linux-pm@lfdr.de>; Thu,  6 Nov 2025 11:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EA630F922;
	Thu,  6 Nov 2025 11:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="XSFyVBrQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from sonic305-19.consmr.mail.gq1.yahoo.com (sonic305-19.consmr.mail.gq1.yahoo.com [98.137.64.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5703430EF90
	for <linux-pm@vger.kernel.org>; Thu,  6 Nov 2025 11:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.64.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762429202; cv=none; b=AQ8G4V6799hcKs4glqnuFRhA/wMI/t3wpbRA8DogcJsCcjb1MIQnj/0EYjOqqGmFDKESIen+EjbAdG/zTTpYpJ5v8CcGCqebl58C43fnpcWElTEQpLgWtBx4mjod43CyCa9xaAxIVHL2/n2NWMxZkrz2D4FB8pBlQGiq5X5dB24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762429202; c=relaxed/simple;
	bh=v2rMqKQjvEwiC3UE8YIQnpWIc49AWaxyZty0N67bGuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q6FbX1W4Lkwxf4o1Of2YEl74hsgeVrDyk9Qr7aRXivoGHg2PSBGGJPi132FZ9d+XZfzNI6SYmDLeI5NLU4Sa9a9XwRhPu6i6HyR7uTFA9Ckmfkwp9RsUOyEVAOJgOdrpoN3N6KrA6Wle00j7iXCU4zpSg07PODqZuGoKsk7F0fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=XSFyVBrQ; arc=none smtp.client-ip=98.137.64.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762429194; bh=cZ+6BA/dOKXbMAPfS0F4xWs8LUFnwRtkkTGEFa9upoQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=XSFyVBrQaybTrfo1lXYUsk+pb1bxA5FgIOk/6qqPvWI32XlGNtwrRdcud3TjUm76UxAltNfGaHQk4QypwJfMQtrWFH+V7Uj5MK9w32AWO7BYL8XscOHWCbpckr9kUn1GsNYe0+CsYYtCpNb41so/WBnz4rzYvn1uYuOWEUEKIlD8e4Kze1/EL5jsm+XB5na3wQ2msJEPlRmp6IHRhV0dVAhh7zPUdWouvgToABTT2hRxryKl6g5RPK/2Ur0k1r/JJHI58x3QbCOP9y2A3SGG6USwNYBX6MNAsyGuBlxN0DfSOz8z/31cjODPj0+IecG9YtQTD4VlXW1hQzoFpi6y4w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762429194; bh=LqcLWYXQWb0Ip0SPiqalyv/pE8J5LXoRo13y3+eIwOJ=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=QHfm8mJjLIuIloGLdqzVmbZ9YjqxTu7UUZAnq6yiWrwyZh5+q6KTc9vvG/QH8bAmSr3jW/Ct9wVH5y4BBWVubHWG3Tf/Vx551vz09yMI73vBvQd/frknhY29f6k7AMZwLVWWLtzO+zpVDpp/G2VwYfmehnHlPauWiFmzSZRV5y31BT4uQ8550pcgzM9pfXuqsU5YGj8DtvnX2k/oIS9DmWDEJ9IGMTUpY+veNjG9hQHl+6qFGGKFcCgH//psctwHIOOih+hjnGK1W9eREKJ9btX3zp8YOKbLMXYh08WjR1v/l22hbP5JpBSXw6w1WaJeatmW2ZNUzem14yOEcnI1jw==
X-YMail-OSG: k9ZbsqQVM1kEzsbWKnPr6TPBwE18ohEy9zHwHXVdtKRGUQDoh48Ewidn._BNor_
 kqUxgkt.aDuocS_OXVHCe8aIOX43YQPQyUjsiAd8Dzvs7dyVFEYp17NqqodvpP66S89Kzrjn9aVC
 GD6fMmMvdVyMpe0bfuPDQsLOcHuXWpmrFC5WyAJCojOitojh8nPsaNSbcFU4VM6.OVI.nuh7S4mL
 TMGaqwZC2okaZAQv_MjHK54EMHvCMqeUVWHxknPZShiF0.XugiIyS_UkFscdIF3JT1nBHNRuYRAt
 yXO2QIWPiHAOaExFLaVBJwFsRdua2toduW9KZAGe59_asSwpQygctGEuHrue3R7Y6Qhy829lfMwr
 RtDlUSOiI6mBZxouFMMIadeTNLNU7TdrbeYk6.vTrwAZbDfaWpjCTWd19X3aZy6HPRpe_1Wxs14N
 xq5mlK_7U1aCH.XjGuxN594n7eOjmZhBFGF3.yc2GwoHV98EiQmRcwOVG6TFAOCp_wVb27kMAwjn
 5l33Rvu3Ln0v20bQTvEmsPCE0qPoS7RRAzvwqlLC68Uy4eJ4bNvGaH4_3BJVbl7Kz4wV_V11XfkM
 bIJ0I.3nUod3SKjnJ9gNczWqHsbR.GsZSsIZKgW46AcF6cGNkunGLZUbAlmH7vcbxEnG0CQHQRqa
 _fixRSkzYCvWkP0jEh4X3qYa0OGBDRX.8Mze3nRX9JUiWM68XAfhMY7JKWIIKfbxq2m33z8Mr_NB
 yp8RKBDu1EP.YJgezdZrZSw8wDSsXmecMP_FFTZtY_zthzVuWxHOigfoRSh9Sk0ytK0.U5N0gxjt
 _VZJjPnnIFlhfyPGaTL5q20VjXQJDd3DmtqJV1LYV2otzuSMRiv_TnxJmEn7csD2GYE4y0KeTl_x
 hb5mieGtUlJ3_DDoAIPJjwDbOU7kL3EEnIxS9FKerzwpY9vu5pCYcuf7heSC4omhO5JIehLpIzzK
 Qj6.cZ0OtA2A7HVvclEL01JuG_CJUVU3tSGehSpXzU0MbIyyinqQR2oVda2AF_5Qj5wJ.NcMGqmW
 BBRUEyeC6ikChfH7fPHzKWHjv.aodYYZhci6c_B_amEdIBCwtckQnPUxDwxSko.GkGsI00t5AD9B
 TKL_f2.anMgAoeA6y7ec.NFm_C2xmoGoUyL9tqeN.lbggJAdTteiikVLmG4JWf1pnXpjQsiV0qSo
 qXHwhNbyw8g8RJgNqxFJUEp2CZZUcsyXuHMrIzvdNHeqcw6I47TL3zCmaFJhfHg.1EfYyFGqsp0y
 AJM8zczGbiXHbKpjZJ9duqvbMsHpkqYtn_uJXww4WCSi4huPGzu01W4z8QEYxdi7kW3_JbBT45ZG
 PZPoFpNl_nUrKaCBQtQmHyUe7wvLB9m.S6TLOigKO0TDIYaIOsbgB9dEX5Se.DcH3zUoUCTR3UiT
 GmUOYwWsVRqwzpoJ179DPIjSO_pUkh1jOFsdxb9o0Cv7NwGvh7yzQnzRHiKVlBJvYauBfM_58AaA
 W3Z6emlMXIYiuQluyWLYvS6zDybMHpkEMBohO4mRIaRul4bSSrUeUVXAmuqgt542NwcMGLruR9yp
 VEs5vYLk5yvu3aXGlanKVuWmpVvqHmcxDOjq6x068cWp_Kek1smGmwKWS3ZWkOmnuqK5QscKtDmh
 g.BSF3vNhXuQ5zszQ9T9aicwflCm0ya.UVAERvjVzabfpR4nYDxksiY4Yy_nlMFVPs8f80o787Gj
 qKQ1oxWpbUFhWZcQvVC6Rt8jRe7XLc80GUqLn4drexXROd6Vr1ZqTJTcBN1xgcTMEO0ed5bdDC5R
 EJO6lWno7DzTBCsfnlkRsUexoH35PPsI3nmpKEpTnzWhwjfIeEGrV0QaJKqlgHjQ127i2ptSl_Oe
 4ay1i3sViwehVS1_pFlkSJPF8pfOn0K3gqL.4wtuvOUu5QhFDsZh_hkQXIuQFZhcnwZ0DqGTsr.Y
 SpHbYfHPQxPGjPsLPZShaD36rNQg1bnj1ZYoJIROQZ.XkC8XwsNs6cJnKmudROoq5jlhpU_DKZ6A
 KcDCcbJqPx21f3kUYyZSyliL8VEY_j6gtIlBYUtSPNySahhGCdADmywr6T.rNSV_MbNogMUxRuQY
 lFrnvuSspmjsEhLGqIWlePKzftnojDg5LtGCmA7Ri7I3IKgUA5z1qvXL.9zNDB3B_ytj_AIC3oat
 1WFe1khlLKIBcmLqFyUKhPeZNN1Pxz0e7_iwMKYyGd2N5rjcqkckzgDe3AQdeEQfa8NLyUiQhuhj
 S3hTDg_yQX0npFuhFdnleUatOZf3PKqPB_TanZEEK2qkrWxeWtUrOPijlrtGLcj4_i126EOAqsgW
 aPk65lslE4HOF8YwQYfsi.g--
X-Sonic-MF: <adelodunolaoluwa@yahoo.com>
X-Sonic-ID: 4305c9c2-da40-495b-ae94-407935b23269
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.gq1.yahoo.com with HTTP; Thu, 6 Nov 2025 11:39:54 +0000
Received: by hermes--production-bf1-58477f5468-vjcpj (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a2a71f3be34b9b294192b02c80d46421;
          Thu, 06 Nov 2025 11:39:53 +0000 (UTC)
From: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	pavel@kernel.org,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	mingo@kernel.org,
	tglx@linutronix.de
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sunday Adelodun <adelodunolaoluwa@yahoo.com>
Subject: [PATCH 1/2] power/swap: add missing params and Return: descriptions to kernel-doc comments
Date: Thu,  6 Nov 2025 12:39:37 +0100
Message-ID: <20251106113938.34693-2-adelodunolaoluwa@yahoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106113938.34693-1-adelodunolaoluwa@yahoo.com>
References: <20251106113938.34693-1-adelodunolaoluwa@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kernel-doc checks (scripts/kernel-doc) reported a number of warnings
for missing parameters and `Return:` descriptions in kernel/power/swap.c.
These missing return descriptions make the generated documentation
noisy and break doc-build when -Werror is used.

Update the kernel-doc comment blocks to add explicit
Return: lines (and a few parameter tags where helpful) for the functions
that were triggering warnings. No functional code changes are made.

Example warnings that motivated this change:
 - Warning: kernel/power/swap.c:535 No description found for return value
   of 'save_image'
 - Warning: kernel/power/swap.c:687 No description found for return value
  of 'save_compressed_image'
 - Warning: kernel/power/swap.c:941 No description found for return value
   of 'swsusp_write'

Signed-off-by: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
---
 kernel/power/swap.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 0beff7eeaaba..3f0df7a26bc3 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -341,6 +341,8 @@ unsigned int swsusp_header_flags;
  *	and get its index (if so)
  *
  *	This is called before saving image
+ *
+ *	Return: 0 on success, negative error code on failure.
  */
 static int swsusp_swap_check(void)
 {
@@ -367,6 +369,8 @@ static int swsusp_swap_check(void)
  *	@buf:		Address we're writing.
  *	@offset:	Offset of the swap page we're writing to.
  *	@hb:		bio completion batch
+ *
+ *	Return: 0 on success, negative error code on failure.
  */
 
 static int write_page(void *buf, sector_t offset, struct hib_bio_batch *hb)
@@ -528,6 +532,11 @@ static int swap_writer_finish(struct swap_map_handle *handle,
 
 /**
  *	save_image - save the suspend image data
+ *	@handle: swap map handle for writing the image
+ *	@snapshot: snapshot handle to read pages from
+ *	@nr_to_write: number of pages to write
+ *
+ *	Return: 0 on success, negative error on failure
  */
 
 static int save_image(struct swap_map_handle *handle,
@@ -676,6 +685,8 @@ static int compress_threadfn(void *data)
  * @handle: Swap map handle to use for saving the image.
  * @snapshot: Image to read data from.
  * @nr_to_write: Number of pages to save.
+ *
+ * Return: 0 on success, negative error code on failure.
  */
 static int save_compressed_image(struct swap_map_handle *handle,
 				 struct snapshot_handle *snapshot,
@@ -906,8 +917,9 @@ static int save_compressed_image(struct swap_map_handle *handle,
 
 /**
  *	enough_swap - Make sure we have enough swap to save the image.
+ *	@nr_pages: number of pages we need to save
  *
- *	Returns TRUE or FALSE after checking the total amount of swap
+ *	Return: TRUE or FALSE after checking the total amount of swap
  *	space available from the resume partition.
  */
 
@@ -930,6 +942,8 @@ static int enough_swap(unsigned int nr_pages)
  *	them synced (in case something goes wrong) but we DO not want to mark
  *	filesystem clean: it is not. (And it does not matter, if we resume
  *	correctly, we'll mark system clean, anyway.)
+ *
+ *	Return: 0 on success, negative error code on failure.
  */
 
 int swsusp_write(unsigned int flags)
@@ -1078,9 +1092,12 @@ static int swap_reader_finish(struct swap_map_handle *handle)
 }
 
 /**
- *	load_image - load the image using the swap map handle
- *	@handle and the snapshot handle @snapshot
- *	(assume there are @nr_pages pages to load)
+ *	load_image - load the image using the swap map and snapshot handles
+ *	@handle: pointer to the swap map used for reading swap pages
+ *	@snapshot: pointer to the snapshot handle that tracks image pages
+ *	@nr_to_read: number of pages to read from the snapshot
+ *
+ *	Return: 0 on success, negative error code on failure.
  */
 
 static int load_image(struct swap_map_handle *handle,
@@ -1195,6 +1212,8 @@ static int decompress_threadfn(void *data)
  * @handle: Swap map handle to use for loading data.
  * @snapshot: Image to copy uncompressed data into.
  * @nr_to_read: Number of pages to load.
+ *
+ * Return: 0 on success, negative error code on failure.
  */
 static int load_compressed_image(struct swap_map_handle *handle,
 				 struct snapshot_handle *snapshot,
@@ -1529,6 +1548,8 @@ static int load_compressed_image(struct swap_map_handle *handle,
  *	swsusp_read - read the hibernation image.
  *	@flags_p: flags passed by the "frozen" kernel in the image header should
  *		  be written into this memory location
+ *
+ *	Return: 0 on success, negative error code on failure.
  */
 
 int swsusp_read(unsigned int *flags_p)
@@ -1567,6 +1588,10 @@ static void *swsusp_holder;
 /**
  * swsusp_check - Open the resume device and check for the swsusp signature.
  * @exclusive: Open the resume device exclusively.
+ *
+ * Return:
+ *        0 if a valid hibernation image is found,
+ *        negative error code on failure.
  */
 
 int swsusp_check(bool exclusive)
@@ -1631,6 +1656,8 @@ void swsusp_close(void)
 
 /**
  *      swsusp_unmark - Unmark swsusp signature in the resume device
+ *
+ *      Return: 0 on success, negative error code on failure.
  */
 
 #ifdef CONFIG_SUSPEND
-- 
2.43.0


