Return-Path: <linux-pm+bounces-41327-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKHAEfx8cmmklQAAu9opvQ
	(envelope-from <linux-pm+bounces-41327-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 20:39:40 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D676D200
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 20:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C39E3030E92
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 19:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB59739573A;
	Thu, 22 Jan 2026 19:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtrpSa1t"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C413034D939
	for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 19:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769110486; cv=none; b=ky02JyYKmvJ6ebzpj4iKzar8uonVN230yzidTQMcpA9RvzcPtc2rWZAsIg7ogGnh3DxfEG6tOjxl81c8V/2I3UFXBQmO5pp+Bn5Z66FE6aZEHL4AYS9DClu65Lk4jlUbDN9c1OkKsgFP6uku7Pe6ukZDIcUjnj+Kvb15ajk3NKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769110486; c=relaxed/simple;
	bh=CrxFUxr1mrz5eB+5MqEJWwahrvuI86sk5sMY/Qw1ky0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E/oRUgxLmQrUPEtJN05TOUJnx+/C1a7KHFkhGr7ewYgHfqc2y2IW1m6zeytHYAHQndslKTtuMWx32v2v5TbgjX7CAIvGGvJSMjMSYWr+vAZEPsRYmVPmiF6e91YEhEeye0StK7b6UuXBJYl933FWf5nr9/9JxtNZeBHBJY15lIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtrpSa1t; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-432d2c7dd52so1402196f8f.2
        for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 11:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769110475; x=1769715275; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=To9ayxXdRoh6y4Rqdir3oO1ZDYFf362lQecdeoxQawk=;
        b=YtrpSa1tOHvAIhwXezVvbv+2yGsAWg32ptxd7qkTuXtcfJ6oLBBCKJj+sso+3sdQTz
         BYPnhfxBRea4BQn0KCe4GMgqJGzEWy2n32IRNG42535L8ivM0yapNuaJzO8luQVrWFyG
         2rF5t0LCqPxTyQwF+iRLWxpw0hGy1og39zsHzF7qkz86I7abdLOcnwqJRs24sC+th9BT
         Yu7gKzOUyTCYANBlHYqT8yfQuHtCKPhVNNLfSV4zz8MqWExv63mQP7kHaqpN+on0f+yJ
         cTNxSBxz6rwtomoiSlSosTGfUJDn4og2oV/tqPy4BohHX8YtY5j2LnH/tf0f008Obq00
         SeLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769110475; x=1769715275;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=To9ayxXdRoh6y4Rqdir3oO1ZDYFf362lQecdeoxQawk=;
        b=haHDHiEr3BgTAFK0VSmN7AL36uJeV2ockqSP9t94pSTIc6GbitttzDk0VIy7zfTM1x
         /tpAZZs5fpYiI3WqJ/fQZkfGCzXol47GEvXt0bCS3ceES0Wyx2Bl9R8b2t6/3KSY58ak
         IkENX0klwCPfzzNc5xejLx220qzgraSG9rII+8WEZ5UWPXOIR89p5o8vr/IOMIyK6OzS
         iUnKezWwfsoOe/AyBdGrPHE8Ra044yL0rm/YJ9oip8DV/V6pJq15liy8TKBuZXwnPWhD
         M4Nee6co3yyofY9eBm19mpJBmjZMeYJLZ685FZR5M/MKTjrZbmaMfH3NBZWprCQuwhgo
         B02Q==
X-Forwarded-Encrypted: i=1; AJvYcCXdxeVjijjEfNlvMM/mVzvv6z3MxZ6I3JksFeWBtJSST8cknFfo12GtcTAtpQRuwBb+SqwagpvzMA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyubFItX24ZjCdtkLQsps1+ZNgk0EZoaBGjDyS+CzjfKIVL2Cb4
	B1BMFYtojzi5n/gp4xyfe5mGs5BseyXSsCorUB60Q62683rBmyLuG/H7
X-Gm-Gg: AZuq6aKEXwrjFYy05i16wdPV8Ck3Fu9jepQjlBO2XvvRgq6TDZkl5ruJMsizlZGXwvs
	SGyGYQjeO++2brKNcjIzdaI2twAUT3aryBf95KGZX7FACSFY/GJhbwaCkiCZHphUY34nxqDIvfy
	8reXph2orwePGiPjjiE6hb27m09kfVLXwOLEUVHQxbBBy+bmQKl+06RrGNeGIbvsb16qVF2s05T
	Twcj6w596paz9Tzkgm85Zdu+7qNzABaPrSSw8JxbeQJ0oFqqF4u68LNke7Lzm/RgWDql+khBvHH
	SOFQKon7BkaXe9xCB9rN9ml4h9RK2bP98grKdpTF6D/40frlvO+O4tCwrgqltXkxPN2TzAhr0Yx
	UjGDg07q/8fvU69oh9aN5WAt2+O3AaEe4ivPoXVKFt4uOZ9sKn0HY5bHO12MSeP2j/VS49nEDgd
	8nGs2prGmP8BlZh/kf5i5pawYMWZ+zA0trwReUsY3i
X-Received: by 2002:a5d:588b:0:b0:435:a464:f468 with SMTP id ffacd0b85a97d-435b1606246mr1084984f8f.47.1769110474677;
        Thu, 22 Jan 2026 11:34:34 -0800 (PST)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-435b1c02dd4sm853240f8f.5.2026.01.22.11.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 11:34:34 -0800 (PST)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Thu, 22 Jan 2026 20:34:23 +0100
Subject: [PATCH 2/2] interconnect: qcom: msm8974: drop duplicated
 RPM_BUS_{MASTER,SLAVE}_REQ defines
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-icc-qcom-dupe-defines-v1-2-eea876c2d98f@gmail.com>
References: <20260122-icc-qcom-dupe-defines-v1-0-eea876c2d98f@gmail.com>
In-Reply-To: <20260122-icc-qcom-dupe-defines-v1-0-eea876c2d98f@gmail.com>
To: Georgi Djakov <djakov@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-41327-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j4g8y7@gmail.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A1D676D200
X-Rspamd-Action: no action

Both the RPM_BUS_MASTER_REQ and the RPM_BUS_SLAVE_REQ constants are
also defined in the 'icc-rpm.h' header.

  $ git grep -nHE 'define[[:blank:]]+RPM_BUS_MASTER_REQ[[:blank:]]'
  drivers/interconnect/qcom/icc-rpm.h:16:#define RPM_BUS_MASTER_REQ       0x73616d62
  drivers/interconnect/qcom/msm8974.c:176:#define RPM_BUS_MASTER_REQ      0x73616d62

  $ git grep -nHE 'define[[:blank:]]+RPM_BUS_SLAVE_REQ[[:blank:]]'
  drivers/interconnect/qcom/icc-rpm.h:17:#define RPM_BUS_SLAVE_REQ        0x766c7362
  drivers/interconnect/qcom/msm8974.c:177:#define RPM_BUS_SLAVE_REQ       0x766c7362

Drop the local defines to avoid the duplications.

No functional changes intended. Compile tested only.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/interconnect/qcom/msm8974.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/interconnect/qcom/msm8974.c b/drivers/interconnect/qcom/msm8974.c
index 469fc48ebfe94d9ebb723132564583f4790d4850..3239edc37f02f20bd65fbbcb4aa48dc7953c7c09 100644
--- a/drivers/interconnect/qcom/msm8974.c
+++ b/drivers/interconnect/qcom/msm8974.c
@@ -173,9 +173,6 @@ enum {
 	MSM8974_SNOC_SLV_QDSS_STM,
 };
 
-#define RPM_BUS_MASTER_REQ	0x73616d62
-#define RPM_BUS_SLAVE_REQ	0x766c7362
-
 #define to_msm8974_icc_provider(_provider) \
 	container_of(_provider, struct msm8974_icc_provider, provider)
 

-- 
2.52.0


