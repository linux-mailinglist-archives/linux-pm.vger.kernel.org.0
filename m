Return-Path: <linux-pm+bounces-28514-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F157AD6265
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 00:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 548E73AAD9A
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 22:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698ED242D84;
	Wed, 11 Jun 2025 22:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="N1AplYhj"
X-Original-To: linux-pm@vger.kernel.org
Received: from sonic309-47.consmr.mail.sg3.yahoo.com (sonic309-47.consmr.mail.sg3.yahoo.com [106.10.244.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9620786342
	for <linux-pm@vger.kernel.org>; Wed, 11 Jun 2025 22:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.244.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749681351; cv=none; b=IQArOQ32XzxvDzsMDL2w/RWDo856sfC9MptxAYnRUQpUw9JSRIJHgCNwW9ZHXu88YonBfVT5wZ4PS/33ftGP4R5eJFenU3kkK2bAxgTaaIqFEiQATGVUZFO2A36mRhALCjREW/Jfg/jIjsj3LClx5Z9AJh2HGKaFYFV5IwVV8Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749681351; c=relaxed/simple;
	bh=/0Vdo2n4vBWv00iFSktmhK52XeKrbW6rz6XK2gUH1Ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LlK41CXmuBpdszRKgi/4wQn+iKAxrhSImicMGHoMktoUavZYIunuQArGHvM0MLxBTTghkSrJeDVv7Nvr9apoUQAM7ac1QUR4sTTpcs4MZbQ3oQqk0i/GG/xrlZaHb6w9OLeZVYILrIXsNrF+g41oyPlwLG7WPV72I23kUM1cxfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=N1AplYhj; arc=none smtp.client-ip=106.10.244.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1749681347; bh=Rn5w/P+M1tuc2960ReqD3yHmxZwhUR9NzbcqGhHPW7M=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=N1AplYhjzUFlIZtpPnDdDhclNaJDEzCosejw92oHDNQJl/naR1zEhlO5zUvQXRxkXqGAqlEkSDcS0UAepNYuAWBBv2BGqIk1GKpEvt2FjqFrIbG2ZNuRA6lkV2uim1sMojRLypNM6NIvkpi3RUelWry+Isby4H6thd7znbRQSJWpkhozLSZRjVrnXCtrroOyfOBRgMDfiHec1+zs/9kDF8PL6DP1PBrMvZDmsCxHLyLyAkdkHemWLJEU+5GtOraMSXmgtmCRmlWGO4jkfZTRJP3NLoZhyJ1AJEtYid4c6omw677SmzrVhuZsZd3pgI4sxMLY+sKgVIzdJDk8CSfFXw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1749681347; bh=5FKii5pTTT3JaJ6ALr0j2h4n2hyIILhMfn20qRxePGm=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=PqJp0iouAoGemjJz0wI8K2z3Wqmu9tkrTtvuE/MsTBXutwyPBOUw9xzKK/MRkv7ekvmKQGcFj+4fGa0iplFdRTHk0dEOwbIEIAAHZtYz4Ced1gGvXJ+iRvIl4zgDKHHeZG5dpBWIB9Zz+A5cKE5Az8+KiDHifyvstddiiPhscd2ZG7ze1nGaNfiZclyV9WVWueNqDwxt3kJnRJUalGOeExUSbr8KzAl30edHrKmYvDj0VCzhdO+ll6Snyy+vxfcH+WUHHCb59tt8cPRXGpF8grN8S65OEW3Eu90Jvsi+WF0GLMV6ZCtpxZAnXL2rUsHHJI/FeZqNQ3Jqbt5N9VVk0g==
X-YMail-OSG: a.2tuGwVM1kfTLH6cec8WQUaPjVAFMdGc_qj0obGbzt8ygiI76p6JNr6G_t7TNU
 xGuN5cd9OoP7wXqGpGsp9X9ZpLcBbjDfzYqVBz_QHh9IE.29GFtDVbvjEnCdmMCkK6Z_LV1M9lY7
 Cm1dWqolJibkZSHRbGeqWxPJNL.6m2zdGykka4rcqAlejOlA3IPABXmixc_Ea0BIMYUgWINPBok7
 Fcm_ugku.30z8XXilYtUqN4J7cDq0dTBPS8QomNEfi5GupqZmQmQJGxUin2BD5RKQYKo7G3hsd7g
 IAldcfyTWeNTQWAorNfklhHBAx8jASU7j0.JmmJyUd35cpiJNjx06DnLBVtPCrnx.xfz5b2GnaYO
 VOAhw955azmutM.vZJmUA99CUDIE_Oa6FdFGgcuRviNQH4wx.HBZCXAHV7QUNArgzC4NEV6vbvT6
 upOpgG_iT4.g8VhnAsXpyEDAcM8Ml3ua0qlSyifZRJCEheSYAoB2V8f8LLpoO9iVxOzwJNd6i3WN
 oqQNq6Cm9C.7x8bSseYohwx4FEx6tf0ZPEr2G3Hra.QHeMpxBzDKa1VsskgsDjW9oPY46y3dysxq
 TQWRzYC_mh3PX._ac7a3LqI2bn1zsI.0uuHC9ZupasHF_PGCcROdrcfXGqvgvDapl_7z9J7Jka0h
 30YCshIZCE2_88vQ4cri5LLBnKE8FB3S6ck0vlmk0NlFqB3mdGFdyLrUrZFJaHH_llf91s3MiI6h
 i1BpwNaZXpZvHJ2pI8wncO_cSHcSloQFeYSO2JD3Vp6OGZGtMWFA._mMxMUOLNlTN3Cv7bkNpvmI
 GdolRtY0kBO723j.995iZpv7h4FTmlTYL8.I5MlI8zs_RoToFlxG4cr_zvfqZze6plhPHOpiOY90
 Lv_gaJgvKj7IxBir8kSh5hcSweRV8V5Niq8Y1x08.Yp7C1D0YUTMNhDKFHxKmQbEFM1d6emeNRm6
 d51o2rlSNmd0afFhiFzq8nQH62blgpT2gYU.I7IRvxW3npQLWPrI6NmKwuJbBwx.bzAQAIureylV
 ptwFv1ziUygDfS001u4EU9UiqCp6rqCYRB4epJ4hPm0.DXBksKGhvsGj9vcv76lJo_.HjwXswVON
 lTYM6tXkDvK0PEnLH1OjFcUOAjMav6hMN1eMp25y_C89inUF2WNAIOLz7EBG87IzWBtp8CHqMiiF
 UriGno6HFimBoQ5VTnX9PtJhFoiNVD8TY.NJeAF73WxRoEgSDW8_PJCvhvi8jw.eg.e0629Zj1Yq
 4OJt7g8tmVqytzi0kc1tN9gstyWPI3Z8MNTIqI6seWCu66AWgmSnwk42YOzs.ryZ5FFhhlVc9WTc
 6BUHY3jALbge7ezobBp60qb1oZS2CnBDYHAsyA_UgWd5LHf7L2gGU_875oFZRm8qDLKhKJ_4qsQ4
 bVvnM0Etzinzlqjixt2YjHfrNPNJjb68gFoIpyrI6Bp71pra9P9afraiYnkR5mjuwF9chVErmN7y
 uGDV7nQ6U.bZmbqurg1Dtwh9jBswdrDx7Kua0IFGqUGYKmAA2OezdA.8whW5TaD85SI058LICV.A
 6tloNepag8tY4m9VAvOCm9QP08JSYGacFwlvbXbyxdvdz18vNF6zAcMV.kYaoCDPyZeCQHO0Dvbb
 mK1R0dyhDGsBd7Wpqt0mC1.T1RqAWfnK05ulpVi3j6u8hB5PFuMMrWbIA73p8lczP5sdkC.oXueI
 kYZeHAYiVsPAPUkWRJscLs3sdUhm2nj_EfV5hrPSsjLZqwVjMXvRVZb1UJAj6S10U4VTBIniv76c
 7xC5VUtYn0wfHKq8P1T5sPa6BDFjoJ_YHgFJrY5Xn4dFuIphUmF00ZcexwuxJ.uLK4EwE3PQ22Q0
 VUM2Lm7n8Sr75gmSkrpFw5yKA7Tyi2go4dysvxqvqFLaN7tywT5v9zub3OXfFrxL4SvL5ixv0kBW
 Ss5guBVKB8w_wxHsrJRA6Hhzky1Z7_LMlcHHEg2NRw33jPxt2O3vrQwV7mR7epJwfXAI..d80x8c
 CqPoh06oKAcpiLQvpcBwambQJGiSN3SNGVGsBrJmlvtTai2OFbc720uadlZC.u2qwOWPiWKTOBBX
 WQgE.DZb_.KMDL0vOKRduPadta6G9QAIuj1ImOqFrmJZsOdJCRfE_L.CiwZR9z91TZKklo3LI_Vn
 WqEanhCjtAZwkRGAN1mV0ACe6bVodKf97_FU4DydmxTI8rodceS.A.30HsqG79WmQTW6EP4l0Xho
 jBR0ry4.R9tv2_VjeSgwIGDNZJq_lr3Yziv_mhHn15vZiLUoo_fxgSVU9h176mEgnoQUIjB4IPxk
 0aEP80XEW8CLsfoRTCFwjnn48kji2yUvip.MZ_oQvz9pcIoxWNdU-
X-Sonic-MF: <sumanth.gavini@yahoo.com>
X-Sonic-ID: d3e8ac7e-f1a1-4672-bbca-d7271f1c36cb
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.sg3.yahoo.com with HTTP; Wed, 11 Jun 2025 22:35:47 +0000
Received: by hermes--production-ne1-9495dc4d7-psbrp (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2ed6d631eec321540bbe8aaca754edee;
          Wed, 11 Jun 2025 21:53:10 +0000 (UTC)
From: Sumanth Gavini <sumanth.gavini@yahoo.com>
To: sumanth.gavini@yahoo.com
Cc: arjan@linux.intel.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux@dominikbrodowski.net,
	rjw@rjwysocki.net,
	skhan@linuxfoundation.org,
	stern@rowland.harvard.edu
Subject: [PATCH v2] docs: ABI: Fix "diasble" to "disable"
Date: Wed, 11 Jun 2025 16:53:06 -0500
Message-ID: <20250611215306.2989590-1-sumanth.gavini@yahoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250523220238.455718-1-sumanth.gavini@yahoo.com>
References: <20250523220238.455718-1-sumanth.gavini@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Shuah,

Just following up on my patch submitted on 2025-05-23 22:02  with subject "[[PATCH v2] docs: ABI: Fix "diasble" to "disable"]".

Original message: https://lore.kernel.org/all/20250523220238.455718-1-sumanth.gavini@yahoo.com/

Would you have any feedback on this change? I'd be happy to address any comments or concerns.

Thank you for your time and consideration.

Best regards,
Sumanth Gavini

