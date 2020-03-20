Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5911B18C6C5
	for <lists+linux-pm@lfdr.de>; Fri, 20 Mar 2020 06:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgCTFXE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Mar 2020 01:23:04 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46861 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgCTFXE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Mar 2020 01:23:04 -0400
Received: by mail-qk1-f196.google.com with SMTP id f28so5661294qkk.13
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2020 22:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:reply-to:organization:content-transfer-encoding;
        bh=vCUT5im7xTqActkIFgeHwLZTn4xMUQygaqCeyzYMBSA=;
        b=u1cFAocf7Txeo5HIC/0UJtMiqn3LSQaTRez8P1syZI9Vwnei2CJ42e91FXG017LELF
         HV8Pzn0jxm19eNZVQAaBop5xJxEMbmvLJXofT3Erd5Th/5dXrTqfvitaYuHmdJH58s87
         IYV5sos7uPx8Js2FP8kPp41i0esLfHddLtumgPtcvOEUsZrCh186omNyuKvrvbJN05hB
         jv92b8O2OdSsDWPWbUVSlLfN4BNB0lSii0sTGZCLPZqo8IZ+Qcv1czvfQWWvGL/WPwj9
         V6VtOe4Jvc1ivh45WrGf/o20wqD6FgWBN3Fng/oJK99mAOjCNgjnZ770l8uP8yON/uzB
         Pxgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:reply-to:organization
         :content-transfer-encoding;
        bh=vCUT5im7xTqActkIFgeHwLZTn4xMUQygaqCeyzYMBSA=;
        b=UUCFiJJ3MNH8IQDhjNTcaZhdESX6O30vh1jFnsOIF1EA7UD5Zlr2k/f8AVag6nNRDi
         TZ897R0/gaUlpgbETyx8xDtmJ4VmeztqVWDQdI2Mkly/IA/UNKJa7FIu28dBPSTcTfy/
         TBcC1XaXAH5ue/DKpGezXZ0OMUYIbCe/pLsAKdhVVluo1tpBUwieZJkFyCJn5SeooVDc
         y9Ig4Qotg6gc9QnKaHU4vKqE9r46w4kWWDXKyNzVVH0hefAoAoCA7Dz7a0OQIeepH2lp
         puuVAnWeq5cZZPix8H3MgyhhXdqQG/Geyy9voazx00IsyJVu/WcRWWJs01HC2y5KIFg5
         LmzA==
X-Gm-Message-State: ANhLgQ1cmRA1TohJ3TbReEIF8llvb17jphyeSCFQq/JXqD7Dlx6Lp/7r
        qUkuzdvwGmUkyYRADo05YEOIOB6N
X-Google-Smtp-Source: ADFU+vuyin1z80RAd0gXCntOC/1uwCzHauJKRu0c3/skEwVOFF/L8S+RxfVugIkJb3qohQDu+bhMRw==
X-Received: by 2002:ae9:c312:: with SMTP id n18mr2448354qkg.472.1584681781915;
        Thu, 19 Mar 2020 22:23:01 -0700 (PDT)
Received: from localhost.localdomain (h96-61-82-19.cntcnh.dsl.dynamic.tds.net. [96.61.82.19])
        by smtp.gmail.com with ESMTPSA id w134sm3273383qka.127.2020.03.19.22.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 22:23:01 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     linux-pm@vger.kernel.org
Cc:     Len Brown <len.brown@intel.com>
Subject: [PATCH 02/10] tools/power turbostat: Fix gcc build warnings
Date:   Fri, 20 Mar 2020 01:22:40 -0400
Message-Id: <d8d005ba6afa502ca37ced5782f672c4d2fc1515.1584679387.git.len.brown@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <081c54323b27d8d4b40df6b2375b9e1f6846d827.1584679387.git.len.brown@intel.com>
References: <081c54323b27d8d4b40df6b2375b9e1f6846d827.1584679387.git.len.brown@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Warning: ‘__builtin_strncpy’ specified bound 20 equals destination size
	[-Wstringop-truncation]

reduce param to strncpy, to guarantee that a null byte is always copied
into destination buffer.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index dd5ac9f52ac5..fa95a8ca5565 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -5325,9 +5325,9 @@ int add_counter(unsigned int msr_num, char *path, char *name,
 	}
 
 	msrp->msr_num = msr_num;
-	strncpy(msrp->name, name, NAME_BYTES);
+	strncpy(msrp->name, name, NAME_BYTES - 1);
 	if (path)
-		strncpy(msrp->path, path, PATH_BYTES);
+		strncpy(msrp->path, path, PATH_BYTES - 1);
 	msrp->width = width;
 	msrp->type = type;
 	msrp->format = format;
-- 
2.20.1

