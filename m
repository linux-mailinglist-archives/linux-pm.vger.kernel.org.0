Return-Path: <linux-pm+bounces-13852-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F35970656
	for <lists+linux-pm@lfdr.de>; Sun,  8 Sep 2024 11:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D08B41C20E56
	for <lists+linux-pm@lfdr.de>; Sun,  8 Sep 2024 09:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCA9139CEE;
	Sun,  8 Sep 2024 09:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghptVbEL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5943754670;
	Sun,  8 Sep 2024 09:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725789500; cv=none; b=pY1OKqLJ1xptTxkN6YkuEN+90+8IEGmtlvYPRWyvXG4VQrrm3NSEAUiiPz7UlYzuPpZ57cNZdbanYKCF8aCYnTSoeMcl2a3aw0oDp4E1NlZ81eSXf/STjsg1a+7gVYbTFjpzyGogngFW0+71xciMgBWj0tSzOFypS9tv/G+lR14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725789500; c=relaxed/simple;
	bh=6oeTg6vHh7q0eLQZzCzj1O22cAhEkmZLp59KU1ULDws=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l93Y2LqcWGoO3p6jmsZillYJy167lLWm1R8PbxZndvq64/fYVO40ZsMqr9PPZM5rLYCe1kXn3j5ejsBlkf/Y5YraaJ+i4SeAfvpTsPmNCqglgIyoWV00PxvZiw4f5ZdDPZVX9bvboI0c8hgbv1JSb71wJhup4G0hdtrsa5JvMlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghptVbEL; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7c3ebba7fbbso2753116a12.1;
        Sun, 08 Sep 2024 02:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725789499; x=1726394299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qAoQB1omJiKRCiW0edWQiKKiWvbNbr1j8v5Ydh1uH18=;
        b=ghptVbEL7t9vhgfEmji4hmuBXgK0edLUQ0op4kF1c/u4ZXjrx0qPzBBfU/zbf1XoOY
         YyV3sBu+gi3e/1knoBvoFPxcT94HrF68kpjVkITXWqB56wKv7OFOXMN6o4HpTvMRicFf
         5REeJVTUSWfsNJ4Ec9WPTse1I4o+2JMA3LntxgvqA4FEFTX77Bn0CUQ7NuAuRDUf9aCk
         Wy3GBvaqG70J5+UN9jVPj9PgRhXSPvNT9/D/mEkANh18NaT8CWWn2IST/wQ2Bxs9X0Ft
         oYElWtCVYRE77Wpntzs02TN0n1jk7rNFhMl5+shsOTAvW6jPQjwyB0EPnWDs0DI2RWvg
         PfKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725789499; x=1726394299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qAoQB1omJiKRCiW0edWQiKKiWvbNbr1j8v5Ydh1uH18=;
        b=FqEWv3H07KrpUm3zVkGB0UAZ5Hjt7Mdrp/Ru1Gl1J0C9D6S8OEEzyyclfn7A+ZGH1p
         YzFTH26NgG4fJtQkgp3j0TbIHaS2RaIUVuuVexl4eLZYqob5/icc7AatxSsT5ubiVI/0
         iB7ug5EFpABRNJJSnwsRqEnGRck4rwZHi2wQzXRD7Lk0PcY+3AS1I5nxVg8uDha4NSqg
         WlKudAKY3mDCgtGISo44krgyl7Z+xVLTYMfTPBfurXK8WRp+WlrorSR9xoL8JL0BKm6q
         JUsxvOJ8L1AfljgztdRq7cKum2KzxUT3Dhuq5KQyCooXaOFZAwW5COp67IXv/p9Pxa0r
         ftJg==
X-Forwarded-Encrypted: i=1; AJvYcCU6PZiZ51RwAAsBkvTCB08mRk8EcJ9Ht15Jo5veUDLHdxtLczXqKjvvC/M+DW0zONVA9HI9+hQd9pE=@vger.kernel.org, AJvYcCW42KFriOgQ9y7Q7rtfSsqH0eAfN6Kbtj6zWgoHSAtf/cvsiBIBpkVDdKNbPxjM1cWe58CMHlkyorYP6UY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVrmZBY4q5FA1Iw4tp/FJsJPXPNy2SLQkxBQI/PQfOZO7LjIiu
	BMzS73WPhdDUXU78NBgglw50qirFeNV2C6z+oPMgWqT/QSMwjdwK
X-Google-Smtp-Source: AGHT+IG1tyh7FXGcc/FL8xmuPR+sjo30QSf0cdeWnoaQkMp3eMQ9w+mZ7rHcN2lXnKFolhURN/1b1A==
X-Received: by 2002:a17:90a:e150:b0:2d4:bf3:428e with SMTP id 98e67ed59e1d1-2dad50f3f3cmr10585204a91.37.1725789498451;
        Sun, 08 Sep 2024 02:58:18 -0700 (PDT)
Received: from 0x7f800001.. (2001-b400-e253-9c9c-a6a8-ede2-a4e3-a1ed.emome-ip6.hinet.net. [2001:b400:e253:9c9c:a6a8:ede2:a4e3:a1ed])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2dadc07617csm4563931a91.32.2024.09.08.02.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 02:58:17 -0700 (PDT)
From: "Yo-Jung (Leo) Lin" <0xff07@gmail.com>
To: 
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	ricardo@marliere.net,
	skhan@linuxfoundation.org,
	0xff07@gmail.com,
	Todd E Brandt <todd.e.brandt@linux.intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PM: tools: sleepgraph: Correct the home link
Date: Sun,  8 Sep 2024 17:57:22 +0800
Message-Id: <20240908095722.7683-1-0xff07@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 01.org/pm-graph link in the sleepgraph.py no longer point to the
pm-graph home page. Replace it with the home page link in the README.

Signed-off-by: Yo-Jung (Leo) Lin <0xff07@gmail.com>
---
 tools/power/pm-graph/sleepgraph.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/power/pm-graph/sleepgraph.py b/tools/power/pm-graph/sleepgraph.py
index ef87e63c05c7..f95061d6069f 100755
--- a/tools/power/pm-graph/sleepgraph.py
+++ b/tools/power/pm-graph/sleepgraph.py
@@ -18,7 +18,7 @@
 #
 # Links:
 #	 Home Page
-#	   https://01.org/pm-graph
+#	   https://www.intel.com/content/www/us/en/developer/topic-technology/open/pm-graph/overview.html
 #	 Source repo
 #	   git@github.com:intel/pm-graph
 #
@@ -2753,8 +2753,9 @@ class Timeline:
 	def createHeader(self, sv, stamp):
 		if(not stamp['time']):
 			return
-		self.html += '<div class="version"><a href="https://01.org/pm-graph">%s v%s</a></div>' \
-			% (sv.title, sv.version)
+		self.html += '<div class="version"><a href="https://www.intel.com/content'+\
+                '/www/us/en/developer/topic-technology/open/pm-graph/overview.html">%s v%s</a></div>' \
+                % (sv.title, sv.version)
 		if sv.logmsg and sv.testlog:
 			self.html += '<button id="showtest" class="logbtn btnfmt">log</button>'
 		if sv.dmesglog:
-- 
2.34.1


