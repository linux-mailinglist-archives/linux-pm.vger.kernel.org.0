Return-Path: <linux-pm+bounces-37880-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C66C54814
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 21:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D57594E1E25
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 20:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41362C159A;
	Wed, 12 Nov 2025 20:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9HmdC8d"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C47242D91
	for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 20:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762980171; cv=none; b=Cm4fO1NCv0VAoZn+jIbP3MRsGaqKWTd5UlUA5oJAQFIWHDWnVx0jSZYVIuotvrmg1iAe44ypKwt1/kemtGkaG9POMvihTSObmBQ2Pe8pPyGIYSnN7uUiLu8/noF9NYLmPD8vq4TErvRWPEMb4VJurPdFaf/4f4JNsAAZPZcLosg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762980171; c=relaxed/simple;
	bh=B26hrNmYi6XQEGPnMIeB4tF8WMLyskH7o/DQg1cKnwY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XUkVrwEN+IgvudND9u5e7GFzpQHCDDv+iAOd/ab324rCvXLLn3220KLfglVENx7pDraPEKRoLr7Lt+KZFaJK4cWK+/UHgNdEhIyKItfpBmvKur0ZvAxiZWswDK4GiBmQAA9bGRxL7icsn7O90wuTeW7/l4uGDKbD76E1ql/4tkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9HmdC8d; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64198771a9bso128333a12.2
        for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 12:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762980168; x=1763584968; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qYRlTpYA/7Q8cmYHoawv0jNTOuUhyYj1/N3pLlPxP7U=;
        b=A9HmdC8dQreyTzbu/PQGjEyDWx5tS3QpnZrCHp6ej+r1QKnLEWU/0L5dTWtFawVdRi
         n9Fw9mAtZ2eo5yNhNv4R51sH7/tQQ69i8JT9Jfo+JgkBJzXEMdsx3W1EJUlAkZIPkHTX
         lMgXNYQAkGHLB6rdaZPkouBqxmK8Lw2l0N1jg/vkqvVIdfA1ibge4wswOVUoAW4yywE+
         Gn+NWjwx7p4BtpptElAZvX0nIMifCHst1nJgR2zuAN3OKq4SuQhCfWHKKJFlJbQO5MOM
         UtWsGzJ6BHIVYTZfh3Cc5dHdrJT3UBXRlOnDGfMhwPqU7RmXehU62hd41HBmKD6r6a1O
         vhTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762980168; x=1763584968;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYRlTpYA/7Q8cmYHoawv0jNTOuUhyYj1/N3pLlPxP7U=;
        b=GzqvTtl1iUDS9RbQBU/ANLbZP+v0G1n5zWkkWGbFkB0qOfVYqe3tbeqvIFSziUP9hQ
         IUW9Du2BfPKe3U0fp8yWnpH7XIeUU0okZKtIKOTqMWA5zV1zX8+VDvUXxP/W3blz4kEf
         GO5arYc51g5WMPZ1IX4t1wOFPnX8s5jGyVpYLcI/dRa3XgeXvSRw79TGPt3OifI+7oE4
         pAc+vZqV16DWzozPpU2zzapx0M3USl7btTZzcyqB4y0jjXFE0774APaulejgH0G2QrRR
         UX25lVuJAtGkOzKLDdqelSxUrkKyOS614KgG9wrNZ8iwZQ4iiz2R6o4Jn/INMrftrLKG
         KEqg==
X-Forwarded-Encrypted: i=1; AJvYcCWakDX6DZz3x0jC6vZ3BcZiO35XT1fXxUIbB7iydTX6d3I7dNx9oKIGiQN7ypqGiXOmHg9q1xkoTw==@vger.kernel.org
X-Gm-Message-State: AOJu0YykJ5jdbYE9OY7GLEJKqt4mk9dFtC6GQx9vcywzZBScx0pJAvqv
	R7d6wRkp7eZYqQb6Wu7YEU6UFzc6Czoz06SZ/17slmKmKaErOSRKcZ++
X-Gm-Gg: ASbGncsatp64735VvXxwfLJIM532Fw7Ky71XsvlylaFr+X/K3HYMUivOhCGkH/Y9DJz
	/1+oxmWYr3TR2SkFUJsglGyB0JAeEj1WWpPFf1IYJRpFdmdAJXgNyrxpJkPZ8pLQyuZbB2raxNb
	tje6AGdCF75Ebg5KAry3gVmB0VN4uJd9439W0tnxvxNhkw/hLiF9t+QmBw/b1YAVO2XeoneHFeU
	0UwR3esQMT14B5Eca5WsBW+t7iCBQx9h5LNXNrx2FvZvrq6kdonNbiU3B7EdTcCy1iwGk4ZmV7j
	o8iW+agymrVfBPolidnMPWskCbTfOBL0bqT7uVdSDv5n8fCkbHQpJztF5XVryftIRioTg/DnlOb
	zYjcfEcz4oFFDAv0+qyn42vdr88P2frhs6GY2NiLdliyFp2YFLfOA6xak6xFLtHxUKHv40fGtM0
	ePDabz3J4SdozF46Qu1DwbGMiqomiG6Q==
X-Google-Smtp-Source: AGHT+IG+jx+M3nE36Fz5bthJFfjspwcmRI7tEfhQmZIEm5r+HcFJgbvQic4eUr3n+TZlrw7O4BctyQ==
X-Received: by 2002:a17:907:6092:b0:b6d:62e4:a63a with SMTP id a640c23a62f3a-b7331aa9775mr491880066b.40.1762980168240;
        Wed, 12 Nov 2025 12:42:48 -0800 (PST)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b72bf9bc214sm1742888366b.52.2025.11.12.12.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 12:42:47 -0800 (PST)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Wed, 12 Nov 2025 21:42:41 +0100
Subject: [PATCH] interconnect: icc-clk: clear enabled flag only when it is
 set
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-icc-clk-disable-cleanup-v1-1-fa4794bf5cc8@gmail.com>
X-B4-Tracking: v=1; b=H4sIAEDxFGkC/x2MzQqDMBAGX0X23IUk+IevUnqIm09dlFQSLAXx3
 Q3eZg4zJ2UkRaahOinhp1m/sYh9VSSLjzNYQ3FyxjXWuI5VhGVbOWj244bC8PHYuanbXmzoMRp
 QqfeESf/P+f25rhtpDyS5aQAAAA==
X-Change-ID: 20251027-icc-clk-disable-cleanup-5468c1d8eb0e
To: Georgi Djakov <djakov@kernel.org>
Cc: Dmitry Baryshkov <lumag@kernel.org>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2

It is pointless to clear the enabled flag when it is cleared already, so
change the code to do that only when the flag is set.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/interconnect/icc-clk.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/interconnect/icc-clk.c b/drivers/interconnect/icc-clk.c
index 93c030608d3e0aad7d9c1ed81a51dcde0d3f85ab..6bbafe8fc6bdf6c036eafab6db8b68687611d6b6 100644
--- a/drivers/interconnect/icc-clk.c
+++ b/drivers/interconnect/icc-clk.c
@@ -31,9 +31,10 @@ static int icc_clk_set(struct icc_node *src, struct icc_node *dst)
 		return 0;
 
 	if (!src->peak_bw) {
-		if (qn->enabled)
+		if (qn->enabled) {
 			clk_disable_unprepare(qn->clk);
-		qn->enabled = false;
+			qn->enabled = false;
+		}
 
 		return 0;
 	}

---
base-commit: 41aa8dd5b19c447686b68e6730d348ecc0373143
change-id: 20251027-icc-clk-disable-cleanup-5468c1d8eb0e

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


