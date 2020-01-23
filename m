Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14F5F146DAB
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2020 16:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgAWP72 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Jan 2020 10:59:28 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:55710 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgAWP72 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jan 2020 10:59:28 -0500
Received: by mail-pj1-f68.google.com with SMTP id d5so1387794pjz.5;
        Thu, 23 Jan 2020 07:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3lwWLGkfzAovdDMrWkQasFS2HMs+aMhOk+szSNNm5TI=;
        b=e9QuWKowpgho/99fE038B4BI67PJoG0yVJzwQbrf0SF8zcC22iiiwEkYzVEXnZ8UnZ
         NihkXRJu0waCssSZ97VJ4NXm21Er7F/xn3bxPTRh7SmkvvANdePnaoq3m7hzZlJsXONj
         nLBgdJmjgQtMWOe80/T514wehUnNPMleiJKIn9mz8a5k6OQ5S5bcLgUKMGF4qLruv6MV
         +M4B87DHciOVKCFBBj7uSzi1MvLs272F6MsUwwJg9i/kmH4HM+sH5mCaP3ba8xr9o62S
         2wwCABmUYb6/RRdNQZM9RXM4kJK1rMVrndsdAnfOk1wkl51ApBUZJmvxKrdfDgd0OBd7
         OlhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3lwWLGkfzAovdDMrWkQasFS2HMs+aMhOk+szSNNm5TI=;
        b=DeQp5B+B/GREi4XcKKoRtNt7HDC0fHq0yXKHEAdyIR20vfRZZM8gUE7dmXiMwXQqlk
         ANp8kBMb0ZhY9/k0qPa2DtvUect8HIBRpHOKDlrFqbRE+HERIMPwuzTRcrJcU6WZu1Zq
         Pijw7nDjF4gA+j6AT6Btaj0GQyW/yCd4xRvMu4qK1BrCfQGNV4gEY5hhNLzKWFwYdQhH
         kT+WKN8oYqcIuHW8tXMHVHIvVnkGG4R+ShexcygdW/XitjwyOjkuGvWYE4jNVqeERlnq
         0Rrms6fURrw+UBGnKBOOUV72aZHbZ99HgsxPW0It7VU2MXaYULImmNR15cLd51CQrN85
         ujgQ==
X-Gm-Message-State: APjAAAVGsbvzXNG4na1ZPSGMcvuCemU7R5jNjjjMPvSuBmyDnMCyfA9q
        /ZMYz8IqF5/vUIex+R37A9M=
X-Google-Smtp-Source: APXvYqxNZZFq/QoM9B6a3Phq48DxWGP5jYfjvkqKQQD6OOmolCYMybdfaXv3Uqqm8cObqqU5ZgA7hw==
X-Received: by 2002:a17:902:6904:: with SMTP id j4mr17588463plk.88.1579795167218;
        Thu, 23 Jan 2020 07:59:27 -0800 (PST)
Received: from localhost.localdomain ([118.150.8.24])
        by smtp.gmail.com with ESMTPSA id h3sm3456254pjs.0.2020.01.23.07.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 07:59:26 -0800 (PST)
From:   pierre Kuo <vichy.kuo@gmail.com>
To:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pierre Kuo <vichy.kuo@gmail.com>
Subject: [PATCH] PM / devfreq: use constant name of userspace governor
Date:   Thu, 23 Jan 2020 23:59:12 +0800
Message-Id: <20200123155912.22160-1-vichy.kuo@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Based on commit aa7c352f9841 ("PM / devfreq: Define the constant governor
name"), use constant name for userspace governor.

Signed-off-by: pierre Kuo <vichy.kuo@gmail.com>
---
 drivers/devfreq/governor_userspace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
index af94942fcf95..0fd6c4851071 100644
--- a/drivers/devfreq/governor_userspace.c
+++ b/drivers/devfreq/governor_userspace.c
@@ -131,7 +131,7 @@ static int devfreq_userspace_handler(struct devfreq *devfreq,
 }
 
 static struct devfreq_governor devfreq_userspace = {
-	.name = "userspace",
+	.name = DEVFREQ_GOV_USERSPACE,
 	.get_target_freq = devfreq_userspace_func,
 	.event_handler = devfreq_userspace_handler,
 };
-- 
2.17.1

