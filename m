Return-Path: <linux-pm+bounces-27620-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A26EBAC2B9E
	for <lists+linux-pm@lfdr.de>; Sat, 24 May 2025 00:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E0F37BB660
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 22:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA4820E717;
	Fri, 23 May 2025 22:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="m/m32+DA"
X-Original-To: linux-pm@vger.kernel.org
Received: from sonic312-20.consmr.mail.sg3.yahoo.com (sonic312-20.consmr.mail.sg3.yahoo.com [106.10.244.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7AB20E012
	for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 22:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.244.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748037773; cv=none; b=AkXm4dXPrnEu8G9jpw0tEpkrS1oRvzahFha9jkCHNvBLVyr/ZeGITTtBBRwuGaoiQwJHhbdqOmonaapmJKKBlTXFC4T675mcydxe6stzu8FmOgVJFsriMlOEagjTLi7KRT+fyqFvmV8nknQWe5JWUqu8xyiHhE+2snUQ5uyNnUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748037773; c=relaxed/simple;
	bh=Ld8sSIiOdoLEcRyi37iPeIWW6gGFZx0wcF07f5OOJjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i3I2DdKjlkW9KrnHOlhfE/eaQvcDD06xyrmGb0jKw/nmU4vwWfvvgLXp/4z89swgXvxlpDcjNOUf50BTLz+u2ouNQEIgP34l9A6j0/7yZYxC/MprmffeZ9T45qgqAGhZTTf8PlkFdTLblEPbeDgt1KWjwtlhSVwMIBZSot+A7JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=m/m32+DA; arc=none smtp.client-ip=106.10.244.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1748037764; bh=g3PopIJDq4T11kCNZlSkgS3dVhWsotgsaLpI5IrDYXM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=m/m32+DAmfjk50P13ks2sQc5Bg8j837NKnqrFP7wF5hhhr21BoqO4MmndJH6+cOW9wkqMKY7gBy3NNtOyG9FnbdDNDAG67m5KHVNqOZr3mzofj8clKehJxst/NX7yfeCuTKh0GpV5lcPUMgiYL9+6wKoAzVm/xCkwLbKL+iCKadOb0hYKX+xD+3TEd+0T3dc2gkCs7wbtiN7eC3yc8SWabFCxGMH+PMMi3IOrFd9u+sMWCBXWmqJVl0ww14bddQqUSZQAGE1fNZb718Z/He+n0KvJUE+HyXeexTV+QchiCLka4LQNo4B9aIGFXT/fBF6pNn46ex4IVGF6aRE1N0dbQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1748037764; bh=vm7jqXRtyiY/E2jBsscGxMWqT7WbgvMDmjyx01HkGXW=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=NdFhrYlarKNd/N7XmbpFQNgO9JrFPbUEFjbsGtnGZKg7KwQuYZq825FxzBLK1GzVV9Ach/f3nJR+1N42JUA51fY+nqWnijxMruWm1q2p+xD0QTIgGOFxjKRVfyJgPRftR+7JjJ7IxSY4r2O6ftjpspjup5XBVodypO3rN3zaIR+vZm2Di8ZvlkRZFaneXJOLd54NbZRWEnOmSd8ChM0i8pFdnO1yOrn2RN6Di63p2bgFq62tnxIy5boje8Su92ksk9X+8TiZ0FGDF50QZ1wTZprisiTxLis23/b+3fIrD0bFTM62uI4AI+EE0/hbAigEBAexJIF2pTMP8zan4PiJpg==
X-YMail-OSG: t2vWDoAVM1nTGRJePXqMaqHw5ro0JZjImZWOmVPpZCuaXqbvED8lbDVuChKK0hK
 zwcISGhEn3mrvO75CYouml876pPept6QRUcUbaIvMtgvG_5ehdA_45BdXSQKKA5K1IrSYabp9_Es
 x4ZRFMn_Ay9BKWmMpH.ZSoztJrU449blbDONS8uVP66FeZ9nKNU5JF7XDpl6Ihc0Rarr9x7nkkye
 3fTk7xsGIWUEZDUKYKhJRvcAw0LpPaciGIaJ0VSCS9jnotXQvkQrtXmiHFBA6OGxMxhHEosdZOqm
 xlgepOYDwHQY20f1VEkbeBSOhov708T56wVZPHS1j5gB9MaSB0JgFBejPnJ0HeUchyzIJQzLLlrT
 cO1N_c4wWzgU6Zwoa9YgRltR5oDiSwHMr8pwI1aZJYFddsrMxFsQdVfiwnJRkvni_vKBvOzFe4gw
 wUZYDnb9yevLN9OkEsrYnpFUnW.hBZGhBOiiehJLzpQHaur92RqLEi8ZYRKrPjWBVPOK0QHQ8iBB
 jh3PaIdiY45iVHIan8gMJpEkyRjAwv37WFD5.3h02lY2bI5oVuOYHeIi32Joh795hcdWEbp5hfnw
 tBXgOORQpfikKV0bCB4JmebvB.UGl3JLtxj2taog4gflr0kVhy1QjRxtlHhPOUNcVleh29L6LQsY
 da8kGQ8Z.qpO1W8Nedef.ASsscaoq6TJv2YABCAuBECPEYrnW7uteo1wRlhlplE47Thu2krqs_qN
 8g9IOnBqfzT46qla5E4gGdNQwxDfgCa4GzGbp0r.J8WxInqcVzxw86U75h93HRJfh7_L3xrfOJOr
 MXAtOf.bLFemO7E6KBYgejSURI5.0JGQpunhSCh4Tgtks7XTZgDrHtme40Py2xKuSHBfIbZ.V08O
 _IzdGg0y028DkZ6l3FXJo2anz5l.4kNf4XvJpnCiXNUHXt8wFCUsbwQtSM3jUoI_BkyLU9FpK3ei
 p0OhykuIzyoa_844bado_gCPPac.05Jz65wMqZ0Cmn6QpZ.pdZH0UNB4.59Of9J9q8c0fhz8nLJo
 .OrdUCBUGVTOoiv5zw9bYwEe7Of2yIt1lnyL3uji91Ordjuzba6exZBrmCNUKBw9xv00Ut6cWKsp
 fjzeEDSXov6EeirBjZFEgj6aVS3.iI7zeHAZzk26DRgg_Z23lW1FhHNVH8BB1z3r.C8MYka7.mqV
 CkZYxk5.hkZM5jRdfGTqxqtEYmNyFTWFkiTO_X9VQnXaV8DetkWJZoyXqvJqTSHW_vM3BLmEEoAp
 H2kQFfc23.7sp6FoCBvmOICfqG1DF8LJjljgyD59X3G1xevomTHKdwDe3dmR49f.i1ytVH3L8PoE
 3uFMOYGFKwCSw3rTlCpvTyupGGX6gse1qAIfDPP.rY7M24JQkxKHYcyvpGmuxB8pdghF4piZM5dA
 Lmad9XfJueeaqYXu_DM1qqEzUXTCXgwpO6dS1tu9F4F67o251Dt91CdFJmic_P.__9GGulcCES4S
 EdETlk2EuV_ODaEB19TXU2ns.1CjTxOl2GbaG63tW9142qOO4VG1aT.4QqcPt.FKb34xyUmWJL0Y
 aI_DmCp00OtHh9d6hAqINxCLRxLQpNmuQ.9SxdxK4FQKVcUX5vkOJuwNioeGb9dlMge39GOV_Agc
 jToAHUpK35AWClE2VVAMuEK3Hx5OLBIBS49r3SF7Y8wLl0AIdAKFQmKnHScJbxtmCLfrrj9EBliB
 6GxKOZbewPskw2K1anB4D8qFumdCUY4DyvH4gbWGSlh9TTemwhS1L46rzOH9Afp74ZpzWmt.SgNy
 rNykpRP_nVacv.zgG7nRTR08kawIl3FepNtpGA0yJ8FmJjxqPYV88HxRH2y1V0vCf60__dzAYQF_
 Pk11kJguxF5aFSLT6P1MGRuATyVXmk7Owdsa7UsoIaPezR4z2Uiy6hgCOLczAO1M6A00LLJX3qJd
 IHqubOIx6FcNFCfd7fG_4SqwBs5Zq6w69deatiB3L4PLgdsv_BDPo16srr2Zc9JMbbTS58e7KIVM
 smxAnbtzJnOVNA8FlVKOAK9WY2tvObaSdkcOvUL_AdR7bCJQUhmUyBeY4SDBtCBojqG5tQJsnZW8
 GU0RfTppkZFIckP7kzbgnaD71ivWPA7XFsOykdlPW_Rt8xVO92mj4As3L_PZ.nH7wYZrH7r8W1sH
 TnwiXa1okfTaN9T2FI.1PLdCw5vfQi6_ANs271vh.LWOWc8ApLBoocoRdFYqISPsMQwrH40Zo6Iz
 YxuIbo5OxQL.yvq_SRlHs7_PqXbcCrNXXnt_fNsiGI_dasrWuG0rmnMZL59HXSB_DDrySwfCX0.8
 nN74YpKqahf3kFLjn7RwfjJ8YAQQyadR7d0qSuee_eXaA
X-Sonic-MF: <sumanth.gavini@yahoo.com>
X-Sonic-ID: a4fdc27a-feff-43de-adb5-bc10c078fb40
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.sg3.yahoo.com with HTTP; Fri, 23 May 2025 22:02:44 +0000
Received: by hermes--production-gq1-74d64bb7d7-ntkkg (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 248dee39e4af4432b83091d1a9b4c06a;
          Fri, 23 May 2025 22:02:42 +0000 (UTC)
From: Sumanth Gavini <sumanth.gavini@yahoo.com>
To: skhan@linuxfoundation.org,
	rjw@rjwysocki.net,
	stern@rowland.harvard.edu,
	arjan@linux.intel.com,
	linux@dominikbrodowski.net
Cc: Sumanth Gavini <sumanth.gavini@yahoo.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2] docs: ABI: Fix "diasble" to "disable"
Date: Fri, 23 May 2025 15:02:37 -0700
Message-ID: <20250523220238.455718-1-sumanth.gavini@yahoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <a0f5b68d-e321-4ed3-a22c-24f80f4d906f@linuxfoundation.org>
References: <a0f5b68d-e321-4ed3-a22c-24f80f4d906f@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 Fix misspelling reported by codespell

Signed-off-by: Sumanth Gavini <sumanth.gavini@yahoo.com>
---
changes in v2:
- No code changes
  - Link to v1: https://lore.kernel.org/lkml/a0f5b68d-e321-4ed3-a22c-24f80f4d906f@linuxfoundation.org/
- Addressed review comments from Shuah Khan.
  - get_maintainers.pl doesn't give you the complete list, So resending
    the patchv2 with linux-pm, doccumentation list and PM maintainers

---
 Documentation/ABI/testing/sysfs-devices-power | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-power b/Documentation/ABI/testing/sysfs-devices-power
index 54195530e97a..d3da88b26a53 100644
--- a/Documentation/ABI/testing/sysfs-devices-power
+++ b/Documentation/ABI/testing/sysfs-devices-power
@@ -56,7 +56,7 @@ Date:		January 2009
 Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
 Description:
 		The /sys/devices/.../async attribute allows the user space to
-		enable or diasble the device's suspend and resume callbacks to
+		enable or disable the device's suspend and resume callbacks to
 		be executed asynchronously (ie. in separate threads, in parallel
 		with the main suspend/resume thread) during system-wide power
 		transitions (eg. suspend to RAM, hibernation).
-- 
2.43.0


