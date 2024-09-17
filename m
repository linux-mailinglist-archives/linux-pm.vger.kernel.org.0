Return-Path: <linux-pm+bounces-14378-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1B397B508
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 23:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9289F1C22B01
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 21:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5598818CC0A;
	Tue, 17 Sep 2024 21:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9YqAQGC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6332AEEE;
	Tue, 17 Sep 2024 21:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726607628; cv=none; b=NHt6dZDGbwFs2YIveKYwXo0S0wJOTY7MXcs4xIYQNj5d3/iPasLruO7ZddVaoWwGy8/qtlPI+b/o9YoooMrNByEqpaLCUokHXR8U6qDXUeMZM6a3Nt/nSlH8mWhE7dJ4uJGSRVuxupv6q303gjeKFe2VCKizAYTgt3zXUyK5oIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726607628; c=relaxed/simple;
	bh=4X3wjfPidt/LiD/CTXVhAiLZG8gvYHhMjugKG8MTr1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cXotlcmwdWVgoz+3okvGbzizkleIfSn4nJ5L8hjjm7Am7UNqDofT8L1mrSWoo1gloJAFYEw4QiL/LJpMu0zumasTRqyye8BlfftM58LUfS6S1hXUfyU0S46nVIcHxofGWS2mp9EnAuz0kWfPZDvj9eRAZhQNxyujHd+fPtaS6+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9YqAQGC; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cde6b5094so49579975e9.3;
        Tue, 17 Sep 2024 14:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726607625; x=1727212425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gQPCeSxuJUcAGQx1wAqP64lG5jHDZ2prYT74R2lhQOw=;
        b=a9YqAQGCZ/oMdRDOz1DLNKPidAtHVwZxUcpfA+nH0Nfw5GYTZtZWxodNYemmnYSnqi
         LFx8HprUqfi+eNgXe/pssCglRhwzspL5X7imEJYa35Y0KzSE1nP4aOugqg0WxfJQdnWF
         fm2e9hC58S/faNttSGDsHZjzzHapOnt83vwTE01mCYze9qR7rlHvzpcuvpMoaClU4FdG
         reF/aKoCjCSvyInRJz308svqAzKALASJQHM5Ideup6HCFlfEVjKkZKF8KKeXNL3nZWiA
         nLCN0esTgms4hIpCvZ6WLY/5TB2sc1G/YuPu1QXkhBBXM79heT9e/7YdyKKP3KsZwas3
         VXzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726607625; x=1727212425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gQPCeSxuJUcAGQx1wAqP64lG5jHDZ2prYT74R2lhQOw=;
        b=SrkC9fhiVelJzq3dgNwiOXqJd7C5dt/vVf4n52aGANrPkGKrVcjrUJ9krVPHmulDH/
         zHjejPmDfowIH77gaLuRwEDzTaa7baLdsOH6uNG5fHqL+58ALYiMuPfHfVV3z8K8vhXW
         bAkIa65Z1Oix5awnNv/2XUAmRNDWHCjVkhprxgNUnpcFayndRpURNYfd/kFrTc1AnW1Z
         xlAvQ5IuciUfD0LXH7vaWUA8/NnwI0hyEkp0x+InCOLsvEwEe3PaoIn/9FdR90s5pBVV
         XEa8aXXqxFSopiFeZS3IqFr9Ji4FG6xkSsntK56nFbD1QsLW3DLcLG5lG9DtC/zLg/td
         MWPA==
X-Forwarded-Encrypted: i=1; AJvYcCUYq06Oi7zvMSOmC6pns2f/Dndb3eDIfxHD0pIXGaBTz59QWviCvi7KNv0HVkIL2dvcpYozSHkyOow=@vger.kernel.org, AJvYcCUsRI0+rPucaPbVMImr//RHJ9ppAy4KpPa2h3lQoa3Ggz9AiwSLQN31M6+7dc3Bzhy7Dy+o1rW4HfS/5X6+@vger.kernel.org, AJvYcCVuJN3hEPP6VO5J1BlLqC7qSS2RtUj3f7OVStHr+lbMguFoNh5kt8yL91zIow1OEsDeY7u2pkrTF7X/jIMf@vger.kernel.org
X-Gm-Message-State: AOJu0YxjQFTQGRLD15rAY7/fsJ6eFFDba8hht20AlufF+FzPhSS4VGKs
	5np4jdonBEYbivGUnY65gIDbAIaudd7BbGN9cAqD5h8c5PJZ1GD3
X-Google-Smtp-Source: AGHT+IFX0JeNjumj2d4t5AlUe2fLFgOpLXFjFId3yhPG2daYecY7DrQ2nuwiffFhE1sL2NnrL3rglw==
X-Received: by 2002:a5d:6291:0:b0:374:c481:3f7 with SMTP id ffacd0b85a97d-378c2cd5ed9mr12211612f8f.6.1726607624482;
        Tue, 17 Sep 2024 14:13:44 -0700 (PDT)
Received: from localhost.localdomain ([37.72.3.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e72e4a46sm10545913f8f.14.2024.09.17.14.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 14:13:44 -0700 (PDT)
From: =?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mikisabate@gmail.com>
To: rafael@kernel.org
Cc: daniel.lezcano@linaro.org,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mikisabate@gmail.com>
Subject: [PATCH] cpuidle: Fix reference count on CPU node
Date: Tue, 17 Sep 2024 23:13:25 +0200
Message-ID: <20240917211325.639765-1-mikisabate@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

For the qcom-spm driver, an early return was not calling the proper
of_node_put call for a previously acquired device node.

Signed-off-by: Miquel Sabaté Solà <mikisabate@gmail.com>
---
 drivers/cpuidle/cpuidle-qcom-spm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-qcom-spm.c b/drivers/cpuidle/cpuidle-qcom-spm.c
index 1fc9968eae19..d3608f47d02b 100644
--- a/drivers/cpuidle/cpuidle-qcom-spm.c
+++ b/drivers/cpuidle/cpuidle-qcom-spm.c
@@ -96,8 +96,10 @@ static int spm_cpuidle_register(struct device *cpuidle_dev, int cpu)
 		return -ENODEV;
 
 	saw_node = of_parse_phandle(cpu_node, "qcom,saw", 0);
-	if (!saw_node)
+	if (!saw_node) {
+		of_node_put(cpu_node);
 		return -ENODEV;
+	}
 
 	pdev = of_find_device_by_node(saw_node);
 	of_node_put(saw_node);
-- 
2.46.0


