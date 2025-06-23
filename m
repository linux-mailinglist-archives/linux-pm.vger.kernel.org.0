Return-Path: <linux-pm+bounces-29258-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB89AE380A
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 10:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0FF61888667
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 08:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F7D21D3F6;
	Mon, 23 Jun 2025 08:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="evW6TOgF"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F257B20D4F9
	for <linux-pm@vger.kernel.org>; Mon, 23 Jun 2025 08:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750666372; cv=none; b=kQ6ryL4/FXW1aV00+JlpYkJctSUpIWIzteFNqZD+FY1Vn6Sp9e4mSk/vLGJR2fckwQsB14wk+SPr4MMG74vC4jSf9UBUsbUrhmsdMxMvgnVhkUOY9TIx95bPefzrr0msYVQfglOasHAusj4NG5mbZr/1QokQMTyGY7AYyO0FNvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750666372; c=relaxed/simple;
	bh=gPbrjKfb3/t9+bJ97l2JcUsCeLq8NB/AHeQm+JnD8Tg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZF5IK0v34mOUKOh5MnxQMuJk29eiEb/E7YiB+/Sk/zw5UiP79IcedWYBx5PKBk1vjJqNmbXao5Rpql7kH+QUnaC6uWDpmKia5FIiPbtH0OdWMO74fc40MWdnUb3PBAfIVuRp0Os7NVUNjnQhBIEFoe3Gjjm3+2SjjtVryGuZigc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=evW6TOgF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750666369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ely3LYIH5ApPb1uTkKRY78N4Y4FDOftaWbIcVrfOOjk=;
	b=evW6TOgFkO1OY+8dsGYT8jRcX8V9vMMggMd6AOmBiUmuIyjXjvaRuZxbfUkNs627WiUtS0
	kHd1JayymoNYMLf63SLls+RlLhZn4OMGlWgewnAfcwdliRoygA9uXStm9J/VDNUSdLCptB
	2D+LxDNOeMV5oBae8blgkLuYHjywhgw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-aF2Y_geSNQyssumo7ROw3w-1; Mon, 23 Jun 2025 04:12:46 -0400
X-MC-Unique: aF2Y_geSNQyssumo7ROw3w-1
X-Mimecast-MFC-AGG-ID: aF2Y_geSNQyssumo7ROw3w_1750666365
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-606f507ede7so3428918a12.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Jun 2025 01:12:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750666365; x=1751271165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ely3LYIH5ApPb1uTkKRY78N4Y4FDOftaWbIcVrfOOjk=;
        b=AV4W4oxUAvT5OQWRfgj6D8MHHeIXrIxq/S0dmu1uZY7sx3h49hnsZVcfvSSpmJ9uzC
         faLT7ydUwHqu8d2vzZ5/UVh7ef+J+fsnnLspaq+B2ypEzGIVnZD7jAHUd3sqU3pwcsdk
         6/GdFYF1QZSjLW7pRjkF+PQ2AQOs3K+xQ+AlUHCO9I8d4NkLub7sZrGlomySKmGbo19f
         49f9BmvFAov8NaddbuOwQKxz/lUM2OyNeLlHmTRS2zCP712Z3/3nnc6NK/uJpCfHFfwN
         YwdAtsuqRWjuU1lhvaNUUgf2qtrHM5urOTPb8IFlR3yoiSD29gbbw25T2z6SIdOx554v
         GZMA==
X-Forwarded-Encrypted: i=1; AJvYcCWGnS131Lqf4xWjbGktkyq+owWC6M012o6+6c9zIW09qqN2KpKs3+7WJVcglhqLU8p3seTYGXHysA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwE1JSV7cKfdnKtuzFQMpFY9pQTK3dpcDQyknSSbkfFFWKtP3a0
	MRBYClYZBm/GpPa+dfN5jN3GFYrR63tENorsIooiWLX5BPjeqmCYV6oAVIXbpkEfBKcTsI/B+Gk
	LwILTMnNFfETvqNtuKfX36lwOgcNwStrK/zoiIkgq7na+q1mbb+xdjgRfKtmD
X-Gm-Gg: ASbGncvAChVzl3mhEyoy3Mq7rgLK24RAChw6lksmPZn3vSkoN5KmIbtDUfQGiM0k5g3
	NIFOcQUkFwg7QIxO3VukOc94tQShcQFJA/RCfWBs96XGFZO6xqicv3KzdLZ5y3we+H2BPT9Ymzo
	tn4ynDKmVbfh0l0VBdpoGVcSjnHmqoPdOc5GwclXA8XEOqTVzvDjqVH7OxIPvcN0txd466i20Cc
	G9fqPz76B0bvYIohHbC3YqRpOqbybrrjmwR/4nZhW94ZkhW/DK8dQhq+2S0YM+CNUp4Be3fbzKZ
	nrOdZnxquk6XliZgg/tSe0PMbUtn7cwzkIIdA54a7Ozl6YjPOUU0lThFmAULJW6nYGpL
X-Received: by 2002:a05:6402:2744:b0:607:6097:2f9c with SMTP id 4fb4d7f45d1cf-60a1cd1d0e8mr9228991a12.21.1750666365434;
        Mon, 23 Jun 2025 01:12:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmSn5SEBbkY2WzQ8Wstprge0mliWZNTw4CyeFgF4x1e2Q598sLsTkhN06aRTXMr6PAByyRyg==
X-Received: by 2002:a05:6402:2744:b0:607:6097:2f9c with SMTP id 4fb4d7f45d1cf-60a1cd1d0e8mr9228976a12.21.1750666365083;
        Mon, 23 Jun 2025 01:12:45 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e01:ef00:b52:2ad9:f357:f709])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60a18c9769fsm5838013a12.40.2025.06.23.01.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 01:12:44 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Casey Connolly <casey.connolly@linaro.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: rectify file entry in QUALCOMM SMB CHARGER DRIVER
Date: Mon, 23 Jun 2025 10:12:40 +0200
Message-ID: <20250623081240.149446-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit 4deeea4b0741  ("MAINTAINERS: add myself as smbx charger driver
maintainer") adds the section QUALCOMM SMB CHARGER DRIVER in MAINTAINERS,
including a file entry pointing to qcom_smbx_charger.c. Within the same
patch series, the commit 5ec53bcc7fce ("power: supply: pmi8998_charger:
rename to qcom_smbx") renames qcom_pmi8998_charger.c to qcom_smbx.c and not
to qcom_smbx_charger.c, though. Note that the commit message clearly
indicates the intentional removal of the "_charger" suffix.

Refer to the intended file.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 41f13ccef4c8..c76ea415c56f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20612,7 +20612,7 @@ M:	Casey Connolly <casey.connolly@linaro.org>
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
-F:	drivers/power/supply/qcom_smbx_charger.c
+F:	drivers/power/supply/qcom_smbx.c
 
 QUALCOMM QSEECOM DRIVER
 M:	Maximilian Luz <luzmaximilian@gmail.com>
-- 
2.49.0


